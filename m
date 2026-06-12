Return-Path: <netdev+bounces-298513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DsvDOdO/K2ouEQQAu9opvQ
	(envelope-from <netdev+bounces-298513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:14:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CD677B44
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:14:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=Se+UWgEG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298513-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298513-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FC83304D7FA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24C374E43;
	Fri, 12 Jun 2026 08:13:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B835F612;
	Fri, 12 Jun 2026 08:13:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252038; cv=none; b=Wt05o+Jk+YMVRZgcZv27bWTO0yOt7h+C3kHz0SAGAb7Php0zw3dtQl1JrQizDn7eGetcqFM37heIxuxn8zZjK/cFBtGxtUcp3xj5LnazVPfbs7LJliWTY25BIPGN9K4+QyCSMxLS9HKMWvMmcHzViH4T3EyutqxKTk1rtWu0reE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252038; c=relaxed/simple;
	bh=2M58W/ftMiLoQVqXaKsWItglmPCEIr2ZtBuGFTlz2Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poR+EPxdAq6PpSd9dj8rFjCKgeVVi3Q8VncpKDFkVtM4Gw9h7RQHr+TnT6PNkvxOF9CND14Skd+JexUPHWYg/kUjuJH8JeFuJ9S/q7GAQctIfTMOEMdSUkh6rqv8KnbJ8RwCwVTVClauVTOKkD/IoihSJeod3bf+IOffc7S0jcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Se+UWgEG; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EA1811A38DA;
	Fri, 12 Jun 2026 08:13:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B619660012;
	Fri, 12 Jun 2026 08:13:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0241106C803C;
	Fri, 12 Jun 2026 10:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781252025; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=L+32PzMm+WzQRtGh72lJJoVSfmWXyo9TbLxRNQv4k5g=;
	b=Se+UWgEG0duiNZ9WoXbeBuxqug6nX8sUWQe1HtTmPfkRupP2xIrqD8q3JG3mtG4ScfCAPp
	tjziiGeXTADLfFsE13l9KbD7W/YryBp+s49H7XIKvG2tYPyWMk2bV0oFVljbBzgiocx7hT
	9asnZcvjs6ZVQC17bIvoMEeBUQuLZi8+yIca7c5yH9P0k8pSDsDFDWhILFPe0hKW/Qqmp3
	4GklimCxZbDVjoHshxvBz9d6NUQUkf/NeapauzBARMMKULFa1hEwZRkTnv/6lukOZchZ2E
	oyNfi+hVkpF8YH399J0Qepqz5NKFOGoCj8PFyQ9krWz0sIn53LGH2HXrSiUo+Q==
Message-ID: <992db759-3b94-4309-8c4d-61a37b41fcce@bootlin.com>
Date: Fri, 12 Jun 2026 10:13:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/6] r8169: add support for phylink
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611094345.880-1-javen_xu@realsil.com.cn>
 <20260611094345.880-4-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260611094345.880-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298513-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 078CD677B44

Hi,

