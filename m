Return-Path: <netdev+bounces-17449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F3751A65
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B0A281C14
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21651612F;
	Thu, 13 Jul 2023 07:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E826116
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:54:03 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D2170E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WHC2hHwfMGxaTjTne1G5M6fbRD4sEeORuZoWOPevjv0=; b=vyeR1oV0xmEu8zZA/rUgkMNAgZ
	kyFpNxYtE4ctlxTPtPsOseC4RB3xmvMta8vU1OufJLkf4frezXNNPGHA2DkcqCLIQKu1ybohY/eJ2
	lD1BrLJzZ48Kl8VQZGSAkAc9Wo7AO8NXX7EW9b/aY4EZ4+TFnXLajJsRioo0s9sk2xzzvKrQZAb4c
	2YRK71q8vSG5+oSaTbUgtizUi4cwfwN3SdE5ux3pFq+evsPd/g/R2YZz1mdZc75JNqLeC4R1VDwul
	kC6grSEW1q2yAF1+QyKZSzlj2gC/5+T/o5o24kqmoqXEYiA1L5KOqmXWFOfJHibKCOQATnsnM+mr1
	UPaa2qSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43066)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJr90-0005wa-2Q;
	Thu, 13 Jul 2023 08:53:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJr8w-0005xQ-W2; Thu, 13 Jul 2023 08:53:43 +0100
Date: Thu, 13 Jul 2023 08:53:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
Message-ID: <ZK+thg7xIKt7b8X+@shell.armlinux.org.uk>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 10:46:53AM +0800, Feiyang Chen wrote:
> +#define PHY_ID_LS7A2000		0x00061ce0
> +#define GNET_REV_LS7A2000	0x00
> +
> +static int ls7a2000_config_aneg(struct phy_device *phydev)
> +{
> +	if (phydev->speed == SPEED_1000)
> +		phydev->autoneg = AUTONEG_ENABLE;
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +	    phydev->advertising) ||
> +	    linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +	    phydev->advertising) ||
> +	    linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +	    phydev->advertising))
> +	    return genphy_config_aneg(phydev);

While it's fine to use four spaces within the if () expression, this
"return" should be indented with a tab.

> +
> +	netdev_info(phydev->attached_dev, "Parameter Setting Error\n");

Does this give the opportunity for userspace to spam the kernel log?
E.g. by a daemon repeatedly trying to set link parameters? Should it
be rate limited?

> +	return -1;

Sigh, not this laziness disease yet again. -1 is -EPERM. Return a
real errno code.

> +int ls7a2000_match_phy_device(struct phy_device *phydev)
> +{
> +	struct net_device *ndev;
> +	struct pci_dev *pdev;
> +
> +	if ((phydev->phy_id & 0xfffffff0) != PHY_ID_LS7A2000)
> +		return 0;

	if (!phy_id_compare(phydev->phy_id, PHY_ID_LS7A2000, 0xfffffff0))
		return 0;

> +
> +	ndev = phydev->mdio.bus->priv;

This doesn't look safe to me - you're assuming that if the PHY ID
above matches, that the MDIO bus' private data is something you know
which is far from guaranteed.

The mdio bus has a parent device - that would be a safer route to
check what the parent device is, provided the mdio bus is created so
that it's a child of the parent PCI device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

