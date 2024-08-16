Return-Path: <netdev+bounces-119315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C64E955246
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E5B231D0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030581C37A3;
	Fri, 16 Aug 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XxBWyddf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A901BE87A;
	Fri, 16 Aug 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843219; cv=none; b=WuASx6bdbYIwjGy+xU8XD+4dz0Vbtz+aaSNUpwmJsrvT3WueYhE34525EJe52nZoREWARuYpU80tX/8zXeur7GTnYn3/JK2irOYsmo19j2aNihfG2JiVvPMWCrknrCkVuGmmD0eYqnarXwbXOVbJ6vCHiIfDi3AFT6nEn48DbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843219; c=relaxed/simple;
	bh=RsnMdQdxZqF2ortXNgK8m4Eno7YiqvVAhPbPy6YyNWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbgjiRzvxI1pPeKnzCtpYsjG+eQUnAqMMBlB2lj2Z40m16Gv9rEoN1p24gv4MA9bJvR8IxLdGj4XR2LA9pBb8Y5N+Q3CgwtGkdUan3ExhpWWYZii04RFLnL3Yc+bXQGdBL59Wy7XkvvLrNzjcENqhdwPOScqjuUV1GmaY69pbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XxBWyddf; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wlvys5SGGz13tW;
	Fri, 16 Aug 2024 23:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723843205;
	bh=0w9S8iWKBv9Q934rgCPmMlAKNc73m9LHTITdhR8icLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxBWyddfhDcivwuxUJ//c/Uw64C145/x13b57MCGJNrLK+x1umQMBWXj+98KXZ0oJ
	 w0TJHM4caw8ZXGBykR+9XzqWp0si8WGdahU0nriRiSvKb63LQEkplKEVQKdOuVS+hf
	 76TYx1SzhjKTjGR6xyjFTsfg0Xb5VnJ9YWxUWcsg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wlvyr4WZVzQPg;
	Fri, 16 Aug 2024 23:20:04 +0200 (CEST)
Date: Fri, 16 Aug 2024 23:19:58 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 1/5] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240816.Bi8EitheeV2o@digikod.net>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <603cf546392f0cd35227f696527fd8f1d644cb31.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <603cf546392f0cd35227f696527fd8f1d644cb31.1723615689.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 14, 2024 at 12:22:19AM -0600, Tahera Fahimi wrote:
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
> v9:
> - Editting inline comments.
> - Major refactoring in domain_is_scoped() and is_abstract_socket
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

Useless "----"

> ---
>  include/uapi/linux/landlock.h |  27 +++++++
>  security/landlock/limits.h    |   3 +
>  security/landlock/ruleset.c   |   7 +-
>  security/landlock/ruleset.h   |  23 +++++-
>  security/landlock/syscalls.c  |  17 +++--
>  security/landlock/task.c      | 129 ++++++++++++++++++++++++++++++++++
>  6 files changed, 198 insertions(+), 8 deletions(-)
> 

> +static bool sock_is_scoped(struct sock *const other,
> +			   const struct landlock_ruleset *const dom)

Please rename "dom" to "domain".  Function arguments with full names
make the API more consistent and easier to understand.

> +{
> +	const struct landlock_ruleset *dom_other;
> +
> +	/* the credentials will not change */
> +	lockdep_assert_held(&unix_sk(other)->lock);
> +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> +	return domain_is_scoped(dom, dom_other,
> +				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
> +}
> +
> +static bool is_abstract_socket(struct sock *const sock)
> +{
> +	struct unix_address *addr = unix_sk(sock)->addr;
> +
> +	if (!addr)
> +		return false;
> +
> +	if (addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
> +	    addr->name[0].sun_path[0] == '\0')
> +		return true;
> +
> +	return false;

Much better!

> +}
> +
> +static int hook_unix_stream_connect(struct sock *const sock,
> +				    struct sock *const other,
> +				    struct sock *const newsk)
> +{
> +	const struct landlock_ruleset *const dom =
> +		landlock_get_current_domain();
> +
> +	/* quick return for non-sandboxed processes */
> +	if (!dom)
> +		return 0;
> +
> +	if (is_abstract_socket(other))
> +		if (sock_is_scoped(other, dom))

if (is_abstract_socket(other) && sock_is_scoped(other, dom))

(We might want to extend this hook in the future but we'll revise this
notation when needed)

> +			return -EPERM;
> +
> +	return 0;
> +}
> +
> +static int hook_unix_may_send(struct socket *const sock,
> +			      struct socket *const other)
> +{
> +	const struct landlock_ruleset *const dom =
> +		landlock_get_current_domain();
> +
> +	if (!dom)
> +		return 0;
> +
> +	if (is_abstract_socket(other->sk))
> +		if (sock_is_scoped(other->sk, dom))

ditto

> +			return -EPERM;
> +
> +	return 0;
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

