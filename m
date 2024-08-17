Return-Path: <netdev+bounces-119358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7142D9554EB
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF351F225A2
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 02:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA310A0D;
	Sat, 17 Aug 2024 02:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR7YHaDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB0138E;
	Sat, 17 Aug 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723862526; cv=none; b=MnFq9gB5/JuOoEzeDd62pBgjGGa011QQli/NTmVAGjypd2XvJoxFVoK/i4DZH9bSbTkp0yw3duCFzxK+BrNYBDr18pYqdGLUsttkQtxgJIIt7RLW5EkD48ucwWJQxyCDr6/iUOqYm7xv73iSukwXPd6M8hQm578YFiU/CPHQBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723862526; c=relaxed/simple;
	bh=l7c+tqqb/MEMAkjLmzruqEhMtkaDk2Uid0ORzOuA0pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIq3J1HSc2uesHmGjsML3y+Ry4cI6FSMezyEcfKeRxNGAYXwDaHnh4wgvjAfQZ37zPQpDcMkoZlxt6br9OOpBiiE6VTaabtmjr7YatWEOj4UcYENJmrJUgzLmDWpVrkXsAqPN227BX9X5390Xmv8Ndp0huAQerG8Gmg99BAMS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR7YHaDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA13C32782;
	Sat, 17 Aug 2024 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723862525;
	bh=l7c+tqqb/MEMAkjLmzruqEhMtkaDk2Uid0ORzOuA0pQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JR7YHaDDV54RwgDhRgPYtrLdn9l/cl37v5X6Y/SlZK+vFMqYVEAOf54T/p+U36vOh
	 wYFIrZQ9LuJ76TY1uCOop/pHo1JdqkBGMFWTLhbV1u2s4yZYAZXNBDSAcA2RKU6K3H
	 86CtTBcDJRVAaAIoFwTn38VZ0CTrB/E+ShlB3abihR3b0th0/R2VKebda/AAUSGgRe
	 fRMzbVYrQN8+s2NFkuapeRTHw/YjOAyWHTTSWA5FaT3e5lk4CnQhrZeaujqz141wpI
	 /4T6fjvECkecteMx9VtL5OifkNLvM3i11G7o4E3Y8NUQ7FpLiEPx0sXmcI6VGD6S/j
	 ujgzu01UjaX7Q==
Date: Fri, 16 Aug 2024 19:42:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] net: xilinx: axienet: Add statistics
 support
Message-ID: <20240816194203.05753edf@kernel.org>
In-Reply-To: <20240815144031.4079048-3-sean.anderson@linux.dev>
References: <20240815144031.4079048-1-sean.anderson@linux.dev>
	<20240815144031.4079048-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 10:40:31 -0400 Sean Anderson wrote:
> +	u64 hw_stat_base[STAT_COUNT];
> +	u64 hw_last_counter[STAT_COUNT];

I think hw_last_counter has to be u32..

> +	seqcount_mutex_t hw_stats_seqcount;
> +	struct mutex stats_lock;
> +	struct delayed_work stats_work;
> +	bool reset_in_progress;
> +
>  	struct work_struct dma_err_task;
>  
>  	int tx_irq;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index b2d7c396e2e3..9353a4f0ab1b 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -519,11 +519,55 @@ static void axienet_setoptions(struct net_device *ndev, u32 options)
>  	lp->options |= options;
>  }
>  
> +static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
> +{
> +	u32 counter;
> +
> +	if (lp->reset_in_progress)
> +		return lp->hw_stat_base[stat];
> +
> +	counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> +	return lp->hw_stat_base[stat] + (counter - lp->hw_last_counter[stat]);

.. or you need to cast the (counter - lp->...) result to u32.
Otherwise counter's type is getting bumped to 64 and you're just doing
64b math here.

> +}
> +
> +static void axienet_stats_update(struct axienet_local *lp, bool reset)
> +{
> +	enum temac_stat stat;
> +
> +	write_seqcount_begin(&lp->hw_stats_seqcount);
> +	lp->reset_in_progress = reset;
> +	for (stat = 0; stat < STAT_COUNT; stat++) {
> +		u32 counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> +
> +		lp->hw_stat_base[stat] += counter - lp->hw_last_counter[stat];
> +		lp->hw_last_counter[stat] = counter;
> +	}
> +	write_seqcount_end(&lp->hw_stats_seqcount);

