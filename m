Return-Path: <netdev+bounces-243458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB4CA19FE
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A833034614
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89602D320E;
	Wed,  3 Dec 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R4qHAUnw"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106E2C237F;
	Wed,  3 Dec 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796043; cv=none; b=TdGpcjYfVa9EiMXnWJ4Qis14P3i7L5aYcJX3YsTCJcU+5K03HfOlR+PNpbybxJEplJofOawmv+FoDBlfEpZTwprZahxljakolEBPxm6aLWe27QeFAdSwj3Fvmq2+03VaByBWYXNAJAMupZDKxhcPhyen5iCW4bp9hnaJzfgLsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796043; c=relaxed/simple;
	bh=9BmTXWiZ1udHlq5DwURTvetbWMe+t3AVUOLj8EXf90s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY/lJjSD//hHAjk1e48TFezQhc03tDdpUdAYtUA161zXjfFjs+ShU1jebbeWjN59mDnEVrmawPY7Aye+WCkxWMjBAqCtBOYQJzq1Q6XxNabgqxmUJfnCBdt1yr08Aq0w24IJncxk1V8Ubkk1545wNqSf10+xnC2eg0um1MxM0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R4qHAUnw; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dM9FL3bsvz9t9P;
	Wed,  3 Dec 2025 22:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfOtELLqqxmDgjFZ9XKy3M43MP9qpjtLAwMQiXCOFGw=;
	b=R4qHAUnwkxNVHJm7HKjsCbKqzMyyQgwTZHlEFBS0dHpuhvvP8WzyMgs3rbqVtUmT5mI8f6
	1o1cununJ4sTsTSrJ38Wd4SbBNicUDDCbfPPwKI7qAX8p/pI8WFNRfx2Tj3EmS7fnbZH2L
	laE3yHcUcfwA/w0Wc88PH0g4FkQb7pQbu3eoE+AnkYzvZpH3bmxQb1Qvm/FlEB4zuQZPbg
	jBi5q7uCBQEactkF/RRiHb4SMusUd7GNljta2GHH8ZtiAqCu2LQAAMUA7K15CyroVgB2Lt
	sItKxigKHvmkU/6U4Uz8q6agEUAbrukeKOzkzEcRo5fZ70uZhT4zGANnHLyAKw==
Message-ID: <75fb955d-ef53-4e59-8a9c-d9792f6e6466@mailbox.org>
Date: Wed, 3 Dec 2025 21:56:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
To: Ivan Galkin <Ivan.Galkin@axis.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "michael@fossekall.de" <michael@fossekall.de>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
 <robh@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "olek2@wp.pl" <olek2@wp.pl>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kuba@kernel.org"
 <kuba@kernel.org>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
 <20251203094224.jelvaizfq7h6jzke@skbuf>
 <43bfe44a0c10af86548d8080d0f83fdbf8070808.camel@axis.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <43bfe44a0c10af86548d8080d0f83fdbf8070808.camel@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: onzktd4bbsuxspeiyknt9m5khdpd7o18
X-MBO-RS-ID: 9433dfc616d90f1025a

On 12/3/25 3:18 PM, Ivan Galkin wrote:

> - Regarding RTL8211F(D)(I)-VD-CG
> 
> As I mentioned before, saying that PHYCR2 doesn't exist is incorrect.
> However, the SSC settings have indeed been moved away from PHYCR2 as
> well.
> 
> The procedure for enabling of RXC SSC and CLKOUT SSC is described in
> EMI Improvement Application Note v1.0 for RTL8211F(D)(I)-VD-CG.

I have EMI improvement application note v1.2 for RTL8211F(D)(I)-CG .

> Enable RXC SSC: Page 0x0d15, register 0x16, Bit 13.
> '1' enables default Main Tone Degrade option (aka "middle").

Page 0xc44 register 0x13 = 0x5f00

> Enable CLK_OUT SSC: This depends on the CLKOUT frequency and the Main
> Tone Degrade option.
> The sequence is complicated and involves several pages and registers.
> The application suggests setting those registers to predefined 16-bit
> values, which I struggle to interpret.
> I would redirect you to the application note instead. All I can say is
> that PHYCR2 (page 0xa43, address 0x19) is not involved.

Page 0xd09 register 0x10 = 0xcf00
Page 0xa43 register 0x19 = 0x38c3
... and, I also suspect this needs to be done, but is missing in the 
appnote ...
PHYCR2 |= BIT(7) // and maybe also bits 13:12 ?

> - Regarding other RTL8211F PHYs.
> I compared datasheets for RTL8211F(I)/RTL8211FD(I) and RTL8211FS(I)(-
> VS). They both use the following bits:
> 
> PHYCR2 (page 0xa43, address 0x19)
> bit 3: enables SSC on RXC clock output
> bit 7: enables SSC on CLKOUT output clock
> 
> Both SSCs are controlled over PHYCR2, which, as far as I can see,
> contradicts this patch.

The bit 7 part is missing from the EMI appnote for RTL8211F(D)(I)-CG , I 
will add it in V2.

-- 
Best regards,
Marek Vasut

