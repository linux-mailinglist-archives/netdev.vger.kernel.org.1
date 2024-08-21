Return-Path: <netdev+bounces-120665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7295A236
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A816B24EAA
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31D14E2F1;
	Wed, 21 Aug 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="apZR2uK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5652F6F
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255961; cv=none; b=IDUQm42zbOdDga+SQ82bYBEAgfWvFBPlbPripZ/NTPKsJFby2lobmqa4zSWQEc9Lgq2jIrDtwJf9WkZsYQWx0BerYidaxNZYFCKoVBXQNtX2mUU+eQCkcdHiXDXzYwE4rkWJi3XHAddot0iYlh0xHRO7UNHgqtYT/WdjjV78GNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255961; c=relaxed/simple;
	bh=hGfKAlZVSBcIYYJUmJQSl4br7LwKO3q2JmCk10knnAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buLEbxScIzgPeq+sjkeK1Ovep/3BwycnsZlgEnP9MCSWYHBRjOyVKm5i+GxEAXZz1oiu/JepBJiNCFxPi12h8Jxq0IggE9mRBQA7M7b7UjVDhGMuYfEEqI0+if/F3WLD0bCCqEA54P2Li2+Vzzaba5coR7PUz2jeIL5TVihfShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=apZR2uK8; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WprcJ5yRxz2bM;
	Wed, 21 Aug 2024 17:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724255952;
	bh=rmYhcpPuAiqn2G75cLrm2Cpv+qTmSyMAG75h0OHJo/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apZR2uK8Gign6hQTbe9OiKScvIm82Ggc3GN47SOa6igsqqoYZWxu1u7FGU3hae11u
	 UpizzNkNePzDolMYcysr4uEX71QZU9QK4iZQPE2fdsVCnK2ga1+wD7SCUu7MzhXm9w
	 mIWBe9hsTGPIjSxAT3SBrrW42LEQ041jy5742zkY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WprcH2w0rzTLQ;
	Wed, 21 Aug 2024 17:59:11 +0200 (CEST)
Date: Wed, 21 Aug 2024 17:59:07 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v10 5/6] sample/Landlock: Support abstract unix socket
 restriction
Message-ID: <20240821.Ohph8see3ru2@digikod.net>
References: <cover.1724125513.git.fahimitahera@gmail.com>
 <72945c1bf5ad016642b678764f44a3dcc5cb040b.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72945c1bf5ad016642b678764f44a3dcc5cb040b.1724125513.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 19, 2024 at 10:08:55PM -0600, Tahera Fahimi wrote:
