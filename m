Return-Path: <netdev+bounces-293819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF7HLw2uHWondAkAu9opvQ
	(envelope-from <netdev+bounces-293819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:06:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA162246F
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27FE03452863
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F903BB690;
	Mon,  1 Jun 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="m1zwpgwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F7213E9C;
	Mon,  1 Jun 2026 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328617; cv=none; b=KWwZvOLULVvEJ1B3S7pLcuZ4fgrlGm5SzQASwU0JvEBsneHamtuNiTZjSV0wmUHmAEueBG/bIzduIBTIIyy+oD8cRl9dTiAF0Ilbo+s60o8X9q7nj4JS6ME61Xh1RfDOQmzq4+6AnZ1PE0S1faWx9cbOfw0PGBWJ/DBoBbMNsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328617; c=relaxed/simple;
	bh=QZ5A64AbPHpTabE09qPlAkl3BR7KJdWRnkf/p+FiGfo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tCqUlf3ArGWeFsCmO3HY+b/l5iOepTmclOYevhTDBE4kU/xvBfCmKvXIBjcYCy8UxWoMlaA1qXDRvMXowCDWrMSxfvaF2biH6vGZ8yv5muN99NLWFjtQOVmtxZFHrx+okMqQ4XDTpJOvXBIgZq0wg0gxlbhXcPZykds8m3QomlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=m1zwpgwx; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8364BA4C08;
	Mon,  1 Jun 2026 17:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780328610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uitTw5r+FjzP/teK02MYNuvZ6+HKUF13Y6sZDAeV5F4=;
	b=m1zwpgwxcHie/GpolPuWxORP8ZWo7JykVhePa6EwJRiUYkKOyvNcAV5efoKt1VVu1Ry3uF
	3n1Rsn0Mm3YS1quwx2zUacH0jNcOdvg0eZBpRyxIHz9+w1B2kfzcZRZrCG5qIQIk3Kh+G0
	bjcFM2D4MP0qBbljcMaoMdQ9QXKHL+k/hOOck6/jFfq5z2kxT1Zy73k8a5fUBXUE6R39cZ
	GZCLsu0emmO+ZvLa1ZAPisFxAFTXGpbzdjfI0woVbmL4ZR7+Jq0ayQjXy6wDi43o8t56sb
	vDpdtr/4bhDIczXM+Y4MUIrk0u8YGhEd+cP5nWRGXD5eMRbz0mtqsOjFq0teiA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 17:43:27 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
 <marex@denx.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fidelio Lawson
 <fidelio.lawson@exotec.com>, Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH net-next v9 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
Message-ID: <018a05a2cfffe4f9a7df608676ec554d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-293819-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com,nabladev.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:url,exotec.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 18DA162246F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fidelio

On 1.6.2026 17:19, Fidelio Lawson wrote:
> Hello,
> 
> This patch implements the KSZ87xx short cable erratum
> described in Microchip document DS80000687C for KSZ87xx switches
> and the following support article:
> 
> Link: 
> https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family
> 
> According to the erratum, the embedded PHY receiver in KSZ87xx switches 
> is
> tuned by default for long, high-loss Ethernet cables. When operating 
> with
> short or low-loss cables (for example CAT5e or CAT6), the PHY equalizer 
> may
> over-amplify the incoming signal, leading to internal distortion and 
> link
> establishment failures.
> 
> Microchip documents two independent mechanisms to mitigate this issue:
> adjusting the receiver low‑pass filter bandwidth and reducing the DSP
> equalizer initial value. These registers are located in the switch’s
> internal LinkMD table and cannot be accessed directly through a
> stand‑alone PHY driver.
> 
> To keep the PHY‑facing API clean, this series models the erratum 
> handling
> as vendor‑specific Clause 22 PHY registers, virtualized by the KSZ8 DSA
> driver. Accesses are intercepted by ksz8_r_phy() / ksz8_w_phy() and
> translated into the appropriate indirect LinkMD register writes. The
> erratum affects the shared PHY analog front‑end and therefore applies
> globally to the switch.
> 
> Based on review feedback, the user‑visible interface is kept 
> deliberately
> simple and predictable:
> 
> - A boolean “short‑cable” PHY tunable applies a documented and
>   conservative preset (LPF bandwidth 62MHz, DSP EQ initial value 0).
>   This is the recommended KISS interface for the common short‑cable
>   scenario.
> 
> - Two additional integer PHY tunables allow advanced or experimental
>   tuning of the LPF bandwidth and the DSP EQ initial value. These
>   controls are orthogonal, have no ordering requirements, and simply
>   override the corresponding setting when written.
> 
> The tunables act as simple setters with no implicit state machine or
> invalid combinations, avoiding surprises for userspace and not relying
> on extended error reporting or netlink ethtool support.
> 
> This series contains:
> 
>   1. Support for the KSZ87xx low‑loss cable erratum in the KSZ8 DSA 
> driver,
>      including the short‑cable preset and orthogonal tuning controls.
> 
>   2. Addition of vendor‑specific PHY tunable identifiers for the
>      short‑cable preset, LPF bandwidth, and DSP EQ initial value.
> 
>   3. Exposure of these tunables through the Micrel PHY driver via
>      get_tunable / set_tunable callbacks.
> 
> This version follows the design agreed upon during v3 review and
> reworks the interface accordingly.
> 
> This series is based on net-next.
> 
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
> ---
> Changes in v9:
> - Drop incorrect Fixes tag
> - Fix typo in comment
> - Link to v8: 
> https://patch.msgid.link/20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com

Please don't re-send patched within the 24h grace period as stated in 
the netdev FAQ [1]

Thanks
Nicolai

[1] 
https://www.kernel.org/doc/html/v6.1/process/maintainer-netdev.html#tl-dr

