Return-Path: <netdev+bounces-269555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPyMFKsrvGn4twIAu9opvQ
	(envelope-from <netdev+bounces-269555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:00:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C82CF478
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38EEC325A89D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1C3EB819;
	Thu, 19 Mar 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPlA2Hou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC33E556B;
	Thu, 19 Mar 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939078; cv=none; b=YlLwG0DWp3CWv9zxHIoTqMs9nXFCMvzlwxGlcQt/drxsv1xnjDFAJVcEX30i3p1e3P4h8AvYagUl5LbuShbjKLSD8yJuwAczTTOQ4lZii9ACQ0LSx7JXSWxyniVhEXFalYqIOEBX1DJPIn0Vyo/sg6rUZAirSBHo3qZ9BMzbSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939078; c=relaxed/simple;
	bh=iL5eYh59l7EnTE8x2HzIToT3IPqQ1IexUOy86xguE08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPiIRQXNY2yMsA+pxAqH5snnBst2MGmcDzPtByrCB/Rgn19ON0KHwlcQXxOTy/X9iEsuVK70Kk5kFcRRXasOKrVWQKloPsK2qrhb6ieK83yCs++j4lSDKHBzS3baEUn7EyQ7Z8DBxB6nMWkRnOzdGpZ4oCz3snc3FcxNa6cLmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPlA2Hou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F142DC19424;
	Thu, 19 Mar 2026 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773939077;
	bh=iL5eYh59l7EnTE8x2HzIToT3IPqQ1IexUOy86xguE08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPlA2HouK74FyFpyPK9ywdOYDvERQ6UmBtZZHpbGU0zDT3ymIfszu/h/79KHRPoN8
	 ZqTyTVSXj8CfUiKKwUQF/dewe/ITDSnf8EusjAr0o9ucIq7YpcIgi0XZsIYYpz894x
	 VEB37gsyN9S8LnnrkqVHR85UJEWVkN1Vjr0mAvjw4xAeEm3RveRnmzSCL0RaYO7+qc
	 d1KJi+oPPJfYAPwaMc4hCgU1+bL5LeaNoljrsCrwdAJObwRDG26uPd5C7cN5oWAofl
	 FlRZhqOgrWlQDSPXgcX9FpJa1Axi3GkV4DPxO0TjKZ45rNnI5tyJDnYlegwhuTWefV
	 Qvc6F7o3bRg7A==
From: Simon Horman <horms@kernel.org>
To: mail@birger-koblitz.de
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net
Subject: Re: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds and EEE
Date: Thu, 19 Mar 2026 16:51:00 +0000
Message-ID: <20260319165100.1988286-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
References: <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269555-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: A46C82CF478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
r8152: Add support for 5Gbit Link Speeds and EEE

The RTL8157 supports 5GBit Link speeds. This commit adds support for this
speed in the setup and setting/getting through ethtool, along with 5GBit
EEE functionality for setup and ethtool get/set methods.

> The RTL8157 supports 5GBit Link speeds. Add support for this speed
> in the setup and setting/getting through ethool. Also add 5GBit EEE.
                                          ^^^^^^
This isn't a bug, but there's a typo: 'ethool' should be 'ethtool'.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 3b6d4252d34c..bab8e10e5f99 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6343,15 +6356,20 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  			r8152_mdio_write(tp, MII_CTRL1000, new1);
>  	}
>
> -	if (tp->support_2500full) {
> +	if (tp->support_2500full || tp->support_5000full) {
>  		orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
> -		new1 = orig & ~MDIO_AN_10GBT_CTRL_ADV2_5G;
> +		new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G);
>
>  		if (advertising & RTL_ADVERTISED_2500_FULL) {
>  			new1 |= MDIO_AN_10GBT_CTRL_ADV2_5G;
>  			tp->ups_info.speed_duplex = NWAY_2500M_FULL;
>  		}
>
> +		if (advertising & RTL_ADVERTISED_5000_FULL) {
> +			new1 |= MDIO_AN_10GBT_CTRL_ADV5G;
> +			tp->ups_info.speed_duplex = NWAY_5000M_FULL;
> +		}
> +
>  		if (orig != new1)
>  			ocp_reg_write(tp, OCP_10GBT_CTRL, new1);
>  	}

Does r8156_ups_flags() handle the new NWAY_5000M_FULL value?

Looking at r8156_ups_flags() in drivers/net/usb/r8152.c, the function
switches on tp->ups_info.speed_duplex:

static u16 r8156_ups_flags(struct r8152 *tp)
{
	u16 ups_flags = 0;

	if (tp->ups_info.green)
		ups_flags |= UPS_FLAGS_EN_GREEN;

	if (tp->ups_info.aldps)
		ups_flags |= UPS_FLAGS_EN_ALDPS;

	if (tp->ups_info.eee)
		ups_flags |= UPS_FLAGS_EN_EEE;

	if (tp->ups_info.flow_control)
		ups_flags |= UPS_FLAGS_EN_FLOW_CONTROL;

	if (tp->ups_info.eee_ckdiv)
		ups_flags |= UPS_FLAGS_EN_EEE_CKDIV;

	if (tp->ups_info._10m_ckdiv)
		ups_flags |= UPS_FLAGS_EN_10M_CKDIV;

	if (tp->ups_info.eee_cmod_lv)
		ups_flags |= UPS_FLAGS_EEE_CMOD_LV_EN;

	if (tp->ups_info._250m_ckdiv)
		ups_flags |= UPS_FLAGS_250M_CKDIV;

	switch (tp->ups_info.speed_duplex) {
	case FORCE_10M_HALF:
		ups_flags |= ups_flags_speed(0);
		break;
	case FORCE_10M_FULL:
		ups_flags |= ups_flags_speed(1);
		break;
	case FORCE_100M_HALF:
		ups_flags |= ups_flags_speed(2);
		break;
	case FORCE_100M_FULL:
		ups_flags |= ups_flags_speed(3);
		break;
	case NWAY_10M_HALF:
		ups_flags |= ups_flags_speed(4);
		break;
	case NWAY_10M_FULL:
		ups_flags |= ups_flags_speed(5);
		break;
	case NWAY_100M_HALF:
		ups_flags |= ups_flags_speed(6);
		break;
	case NWAY_100M_FULL:
		ups_flags |= ups_flags_speed(7);
		break;
	case NWAY_1000M_FULL:
		ups_flags |= ups_flags_speed(8);
		break;
	case NWAY_2500M_FULL:
		ups_flags |= ups_flags_speed(9);
		break;
	default:
		break;
	}

	return ups_flags;
}

When rtl8152_set_speed() sets tp->ups_info.speed_duplex = NWAY_5000M_FULL
and r8156_ups_en(enable=true) subsequently calls r8156_ups_flags(), the
switch falls through to the default case and no speed bits are set in the
UPS flags word.

Is the UPS power management configuration incorrect for 5Gbit link speeds
without a case for NWAY_5000M_FULL in r8156_ups_flags()?

This path is activated by the next commit in the series (58ba3b6c476d
'r8152: Add support for the RTL8157 hardware') which sets
support_5000full = 1.

[ ... ]

