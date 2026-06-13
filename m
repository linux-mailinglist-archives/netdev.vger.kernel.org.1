Return-Path: <netdev+bounces-299065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aAUGN7XULWqokwQAu9opvQ
	(envelope-from <netdev+bounces-299065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:07:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6367FDD0
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:07:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eCVD3ULw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299065-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299065-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B825B304B28E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F83A785A;
	Sat, 13 Jun 2026 22:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5383A75A2;
	Sat, 13 Jun 2026 22:06:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388365; cv=none; b=g7r987wbwQoXLPwTPRUwdexIs+svhKh5Mq0Qw5NJgvzlxYc4AC85kp9FCblKMSeQc59O54XtBXqe+aXIjddh/v721KwMb75MIiAPEsLcBTX9YYZWsVm9Ux6iX71oO6IoLVV7jDYQr82xnFdyHd53poWU2b3VvrMBOfxVIQkITCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388365; c=relaxed/simple;
	bh=fVoIX8fGUd/mxcBV+RP+xkM94q8/1XqbACF5z4t81tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wu9D5g4H6wh670RQR5ljdo9MJiLhq7xAPobTJGx6WQ0V/KegUleUq9uTdn89LeQT2tWwkfxQXrkrzMkruEtJ6z1aEiGyhxVW4IjxTcyp1BAb8rOZNFm8kpG2KX2XVv5iPzx6bwuQpB3cdLgDimWUfz9t+u+SEibNsq6Zh1qWk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCVD3ULw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313D81F00A3A;
	Sat, 13 Jun 2026 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388363;
	bh=ZNBuc9LO0TVPernc1+y9mCATM6GnjcypbVL+xZWKplI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eCVD3ULwoqYi1ASR48UudXHUazG4rRUZgs/CcpVMTwParn4fIOCv7NmYgMVDNfuil
	 yPtbLXnt3Q3d6w/hHgP8um7V7Da1LSskaZu7PuggG5oNw0y8wtGfYsK+Lop2ogSHlh
	 Snx1xCTkWq+4nrHobDP82NZ6KYMNVEdXtCrFenjrPNX2u19cdxiPX68kYxMqAmnWEX
	 UPhAFAnRcJiRpCj6C7DnqLQC3O0vJ+9sZPtL51WftKjTXIUPMELt+SU67ZWGp3ssij
	 a7oJo/mIlgZa0M1zOuv613FlWLbGRCO8DCEsGYygmTYrtZ1W7qUxu16kYKoTOtwpWQ
	 Jrxuar2rkb3jQ==
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
Date: Sat, 13 Jun 2026 15:06:02 -0700
Message-ID: <20260613220602.219782-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299065-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 48C6367FDD0

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: add ltr support for RTL8116af

This patch adds ltr support for RTL8116af, enables RTL8116af enter l1.2
state. This makes sense for the system to enter c10 state.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index a73c0215b2407..a49e7a8d8f4da 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
[ ... ]
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

[Severity: High]
Does this completely redefine the LTR enable sequence for all devices using
RTL_GIGA_MAC_VER_52? Since older devices like RTL8117 also use this MAC
version, could this cause regressions for them by replacing the previous
fallthrough behavior? Should there be a check to ensure this only runs for
the newly added RTL8116af?

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
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>  		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
>  		RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
>  		fallthrough;
> @@ -3174,6 +3190,7 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
>  	}
>  	/* chip can trigger LTR */
>  	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
> +	r8168_mac_ocp_modify(tp, SEND_LTR_MSG, 0x0000, LTR_MSG_EN);

[Severity: High]
This unconditionally modifies SEND_LTR_MSG at the end of rtl_enable_ltr(),
which is called for multiple MAC versions. Was it intended to apply globally
to all chips, or should this change also be restricted to RTL8116af?

>  }
>  
>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
[ ... ]
> @@ -3732,7 +3751,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  
>  	rtl_eri_set_bits(tp, 0xd4, 0x0010);
>  
> -	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4f87);
> +	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4000);
> +
> +	r8168_mac_ocp_write(tp, 0xe098, 0xc302);

[Severity: High]
Since older devices also use rtl_hw_start_8117(), will applying these register
changes unconditionally to all RTL_GIGA_MAC_VER_52 devices affect the hardware
initialization of existing devices? Could we add a check to restrict these
tweaks specifically to RTL8116af?

>  
>  	rtl_disable_rxdvgate(tp);
>  
> @@ -3759,9 +3780,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  	}
>  
>  	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
> -	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
> -	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
> +	r8168_mac_ocp_write(tp, 0xea80, 0x0000);
> +	r8168_mac_ocp_modify(tp, 0xe052, 0x0009, 0x0000);
> +	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x045f);

[Severity: High]
Like the changes above in rtl_hw_start_8117(), these magic register updates
will be applied to RTL8117 as well. Can this break link stability or ASPM
for existing devices by replacing their expected register values?

>  
>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);

