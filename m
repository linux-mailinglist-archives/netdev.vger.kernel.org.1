Return-Path: <netdev+bounces-122983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111AA96355F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01DE1F24084
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC711AD9F4;
	Wed, 28 Aug 2024 23:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC071AD9D0;
	Wed, 28 Aug 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887584; cv=none; b=aipw1iDTPmBxpcRgOecSDECnkrB9LzPlbMdMehJrbYCmQf131SU2QeOo01CQUjYwx13mW0tlYy9HIjAkDKJcWRxdPFJCT+gn6KpvEWy2BPsYowBPiyffLHCzPPC/HA/+6W3Bnw/cIYsqHIqkQNEUHrQC/xNal+CmI1hRbbGbqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887584; c=relaxed/simple;
	bh=ZmBX1i/gzUBKDT7MneBIjVFqHHioZEbAtq4Zuxn30KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ2s6gKQxHu7Yv7SD/bnz4DHoDIwjMC9GD05x1WakPBtHmjKXZiA+tslvTMnL9C0Xt0uy/4hyYTwErbAo8CVCnCGif65kSUvjph8djjpBRUviDy6Wpr07pFDZDM5P7M/UMrABAe3Z/74Bd8WFUVgr2FTiO5vWBq5R8sTTAclHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sjS3L-000000000Xz-21Lc;
	Wed, 28 Aug 2024 23:26:15 +0000
Date: Thu, 29 Aug 2024 00:26:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: aquantia: allow forcing order
 of MDI pairs
Message-ID: <Zs-yECtQO8kKafAQ@makrotopia.org>
References: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>
 <e56a9065f50cd90d33da7fe50bf01989adc65d26.1724885333.git.daniel@makrotopia.org>
 <afca2465-3e42-4bf1-8f07-13e15e9ed773@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afca2465-3e42-4bf1-8f07-13e15e9ed773@lunn.ch>

On Thu, Aug 29, 2024 at 01:05:00AM +0200, Andrew Lunn wrote:
> On Wed, Aug 28, 2024 at 11:52:09PM +0100, Daniel Golle wrote:
> > Despite supporting Auto MDI-X, it looks like Aquantia only supports
> > swapping pair (1,2) with pair (3,6) like it used to be for MDI-X on
> > 100MBit/s networks.
> > 
> > When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
> > come up with pair order is not configured correctly, either using
> > MDI_CFG pin or using the "PMA Receive Reserved Vendor Provisioning 1"
> > register.
> > 
> > Normally, the order of MDI pairs being either ABCD or DCBA is configured
> > by pulling the MDI_CFG pin.
> > 
> > However, some hardware designs require overriding the value configured
> > by that bootstrap pin. The PHY allows doing that by setting a bit in
> > "PMA Receive Reserved Vendor Provisioning 1" register which allows
> > ignoring the state of the MDI_CFG pin and another bit configuring
> > whether the order of MDI pairs should be normal (ABCD) or reverse
> > (DCBA). Pair polarity is not affected and remains identical in both
> > settings.
> > 
> > Introduce two mutually exclusive boolean properties which allow forcing
> > either normal or reverse order of the MDI pairs from DT.
> > 
> > If none of the two new properties is present, the behavior is unchanged
> > and MDI pair order configuration is untouched (ie. either the result of
> > MDI_CFG pin pull-up/pull-down, or pair order override already configured
> > by the bootloader before Linux is started).
> > 
> > Forcing normal pair order is required on the Adtran SDG-8733A Wi-Fi 7
> > residential gateway.
> 
> Is there an in-tree dts file for this? We like to see that options
> which are added are actually used.

I planning to submit DTS for all the Adtran 8700 series once the
MediaTek MT7988 SoC Ethernet is fully supported. At this point I'm still
waiting for feedback on how to organize the PCS drivers for that SoC,
see https://patchwork.kernel.org/comment/25954425/