On 6/11/26 11:43, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Transfer old framework to phylink. Phylink can support fiber mode card
> which can not get link status or link speed from standard phy registers.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - merge patch v1 3/6 and v1 4/6.
>  - add helper rtl_mac_enable_tx_lpi(), rtl_mac_disable_tx_lpi()
>    and rtl8169_get_lpi_caps()
> ---
>  drivers/net/ethernet/realtek/Kconfig      |   1 +
>  drivers/net/ethernet/realtek/r8169_main.c | 249 ++++++++++++++++------
>  2 files changed, 181 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
> index 9b0f4f9631db..49ac72734225 100644
> --- a/drivers/net/ethernet/realtek/Kconfig
> +++ b/drivers/net/ethernet/realtek/Kconfig
> @@ -88,6 +88,7 @@ config R8169
>  	select CRC32
>  	select PHYLIB
>  	select REALTEK_PHY
> +	select PHYLINK
>  	help
>  	  Say Y here if you have a Realtek Ethernet adapter belonging to
>  	  the following families:
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 560f987437b6..615bd4107359 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -28,6 +28,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
> +#include <linux/phylink.h>
>  #include <linux/prefetch.h>
>  #include <linux/ipv6.h>
>  #include <linux/unaligned.h>
> @@ -777,6 +778,8 @@ struct rtl8169_private {
>  	struct r8169_led_classdev *leds;
>  
>  	u32 ocp_base;
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
>  	struct irq_domain *phy_irq_domain;
>  };
>  
> @@ -2256,7 +2259,7 @@ static int rtl8169_get_eee(struct net_device *dev, struct ethtool_keee *data)
>  	if (!rtl_supports_eee(tp))
>  		return -EOPNOTSUPP;
>  
> -	ret = phy_ethtool_get_eee(tp->phydev, data);
> +	ret = phylink_ethtool_get_eee(tp->phylink, data);
>  	if (ret)
>  		return ret;
>  
> @@ -2272,7 +2275,7 @@ static int rtl8169_set_eee(struct net_device *dev, struct ethtool_keee *data)
>  	if (!rtl_supports_eee(tp))
>  		return -EOPNOTSUPP;
>  
> -	return phy_ethtool_set_eee(tp->phydev, data);
> +	return phylink_ethtool_set_eee(tp->phylink, data);
>  }
>  
>  static void rtl8169_get_ringparam(struct net_device *dev,
> @@ -2303,13 +2306,8 @@ static void rtl8169_get_pauseparam(struct net_device *dev,
>  				   struct ethtool_pauseparam *data)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
> -	bool tx_pause, rx_pause;
>  
> -	phy_get_pause(tp->phydev, &tx_pause, &rx_pause);
> -
> -	data->autoneg = tp->phydev->autoneg;
> -	data->tx_pause = tx_pause ? 1 : 0;
> -	data->rx_pause = rx_pause ? 1 : 0;
> +	phylink_ethtool_get_pauseparam(tp->phylink, data);
>  }
>  
>  static int rtl8169_set_pauseparam(struct net_device *dev,
> @@ -2320,9 +2318,7 @@ static int rtl8169_set_pauseparam(struct net_device *dev,
>  	if (dev->mtu > ETH_DATA_LEN)
>  		return -EOPNOTSUPP;
>  
> -	phy_set_asym_pause(tp->phydev, data->rx_pause, data->tx_pause);
> -
> -	return 0;
> +	return phylink_ethtool_set_pauseparam(tp->phylink, data);
>  }
>  
>  static void rtl8169_get_eth_mac_stats(struct net_device *dev,
> @@ -2388,6 +2384,14 @@ static void rtl8169_get_eth_ctrl_stats(struct net_device *dev,
>  		le32_to_cpu(tp->counters->rx_unknown_opcode);
>  }
>  
> +static int rtl8169_get_link_ksettings(struct net_device *ndev,
> +				      struct ethtool_link_ksettings *cmd)
> +{
> +	struct rtl8169_private *tp = netdev_priv(ndev);
> +
> +	return phylink_ethtool_ksettings_get(tp->phylink, cmd);
> +}
> +
>  static int rtl8169_set_link_ksettings(struct net_device *ndev,
>  				      const struct ethtool_link_ksettings *cmd)
>  {
> @@ -2418,6 +2422,13 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
>  	return 0;
>  }
>  
> +static int rtl8169_nway_reset(struct net_device *dev)
> +{
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +
> +	return phylink_ethtool_nway_reset(tp->phylink);
> +}
> +
>  static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
> @@ -2433,10 +2444,10 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.get_sset_count		= rtl8169_get_sset_count,
>  	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
>  	.get_ts_info		= ethtool_op_get_ts_info,
> -	.nway_reset		= phy_ethtool_nway_reset,
> +	.nway_reset		= rtl8169_nway_reset,
>  	.get_eee		= rtl8169_get_eee,
>  	.set_eee		= rtl8169_set_eee,
> -	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
> +	.get_link_ksettings	= rtl8169_get_link_ksettings,
>  	.set_link_ksettings	= rtl8169_set_link_ksettings,
>  	.get_ringparam		= rtl8169_get_ringparam,
>  	.get_pause_stats	= rtl8169_get_pause_stats,
> @@ -2661,13 +2672,10 @@ static void rtl_jumbo_config(struct rtl8169_private *tp)
>  		pcie_set_readrq(tp->pci_dev, readrq);
>  
>  	/* Chip doesn't support pause in jumbo mode */
> -	if (jumbo) {
> -		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> -				   tp->phydev->advertising);
> -		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> -				   tp->phydev->advertising);
> -		phy_start_aneg(tp->phydev);
> -	}
> +	if (jumbo)
> +		tp->phylink_config.mac_capabilities &= ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +	else
> +		tp->phylink_config.mac_capabilities |= (MAC_SYM_PAUSE | MAC_ASYM_PAUSE);

I'm wondering if this actually works. These capabilities are used at init, it's
not really something that's supposed to be changed dynamically.

I'm wondering what's the best course of action to address this. Either rejecting
pause settings in set_pauseparams when jumbo is used, but that leaves the pause
bits in the advertisement.

