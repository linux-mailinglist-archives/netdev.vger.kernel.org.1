Return-Path: <netdev+bounces-194005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41BAC6C5C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496777A1A86
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D458728B4F0;
	Wed, 28 May 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZo/eUFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA2262A6
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444273; cv=none; b=sc+Os+mA1jtKll1xW/017P60d3zR6Zh3XzubW8D4Sr33avOgmoI58vY1l6B+ZMhjq3oUGENxpt3yRAqO4A1dBzrFb/Xr520MuXEh6hvAbb0NAiZpBbTQVoKIrgqqLiz+OXkVjVVh2/9WK8GyBVS4YpAzu3sMFlydShg2qCAQ9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444273; c=relaxed/simple;
	bh=+ScAOwNKixj8SgPeJAjsOR4DVpMbOze3hpapLJbzoh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbcQh2bsoV3uV/TtSIzXbGvqTv2gsTPPCCRKsFfYSAOVoCU5DoSl8BNE7UONKZ11JnyYuUzT/wG+S6SA0eTowhXyvQd815ME/bb0WB6mLUxqka8PYOdm214DophzDaAkWk5l3MVHi6EhNtnVkh2rIBpFzww7yE9bWU3JMAKJ24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZo/eUFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AAAC4CEE3;
	Wed, 28 May 2025 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748444273;
	bh=+ScAOwNKixj8SgPeJAjsOR4DVpMbOze3hpapLJbzoh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZo/eUFRxkfz8rdrf8PgwC74bQrhmh9Vef4pDM+GfeZvlbavX8HThyZoDtT5XztI2
	 M4Ps6BGx4ECtcjoblMs4vUsMTJDMI0vnIwiEeqwMFeGjBm+7cyzk4XItKjTPKD4ljf
	 YjFWz5+RRAfAZs9QPptOgSGeap4FolIVXlvHswmCMCisFET3hWLIXrwXKQXTxJ+JUY
	 Kzya6vi4ZtpHGFHY0QXC9bQ3z3l6kvv7KTYBCJmvVDwpKDSM8gSvCqXi/ii0YBfHF5
	 I2hU3i97lPzNRKUvmyiPdCHtG8MrpBS4i9aKTTeAvQ0kxPCaFcP4HfVL/mL+aCcEGI
	 Qx9pYYKmWCbuw==
Date: Wed, 28 May 2025 15:57:47 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saikrishnag@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
	lcherian@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [net PATCH] octeontx2: Annotate mmio regions as __iomem
Message-ID: <20250528145747.GA1484967@horms.kernel.org>
References: <1748409327-25648-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748409327-25648-1-git-send-email-sbhatta@marvell.com>

On Wed, May 28, 2025 at 10:45:27AM +0530, Subbaraya Sundeep wrote:
> This patch removes unnecessary typecasts by marking the
> mbox_regions array as __iomem since it is used to store
> pointers to memory-mapped I/O (MMIO) regions. Also simplified
> the call to readq() in PF driver by removing redundant type casts.
> 
> Fixes: 98c561116360 ("octeontx2-af: cn10k: Add mbox support for CN10K platform")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks Subbaraya,

As per my comment on [1], I wonder if this is more of a clean-up
for net-next (once it re-opens, no Fixes tag) than a fix.

[1] Re: [net v2 PATCH] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro 
    https://lore.kernel.org/netdev/20250528125501.GC365796@horms.kernel.org/T/#t

...

