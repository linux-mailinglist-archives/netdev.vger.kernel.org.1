Return-Path: <netdev+bounces-114117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58194940FF7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23D32843D8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CB194A73;
	Tue, 30 Jul 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1uTQUCDA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9153E3A;
	Tue, 30 Jul 2024 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336735; cv=none; b=pDpbqy3Bf9Av7cXz3Yy3QsXjXXYlC/VCXqxUP/XiBRepbyK3FDwNmsXJ4PTO8vTy/oO8kM95kQVecmJ2+rMMvKiTnG15nkR35aCeZYIeKV1Tjv4TbP5KxZEA/EowufqPGjYFaaek7mHJ4o/MgnxrFx1VtEpoZ4DaUmG46rPco1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336735; c=relaxed/simple;
	bh=s2HQocwpXxBZkrNYb491vvo3W+TnaxNPokO3SU8nRDY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtUQ+qeEU6WlO9nrtPCD9YEcMqUkVMzQ5C2MdZCd5w3oTyK6eCPs/D8QhyzZg+Co4owGiACBa+wARS371C+5XO13/FBlnxMQ1XhjuKg3gdy6tUVSDIgb/yojBzLX8rGkBCQUa2bancDrSwWu2rqxKTUM4K+1HTBOVd4546eYOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1uTQUCDA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722336732; x=1753872732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s2HQocwpXxBZkrNYb491vvo3W+TnaxNPokO3SU8nRDY=;
  b=1uTQUCDAd9XqvOAmm84cYrGHX2y5r2vx5lCMxCsH1SDCjSAALAIQ2Wbv
   GpWLtu9Q4ZKfKZuLre6gQAQKXzFKMC7Askh7WDUoW+coUVhwQZnDWxsL4
   6BXkEB695mbEhOj+YvKMmJSDX7c3nzTzkubKz7iW5RL8ubrxDkTPRcQXS
   ikB/HwpOrKmIu5BhftK9quOjxlVn8XJCgJ0G8uMDlPM1OcoUuOwG/sp+5
   oG7NutRRbK/rGBxlX9TjvXUxtmwYJPs1rWsxsHiKFDGO8XwPYTTWaml/A
   m4v76NuioFspvwuHIpSV1ff0eJNaVp1rFQYrei7v08m1+fEyyIo+DFN+v
   g==;
X-CSE-ConnectionGUID: zpjcpBX5T8i0xmnoZrxCrQ==
X-CSE-MsgGUID: CNYIZc/mTT2AMg5wmvetBQ==
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="197274630"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2024 03:52:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jul 2024 03:51:36 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 30 Jul 2024 03:51:35 -0700
Date: Tue, 30 Jul 2024 16:18:20 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<horms@kernel.org>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V2 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <ZqjE9A8laPxYP1ta@HYD-DK-UNGSW21.microchip.com>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <20240716113349.25527-4-Raju.Lakkaraju@microchip.com>
 <Zqdd1mfSUDK9EifJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Zqdd1mfSUDK9EifJ@shell.armlinux.org.uk>

Hi Russell King,

Thank you for review the patches.

The 07/29/2024 10:16, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, Jul 16, 2024 at 05:03:48PM +0530, Raju Lakkaraju wrote:
> > +static void lan743x_phylink_mac_link_up(struct phylink_config *config,
> > +                                     struct phy_device *phydev,
> > +                                     unsigned int link_an_mode,
> > +                                     phy_interface_t interface,
> > +                                     int speed, int duplex,
> > +                                     bool tx_pause, bool rx_pause)
> > +{
> > +     struct net_device *netdev = to_net_dev(config->dev);
> > +     struct lan743x_adapter *adapter = netdev_priv(netdev);
> > +     int mac_cr;
> > +     u8 cap;
> > +
> > +     mac_cr = lan743x_csr_read(adapter, MAC_CR);
> > +     /* Pre-initialize register bits.
> > +      * Resulting value corresponds to SPEED_10
> > +      */
> > +     mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
> > +     if (speed == SPEED_2500)
> > +             mac_cr |= (MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
> > +     else if (speed == SPEED_1000)
> > +             mac_cr |= (MAC_CR_CFG_H_);
> > +     else if (speed == SPEED_100)
> > +             mac_cr |= (MAC_CR_CFG_L_);
> 
> These parens in each of these if() sub-blocks is not required. |=
> operates the same way as = - all such operators are treated the same
> in C.

Accpeted. I will fix.

> 
> > +
> > +     lan743x_csr_write(adapter, MAC_CR, mac_cr);
> > +
> > +     lan743x_ptp_update_latency(adapter, speed);
> > +
> > +     /* Flow Control operation */
> > +     cap = 0;
> > +     if (tx_pause)
> > +             cap |= FLOW_CTRL_TX;
> > +     if (rx_pause)
> > +             cap |= FLOW_CTRL_RX;
> > +
> > +     lan743x_mac_flow_ctrl_set_enables(adapter,
> > +                                       cap & FLOW_CTRL_TX,
> > +                                       cap & FLOW_CTRL_RX);
> > +
> > +     netif_tx_wake_all_queues(to_net_dev(config->dev));
> 
> You already have "netdev", so there's no need to do the to_net_dev()
> dance again here.

Accepted. I will fix
> 
> > +}
> > +
> > +static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
> > +     .mac_config = lan743x_phylink_mac_config,
> > +     .mac_link_down = lan743x_phylink_mac_link_down,
> > +     .mac_link_up = lan743x_phylink_mac_link_up,
> > +};
> 
> I guess as there's no PCS support here, you don't support inband mode
> for 1000base-X (which is rather fundamental for it).
> 

