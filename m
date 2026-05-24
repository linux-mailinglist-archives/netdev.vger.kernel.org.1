Return-Path: <netdev+bounces-291214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIrDE60lE2pq8QYAu9opvQ
	(envelope-from <netdev+bounces-291214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:22:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29B5C31A3
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAAF4302AD16
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5353AA1BD;
	Sun, 24 May 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="kHVhCBtW"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6D3A9D9F;
	Sun, 24 May 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639606; cv=none; b=nnwDzt9kXCaPcctft2tb1D6MBAQReRm4Krwonvu2R+7rg6dYhTuAxLMJxSAztr5sg24bGsTvcKmS/qnCt4GBZREBkJ+I3vO3lCsOkDj+QFc3Z73lqjGlIxAWL+mIMWSzvN6II5IRF3MLeXEtXUke94XATbTq7+5s3XIA4zdGKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639606; c=relaxed/simple;
	bh=tCcLR8Ur70P+Ln5v1vem27jgG+r+SbwD3TIHzu93G0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSxCPHG0wb+5R+lwLiqspuGmXu+X5X1YOG9bWZ3wGWOTdZJnaUWC3zIB/bOYbo+YUWVznsInMUOVoM1wDnuc2QOOY8PlDfP6ATLHvwS4OCIpYMaUZeUw0EDjKc4T4pkDd7nWW6SbKUXHX2hhJI+SoZ8Cu2mCzFhBuKMe9IEqI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=kHVhCBtW; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83DF6115B0C;
	Sun, 24 May 2026 18:19:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779639595;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/NCVTwd2pXSiDf9ftw/E9e+RCf1UFNF0DpfTxWTpLHI=;
	b=kHVhCBtWqyI34BOWXSZ0Wgu3uYcSu5aU9TX7C50N+yOmD8XVZ+aVhKnxt5cQCKNaPLTADU
	gkXzrgNCVzH032ayPYXEvexxJzB99O07/HbTXx344Tpyj3K2Bbmbe0z+1zH29GuL06BPLI
	Zxh1pxm4ZsfMTjELlTCmNLR/VMbly9qbUwAoU4wI+efwFnLKjoXV04GB7lDrrEElNv8Z7W
	cbxMb9NpXHE0S75vSuen4jiVMJWjYhh/5CG3YeM5ktxzm1LlC+jnSycryDmPTZ7iudl9zv
	5YmiEkxwJfLRuA2JLNUg5JAU/GaNCKXJ4HtA+EW7WLLOhF6xoQY1kThBR5YsMw==
Message-ID: <0a9433d4-6b4a-45d2-9625-c33d502ab674@nabladev.com>
Date: Sun, 24 May 2026 18:19:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291214-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA29B5C31A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/24/26 12:44 PM, Fidelio Lawson wrote:
> Hello,
> 
> This patch implements the “Module 3: Equalizer fix for short cables” erratum
> described in Microchip document DS80000687C for KSZ87xx switches.
> 
> According to the erratum, the embedded PHY receiver in KSZ87xx switches is
> tuned by default for long, high-loss Ethernet cables. When operating with
> short or low-loss cables (for example CAT5e or CAT6), the PHY equalizer may
> over-amplify the incoming signal, leading to internal distortion and link
> establishment failures.
> 
> Microchip documents two independent mechanisms to mitigate this issue:
> adjusting the receiver low‑pass filter bandwidth and reducing the DSP
> equalizer initial value. These registers are located in the switch’s
> internal LinkMD table and cannot be accessed directly through a
> stand‑alone PHY driver.
> 
> To keep the PHY‑facing API clean, this series models the erratum handling
> as vendor‑specific Clause 22 PHY registers, virtualized by the KSZ8 DSA
> driver. Accesses are intercepted by ksz8_r_phy() / ksz8_w_phy() and
> translated into the appropriate indirect LinkMD register writes. The
> erratum affects the shared PHY analog front‑end and therefore applies
> globally to the switch.
> 
> Based on review feedback, the user‑visible interface is kept deliberately
> simple and predictable:
> 
> - A boolean “short‑cable” PHY tunable applies a documented and
>    conservative preset (LPF bandwidth 62MHz, DSP EQ initial value 0).
>    This is the recommended KISS interface for the common short‑cable
>    scenario.
> 
> - Two additional integer PHY tunables allow advanced or experimental
>    tuning of the LPF bandwidth and the DSP EQ initial value. These
>    controls are orthogonal, have no ordering requirements, and simply
>    override the corresponding setting when written.
> 
> The tunables act as simple setters with no implicit state machine or
> invalid combinations, avoiding surprises for userspace and not relying
> on extended error reporting or netlink ethtool support.
> 
> This series contains:
> 
>    1. Support for the KSZ87xx low‑loss cable erratum in the KSZ8 DSA driver,
>       including the short‑cable preset and orthogonal tuning controls.
> 
>    2. Addition of vendor‑specific PHY tunable identifiers for the
>       short‑cable preset, LPF bandwidth, and DSP EQ initial value.
> 
>    3. Exposure of these tunables through the Micrel PHY driver via
>       get_tunable / set_tunable callbacks.
> 
> This version follows the design agreed upon during v3 review and
> reworks the interface accordingly.
> 
> This series is based on net-next.
Please note that I provided RBs for V6 already.

