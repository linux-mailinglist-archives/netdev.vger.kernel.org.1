Return-Path: <netdev+bounces-115384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D6A946202
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015AFB21C37
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20C8136340;
	Fri,  2 Aug 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h640QXpq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98216BE34
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617245; cv=none; b=RX/pZQXShpVb5328kMPuNdn4GM/bUtZkRKdroTPSARHzW4iQESu+t5yctn18OaGOFHIAZ8oZkmg57r2DOy+YPkMrHMkeei1N9bTKf0QIio0uX/L5ye5Yl2BSBK4xpaasYPd0dHxXyonFwPh41qmpOQJssDAJiFps2lkaEj47z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617245; c=relaxed/simple;
	bh=RGf6luxF72orTmjcrfSwt70R0e+rSHz4Up7yB+sHXKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhcNPZP0PDl/N2wrPB2VtHT+tjd1Oajq36VHM2msC7/TZyBAZ7R3TTQvh0HRf/v4vt2c+LgrvJowfqetPJKBxvoZeDE0vbWWZQiNmZn61R9dxzpjVx7s+Vn7bHcLQsdnIpBcAY8owqweSr4BS5Jw/LUa4b/tH7KegBDzZetdsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=h640QXpq; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WbBZS3lYmzVH5;
	Fri,  2 Aug 2024 18:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1722617232;
	bh=f7GP9QMvtF9KsDGdfWmK8FrJmSmnuGh12Q4OwRUH/YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h640QXpqMez0avDH9LRVqqmyPGgDYsh2lOOlf1kBcl05LZ6VTtaK4T1nGtTi7ukif
	 kM3cOP6uCRa1ODXKwAXqznRbQeZpUEhbJt45sjfVKhUA6r/4N6NyT6uTkUeDdlkOze
	 wQIOp5ElphC+6luxO0SaLwlM/qxz3ZQc9O1cFpqo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WbBZQ6DB5zPPt;
	Fri,  2 Aug 2024 18:47:10 +0200 (CEST)
Date: Fri, 2 Aug 2024 18:47:04 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240802.EimaeN3wie7x@digikod.net>
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
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 68625e728f43..ab31e9f53e55 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
>  	 * rule explicitly allow them.
>  	 */
>  	__u64 handled_access_net;
> +	/**
> +	 * @scoped: Bitmask of scopes (cf. `Scope flags`_)
> +	 * restricting a Landlock domain from accessing outside
> +	 * resources(e.g. IPCs).
> +	 */
> +	__u64 scoped;
>  };
>  
>  /*
> @@ -266,4 +272,28 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  /* clang-format on */
> +
> +/**
> + * DOC: scope
> + *
> + * scoped attribute handles a set of restrictions on kernel IPCs through
> + * the following flags.

If present, this previous sentence should be after the "Scope flags"
section, otherwise it shows in the previous section.  I don't think this
sentence is useful because of the next one, so you can remove it.

> + *
> + * Scope flags
> + * ~~~~~~~~~~~
> + *
> + * These flags enable to restrict a sandboxed process from a set of IPC
> + * actions. Setting a flag for a ruleset will isolate the Landlock domain
> + * to forbid connections to resources outside the domain.
> + *
> + * IPCs with scoped actions:
> + *
> + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandboxed process
> + *   from connecting to an abstract unix socket created by a process
> + *   outside the related Landlock domain (e.g. a parent domain or a
> + *   non-sandboxed process).
> + */
> +/* clang-format off */
> +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> +/* clang-format on*/
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 4eb643077a2a..eb01d0fb2165 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -26,6 +26,9 @@
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> +#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> +#define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
> +#define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  /* clang-format on */
>  
>  #endif /* _SECURITY_LANDLOCK_LIMITS_H */
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 6ff232f58618..a93bdbf52fff 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -52,12 +52,13 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  
>  struct landlock_ruleset *
>  landlock_create_ruleset(const access_mask_t fs_access_mask,
> -			const access_mask_t net_access_mask)
> +			const access_mask_t net_access_mask,
> +			const access_mask_t scope_mask)
>  {
>  	struct landlock_ruleset *new_ruleset;
>  
>  	/* Informs about useless ruleset. */
> -	if (!fs_access_mask && !net_access_mask)
> +	if (!fs_access_mask && !net_access_mask && !scope_mask)
>  		return ERR_PTR(-ENOMSG);
>  	new_ruleset = create_ruleset(1);
>  	if (IS_ERR(new_ruleset))
> @@ -66,6 +67,8 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
>  		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
>  	if (net_access_mask)
>  		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
> +	if (scope_mask)
> +		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
>  	return new_ruleset;
>  }
>  
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 0f1b5b4c8f6b..c749fa0b3ecd 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -35,6 +35,8 @@ typedef u16 access_mask_t;
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
>  /* Makes sure all network access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
> +/* Makes sure all scoped rights can be stored*/
> +static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
>  /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
>  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  
> @@ -42,6 +44,7 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  struct access_masks {
>  	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
>  	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> +	access_mask_t scoped : LANDLOCK_NUM_SCOPE;
>  };
>  
>  typedef u16 layer_mask_t;
> @@ -233,7 +236,8 @@ struct landlock_ruleset {
>  
>  struct landlock_ruleset *
>  landlock_create_ruleset(const access_mask_t access_mask_fs,
> -			const access_mask_t access_mask_net);
> +			const access_mask_t access_mask_net,
> +			const access_mask_t scope_mask);
>  
>  void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
>  void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
> @@ -280,6 +284,16 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
>  	ruleset->access_masks[layer_level].net |= net_mask;
>  }
>  
> +static inline void
> +landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
> +			const access_mask_t scope_mask, const u16 layer_level)
> +{
> +	access_mask_t scoped_mask = scope_mask & LANDLOCK_MASK_SCOPE;
> +
> +	WARN_ON_ONCE(scope_mask != scoped_mask);
> +	ruleset->access_masks[layer_level].scoped |= scoped_mask;
> +}
> +
>  static inline access_mask_t
>  landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
>  				const u16 layer_level)
> @@ -303,6 +317,13 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
>  	return ruleset->access_masks[layer_level].net;
>  }
>  
> +static inline access_mask_t
> +landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
> +			const u16 layer_level)
> +{
> +	return ruleset->access_masks[layer_level].scoped;
> +}
> +
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  			    const access_mask_t access_request,
>  			    layer_mask_t (*const layer_masks)[],
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 03b470f5a85a..f51b29521d6b 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -97,8 +97,9 @@ static void build_check_abi(void)
>  	 */
>  	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
>  	ruleset_size += sizeof(ruleset_attr.handled_access_net);
> +	ruleset_size += sizeof(ruleset_attr.scoped);
>  	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
> -	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);
> +	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
>  
>  	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
>  	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
> @@ -149,7 +150,7 @@ static const struct file_operations ruleset_fops = {
>  	.write = fop_dummy_write,
>  };
>  
> -#define LANDLOCK_ABI_VERSION 5
> +#define LANDLOCK_ABI_VERSION 6
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> @@ -170,7 +171,7 @@ static const struct file_operations ruleset_fops = {
>   * Possible returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> - * - %EINVAL: unknown @flags, or unknown access, or too small @size;
> + * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;

I think you missed one of my previous review.

>   * - %E2BIG or %EFAULT: @attr or @size inconsistencies;
>   * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
>   */
> @@ -213,9 +214,14 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  	    LANDLOCK_MASK_ACCESS_NET)
>  		return -EINVAL;
>  
> +	/* Checks IPC scoping content (and 32-bits cast). */
> +	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) != LANDLOCK_MASK_SCOPE)
> +		return -EINVAL;
> +
>  	/* Checks arguments and transforms to kernel struct. */
>  	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
> -					  ruleset_attr.handled_access_net);
> +					  ruleset_attr.handled_access_net,
> +					  ruleset_attr.scoped);
>  	if (IS_ERR(ruleset))
>  		return PTR_ERR(ruleset);
>  
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

