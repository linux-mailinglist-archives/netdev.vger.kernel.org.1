Return-Path: <netdev+bounces-116532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C9794ABCA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0468A1F24959
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76162AF07;
	Wed,  7 Aug 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LJA7Du6y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98A811F1;
	Wed,  7 Aug 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043337; cv=none; b=oJMX6G2Pkz7KPeixX4i1g995AnKAoYC8jWVrhWQXXrJ4pEjt6EPw9ToWpaceAykozJCIeCWeN79zLDvixN1zNemjMeXNc8Z54CA8JH5e5r4LRuCa08OXj9na1nU3/ucZXmxZD+kB3JezOQRgq33NfQU6qa9C6N1oQKyGVfmPrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043337; c=relaxed/simple;
	bh=gBlvsOXtqGeYZUg6gPoq1je38qm0ISw5dJz6JzmkOcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfzrpiYWvPMDoFaGQzfVeZjc+y+5CEb7rU1mL6YXRbC4UagpOnetGHDrX0hRNxUOx/TsoV5eyttLb6VT0gnHF17kvPu4RgDaHmiB0kQM6VNZGVf4jLrXmGDzceazCPIOhkXHTfpBHPBja6KGuZ0TZ7B761m/k4y8HX1UJfbvlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LJA7Du6y; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WfD8Y1FCKzYg4;
	Wed,  7 Aug 2024 17:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723043325;
	bh=cFWPpNndZUTp8yzvBdPSMqMhC/wILyTlYmhBXsAOx7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJA7Du6yxi64CJBYY1pzq5TRJQCvR7ELc0z4ju7y+/djhAvIjywptc8cg11To/Cs5
	 6RUkFOad/ue0dO3sPQ8h/YikpokKbc535yFzEGZIAEZxxxJY9jr9j9ehDYPQ3Cxav5
	 WY6gA1tgcz3roSZohxmO+kvNEpb4DuIUOCD9TQz8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WfD8X3mjqzTC3;
	Wed,  7 Aug 2024 17:08:44 +0200 (CEST)
Date: Wed, 7 Aug 2024 17:08:40 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 2/4] selftests/landlock: Abstract unix socket
 restriction tests
Message-ID: <20240807.WieGae7wahh6@digikod.net>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <ea8c8734602145ded23b8ac205b6ba38f1b00e3f.1722570749.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea8c8734602145ded23b8ac205b6ba38f1b00e3f.1722570749.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 01, 2024 at 10:02:34PM -0600, Tahera Fahimi wrote:
> The patch introduces Landlock ABI version 6 and has four types of tests:
> 1) unix_socket: base tests of the abstract socket scoping mechanism for a
>    landlocked process, same as the ptrace test.
> 2) optional_scoping: generates three processes with different domains and
>    tests if a process with a non-scoped domain can connect to other
>    processes.
> 3) unix_sock_special_cases: since the socket's creator credentials are used
>    for scoping sockets, this test examines the cases where the socket's
>    credentials are different from the process using it.
> 4) pathname_address_sockets: ensures that Unix sockets bound to a
>    null-terminated filesystem can still connect to a socket outside of
>    their scoped domain. This means that even if the domain is scoped with
>    LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET, the socket can connect to a socket
>    outside the scoped domain.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> Changes in versions:
> V8:
> - Move tests to scoped_abstract_unix_test.c file.
> - To avoid potential conflicts among Unix socket names in different tests,
>   set_unix_address is added to common.h to set different sun_path for Unix sockets.
> - protocol_variant and service_fixture structures are also moved to common.h
> - Adding pathname_address_sockets to cover all types of address formats
>   for unix sockets, and moving remove_path() to common.h to reuse in this test.
> V7:
> - Introducing landlock ABI version 6.
> - Adding some edge test cases to optional_scoping test.
> - Using `enum` for different domains in optional_scoping tests.
> - Extend unix_sock_special_cases test cases for connected(SOCK_STREAM) sockets.
> - Modifying inline comments.
> V6:
> - Introducing optional_scoping test which ensures a sandboxed process with a
>   non-scoped domain can still connect to another abstract unix socket(either
>   sandboxed or non-sandboxed).
> - Introducing unix_sock_special_cases test which tests examines scenarios where
>   the connecting sockets have different domain than the process using them.
> V4:
> - Introducing unix_socket to evaluate the basic scoping mechanism for abstract
>   unix sockets.
> ---
>  tools/testing/selftests/landlock/base_test.c  |    2 +-
>  tools/testing/selftests/landlock/common.h     |   72 ++
>  tools/testing/selftests/landlock/fs_test.c    |   34 -
>  tools/testing/selftests/landlock/net_test.c   |   31 +-
>  .../landlock/scoped_abstract_unix_test.c      | 1136 +++++++++++++++++
>  5 files changed, 1210 insertions(+), 65 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c

> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 3c1e9f35b531..52b00472a487 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -75,7 +75,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(6, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> index 7e2b431b9f90..a0c8126d94b4 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -16,8 +16,11 @@
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> +#include <sys/un.h>
> +#include <arpa/inet.h>
>  
>  #include "../kselftest_harness.h"
> +#define TMP_DIR "tmp"
>  
>  #ifndef __maybe_unused
>  #define __maybe_unused __attribute__((__unused__))
> @@ -226,3 +229,72 @@ enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
>  		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
>  	}
>  }
> +
> +struct protocol_variant {
> +	int domain;
> +	int type;
> +};
> +
> +struct service_fixture {
> +	struct protocol_variant protocol;
> +	/* port is also stored in ipv4_addr.sin_port or ipv6_addr.sin6_port */
> +	unsigned short port;
> +	union {
> +		struct sockaddr_in ipv4_addr;
> +		struct sockaddr_in6 ipv6_addr;
> +		struct {
> +			struct sockaddr_un unix_addr;
> +			socklen_t unix_addr_len;
> +		};
> +	};
> +};
> +
> +static pid_t __maybe_unused sys_gettid(void)
> +{
> +	return syscall(__NR_gettid);
> +}
> +
> +static void __maybe_unused set_unix_address(struct service_fixture *const srv,
> +					    const unsigned short index)
> +{
> +	srv->unix_addr.sun_family = AF_UNIX;
> +	sprintf(srv->unix_addr.sun_path,
> +		"_selftests-landlock-abstract-unix-tid%d-index%d", sys_gettid(),
> +		index);
> +	srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
> +	srv->unix_addr.sun_path[0] = '\0';
> +}
> +
> +static int __maybe_unused remove_path(const char *const path)

We don't need to import remove_path() for these simple filesystem
actions.

