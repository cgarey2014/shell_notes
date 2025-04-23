from setuptools import setup, find_packages

setup(
    name='shellnotes',
    version='0.1',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'colorama',
        'setuptools',
    ],
    entry_points={
        'console_scripts': [
            'shellnotes = __main__:main',
        ],
    },
)
