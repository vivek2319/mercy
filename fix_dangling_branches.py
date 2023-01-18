import subprocess
from gitlab import Gitlab

def fix_dangling_branch(url, private_token):
  """
    This function connects to the git provider using the provided url and private token,
    lists all the repositories that have dangling branches, fixes them by deleting the branches,
    creates a new commit with the message "fixed dangling branch" and pushes the changes to the remote repository.
    :param url: url of the git provider
    :type url: str
    :param private_token: private token for authentication
    :type private_token: str
    :return: None
    """
    try:
        # Connect to GitLab
        gl = Gitlab(url, private_token=private_token)

        # Get all the repos for the authenticated user
        repos = gl.projects.list()

        # Iterate through the repos and check for dangling branches
        for repo in repos:
            branches = repo.branches.list()
            for branch in branches:
                if branch.name not in repo.protected_branches.list():
                    print(f"Dangling branch found in repo {repo.name}: {branch.name}")
                    subprocess.run(['git', 'push', '--delete', 'origin', branch.name])
                    subprocess.run(['git', 'commit', '-am', 'fixed dangling branch'])
                    subprocess.run(['git', 'push'])
    except Exception as e:
        print(f'An error occurred: {e}')
