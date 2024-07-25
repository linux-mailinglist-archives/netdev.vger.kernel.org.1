Return-Path: <netdev+bounces-113022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48F93C40C
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A271F21C9E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572BC19D074;
	Thu, 25 Jul 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uiJ5Nqdk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B319D069;
	Thu, 25 Jul 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917484; cv=none; b=g/AzDKx0/ShnI+Az3qXVEWtKc6HiF9ZJQxW5Tt0wUbcd/MbOjfW3kgyHfWYSDqNadx33h3jpKe296d/KZBineIOTs1TfFF/Pi8eRBSRQRQJcHp0pwR/qIElcMwxbHaS5ff/BiMK/XDTJSQmvXGeqspQQSGp90eMfX1If8QgI9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917484; c=relaxed/simple;
	bh=kKGsCvJv3BT95C1psRjk/CwXqzYbGD5BiiQadA+rE4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItElzyQyb6V++d61dz5bhW+v5PPtNNLNog9aPiKqE0EHczy4A31Sh2CraRMGjuNSdo5MA9kAzwUynO0UYiGPGvCNeq2Hu12LkkbkIir0xeY+3PXdnHgAdKv4r2e3rB2ZLlsOwWocqKRk9qLcBVrf0hyJC2yXJ8WPVmy7zfD/Jzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uiJ5Nqdk; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WVCnX6f2bz2gP;
	Thu, 25 Jul 2024 16:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721917472;
	bh=aEyCFHllkk+sAOFEXZOQmrTY5LGlcDqtP7VwEmNt6Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiJ5Nqdkp5bWlKsCa0Dftmmf6j+WIG/adsPB0Y9YPS62UV7fhIaljK7j99W3kC/L0
	 hVKZpkMT+DhGEsi/8gXkNKrsKdcLF69an3Qp1PIXvyI07iV9pYkxwQf491RX3fbKpg
	 gG9BpCyaha9CUReyx+osbacaTHJUB96lGZWAj+fg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WVCnX2th4zrqG;
	Thu, 25 Jul 2024 16:24:32 +0200 (CEST)
Date: Thu, 25 Jul 2024 16:24:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 4/4] documentation/landlock: Adding scoping mechanism
 documentation
Message-ID: <20240725.oF9eengaD4ue@digikod.net>
References: <cover.1721269836.git.fahimitahera@gmail.com>
 <319fd95504a9e491fa756c56048e63791ecd2aed.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <319fd95504a9e491fa756c56048e63791ecd2aed.1721269836.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

The subject should start with "landlock:" not "documentation/landlock:"
See similar commits.

On Wed, Jul 17, 2024 at 10:15:22PM -0600, Tahera Fahimi wrote:
> - Defining ABI version 6 that supports IPC restriction.
> - Adding "scoped" to the "Access rights".
> - In current limitation, unnamed sockets are specified as
>   sockets that are not restricted.

It would help to write (small) paragraphs instead of bullet points (here
and for other patches).

> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  Documentation/userspace-api/landlock.rst | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 07b63aec56fa..61b91cc03560 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: April 2024
> +:Date: July 2024
>  
>  The goal of Landlock is to enable to restrict ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -306,6 +306,16 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
>  process, a sandboxed process should have a subset of the target process rules,
>  which means the tracee must be in a sub-domain of the tracer.
>  
> +IPC Scoping
> +-----------
> +
> +Similar to Ptrace, a sandboxed process should not be able to access the resources
> +(like abstract unix sockets, or signals) outside of the sandbox domain. For example,
> +a sandboxed process should not be able to :manpage:`connect(2)` to a non-sandboxed
> +process through abstract unix sockets (:manpage:`unix(7)`). This restriction is
> +applicable by optionally specifying ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET`` in
> +the ruleset.

Here is a proposal based on your text:

Complementary to the implicit `ptrace restrictions`_, we may want to
further restrict interactions between sandboxes.  Each Landlock domain
can be explicitly scoped for a set of actions by specifying it on a
ruleset.

For example, if a sandboxed process should not be able to
:manpage:`connect(2)` to a non-sandboxed process through abstract
:manpage:`unix(7)` sockets, we can specify such restriction with
``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``.


(We also need to explain how scoping works, especially between scoped
and non-scoped domains)

> +
>  Truncating files
>  ----------------
>  
> @@ -404,7 +414,7 @@ Access rights
>  -------------
>  
>  .. kernel-doc:: include/uapi/linux/landlock.h
> -    :identifiers: fs_access net_access
> +    :identifiers: fs_access net_access scoped
>  
>  Creating a new ruleset
>  ----------------------
> @@ -446,7 +456,7 @@ Special filesystems
>  
>  Access to regular files and directories can be restricted by Landlock,
>  according to the handled accesses of a ruleset.  However, files that do not
> -come from a user-visible filesystem (e.g. pipe, socket), but can still be
> +come from a user-visible filesystem (e.g. pipe, unnamed socket), but can still be

Why this change? Opened named sockets are still visible in /proc/self/fd/

>  accessed through ``/proc/<pid>/fd/*``, cannot currently be explicitly
>  restricted.  Likewise, some special kernel filesystems such as nsfs, which can
>  be accessed through ``/proc/<pid>/ns/*``, cannot currently be explicitly
> @@ -541,6 +551,13 @@ earlier ABI.
>  Starting with the Landlock ABI version 5, it is possible to restrict the use of
>  :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
>  
> +Special filesystems (ABI < 6)

"Special filesystems"? This patch series is about abstract unix socket
scoping.  The signal scoping one can inlcude a patch rewriting this title.

> +-----------------------------
> +
> +With ABI version 6, it is possible to restrict IPC actions such as connecting to

The signal patch series may be merged with this one for the same kernel
release but we should be explicit about the *current" changes.  You can
write this section talking only about
LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET, and in the signal scoping patch
series you can extend this section.

> +an abstract Unix socket through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``, thanks
> +to the ``.scoped`` ruleset attribute.

The dot is superfluous (here and in comments):

"thanks to the ruleset's ``scoped`` attribute."

> +
>  .. _kernel_support:
>  
>  Kernel support
> -- 
> 2.34.1
> 
> 

