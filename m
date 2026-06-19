Return-Path: <netdev+bounces-300722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HIOHANxLNWr6rgYAu9opvQ
	(envelope-from <netdev+bounces-300722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 16:02:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4236A63C8
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 16:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=sSeNWiLe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300722-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300722-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A92FD3004CB6
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3BA28BAB9;
	Fri, 19 Jun 2026 14:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911428CF6F;
	Fri, 19 Jun 2026 14:01:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877718; cv=none; b=e717KzlaKIwyXd9j2d0EwQxtbKBE+4RPzI1RAcSDOBuEvjyUGrRvM3lIBPAGERvHik2cqgAuXs6sHKR+kJ3kUMtv281pu7PbQsBikSK+m7VUbGcC+fS6ODS8cqXVfw8cAFkAh4qtqoR553ljcKrNd8nohc/m7xIQBUYcgXeO10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877718; c=relaxed/simple;
	bh=7r+gWLbdzCWmndG+gBwFRbgXNU6RGyqb7Gy5j+rKHys=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LmHDokShQP7ygdX8PXh/cMwLZU5VJ7qVWwlEjiMjvta/phMdl72mRwXSo65/XGyQjswGi5cLWIiHFjYp9aZa9bG5BDjwl+/AXuygULkzaEvRQESI8hXEAJavrExZYJtD6cAeIlJevvLuotO3SMrv/ECboBoldxQXmPD5XLJGgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=sSeNWiLe; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A09A0A0285;
	Fri, 19 Jun 2026 16:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781877711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0kzVf2rab1tQ1NJcQPC2UBtf3cOYxXzI6xVDXbFZBT4=;
	b=sSeNWiLescYGP4jzUxbMPA7Jyb8FExiAKhaW/mOGgwIWppN7scrsjkka8jYowMUmo4e1IM
	YxJaNI14d7atbO8/aNQoFgCjMk6HcEhjgDfEydYtJnD3vNw4NFvmyIQpZmhxOi3b6sisFl
	bHgP2DVbVsiP8sGzQ497GQi9MnrbMJAOJ1wvFAPzxmCKYy4CSn6VeRab6j5patSTR2wtMy
	+LE1q5dgjbT1WbCUCM4RAGVZE+FHFlJebFPkhGx0g14m1om7C/ZBCvqF4MCOa4lwjuxpOs
	SaSyjbDsDE2dWSoRaM6yALdM4ewRP1Gr2jD6Wf8FIJd4+mvUPb9E4gWd55Wjtg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jun 2026 16:01:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan
 Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: AW: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter
 table after device reset
In-Reply-To: <BEZP281MB224523ADACDB48D8E3974D4AD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
 <BEZP281MB2245422BB9FBFF4AFE081451D9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <4abfc9b1e8860da93c03639863bd0232@tipi-net.de>
 <BEZP281MB224523ADACDB48D8E3974D4AD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Message-ID: <f76711d2f45c527f9ce0f5d288631bc6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:schuchmann@schleissheimer.de,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:Woojung.Huh@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-300722-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F4236A63C8

Hi Sven

On 19.6.2026 15:31, Sven Schuchmann wrote:
> Hello Nicolai,
> 
> looks good from my point of view
> (Calling the lan78xx_write_vlan_table() from
> lan78xx_mac_link_up() and from lan78xx_reset()).

Thanks.

> But I investigated a little more and it seems the hash table
> (which is right behind the vlan table in the controllers memory)
> also gets cleared. I wrote some random data into this table and have
> seen that it gets also cleared. I think this needs to be fixed too.

Something like

static int lan78xx_write_mchash_table(struct lan78xx_net *dev)
{
        struct lan78xx_priv *pdata = (struct lan78xx_priv 
*)(dev->data[0]);

        return lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_,
                                      DP_SEL_VHF_VLAN_LEN,
                                      DP_SEL_VHF_HASH_LEN, 
pdata->mchash_table); // from lan78xx_deferred_multicast_write)
}

with callers in lan78xx_deferred_multicast_write() and 
lan78xx_mac_link_up(), should
do the trick?

> 
> In the Datasheet from the LAN7801 I can read:
> "After a reset event, the RFE will automatically initialize the 
> contents of the VHF to 0h."
> Where VHF also refers to the hash table.
> But I still do not understand what reset is happening when I just 
> unplug the network cable....

I suspect it is triggered from the PHY:

8.10 (MAC Reset Watchdog Timer):
"A portion of the MAC operates on clocks generated by the Ethernet PHY 
[...] PHY Reset
(PHY_RST) results in resetting the portion of the MAC operating on the 
PHY receive and
transmit clocks."

So which PHY are you using?

> [...]

Thanks,
Nicolai

