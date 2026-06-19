Return-Path: <netdev+bounces-300649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0FuPMCn+NGomlwYAu9opvQ
	(envelope-from <netdev+bounces-300649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:30:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA746A49A7
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:30:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=cwt2uDLQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300649-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300649-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810FE300DDD4
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA502330666;
	Fri, 19 Jun 2026 08:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719DD298CB2;
	Fri, 19 Jun 2026 08:30:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857828; cv=none; b=S0JAJw4NISPty/2/OylBapIZuxen+pWvVWqCR0CxGb9i408iQOvPT30u3SY70mYERTjq+lvASTYLuxqM82SyZKET4p07JZwA4OCK9D3kW38xJ9M7zJ/NytA+1LV38XiRRBAv5rvQ9pSlY0tHhs2uFPGjv4V7uWCJ7W5paxGF5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857828; c=relaxed/simple;
	bh=iqZRUz8SKRy1NgRwT2lOifewnmALL2tQYL7EpvJrZ38=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Y2V71boC/IcqGFMABrwV8A4kxI6ZH2d35taxqbNRhNxvgLT2jlzXUaT5eXlIB2mKkLZL+VDqvMuLsZwJ5HN0WJg32UJQ9R0wzQpkVHIZvzgwNmZoYGgYV15M88s0AiCgitXzVLon4CstEAax8eXXQxG6IPr/wIbwPWoQ02jv4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cwt2uDLQ; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CD56A47D2;
	Fri, 19 Jun 2026 10:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781857824; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V2QBu7CDupdPYy31HVgPBAYKthBcmzdHptwvbLWexlA=;
	b=cwt2uDLQ90g728H6aS5JCN85gzhL3tvpqBvt5OkORKv8f98RXxLcXHjlntRSwwlzdCT573
	8uU+LCcXoqUFuo/ER27uUzLzt4PfohtewYLeQ03n3QEIfUt3cIf2876D+tbd0LU2sI3cO/
	Epk+kZuDIq9BWorvGQIAULz6kBCDuOQYGU33MAtlv/G5TIr0u5BzVvvWCKtBRKYllkOpDu
	Mt7mF6XPhW6sOVZ/PT+wOb5K+h1TteyEJVlEAphLsKmAht9mjnooPANAAoA+nDebA7wGzd
	VGH660s1ExeqtXrkstzhcGiVf/QIHH7YVrLmQ4nYxAFhHN1eM8d0i1KoPtWTyA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jun 2026 10:30:23 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan
 Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter table
 after device reset
In-Reply-To: <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Message-ID: <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:schuchmann@schleissheimer.de,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:Woojung.Huh@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-300649-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FA746A49A7

Hi Sven

On 19.6.2026 10:11, Sven Schuchmann wrote:
> Hello Nicolai,
> thank you for the quick response and the quick patch!
> 
> But actually it is not working for me... If I disconnect and connect
> the LAN Cable (I have setup an automated test already with two adapters
> connected to my RaspberryPi CM5) the lan78xx_reset() function is not 
> called.
> 
> Here is a dmesg output from my test.
> I defined DEBUG at the beginning of the driver and added
> netdev_info(dev->net, "function()"); to nearly every function
> in the driver. Also I added my a VLAN compare function:
> 
> static void lan78xx_check_vlan_table(struct net_device *netdev)
> {
> 	struct lan78xx_net *dev = netdev_priv(netdev);
> 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
> 
> 	for (int i = 0; i < 1; i++) {
> 		u32 buf;
> 		lan78xx_dataport_read(dev, DP_SEL_RSEL_VLAN_DA_, i, 1, &buf);
> 		if (pdata->vlan_table[i] != buf)
> 			netdev_err(dev->net, "VLAN TABLE %d: 0x%02x 0x%02x - ERROR", i, 
> pdata->vlan_table[i], buf);
> 		else
> 			netdev_info(dev->net, "VLAN TABLE %d: 0x%02x 0x%02x - Ok", i, 
> pdata->vlan_table[i], buf);
> 	}
> }
> 
> I call this at the end of lan78xx_start_rx_path() and 
> lan78xx_mac_link_up().
> I now I get this output. The output ends after 16 disconnects and 
> connects.
> Then it is broken. What I am wondering is what is happening after
> lan78xx_start_rx_path() that destroys the table...

> [...]

Can you please try with the following changes to lan78xx_mac_reset()?

	ret = lan78xx_stop_rx_path(dev);
	if (ret < 0)
		goto link_down_fail;

-	/* MAC reset seems to not affect MAC configuration, no idea if it is
-	 * really needed, but it was done in previous driver version. So, 
leave
-	 * it here.
-	 */
-	ret = lan78xx_mac_reset(dev);
-	if (ret < 0)
-		goto link_down_fail;
-
	return;

BR
Nicolai

self NACK (or whatever it takes to withdraw this patch for now)

