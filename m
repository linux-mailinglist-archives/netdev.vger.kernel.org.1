Return-Path: <netdev+bounces-218496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364EB3CB77
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14C71BA4834
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BE248F69;
	Sat, 30 Aug 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JLtQaqfl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297D225417;
	Sat, 30 Aug 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565055; cv=none; b=dF2YS0f09r+GGrnABScdRA0wu5SUfJMXsfw4It898negjjWr1usPTS0iFL1PcDZEEKWpqB0pigX9brYJfyXXk144Pm8YlHJGDhfjk93NNDCnfoCzsMDiB1eN8CCOJU885s+Ld4hvQ+l0s1MNZEUnp/OxqcbXf9lXJ1xqJ2g3BIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565055; c=relaxed/simple;
	bh=gRUiNGjcYOtZLtB6gDWU+koXv68eP3p8d3J4vmPEiUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frPw1CBG5bdXFASFoaLcS1wAwcnEIQNRcbtjIe5EqemyQX+6dWAf8MrJCC/gdPfT3ye9KIbbw+RkWcHRCu9hl2i5yfS+/Ltg+l+/9i+l+0LMF1QULsPRWoaJg53KxB59B+hdCKcRSK6gZUhkP87HO3QTa90bE1pKoogUXokRrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JLtQaqfl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ejELTxLCoQB6YphO8zD3an/XL2N+OQq8r6UF1wGXBDo=; b=JLtQaqflqdxk0EjLmVyZyVsUBf
	QoktZj5V1jrJTfOFRMSc4Bok2g8e4z4b/ljHsGjblJqbkbUMFWf1Zu4j1Ud2ApHEDz35oWp4UwKFB
	QD5LHVuHr6D+xP8UuRoq8tLjlw/HQLqW+lHwCHQA3StqcldTLW3fElKtf42A+tMkoGb4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usMoE-006aHZ-0m; Sat, 30 Aug 2025 16:44:02 +0200
Date: Sat, 30 Aug 2025 16:44:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] r8169: hardening and stability improvements
Message-ID: <e461ef27-a6cf-4ed9-adec-e7d949958df9@lunn.ch>
References: <20250830073039.598-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830073039.598-1-moahmmad.hosseinii@gmail.com>

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9c601f271c02..66d7dcd8bf7b 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3981,19 +3981,39 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  	int node = dev_to_node(d);
>  	dma_addr_t mapping;
>  	struct page *data;
> +	gfp_t gfp_flags = GFP_KERNEL;
>  
> -	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
> -	if (!data)
> -		return NULL;
> +	/* Use atomic allocation in interrupt/atomic context */
> +	if (in_atomic() || irqs_disabled())
> +		gfp_flags = GFP_ATOMIC;

/*
 * Are we running in atomic context?  WARNING: this macro cannot
 * always detect atomic context; in particular, it cannot know about
 * held spinlocks in non-preemptible kernels.  Thus it should not be
 * used in the general case to determine whether sleeping is possible.
 * Do not use in_atomic() in driver code.
 */
#define in_atomic()	(preempt_count() != 0)

You need to explain why you ignored this last line, and why this is
safe in this context. For a change like this, which breaks the normal
rules, you want it in a patch of its own, so the explanation can be in
the commit message and it is then very clear why you are ignoring the
rules.

Looking at the rest of the patch, a lot of the changes are
questionable. Splitting it up will help you describe why you are
making each change, why it is needed.

    Andrew

---
pw-bot: cr

