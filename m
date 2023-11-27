Return-Path: <netdev+bounces-51360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED867FA522
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3EB2816A9
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2B734561;
	Mon, 27 Nov 2023 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n9iaFImX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951AFBE;
	Mon, 27 Nov 2023 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=svOT1Ab/ZzY/i1DkMPg/q3PvUAlQ9TMeZEgdR1xeIck=; b=n9iaFImXGrlemMfVNe1O1oYwG+
	m2MiS3GRpBOlJMg3MBA6xyk7/IJBnTv6BKn+fcSGug/QQKY8w10C6MXHGWzI6Lu4v0rmU9Bg2u4os
	C9fpQsKfkFALcRzeGWLajGLy6lVynVQ0sv+Yl5HyuYUUnUX67WhMv4YEMj2OvBS1wZICYjx+Hb9jz
	/nTFc4am1zkaVS1l4PHTZMH+uiI0l2MR+xa+0v2AisBrVREmkLJNJ47QApNSRkW+HANCHhROxmXuU
	TuIQQj2RDf8aUlixNL95cSJL9z10RUyyu5tt9bks9VRLXSslLcbVx8Ddyr+NISk+uCJJ8yTxa3rBm
	TmczTHNA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46976)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r7dpn-00066b-0L;
	Mon, 27 Nov 2023 15:47:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r7dpn-000223-1L; Mon, 27 Nov 2023 15:47:43 +0000
Date: Mon, 27 Nov 2023 15:47:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 5/8] dt-bindings: net: pcs: add bindings for MediaTek
 USXGMII PCS
Message-ID: <ZWS6Hl2tZ0MPj+OL@shell.armlinux.org.uk>
References: <cover.1699565880.git.daniel@makrotopia.org>
 <2dff6aff7006573d3232ec2ddd93c1792740d4d3.1699565880.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dff6aff7006573d3232ec2ddd93c1792740d4d3.1699565880.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 09, 2023 at 09:51:47PM +0000, Daniel Golle wrote:
> MediaTek's USXGMII can be found in the MT7988 SoC. We need to access
> it in order to configure and monitor the Ethernet SerDes link in
> USXGMII, 10GBase-R and 5GBase-R mode. By including a wrapped
> legacy 1000Base-X/2500Base-X/Cisco SGMII LynxI PCS as well, those
> interface modes are also available.

I think this binding is based on the implementation than on hardware.

What I believe you have is this setup:

        .---- LynxI PCS ----.
MAC ---+                     +--- PEXTP --- world
        `--- USXGMII PCS ---'

You are representing the PEXTP as a separate entity in DT, but then
you're representing the LynxI PCS and the USXGMII PCS as a single
block, which seems to be how you've decided to implement it.

Given that the LynxI PCS is already in use elsewhere in the Mediatek
range, I suggest that the LynxI PCS is one block of IP, and the USXGMII
PCS is a separate block of IP.

1) Would it not be better to model the two PCS seperately?

2) The addition of the SGMII reset needs more information - is this
   controlling a reset for the LynxI block? If so, it should be part
   of a LynxI PCS binding.

3) The PEXTP is presumably a separate block which can be shared between
   several devices - for example, the LynxI, USXGMII, and probably SATA
   and PCIe as well. From the 802.3's network model, the PEXTP is the
   PMA/PMD.

   From the point of view of 802.3's model, a network interface has
   various layers such as the MAC, PCS and PMA/PMD, and sitting above
   these layers is the management of the system. Rather than chasing
   the data flow (which in a network device can be complex) wouldn't
   it be better to continue with the 802.3 model as we are doing with
   other devices, rather than trying to go with a new approach here?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

