Return-Path: <netdev+bounces-302332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Pm6Cgm8P2oaXwkAu9opvQ
	(envelope-from <netdev+bounces-302332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 14:03:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D45C6D1DFA
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 14:03:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=MZr0qSpd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302332-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302332-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BABFF301038E
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65DC3559F8;
	Sat, 27 Jun 2026 12:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1F23394B
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 12:03:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782561797; cv=none; b=dLueMwDzvbpwVfxH9fSWNDgQgtqm3P4BWJ24lkMPyPQtujW8/W2fjrgwyS3eGhLJs2V+1AubNkxIm9/I4vbDkqZCTuVnD0IpdZopbGZzgn1PsOpjkQJRuczrCYm6OGWLHeoZ2Irpv4vhQDjp6bBt9iRKls5keJA/+N2rSPKNpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782561797; c=relaxed/simple;
	bh=WwGFokztcs+y9n4jJTNDSzVxZhLEu2f8nljUSlA7JXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lh2aCOihmIrPYgwDwxvVla29M46v2r1lu1EHp0Pxi4YCfosyYhm3BpVIb5QoF6lLeZ+1YvyiQojjChCYjaydw4wSLfiCIrQzjtHly7hBDusrTm6UQkSq+5CkOTowxMjJFyEBDJmtPZJeA/KbWd9MUVUS1D1H8UJKZMKN0ImUqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MZr0qSpd; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 69F87C5CD78;
	Sat, 27 Jun 2026 12:03:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24CE760233;
	Sat, 27 Jun 2026 12:03:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6ED60106F0447;
	Sat, 27 Jun 2026 14:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782561791; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vXHW0KlN3ToKmF2y5q+w/EnLPad1QSe+5reRgFv7LEA=;
	b=MZr0qSpduLDgGneJuPXUW3tm3Wox0CLWrXJ1dd7bgqRTuZxb3bpcWYT2RyQGt3a0ZuvlfD
	5XNMmDD52JQ7UkdP0eKxjDa98a83ohEUb8R19UWODqH5NvRT9z69KwB2mr4oIt05bC/Mzb
	jrIXZmQ9vbjVm5GM1qeNWJpdI+HLcblpXXC2drJEIaZCzJrc4DVsA3VGyCAOXFmLHxXcjm
	mCHogqiRU6zGtlp7bWNM3NAVmvb3lv0vNAYChJCZbYcccjST6thpfW+J/ORfkbQWfdQybm
	IDTdj64W5CESXBeX5pPf3kKfZWctIAE3fiygR5IN5VhX7YlD9ne9EzLsJ3x6Ag==
Message-ID: <24a4065d-1e37-4364-94eb-622b11bd0471@bootlin.com>
Date: Sat, 27 Jun 2026 14:03:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
To: Petr Wozniak <petr.wozniak@gmail.com>, olek2@wp.pl,
 linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, bjorn@mork.no, kabel@kernel.org
References: <20260624084814.20972-3-petr.wozniak@gmail.com>
 <20260626163519.10678-1-petr.wozniak@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260626163519.10678-1-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302332-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:olek2@wp.pl,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:bjorn@mork.no,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,wp.pl,armlinux.org.uk,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D45C6D1DFA

Hi Petr

On 6/26/26 18:35, Petr Wozniak wrote:
> Maxime Chevallier wrote:
>> I finally got time to test this with a RollBall module, and I
>> confirm what Aleksander says, the RollBall module's PHY doesn't
>> get detected even with this patch. It does work on v7.0 though,
>> so before the bridge probing was introduced.
> 
> Thanks a lot for taking the time to test, Maxime - and Aleksander
> for the original report.
> 
> That settles it: the deferred-probe approach in patch 2/2 doesn't
> actually restore genuine RollBall PHY detection, and as you both
> confirm it worked before 8fe125892f40 introduced the bridge probing.
> Sashiko's static review flagged the same thing (the probe bypasses the
> PHY discovery retry loop for slow-initializing modules), so the static
> analysis and the two hardware reports all point at the same flaw.
> 
> I only have RTL8261BE-based copper modules here, not a genuine RollBall
> one, so I can't develop and verify a proper slow-init timing fix
> (module_t_wait / a retry that waits for the bridge) without the
> hardware to test against.
> 
> Given that, my suggestion:
> 
> - Please drop patch 2/2 from the series.
> 
> - Since 8fe125892f40 regressed genuine RollBall detection and the
>   deferred probe doesn't restore it, I think the cleanest fix is to
>   revert 8fe125892f40. I'm happy to send that revert if you'd prefer.
>   The 5-minute RTL8261BE probe loop it was addressing is handled in our
>   downstream tree, so reverting it upstream is fine on our side.
> 
> - Patch 1/2 (the mii_bus leak fix) is independent of all this and
>   already has Reviewed-by from Maxime and Larysa - it would be good to
>   take that one regardless. I can resend it standalone if that's easier.
> 
> A proper fix covering slow-firmware modules really needs a genuine
> RollBall module to validate, so it's better owned by someone who has
> that hardware - happy to help review.
> 

I only have a single rollball module here, and none with the missing
bridge, so I can't test the full thing either.

In that case, I agree with reverting 8fe125892f40 as this is breaking
all rollball modules right now.

Can you send the revert ?

Maxime


