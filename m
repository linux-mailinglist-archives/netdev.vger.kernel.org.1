Return-Path: <netdev+bounces-279341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKyGHN1G4mlh4AAAu9opvQ
	(envelope-from <netdev+bounces-279341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F2141C2F0
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E741315672D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4A3B27F6;
	Fri, 17 Apr 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="b2hht9rM"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4212ED846;
	Fri, 17 Apr 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436573; cv=none; b=ifvXy89uJGZLT2EvTXXiszJz4AjB9704nmrk2Y13N1Xjjvaw4Y8EGQnWwb780GRFAIp5DKiLyBNpyc5vUrsr3FQwG58gtAiTZFA/WidB8HSi4LDkX1pzBGt40vGlwOuZ4H9YyquNowX4dV6mmqgkKsWI2wjmZfP5UiF0iLJR2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436573; c=relaxed/simple;
	bh=4K5xCDOrsqfdBbbfs66l499I5HBzF3VQLwoV69MrSsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjulK08AEuBUE/Xk4Xar879aZCXx5lcKpSyBnPK3YWvgjaA1G8wkdNPbiQpmz0SSHj+dvsr2UOhQ1vGEfUq1d+gkjkSCg6wEU2UXvweK5/In/c4bszJvJ1oEmfau4BS7uv1M/dyI68fz7IFOkx6397l/mGLsqRGT0J56AI/y2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=b2hht9rM; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30DF911385C;
	Fri, 17 Apr 2026 16:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776436566;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LGnDlQ1kXzbMWy8rPGEeELExDvbX+Y5f+N9yBoi3r40=;
	b=b2hht9rMJUvcGZUPLWaWpBdmYK3jONk/Msf40JSOA8a2AkRfqA9bxTgOYSbxE1wna82SdU
	Q/QPFYu/vXkxrq5nTvzFC3SPi9O7VXf8aKFtFyHJ97H/49zJ+ocA2tf1PIxUxkCQ4j+2iY
	tv2d1+NA9E9343+Rm72PJftBZFuxbpbk2KXAGon6qBcXA+DiqdUl9XoPU3ns8YGCqKnBW+
	g2GkbwZ/BOu+qomMFylm72T2Eu0kOKSZKIz7u0qTDNhvBWLp3wltqTYHNfFMlPqNHs311D
	UYHoeSbcdL/s57uRyBCXOmnH74bAsXjk/TgeD5vWCPa3yfCrT30JVXiDnrrLqA==
Message-ID: <fdb7bac5-1edd-475e-b869-000e827e69ea@nabladev.com>
Date: Fri, 17 Apr 2026 16:36:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279341-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[nabladev.com:server fail,sea.lore.kernel.org:server fail,exotec.com:server fail];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: C4F2141C2F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 2:44 PM, Fidelio Lawson wrote:
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
> This series is based on Linux v7.0-rc1.
> 
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
Thank you for working on this, except for that one nitpick on 1/3, this 
looks really good !

