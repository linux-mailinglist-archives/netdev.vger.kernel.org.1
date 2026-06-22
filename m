Return-Path: <netdev+bounces-301032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZOvaMCgQOWrcmAcAu9opvQ
	(envelope-from <netdev+bounces-301032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:36:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176FB6AEBF4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:36:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=vSbDrnBP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301032-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301032-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED1BE3055DE2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00F371D13;
	Mon, 22 Jun 2026 10:34:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97D3491D0;
	Mon, 22 Jun 2026 10:34:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124445; cv=none; b=Zv3f5T2mYWuEy+LvJc2GufnbFVKwKS5OKvPWd9sBCwP+sLuuZCuOMq0yW5xVDLBEu6hTk6DeyJEk5yBNCiSbuYjZHT20KuFDQzfv6nouJ/xQ0rRQldvpz6WZZPoMo9Jta5m6JvUKAE/4XG0Q8hzBdQ05Ovr962KUAUcrzOLTUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124445; c=relaxed/simple;
	bh=dLWCFMXElJAimOVvnulujwYsPKAab/rtBHijkyJGNfM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aJGz+HahUT/2Jcabc+5Yjw/LB3819gUbcp7FXuly1cvaHlRPIafmvPP/qynYYiDioFG4GvEMs8nFyTlwzXHpxLDlrJAMeYq9SXWnKbt06TDBF2BSfVT9S6P9r15MF+tgcH9/0cci4IhQttk601/+StZs2RiVIGY2KH1MklF6g+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=vSbDrnBP; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD3BAA02DF;
	Mon, 22 Jun 2026 12:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782124441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dx/B2m4epnkAcHaC7egWzuokCQWHPyJnQKfGd2yfeTY=;
	b=vSbDrnBPqo5QeqIpa+C+G7d7FrD6k2Ox/Xymoys4Zuq8QzL5wFxjOw8SO0I2VXLMf8gJly
	JPluI1++N1vVPhcqr2BS2me6QTORRUkrL8yvUYNTpKvueFDwDl4LehXeurCtbywV37BpCl
	STaQhm6AZu+ubiFr8Tmaqb+ZkEvddyv1s57QWfqKQFhA+81yt3zpGa+ZZnaufjXROzwtyM
	B19zaTfQBo+I+FIsSZee7IKlF0ZK0gm9NwE95PmoiSygtuGsj+HuYFOyl2k4y+szQt5P8t
	1jBxpPkxuOi+GqEhhbtPYsMM3HFX2xs5Dz2UZN8QI0VuY9jaGir/Dn6GwD1Aag==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 12:34:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan
 Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: AW: AW: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN
 filter table after device reset
In-Reply-To: <BEZP281MB22457C80F9D1AC7F788EC008D9EF2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
 <BEZP281MB2245422BB9FBFF4AFE081451D9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <4abfc9b1e8860da93c03639863bd0232@tipi-net.de>
 <BEZP281MB224523ADACDB48D8E3974D4AD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <f76711d2f45c527f9ce0f5d288631bc6@tipi-net.de>
 <BEZP281MB22457C80F9D1AC7F788EC008D9EF2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Message-ID: <3964f6655b98681b9aab92593b5ed3ca@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:schuchmann@schleissheimer.de,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:Woojung.Huh@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-301032-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,tipi-net.de:dkim,tipi-net.de:mid,tipi-net.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 176FB6AEBF4

Hi Sven

On 22.6.2026 12:07, Sven Schuchmann wrote:

> [...]

>> > looks good from my point of view
>> > (Calling the lan78xx_write_vlan_table() from
>> > lan78xx_mac_link_up() and from lan78xx_reset()).
>> 
>> Thanks.
> 
> Just to be clear I used this patch which is looking good:

> [...]

Thanks for testing! I've sent a v2 of my patch with your t-b:
https://lore.kernel.org/netdev/20260622102911.484045-1-nb@tipi-net.de/

Regards
Nicolai


