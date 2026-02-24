Return-Path: <netdev+bounces-260600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJSbN3TanWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:05:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA918A479
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0F10300598D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD63A7F6C;
	Tue, 24 Feb 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnX3JoV1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5292BDC0B;
	Tue, 24 Feb 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952752; cv=none; b=p8T5yfX6oIx0FIH70wEib3ZagfA4NYIWE1nHmZbfiGzKd17eFDnH++gVqWwVeWynXCgbCbP+lEH8gnBsf4PdsefViAvt3QxLcBTLEeAdWto9l8GVuy7IslTMxfIao254SjFeSBiE59RPVQDBHrJj/dYjy35LsW2wMnLpSD0LyfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952752; c=relaxed/simple;
	bh=GER6Gyyz5eCF6X89SXQDk16nKN8AHdPtJ7A5xe6CvkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMkNyu/d3UCZQGfHWm+CL+ylNiIYESX4R/qiPDMxbWb2YseEqaD0Xpr8iHMnlyC0nJLQ7PZfLjx52pqWzbUky/RD2a0FLQFqsuEL+VlIQ8H6RD0zAOITqzV7eWmUu3zfMbAmP4uzDuZ4hPzH1TDY2WEXO8SJn3WKThIdd5iY5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnX3JoV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB22C116D0;
	Tue, 24 Feb 2026 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771952752;
	bh=GER6Gyyz5eCF6X89SXQDk16nKN8AHdPtJ7A5xe6CvkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnX3JoV1frtuDKYhkJ9ibXzDIvdBUuqnhfR2PMUoLR7MruwaxXazhC0Yw0mK4DNml
	 sD99SJbrgozaJ3D2o7pePirq3IO8LHhngg+bRfzP01Rg19749PDWgQ8j+sKLpKogsq
	 VbSYv06sJls6LKfzg3/bigCnPP87m9/OzeeVhONye31pMmsbU/6PHCHeYPIDK3sQs9
	 0XwpY6sbXbbpSq//ryJtZ/8BotaspkdGeP1chMLqI6VaOEpNKyT53QOGfwXSuJSYsC
	 Luqtkg++5L5/rfudRYCy/o0+3xx4Frt48bISxnJDZ4rU8LURaH8tIIL2jGOPXGLV3Q
	 2sKq4FO9h4v0Q==
From: Simon Horman <horms@kernel.org>
To: mail@birger-koblitz.de
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	opensource@vdorst.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net
Subject: Re: [net-next] r8152: Add 2500baseT EEE status/configuration support
Date: Tue, 24 Feb 2026 17:02:08 +0000
Message-ID: <20260224170206.146491-3-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223-b4-eee2g5-v1-1-7006b537b144@birger-koblitz.de>
References: <20260223-b4-eee2g5-v1-1-7006b537b144@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260600-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 49DA918A479
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
> index 8d36162f36df..a831acd385cd 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -8924,6 +8926,7 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>  {
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
>  	u16 val;
> +	u16 speed = rtl8152_get_speed(tp);

Simon says: please declare local variables in reverse xmas tree order -
            longest line to shortest.

>
>  	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
>  	mii_eee_cap1_mod_linkmode_t(eee->supported, val);
> @@ -8936,8 +8939,14 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>
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

Does this code read uninitialized memory? The 'common' bitmap is declared
via __ETHTOOL_DECLARE_LINK_MODE_MASK(common), which expands to
DECLARE_BITMAP -- an uninitialized stack array:

unsigned long common[BITS_TO_LONGS(__ETHTOOL_LINK_MODE_MASK_NBITS)];

The new code conditionally sets individual bits via linkmode_set_bit(),
which calls __set_bit() to set a single bit position. This leaves all
other bits in the array containing whatever garbage was on the stack.

Then linkmode_and(common, common, eee->advertised) reads all the
uninitialized bits when performing the bitwise AND operation.

The old code was safe because it used linkmode_and(common,
eee->advertised, eee->lp_advertised), which fully wrote 'common' from two
initialized bitmaps before reading it.

With uninitialized stack data, eee_active could be incorrectly reported as
true if garbage bits happen to overlap with the advertised and
lp_advertised bitmasks.

>
>  	return 0;
>  }
> @@ -8948,7 +8957,10 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
>
>  	tp->eee_en = eee->eee_enabled;
>  	tp->eee_adv = val;
> -
> +	if (tp->support_2500full) {
> +		val = linkmode_to_mii_eee_cap2_t(eee->advertised);
> +		tp->eee_adv2 = val;
> +	}
>  	rtl_eee_enable(tp, tp->eee_en);

[Simon says: I note that Daniel Golle flagged this issue already]

Is the user's 2500baseT EEE configuration actually applied to hardware?
The code stores the user's preference in tp->eee_adv2, but
rtl_eee_enable() never writes this value to the OCP_EEE_ADV2 register.

For RTL_VER_10-15 (the 2500full-capable chips), rtl_eee_enable() calls
r8156_eee_en() which unconditionally sets MDIO_EEE_2_5GT rather than using
tp->eee_adv2:

drivers/net/usb/r8152.c:r8156_eee_en() {
    ...
    if (enable) {
        ...
        set |= MDIO_EEE_2_5GT;
    } else {
        ...
        clr |= MDIO_EEE_2_5GT;
    }
    ocp_data = (ocp_data & ~clr) | set;
    ocp_reg_write(tp, OCP_EEE_ADV2, ocp_data);
}

Then rtl_eee_enable() writes only tp->eee_adv to OCP_EEE_ADV:

drivers/net/usb/r8152.c:rtl_eee_enable() {
    ...
    case RTL_VER_10: ... case RTL_VER_15:
        r8156_eee_en(tp, enable);
        ...
        ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);
        break;
}

The OCP_EEE_ADV2 register is never updated with tp->eee_adv2. This means
user attempts to selectively control 2500baseT EEE advertisement via
ethtool are silently ignored.

The cap1 path correctly writes tp->eee_adv to OCP_EEE_ADV. Shouldn't the
cap2 path similarly write tp->eee_adv2 to OCP_EEE_ADV2?

>
>  	return 0;
>  }
> @@ -8958,6 +8970,7 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>  {
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
>  	u16 val;
> +	u16 speed = rtl8152_get_speed(tp);
>
>  	val = ocp_reg_read(tp, OCP_EEE_ABLE);
>  	mii_eee_cap1_mod_linkmode_t(eee->supported, val);

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

The same uninitialized memory issue exists here in r8153_get_eee. The
'common' bitmap declared via __ETHTOOL_DECLARE_LINK_MODE_MASK is never
zeroed before individual speed bits are conditionally set with
linkmode_set_bit(). Then linkmode_and() reads the uninitialized garbage
bits.

This function affects RTL_VER_03 through RTL_VER_15, which is the majority
of supported devices.

