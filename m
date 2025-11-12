Return-Path: <netdev+bounces-237988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982A0C527B0
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5122D3A3044
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02633358C3;
	Wed, 12 Nov 2025 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0uvMUYbc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A0307AD1;
	Wed, 12 Nov 2025 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953611; cv=none; b=UN7V1IxntZbHzjhPka80WX2MmiUpFTkfIiWoFyU+d0YlV4P1lb/2YQ4zgh3Cx5jHW8T75Yy76LMcUGA9JfYuZFvAoeWkzIQELKoRp+7sBX+MjKf1TUNFAjEHcdFyFyaZcOcWZuS2MMc5U+52BRJcfQwcrPgI5EBFY4Cve7eK5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953611; c=relaxed/simple;
	bh=BZpnM5upHTZ7qUgZkigoHN2kYvZMnoyTTsUw6eJIxdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5qFc2C1dxmIsS8jNkADpnsXPd1pbaIHNKGo0/R/3r2HSedGRtAQd2EA8B425qrimqM7h6HH++IXHJxg4oHF0X72JUY6KMIBjEzk0E9ssDOhzWuEg/x+3FvzqSLbY7FFcMInCg/MJ3cErB7IRZ4N+LefHNu1brSMI5079cSp3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0uvMUYbc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xu5J2YUVmO+KaIFCwe3YTQ+9UN97u6v/RSU7wP6bNI8=; b=0uvMUYbckaKxc9ZGTp6DGbg3YN
	LALnRa7NcqVeGPt4nB5iXP1V4HqFy8LBFW7/xewuahRQ+6gPCw2f4WaEhI9ijAyzq6xNrwf7/E+M8
	UvW05os7ZPsFzkNKwfIlPDFicG82Pb+eeBdJi4Lf92Ogx+Yp8YwTCJ6bJaypmP2LJ6A0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJAl1-00DkSt-Dv; Wed, 12 Nov 2025 14:19:31 +0100
Date: Wed, 12 Nov 2025 14:19:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>

> > This is an optional property. If it does not exist, you have an old DT blob. It is
> > not an error. So you need to do different things depending on what the error
> > code is. If it does not exist, just return 0 and leave the hardware alone. If it is
> > some other error report it, and abort the probe.
> > 
> 
> Based on this for next version, I want to move the "aspeed,scu" from dtsi to dts.
> Change it to optional and accord it whether existed to decide it is old or new DT 
> blob.

I think that is the easy way out, not necessarily the correct way.

All systems have the aspeed,scu, so it should really be in the .dtsi
file.

What are you really trying to solve? That the DT blob says "rgmii",
but the bootloader has configured the MAC to add delays? You should be
able to test for that condition. If it is found, issue as warning, and
treat phy-mode as 'rgmii-id'. If the DT blob says 'rgmii-id' and the
MAC is configured to add the delays, the system is at least
consistent, no need for a warning, disable the MAC delays and pass
_RGMII_ID to the PHY. And if the blob says 'rgmii-id' and the MAC is
not adding delays, no need to touch the MAC delay, and pass _RGMII_ID
to the PHY.

Are there any mainline DT .dts files which say rgmii-txid, or
rgmii-rxid? They would be rather odd, but occasionally you see them.
Assuming there are not lots of them, i would probably just leave
everything as is.

	Andrew

