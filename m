Return-Path: <netdev+bounces-240161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0306EC70EB6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7351C343A81
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD501366DCB;
	Wed, 19 Nov 2025 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x7aTNYss"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7E371DC5;
	Wed, 19 Nov 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582005; cv=none; b=GtAwuvYBIXs3abgw8TOSdywdVDoUXK9VHzNdnCr+LMCfnsVLQaDyJv37fRsIMHb1Kf9czr3M9EtxjNo5WevaTc21AC2uNf6Jh6vZu8o6x/NPqxpAbE6iDyMxnpvsOjhiSyP9EkuaZqwf0Y4lxsMvVY7YuEM5BusKC0NGj/BKwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582005; c=relaxed/simple;
	bh=HL48sP4Xb6zrvLbsLGKA44KV6tQWp6ekwH4IaDpvlBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGaizhOxbAzaZRL9FKus5KX2x1QaHE9u9ihQXoRsRTX3TGquxZc8wkvtQDFuTnlmgUL6i6qLmS4GrF358lKrpEv31odYkEKYlaHGYgUMxm9kWVhpMCg97WEx0S1hDV8btZ6pSrJi2Y0Mh+yY19c0FDPOY4ODejhnSQeM4DxnL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x7aTNYss; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aWO5KrFQkBjGbqWq3opM1WzP8ZAtbN7r9Kz3p3ON6nA=; b=x7aTNYssYFyN4yBC3IRuHII8y8
	6qaX3WQA77mUmw58FnanspgKC9RnduoXABfiCHicmRz+SiJydCt7aw1jth2Z/KJtTHsIT3z6gcYr+
	Q+sB7gEFI78ee5jCWuJrZm5/N+zz794pfwcgLdZTvHPJ2wrMgt/tjyXJccaT8aOHLU5g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLoEn-00EXoe-2A; Wed, 19 Nov 2025 20:53:09 +0100
Date: Wed, 19 Nov 2025 20:53:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: lan966x: Fix the initialization of taprio
Message-ID: <ffa6ba0a-750e-4281-826d-f56c4f5ea433@lunn.ch>
References: <20251119172845.430730-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119172845.430730-1-horatiu.vultur@microchip.com>

> +#define LAN9X66_CLOCK_RATE	165617754

You add a #define

> +
>  #define LAN966X_MAX_PTP_ID	512
>  
>  /* Represents 1ppm adjustment in 2^59 format with 6.037735849ns as reference
> @@ -1126,5 +1129,5 @@ void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
>  u32 lan966x_ptp_get_period_ps(void)
>  {
>  	/* This represents the system clock period in picoseconds */
> -	return 15125;
> +	return PICO / 165617754;

and then don't use it?

	Andrew

