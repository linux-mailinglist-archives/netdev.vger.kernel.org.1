Return-Path: <netdev+bounces-299068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PcjdMzbVLWrlkwQAu9opvQ
	(envelope-from <netdev+bounces-299068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:09:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E12267FE08
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Fuq9kHYY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299068-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299068-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 815623062967
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32113A3E77;
	Sat, 13 Jun 2026 22:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3893A5E93;
	Sat, 13 Jun 2026 22:06:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388387; cv=none; b=AqxyjonRJkXRAX8FiddxfgLUl32KZhkcQvcA+5GblEo8PqifyuV0J3M39T72avD7poVbSWH16AjCpms5Td+NVkLTjjCfvH07gjFuTGE8pK5tw0I7TXkO9Xz3kvx+4R5tb4TBnJtMwYCOXFhhW2GeIiXGOrgY42bUpxidnGAgbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388387; c=relaxed/simple;
	bh=gbCMQM+2EJqlPRYv+UN/BoDTUoHBpLbF0fQbJ4OLHFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcMZvm4OhH9G6uD1T3kPnrk2am/+9xQyTyt2RHYS7nkdd0g5X82nEK5QUE5393LQbD9Br+Ns2wjR3WyizDEmJfm/uMAGyr3gK1aPqeHuYqvQrbe4++2+Q3iMoPrFCdGbAEZZz/lPb/Xmc6lqIHIr7AViFgaWW85UKUseGJB01js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fuq9kHYY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5381F00A3A;
	Sat, 13 Jun 2026 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388385;
	bh=gFpzhflmxkJ0n9PiuwQpTF7It8qCwit+HO/6VW23vsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fuq9kHYYWBf5jP5hFzRR7Rt7FIQ5kDiyeWQNkYKvadTkwEgz22sfC7Vn66UCevd7o
	 oFU9nfhiqSJe4juw02h5EqJKcVO0qaciRT6DxSweko4cHg+3NDmk++UkTfDOoXIk1A
	 748KsASZ6KH5K6ycgVqwANycVNHVusW5LgEIuFcmDyKUTHTsi+YPQrJkhryFXEkoN+
	 W80R4VtivqnW8pK7OLgx1Rz56BQ/7OgBAEqxYPT+4aP9clo1h2Tpb5gZgfC74ot0b2
	 xyr0UgUpw/o6HgNnkJqB8/sDrSam9XqCi6Z845kHuOZeVDJO3mKSjP7+q35GADagGn
	 O0ApIBob5OnNw==
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
Date: Sat, 13 Jun 2026 15:06:24 -0700
Message-ID: <20260613220624.220186-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299068-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E12267FE08

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: add support for phylink

This commit transfers the r8169 driver from the phylib framework to
phylink, in order to support fiber-mode cards whose link status/speed
cannot be read from standard PHY registers.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 560f987437b6..615bd4107359 100644
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

[High]
Does this still enforce the "Chip doesn't support pause in jumbo mode"
constraint that the comment describes?

Looking at phylink_create() in drivers/net/phy/phylink.c, pl->supported is
initialized once via linkmode_fill() + phylink_validate() and is not
re-derived from config->mac_capabilities afterwards. Pause negotiation is
driven by pl->link_config.pause and the PHY's advertising bits, neither of
which is updated when rtl_jumbo_config() toggles mac_capabilities.

In rtl8169_change_mtu() the phylink_stop()/phylink_start() cycle re-runs
phylink_mac_initial_config() against the cached pl->link_config, so
Pause/Asym_Pause remain advertised after MTU is raised above ETH_DATA_LEN.

Compared to the old code which actively cleared Pause/Asym_Pause from
tp->phydev->advertising and called phy_start_aneg() to force renegotiation,
should this branch instead be updating something that is actually consumed
on the next link-up, so that PAUSE is no longer advertised in jumbo mode?

[ ... ]

> @@ -5010,7 +4995,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  	/* Clear all task flags */
>  	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
>  
> -	phy_stop(tp->phydev);
> +	phylink_stop(tp->phylink);

[Medium]
Is the phylink conversion complete here?

After this commit the PHY is owned by phylink (connected via
phylink_connect_phy() / phylink_disconnect_phy()), but
net_device_ops.ndo_eth_ioctl still points at phy_do_ioctl_running, so
SIOCGMIIREG / SIOCSMIIREG / SIOCGMIIPHY continue to go directly to the PHY
and bypass phylink.

phylink exports phylink_mii_ioctl() for exactly this case.  Mixing direct
phydev ioctl access with phylink-managed link state can let phylink's
cached state (pl->link_config, pl->phy_state) drift out of sync with the
actual PHY register state.

Should ndo_eth_ioctl be switched to phylink_mii_ioctl() as part of this
conversion?

[ ... ]

> @@ -5644,6 +5621,132 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
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

[Medium]
Is PHY_INTERFACE_MODE_INTERNAL the intended interface mode here?

Both the sfp_mode branch and the copper branch set phy_mode to
PHY_INTERFACE_MODE_INTERNAL, which makes the if/else look like a
copy-paste.  The previous r8169_phy_connect() picked
PHY_INTERFACE_MODE_GMII when supports_gmii was set and
PHY_INTERFACE_MODE_MII otherwise:

	phy_mode = tp->supports_gmii ? PHY_INTERFACE_MODE_GMII :
		   PHY_INTERFACE_MODE_MII;

PHY_INTERFACE_MODE_INTERNAL is conventionally used for PHYs integrated on
the same die as the MAC, whereas r8169's MAC-to-PHY link is logically
GMII/MII.

Phylink also derives interface-allowed link capabilities through
phy_caps_from_interface() in phylink_get_capabilities(), so the chosen
interface mode shapes which speeds and duplex modes are validated, and may
affect PHY-side EEE/clock-stop handling and rate matching.

Could the commit message explain why INTERNAL was selected for both arms,
or should the copper branch keep the GMII/MII selection?

