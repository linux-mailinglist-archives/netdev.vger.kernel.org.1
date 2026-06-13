Return-Path: <netdev+bounces-299070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNEwC4/VLWoIlAQAu9opvQ
	(envelope-from <netdev+bounces-299070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:11:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223567FE3F
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:11:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C6DesKGi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299070-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299070-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C819307BD37
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A763A6F05;
	Sat, 13 Jun 2026 22:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150BB3A6F19;
	Sat, 13 Jun 2026 22:06:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388392; cv=none; b=YcitDFLjPkm+L2Ywo8Oe3kHMKzFDb1YWDHRbSGpJVtak0WOMO212Z0VL6/gspTVL87sFMZwmpsGLJkRXVoD0SpGRTl6oOMwvHsQQNt/FeHLeiXQGU6821WrL3XrczjwSHRvU5o/nm80XorB0jvmpM4xbq7SCYg/WIPAPnmkFBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388392; c=relaxed/simple;
	bh=G8pYTqSn8nHdV0rd4tD/FhdFVegrmjphmnW83EifO+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lO+4dMpFq1JiqiAS/KdH6M7728wo0P+c7x3tcsTO0zQyQkgAjeE3gOagMTkexE3pfFGJIcIxTqTuFL/6mU7gp0JJ0CzshTxAqGmBt9Q/e4RQc8u9pCpBYaE4dbMMoM4KexgkaWkcZarQ+VMiS6MtDyvk7lj/ho8Pv0H5yLSD0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6DesKGi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9E11F00A3A;
	Sat, 13 Jun 2026 22:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388388;
	bh=P/vKx7xQTq6u2ejrRiY/G5o7WpO7DrX6RWZhM0zZW50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C6DesKGi+iTbcLM7FQbgytulBtkifIdszBlcz6cZawR6BD1A23mTysaVz4GqHc9fZ
	 He68VuLFPaKE20wGr0NfXOpyfDzE6boNO/u99RtJ+Yfuwlc5+WHyPbZVpJLBrlu+bo
	 umJMgRVEawOCr1qRoFKJhA96NRPUsh+5wXQP3JnMKwPJsIOvDfMCSVY6eOEioSSRkP
	 6cnzhuO8+0Bad+Wasq//JEiF2UbklHAwew9Bcs+cpJjJGckG4IEdzjnbzLAX1t0AKz
	 cBhKI5rt1C5ARjtXCg7YciTqMnNpXEpBx8bPRYqmCPtDa+bmVSNV75IAmP5zUB23dX
	 ZHj51hRWGrh1A==
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
Subject: Re: [PATCH net-next v2 5/6] r8169: add ltr support for RTL8116af
Date: Sat, 13 Jun 2026 15:06:27 -0700
Message-ID: <20260613220627.220252-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611094345.880-6-javen_xu@realsil.com.cn>
References: <20260611094345.880-6-javen_xu@realsil.com.cn>
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
	TAGGED_FROM(0.00)[bounces-299070-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8223567FE3F

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: add ltr support for RTL8116af

This patch adds LTR programming for RTL8116af so the link can enter L1.2,
which is needed for the system to reach C10. The change extends
rtl_enable_ltr() with a new case for RTL_GIGA_MAC_VER_52, adds a global
SEND_LTR_MSG write at the end of rtl_enable_ltr(), and modifies several
unrelated registers in rtl_hw_start_8117().

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index a73c0215b240..a49e7a8d8f4d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -349,11 +349,13 @@ enum rtl_registers {
>  	ALDPS_LTR	= 0xe0a2,
>  	LTR_OBFF_LOCK	= 0xe032,
>  	LTR_SNOOP	= 0xe034,
> +	SEND_LTR_MSG	= 0xe038,
>  
>  #define ALDPS_LTR_EN			BIT(0)
>  #define LTR_OBFF_LOCK_EN		BIT(0)
>  #define LINK_SPEED_CHANGE_EN		BIT(14)
>  #define LTR_SNOOP_EN			GENMASK(15, 14)
> +#define LTR_MSG_EN			BIT(0)
>  };
>  
>  enum rtl8168_8101_registers {
> @@ -3153,8 +3155,22 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
>  		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
>  		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
>  		break;
> -	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>  	case RTL_GIGA_MAC_VER_52:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
> +		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
> +		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
> +		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xe0a6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xe0a8, 0x9003);
> +		break;

[High]
The new case is selected purely on tp->mac_version == RTL_GIGA_MAC_VER_52,
but per the chip_info table that mac_version covers both the existing
RTL8168fp/RTL8117 and the new RTL8116af. Should this case use
rtl_is_8116af() to distinguish the two, the way other 8116af-specific
paths in the driver already do?

Two behavioural deltas show up for RTL8117 with this change:

  - the previous (VER_46..VER_48 | VER_52) fallthrough caused VER_52
    to execute

        RTL_W8(tp, COMBO_LTR_EXTEND,
               RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);

    which is silently dropped for VER_52 here.

  - new writes to OCP 0xe0a6 and 0xe0a8 are now performed on every
    VER_52 device, including pre-existing RTL8117 hardware that the
    old code never poked.

Is the intent that the new sequence supersedes the old RTL8117 LTR
programming for all VER_52 chips, or only for RTL8116af? If the former,
could the commit message explain why the existing RTL8117 sequence was
wrong, and should this be a separate patch?

> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>  		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
>  		RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
>  		fallthrough;
> @@ -3174,6 +3190,7 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
>  	}
>  	/* chip can trigger LTR */
>  	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
> +	r8168_mac_ocp_modify(tp, SEND_LTR_MSG, 0x0000, LTR_MSG_EN);
>  }

