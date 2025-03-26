Return-Path: <netdev+bounces-177820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EEDA71E6A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1196C179095
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E88124EA9A;
	Wed, 26 Mar 2025 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="qydPoju+"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9923FC54;
	Wed, 26 Mar 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013779; cv=none; b=UXk9acm+lCICo4239YJFAnQt+7IqP+ikw2M2thfUO1F+dfqf4X41owocjG+c6gUGpW3dZwflLwxvw5ryNPn/Jz5VfYSDVROnYGS5xblXfBVNj2hZjLjpyEShZ0drvsVmsDh8Ht1qyxn7hwSRHBBHov320cRJrH5L3NmF3S8zMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013779; c=relaxed/simple;
	bh=g2yzAzX5o6xIyPWqMNLJGDsTUlNwj7m3G2jIFpQ0Z44=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bz0wM/j0wMOHjtRF+59GPQc0aCFUwoYwr5UrbgiF8gYj4JXoZK6Rd2Kqql6HzhF2sfBfkiHXrrP/6ZW1uyCghj6cDrJULdtIOPa+SKGI/ggrAh7aD7AusWFcRJucMjmLKyUhNIhr5XBhPodhWmaT3MuJkRAafD/fp+8YS4W6HgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=qydPoju+; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 6B459C000A;
	Wed, 26 Mar 2025 21:29:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 6B459C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743013772; bh=A9Ek7r7bq0EEPg8qhhw8rnhM2LNnbRdf1rOlxeo2ymo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=qydPoju+mT0jIb1EUUDtgynECwYAKBIORWM6mwQHaqx4ExwIe48qWfHTTi8ojhaXz
	 gi9rg9P6pYcTOBQF1SFDL7+X7EgpxnkUR2IUyYuyAy9SELZT//J7Pi+COpEQuQ/o1R
	 gQgTl+aidP9tanJ+3StGgUqicn9dwdR2u5MWDUomyM1XB/Ente/azpGTmjDSkqW70a
	 j8giPsENiZ7tqV2nBAdsZbY8wy2HJvc+YO4nT6la6rWyPMcTwZ5ZRod3U3EQ4u8cnK
	 ZXH/Vc2WaCY2WuDy78kQZ79uoTtNbhuvGBTVaukUeaCfp0/Xd+bG+oSHRvXMahqpbk
	 DYuJPvqXyEoiw==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed, 26 Mar 2025 21:29:32 +0300 (MSK)
Received: from localhost (5.1.51.21) by mmail-p-exch01.mt.ru (81.200.124.61)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Wed, 26 Mar
 2025 21:29:29 +0300
Date: Wed, 26 Mar 2025 23:29:29 +0500
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] net: dsa: felix: check felix_cpu_port_for_conduit() for
 failure
Message-ID: <20250326232929.809a37357877ef3168dfc097@mt-integration.ru>
In-Reply-To: <dc85eb72-cdec-43a1-8ad7-6cd7db9c6b25@lunn.ch>
References: <20250326161251.7233-1-v.shevtsov@mt-integration.ru>
	<dc85eb72-cdec-43a1-8ad7-6cd7db9c6b25@lunn.ch>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64--netbsd)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Prob_CN_TRASH_MAILERS}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;81.200.124.61:7.1.2;mt-integration.ru:7.1.1;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192129 [Mar 26 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 40
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/26 10:13:00 #27825781
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

On Wed, 26 Mar 2025 19:22:07 +0100, Andrew Lunn wrote:

> If i'm reading the code correctly you mean ocelot_bond_get_id()
> returns -ENOENT?
> 
> If so, you should return the ENOENT, not replace it by EINVAL.
> 
> 	Andrew

Or maybe it's better to just return negative cpu value instead?
This variable will have the correct -ENOENT value in case of failure.

-- 
Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>

