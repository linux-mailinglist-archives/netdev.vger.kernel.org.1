Return-Path: <netdev+bounces-210207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A677B12627
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9982189F1F7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736AA24E01F;
	Fri, 25 Jul 2025 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DufsnYNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CA242910;
	Fri, 25 Jul 2025 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479556; cv=none; b=lGp3154xjUWDDBxE/JcS7RLtqGJY8/KVvdu4YKOmpIiezqTg8GUjAQ7YPdemFNtyJsrjwI3m3HWXhEywdtddHb9I7lzLwPEqjM+DMNSac/ajEg/NE62pI4v489N8KYx0tsYcgXphmmgEyv8T8uWHAOi+tGj9Hk4UCwkPPOWwYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479556; c=relaxed/simple;
	bh=s855RP0ntxcRIelDWLEqT1FhFHtsOA0rt3kzJy72HbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLlhz0UbJVaEzv76gLlqbXuIxyPNDPVvYUER/5N2SCZl1V8SUQa6cKu+lKKWvxygD2XhnMnegXuojAQacd2EoEts+zmU+nsiDRIy9p7Z46IZ00jXE/f0sXxp8xUSmkNdVtd7Xyrk3SF8qqCKdaGh+gI7OngpRpO4YH/N+xvc6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DufsnYNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB5AC4CEEF;
	Fri, 25 Jul 2025 21:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753479555;
	bh=s855RP0ntxcRIelDWLEqT1FhFHtsOA0rt3kzJy72HbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DufsnYNS2gzeiVrOivkaBRbIEV9itq//bQgJzZcMZ52lT6e8rhgOY8WKoulIXB4i1
	 tSMY89RVvj2xkEr+yEACk1pwPjvQYYJ5KWb2WPpngGqCd0MpTJBalwt47vrNpRuddz
	 WDXRqR2KYYZaEJHdy9sagWebAcVdl03yGy9eiel5wdG2C8vILk8qeW2i4vHZm2qpDK
	 K7AQJ4/X0xT20mbom+NU9at/mhwJnkodiQxjBGzuklYD3bb7X4ML4ljxzxA6bf98xC
	 oxpCKnM9wNr5G28loQfT3HOipeBieo2SRY8z7iTuehtL+t+QZ0fKf1kcKhg3H6LIM/
	 7BbFeTRnQKvcA==
Date: Fri, 25 Jul 2025 14:39:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Tomasz Duszynski <tduszynski@marvell.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [net PatchV4] Octeontx2-vf: Fix max packet length errors
Message-ID: <20250725143914.696316b8@kernel.org>
In-Reply-To: <20250724070623.2354509-1-hkelam@marvell.com>
References: <20250724070623.2354509-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 12:36:22 +0530 Hariprasad Kelam wrote:
> @@ -2165,6 +2166,8 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
>  	/* Check for minimum and maximum packet length */
>  	if (skb->len <= ETH_HLEN ||
>  	    (!skb_shinfo(skb)->gso_size && skb->len > pf->tx_max_pktlen)) {
> +		dev_stats = &pf->hw.dev_stats;
> +		dev_stats->tx_discards++;
>  		dev_kfree_skb(skb);
>  		return NETDEV_TX_OK;
>  	}

This is a multi-queue device and the counter is per device.
The counter should really be an atomic_long_t, to avoid races.
-- 
pw-bot: cr