> A sandboxer can receive the character "a" as input from the environment
> variable LL_SCOPE to restrict the abstract UNIX sockets from connecting
> to a process outside its scoped domain.
> 
> Example
> =======
> Create an abstract unix socket to listen with socat(1):
> socat abstract-listen:mysocket -
> 
> Create a sandboxed shell and pass the character "a" to LL_SCOPED:
> LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash
> 
> If the sandboxed process tries to connect to the listening socket
> with command "socat - abstract-connect:mysocket", the connection
> will fail.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> v10:
> - Minor improvement in code based on v9.
> v9:
> - Add a restrict approach on input of LL_SCOPED, so it only allows zero
>   or one "a" to be the input.
> v8:
> - Adding check_ruleset_scope function to parse the scope environment
>   variable and update the landlock attribute based on the restriction
>   provided by the user.
> - Adding Mickaël Salaün reviews on version 7.
> 
> v7:
> - Adding IPC scoping to the sandbox demo by defining a new "LL_SCOPED"
>   environment variable. "LL_SCOPED" gets value "a" to restrict abstract
>   unix sockets.
> - Change LANDLOCK_ABI_LAST to 6.
> ---
>  samples/landlock/sandboxer.c | 56 +++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e8223c3e781a..0564d0a40c67 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -14,6 +14,7 @@
>  #include <fcntl.h>
>  #include <linux/landlock.h>
>  #include <linux/prctl.h>
> +#include <linux/socket.h>
>  #include <stddef.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -22,6 +23,7 @@
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <unistd.h>
> +#include <stdbool.h>
>  
>  #ifndef landlock_create_ruleset
>  static inline int
> @@ -55,6 +57,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  #define ENV_FS_RW_NAME "LL_FS_RW"
>  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
> +#define ENV_SCOPED_NAME "LL_SCOPED"
>  #define ENV_DELIMITER ":"
>  
>  static int parse_path(char *env_path, const char ***const path_list)
> @@ -184,6 +187,40 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  	return ret;
>  }
>  
> +static bool check_ruleset_scope(const char *const env_var,
> +				struct landlock_ruleset_attr *ruleset_attr)
> +{
> +	bool abstract_scoping = false;
> +	bool ret = true;
> +	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
> +
> +	ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;

This is bug prone because it removes the scope flags but doesn't store
the initial state.  It would be better to use the abstract_scoping
variable to unset the related flag at the end of this function.

> +	env_type_scope = getenv(env_var);
> +	/* scoping is not supported by the user */
> +	if (!env_type_scope || strcmp("", env_type_scope) == 0)
> +		return true;
> +
> +	env_type_scope = strdup(env_type_scope);
> +	unsetenv(env_var);
> +	env_type_scope_next = env_type_scope;
> +	while ((ipc_scoping_name =
> +			strsep(&env_type_scope_next, ENV_DELIMITER))) {
> +		if (strcmp("a", ipc_scoping_name) == 0 && !abstract_scoping) {
> +			abstract_scoping = true;
> +			ruleset_attr->scoped |=
> +				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
> +		} else {
> +			fprintf(stderr, "Unsupported scoping \"%s\"\n",
> +				ipc_scoping_name);
> +			ret = false;
> +			goto out_free_name;
> +		}
> +	}
> +out_free_name:
> +	free(env_type_scope);
> +	return ret;
> +}
> +
>  /* clang-format off */
>  
>  #define ACCESS_FS_ROUGHLY_READ ( \
> @@ -208,7 +245,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  
>  /* clang-format on */
>  
> -#define LANDLOCK_ABI_LAST 5
> +#define LANDLOCK_ABI_LAST 6
>  
>  int main(const int argc, char *const argv[], char *const *const envp)
>  {
> @@ -223,14 +260,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		.handled_access_fs = access_fs_rw,
>  		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>  				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
>  	};
>  
>  	if (argc < 2) {
>  		fprintf(stderr,
> -			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
> +			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
>  			"<cmd> [args]...\n\n",
>  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, argv[0]);
> +			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
>  		fprintf(stderr,
>  			"Execute a command in a restricted environment.\n\n");
>  		fprintf(stderr,
> @@ -251,15 +289,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		fprintf(stderr,
>  			"* %s: list of ports allowed to connect (client).\n",
>  			ENV_TCP_CONNECT_NAME);
> +		fprintf(stderr, "* %s: list of restrictions on IPCs.\n",
> +			ENV_SCOPED_NAME);
>  		fprintf(stderr,
>  			"\nexample:\n"
>  			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
>  			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>  			"%s=\"9418\" "
>  			"%s=\"80:443\" "
> +			"%s=\"a\" "
>  			"%s bash -i\n\n",
>  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, argv[0]);
> +			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
>  		fprintf(stderr,
>  			"This sandboxer can use Landlock features "
>  			"up to ABI version %d.\n",
> @@ -327,6 +368,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
>  		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
>  
> +		__attribute__((fallthrough));
> +	case 5:
> +		/* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
> +		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
>  		fprintf(stderr,
>  			"Hint: You should update the running kernel "
>  			"to leverage Landlock features "
> @@ -358,6 +403,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
>  	}
>  
> +	if (abi >= 6 && !check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))

Instead of explicitly re-checking the ABI, check_ruleset_scope() should
check ruleset_attr.scoped & LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET

> +		return 1;
> +
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>  	if (ruleset_fd < 0) {
> -- 
> 2.34.1
> 
> 

