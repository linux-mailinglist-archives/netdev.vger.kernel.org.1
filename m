Return-Path: <netdev+bounces-125554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A496DAC7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE0B1F23125
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC3419D082;
	Thu,  5 Sep 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NwniwFu7"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ACE19CD19;
	Thu,  5 Sep 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544176; cv=none; b=QEmrYbTYeSjoD2qOizm6hifvP/c1uztNSlr/y3c5GfS6RN87hoY8EOAbjn+lIum44ot4djfQHya09FnlVtLVFP8Uy7td8kqDguub6mOGX54PMul+8tJ/gde73pX5oXi7PG0HpRzoscydBAsgsqnQfoNZYgp7ttWxVo8IhLeeb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544176; c=relaxed/simple;
	bh=YNJnsa/btuGc6/CJi4TG9kvJyf4ybUzj7WJ6SZWiWJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RK4o7hEIC74W/h0RrkKITQOtNJuQKTIbeoXxL3HHYcmlrEajIWHtG+ajlnzVnREuLC2I5a74X9zGKATFecIBYghceFbkVaU6HC5Q/KjG4qt/nx589k2qpa4xAM6AmdYVLozfYaY2G+RLrk5P4Vl3efM8XBDp8eaIw2Hwq0lCxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NwniwFu7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2B5F2000B;
	Thu,  5 Sep 2024 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725544172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTFm93jT7a+pFGtxJtmBVOuv/6BGEr9jKneXAOK6lFE=;
	b=NwniwFu7pbqoesv45nMgSU8oh5sEyo1aUS2Je1dj0pkT1xpmFYJLUdSB002vARvs5a0AIc
	wBAxJjDKbkuz0yHgY/Xlu3IFGbkNGJpWAiBBYi4xIJE2ztXSMLY1hPZIcipw3Otc9H8GuF
	V8/jlpvS2AkSyYq3nNH8GzM7BeR6qLLLJSEKTFU15/RuBjT/bzXcV51eiK8Y2JcuxCH5T+
	KzktvX4Yumd8yf7LR1BXe0c46HIE2slkjtdx/OGy/fVTE8UE2+leoM0bQXt2Fr9cl31u2x
	0DHHK+6a6kCvttqwDqiszOYTxS72VYuR3Rl2aHAH3Eewgi+7Jb7kOPjgk0OCYA==
Date: Thu, 5 Sep 2024 15:49:28 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <linux@armlinux.org.uk>, <kuba@kernel.org>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
 <rdunlap@infradead.org>, <bryan.whitehead@microchip.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V5 4/5] net: lan743x: Migrate phylib to phylink
Message-ID: <20240905154928.18fc7f10@fedora.home>
In-Reply-To: <20240904090645.8742-5-Raju.Lakkaraju@microchip.com>
References: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
	<20240904090645.8742-5-Raju.Lakkaraju@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Raju,

On Wed, 4 Sep 2024 14:36:44 +0530
Raju Lakkaraju <Raju.Lakkaraju@microchip.com> wrote:

> Migrate phy support from phylib to phylink.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
> Change List:                                                                    
> ============                                                                    
> V4 -> V5:                                                                       
>   - Remove the fixed_phy_unregister( ) function. Not require                    
> V3 -> V4:                                                                       
>   - Add the Fixed-link by include the Russell King patch
>   - Change lan743x_phylink_create( ) argument from netdev to adapter
> V2 -> V3:                                                                       
>   - Remove the unwanted parens in each of these if() sub-blocks                 
>   - Replace "to_net_dev(config->dev)" with "netdev".                            
>   - Add GMII_ID/RGMII_TXID/RGMII_RXID in supported_interfaces                   
>   - Fix the lan743x_phy_handle_exists( ) return type
> V1 -> V2:                                                                       
>   - Split the PHYLINK and SFP changes in 2 different patch series                                                                  

Besides what Andrew pointed out, I don't see any obvious problem.

With Andrew's comments taken into account,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