Please sort the included files.

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
> +{
> +	if (!child || base_layer < 0 || !(*walker))
> +		return false;
> +
> +	for (deep_layer; base_layer < deep_layer; deep_layer--) {
> +		if (check_scoping & landlock_get_scope_mask(child, deep_layer))
> +			return false;
> +		*walker = (*walker)->parent;
> +		if (WARN_ON_ONCE(!*walker))
> +			/* there is an inconsistency between num_layers
> +			 * and landlock_hierarchy in the ruleset
> +			 */
> +			return false;
> +	}
> +	return true;
> +}
> +
> +/**
> + * domain_IPC_scope - Checks if the client domain is scoped in the same

Please don't use uppercase (IPC) in function or variable's names, it is
reserved to "#define" statements only.

> + *		      domain as the server.
> + *
> + * @client: IPC sender domain.
> + * @server: IPC receiver domain.
> + *
> + * Check if the @client domain is scoped to access the @server; the @server
> + * must be scoped in the same domain.
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
> +	base_layer = (client_layer > server_layer) ? server_layer :
> +						     client_layer;
> +
> +	/* For client domain, walk_and_check ensures the client domain is
> +	 * not scoped until gets to base_layer.
> +	 * For server_domain, it only ensures that the server domain exist.
> +	 */
> +	if (client_layer != server_layer) {
> +		if (client_layer > server_layer)
> +			is_scoped = walk_and_check(client, &client_walker,
> +						   server_layer, client_layer,
> +						   ipc_type);
> +		else
> +			is_scoped = walk_and_check(server, &server_walker,
> +						   client_layer, server_layer,
> +						   ipc_type & 0);
> +		if (!is_scoped)
> +			return false;
> +	}
> +	/* client and server are at the same level in hierarchy. If client is
> +	 * scoped, the server must be scoped in the same domain
> +	 */
> +	for (base_layer; base_layer >= 0; base_layer--) {
> +		if (landlock_get_scope_mask(client, base_layer) & ipc_type) {
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
> +		 * landlock_hierarchy in each of rulesets
> +		 */
> +		if (WARN_ON_ONCE(base_layer > 0 &&
> +				 (!server_walker || !client_walker)))
> +			return false;
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
> +	return domain_IPC_scope(dom, dom_other,
> +				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
> +}
> +
> +static bool check_unix_address_format(struct sock *const sock)
> +{
> +	struct unix_address *addr = unix_sk(sock)->addr;
> +
> +	if (!addr)
> +		return true;
> +
> +	if (addr->len > sizeof(AF_UNIX)) {

AF_UNIX is the family, not a length.

I'm wondering if we cannot also check the "path" field or something
else.

> +		/* handling unspec sockets */
> +		if (!addr->name[0].sun_path)
> +			return true;
> +
> +		if (addr->name[0].sun_path[0] == '\0')
> +			if (!sock_is_scoped(sock))

This function should only check the address format.  sock_is_scoped()
can be called in each LSM hook.

> +				return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int hook_unix_stream_connect(struct sock *const sock,
> +				    struct sock *const other,
> +				    struct sock *const newsk)
> +{

To not impact unsandboxed tasks, we need to first check if current is
sandboxed with Landlock, and then pass this dom to the following
functions.

> +	if (check_unix_address_format(other))
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
> +static int hook_unix_may_send(struct socket *const sock,
> +			      struct socket *const other)
> +{
> +	if (check_unix_address_format(other->sk))
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

