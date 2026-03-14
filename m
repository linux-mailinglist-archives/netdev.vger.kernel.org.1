Return-Path: <netdev+bounces-267844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PgQLXK8tWlD4QAAu9opvQ
	(envelope-from <netdev+bounces-267844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:52:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 292BB28EABE
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76E58301CFDF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA4937F744;
	Sat, 14 Mar 2026 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="fCLn28nb"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8B3126D7;
	Sat, 14 Mar 2026 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517935; cv=none; b=swotoCYXzjfb28kRjzKfTKJ/yLA0ehB7G5KaQmpWjotBjA7WEDe25Y7H5EV/Hs7oXfd5dmpDEzv9q/5OcaHiiFartWHK+s1fLKFptRs3DvTm8Ak4cJH3agh3KslHMtElqOSy1ZiYsYu9DNQDMpWvstHzESorMvPwZuvIMUNbsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517935; c=relaxed/simple;
	bh=05c/9binp24LS+w7F7qkuVqW7oXNweubfMnrDJ655lc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bxXAKrX9+7VDgwjpFxX8zlzaGQ5fY8MFXDQg2fG+Td9b+5wxvlTPtN7RYq5JbdDfyj1yFipQFLGOC8ZcNpR6VEnwsuUDRwl3LqbSGoSLB708PcgpXGd805jlgz7Em1VDkJ5Dk5fl+vSyqSxW2GqSbUii6pKnUiYVgOL/9jDdnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=fCLn28nb; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB7EEA0304;
	Sat, 14 Mar 2026 20:52:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773517932; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TleW7hTd/KTKAu03za2P5eXbX0UrARAzI5aPN15z5fE=;
	b=fCLn28nbuzPYu6B6/fMvxoZj+fAFNB+rV4pNwnG/jjnGWWIheCYHliv1gPSvEEV3WEPEmn
	+8gS/esPbVujhoVlwENAzonU9St8LTCguF4LNNvAuwy7GfcYa1J+HFkRbz1UUWaG4STu0X
	QjU6ZE4jdrhu3k7tacHT+JUd1a5j2wqhn1h0f67LryMy4iQwipn2X9mBYOOI6BM1HUr8R7
	ozqrvkXGdIrhDAdROB+CdxvCnSkXwvNBYqrdj24NIYy40mxwBTXF1H6lMhJk9+yUodh78k
	0ItIH617JuPQm+5KkGvUFNswhkU4NrhD9kHRlKRr65tup5vNWtUi1Ci68tXM2w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 14 Mar 2026 20:52:11 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Eric Biggers <ebiggers@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <mbloch@rooftopnetworks.de>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] net: bcmgenet: add XDP support
In-Reply-To: <20260314085232.089ea669@kernel.org>
References: <20260313092101.1344954-1-nb@tipi-net.de>
 <20260314085232.089ea669@kernel.org>
Message-ID: <78fb6651f668390bd877a60597ba52fd@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267844-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,broadcom.com,kernel.org,rooftopnetworks.de,arndb.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 292BB28EABE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 14.3.2026 16:52, Jakub Kicinski wrote:
> On Fri, 13 Mar 2026 10:20:55 +0100 Nicolai Buchwitz wrote:
>> Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
>> XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.
>> 
>> The first patch converts the RX path from the existing kmalloc-based
>> allocation to page_pool, which is a prerequisite for XDP. The 
>> remaining
>> patches incrementally add XDP functionality and per-action statistics.
>> 
>> Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
>> - XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
>> - XDP_PASS latency: 0.164ms avg, 0% packet loss
>> - XDP_DROP: all inbound traffic blocked as expected
>> - XDP_TX: TX counter increments (packet reflection working)
>> - Link flap with XDP attached: no errors
>> - Program swap under iperf3 load: no errors
> 
> Have you had a chance to run the XDP tests from
> tools/testing/selftests/drivers/net/hw/
> ?

Not yet - thanks for the poibter. I will run it and include results in 
v2.

Nicolai

