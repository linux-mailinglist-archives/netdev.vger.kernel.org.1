Return-Path: <netdev+bounces-27660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E577CB06
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1758528145D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D61101EB;
	Tue, 15 Aug 2023 10:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFBDF4C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 10:13:27 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7141BD7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 03:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5HSHe/7xK9qfKzA+ud+1e59aq6q+P4D3FniFlYpAsRc=; b=K9Mgvpz/gKDPDipaDNa55c08Tm
	qG3SnfcUCnU09qKWxCCx/NP7tzyx3v5IPIWLgm2xblVCjZ5yYqizqUXPBYRF/ci41jl2qYw7nxEHR
	n0jFW4FT0WsZa/D9iyqsNtyRgogFq4rog+gsOEEGNM1kRtIKoMI4IKcWb7zg9GxajLhyUdMd4kzPG
	iQXczgLOMW0a+PY4ajm6ZqyaSbkACTMsy37loRIPBo55k119q13VvqhcwxoWzagW6CZuEikqTxh8y
	gr3XhGD8hueXL3ylmlL4kjz2APCoM+3m9LG57bw2Ii844rLXjBWhqgpocTIkBTUn439xOwaOco6Vq
	gKQcp0Mg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37662)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qVr2y-0001QB-2s;
	Tue, 15 Aug 2023 11:13:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qVr2x-0006uN-FZ; Tue, 15 Aug 2023 11:13:07 +0100
Date: Tue, 15 Aug 2023 11:13:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <ZNtPswQl8fvnlGyf@shell.armlinux.org.uk>
References: <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <ZNqklHxfH8sYaet7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNqklHxfH8sYaet7@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 11:03:00PM +0100, Russell King (Oracle) wrote:
> Then we have the DSA side:
> 
>    DSA <------------------------------> Fixed-PHY
>     v					    v
> dt-dsa-node {				No DT node
>   phy-mode = "rgmii-foo";
>   fixed-link {
>    ...
>   };
> };
> 
> parses phy mode
> configures for RGMII mode
> configures RGMII delays associated
>  with phy-mode
> calls phy_attach(..., mode);
> phylib sets phy_dev->interface
> 					Generic PHY driver ignores
> 					phy_dev->interface

There is one case that I have missed, and it's totally screwed by
this behaviour where a Marvell DSA switch is connected to a Marvell
PHY via a RGMII connection:

   DSA <---------------------------------> PHY
    v					    v
dt-dsa-node {				phy: dt-phy-node {
  phy-handle = <&phy>;			  ...
  phy-mode = "rgmii-foo";		};
};

parses phy mode
configures for RGMII mode
configures RGMII delays associated
 with phy-mode
calls phy_attach(..., mode);
phylib sets phy_dev->interface
					PHY driver looks at
					phydev->interface and
					configures delays

In this case, we have *both* ends configuring the RGMII delays and it
will not work - because having the DSA MAC end configure the delays
breaks the phylib model where the MAC *shouldn't* be configuring the
delays.

So, should mv88e6xxx_mac_config() also be forcing all RGMII modes
in state->interface to be PHY_INTERFACE_MODE_RGMII when passing
that into mv88e6xxx_port_config_interface() if, and only if the
port is a user port? Or maybe if and only if the port is actually
connected to a real PHY?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

