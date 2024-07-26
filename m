Return-Path: <netdev+bounces-113158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24D93CF35
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180C6B21A9D
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CFD176AD2;
	Fri, 26 Jul 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NRX8m5gm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A32176257
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981095; cv=none; b=bPax/n3wf8rJBSjm4OrCdX4msyDfkkDwiCMnwIryrxExfA0+ypyStkXq7zcLvCRVFqCr1TRqWe0FyhMVow76Fw9H/WsSAXifhBh80OaJy99BytkczG/bU3ZKaFSxVrwp7K+hzoldNHf+BkXnuMwBdR+EJCUsRkqWuNMNfMf0MUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981095; c=relaxed/simple;
	bh=nNt0zpC/6tOUSkyx0tkZG4O0/vc2H4GqqHBXub0k7sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9U7/SAuCB6Rua9Q+PyQesJOO6DJgmwNXmLaGr6TqtMoagbsjp+/vEcQMkWNYbWpJJ664swqWkHQ8WnpwMsxvUoFxyriLVfIfB3JAUCGQiQ8O0cHlLZJdOopwlcGu0nTdDjwM/3v1aemJfV0KILX0Pk8H+IXXwQkxJwJSVKif20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NRX8m5gm; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WVgJq1f42zFf5;
	Fri, 26 Jul 2024 10:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721981083;
	bh=+TAdx9l6iazb3Rz8qM4APrxPXViKUEuBFt8myb3aPqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRX8m5gm1Wh1lzkAloWaMpdUObfxCI2cgpTHB4JU8iAGqBZoj5BEr/0qdT8CgQ98V
	 AtMeHHc6gHwQB8ElkStFtErF1bwowhXvI9q8w9MajwJQdJDOPyIyNhVJM8BfSKw2OZ
	 4hzyBPz+T2o7cfpMhDbMXdNiwBCSnw7jT5BUMaSg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WVgJp1x3pz25K;
	Fri, 26 Jul 2024 10:04:42 +0200 (CEST)
Date: Fri, 26 Jul 2024 10:04:40 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 4/4] documentation/landlock: Adding scoping mechanism
 documentation
Message-ID: <20240726.weu3Ee5aiTha@digikod.net>
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

On Wed, Jul 17, 2024 at 10:15:22PM -0600, Tahera Fahimi wrote:
> - Defining ABI version 6 that supports IPC restriction.
> - Adding "scoped" to the "Access rights".
> - In current limitation, unnamed sockets are specified as
>   sockets that are not restricted.
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

If you look at the generated documentation, you'll see that the `Scope
flags` links are broken, and the related section is missing.  This is
because it should not be "scoped" but "scope" here.

With `make htmldocs` you'll also see that there are formating issues in
this (missing) section.