Have you checked if the above code you wrote works correctly w.r.t pause advertising
when you switch back and forth between jumbo/non jumbo ?

>  }
>  
>  DECLARE_RTL_COND(rtl_chipcmd_cond)
> @@ -2782,7 +2790,7 @@ static void rtl_prepare_power_down(struct rtl8169_private *tp)
>  		rtl_ephy_write(tp, 0x19, 0xff64);
>  
>  	if (device_may_wakeup(tp_to_dev(tp))) {
> -		phy_speed_down(tp->phydev, false);
> +		phylink_speed_down(tp->phylink, false);
>  		rtl_wol_enable_rx(tp);
>  	}
>  }
> @@ -4142,11 +4150,17 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  
> +	if (netif_running(dev))
> +		phylink_stop(tp->phylink);
> +
>  	WRITE_ONCE(dev->mtu, new_mtu);
>  	netdev_update_features(dev);
>  	rtl_jumbo_config(tp);
>  	rtl_set_eee_txidle_timer(tp);
>  
> +	if (netif_running(dev))
> +		phylink_start(tp->phylink);
> +
>  	return 0;
>  }
>  
> @@ -4932,9 +4946,6 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  
>  static void rtl_enable_tx_lpi(struct rtl8169_private *tp, bool enable)
>  {
> -	if (!rtl_supports_eee(tp))
> -		return;
> -
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_52:
>  		/* Adjust EEE LED frequency */
> @@ -4965,41 +4976,15 @@ static void rtl_enable_tx_lpi(struct rtl8169_private *tp, bool enable)
>  	}
>  }
>  
> -static void r8169_phylink_handler(struct net_device *ndev)
> -{
> -	struct rtl8169_private *tp = netdev_priv(ndev);
> -	struct device *d = tp_to_dev(tp);
> -
> -	tp->speed = tp->phydev->speed;
> -	if (netif_carrier_ok(ndev)) {
> -		rtl_link_chg_patch(tp, tp->speed);
> -		rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
> -		pm_request_resume(d);
> -	} else {
> -		pm_runtime_idle(d);
> -	}
> -
> -	phy_print_status(tp->phydev);
> -}
> -
>  static int r8169_phy_connect(struct rtl8169_private *tp)
>  {
> -	struct phy_device *phydev = tp->phydev;
> -	phy_interface_t phy_mode;
>  	int ret;
>  
> -	phy_mode = tp->supports_gmii ? PHY_INTERFACE_MODE_GMII :
> -		   PHY_INTERFACE_MODE_MII;
> -
> -	ret = phy_connect_direct(tp->dev, phydev, r8169_phylink_handler,
> -				 phy_mode);
> -	if (ret)
> +	ret = phylink_connect_phy(tp->phylink, tp->phydev);
> +	if (ret) {
> +		netdev_err(tp->dev, "failed to connect phy\n");
>  		return ret;
> -
> -	if (!tp->supports_gmii)
> -		phy_set_max_speed(phydev, SPEED_100);
> -
> -	phy_attached_info(phydev);
> +	}
>  
>  	return 0;
>  }
> @@ -5010,7 +4995,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  	/* Clear all task flags */
>  	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
>  
> -	phy_stop(tp->phydev);
> +	phylink_stop(tp->phylink);
>  
>  	/* Reset SerDes PHY to bring down fiber link */
>  	if (tp->sfp_mode)
> @@ -5042,7 +5027,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
>  
> -	phy_start(tp->phydev);
> +	phylink_start(tp->phylink);
>  }
>  
>  static int rtl8169_close(struct net_device *dev)
> @@ -5058,7 +5043,7 @@ static int rtl8169_close(struct net_device *dev)
>  
>  	free_irq(tp->irq, tp);
>  
> -	phy_disconnect(tp->phydev);
> +	phylink_disconnect_phy(tp->phylink);
>  
>  	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
>  			  tp->RxPhyAddr);
> @@ -5291,6 +5276,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
>  		r8169_remove_leds(tp->leds);
>  
>  	unregister_netdev(tp->dev);
> +	if (tp->phylink)
> +		phylink_destroy(tp->phylink);
>  
>  	if (tp->dash_type != RTL_DASH_NONE)
>  		rtl8168_driver_stop(tp);
> @@ -5519,16 +5506,6 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  		return -EUNATCH;
>  	}
>  
> -	tp->phydev->mac_managed_pm = true;
> -	if (rtl_supports_eee(tp))
> -		phy_support_eee(tp->phydev);
> -	phy_support_asym_pause(tp->phydev);
> -
> -	/* mimic behavior of r8125/r8126 vendor drivers */
> -	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
> -		phy_disable_eee_mode(tp->phydev,
> -				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
> -
>  	/* PHY will be woken up in rtl_open() */
>  	phy_suspend(tp->phydev);
>  
> @@ -5644,6 +5621,132 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static void rtl_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			      phy_interface_t interface)
> +{
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +
> +	tp->speed = SPEED_UNKNOWN;
> +	pm_runtime_idle(tp_to_dev(tp));
> +}
> +
> +static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *phydev,
> +			    unsigned int mode, phy_interface_t interface,
> +			    int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +
> +	struct device *d = tp_to_dev(tp);
> +
> +	tp->speed = speed;
> +	rtl_link_chg_patch(tp, speed);
> +
> +	pm_request_resume(d);
> +}
> +
> +static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
> +					      phy_interface_t interface)
> +{
> +	return NULL;
> +}
> +
> +static void rtl_mac_config(struct phylink_config *config, unsigned int mode,
> +			   const struct phylink_link_state *state)
> +{
> +}
> +
> +static void rtl_mac_disable_tx_lpi(struct phylink_config *config)
> +{
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +
> +	rtl_enable_tx_lpi(tp, false);
> +}
> +
> +static int rtl_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
> +{
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +
> +	if (!rtl_supports_eee(tp))
> +		return -EOPNOTSUPP;
> +
> +	rtl_enable_tx_lpi(tp, true);
> +
> +	return 0;
> +}
> +
> +static const struct phylink_mac_ops rtl_phylink_mac_ops = {
> +	.mac_select_pcs = rtl_mac_select_pcs,
> +	.mac_config = rtl_mac_config,
> +	.mac_link_down  = rtl_mac_link_down,
> +	.mac_link_up    = rtl_mac_link_up,
> +	.mac_disable_tx_lpi = rtl_mac_disable_tx_lpi,
> +	.mac_enable_tx_lpi = rtl_mac_enable_tx_lpi,
> +};
> +
> +static unsigned long rtl8169_get_lpi_caps(struct rtl8169_private *tp)
> +{
> +	unsigned long caps = 0;
> +
> +	if (!rtl_supports_eee(tp))
> +		return 0;
> +
> +	caps |= MAC_100FD | MAC_1000FD;
> +
> +	/* mimic behavior of r8125/r8126 vendor drivers
> +	 * RTL_GIGA_MAC_VER_61 doesn't support 2.5G eee
> +	 */
> +	if (tp->mac_version >= RTL_GIGA_MAC_VER_63)
> +		caps |= MAC_2500FD;
> +	if (tp->mac_version >= RTL_GIGA_MAC_VER_70)
> +		caps |= MAC_5000FD;
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		caps |= MAC_10000FD;
> +
> +	return caps;
> +}
> +
> +static int rtl_init_phylink(struct rtl8169_private *tp)
> +{
> +	struct phylink *pl;
> +	phy_interface_t phy_mode;

reverse xmas tree here :)

