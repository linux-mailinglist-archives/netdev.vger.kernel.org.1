Return-Path: <netdev+bounces-299063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZVa5NXPULWqMkwQAu9opvQ
	(envelope-from <netdev+bounces-299063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:06:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F767FDAE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:06:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oUVMOl1D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299063-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299063-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 024CE303E4C6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781773A6EE6;
	Sat, 13 Jun 2026 22:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E83911AA;
	Sat, 13 Jun 2026 22:06:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388362; cv=none; b=Qchh27on+T5LiP2msQMenmrZPyot7/c9A6pk29VaK9AP85N980186gYJMv6rytKV22I0J1ragcIvq2ZCKYsOqEejYfB2SkyBm8vYjRgaawL8aDCFSMt3CE+5TAZsXJVBm6EJFRw9Yoh/s8pnasttf0HsMz9LF3vKvIapvimYI0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388362; c=relaxed/simple;
	bh=3nQBGzuQdCssSRx+UZk8Wlt7YmuQmPlcWTseaOCVuKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0JSLPW4y1fRxdNCrzHKKKklls/gRKVKsNY0B+y62dErPL13S53XyhB1YM7IpCbEFm9RRANF6BKcZLj/HwPc0i6FPbiLlaPzVuPmKDflR0dZHYoudaVEQ3juYHdiASdV+Ns/KYGu8jnApj91503Qt/3Gzhu11riSuVu87nFCCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUVMOl1D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D3C1F00A3A;
	Sat, 13 Jun 2026 22:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388360;
	bh=eh3E9tbLJK6r2YQL7zhyUJJeEaI2GkjBaTkRJyhcxZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUVMOl1D+40ylftuLx3UQYMO33RGElh+6FuqNgxzfRKe1Ee17PBLsZGKa7rKHHyA9
	 IxjW5/sXOJTPSh1CgESY+JkXyyPMy1b+U+TP6Ygp39Hx3brRyYaEjjGU3oNxasJxDz
	 v/ZALUQnJy7kkaEHO/0cVpz6XSuNRrZJ32P3MUsiwCstfw91Z01coL+TBKkmQaanAW
	 7UCVCPdlgcj0R7avjhA/Wm8yg2RhuRAnFGmDx/hlx8TCl4yh3qTB2BNSm3df8gxUNu
	 NxCnyqjLqo0njWC6qtq2H44X7wReIoNBHx7cwyl/HQJteWRkoJvOHyTbMs/hQKPovM
	 VG2A7Uwsnswag==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] r8169: add support for phylink
Date: Sat, 13 Jun 2026 15:05:59 -0700
Message-ID: <20260613220559.219642-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611094345.880-4-javen_xu@realsil.com.cn>
References: <20260611094345.880-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299063-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:kuba@kernel.org,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E2F767FDAE

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: add support for phylink

Transfer old framework to phylink. Phylink can support fiber mode card
which can not get link status or link speed from standard phy registers.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 560f987437b63..615bd4107359a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
[ ... ]
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
>  }

[Severity: High]
Does phylink re-read mac_capabilities on start?

It looks like dynamic bitwise modifications to tp->phylink_config.mac_capabilities
made here are ignored by phylink. Since phylink does not update the pl->supported
link mode mask during phylink_start(), won't the PHY continue to incorrectly
advertise pause capabilities to the link partner when jumbo frames are enabled?

[ ... ]
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

[ ... ]
> +static int rtl_init_phylink(struct rtl8169_private *tp)
> +{
> +	struct phylink *pl;
> +	phy_interface_t phy_mode;
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

[Severity: High]
Does hardcoding phy_mode to PHY_INTERFACE_MODE_INTERNAL here break older
adapters that use discrete PHYs over GMII or MII?

Prior to this patch, the driver dynamically checked tp->supports_gmii to set
either PHY_INTERFACE_MODE_GMII or PHY_INTERFACE_MODE_MII. Forcing INTERNAL
might tell the PHY driver that the PHY is integrated into the MAC, which could
cause discrete PHY drivers to skip necessary initializations, fail validation
checks, or misconfigure interface delays.

> +
> +		if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +			tp->phylink_config.mac_capabilities |= MAC_1000FD | MAC_2500FD |
> +							       MAC_5000FD | MAC_10000FD;

