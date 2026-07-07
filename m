Return-Path: <netdev+bounces-305418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TxIfFdvfTGqLrQEAu9opvQ
	(envelope-from <netdev+bounces-305418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:15:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3E71AD90
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=fbct+YP2;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305418-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305418-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB533013484
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50003F58C9;
	Tue,  7 Jul 2026 11:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90783E6392
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 11:10:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422616; cv=none; b=Qcu+msxGWmq11Kh2mQ/nXtuTjeVNhZmmj8L0JM9hwh9lc3iZ5+5+/or3tblfQqiLI69zUbG4IqyLz9WuveHCANyG8SRbqSjSjHpy0mWvt3YpnWrBI8nAGD1DNoI6SxdlndMk5WWnatsRWvmdPwfvkivTvk72CraEr42VAxZS4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422616; c=relaxed/simple;
	bh=HbrxnkhkBloL8pgj3H5uTbv6oVtfAv7MakqvR3BMI3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYycVru0CTxMxjZh6VKjRwsYfWnh2h7KpkYwz54IHvF78QlVFREsl87GmENdeE4lznIcACdx8Mbx8QiGYS2HZR68M7QEdvxOtaco75pK5CUlHLyq8+4d3UJMt/Qicoz54WugPWNWO/qolBCEe7RFx9kG3Y7pEIk2OTc0tkN3V30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fbct+YP2; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3647C1A0EB7;
	Tue,  7 Jul 2026 11:10:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 087C7601A3;
	Tue,  7 Jul 2026 11:10:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42C9F11BC150A;
	Tue,  7 Jul 2026 13:10:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783422610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6XCXmOjphQkcXnm91iLeRRCWQdQMqmpt67g9KghxGOI=;
	b=fbct+YP2HBJM3/5c0slj9Qm0giNfSh4VoTfPYOYLPwSxPGzVs9tCCYO0eqHRy7vfJUuNoK
	hRrq8rh7Qt8PXJr1tMrNckUDtyofg5X/KIk10vevbVPXmEOTOd3SF8FEUUUvhwx0sl/+lQ
	zcLcvvIcLZsxlLHXfVqp+7/FJh8b/lxQOkWgy5pvU9r/GLpAdyNcLIggcn3Txdvw0sjfqX
	qpSO0xjE/K6rbOp1Kt3SGQCOvo6H/AzrJGT2ciGuT3M5RoQwu/2ypvq5+kxErSb624GmGV
	9r23o/ZvzpGg6c9xbko+Xj7eHCPNTfDHiO4PRieyX/zyZImM4toHBaopHIa7DQ==
Message-ID: <a5dcf2a7-8291-4ac9-bbf4-513b43524f10@bootlin.com>
Date: Tue, 7 Jul 2026 13:10:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/8] net: phy: phylink: add helper to modify
 pause
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, linux@armlinux.org.uk, enelsonmoore@gmail.com,
 daniel@thingy.jp
References: <20260707091637.371-1-javen_xu@realsil.com.cn>
 <20260707091637.371-3-javen_xu@realsil.com.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260707091637.371-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305418-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:linux@armlinux.org.uk,m:enelsonmoore@gmail.com,m:daniel@thingy.jp,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,armlinux.org.uk,gmail.com,thingy.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0B3E71AD90

Hi, 

On 7/7/26 11:16, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> For Realtek nics, when we enable jumbo, pause are not supported. So we
> must check the pause capabilities from ourself and lp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v5:
>  - no changes, new file
> ---
>  drivers/net/phy/phylink.c | 66 +++++++++++++++++++++++++++++++++++++++
>  include/linux/phylink.h   |  2 ++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 59dfe35afa54..c450ee33b75c 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1828,6 +1828,72 @@ int phylink_set_fixed_link(struct phylink *pl,
>  }
>  EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
>  
> +/**
> + * phylink_set_mac_capabilities() - Dynamically update MAC capabilities
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + * @mac_capabilities: the new MAC capabilities mask
> + *
> + * This function allows a MAC driver to dynamically change its capabilities,
> + * such as losing/gaining Pause frame support based on MTU size.
> + * It recalculates supported link modes and triggers renegotiation if needed.
> + */
> +void phylink_set_mac_capabilities(struct phylink *pl, unsigned long mac_capabilities)

This is a step in the right direction, but this is maybe too generic, as
mac_capabilities represent both the MAC's Pause support as well as Speed/Duplex
support.

The speed/duplex parts shouldn't be changed dynamically, I think the helper
needs to be specific in its naming that this is strictly about changing the MAC's
Pause / Asym capabilities dynamically, and be either passed some booleans, one for
rx one for tx, or fail if we try to change anything other than MAC_SYM_PAUSE and
MAC_ASYM_PAUSE.

Maybe something like "phylink_update_mac_pause_capabilities" ?

The 'update' part makes it clear this may trigger re-negotiation.


Maxime

