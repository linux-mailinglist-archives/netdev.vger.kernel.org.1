Return-Path: <netdev+bounces-296092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PSLrMX3wI2qF0QEAu9opvQ
	(envelope-from <netdev+bounces-296092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 12:03:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3264D0D6
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 12:03:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="mckouWh/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296092-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296092-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D16C63011F26
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6B349CFF;
	Sat,  6 Jun 2026 10:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582BA1DC9B5;
	Sat,  6 Jun 2026 10:02:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780740156; cv=none; b=YmoxwWiiHuvl5UdXfrshOUvRQ/ksCOdAv0neMNb60NJBMH1Z8ppovbE9f0DPYtwd1oVw8s/q0TmktUwEA6acyW8FRByj0cEitcYn29hjqSfiN0HLzaM9KCLqAjVA+Mhglkj93aCJ5yGhpwDqddO8P92ssvTETXJKX0c7258g2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780740156; c=relaxed/simple;
	bh=Rm91Heq3QmN5OrIGEir5rWY4F/Y9ScvkiEMrJ4a+xvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEhyYHTADxWHirPA9jDc6II93EaohTxprQ5cjkz6ONUPFJY/st/QGA476MDdskyVYUYLQKUWefAn3FjHv1ZZPXwRreeq7oFl7Uqb6e3XB4BIc++KjKmhWhwExnlufAbt/zCBpwcSJrAuXKdUeY6xpaFPnKcIYbysjYjyxcN9CME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mckouWh/; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 993074E40923;
	Sat,  6 Jun 2026 10:02:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F62B5FF0F;
	Sat,  6 Jun 2026 10:02:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0CF8106A0339;
	Sat,  6 Jun 2026 12:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780740149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=UF5TvVHp8YV6byGa3Kmqen79UBEkCCOKuCtWDAY3KfA=;
	b=mckouWh/zJsyRojY4M+770MjGfZApkbAlWlG2Vp/HV1klnNO+WTzOqIUJBBIAxZtQZtuDA
	gsHwTRXXY87h0EIjMVsgq9/AY4vosRMrwhSOI+/Q2HTVB0lnbjbh6xPnD3ocgybNtrKuzF
	NERL9pU9SOvcCcZy3MoQZ2M11iPegKFp2Q05uX2ruPcmS6EEtOWpypo9SeNW1oGcDzmE2P
	ibbutv/IYlIqoVSDyQApZmbuz1PMCFfPkoTPHEHl02zcZ7OXr9tn0QclCIHCSFzu74oMej
	Navh5FXDCOjY+pO1Fqdtk6RunsKtsgHKcy96KtzrMTwsaMpHRc04Ek3WeJ7V2A==
Message-ID: <75cee79b-78d5-4a64-bbfe-8ba89f4cfb7d@bootlin.com>
Date: Sat, 6 Jun 2026 12:02:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/6] r8169: add support for phylink
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-3-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260605103906.1445-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296092-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22F3264D0D6

Hi,

On 6/5/26 12:39, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Transfer old framework to phylink. Phylink can support fiber mode card
> which can not get link status or link speed from standard phy registers.

This is a good start, but you need to go deeper than that. Looking at the
end result, you still access tp->phydev a lot in this driver :

Looking at r8169_mdio_register() for example :

 -> don't configure the PHY eee support with phy_support_eee() and
    phy_disable_eee_mode(), let phylink to that for you

All over the driver, there's still a lot of manual control of the PHY
with phylib, look at the calls for phy_init_hw(), phy_resume(), and so on,
you need to assume that with phylink you may not have a PHY.

The problem then is that there are places in the code where PHY registers
are directly accessed :

static void rtl8169_init_phy(struct rtl8169_private *tp)
{
[...]

	if (tp->mac_version == RTL_GIGA_MAC_VER_05 &&
	    tp->pci_dev->subsystem_vendor == PCI_VENDOR_ID_GIGABYTE &&
	    tp->pci_dev->subsystem_device == 0xe000)
		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
[...]
	genphy_soft_reset(tp->phydev);
}

In the end, you shouldn't even need to use tp->phydev at all.

