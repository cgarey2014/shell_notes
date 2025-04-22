from setuptools import setup, find_packages

setup(
    name='shell_notes',
    version='1.0.0',
    packages=find_packages(),
    install_requires=[
        'colorama',
    ],
    entry_points={
        'console_scripts': [
            'shellnotes=shell_notes.__main__:main',  # Maps CLI 'shellnotes' to main()
        ],
    },
    author='Christopher Garey',
    author_email='chrisgarey2014@gmail.com',
    description='A terminal shell session logger and log manager.',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',
    url='https://github.com/cgarey2014/shell_notes',
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
    ],
    python_requires='>=3.6',
)
