Return-Path: <netdev+bounces-115489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A75994697A
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 13:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF6F1F21452
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386614E2FA;
	Sat,  3 Aug 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yt1WAL/b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F64A2F;
	Sat,  3 Aug 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722684563; cv=none; b=kGeU1PeeDmL4Y44WE7OxXGIDvW9aQMGyjJsxpTTvud1F44kZTxdTOZePHmPjDTwnp0Lg4QH8kVwS/HC0hh0VoKIxeVGmgkToFNwC0lZiM6R59zJ0UtlN/8Rgj+F4MsfycBNf85AgpzhMZgYYXQ4ofFqLJkMtmwgsAYtJoxgD2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722684563; c=relaxed/simple;
	bh=M7Fe/njCUoCP6RdmOYg3bUxuW4aHwzbuxwI4Pq19KiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMtQRoPsS7sA1dBy15EPXz1e5E4DqdX0Xnt03O+kR92pBnArcYcB7jmxoErllNAH0oG8/+4b9c4JFGNRe59qTZ+NqTCa7VajqJI76YwDXKuzbmsbrhIqAPh8lI91X1GEXAUeRl3nLdkBZjSSstnMxH6Rg003arnZTplnWm1KQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yt1WAL/b; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WbgT465zMzbTj;
	Sat,  3 Aug 2024 13:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1722684552;
	bh=jwsyx2nnKOINE7lKj3pbNTUdQ8EqlqBDP16h792D1Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yt1WAL/bXWZLlDGy398J3PTbg4rOPCRNljSUAyUoQb5mmYl7tmfyRwXKkRhuwCQW+
	 nYii/957sFuyygKT6gBtQLgSN6J8+4cb+dxojd2lkBEh7hBHghHlKCPRlZHZ/jfuXh
	 NVfDl51mFaG2d6WNVPBm5X5hnuHmV5nX3khY88rY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WbgT33Fdbz916;
	Sat,  3 Aug 2024 13:29:11 +0200 (CEST)
Date: Sat, 3 Aug 2024 13:29:04 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240803.iefooCha4gae@digikod.net>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 01, 2024 at 10:02:33PM -0600, Tahera Fahimi wrote:
> This patch introduces a new "scoped" attribute to the landlock_ruleset_attr
> that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> abstract Unix sockets from connecting to a process outside of
> the same landlock domain. It implements two hooks, unix_stream_connect
> and unix_may_send to enforce this restriction.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> ---
> v8:
> - Code refactoring (improve code readability, renaming variable, etc.) based
>   on reviews by Mickaël Salaün on version 7.
> - Adding warn_on_once to check (impossible) inconsistencies.
> - Adding inline comments.
> - Adding check_unix_address_format to check if the scoping socket is an abstract
>   unix sockets.
> v7:
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
>  - Using socket's file credentials instead of credentials stored in peer_cred
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
> [1]https://lore.kernel.org/all/20240610.Aifee5ingugh@digikod.net/
> ----
> ---
>  include/uapi/linux/landlock.h |  30 +++++++
>  security/landlock/limits.h    |   3 +
>  security/landlock/ruleset.c   |   7 +-
>  security/landlock/ruleset.h   |  23 ++++-
>  security/landlock/syscalls.c  |  14 ++-
>  security/landlock/task.c      | 155 ++++++++++++++++++++++++++++++++++
>  6 files changed, 225 insertions(+), 7 deletions(-)

> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 849f5123610b..7e8579ebae83 100644
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
> @@ -108,9 +110,162 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  	return task_ptrace(parent, current);
>  }
>  
> +static bool walk_and_check(const struct landlock_ruleset *const child,
> +			   struct landlock_hierarchy **walker,
> +			   size_t base_layer, size_t deep_layer,
> +			   access_mask_t check_scoping)

s/check_scoping/scope/

