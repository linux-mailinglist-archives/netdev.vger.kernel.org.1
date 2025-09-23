Return-Path: <netdev+bounces-225559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4753EB95686
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80B17A8E44
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385C31986C;
	Tue, 23 Sep 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idLUPQO5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B4314B9F;
	Tue, 23 Sep 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622501; cv=none; b=AjU9KX9wH/2zKC6gYPInBkruS1k7cKFNTKulhhzaiIUIM88IS8lJJwzY122OoM/TLFcWtTIl2IVsj6oEsvC7GqdFpN4vqOK8/SBgnOuF4KT67YWu9B/h7DSOZ0CWNigRIDX/VySdbi+95DhNnHgFrSivIQShrOZvI0Vxkhr1Ygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622501; c=relaxed/simple;
	bh=haIgKpIb9Hk/Q1wLL+iSp51Y1PBWW5slpEGTrR7W4rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gppI/Q3D02Y549k7Bwxl9UaR9cBNGwY7pMg7PpTqzsO5SNWo4xSlRYCrJM0FSjbrSBOU64LLwOxBgRzCbKNdGcxwksrVX57tLUsce9sUY0htnXl4K5Qb6pdo71eg3rFqCTjuaqWs5aHybrr+9wdHI//aA6HFaY6D/rZdEJ8DPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idLUPQO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E24EC4CEF5;
	Tue, 23 Sep 2025 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758622500;
	bh=haIgKpIb9Hk/Q1wLL+iSp51Y1PBWW5slpEGTrR7W4rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idLUPQO5O+g8WXvVjxYzr8x6sRiVmXVPk8CdrHKOl/BhNB9sVmPj3Jk3vw3Vem6/k
	 eXcF1W4YRsukJa76+xwk1OQq0mZWZOgQlNH4Eh/Sby4IDjNDsnr5VEn1wVAdfvzY0A
	 5wngYj1eN4X5tm9iig0cZCC4ss4W6rwQ4vH5OmpjU65OxC+bbOj9JsPkN3OjJiauaU
	 1pg/LnJUMWdCOqqBvzXnDsUlg26W7QF5zXKMmnN++Ne3s6XbDdPoYsyWqtL7ViOVsT
	 ysrlruJcyPXG7VCH52lVmJYpIh5377XIw1S44Ph+JADvHa0YE1fjT//v8QcP+a6zhe
	 pLeHcXtdeCnSg==
Date: Tue, 23 Sep 2025 11:14:56 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next 2/3] net: dns_resolver: Move dns_query()
 explanation out of code block
Message-ID: <20250923101456.GI836419@horms.kernel.org>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
 <20250922095647.38390-4-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922095647.38390-4-bagasdotme@gmail.com>

On Mon, Sep 22, 2025 at 04:56:47PM +0700, Bagas Sanjaya wrote:
> Documentation for dns_query() is placed in the function's literal code
> block snippet instead. Move it out of there.
> 
> Fixes: 9dfe1361261b ("docs: networking: convert dns_resolver.txt to ReST")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks, this renders much better. In a browser at least.

I've added a few comments below.

> ---
>  Documentation/networking/dns_resolver.rst | 45 +++++++++++------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
> index 5cec37bedf9950..329fb21d005ccd 100644
> --- a/Documentation/networking/dns_resolver.rst
> +++ b/Documentation/networking/dns_resolver.rst
> @@ -64,44 +64,43 @@ before the more general line given above as the first match is the one taken::
>  Usage
>  =====
>  
> -To make use of this facility, one of the following functions that are
> -implemented in the module can be called after doing::
> +To make use of this facility, the appropriate header must be included first::

Maybe: ..., first linux/dns_resolver.h must be included.

>  
>  	#include <linux/dns_resolver.h>
>  
> -     ::
> +Then you can make queries by calling::

Please use imperative mood:

Then queries may be made by calling::

>  
>  	int dns_query(const char *type, const char *name, size_t namelen,
>  		     const char *options, char **_result, time_t *_expiry);
>  
> -     This is the basic access function.  It looks for a cached DNS query and if
> -     it doesn't find it, it upcalls to userspace to make a new DNS query, which
> -     may then be cached.  The key description is constructed as a string of the
> -     form::
> +This is the basic access function.  It looks for a cached DNS query and if
> +it doesn't find it, it upcalls to userspace to make a new DNS query, which
> +may then be cached.  The key description is constructed as a string of the
> +form::
>  
>  		[<type>:]<name>
>  
> -     where <type> optionally specifies the particular upcall program to invoke,
> -     and thus the type of query to do, and <name> specifies the string to be
> -     looked up.  The default query type is a straight hostname to IP address
> -     set lookup.
> +where <type> optionally specifies the particular upcall program to invoke,
> +and thus the type of query to do, and <name> specifies the string to be

I think while we are here "to do" could be removed.
But maybe that's just me.

> +looked up.  The default query type is a straight hostname to IP address
> +set lookup.

...

