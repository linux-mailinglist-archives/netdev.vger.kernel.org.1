Return-Path: <netdev+bounces-298549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XxgBGp3PK2rzFQQAu9opvQ
	(envelope-from <netdev+bounces-298549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:21:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C264B67835A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:21:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=P2QyEbmL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298549-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298549-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7966C30680D6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E038657D;
	Fri, 12 Jun 2026 09:18:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FB349CCE
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:18:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255933; cv=none; b=JmUUfyYRcyccpNnZgcOjrIcBWQGOxtK69kknq4TvXQ7D22MXmA+Y3/J2VTNyuF5chCWE+hAXmPxj/ceBskb8LY+xKGWNZMW2rlbReg/rr7FsGr2wUzNDskaxk6kJY239wCj3jUHJIa1iFH7iU/AMpxh28L7RFHVrEdGtKbuhEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255933; c=relaxed/simple;
	bh=oyGTzbvxCuDvDM9+RpRvGN2hgWc851MaYea+ROmjQu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8awOsDpnSa2KJRDhmIVpFYXa6jDQHB2wnrwHDaYNlYuFwQf8jYiwuQf6+dL1oNyqplxBAdU/2AMnmsPPTg16eHII5b92otOV9DZDBsYV11WQO73gNZPbIeEkDgQvujPihcGrtGwpMHFW0m6aw0CnSzJ+ECEy+kAgjpWh+sCfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P2QyEbmL; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 843EF1A38DB;
	Fri, 12 Jun 2026 09:18:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 559F360012;
	Fri, 12 Jun 2026 09:18:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 857C6106C861E;
	Fri, 12 Jun 2026 11:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781255927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vVYoRcRdHxRy0+qoqV9cENhNZgpBYA4mJS7LJ6zHJ04=;
	b=P2QyEbmLEDJ31fZN40dey2srYbY5Fft7BVlu63MAiagOi8sQkFTxwK82uIaIfuWMIzMInS
	+oiNylmb8knPGBWoaBZYcdArffIcdempQtQ6CWlTZYJ6mC6MTroQ7SwWI9ZX+koOpw0g9R
	EH6A8TziPCtdhcFbyaZ0aOvWxBLwZOdZ4CL+HmT3WpXuhV/9RWouPKmEn2XcSV7ZPIo81w
	m+2VJUkDBuIzmYOs4YZMGCVe3RSmtm1E+LP0DyMhWwhCFqn2Y0QArQ4ZkG17uAzXCxeTdv
	Rsn45r+aSLes++jhke3W3H1DJ7Gw9sXYSH5B3yfimnSGIANhfYCt8L0jkLXNjA==
Message-ID: <c32f7996-a67b-452c-8ebd-d9e348f279c0@bootlin.com>
Date: Fri, 12 Jun 2026 11:18:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/10] net: dsa: microchip: implement
 lan937x-specific MDIO registration
To: Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
 <20260608-clean-ksz-3rd-v2-9-6e61b7be23c4@bootlin.com>
 <01b8171c-f684-4525-8f98-2d41c9b62f80@redhat.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <01b8171c-f684-4525-8f98-2d41c9b62f80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298549-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C264B67835A

Hi Paolo,

On 6/11/26 12:54 PM, Paolo Abeni wrote:
> On 6/8/26 4:10 PM, Bastien Curutchet (Schneider Electric) wrote:
>> All the switches use a common mdio_register() function that uses two
>> ksz_dev_ops callbacks (.mdio_bus_preinit() and .create_phy_addr_map())
>> to handle the lan937x specific case. These two callbacks are used only
>> at this place in the code.
>>
>> Implement a new lan937x-specific MDIO registration functions that uses
>> these two lan937x-specific functions. The lan937x bindings don't
>> have any 'interrupts' property so this lan937x_mdio_register() doesn't
>> call ksz_irq_phy_setup().
> 
> Sashiko noted that ksz_irq_phy_setup() manually populate the mii_bus irq
> array by mapping the switch's internal port IRQs (PORT_SRC_PHY_INT)
> rather than relying on the device tree and stripping ksz_irq_phy_setup()
> may lead to regressions.
> 
> Is that a false positive?

Yes it is to me. ksz_irq_phy_setup() is currently gated by (dev->irq > 
0) which can't be true if no interrupt property is present in the 
device-tree.

> 
> Please note that to help processing the series, you should comment
> proactively on the AI reviews finding.
> 
Ok, I didn't know that, I'll do it from now on.


Best regards,
Bastien