> +{
> +	char *walker;
> +	int i, ret, err = 0;
> +
> +	walker = strdup(path);
> +	if (!walker) {
> +		err = ENOMEM;
> +		goto out;
> +	}
> +	if (unlink(path) && rmdir(path)) {
> +		if (errno != ENOENT && errno != ENOTDIR)
> +			err = errno;
> +		goto out;
> +	}
> +	for (i = strlen(walker); i > 0; i--) {
> +		if (walker[i] != '/')
> +			continue;
> +		walker[i] = '\0';
> +		ret = rmdir(walker);
> +		if (ret) {
> +			if (errno != ENOTEMPTY && errno != EBUSY)
> +				err = errno;
> +			goto out;
> +		}
> +		if (strcmp(walker, TMP_DIR) == 0)
> +			goto out;
> +	}
> +
> +out:
> +	free(walker);
> +	return err;
> +}
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 7d063c652be1..fc74cab6dfb8 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -221,40 +221,6 @@ static void create_file(struct __test_metadata *const _metadata,
>  	}
>  }
>  
> -static int remove_path(const char *const path)
> -{
> -	char *walker;
> -	int i, ret, err = 0;
> -
> -	walker = strdup(path);
> -	if (!walker) {
> -		err = ENOMEM;
> -		goto out;
> -	}
> -	if (unlink(path) && rmdir(path)) {
> -		if (errno != ENOENT && errno != ENOTDIR)
> -			err = errno;
> -		goto out;
> -	}
> -	for (i = strlen(walker); i > 0; i--) {
> -		if (walker[i] != '/')
> -			continue;
> -		walker[i] = '\0';
> -		ret = rmdir(walker);
> -		if (ret) {
> -			if (errno != ENOTEMPTY && errno != EBUSY)
> -				err = errno;
> -			goto out;
> -		}
> -		if (strcmp(walker, TMP_DIR) == 0)
> -			goto out;
> -	}
> -
> -out:
> -	free(walker);
> -	return err;
> -}
> -
>  struct mnt_opt {
>  	const char *const source;
>  	const char *const type;
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index f21cfbbc3638..4e0aeb53b225 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -36,30 +36,6 @@ enum sandbox_type {
>  	TCP_SANDBOX,
>  };
>  
> -struct protocol_variant {
> -	int domain;
> -	int type;
> -};
> -
> -struct service_fixture {
> -	struct protocol_variant protocol;
> -	/* port is also stored in ipv4_addr.sin_port or ipv6_addr.sin6_port */
> -	unsigned short port;
> -	union {
> -		struct sockaddr_in ipv4_addr;
> -		struct sockaddr_in6 ipv6_addr;
> -		struct {
> -			struct sockaddr_un unix_addr;
> -			socklen_t unix_addr_len;
> -		};
> -	};
> -};
> -
> -static pid_t sys_gettid(void)
> -{
> -	return syscall(__NR_gettid);
> -}
> -
>  static int set_service(struct service_fixture *const srv,
>  		       const struct protocol_variant prot,
>  		       const unsigned short index)
> @@ -92,12 +68,7 @@ static int set_service(struct service_fixture *const srv,
>  		return 0;
>  
>  	case AF_UNIX:
> -		srv->unix_addr.sun_family = prot.domain;
> -		sprintf(srv->unix_addr.sun_path,
> -			"_selftests-landlock-net-tid%d-index%d", sys_gettid(),
> -			index);
> -		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
> -		srv->unix_addr.sun_path[0] = '\0';
> +		set_unix_address(srv, index);

Please create a standalone patch for existing code refactoring, and then
another patch for the new tests.

>  		return 0;
>  	}
>  	return 1;
> diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> new file mode 100644
> index 000000000000..ffa1f01dbbce
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c

> +TEST_F(unix_socket, abstract_unix_socket)
> +{
> +	int status;
> +	pid_t child;
> +	bool can_connect_to_parent, can_connect_to_child;
> +	int err, err_dgram;
> +	int pipe_child[2], pipe_parent[2];
> +	char buf_parent;
> +
> +	/*
> +	 * can_connect_to_child is true if a parent process can connect to its
> +	 * child process. The parent process is not isolated from the child
> +	 * with a dedicated Landlock domain.
> +	 */
> +	can_connect_to_child = !variant->domain_parent;
> +	/*
> +	 * can_connect_to_parent is true if a child process can connect to its
> +	 * parent process. This depends on the child process is not isolated from
> +	 * the parent with a dedicated Landlock domain.
> +	 */
> +	can_connect_to_parent = !variant->domain_child;
> +
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +	if (variant->domain_both) {
> +		create_unix_domain(_metadata);
> +		if (!__test_passed(_metadata))
> +			return;
> +	}
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		char buf_child;
> +
> +		ASSERT_EQ(0, close(pipe_parent[1]));
> +		ASSERT_EQ(0, close(pipe_child[0]));
> +		if (variant->domain_child)
> +			create_unix_domain(_metadata);
> +
> +		/* Waits for the parent to be in a domain, if any. */
> +		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> +
> +		if (variant->connect_to_parent) {
> +			self->client = socket(AF_UNIX, SOCK_STREAM, 0);
> +			self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
> +
> +			ASSERT_NE(-1, self->client);
> +			ASSERT_NE(-1, self->dgram_client);
> +			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> +
> +			err = connect(self->client,
> +				      &self->stream_address.unix_addr,
> +				      (self->stream_address).unix_addr_len);
> +			err_dgram =
> +				connect(self->dgram_client,
> +					&self->dgram_address.unix_addr,
> +					(self->dgram_address).unix_addr_len);
> +
> +			if (can_connect_to_parent) {
> +				EXPECT_EQ(0, err);
> +				EXPECT_EQ(0, err_dgram);
> +			} else {
> +				EXPECT_EQ(-1, err);
> +				EXPECT_EQ(-1, err_dgram);
> +				EXPECT_EQ(EPERM, errno);
> +			}
> +		} else {
> +			self->server = socket(AF_UNIX, SOCK_STREAM, 0);
> +			self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
> +			ASSERT_NE(-1, self->server);
> +			ASSERT_NE(-1, self->dgram_server);
> +
> +			ASSERT_EQ(0,
> +				  bind(self->server,
> +				       &self->stream_address.unix_addr,
> +				       (self->stream_address).unix_addr_len));
> +			ASSERT_EQ(0, bind(self->dgram_server,
> +					  &self->dgram_address.unix_addr,
> +					  (self->dgram_address).unix_addr_len));
> +			ASSERT_EQ(0, listen(self->server, 32));

Please, avoid the use of hardcoded values (e.g. in all listen calls).
You can create a global backlog variable like in net_test.c (just copy
it, no need to include it in common.h).

> +
> +			/* signal to parent that child is listening */
> +			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> +			/* wait to connect */
> +			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> +		}
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	ASSERT_EQ(0, close(pipe_child[1]));
> +	ASSERT_EQ(0, close(pipe_parent[0]));
> +
> +	if (variant->domain_parent)
> +		create_unix_domain(_metadata);
> +
> +	/* Signals that the parent is in a domain, if any. */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +
> +	if (!variant->connect_to_parent) {
> +		self->client = socket(AF_UNIX, SOCK_STREAM, 0);
> +		self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
> +
> +		ASSERT_NE(-1, self->client);
> +		ASSERT_NE(-1, self->dgram_client);
> +
> +		/* Waits for the child to listen */
> +		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> +		err = connect(self->client, &self->stream_address.unix_addr,
> +			      (self->stream_address).unix_addr_len);
> +		err_dgram = connect(self->dgram_client,
> +				    &self->dgram_address.unix_addr,
> +				    (self->dgram_address).unix_addr_len);
> +
> +		if (can_connect_to_child) {
> +			EXPECT_EQ(0, err);
> +			EXPECT_EQ(0, err_dgram);
> +		} else {
> +			EXPECT_EQ(-1, err);
> +			EXPECT_EQ(-1, err_dgram);
> +			EXPECT_EQ(EPERM, errno);
> +		}
> +		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	} else {
> +		self->server = socket(AF_UNIX, SOCK_STREAM, 0);
> +		self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
> +		ASSERT_NE(-1, self->server);
> +		ASSERT_NE(-1, self->dgram_server);
> +		ASSERT_EQ(0, bind(self->server, &self->stream_address.unix_addr,
> +				  (self->stream_address).unix_addr_len));
> +		ASSERT_EQ(0, bind(self->dgram_server,
> +				  &self->dgram_address.unix_addr,
> +				  (self->dgram_address).unix_addr_len));
> +		ASSERT_EQ(0, listen(self->server, 32));
> +
> +		/* signal to child that parent is listening */
> +		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
> +enum sandbox_type {
> +	NO_SANDBOX,
> +	SCOPE_SANDBOX,
> +	/* Any other type of sandboxing domain */
> +	OTHER_SANDBOX,
> +};
> +
> +/* clang-format off */
> +FIXTURE(optional_scoping)
> +{
> +	struct service_fixture parent_address, child_address;

> +	int parent_server, child_server, client;

The variables should be local ones.

> +};
> +
> +/* clang-format on */
> +FIXTURE_VARIANT(optional_scoping)
> +{
> +	const int domain_all;
> +	const int domain_parent;
> +	const int domain_children;
> +	const int domain_child;

> +	const int domain_grand_child;

domain_grand_child is always NO_SANDBOX in the variants.


> +	const int type;
> +};
> +
> +FIXTURE_SETUP(optional_scoping)

s/optional_scoping/scoping/ ?

> +{
> +	memset(&self->parent_address, 0, sizeof(self->parent_address));
> +	memset(&self->child_address, 0, sizeof(self->child_address));
> +
> +	set_unix_address(&self->parent_address, 0);
> +	set_unix_address(&self->child_address, 1);
> +}

> +TEST_F(optional_scoping, unix_scoping)
> +{
> +	pid_t child;
> +	int status;
> +	bool can_connect_to_parent, can_connect_to_child;
> +	int pipe_parent[2];
> +
> +	if (variant->domain_grand_child == SCOPE_SANDBOX)
> +		can_connect_to_child = false;

We never go through this case.

> +	else
> +		can_connect_to_child = true;
> +
> +	if (!can_connect_to_child || variant->domain_children == SCOPE_SANDBOX)
> +		can_connect_to_parent = false;
> +	else
> +		can_connect_to_parent = true;

We never go through this case.

> +
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +
> +	if (variant->domain_all == OTHER_SANDBOX)
> +		create_fs_domain(_metadata);
> +	else if (variant->domain_all == SCOPE_SANDBOX)
> +		create_unix_domain(_metadata);
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		int pipe_child[2];
> +
> +		ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +		pid_t grand_child;
> +
> +		if (variant->domain_children == OTHER_SANDBOX)
> +			create_fs_domain(_metadata);
> +		else if (variant->domain_children == SCOPE_SANDBOX)
> +			create_unix_domain(_metadata);
> +
> +		grand_child = fork();
> +		ASSERT_LE(0, grand_child);
> +		if (grand_child == 0) {
> +			ASSERT_EQ(0, close(pipe_parent[1]));
> +			ASSERT_EQ(0, close(pipe_child[1]));
> +
> +			char buf1, buf2;
> +			int err;
> +
> +			if (variant->domain_grand_child == OTHER_SANDBOX)
> +				create_fs_domain(_metadata);
> +			else if (variant->domain_grand_child == SCOPE_SANDBOX)
> +				create_unix_domain(_metadata);
> +
> +			self->client = socket(AF_UNIX, variant->type, 0);
> +			ASSERT_NE(-1, self->client);
> +
> +			ASSERT_EQ(1, read(pipe_child[0], &buf2, 1));
> +			err = connect(self->client,
> +				      &self->child_address.unix_addr,

> +				      (self->child_address).unix_addr_len);

No need for these extra parenthesis.

> +			if (can_connect_to_child) {
> +				EXPECT_EQ(0, err);
> +			} else {
> +				EXPECT_EQ(-1, err);
> +				EXPECT_EQ(EPERM, errno);
> +			}
> +
> +			if (variant->type == SOCK_STREAM) {
> +				EXPECT_EQ(0, close(self->client));
> +				self->client =
> +					socket(AF_UNIX, variant->type, 0);
> +				ASSERT_NE(-1, self->client);
> +			}
> +
> +			ASSERT_EQ(1, read(pipe_parent[0], &buf1, 1));
> +			err = connect(self->client,
> +				      &self->parent_address.unix_addr,
> +				      (self->parent_address).unix_addr_len);
> +			if (can_connect_to_parent) {
> +				EXPECT_EQ(0, err);
> +			} else {
> +				EXPECT_EQ(-1, err);
> +				EXPECT_EQ(EPERM, errno);
> +			}
> +			EXPECT_EQ(0, close(self->client));
> +
> +			_exit(_metadata->exit_code);
> +			return;
> +		}
> +
> +		ASSERT_EQ(0, close(pipe_child[0]));
> +		if (variant->domain_child == OTHER_SANDBOX)
> +			create_fs_domain(_metadata);
> +		else if (variant->domain_child == SCOPE_SANDBOX)
> +			create_unix_domain(_metadata);
> +
> +		self->child_server = socket(AF_UNIX, variant->type, 0);
> +		ASSERT_NE(-1, self->child_server);
> +		ASSERT_EQ(0, bind(self->child_server,
> +				  &self->child_address.unix_addr,
> +				  (self->child_address).unix_addr_len));
> +		if (variant->type == SOCK_STREAM)
> +			ASSERT_EQ(0, listen(self->child_server, 32));
> +
> +		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> +		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
> +		return;
> +	}
> +	ASSERT_EQ(0, close(pipe_parent[0]));
> +
> +	if (variant->domain_parent == OTHER_SANDBOX)
> +		create_fs_domain(_metadata);
> +	else if (variant->domain_parent == SCOPE_SANDBOX)
> +		create_unix_domain(_metadata);
> +
> +	self->parent_server = socket(AF_UNIX, variant->type, 0);
> +	ASSERT_NE(-1, self->parent_server);
> +	ASSERT_EQ(0, bind(self->parent_server, &self->parent_address.unix_addr,
> +			  (self->parent_address).unix_addr_len));
> +
> +	if (variant->type == SOCK_STREAM)
> +		ASSERT_EQ(0, listen(self->parent_server, 32));
> +
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}

> +FIXTURE_SETUP(pathname_address_sockets)
> +{
> +	/* setup abstract addresses */
> +	memset(&self->stream_address, 0, sizeof(self->stream_address));
> +	set_unix_address(&self->stream_address, 0);
> +
> +	memset(&self->dgram_address, 0, sizeof(self->dgram_address));
> +	set_unix_address(&self->dgram_address, 0);
> +
> +	const char *s_path = variant->stream_path;
> +	const char *dg_path = variant->dgram_path;
> +
> +	disable_caps(_metadata);
> +	umask(0077);
> +	ASSERT_EQ(0, mkdir(TMP_DIR, 0700));
> +
> +	ASSERT_EQ(0, mknod(s_path, S_IFREG | 0700, 0))
> +	{
> +		TH_LOG("Failed to create file \"%s\": %s", s_path,
> +		       strerror(errno));
> +		remove_path(TMP_DIR);

Just use rmdir() instead of remove_path() everywhere.

> +	}
> +	ASSERT_EQ(0, mknod(dg_path, S_IFREG | 0700, 0))
> +	{
> +		TH_LOG("Failed to create file \"%s\": %s", dg_path,
> +		       strerror(errno));
> +		remove_path(TMP_DIR);
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(pathname_address_sockets)
> +{
> +	const char *s_path = variant->stream_path;
> +	const char *dg_path = variant->dgram_path;
> +
> +	ASSERT_EQ(0, remove_path(dg_path));

Just use unlink() and rmdir().

> +	ASSERT_EQ(0, remove_path(s_path));
> +	ASSERT_EQ(0, remove_path(TMP_DIR));
> +}


