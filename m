Return-Path: <netdev+bounces-199395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E823DAE025D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E559173238
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7749221DBA;
	Thu, 19 Jun 2025 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw8fQG17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E1221D93;
	Thu, 19 Jun 2025 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327602; cv=none; b=Z6HavYrFiSXUTE6FC7l/TBBTXzt+cc9/hlVgtUq3FyE8ynHEFXC1D6GvalxYhIAK5LluTyTncMlZd538k12ayZSnuZ9ulWNwHG3sZ1Wq6zHqfnacKA6GPrcLZb2ILB981aaGHu3/xG4yYlnT/pzBRLs/PfU9De6o0BUsVtVdiXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327602; c=relaxed/simple;
	bh=n6ybjKDazxybQ2i7xjzgJ9xiqJaoh5bYSS7ARBO4LNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNUoyzcQlupnrO3YLVIILf8mLZGztLohHi9ti3nLdeAihP8KOK9JngaU8x0Kmx/DWstKH3X4r1UP1savp67OQCAydg+vkKYWpptZJNdwHAnz7Nf8b4m5X3po6smXs+wwHaOcG6akkEMm8k5W3YIvU1nL4X8CaqcdOAX+4SZ8Hv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw8fQG17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B2BC4CEED;
	Thu, 19 Jun 2025 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327602;
	bh=n6ybjKDazxybQ2i7xjzgJ9xiqJaoh5bYSS7ARBO4LNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rw8fQG17fdcWZA22467uefTegZP7T8sr/L/0ZkZAtyiz+I/WMNb4/1LaRL/2sJiHS
	 BxJrxu5qxa8Hho3F7dtQa1Bq3FBHkW4OxJoij/kz6r5AcTM4veu2tQH1br+h/RpYTC
	 zEaDAIXaTGc5N41t8NpeRrnHXmWLWGPsYGAbBHAQn5INIBwmVEUTEWYmkUFg9E1xVZ
	 vL5MvudhhNxeTNuHPJJBfKC6e+pOh2DkOav0btDOHUszzUPtEzuGfSc56yT0I9BngK
	 rUez2bf6GzV+9eiLpHYpFlGQBOkGGt8Iofd77GC5XtCTmnHNo7Fdk48hLiXZSQydbS
	 hdnd1dkeLROuA==
Date: Thu, 19 Jun 2025 11:06:36 +0100
From: Simon Horman <horms@kernel.org>
To: Himanshu Mittal <h-mittal1@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
	m-malladi@ti.com, pratheesh@ti.com, prajith@ti.com
Subject: Re: [PATCH net-next v3] net: ti: icssg-prueth: Add prp offload
 support to ICSSG driver
Message-ID: <20250619100636.GD1699@horms.kernel.org>
References: <20250618175536.430568-1-h-mittal1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618175536.430568-1-h-mittal1@ti.com>

On Wed, Jun 18, 2025 at 11:25:36PM +0530, Himanshu Mittal wrote:
> Add support for ICSSG PRP mode which supports offloading of:
>  - Packet duplication and PRP trailer insertion
>  - Packet duplicate discard and PRP trailer removal
> 
> Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>
> ---
> v3-v2:
> - Addresses comment to fix structure documentation
> 
> v2: https://lore.kernel.org/all/20250618102907.GA1699@horms.kernel.org/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


