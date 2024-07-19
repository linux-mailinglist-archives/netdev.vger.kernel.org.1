Return-Path: <netdev+bounces-112261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2B937C3B
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 20:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68322831A6
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF21459F9;
	Fri, 19 Jul 2024 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OlBdRfZU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FF2746B
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412853; cv=none; b=FKR9boWFPLWalIY/7k2MuAPdFbb+445NEcVVsSfwGmy85pm28hqlM4Hh5UnA5DUoe9TRgxaVwTWtB5CSavkLq7dOmocZNPTVYoF91eW9FeUo3Yghg7nVDTH96fgaFn+qHj75J0rcdno+aFXA13tTN0D6E3MET5RS0z/77JcC64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412853; c=relaxed/simple;
	bh=qCrqHdn+cpkWR3yivLl119Ad62YP9Gu7JeJQO9PsfUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxn+GTuZwmENYAxk2h/gGzxKNP/K1xo4Zc6GHNhv6OdGHeWnwxuJnQD8/m8HCrJNFPqeUImrCWLRbjivV6BhLqcLCuvaADUE8yJFlLCyoTY7TNI4Ymd91k5PeVvcQw/NXsH6x4cJ2yJ3FWEhamV55XIf+tYTHLixmkSRD08esxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OlBdRfZU; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQd9B1JHSzYJB;
	Fri, 19 Jul 2024 20:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721412846;
	bh=Sfu7kbVhK7l3nqVtAhoPi7msdo+3IQX+4FwZA44EGgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlBdRfZUhd534U/aK4GNrmC8QpD79aZSrAOFi/PqN71269udy5dKni70LUqT1DFMC
	 ZnNwoZFZrMm8XsVV8cdILIOy3aXHyPj3ON0udSwvLVqTaDCVkPSDWwGW0NbOdFeL0M
	 AGO05GreLlBAJu28zxT3xOw3yg8ug8T+JKVoxeKc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQd990l2Wznlr;
	Fri, 19 Jul 2024 20:14:05 +0200 (CEST)
Date: Fri, 19 Jul 2024 20:14:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240719.AepeeXeib7sh@digikod.net>
References: <cover.1721269836.git.fahimitahera@gmail.com>
 <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 10:15:19PM -0600, Tahera Fahimi wrote:
> The patch introduces a new "scoped" attribute to the
> landlock_ruleset_attr that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET"
> to scope abstract unix sockets from connecting to a process outside of
> the same landlock domain.
> 
> This patch implement two hooks, "unix_stream_connect" and "unix_may_send" to
> enforce this restriction.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> -------

Only "---"

> v7:

Thanks for the detailed changelog, it helps!

>  - Using socket's file credentials for both connected(STREAM) and
>    non-connected(DGRAM) sockets.
>  - Adding "domain_sock_scope" instead of the domain scoping mechanism used in
>    ptrace ensures that if a server's domain is accessible from the client's
>    domain (where the client is more privileged than the server), the client
>    can connect to the server in all edge cases.
>  - Removing debug codes.
> v6:
>  - Removing curr_ruleset from landlock_hierarchy, and switching back to use
>    the same domain scoping as ptrace.
>  - code clean up.
> v5:
>  - Renaming "LANDLOCK_*_ACCESS_SCOPE" to "LANDLOCK_*_SCOPE"
>  - Adding curr_ruleset to hierarachy_ruleset structure to have access from
>    landlock_hierarchy to its respective landlock_ruleset.
>  - Using curr_ruleset to check if a domain is scoped while walking in the
>    hierarchy of domains.
>  - Modifying inline comments.
> V4:
>  - Rebased on Günther's Patch:
>    https://lore.kernel.org/all/20240610082115.1693267-1-gnoack@google.com/
>    so there is no need for "LANDLOCK_SHIFT_ACCESS_SCOPE", then it is removed.
>  - Adding get_scope_accesses function to check all scoped access masks in a ruleset.
>  - Using file's FD credentials instead of credentials stored in peer_cred
>    for datagram sockets. (see discussion in [1])
>  - Modifying inline comments.
> V3:
>  - Improving commit description.
>  - Introducing "scoped" attribute to landlock_ruleset_attr for IPC scoping
>    purpose, and adding related functions.
>  - Changing structure of ruleset based on "scoped".
>  - Removing rcu lock and using unix_sk lock instead.
>  - Introducing scoping for datagram sockets in unix_may_send.
> V2:
>  - Removing wrapper functions
> 
> [1]https://lore.kernel.org/outreachy/Zmi8Ydz4Z6tYtpY1@tahera-OptiPlex-5000/T/#m8cdf33180d86c7ec22932e2eb4ef7dd4fc94c792


> -------
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

No need for this hunk.


> ---
>  include/uapi/linux/landlock.h |  29 +++++++++
>  security/landlock/limits.h    |   3 +
>  security/landlock/ruleset.c   |   7 ++-
>  security/landlock/ruleset.h   |  23 ++++++-
>  security/landlock/syscalls.c  |  14 +++--
>  security/landlock/task.c      | 112 ++++++++++++++++++++++++++++++++++
>  6 files changed, 181 insertions(+), 7 deletions(-)

> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 849f5123610b..597d89e54aae 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -13,6 +13,8 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
> +#include <net/sock.h>
> +#include <net/af_unix.h>
>  
>  #include "common.h"
>  #include "cred.h"
> @@ -108,9 +110,119 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  	return task_ptrace(parent, current);
>  }
>  
> +static int walk_and_check(const struct landlock_ruleset *const child,
> +			  struct landlock_hierarchy **walker, int i, int j,

We don't know what are "i" and "j" are while reading this function's
signature.  They need a better name.

Also, they are ingegers (signed), whereas l1 and l2 are size_t (unsigned).

> +			  bool check)
> +{
> +	if (!child || i < 0)
> +		return -1;
> +
> +	while (i < j && *walker) {

This would be more readable with a for() loop.

> +		if (check && landlock_get_scope_mask(child, j))

This is correct now but it will be a bug when we'll have other scope.
Instead, you can replace the "check" boolean with a variable containing
LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET.

> +			return -1;
> +		*walker = (*walker)->parent;
> +		j--;
> +	}
> +	if (!*walker)
> +		pr_warn_once("inconsistency in landlock hierarchy and layers");

This must indeed never happen, but WARN_ON_ONCE(!*walker) would be
better than this check+pr_warn.

Anyway, if this happen this pointer will still be dereferenced in
domain_sock_scope() right?  This must not be possible.


> +	return j;

Because j is now equal to i, no need to return it.  This function can
return a boolean instead, or a struct landlock_ruleset pointer/NULL to
avoid the pointer of pointer?

> +}
> +
> +/**
> + * domain_sock_scope - Checks if client domain is scoped in the same
> + *			domain as server.
> + *
> + * @client: Connecting socket domain.
> + * @server: Listening socket domain.
> + *
> + * Checks if the @client domain is scoped, then the server should be
> + * in the same domain to connect. If not, @client can connect to @server.
> + */
> +static bool domain_sock_scope(const struct landlock_ruleset *const client,

This function can have a more generic name if
LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET is passed as argument.  This could
be reused as-is for other kind of scope.

> +			      const struct landlock_ruleset *const server)
> +{
> +	size_t l1, l2;
> +	int scope_layer;
> +	struct landlock_hierarchy *cli_walker, *srv_walker;

We have some room for a bit more characters ;)
client_walker, server_walker;

> +
> +	if (!client)
> +		return true;
> +
> +	l1 = client->num_layers - 1;

Please rename variables in a consistent way, in this case something like
client_layer?

> +	cli_walker = client->hierarchy;
> +	if (server) {
> +		l2 = server->num_layers - 1;
> +		srv_walker = server->hierarchy;
> +	} else
> +		l2 = 0;
> +
> +	if (l1 > l2)
> +		scope_layer = walk_and_check(client, &cli_walker, l2, l1, true);

Instead of mixing the layer number with an error code, walk_and_check()
can return a boolean, take as argument &scope_layer, and update it.

> +	else if (l2 > l1)
> +		scope_layer =
> +			walk_and_check(server, &srv_walker, l1, l2, false);
> +	else
> +		scope_layer = l1;
> +
> +	if (scope_layer == -1)
> +		return false;

All these domains and layers checks are difficult to review. It needs at
least some comments, and preferably also some code refactoring to avoid
potential inconsistencies (checks).

> +
> +	while (scope_layer >= 0 && cli_walker) {

Why srv_walker is not checked?  Could this happen?  What would be the
result?

Please also use a for() loop here.

> +		if (landlock_get_scope_mask(client, scope_layer) &
> +		    LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET) {

The logic needs to be explained.

> +			if (!server)
> +				return false;
> +
> +			if (srv_walker == cli_walker)
> +				return true;
> +
> +			return false;
> +		}
> +		cli_walker = cli_walker->parent;
> +		srv_walker = srv_walker->parent;
> +		scope_layer--;
> +	}
> +	return true;
> +}
> +
> +static bool sock_is_scoped(struct sock *const other)
> +{
> +	const struct landlock_ruleset *dom_other;
> +	const struct landlock_ruleset *const dom =
> +		landlock_get_current_domain();
> +
> +	/* the credentials will not change */
> +	lockdep_assert_held(&unix_sk(other)->lock);
> +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> +
> +	/* other is scoped, they connect if they are in the same domain */
> +	return domain_sock_scope(dom, dom_other);
> +}
> +
> +static int hook_unix_stream_connect(struct sock *const sock,
> +				    struct sock *const other,
> +				    struct sock *const newsk)
> +{
> +	if (sock_is_scoped(other))
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
> +static int hook_unix_may_send(struct socket *const sock,
> +			      struct socket *const other)
> +{
> +	if (sock_is_scoped(other->sk))
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
> +	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
> +	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
>  };
>  
>  __init void landlock_add_task_hooks(void)
> -- 
> 2.34.1
> 
> 

