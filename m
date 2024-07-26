Return-Path: <netdev+bounces-113163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE29293CF4B
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AFF1C222E9
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DD8176AAA;
	Fri, 26 Jul 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0U4Jy2sl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D11741FB
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981266; cv=none; b=HTlvPfT4z2hzqNDil7JpnS7787MUT560WgYtKLR8rznyrQGIbancqmu4zXeyJAiVVg0NKKDMeiQzH0gowY0VxRpAjVQceMKRCM8HIEjxtuTi8Z69nEDxsyqV/s1JKfUGK0ECOmHkOn1oxGBWcMEiIGgsHeh4rdJAMoyuWCEMNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981266; c=relaxed/simple;
	bh=eI+e+tli3hU865TCIxyeXDogwsp/X2laaJtuyO9qqZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhi/UI3AS/Hi0Z55W5j/RrwF+gezgCHcu+ZamxvZp8bg8DaSBiTkclFaI8ABMgC/4NSOGS72kBYV/An4DuctsIw+X0wjo3d8XqLmFkR9TD1ulB+vmG9g+W2V7V+FBYAPTK5za4jJNFA7SxYCRnZmMb/MVvkMdRvoFvZ6u456sYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0U4Jy2sl; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WVgND2GvGzN1B;
	Fri, 26 Jul 2024 10:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721981260;
	bh=1B7FkB9zwPzXkb++z1W4fSaxY9faalW6aoTN3k9G6eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0U4Jy2slEWPGSBR3Fj22KEMce/LLcWxIK9fCZURM2DV4ZaexrYddYp4pvpQdU6873
	 UTytPDUlX6zKmUzijq50JXaxyAPrnxbdPNJj57M/SM3HS4zyMfndVfxQ2IldT+xIkD
	 pIxYHvtd+15jzve9FE9Dc86GFHD7O+41IZhNYkZA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WVgNC54Qrzqyd;
	Fri, 26 Jul 2024 10:07:39 +0200 (CEST)
Date: Fri, 26 Jul 2024 10:07:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240726.Nohde4vooy3A@digikod.net>
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
> ---
>  include/uapi/linux/landlock.h |  29 +++++++++
>  security/landlock/limits.h    |   3 +
>  security/landlock/ruleset.c   |   7 ++-
>  security/landlock/ruleset.h   |  23 ++++++-
>  security/landlock/syscalls.c  |  14 +++--
>  security/landlock/task.c      | 112 ++++++++++++++++++++++++++++++++++
>  6 files changed, 181 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 68625e728f43..9cd881673434 100644
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
> @@ -266,4 +272,27 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  /* clang-format on */
> +
> +/**
> + * DOC: scope
> + *
> + * .scoped attribute handles a set of restrictions on kernel IPCs through
> + * the following flags.

If you look at the generated documentation (once this doc is properly
included), you'll see that this line ends in the Network flags section.

> + *
> + * Scope flags
> + * ~~~~~~~~~~~
> + *
> + * These flags enable to restrict a sandboxed process from a set of IPC
> + * actions. Setting a flag for a ruleset will isolate the Landlock domain
> + * to forbid connections to resources outside the domain.
> + *
> + * IPCs with scoped actions:

There is a formating issue here.

> + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandboxed process
> + *   from connecting to an abstract unix socket created by a process
> + *   outside the related Landlock domain (e.g. a parent domain or a
> + *   non-sandboxed process).
> + */
> +/* clang-format off */
> +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> +/* clang-format on*/
>  #endif /* _UAPI_LINUX_LANDLOCK_H */

