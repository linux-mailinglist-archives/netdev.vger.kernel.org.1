Return-Path: <netdev+bounces-169316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E6CA436EC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FBE16262D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01225B693;
	Tue, 25 Feb 2025 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUN6hIZf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250941A5BBB
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470685; cv=none; b=qZEDFD9gErxc63bK0ZC/NVxESYcXAGohVXNFZA5JDeZGu1lNZJSQFK+BSZUcJC6y+ugM++lbDdtEM2qDXfMCWjFca0+OqfA21rlLGyyYb1jt6EJW7wf1sEmorrToZIHSXI5atEazmju9b7QRWy4H8xhL//UItyblLxvkh5SCH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470685; c=relaxed/simple;
	bh=qwCg9W18tRGNfZNg6vfpzPaVlTT9+BfgxwxHzJyXrDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZogVExkRzoGfOiE3B2lejLX7HbW60VjWnRkJrOdQxvyWX9pQ/HyWop6seaEzTVf2nI6zIQT88zJ588/kJjyLFT1po97zkgrTP/iStrcFqluP4rpStzGstS7t6mQsX8UdtTtOjByUrwZpHMQe2hQfi0qcpLoztLXKDV6l3zGx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUN6hIZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045F1C4CEDD;
	Tue, 25 Feb 2025 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740470684;
	bh=qwCg9W18tRGNfZNg6vfpzPaVlTT9+BfgxwxHzJyXrDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUN6hIZfATP0EtUBQ5MUlZFQQzW9Mpf3k5oL50QsKGPA99UZvtj+EtdpIGoO/RScP
	 EGHyS7i1a/IEY2+hhjrh33k1C9Gf0uy7NF/+ZrmJ3DiD+rP82dRfQ0HZyIH0Y1LOAM
	 bOxTT9Yn+OlSaPS0rcHbpk7O+5E43/pzHPdcuNkqhMmWjymQOVweY0bE1bhcIXRnTT
	 glVi7Gr13gCGWNlbrUwDam5d3Kt0hnD8okd5/Ghf0qEJvlFw9c/oQRxeO6Pu6zJ/j2
	 2F5Ri+awfsNVtKqg9zx/m7d/bMok67UKU3Zw2sLYIS9zM1vCGmppjX20xFqWkjwjlJ
	 fn7T9fsHDPu3Q==
Date: Tue, 25 Feb 2025 10:04:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH ipsec-next] xfrm: remove hash table alloc/free helpers
Message-ID: <20250225080440.GE53094@unreal>
References: <20250224171055.15951-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224171055.15951-1-fw@strlen.de>

On Mon, Feb 24, 2025 at 06:10:50PM +0100, Florian Westphal wrote:
> These functions predate kvmalloc, update xfrm to use that instead.
> This also allows to drop the 'size' argument passed to xfrm_hash_free().
> 
> xfrm_hash_free() is kept around because of 'struct hlist_head *' arg type
> instead of 'void *'.

<...>

> -struct hlist_head *xfrm_hash_alloc(unsigned int sz);
> -void xfrm_hash_free(struct hlist_head *n, unsigned int sz);
> +static inline struct hlist_head *xfrm_hash_alloc(unsigned int sz)
> +{
> +	return kvzalloc(sz, GFP_KERNEL);
> +}
>  
> +static inline void xfrm_hash_free(struct hlist_head *n)
> +{
> +	kvfree(n);
> +}

Sorry, what does this wrapper give us?
You are passing pointer as is and there is no any pointer type check
that this construction will give us.

I would say that there is no need to hide basic kernel primitives
like kvzalloc and kvfree, and better leave them as is without wrappers.

The change itself looks good,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

