Return-Path: <netdev+bounces-217748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8823B39B2D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C473BD408
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167830DD04;
	Thu, 28 Aug 2025 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cMW5482u"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5330DD19
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379556; cv=none; b=XXy3R5/TXytqOH8pODihLbEoWRYTjWBg1JBnLYXie4Zk1dn4YxWjSuC/EYkXtfEwWJwq8zRlREAmi6jc2ZZDENsdjBJ3wOD+5skRn8W2yBjunHEZZX7Z6NK6cA9p2wsebm44yrc8O9oK//fgqDvHzDvsKMLl3AFMgTTTDFZ9638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379556; c=relaxed/simple;
	bh=juYgXk9LZx1EuXemUqYYzhZ/fTmuKfQE2tSimlHyYzs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWMYyt/nqSo+RcigOx4DWu6R2Vn0ZAlILa05srPhykGtNYl30M1cL+yjD4MoN3QYsz8HP/qABDD1D34cxkvdIFLhLV0oI5BcsouTIhTBaosF8yva634G9/5l0rPnTL3Pojl4h34xd51iJPnePp1KfPK+s9aRpZm6OwH5ccBuY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cMW5482u; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756379554; x=1787915554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=juYgXk9LZx1EuXemUqYYzhZ/fTmuKfQE2tSimlHyYzs=;
  b=cMW5482uXTULX0iDSqoVOwLM3azPuk+3wO3PafGX/3Fir00SXcWoqPFR
   NDR9K0g4ZDTv0XPNmLC1XlTLiDOtUVC9T6XRz6Cd0L/c5cIzl+G3GBrkr
   QRMMFZAghmHykv0N8IHszT1q+K4c2aJhtbWhW35+jZhmBwhdG6sSsHtod
   ayMe54arLN/HHNyuEApfhxmkxSd/rvNfP7wY2Kj7qBh0dfjhZGJFO8ZgN
   Jz/scO47HeqFFKpmkeOiesr3Z8yPMhG+fsU12SIFyxkGza7/nWFwj5GIr
   y1PiRzVgLPLrc9vlQZvnw9sjO1cnDTfnrQ7uwhhpysTC/1X55CflHxToe
   Q==;
X-CSE-ConnectionGUID: UKqJSBJbQH6L8c+Kb5YBCA==
X-CSE-MsgGUID: pebM7QlLTCafdv5re/M2UA==
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="51409645"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2025 04:12:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 28 Aug 2025 04:12:17 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 28 Aug 2025 04:12:17 -0700
Date: Thu, 28 Aug 2025 11:12:16 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, <horatiu.vultur@microchip.com>
Subject: Re: [PATCH net-next 2/2] net: lan966x: convert fwnode to of
Message-ID: <20250828111216.bruz7lq7dz5e6b6f@DEN-DL-M70577>
References: <20250827215042.79843-1-rosenp@gmail.com>
 <20250827215042.79843-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250827215042.79843-3-rosenp@gmail.com>

