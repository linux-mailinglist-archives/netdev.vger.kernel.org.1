Return-Path: <netdev+bounces-254519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG/kNDfFemmY+QEAu9opvQ
	(envelope-from <netdev+bounces-254519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:25:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 341DBAB1A0
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E62153009F9E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7228C33557E;
	Thu, 29 Jan 2026 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6eLER3N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6321F0E34
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653557; cv=none; b=uNIUi7DLd2sxSoBzSS1KIdNvAEqiyoR94keUPnMuhBNXMhJ3dmPgNSnWpN+A36l1sEOeHtRBLh/hghcQw2MD5Ytij72xymXcGi9Nt6oArNL+qDqeCoSGpZbA4U4X2g6H0QEJrMRbxmjeS/3eeJLdXbeAzUQjCsAPiW9N/Cuo+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653557; c=relaxed/simple;
	bh=sxKbIJguZyPdfl7KRvy/w+9b4WqCgGOITcT6soe7Y6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1R+MeMNrk55pzJWxxTB4nGeVyuj0B/gwhrjrESJ1Ekkg38QLLAYainmxvdPibOgNYmusiDJ1e/HidtDDlD0Zr1EQh9iPtc7mWLflJrjrrPuGtLeYUg3/titredQ1SaAk9cqWHeV0aZrHY4On80AhD+bmQwEq+HSbEFTsLA1wv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6eLER3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EE7C4CEF1;
	Thu, 29 Jan 2026 02:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769653557;
	bh=sxKbIJguZyPdfl7KRvy/w+9b4WqCgGOITcT6soe7Y6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6eLER3NkhyurlYC/a9poDYzmOwIBLejT/VAol0tlDfioDdkoUlBOEUrXcyttGGYY
	 x7oU1vkOgg35IDr/B6jA9+xbcY/gwfglwW3WyDtrkpnXuPlakTKjCPSGAukqRzEjxv
	 R6crmNsTQYcI3G9bjDfKY6vN8TIyjam/WCWS3wbCwsfeUtijzhbwBM3rmvEPh0LZLV
	 MewXxGpSHXarB5To6YfJpyipTFIsRABHap9FFHddFnGejdXPwc/pllM65WG/3PtST3
	 hNF57u1AqfqB3kmRq7red6YCn+LonVgGokbHhXfBGP5aYoxc0CJOApDs8u6MZ5qtu6
	 AqjuKJ88ULcHw==
From: Jakub Kicinski <kuba@kernel.org>
To: ht@twx-software.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	f.fainelli@gmail.com,
	robh+dt@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [v1,3/3] net: dsa: microchip: add single-led-mode support for KSZ9477
Date: Wed, 28 Jan 2026 18:25:48 -0800
Message-ID: <20260129022547.300907-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128133842.1173406-4-ht@twx-software.de>
References: <20260128133842.1173406-4-ht@twx-software.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,vger.kernel.org,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254519-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 341DBAB1A0
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: microchip: add single-led-mode support for KSZ9477

This patch adds single LED mode support for KSZ9477 via a device tree
property. The mode is configured during MAC link-up for non-CPU ports
and includes a workaround for Errata Module 19.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index e5fa1f5fc09b..bef8ec51d948 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c

[ ... ]

> @@ -3909,6 +3920,24 @@ static void ksz_set_gbit(struct ksz_device *dev, int port, bool gbit)
>  	ksz_pwrite8(dev, port, regs[P_XMII_CTRL_1], data8);
>  }
>
> +static void ksz_enable_single_led_mode(struct ksz_device *dev, int port, struct phy_device *phydev)
> +{
> +	const u16 *regs = dev->info->regs;
> +
> +	ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x0002); /* Set up register address for MMD */
> +	ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0000); /* Select Register 00h of MMD */
> +	ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x4002); /* Select register data for MMD */
> +	ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0011); /* Write value 0011h to MMD */
> +
> +	/* According to KSZ9477S Errata DS80000754F (Module 19) 0xfa00 has to
> +	 * be written to the Debug Register 3 to enable Single-LED Mode.
> +	 */
> +	if (phydev->dev_flags & MICREL_KSZ9_LED_ERRATA)
              ^^^^^^

Can phydev be NULL here? The phylink framework passes phydev as NULL when
using fixed-link configurations (MLO_AN_FIXED mode). For example, if a
non-CPU port on KSZ9477 is configured with a fixed-link in device tree
instead of a real PHY, phylink_fwnode_phy_connect() returns early without
attaching a PHY, leaving pl->phydev as NULL.

When link comes up on such a port, phylink_link_up() calls the mac_link_up
callback with this NULL phydev, which then gets passed to this function.

> +		ksz_pwrite16(dev, port, regs[P_PHY_DIGITAL_DEBUG_3], 0xfa00);
> +
> +	dev_info(dev->dev, "port-%d: single-led mode enabled.\n", port);
> +}

[ ... ]

> @@ -3977,6 +4006,9 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
>  	int port = dp->index;
>  	struct ksz_port *p;
>
> +	if (dev->single_led_mode && port != dev->cpu_port)
> +		ksz_enable_single_led_mode(dev, port, phydev);

The guard here checks single_led_mode and that port is not the CPU port,
but it does not verify that phydev is valid. On KSZ9477, ports 5 and 6
do not have internal PHYs (internal_phy[] is false), and if one of these
external ports is configured with fixed-link while cpu_port is the other
external port, this path will be taken with phydev=NULL.

[ ... ]
-- 
pw-bot: cr

