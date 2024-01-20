Return-Path: <netdev+bounces-64482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3B8336A4
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 23:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FAAB2173F
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B891400D;
	Sat, 20 Jan 2024 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Q//TiCMz"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4363611727
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705788837; cv=none; b=biKipBc1J+eG8KIiuE+P0+1ku8v/2GM6rrqvh1mk6c6CRe6TEtUoaYI3OSbMIbzsQixmEI878XKn7wRh7K6WdoXJ4kgWsydH7KIKaZ6eOSk1WsdnbLpPpt53BovWldAq5kjII0yH++lCVCbHuMIReoHEDRIiCGHZeAeOotbDjU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705788837; c=relaxed/simple;
	bh=ZzMemv+cMDIPLGfTo+s6Ls7o7fT27EADA7G5neNpUs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT9VrkU7pRAWG1WAKye2NvAAdE4BGM1lnOjvjptKP4KGkoGSejSsZ5L93Ht9aIvq9zZRagIaa6QupHq+nqI2TD+pJV0xC27MddufckLkCsXV57frxGEP43zpNY7RfOzcE70AIvWeMdOWYMfRJIxnXiw0f3UfnVdj6He+QSidBYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Q//TiCMz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 045EC1BF205;
	Sat, 20 Jan 2024 22:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705788826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRgMUTW99GNSHg7woAly2QqmaolqmnZDomD1VnIawlc=;
	b=Q//TiCMzzKUVxrvA0EKHwFS//hczQ/1sz24DuUYu/7Sme2HM4gYgfQfIfY/wXvN8UYPlN4
	mJtUE13Wo+u0BbDClk5yqEqbZwPAqGxCeQNcsoS/uMB71dY/u6HUexFvDbnkXEeLeF/tr0
	3jsireXnnxcFIDEjdqQG2S2HfPdPV2odYAla2UPIPS0jSMuGPwsk9CoDnNz2tJqRf+7eZ9
	CLrojhIeraKY1unZpSoxQrsa30F5r8qxxvA62E2URT1v8yk3hIf493ckwjYm0D93zh6axX
	bQzROQm57lbxlFWEPOjzNVFS5+ydvoWMKFl9v7bJJB7WakrunJpsJSacjsAmdw==
Message-ID: <ccaf46ca-e1a3-4cba-87eb-53bf427b5d68@arinc9.com>
Date: Sun, 21 Jan 2024 01:13:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/8] net: dsa: realtek: variants to drivers,
 interfaces to a common module
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20240115215432.o3mfcyyfhooxbvt5@skbuf>
 <9183aa21-6efb-4e90-96f8-bc1fedf5ceab@arinc9.com>
 <CACRpkdaXV=P7NZZpS8YC67eQ2BDvR+oMzgJcjJ+GW9vFhy+3iQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CACRpkdaXV=P7NZZpS8YC67eQ2BDvR+oMzgJcjJ+GW9vFhy+3iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 17.01.2024 15:48, Linus Walleij wrote:
> On Wed, Jan 17, 2024 at 11:26 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>> On 16.01.2024 00:54, Vladimir Oltean wrote:
> 
>>> git format-patch --cover-letter generates a nice patch series overview
>>> with a diffstat and the commit titles, you should include it next time.
>>
>> Thanks a lot for mentioning this. I didn't know this and now that I use it,
>> it helps a lot.
> 
> There are some even nicer tools you can use on top, i.e. "b4":
> https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1
> 
> This blog post doesn't mention the magic trick:
> b4 prep --set-prefixes net-next
> 
> And
> b4 trailers -u
> 
> Which is what you need to make it an awesome net contribution
> patch series tool.

I've spent a day thinking I probably don't need this. I've spent the next
day giving it a go. I need this. Diffstat, the auto formatting of new
version change log, and linking to the previous version on the cover
letter, patch version comparison, and auto adding trailers features make my
life so much easier.

I've had trouble with every mail provider's SMTP server that I've ever used
for submitting patches, so the web endpoint is a godsend. It would've been
great if b4 supported openssh keys to submit patches via the web endpoint.
Patatt at least supports it to sign patches. I've got a single ed25519
openssh keypair I use across all my devices, now I'll have to backup
another key pair. Or create a new key and authenticate with the web
endpoint on each device.

Safe to say, I will submit my next patch series using b4. Thanks for
telling me about this tool Linus!

Arınç

