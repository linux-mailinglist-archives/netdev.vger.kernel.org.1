Return-Path: <netdev+bounces-261071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNAXNExUn2nXaAQAu9opvQ
	(envelope-from <netdev+bounces-261071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:58:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3F19CFC8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44E7D3023A65
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9D33EDADB;
	Wed, 25 Feb 2026 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os243N9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB53ED11F;
	Wed, 25 Feb 2026 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049480; cv=none; b=Lv6LmhwsejIcr0/MX3QbaRX9DrOAinvYvbRDzkTE71gfLKAcW73IS+xzLIQXvx96Rbcm+gGiDMn9lnrs6ffppufXCeimr2GY0nzWTdod1r5ItnJivE1pPCr8UMVfjvuHvke54LOf7b4oE96uh6YK1eXeB4mWszfEIdlEhI1cxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049480; c=relaxed/simple;
	bh=tKs53SdgZniVLnMwFFA4inAvO+o9YIMabotBZvIKvFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEd96F3dBJ2k3u5AODlnmgAH8YT4Km0yS/tzT0GohIZS0rk+E+ReEeDCsXSVE8y/mb0rkYgmPfM6B9CbPBdRMLM1a9zE7XoRwhnuAee//L/GCHWR/nImxi58xw2Aci0xSkkdxm6VUZ3w0Dircrf6meRyhD1j7VZnbQdSpj3lLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os243N9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42811C116D0;
	Wed, 25 Feb 2026 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772049480;
	bh=tKs53SdgZniVLnMwFFA4inAvO+o9YIMabotBZvIKvFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=os243N9OzVS+feuW5r31nBnTt9qToFQ8m9CpAa8e9EEpT0kfDkXQrvYNjloWCcswD
	 NExCZ5cI8bJMKN+oMiAsZwatsbpghLB7p1AJYlxBFBQL8YLCFoKsqQAnhqGCTvFFj5
	 9SRb+TPDabySZHbqKDaEIRCbn2gmObuYSx481JYQb6VocJBuaImsgzecD22HR/rXdo
	 trRHlQnfb4T/HC60A4lD0NSeSPI/GARktHX15NmCPKf3dLQ+ILZlNSty0+pm2rpOR9
	 oO7SRdMKZsHYk0ULMuf7MTtd1O4oBb43ZyMpTazH+2w9V/ocUxbsN7/Z/2oPp77A+t
	 9GTns/wMObwgA==
From: Simon Horman <horms@kernel.org>
To: mail@birger-koblitz.de
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	opensource@vdorst.com
Subject: Re: [net-next,v2] r8152: Add 2500baseT EEE status/configuration support
Date: Wed, 25 Feb 2026 19:48:49 +0000
Message-ID: <20260225194848.188081-2-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224-b4-eee2g5-v2-1-cf5c83df036e@birger-koblitz.de>
References: <20260224-b4-eee2g5-v2-1-cf5c83df036e@birger-koblitz.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261071-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CC3F19CFC8
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
r8152: Add 2500baseT EEE status/configuration support

The r8152 driver supports the RTL8156, which is a 2.5Gbit Ethernet
controller for USB 3.0, for which support is added for configuring and
displaying the EEE advertisement status for 2.5GBit connections. The
patch also corrects the determination of whether EEE is active to include
the 2.5GBit connection status and make the determination dependent not on
the desired speed configuration (tp->speed), but on the actual speed used
by the controller.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 8d36162f36df..3df1a1f4a350 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -8922,7 +8924,8 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>
>  static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>  {
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
> +	u16 speed = rtl8152_get_speed(tp);
>  	u16 val;
>
>  	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);

This isn't a bug, but the variable declarations are not in reverse
Christmas tree order. Simon Horman's AI review raised this in v1, you
acknowledged it and said it would be fixed in v2, but the ordering issue
remains. The longest line should come first, followed by shorter lines.
Should be:

	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
	u16 speed = rtl8152_get_speed(tp);
	u16 val;

(Reference: https://lore.kernel.org/all/20260224170206.146491-3-horms@kernel.org/)

[ ... ]

> @@ -8956,7 +8968,8 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
>
>  static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>  {
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
> +	u16 speed = rtl8152_get_speed(tp);
>  	u16 val;
>
>  	val = ocp_reg_read(tp, OCP_EEE_ABLE);

Same reverse Christmas tree order issue here. The same pattern should be
applied as in r8152_get_eee().

[ ... ]

> @@ -8968,10 +8981,29 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>  	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
>  	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
>
> +	if (tp->support_2500full) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, eee->supported);
> +
> +		val = ocp_reg_read(tp, OCP_EEE_ADV2);
> +		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);
> +
> +		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
> +		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
> +
> +		if (speed & _2500bps)
> +			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
> +	}
> +
>  	eee->eee_enabled = tp->eee_en;
>
> -	linkmode_and(common, eee->advertised, eee->lp_advertised);
> -	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
> +	if (speed & _1000bps)
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, common);
> +	if (speed & _100bps)
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
> +
> +	linkmode_and(common, common, eee->advertised);
> +	linkmode_and(common, common, eee->lp_advertised);
> +	eee->eee_active = !linkmode_empty(common);
>
>  	return 0;
>  }

The eee_active determination logic is now duplicated between
r8152_get_eee() and r8153_get_eee(). Both functions convert speed
register bits to linkmode bits, AND with advertised and lp_advertised,
and test emptiness in the same way. Would it make sense to factor this
into a shared helper to reduce maintenance burden?

> @@ -9512,6 +9544,7 @@ static int rtl_ops_init(struct r8152 *tp)
>  	case RTL_VER_11:
>  		tp->eee_en		= true;
>  		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
> +		tp->eee_adv2		= MDIO_EEE_2_5GT;
>  		fallthrough;
>  	case RTL_VER_10:
>  		ops->init		= r8156_init;

[ ... ]

> @@ -9537,6 +9570,7 @@ static int rtl_ops_init(struct r8152 *tp)
>  	case RTL_VER_15:
>  		tp->eee_en		= true;
>  		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
> +		tp->eee_adv2		= MDIO_EEE_2_5GT;
>  		ops->init		= r8156b_init;
>  		ops->enable		= rtl8156b_enable;
>  		ops->disable		= rtl8153_disable;

Does RTL_VER_15 support 2.5G links? Looking at the code, only RTL_VER_12
and RTL_VER_13 set tp->support_2500full before falling through, but
RTL_VER_15 does not. With this change, tp->eee_adv2 = MDIO_EEE_2_5GT is
set for VER_15.

When r8156_eee_en() is called for a VER_15 device with EEE enabled:

static void r8156_eee_en(struct r8152 *tp, bool enable)
{
	u16 config;

	config = ocp_reg_read(tp, OCP_EEE_ADV2);

	if (enable && (tp->eee_adv2 & MDIO_EEE_2_5GT))
		config |= MDIO_EEE_2_5GT;

The condition (tp->eee_adv2 & MDIO_EEE_2_5GT) will be true, causing
MDIO_EEE_2_5GT to be written into the OCP_EEE_ADV2 hardware register.
This would advertise 2.5G EEE capability to the link partner on a device
that does not support 2.5Gbit links.

Should the eee_adv2 initialization be moved into the RTL_VER_12/13 block
(before the fallthrough), or should RTL_VER_15 be given eee_adv2 = 0 to
remain consistent with its lack of support_2500full?

