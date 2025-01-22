Return-Path: <netdev+bounces-160305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4EA19347
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D5F1662FE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D8213229;
	Wed, 22 Jan 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j45+Wj0b"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F02116FB;
	Wed, 22 Jan 2025 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554752; cv=none; b=S/iCsGDYf3rPc/yI9tPi/SPCYWqycYPq5YcZRPefREMcjKOTntidbjMne2WV2rBno0OiQvHT/5nhn3dvlnc1oXtI4lEW4bbSVOcYB3L+eBQHyG3yPISypoYw53BL/Vyakw7pfXJaz5Zopfabvupp6IjoLRYMw86jV2xoIE8W1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554752; c=relaxed/simple;
	bh=QGqTLHN0Ld1kv3k3DNZC6hbH4yMh+dl8IIleNxcgVMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcuPPCzVvB6BVHWeLOfpBG9Kcgdth2s86ogoLLZ0IEX476qFZrC3yidEmdsLh015eTJexpUIEf0YvXz/w9QGMuxwDx9oBR0mqpzRm2dDehH/kwgLUX1SRRFPIQ4THaTlH4HQsLfb1vztw8Dsgy5EYBbIe4gZGpRtSdMg6Qcy1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j45+Wj0b; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D40F1BF208;
	Wed, 22 Jan 2025 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737554747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6A2D9Gp6FOhIbSWgb9j5UrKEP+ZhUZ+HlhkvNqPm+8=;
	b=j45+Wj0bkZUjkfE2K7uxrujT3U0CBiljadFY9MriVnVTIHNFfsdFA5xnU5ptdu/wlydT4b
	n2vJbfLP+TmM0g0MR4H0vd5fJviqvSdbh8lgC+59TU/F7Kg9mInq2xT1/fXyc8Tympc6pG
	SC1r2wzqeAOGO3MYoRZWhHoz94AxeCf6w7Sg90jqLyrtUdnL1bBgjkNRgxmFFzVSP+iS14
	gMCgNt+ynhl7pYBKfOnoTLNBgl1YBVjuodqnbWHX3XtTAebrVCkdoAeIJFUCtV2Rus55TL
	9HF2d9LlA3ulb67ms7LaA+aWcA3fGjTx4RxCyixqFvkjd/WiVeMYS9QNDhjXUQ==
Date: Wed, 22 Jan 2025 15:05:42 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ninad Palsule <ninad@linux.ibm.com>, Jacky Chou
 <jacky_chou@aspeedtech.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "eajames@linux.ibm.com"
 <eajames@linux.ibm.com>, "edumazet@google.com" <edumazet@google.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
 "robh@kernel.org" <robh@kernel.org>
Subject: Re: =?UTF-8?B?5Zue6KaGOiDlm57opoY6?= [PATCH v2 05/10] ARM: dts:
 aspeed: system1: Add RGMII support
Message-ID: <20250122150542.55d483e6@fedora.home>
In-Reply-To: <c83f0193-ce24-4a3e-87d1-f52587e13ca4@lunn.ch>
References: <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
	<SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
	<8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
	<c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
	<c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
	<SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
	<9fbc6f4c-7263-4783-8d41-ac2abe27ba95@lunn.ch>
	<81567190-a683-4542-a530-0fb419f5f9be@linux.ibm.com>
	<0ee94fd3-d099-4d82-9ba8-eb1939450cc3@lunn.ch>
	<20250122140719.5629ae57@fedora.home>
	<c83f0193-ce24-4a3e-87d1-f52587e13ca4@lunn.ch>
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

> > Can we consider an update in the kernel doc along these lines :
> > 
> > ---
> >  Documentation/networking/phy.rst | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
> > index f64641417c54..7ab77f9867a0 100644
> > --- a/Documentation/networking/phy.rst
> > +++ b/Documentation/networking/phy.rst
> > @@ -106,14 +106,17 @@ Whenever possible, use the PHY side RGMII delay for these reasons:
> >    configure correctly a specified delay enables more designs with similar delay
> >    requirements to be operated correctly
> >  
> > -For cases where the PHY is not capable of providing this delay, but the
> > -Ethernet MAC driver is capable of doing so, the correct phy_interface_t value
> > -should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
> > -configured correctly in order to provide the required transmit and/or receive
> > -side delay from the perspective of the PHY device. Conversely, if the Ethernet
> > -MAC driver looks at the phy_interface_t value, for any other mode but
> > -PHY_INTERFACE_MODE_RGMII, it should make sure that the MAC-level delays are
> > -disabled.
> > +The MAC driver may add delays if the PCB doesn't include any. This can be
> > +detected based on firmware "rx-internal-delay-ps" and "tx-internal-delay-ps"
> > +properties.
> > +
> > +When the MAC driver can insert the delays, it should always do so when these
> > +properties are present and non-zero, regardless of the RGMII mode specified.
> > +
> > +However, the MAC driver must adjust the PHY_INTERFACE_MODE_RGMII_* mode it passes
> > +to the connected PHY device (through phy_attach or phylink_create() for example)
> > +to account for MAC-side delay insertion, so that the the PHY device knows
> > +if any delays still needs insertion on either TX or RX paths.  
> 
> You dropped:
> 
>    For cases where the PHY is not capable of providing this delay...
> 
> This is something i would like to keep, to strengthen that we really
> do want the PHY to add the delays. Many MACs are capable of adding
> delays, but we don't want them to, the PHY should do it, so we have
> consistency.
> 
> The language i've tried to use is that "rx-internal-delay-ps" and
> "tx-internal-delay-ps" can be used to fine tune the delays, so i'm
> expecting their values to be small, because the PHY is adding the 2ns,
> and the MAC is just adding/removing 0-200ps etc. I've also used the
> same terminology for PHY drivers, the PHY DT properties for delays are
> used for fine tuning, but the basic 2ns on/off comes from the phy-mode
> passed to phylib.
> 
> If it is just fine tuning, and not adding the full 2ns, it should just
> pass phy-mode straight through.
> 
> So your text becomes something like:
> 
>   The MAC driver may fine tune the delays. This can be configured
>   based on firmware "rx-internal-delay-ps" and "tx-internal-delay-ps"
>   properties. These values are expected to be small, not the full 2ns
>   delay.
> 
>   A MAC driver inserting these fine tuning delays should always do so
>   when these properties are present and non-zero, regardless of the
>   RGMII mode specified.
> 
> Then we can address when the MAC adds the full 2ns.
> 
>   For cases where the PHY is not capable of providing the 2ns delay,
>   the MAC must provide it, if the phy-mode indicates the PCB is not
>   providing the delays. The MAC driver must adjust the
>   PHY_INTERFACE_MODE_RGMII_* mode it passes to the connected PHY
>   device (through phy_attach or phylink_create() for example) to
>   account for MAC-side delay insertion, so that the the PHY device
>   does not add additional delays.
> 
> I also think we need something near the beginning like:
> 
>   The device tree property phy-mode describes the hardware. When used
>   with RGMII, its value indicates if the hardware, i.e. the PCB,
>   provides the 2ns delay required for RGMII. A phy-mode of 'rgmii'
>   indicates the PCB is adding the 2ns delay. For other values, the
>   MAC/PHY pair must insert the needed 2ns delay, with the strong
>   preference the PHY adds the delay.

Thanks Andrew for the suggestions, your wording is definitely better
than mine :) I'll queue that for when net-next re-opens.

Maxime

