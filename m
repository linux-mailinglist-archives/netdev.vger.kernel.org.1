Return-Path: <netdev+bounces-295069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rb1fMm0qIWrm/wAAu9opvQ
	(envelope-from <netdev+bounces-295069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:34:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2702A63DA7B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:34:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=dGCBAUCl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295069-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295069-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323AC3061092
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726DD397E8D;
	Thu,  4 Jun 2026 07:26:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC1346AC1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 07:26:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558012; cv=none; b=bKyti+6CUqg8DgO7MMyngdiMpmto7Ul2mV7F5MZdU0ICxUZUIby3tCI8T+yrd82F+kyCDOc3P5N3a9e2DAmS44998zuQ3H09soG6lugqH8qRZ9ZRYHPbL8I+kQI/JHWwqS1lLsdlNLX9zc9t9QoKjKHHxHVNBy0ZupHYbKRu6io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558012; c=relaxed/simple;
	bh=YdIR2ib4L+SBxf6ithHbapHSmbsyZJNx5bKyxNJlQF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEHapBbu7N4f39FJAzFgrK5l/12EY+q42WPLZ1meq/F1eV4K1iOmS7Kf1NIIPxnuYKr8OtkShgLhaFtYdLuREEio4dUMpC519YFgnodCPsY2KlGnkGIm8rpmZ69ldrxFc0jBa/hrLcfP49buNjCcFdCWMsz+rJpVDtHHV40WHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dGCBAUCl; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0C497C6344A;
	Thu,  4 Jun 2026 07:26:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D79225FF03;
	Thu,  4 Jun 2026 07:26:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 477C0106A1733;
	Thu,  4 Jun 2026 09:26:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780558009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=5t+SPwaTMkHlkLH5ZHVvZXjSLZD+uZqcmCuVg3yJbrA=;
	b=dGCBAUClGeQHDCEBxsMw+aIUM6T2Us7StbcIiyoCQS4FWF7dGDKLM7J/x6HPjugRvxKTbZ
	0A0np/2YVEmQ+kL7Wjse70m0xlSODBz+F2K9FHZ6AuHG49Efxv9h3Gy3ZYmagtlM4iNrcX
	c9iy07Aw+ehIwDDlAPaG7RUdAnkoT8P5+9wYs1br44TNV0irOM/nlYqK4Ktk1sdkw84YXB
	s0oqBTgxjT8R6IdYsGTJdfWPk+M8v14mjldgWunoMPJUh70K9bAu/FJvC9jKsM8NKrgg3D
	h30OIoZwMHevLT4RNUVHeGGu1yFutSRsVUhiW+9+xVxkFHkwHGOA/oRkulxckA==
Message-ID: <9e0ebc04-2eb9-49b6-8ce1-e5b18968ac1f@bootlin.com>
Date: Thu, 4 Jun 2026 09:26:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net: phy: remove phy ports upon probe failure
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20260601084029.815461-3-maxime.chevallier@bootlin.com>
 <20260604022706.2924974-2-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260604022706.2924974-2-kuba@kernel.org>
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
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-295069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:from_mime,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2702A63DA7B



On 6/4/26 04:27, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: phy: remove phy ports upon probe failure
> 
> When phy_probe fails, let's clean the phy_ports that were successfully
> added already.
> 
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 6ccbfacf7d1d2..a171cbe2a74a1 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -3778,6 +3778,8 @@ static int phy_probe(struct device *dev)
>>  	return 0;
>>  
>>  out:
>> +	phy_cleanup_ports(phydev);
>> +
>>  	sfp_bus_del_upstream(phydev->sfp_bus);
>>  	phydev->sfp_bus = NULL;
>>  
> 
> [Severity: Critical]
> Is it safe to call phy_cleanup_ports() before sfp_bus_del_upstream() here?
> 
> sfp_bus_del_upstream() unregisters the upstream SFP callbacks and acts as a
> synchronization barrier by acquiring rtnl_lock(). Before it is called, the
> SFP bus is still active and can asynchronously fire events like
> phy_sfp_module_insert().
> 
> Because these SFP events locklessly iterate over the phydev->ports list via
> phy_get_sfp_port(), and phy_cleanup_ports() mutates the list and frees port
> structures without lock protection:
> 
> Could this concurrent access lead to list corruption and a use-after-free?
> 
> This same incorrect ordering is a pre-existing issue in the phy_remove()
> teardown path, but this patch introduces it into the phy_probe() error path.

Heh true indeed... Let me respin then, I'll fix the other callsite that has the
same problem

Thanks,

Maxime

