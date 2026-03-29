Return-Path: <netdev+bounces-272984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBj6EeR+yWnbyQUAu9opvQ
	(envelope-from <netdev+bounces-272984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:35:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC8353CEF
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 228743003982
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0337AA7E;
	Sun, 29 Mar 2026 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVkhNhF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C795EEBB;
	Sun, 29 Mar 2026 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774812897; cv=none; b=J4hYTp8GeZYel2UfFBPWPiY28fidE1Fmj7RasSaHqaVbifShcGIB9dYvMdz8FU4a01VLgvD+gkuHscNAMy0WRWE6WPe7YAMnScj7FZ28vLXNWtzLtrwscHvRW//vrTP9RfCLsoIwhu0en7pc/OIsMykB+iptlHNHXUTf0oj7o8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774812897; c=relaxed/simple;
	bh=HKyld4TxIknD6PhFGLzo/+fjmh3AuVgLmMrpmS5DxuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3w0iaXklctuYkYV7hv2md33ZJcl0QZ6RJMWCOsRgNj2f+WGQGVAXt1ek4e1622voga4wuKXCzgEYc4owKLClhrAU5o2m8h1C4vaFBMcNeOI+SsgjjyRnoVGCJ04SLRtZwfGFrNih9ft6p1MlZdqpQr5XtKp3U81iTfHZ1U67Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVkhNhF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F9DC116C6;
	Sun, 29 Mar 2026 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774812897;
	bh=HKyld4TxIknD6PhFGLzo/+fjmh3AuVgLmMrpmS5DxuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVkhNhF6EQHOl4NSjk6VtJs6YmVDZE1oQqzLCsAYVaSJSZ33YRXsBr9QU6mzP9nHw
	 yCLIuv8YEmld83K5lHNtqj5RWpOpNnxfGNYYel9Tt6HiIyrzeRfLzBcC3HwxJblQrW
	 TQjmzhejrwe+L7ti4gwygeR1tOtJXopwq+pMlqSWhjMviBSE16n0kcj1NnBcOoJx1S
	 iVcG/ibOBA2sUl6xYJJ44CtbaEz7gEpIsf9kV2YqBMEOQnGM8PnVKgbBopGeCmBAUG
	 zoq8XiujpSs+DmNQ6SDX5BtvwAL97Sy8EdBmRZ643RS9gkSt2I6OQQXJ7RQuZqn20v
	 1hcsFmyiRUT9g==
From: Jakub Kicinski <kuba@kernel.org>
To: mail@birger-koblitz.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] r8152: Add support for 5Gbit Link Speeds and EEE
Date: Sun, 29 Mar 2026 12:34:49 -0700
Message-ID: <20260329193449.2764517-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-rtl8157_next-v4-1-034312b12de5@birger-koblitz.de>
References: <20260324-rtl8157_next-v4-1-034312b12de5@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272984-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3FC8353CEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8152: Add support for 5Gbit Link Speeds and EEE

This commit adds support for 5GBit link speeds and EEE to the RTL8157
driver. It updates the speed and duplex settings, ethtool integration,
and EEE advertisement parameters to handle the new 5G capabilities.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 3b6d4252d34c..bab8e10e5f99 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -604,6 +604,7 @@ enum spd_duplex {
>  	FORCE_100M_FULL,
>  	FORCE_1000M_FULL,
>  	NWAY_2500M_FULL,
> +	NWAY_5000M_FULL,
>  };

Are there missing switch cases for NWAY_5000M_FULL in the hardware UPS
flag configurations, such as r8156_ups_flags? 

It looks like if a 5Gbps link is established, it might fall through to the
default case and leave the speed bits as 0. Since ups_flags_speed(0) maps
to FORCE_10M_HALF, this could cause the device's clock scaling and power
management features to be misconfigured for 10M Half-Duplex instead of the
5Gbps link.

[ ... ]

> @@ -725,6 +726,7 @@ enum spd_duplex {
>  #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
>  
>  enum rtl_register_content {
> +	_5000bps	= BIT(12),
>  	_2500bps	= BIT(10),

Is it intentional that the MAC idle speed down feature (IDLE_SPDWN_EN) is
disabled for _2500bps but remains enabled for _5000bps? 

In functions like rtl8156_enable, the code checks if the speed is _2500bps
to disable the idle speed down feature, but the new _5000bps constant is
not included in those checks. This might cause latency spikes or instability
at 5Gbps if the power-saving feature is enabled.

[ ... ]

> @@ -6343,15 +6356,20 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  				r8152_mdio_write(tp, MII_CTRL1000, new1);
>  		}
>  
> -		if (tp->support_2500full) {
> +		if (tp->support_2500full || tp->support_5000full) {
>  			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
> -			new1 = orig & ~MDIO_AN_10GBT_CTRL_ADV2_5G;
> +			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G);
>  
>  			if (advertising & RTL_ADVERTISED_2500_FULL) {
>  				new1 |= MDIO_AN_10GBT_CTRL_ADV2_5G;
>  				tp->ups_info.speed_duplex = NWAY_2500M_FULL;
>  			}
>  
> +			if (advertising & RTL_ADVERTISED_5000_FULL) {
> +				new1 |= MDIO_AN_10GBT_CTRL_ADV5G;
> +				tp->ups_info.speed_duplex = NWAY_5000M_FULL;
> +			}
> +

Could this unintentionally advertise 5GbE on a 2.5GbE-only adapter if
userspace requests it? 

The earlier check in this function:

		if (!(advertising & support))
			return -EINVAL;

only ensures that at least one supported speed is requested, but it does
not strip unsupported speeds from the advertising mask. Since this block
is now entered when support_2500full is true, checking the advertising mask
for RTL_ADVERTISED_5000_FULL without verifying tp->support_5000full could
erroneously write the 5G bit to the PHY and misconfigure the hardware
state.

[ ... ]

> @@ -8793,6 +8814,19 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
>  			cmd->base.speed = SPEED_2500;
>  	}
>  
> +	if (tp->support_5000full) {
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +				 cmd->link_modes.advertising,
> +				 ocp_reg_read(tp, OCP_10GBT_CTRL) & MDIO_AN_10GBT_CTRL_ADV5G);
> +
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +				 cmd->link_modes.lp_advertising,
> +				 ocp_reg_read(tp, OCP_10GBT_STAT) & MDIO_AN_10GBT_STAT_LP5G);
> +
> +		if (is_speed_5000(rtl8152_get_speed(tp)))
> +			cmd->base.speed = SPEED_5000;
> +	}

Since 5G adapters like the RTL8157 will have both support_2500full and
support_5000full set, will this result in duplicate blocking USB control
transfers? 

The ocp_reg_read calls for OCP_10GBT_CTRL and OCP_10GBT_STAT, along with
rtl8152_get_speed, are also executed in the preceding support_2500full
block. Reading these into local variables before the capability checks
would avoid the overhead of duplicate hardware accesses.

[ ... ]

> @@ -8994,6 +9032,13 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>  			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
>  	}
>  
> +	if (tp->support_5000full) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, eee->supported);
> +
> +		if (speed & _5000bps)
> +			linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, common);
> +	}

In r8153_get_eee, the reading of OCP_EEE_ADV2 and OCP_EEE_LPABLE2 is
performed inside the if (tp->support_2500full) block that precedes this new
code. 

Since those registers contain the EEE capability bits for both 2.5G
and 5G speeds, what happens if a device has support_5000full enabled but
support_2500full disabled? It looks like the registers would never be read,
and the 5Gbps EEE capabilities would fail to populate correctly.
-- 
pw-bot: cr

