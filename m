Return-Path: <netdev+bounces-167779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D40CA3C3AC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B047A58B1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1781F463D;
	Wed, 19 Feb 2025 15:30:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D51E3DE5;
	Wed, 19 Feb 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979046; cv=none; b=N5W1q3DZtLTtpwvtyIny28gyu0OBB2P0S9isrAIdWubpD4FACSDeoKAAIQT33BVs1gUO7cLbagqj+4JxTnVQ64wJXTLoUESAQlh/JH2Okmud5CMMtRhx2QzbrdZdi62gCdgnS1wbbaH+IVh6CamGI6Ur3gc7vSLpOIEHzI5mm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979046; c=relaxed/simple;
	bh=i6P248GcdM52UmE54vdAeMVf7Z015Qxcro/CvG4KqiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3C3h+6fhMBrWZorLe0BHwDetpt3ZrE5Isw5/zzBfswQqfVkfGyYzFv3WdNa4Ogy1EJeCXdZZttLehn4GaN0jYHRSfNHN5rgq3WhpK4aSrgamxyotZVGfhCU2CxZMN8pxok3MZ27XxMuJhTplHpeOawdWmxalwoOv+fpHFpIrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tkm1p-000000000at-2efA;
	Wed, 19 Feb 2025 15:30:25 +0000
Date: Wed, 19 Feb 2025 15:30:22 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Message-ID: <Z7X5Dta3oUgmhnmk@makrotopia.org>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>
 <a15cfd5d-7c1a-45b2-af14-aa4e8761111f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a15cfd5d-7c1a-45b2-af14-aa4e8761111f@lunn.ch>

On Wed, Feb 19, 2025 at 04:26:21PM +0100, Andrew Lunn wrote:
> > +description: |
> > +  MediaTek Built-in 2.5G Ethernet PHY needs to load firmware so it can
> > +  run correctly.
> > +
> > +properties:
> > +  compatible:
> > +    const: "mediatek,2p5gphy-fw"
> > +
> > +  reg:
> > +    items:
> > +      - description: pmb firmware load address
> > +      - description: firmware trigger register
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phyfw: phy-firmware@f000000 {
> > +      compatible = "mediatek,2p5gphy-fw";
> > +      reg = <0 0x0f100000 0 0x20000>,
> > +            <0 0x0f0f0018 0 0x20>;
> > +    };
> 
> This is not a device in itself is it? There is no driver for this.
> 
> It seems like these should be properties in the PHY node, since it is
> the PHY driver which make use of them. This cannot be the first SoC
> device which is both on some sort of serial bus, but also has memory
> mapped registers.

I'm afraid it is...

> Please look around and find the correct way to do this.

Would using a 'reserved-memory' region be an option maybe?

