Return-Path: <netdev+bounces-304447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id etDuI5hyR2pyYQAAu9opvQ
	(envelope-from <netdev+bounces-304447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:28:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E167000BB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:28:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j5YhX3kQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304447-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304447-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F7203146151
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16298367285;
	Fri,  3 Jul 2026 08:11:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4513603D5;
	Fri,  3 Jul 2026 08:11:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066288; cv=none; b=OftlEDTop0ty5apui7tM+IAxFcjGTREeDCdN5UfuQ/VBjRuVITQVz9kpnR/Pvb85PvV/n90818vCx1ITOhPgKmM32+eZKyn0KTN9e4LjwzFZ8m1mOWZ/zGGU+TcVSW53qaB2B1aRzh2wA8dViGd8L+B2tUjrMLSOejoBJziTAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066288; c=relaxed/simple;
	bh=JX03iTHrikR9VJkoRUoLi2VdEbthp71g9eD2Ync+wV8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=qSnUH8AwBsA7nHgqet3twjQMhLlh87H0MgxwC127yY4LKqxd7HJnaiP8JepsaRv07aG4YxaXJcQI8oxSeECjv3WZCMjjxv6YgHwD9H9JQA/aRi9lgpcqwlFt7v/pkDURCMujCh91u2JvKO6wEppscYmiiQ8ftTJnPAfXyw/P51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5YhX3kQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39131F00A3D;
	Fri,  3 Jul 2026 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066286;
	bh=Ro3wnGG38KDFb6ihthy3CeKILdGmcUHT/i7PDCPWBlM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=j5YhX3kQ4j+JL24vYWVliFbx2reqcLtkKZNj/KvNuamnJJZXRnzNZ0YsFe6IvR4F1
	 /8IrlRhkVueayUweMGKsylr6bFuryvIA4aNCqyOyQhvHkpQolQMA36ts6Dlbk1iIGL
	 1OO6TCkHxfZdmlkv4on6+grDtq5W7zvTqmPmO2h1Nnkmm3UGHKwJi9aqcrZ83xQ7Gw
	 Ot8jhIuBdv49vuAS94kgMUbHyI9Ar7O2KcZyRDiBvu3koDkb/1lR2QtXHslvDi1eXq
	 7LB3KtzC9drJ61NC2Unz5Q00A4jlLVFxfl/ROXLkaHab5YpDbdEcrT2D4NyXiDTxj9
	 l6N+Bw1So6h7g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 3/3] coredump, net: remove `SOCK_COREDUMP`
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <John.Ericson@Obsidian.Systems>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, John Ericson <mail@JohnEricson.me>, 
 Cong Wang <cwang@multikernel.io>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 David Rheinsberg <david@readahead.eu>, Andy Lutomirski <luto@kernel.org>, 
 Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260703073948.2541875-4-John.Ericson@Obsidian.Systems>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-4-John.Ericson@Obsidian.Systems>
Date: Fri, 03 Jul 2026 10:11:17 +0200
Message-Id: <20260703-umgehen-auftun-anlagen-826bf59dfcb5@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6629; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JX03iTHrikR9VJkoRUoLi2VdEbthp71g9eD2Ync+wV8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5562s2lpsMeOa1UeBlV1NOsYHJLb7n9vzq3f+ji9uF
 ibhqVHLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS3Mvw3/Ph/YzHP3y4kr46
 hZ03MpzI1FVqpmgxy8epYpewVKSzHyPD1hlfqr2jl3768S5U4+PhLadOzpy9TDCbqZt735NpM5W
 bOQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:John.Ericson@Obsidian.Systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mail@JohnEricson.me,m:cwang@multikernel.io,m:kuniyu@google.com,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:luto@kernel.org,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:mic@digikod.net,m:gnoack@google.com,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304447-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3E167000BB