Initially, I add PHYLINK and SFP support changes in one patch series.
Due to too many changes, I split in 2 set of patches (i.e. PHYLINK and SFP
support).
In SFP support patch series, I would like to use Synopsys Designware's XPCS
driver as PCS support. Those changes are ready to submit for code review after
this patch series accept.
Those changes support 2500basex-x, 1000base-x along with SGMII Interfaces.

> > +
> > +static int lan743x_phylink_create(struct net_device *netdev)
> > +{
> > +     struct lan743x_adapter *adapter = netdev_priv(netdev);
> > +     struct phylink *pl;
> > +
> > +     adapter->phylink_config.dev = &netdev->dev;
> > +     adapter->phylink_config.type = PHYLINK_NETDEV;
> > +     adapter->phylink_config.mac_managed_pm = false;
> > +
> > +     adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
> > +             MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
> > +
> > +     lan743x_phy_interface_select(adapter);
> > +
> > +     switch (adapter->phy_interface) {
> > +     case PHY_INTERFACE_MODE_SGMII:
> > +             __set_bit(PHY_INTERFACE_MODE_SGMII,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             __set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             __set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             break;
> > +     case PHY_INTERFACE_MODE_GMII:
> > +             __set_bit(PHY_INTERFACE_MODE_GMII,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             break;
> > +     case PHY_INTERFACE_MODE_MII:
> > +             __set_bit(PHY_INTERFACE_MODE_MII,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             break;
> > +     default:
> > +             __set_bit(PHY_INTERFACE_MODE_RGMII,
> > +                       adapter->phylink_config.supported_interfaces);
> 
> Do you really only support RGMII and not RGMII_ID/RGMII_TXID/RGMII_RXID
> (which are normally implemented by tweaking the delays at the PHY end
> of the RGMII link) ?

Accepted.
Microchip's KSZ9131 PHY support RGMII_ID/RGMII_TXID/RGMII_RXID. I will fix.

> 
> > +static bool lan743x_phy_handle_exists(struct device_node *dn)
> > +{
> > +     dn = of_parse_phandle(dn, "phy-handle", 0);
> > +     of_node_put(dn);
> > +     if (IS_ERR(dn))
> > +             return false;
> > +
> > +     return true;
> 
> This likely doesn't work. Have you checked what the return values for
> of_parse_phandle() actually are before creating this, because to me
> this looks like you haven't - and thus what you've created is wrong.
> of_parse_phandle() doesn't return error-pointers when it fails, it
> returns NULL. Therefore, this will always return true.
> 
> We have another implementation of something very similar in the macb
> driver - see macb_phy_handle_exists(), and this one is implemented
> correctly.

Ok. 
After change, i ran the checkpatch script. it's giving follwoing warning
i.e.
"CHECK: Comparison to NULL could be written "dn"" 

Is it OK ?

> 
> > +}
> > +
> > +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> > +{
> > +     struct device_node *dn = adapter->pdev->dev.of_node;
> > +     struct net_device *dev = adapter->netdev;
> > +     struct fixed_phy_status fphy_status = {
> > +             .link = 1,
> > +             .speed = SPEED_1000,
> > +             .duplex = DUPLEX_FULL,
> > +     };
> > +     struct phy_device *phydev;
> > +     int ret;
> > +
> > +     if (dn)
> > +             ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
> > +
> > +     if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> > +             phydev = phy_find_first(adapter->mdiobus);
> > +             if (!phydev) {
> > +                     if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
> > +                           ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
> > +                             phydev = fixed_phy_register(PHY_POLL,
> > +                                                         &fphy_status,
> > +                                                         NULL);
> > +                             if (IS_ERR(phydev)) {
> > +                                     netdev_err(dev, "No PHY/fixed_PHY found\n");
> > +                                     return PTR_ERR(phydev);
> > +                             }
> 
> Eww. Given that phylink has its own internal fixed-PHY support, can we
> not find some way to avoid the legacy fixed-PHY usage here?

Yes. I agree with you. This is very much valid suggestion.
Andrew also gave same suggestion.

Currently we don't have Device Tree support for LAN743X driver. 
For SFP support, I create the software-node an passing the paramters there.

I don't have fixed-PHY hardware setup currently.
I would like to take this as action item to fix it after SFP support commits.

> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
Thanks,                                                                         
Raju

