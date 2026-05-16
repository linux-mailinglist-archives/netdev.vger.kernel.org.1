Return-Path: <netdev+bounces-288555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TwJxHSnMB2rQJAMAu9opvQ
	(envelope-from <netdev+bounces-288555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:45:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA794559CF3
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E767B301D32F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFC2741B6;
	Sat, 16 May 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="GEKjJH64"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175B261388;
	Sat, 16 May 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778895909; cv=none; b=fpbOCTbKS5Ks9AGrEgcyjZ3jQkVeOOZrxjbI+o7ae4XcezRjz3fPGzBGsBz5XIWDLJlPwNRc38rYlAtyhA129rHzDZ329H0kPADpKHBF9Nb8KNoIWghBrI0T5dxN7Fe3HExFmUxQ10bcTaFTCp3aQkxa6MXU+QokX0e0pUNeDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778895909; c=relaxed/simple;
	bh=PNemOm1/VDDNckigupTljtm+CV61Xskt7YJK4o27BrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6d5T6llshQqC8t1rKbROYZ7pV/Ftb07wjUBJVAgTrKCi/UubPqlchxPtI8RewuN6l7zHhbehgDgyql7Lj4d3ERp9sfgDBppKPjGykECOl9LZq0I3bjv92aGtCVIdJqpW+w69dBiBg9tXnXiv/x9KgNJW5m7LYNZnqm0vsFSxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=GEKjJH64; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6C75115830;
	Sat, 16 May 2026 03:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778895905;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wUkV5CLe5fNiWjewueAqMkqDjq+1DHT8fwMSCAWsoWE=;
	b=GEKjJH64EyKo9lCqZ/LMq67O04f3fFcC/QKjEPdSzIRtETNZ3AUbUJ0OMLKjVjGkOJjRP+
	Zek5Ll+PrYbb/on/a42ezFngLFJ/no/gK9muKqIvK3uH7eKtHaxIQanjbdrNI3C2jeFlrG
	c0AAWe/o0m6gWwDUfEUjeVxyEWLQxMTBPHf/wOklrI6G1+BFs0YfzEsJo1Dbwyur6bi2F9
	DFwSr+nMUf9ZIZqH8YuRVUNy6J3i2ySa5I7kCP2qURvfY+TrFl9bjd1xXfjqQx+EWcZ0ju
	YwECwyg5SjVBDnT/zVb9TVWWq8jhdYdrLhJwmCqZ701ToLXKosWl27zhF6Yb/Q==
Message-ID: <fe01752d-95d4-4686-b536-0acc8a2046cb@nabladev.com>
Date: Sat, 16 May 2026 03:44:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CA794559CF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288555-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/5/26 1:42 PM, Fidelio Lawson wrote:
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
Is there still anything left to do with this series ?