> The utility of the refactors of the last two commits is demonstrated by
> fixing this glaring layer violation: the unix socket implementation
> knowing about the coredump socket caller.
> 
> Before, when the only way to connect to a socket was via the UAPI
> `struct sockaddr_un`, the only way to implement the proper logic that
> the kernel needs to resolve the coredump socket path was via hacking it
> into the socket implementation.
> 
> In addition to being quite ugly, this layer violation is not great for
> security. The intent is that `SOCK_COREDUMP` can only be used by the
> kernel, and to be clear, I have no reason to believe this is not
> correctly enforced today. But because of the many functions with flags
> arguments, this is not a locally-enforced invariant. Some change, at
> some point, could mess up, and allow user-provided flags to sneak in,
> and this strikes me as a mistake waiting to happen. At that point, a
> user could exploit this to connect to any socket it likes, bypassing
> permission checks.
> 
> Now, with the two functions we've just previously factored out, we can
> fix the layering. The custom path lookup logic lives with the coredump
> caller, where it belongs. Once the right `struct path` is found
> (actually just the inode is needed), the coredump caller can resolve a
> `struct sock *` from it, and then directly connect to it. With this
> change, `SOCK_COREDUMP` is no longer needed at all, and can be deleted.
> The layer violation is gone, and the security footgun is gone with it.
> 
> As an added bonus, remove `flags` parameters from a number of internal
> functions that no longer need them. They were just taking flags
> parameters for the sake of `SOCK_COREDUMP`, and so with that gone, those
> flag parameters are also no longer needed. If or when there is a new
> flag that motivates them, they can be added back.
> 
> Tested that `coredump_socket_protocol_test` still passes.
> 
> Signed-off-by: John Ericson <mail@JohnEricson.me>
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index e68a76ff92a3..e1452021218e 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -14,6 +14,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/highmem.h>
>  #include <linux/spinlock.h>
> +#include <linux/cred.h>
>  #include <linux/key.h>
>  #include <linux/personality.h>
>  #include <linux/binfmts.h>
> @@ -21,6 +22,7 @@
>  #include <linux/sort.h>
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/signal.h>
> +#include <linux/sched/task.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/utsname.h>
>  #include <linux/pid_namespace.h>
> @@ -50,7 +52,6 @@
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
>  #include <uapi/linux/pidfd.h>
> -#include <uapi/linux/un.h>
>  #include <uapi/linux/coredump.h>
>  
>  #include <linux/uaccess.h>
> @@ -668,17 +669,10 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
>  static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *cprm)
>  {
>  	struct file *file __free(fput) = NULL;
> -	struct sockaddr_un addr = {
> -		.sun_family = AF_UNIX,
> -	};
> -	ssize_t addr_len;
> -	int retval;
> +	struct path root, path;
>  	struct socket *socket;
> -
> -	addr_len = strscpy(addr.sun_path, cn->corename);
> -	if (addr_len < 0)
> -		return false;
> -	addr_len += offsetof(struct sockaddr_un, sun_path) + 1;
> +	struct sock *sk;
> +	int retval;
>  
>  	/*
>  	 * It is possible that the userspace process which is supposed
> @@ -710,14 +704,37 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
>  	 */
>  	pidfs_coredump(cprm);
>  
> -	retval = kernel_connect(socket, (struct sockaddr_unsized *)(&addr), addr_len,
> -				O_NONBLOCK | SOCK_COREDUMP);
> +	/*
> +	 * Resolve the socket path relative to init's root and with kernel
> +	 * credentials, and with symlinks, magic links and escaping the
> +	 * root all forbidden, so the dumping process cannot use its own
> +	 * filesystem view to redirect its core to an arbitrary socket.
> +	 */
> +	task_lock(&init_task);
> +	get_fs_root(init_task.fs, &root);
> +	task_unlock(&init_task);
> +
> +	scoped_with_kernel_creds()
> +		retval = vfs_path_lookup(root.dentry, root.mnt, cn->corename,
> +					 LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
> +					 LOOKUP_NO_MAGICLINKS, &path);
> +	path_put(&root);
> +	if (retval)
> +		return false;
> +
> +	/* Connect directly to the socket bound there, by fd not by name. */
> +	sk = unix_lookup_bsd_path(&path, SOCK_STREAM);
> +	path_put(&path);
> +	if (IS_ERR(sk))
> +		return false;
>  
> +	retval = kernel_unix_connect_direct(sk, socket, O_NONBLOCK);

I don't think dragging the bowels of net/ into fs/coredump.c just for
the sake of getting a purely internal SOCK_COREDUMP flag out of the way
is the right way to go.

The two helpers also make no sense to me and force a bunch of cleanup on
the caller as well.

I suspect the saner thing to do would be to introduce a primitive for
connecting to an AF_UNIX path-based socket directly instead of this
weird dance here, no?

int kernel_unix_connect(const char *path, struct socket *socket, unsigned int o_flags, int type)

then my kthread changes would collapse this into:

scoped_with_init_fs()
	retval = kernel_unix_connect(path, socket, O_NONBLOCK, SOCK_STREAM);

> +	sock_put(sk);
>  	if (retval) {
>  		if (retval == -EAGAIN)
> -			coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
> +			coredump_report_failure("Coredump socket %s receive queue full", cn->corename);
>  		else
> -			coredump_report_failure("Coredump socket connection %s failed %d", addr.sun_path, retval);
> +			coredump_report_failure("Coredump socket connection %s failed %d", cn->corename, retval);
>  		return false;
>  	}
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 65c9609ec207..3d6fbb6d2628 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -323,8 +323,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>  
>  #if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> -LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
> -	 int flags)
> +LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other)

I'm not sure why we would go on altering all kinds of LSM hooks as well.

-- 
Christian Brauner <brauner@kernel.org>

