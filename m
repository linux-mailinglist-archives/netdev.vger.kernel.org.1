Return-Path: <netdev+bounces-302329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XNczDECrP2qBWQkAu9opvQ
	(envelope-from <netdev+bounces-302329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 12:51:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F95D6D1C9F
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 12:51:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=WFGFChRs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302329-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302329-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94B3530215BA
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB53A784F;
	Sat, 27 Jun 2026 10:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55639182D
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 10:51:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782557499; cv=none; b=U4ZshjLGMrQN4UW7on1CNFm3Am9NRjNuDHVibn2p7NKpyh71uyS7Gqk5mvbXpHGW28Q5zOITreDjCpqeMdU0tlFzPejGUP/URcMigijk4bkyTta9BNmEAjJpLcrgNrQ2Kud0V4C0jq32i4Dnvd0qau9CAczExj8ezi/oLhqXJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782557499; c=relaxed/simple;
	bh=DKZMjW6YgabzM0SyMqjkY5OV0gBbsU9vG+3eee9vbHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uu8D0odVoARjI4CLfueJEHgSRYRg77Xz6AIHLwsljRK+UC1eYg5+S7++6Y+n9vBKH8gEnrVrcY8q0g+BSurbNonTweHhhCiNO8qdophnHlnvl+q7pEObF+LzRrSUF08/AcYLAN0c0TsHoYt1D8iuSKyDY6sIVKVqfii0G2g0QUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=WFGFChRs; arc=none smtp.client-ip=212.77.101.10
Received: (wp-smtpd smtp.wp.pl 19563 invoked from network); 27 Jun 2026 12:51:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1782557490; bh=DKZMjW6YgabzM0SyMqjkY5OV0gBbsU9vG+3eee9vbHE=;
          h=Subject:To:Cc:From;
          b=WFGFChRsmBaPhzkk5ferhklt2GqHM60xouIGTsomy+sa44KUjgyqnMYDHze2UN1s8
           gtlgQcl/X8nq+F6KK0ImhwbkrRf34/anAil+FH5wjHovsNWVkrY0Dqx1Txpce/wgN2
           XwYHx95BQK1S9/FQApGTSIRRB2Cn1HndpJZobCVhhK18ZcE3zldoBgaOcFCcHRqjHs
           wYNQYwk0b51YewM3Pz8cOaz99GvQA+kg9K6+4eRJtMXnrS8Cw+BGPdvfHgrmP8plbH
           Wfrtr4XNSD3zmTZ5bCa5aCzCLNr4eU58XYdnH9eeGs/iLUZeq5T+Jaki/l2FTXPWNG
           aKBJopKvdIPnA==
Received: from 83.5.235.152.ipv4.supernova.orange.pl (HELO [192.168.3.224]) (olek2@wp.pl@[83.5.235.152])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <kuba@kernel.org>; 27 Jun 2026 12:51:30 +0200
Message-ID: <f57f27be-c118-4d18-9435-fa2b0378035e@wp.pl>
Date: Sat, 27 Jun 2026 12:51:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Wozniak <petr.wozniak@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Bjorn Mork
 <bjorn@mork.no>, Marek Behun <kabel@kernel.org>
References: <20260624084814.20972-1-petr.wozniak@gmail.com>
 <20260624084814.20972-3-petr.wozniak@gmail.com>
 <9f813a8e-8b9a-4708-b3b6-db4972adac35@wp.pl>
 <20260625082335.3d13d875@kernel.org>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260625082335.3d13d875@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 556fbf69d037b530cb73c033b6de72c6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [kUD8]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:petr.wozniak@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	TAGGED_FROM(0.00)[bounces-302329-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,bootlin.com,mork.no,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wp.pl:dkim,wp.pl:mid,wp.pl:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F95D6D1C9F

Hi Jakub,

On 25/06/2026 17:23, Jakub Kicinski wrote:
> On Wed, 24 Jun 2026 23:44:19 +0200 Aleksander Jan Bajkowski wrote:
>>> For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
>>> AQR113C) the probe now runs after initialization is complete and
>>> correctly returns 0, so PHY detection proceeds normally.
>> The FLPRO SFP module still fails to detect the PHY. It is necessary to
>> increase `module_t_wait` to 20 seconds. Most likely, during this time
>> the module loads the PHY firmware from SPI memory or from the
>> microcontroller (rollball bridge) via MDIO. Same probably applies to
>> most SFP modules with a PHY that load firmware at start-up (AQR113,
>> RTL8261C etc.).
> Just to clarify is FLPRO a typo or a knock off ?
Typo on my comment FLPRO->FLYPRO :)
> Do you want something to be changed here or you're just flagging that
> more follow ups are needed if we want to cover more modules?
I don’t know how this should be fixed. I’m just sharing information.
Even with this patch, most Rollball modules still don’t work. This
patch at least fixes one bug. According to SFF-8472[1], we shouldn’t
communicate with the SFP module until 300ms have elapsed since the
module was inserted. The second problem still remains. 300ms is still
not enough for most Rollball modules. Unfortunately, we’d need to test
a quirk for each module to find out what delay is required. We need a
quirk similar to sfp_fixup_rollball_wait4s. But with a longer delay.
Should the fix be included in this series or follow up?

1. SFF-8472 Rev 12.5a. Table 8-7

Best regards,
Aleksander


