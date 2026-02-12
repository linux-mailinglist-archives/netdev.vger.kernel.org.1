Return-Path: <netdev+bounces-258485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPyWAKsejmnp/gAAu9opvQ
	(envelope-from <netdev+bounces-258485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:40:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7427D130599
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 690F53037F2A
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE9280317;
	Thu, 12 Feb 2026 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BghUVet7"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C3224B0D
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770921640; cv=none; b=CCwT3HuynEqGAJWV5SmuWqckfPNrLV6PimewGJX3l205x7NpNmaI4QIF24m7q1AxD3HnL1nrUdCNMXF55ouEn+oo4FWxeClepGxERVpbPmHHOgzV9lnE/UXCFl+JwpATlbLRyD4RvEMji9YuSI6JC6CTb7CZKjrKNUS5LCapKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770921640; c=relaxed/simple;
	bh=AfFfEZZmykQNiWI1P7tQUCRv6W4BRKkmHedNGBEyn04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMmiW327tSWzkqfN1RGhI5mTX1pmpwj4TIBkf9lxlmE0VbWSzHNwkoaP+78bHg6waW45gbUMfrR2MOakyEvpWUBlk3bjwTOhNQBrmS/0sFtOtuB93V7cX4qVpVGYocGZGrTm9DfN2N1iLWLkrAhikHuYUgHC0Qti2A2oypurFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BghUVet7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4B31AC23DAB;
	Thu, 12 Feb 2026 18:40:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B3017606B8;
	Thu, 12 Feb 2026 18:40:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30F8E103688A1;
	Thu, 12 Feb 2026 19:40:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770921636; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SQCxFGr5qrtRperceJYZ7ft+IVLPFCaXNx0EVEdG/1Y=;
	b=BghUVet7sXdsZQ150AryHSKKGXglYKMvbkzRKzQiWuIjZI7yDJM5Y8hz7KCwqP/0BfhfUv
	tYpiskuagrcm9K1taSmKYvjplipkxsJ+pWkEdnbH4xj/mjdPV0X/xTwzxOt1BrBUxioK9B
	FJ9sgXYrC8MVPAqlayR7H5rDr5OJPx4nc1dvaUHRUO2l9eqlopEEvaWtxOKff8oIz6Lynh
	7lnQhDGx+Zw9G6PyqWJzobNdxlvgs/ohnA2tPbgZUTLhoysH/s1vh8PHUoAhxs47SAY5l3
	9D2NPCjo5Y7PYmvTJN8aWz6JxzJO0ZZ7Ir4CuFbvu0aIlVwjv8Z0LejtJA1u9A==
Message-ID: <5929eafb-6101-4570-beaf-ed08ae109423@bootlin.com>
Date: Thu, 12 Feb 2026 19:40:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced
 100Base-Tx mode
To: Meghana Malladi <m-malladi@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, linux@armlinux.org.uk, hkallweit1@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <0a9d0ec8-09c4-4029-8449-8c8f08c6dca0@lunn.ch>
 <a498b310-29f1-4775-aa65-fda027a3124b@ti.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <a498b310-29f1-4775-aa65-fda027a3124b@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258485-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,vger.kernel.org,ti.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7427D130599
X-Rspamd-Action: no action

Hi Meghana,

On 12/02/2026 07:21, Meghana Malladi wrote:
> Hi Andrew,
> 
> On 2/11/26 19:42, Andrew Lunn wrote:
>> On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
>>> When using DP83869 in force 100Base-Tx mode, the PHY is required
>>> to have robust Auto-MDIX feature enabled from register 1Eh.
>>> Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.
>>
>> What are the results of not enabling this? How would somebody know
>> they need this patch?
> 
> This is the fix for 100M full duplex when auto-neg gets disabled, it 
> fails to have a link up and this patch fixes it. I will add more 
> description to the commit message.

I have a board here with a DP83869 + imx93's dwmac, but I couldn't
trigger the bug locally. I forced speed, dpx and aneg settings with :

ethtool -s eth0 speed 100 duplex full autoneg off

I did the same on the link partner, but I was still able to get link-up.

I'm not saying the bug isn't real, I mostly curious about the kind of
circumstances that causes this prblem to show-up. Do you have any
clarifications on that ?

I'll be happy to give the fix a try, if I can manage to reproduce the
issue :)

Maxime



