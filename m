Return-Path: <netdev+bounces-171363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25145A4CA86
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D2516097C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36491214234;
	Mon,  3 Mar 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="ACDO/OIu"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140A1EE7D9;
	Mon,  3 Mar 2025 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024419; cv=none; b=u6Aa9d4/lSlxU1JweIP/UNZ0hLX1CLam5UkZEuwPs9jpZg79xy+5Ipr4n3j4TzGcyor0f1QpGA9tsonk9uLs9eo5Hz9y6jwoobgcCuL6xC3Ne1CAm/MlO5S4kRgvhNkCXguPz7xROC73iqY+idKlauJSh6fwH9Hc0KR5jw1aouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024419; c=relaxed/simple;
	bh=pMJGwmT5syYpazoo5nLk6s5Uyrc3DDhH7hbRvJGKVmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSDKEEQe+BUk5zddn+DmXKa0zkSu9c53Kce5IRpaF+cfdt1GIOongwGD8XoREtjq8dELS9gwIgE0EUiqkQnJj8n+vmoFZzbOHuDoKpAY1bZfgL4HGVPBlu4Z1kEVeW30XcbLODMOc1MUIcR258aU0aWVOH171Q7E2N/vHN8Nk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=ACDO/OIu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id C09D24425A;
	Mon,  3 Mar 2025 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741024410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ocbhNXyg1DVPGXd5pgdUnTrPsU79WBmUNsZd4G8D5k=;
	b=ACDO/OIuRa+KNyyvhN4b3OE+BxAtxymzzNBZBWT7uaZaFi71kgVwEjAxBRSIryRvlUmcKe
	Pn9e/Fu2nqLRluOVt6rMETWftmJByZKHiTV5GTCz2Vsq/Ful4CDNAJ8S4zw0slvqXNX+7x
	b/k2d4AMcSmSYvXFoVMg/QuqlNsoE/X68RywRtOYI5KSeyik8Q64odiIqz89m9/Jnyh//f
	8FwBY35WuSlHz2VNF206MzH2TMc9dhQtCXmKGLYNdUD/x+AD/ScPCvBd5Gc06MS708QOmt
	XGwjmyIlNJ69/8PG1eiAhPspcRtvAwz1YS4B+p5eOnvVdp4Uudk75QfOwFujZw==
Message-ID: <49c94ed4-5475-484e-a9c0-3c916482a97c@yoseli.org>
Date: Mon, 3 Mar 2025 18:53:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: phy: dp83826: Add support for straps reading
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Catalin Popescu <catalin.popescu@leica-geosystems.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
 <20250303-dp83826-fixes-v1-2-6901a04f262d@yoseli.org>
 <fcc25495-5453-4b15-aece-b01bca3a00ba@lunn.ch>
 <7cd18e37-2d68-4825-bcc4-fc2ac6b9a461@yoseli.org>
 <bf0228a7-032d-4d8c-b5e1-1be4830404f7@lunn.ch>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <bf0228a7-032d-4d8c-b5e1-1be4830404f7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhepfeeiteeghedvgefggfffteehhefhteekfeehhfegueehteeuffeuieekgfffffetnecukfhppeeluddrudeihedrudeihedrudeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeluddrudeihedrudeihedrudeljedphhgvlhhopegludelvddrudeikedruddriegnpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhgl
 hgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrphhophgvshgtuheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhm
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Andrew,

On 03/03/2025 18:50, Andrew Lunn wrote:
> On Mon, Mar 03, 2025 at 06:37:28PM +0100, Jean-Michel Hautbois wrote:
>> Hi Andrew,
>>
>> On 03/03/2025 18:20, Andrew Lunn wrote:
>>> On Mon, Mar 03, 2025 at 06:05:52PM +0100, Jean-Michel Hautbois wrote:
>>>> When the DP83826 is probed, read the straps, and apply the default
>>>> settings expected. The MDI-X is not yet supported, but still read the
>>>> strap.
>>>
>>> What about backwards compatibility? I expect this changes the
>>> behaviour of the device, potentially introducing regressions?  Please
>>> add an explanation of why this is safe.
>>
>> I am not certain it is safe. As far as I know that if straps are used on the
>> hardware, then it should be used, and if the behavior has to be different,
>> then userspace can change it (or any other way). Am I wrong ?
> 
> First off, what does the datasheet say about these straps?
> 
> Straps generally configure the hardware, without software being
> involved. It seems odd you need software to read the straps and apply
> them.
> 
> Why do you need this? What is your use case. As you said, user space
> can configure all this, so why are you not doing that?
> 
Mmmh, now that you say that, it makes me think that it could probably be 
configured indeed...
The HW uses the straps, and it disables autoneg and fixes a 100Mbps / 
Full duplex link on the board I have.
But, event if HW does this, autoneg still starts when ip link sets the 
device up.

Maybe should I call ethtool before ip link and see if it does the trick.

Thanks,
JM

