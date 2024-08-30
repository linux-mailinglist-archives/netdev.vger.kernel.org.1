Return-Path: <netdev+bounces-123779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3829667A7
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7F21C22EFB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707241B8EB3;
	Fri, 30 Aug 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+QTUs++"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C766192D98
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037819; cv=none; b=tI9zBqPTMWJrl8asvQlgQIsly/T/m/iCbYCsJC5yaOqjHHJMm6DLOPeCfdKvVzzJFgHRHMM7oxtZRSdgnqTpWnJFvr/M9JES8uGact4rSryhomoDPIzfl9l1SW/ljn63sEbdv/dkcfoACj9e0it5A+/mcNIG+xZESuxxXQ5RPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037819; c=relaxed/simple;
	bh=n6eFg8086ueMj/VxubD6+dngb11Wnrs+eT3pSs9sUYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kY9sTVYIpAVry1WjJ1JKGF4NJzFiLqrc/OQT5Ru4o4aLWnqnyY2byNCjDVmwqXh9HKDGI7AD6IDYarvX2K//frABvxzDy1rpoSb6UdJ1YQmMdJkfhbk+fcTkdNDiwXegP2DVXbmSfsftX2P9YSevCcV0LZMwh/7H1ON2A904/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+QTUs++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C10AC4CEC2;
	Fri, 30 Aug 2024 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725037818;
	bh=n6eFg8086ueMj/VxubD6+dngb11Wnrs+eT3pSs9sUYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+QTUs++LhFyKp3b0VrVfy44fqcnevliIHa8Js8U7gTNkF+eUGWTn98Oy3vbvWbZA
	 sZN928yyXLpiTVn7s06byqxrUYBjfRigm+UT2QQhdeueFSFRjazQSCmIH86K/tHe9e
	 rOOHe1FGGtgpKDMoXnNOyT9V0XuFZGonT+T9fL4aUhdyOtRNyqdQdHqpcjYdw2b2RA
	 ByALJvWp1A5mJ28TFsiQP91ARkLrzP98p+aWu+gQP1XVC16qMP/WfqIr+ipZc8brKn
	 /sI1KpI/uQ097M4kcSxpso8BdTH90gBSst0n4VVIyXD4MY4hySVVG6c+aWYdxs0cIM
	 cbm9ii/GFuIBg==
Date: Fri, 30 Aug 2024 18:10:14 +0100
From: Simon Horman <horms@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	ndabilpuram@marvell.com
Subject: Re: [PATCH net-next,v2,3/3] octeontx2-af: configure default CPT
 credits for CN10KA B0
Message-ID: <20240830171014.GB1368797@kernel.org>
References: <20240829080935.371281-1-schalla@marvell.com>
 <20240829080935.371281-4-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829080935.371281-4-schalla@marvell.com>

On Thu, Aug 29, 2024 at 01:39:35PM +0530, Srujana Challa wrote:
> The maximum CPT credits that RXC can use are now configurable on CN10KA B0
> through a hardware CSR. This patch sets the default value to optimize peak
> performance, aligning it with other chip versions.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