> +{
> +	if (!child || base_layer < 0 || !(*walker))

I guess it should be:
WARN_ON_ONCE(!child || base_layer < 0 || !(*walker))

> +		return false;
> +
> +	for (deep_layer; base_layer < deep_layer; deep_layer--) {

No need to pass deep_layer as argument:
deep_layer = child->num_layers - 1

> +		if (check_scoping & landlock_get_scope_mask(child, deep_layer))
> +			return false;
> +		*walker = (*walker)->parent;
> +		if (WARN_ON_ONCE(!*walker))
> +			/* there is an inconsistency between num_layers

Please use full sentences starting with a capital letter and ending with
a dot, and in this case start with "/*"

> +			 * and landlock_hierarchy in the ruleset
> +			 */
> +			return false;
> +	}
> +	return true;
> +}
> +
> +/**
> + * domain_IPC_scope - Checks if the client domain is scoped in the same
> + *		      domain as the server.

Actually, you can remove IPC from the function name.

> + *
> + * @client: IPC sender domain.
> + * @server: IPC receiver domain.
> + *
> + * Check if the @client domain is scoped to access the @server; the @server
> + * must be scoped in the same domain.

Returns true if...

> + */
> +static bool domain_IPC_scope(const struct landlock_ruleset *const client,
> +			     const struct landlock_ruleset *const server,
> +			     access_mask_t ipc_type)
> +{
> +	size_t client_layer, server_layer = 0;
> +	int base_layer;
> +	struct landlock_hierarchy *client_walker, *server_walker;
> +	bool is_scoped;
> +
> +	/* Quick return if client has no domain */
> +	if (!client)
> +		return true;
> +
> +	client_layer = client->num_layers - 1;
> +	client_walker = client->hierarchy;
> +	if (server) {
> +		server_layer = server->num_layers - 1;
> +		server_walker = server->hierarchy;
> +	}

} else {
	server_layer = 0;
	server_walker = NULL;
}

> +	base_layer = (client_layer > server_layer) ? server_layer :
> +						     client_layer;
> +
> +	/* For client domain, walk_and_check ensures the client domain is
> +	 * not scoped until gets to base_layer.

until gets?

> +	 * For server_domain, it only ensures that the server domain exist.
> +	 */
> +	if (client_layer != server_layer) {

bool is_scoped;

> +		if (client_layer > server_layer)
> +			is_scoped = walk_and_check(client, &client_walker,
> +						   server_layer, client_layer,
> +						   ipc_type);
> +		else

server_walker may be uninitialized and still read here, and maybe later
in the for loop.  The whole code should maks sure this cannot happen,
and a test case should check this.

> +			is_scoped = walk_and_check(server, &server_walker,
> +						   client_layer, server_layer,
> +						   ipc_type & 0);

"ipc_type & 0" is the same as "0"

> +		if (!is_scoped)

The name doesn't reflect the semantic. walk_and_check() should return
the inverse.

> +			return false;
> +	}

This code would be simpler:

if (client_layer > server_layer) {
	base_layer = server_layer;
	// TODO: inverse boolean logic
	if (!walk_and_check(client, &client_walker,
				   base_layer, ipc_type))
		return false;
} else (client_layer < server_layer) {
	base_layer = client_layer;
	// TODO: inverse boolean logic
	if (!walk_and_check(server, &server_walker,
				   base_layer, 0))
		return false;
} else {
	base_layer = client_layer;
}


I think we can improve more to make sure there is no path/risk of
inconsistent pointers.


> +	/* client and server are at the same level in hierarchy. If client is
> +	 * scoped, the server must be scoped in the same domain
> +	 */
> +	for (base_layer; base_layer >= 0; base_layer--) {
> +		if (landlock_get_scope_mask(client, base_layer) & ipc_type) {

With each multi-line comment, the first line should be empty:
/*
 * This check must be here since access would be denied only if

> +			/* This check must be here since access would be denied only if
> +			 * the client is scoped and the server has no domain, so
> +			 * if the client has a domain but is not scoped and the server
> +			 * has no domain, access is guaranteed.
> +			 */
> +			if (!server)
> +				return false;
> +
> +			if (server_walker == client_walker)
> +				return true;
> +
> +			return false;
> +		}
> +		client_walker = client_walker->parent;
> +		server_walker = server_walker->parent;
> +		/* Warn if there is an incosistenncy between num_layers and

Makes sure there is no inconsistency between num_layers and


> +		 * landlock_hierarchy in each of rulesets
> +		 */
> +		if (WARN_ON_ONCE(base_layer > 0 &&
> +				 (!server_walker || !client_walker)))
> +			return false;
> +	}
> +	return true;
> +}