It's hard to know what this is all about, but it seems like something
a PHY driver should have to do, not a MAC driver :(

Also, I'd merge the next commit with this one to have one single commit
doing the phylink conversion.

Maxime

> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/Kconfig      |   1 +
>  drivers/net/ethernet/realtek/r8169_main.c | 170 ++++++++++++++++------
>  2 files changed, 123 insertions(+), 48 deletions(-)
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
> index fdc8c84dd112..97bcd36efdbb 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -26,6 +26,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
> +#include <linux/phylink.h>
>  #include <linux/prefetch.h>
>  #include <linux/ipv6.h>
>  #include <linux/unaligned.h>
> @@ -775,6 +776,8 @@ struct rtl8169_private {
>  	struct r8169_led_classdev *leds;
>  
>  	u32 ocp_base;
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
>  };
>  
>  typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
> @@ -2554,9 +2557,6 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
>  	if (tp->sfp_mode)
>  		rtl_sfp_init(tp);
>  
> -	/* We may have called phy_speed_down before */
> -	phy_speed_up(tp->phydev);
> -
>  	genphy_soft_reset(tp->phydev);
>  }
>  
> @@ -2658,13 +2658,10 @@ static void rtl_jumbo_config(struct rtl8169_private *tp)
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
>  }
>  
>  DECLARE_RTL_COND(rtl_chipcmd_cond)
> @@ -2779,7 +2776,7 @@ static void rtl_prepare_power_down(struct rtl8169_private *tp)
>  		rtl_ephy_write(tp, 0x19, 0xff64);
>  
>  	if (device_may_wakeup(tp_to_dev(tp))) {
> -		phy_speed_down(tp->phydev, false);
> +		phylink_speed_down(tp->phylink, false);
>  		rtl_wol_enable_rx(tp);
>  	}
>  }
> @@ -4139,11 +4136,17 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
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
> @@ -4962,41 +4965,15 @@ static void rtl_enable_tx_lpi(struct rtl8169_private *tp, bool enable)
>  	}
>  }
>  
> -static void r8169_phylink_handler(struct net_device *ndev)
> -{
> -	struct rtl8169_private *tp = netdev_priv(ndev);
> -	struct device *d = tp_to_dev(tp);
> -
> -	tp->current_speed = tp->phydev->speed;
> -	if (netif_carrier_ok(ndev)) {
> -		rtl_link_chg_patch(tp, tp->current_speed);
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
> @@ -5007,7 +4984,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  	/* Clear all task flags */
>  	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
>  
> -	phy_stop(tp->phydev);
> +	phylink_stop(tp->phylink);
>  
>  	/* Reset SerDes PHY to bring down fiber link */
>  	if (tp->sfp_mode)
> @@ -5035,11 +5012,14 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	phy_init_hw(tp->phydev);
>  	phy_resume(tp->phydev);
>  	rtl8169_init_phy(tp);
> +
> +	/* We may have called phy_speed_down before */
> +	phylink_speed_up(tp->phylink);
>  	napi_enable(&tp->napi);
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
>  
> -	phy_start(tp->phydev);
> +	phylink_start(tp->phylink);
>  }
>  
>  static int rtl8169_close(struct net_device *dev)
> @@ -5055,7 +5035,7 @@ static int rtl8169_close(struct net_device *dev)
>  
>  	free_irq(tp->irq, tp);
>  
> -	phy_disconnect(tp->phydev);
> +	phylink_disconnect_phy(tp->phylink);
>  
>  	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
>  			  tp->RxPhyAddr);
> @@ -5288,6 +5268,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
>  		r8169_remove_leds(tp->leds);
>  
>  	unregister_netdev(tp->dev);
> +	if (tp->phylink)
> +		phylink_destroy(tp->phylink);
>  
>  	if (tp->dash_type != RTL_DASH_NONE)
>  		rtl8168_driver_stop(tp);
> @@ -5474,10 +5456,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  		return -EUNATCH;
>  	}
>  
> -	tp->phydev->mac_managed_pm = true;
>  	if (rtl_supports_eee(tp))
>  		phy_support_eee(tp->phydev);
> -	phy_support_asym_pause(tp->phydev);
>  
>  	/* mimic behavior of r8125/r8126 vendor drivers */
>  	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
> @@ -5599,6 +5579,92 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static void rtl_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			      phy_interface_t interface)
> +{
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +
> +	tp->current_speed = SPEED_UNKNOWN;
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
> +	tp->current_speed = speed;
> +	rtl_link_chg_patch(tp, speed);
> +
> +	if (phydev)
> +		rtl_enable_tx_lpi(tp, phydev->enable_tx_lpi);
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
> +static const struct phylink_mac_ops rtl_phylink_mac_ops = {
> +	.mac_select_pcs = rtl_mac_select_pcs,
> +	.mac_config = rtl_mac_config,
> +	.mac_link_down  = rtl_mac_link_down,
> +	.mac_link_up    = rtl_mac_link_up,
> +};
> +
> +static int rtl_init_phylink(struct rtl8169_private *tp)
> +{
> +	struct phylink *pl;
> +	phy_interface_t phy_mode;
> +
> +	tp->phylink_config.dev = &tp->dev->dev;
> +	tp->phylink_config.type = PHYLINK_NETDEV;
> +	tp->phylink_config.mac_managed_pm = true;
> +
> +	tp->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
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
> +	pl = phylink_create(&tp->phylink_config, tp_to_dev(tp)->fwnode,
> +			    phy_mode, &rtl_phylink_mac_ops);
> +	if (IS_ERR(pl))
> +		return PTR_ERR(pl);
> +
> +	tp->phylink = pl;
> +
> +	return 0;
> +}
> +
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_chip_info *chip;
> @@ -5789,13 +5855,21 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	pci_set_drvdata(pdev, tp);
>  
> -	rc = r8169_mdio_register(tp);
> +	rc = rtl_init_phylink(tp);
>  	if (rc)
>  		return rc;
>  
> +	rc = r8169_mdio_register(tp);
> +	if (rc) {
> +		phylink_destroy(tp->phylink);
> +		return rc;
> +	}
> +
>  	rc = register_netdev(dev);
> -	if (rc)
> +	if (rc) {
> +		phylink_destroy(tp->phylink);
>  		return rc;
> +	}
>  
>  	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
>  		if (rtl_is_8125(tp))


