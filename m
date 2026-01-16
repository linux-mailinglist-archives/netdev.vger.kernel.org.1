Return-Path: <netdev+bounces-250544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7DD3272F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 033FF301623A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9566231618C;
	Fri, 16 Jan 2026 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="whnsPrW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B913AF2
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572995; cv=none; b=ZD2Rym8lFlR+pbMj6YpWFdm1qmVvwA+NRqOlRpEQUbrZO6wf1wDmODX0BgRMF8x65uTi1DHzwbr9q58UJmQD5Idkdkf85muiiplckdd9bmXlwwqtPJnzRtU53q0fOq7QC5FFQjbzNk8cVozWXIAuss0qIwPnxj9b66+klq8IOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572995; c=relaxed/simple;
	bh=nKrjM35rdrCwLUD8b8mI0oF6ONlHXarPqtPT+kKxqIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmNquxX+yL8hj3FRsS8kpsRA5hRQAp1NT+W3RlJq5VzjjdcBNnTUfhKaxxTTjHyjzurl0gsEIyav53lkus3Tczg29iZ3hOHh/s4Ka2qLAQ/vdYcfmEeP7ilrt4rr14Nq8bNt2pgIUjGGnSDp/G88IlwE3BqUhqO/og9k0R/xeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=whnsPrW2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C864B1A28B8;
	Fri, 16 Jan 2026 14:16:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9687460732;
	Fri, 16 Jan 2026 14:16:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41F9B10B689C4;
	Fri, 16 Jan 2026 15:16:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768572991; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZS5TRLYEDopxN+zFn+edCDdQMaSK/4CnNdBp3xbj0DA=;
	b=whnsPrW2sFRVMka7e9fBIas2+63yZxF/BfrIEOR9O6ez/sq38Op5opaWSnB+zFRpL82E0y
	ESEkEYQfJ5DTFf/wo7EitnvwSJzBzB4XrLchc8PYOmGvCTsBfcfTqWLCoPKUPlQHDhfvEP
	0Mz+le17UKidOwI0LaYaNhpyG5kwQeJhH3UBaf0NkNL4l/KLOzoJ8zU+zABOp7r/kff2cM
	EV7FZx7rMuHyFl8fwzXOOcMZsvUFlYDDxuQMyZhpOQLVODLhQay646vwZwLsMV/qxLywkz
	0HXTseTpGb7EcYSlWKvhH/i/GwxS1TdtQbfesgCF61V/G2ife6EdUETegIHBQQ==
Message-ID: <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
Date: Fri, 16 Jan 2026 15:16:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
To: Andrew Lunn <andrew@lunn.ch>, Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 16/01/2026 15:07, Andrew Lunn wrote:
> On Fri, Jan 16, 2026 at 02:43:47PM +0100, Jonas Jelonek wrote:
>> Hi,
>>
>> On 16.01.26 14:23, Maxime Chevallier wrote:
>>> I think Russell pointed it out, but I was also wondering the same.
>>> How do we deal with controllers that cannot do neither block nor
>>> single-byte, i.e. that can only do word access ?
>>>
>>> We can't do transfers that have an odd length. And there are some,
>>> see sfp_cotsworks_fixup_check() for example.
>>>
>>> Maybe these smbus controller don't even exist, but I think we should
>>> anyway have some log saying that this doesn't work, either at SFP
>>> access time, or at init time.
>>
>> I tried to guard that in the sfp_i2c_configure() right now. The whole path
>> to allow SMBus transfers is only allowed if there's at least byte access. For
>> exactly the reason that we need byte access in case of odd lengths.
> 
> Is there a use case for odd lengths? Apart from 1.

There's sfp_cotsworks_fixup_check() that does a 3-byte access :
	
	id->base.phys_id = SFF8024_ID_SFF_8472;
	id->base.phys_ext_id = SFP_PHYS_EXT_ID_SFP;
	id->base.connector = SFF8024_CONNECTOR_LC;
	sfp_write(sfp, false, SFP_PHYS_ID, &id->base, 3);

It may be possible to turn that into 2 2-byte accesses if we write

	id->base.phys_id = SFF8024_ID_SFF_8472;
	id->base.phys_ext_id = SFP_PHYS_EXT_ID_SFP;

and then

	id->base.phys_ext_id = SFP_PHYS_EXT_ID_SFP;
	id->base.connector = SFF8024_CONNECTOR_LC;

But let's first figure-out if word-only smbus are really a thing

> 
>> This of course rules out any controllers which just can do word access.
> 
> There are some PHYs embedded within SFPs which kill the bus if you do
> anything but 1 byte access. There is a quirk for it. We should refuse
> to drive the SFP if we have such an SFP and an I2C bus that can only
> do words.

Heh true, same for the weird SGMII <-> 100FX from Prolabs

Maxime