> This is a purely OF driver. There's no need for fwnode to handle any of
> this, with the exception being phylik_create. Use of_fwnode_handle for
> that.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../ethernet/microchip/lan966x/lan966x_main.c | 32 ++++++++++---------
>  .../ethernet/microchip/lan966x/lan966x_main.h |  2 +-
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 8bf28915c030..d778806dcfc6 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -183,7 +183,7 @@ static int lan966x_port_open(struct net_device *dev)
>                 ANA_PORT_CFG_PORTID_VAL,
>                 lan966x, ANA_PORT_CFG(port->chip_port));
> 
> -       err = phylink_fwnode_phy_connect(port->phylink, port->fwnode, 0);
> +       err = phylink_of_phy_connect(port->phylink, port->dnode, 0);
>         if (err) {
>                 netdev_err(dev, "Could not attach to PHY\n");
>                 return err;
> @@ -767,8 +767,8 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
>                         port->phylink = NULL;
>                 }
> 
> -               if (port->fwnode)
> -                       fwnode_handle_put(port->fwnode);
> +               if (port->dnode)
> +                       of_node_put(port->dnode);
>         }
> 
>         disable_irq(lan966x->xtr_irq);
> @@ -1081,7 +1081,7 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
> 
>  static int lan966x_probe(struct platform_device *pdev)
>  {
> -       struct fwnode_handle *ports, *portnp;
> +       struct device_node *ports, *portnp;
>         struct lan966x *lan966x;
>         int err;
> 
> @@ -1179,7 +1179,7 @@ static int lan966x_probe(struct platform_device *pdev)
>                 }
>         }
> 
> -       ports = device_get_named_child_node(&pdev->dev, "ethernet-ports");
> +       ports = of_get_child_by_name(pdev->dev.of_node, "ethernet-ports");
>         if (!ports)
>                 return dev_err_probe(&pdev->dev, -ENODEV,
>                                      "no ethernet-ports child found\n");
> @@ -1191,25 +1191,27 @@ static int lan966x_probe(struct platform_device *pdev)
>         lan966x_stats_init(lan966x);
> 
>         /* go over the child nodes */
> -       fwnode_for_each_available_child_node(ports, portnp) {
> +       for_each_available_child_of_node(ports, portnp) {
>                 phy_interface_t phy_mode;
>                 struct phy *serdes;
>                 u32 p;
> 
> -               if (fwnode_property_read_u32(portnp, "reg", &p))
> +               if (of_property_read_u32(portnp, "reg", &p))
>                         continue;
> 
> -               phy_mode = fwnode_get_phy_mode(portnp);
> -               err = lan966x_probe_port(lan966x, p, phy_mode, portnp);
> +               err = of_get_phy_mode(portnp, &phy_mode);
> +               if (err)
> +                       goto cleanup_ports;
> +
> +               err = lan966x_probe_port(lan966x, p, phy_mode, of_fwnode_handle(portnp));

As I see it, you could change the signature of lan966x_probe_port() to accept a
struct device_node, and instead pass that.  Then you can convert it to fwnode
for phylink_create, and ditch to_of_node().

Same goes for lan966x_port_parse_delays(), here you can change
fwnode_for_each_available_child_node() to for_each_available_child_of_node()
and fwnode_property_read_u32() to of_property_read_u32().

That will get rid of all the struct fwnode_handle uses and be more consistent.

>                 if (err)
>                         goto cleanup_ports;
> 
>                 /* Read needed configuration */
>                 lan966x->ports[p]->config.portmode = phy_mode;
> -               lan966x->ports[p]->fwnode = fwnode_handle_get(portnp);
> +               lan966x->ports[p]->dnode = of_node_get(portnp);
> 
> -               serdes = devm_of_phy_optional_get(lan966x->dev,
> -                                                 to_of_node(portnp), NULL);
> +               serdes = devm_of_phy_optional_get(lan966x->dev, portnp, NULL);
>                 if (IS_ERR(serdes)) {
>                         err = PTR_ERR(serdes);
>                         goto cleanup_ports;
> @@ -1222,7 +1224,7 @@ static int lan966x_probe(struct platform_device *pdev)
>                         goto cleanup_ports;
>         }
> 
> -       fwnode_handle_put(ports);
> +       of_node_put(ports);
> 
>         lan966x_mdb_init(lan966x);
>         err = lan966x_fdb_init(lan966x);
> @@ -1255,8 +1257,8 @@ static int lan966x_probe(struct platform_device *pdev)
>         lan966x_fdb_deinit(lan966x);
> 
>  cleanup_ports:
> -       fwnode_handle_put(ports);
> -       fwnode_handle_put(portnp);
> +       of_node_put(ports);
> +       of_node_put(portnp);
> 
>         lan966x_cleanup_ports(lan966x);
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> index 4f75f0688369..bafb8f5ee64d 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> @@ -407,7 +407,7 @@ struct lan966x_port {
>         struct lan966x_port_config config;
>         struct phylink *phylink;
>         struct phy *serdes;
> -       struct fwnode_handle *fwnode;
> +       struct device_node *dnode;
> 
>         u8 ptp_tx_cmd;
>         bool ptp_rx_cmd;
> --
> 2.51.0
>

/Daniel 