[Medium]
This new write sits after the switch, so it runs for every case that
does not hit the default return: VER_46..VER_48, VER_51, VER_52,
VER_61..VER_66, VER_70 and VER_80. The commit message describes the
change as RTL8116af-specific, but the resulting behaviour pokes
SEND_LTR_MSG bit 0 on every modern Realtek MAC handled by this driver.

Does OCP 0xe038 bit 0 have identical "send LTR message enable"
semantics across the entire MAC_VER_46..LAST range, or has this only
been validated on RTL8116af? If the former, could that be stated in
the commit message; if the latter, should the write be gated on the
chip family it was tested on?

[ ... ]

> @@ -3732,7 +3751,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  
>  	rtl_eri_set_bits(tp, 0xd4, 0x0010);
>  
> -	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4f87);
> +	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4000);
> +
> +	r8168_mac_ocp_write(tp, 0xe098, 0xc302);
>  
>  	rtl_disable_rxdvgate(tp);

[High]
rtl_hw_start_8117() is dispatched for the entire VER_52 family
without any rtl_is_8116af() gating, so these changes affect existing
RTL8168fp/RTL8117 hardware and not just RTL8116af. None of the
modified registers (0x5f0, 0xe098, 0xea80, 0xe052, 0xd420) appear to
be LTR registers, yet the commit subject and body only discuss LTR
support for RTL8116af.

Could the commit message explain what each of these register changes
does and confirm they have been tested on existing RTL8117 hardware?
Should they be split into separate patches with their own
justifications?

>  
> @@ -3759,9 +3780,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  	}
>  
>  	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
> -	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
> -	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x045f);
> +	r8168_mac_ocp_write(tp, 0xea80, 0x0000);
> +	r8168_mac_ocp_modify(tp, 0xe052, 0x0009, 0x0000);
> +	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x045f);

[High]
The 0xe052 modify call has its mask and set arguments swapped:

    -    r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
    +    r8168_mac_ocp_modify(tp, 0xe052, 0x0009, 0x0000);

r8168_mac_ocp_modify() applies (data & ~mask) | set, so the old call
set bits 0 and 3 of 0xe052 while the new call clears them. Is this
semantic inversion intentional, and if so could the commit message
say so explicitly? On what hardware was the new behaviour validated,
given that VER_52 covers both RTL8168fp/RTL8117 and the new
RTL8116af?

>  
>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);