> +
> +	tp->phylink_config.dev = &tp->dev->dev;
> +	tp->phylink_config.type = PHYLINK_NETDEV;
> +	tp->phylink_config.mac_managed_pm = true;
> +	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
> +	tp->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
> +
> +	if (tp->sfp_mode) {
> +		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
> +		tp->phylink_config.mac_capabilities |= MAC_10000FD;
> +	} else {
> +		tp->phylink_config.mac_capabilities |= MAC_10 | MAC_100;
> +		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
> +
> +		if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +			tp->phylink_config.mac_capabilities |= MAC_1000FD | MAC_2500FD |
> +							       MAC_5000FD | MAC_10000FD;
> +		else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
> +			tp->phylink_config.mac_capabilities |= MAC_1000FD |
> +							       MAC_2500FD | MAC_5000FD;
> +		else if (tp->mac_version >= RTL_GIGA_MAC_VER_61)
> +			tp->phylink_config.mac_capabilities |= MAC_1000FD | MAC_2500FD;
> +		else
> +			if (tp->supports_gmii)
> +				tp->phylink_config.mac_capabilities |= MAC_1000FD;
> +	}
> +
> +	__set_bit(phy_mode, tp->phylink_config.supported_interfaces);

So a few lines above in r8169_phy_connect() there's this removal : 

> -	phy_mode = tp->supports_gmii ? PHY_INTERFACE_MODE_GMII :
> -		   PHY_INTERFACE_MODE_MII;
> -

Has it always actually been an internal interface for all realtek devices ?

Maxime


