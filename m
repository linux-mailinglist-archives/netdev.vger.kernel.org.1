Return-Path: <netdev+bounces-171359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C74A4CA45
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A0F17AB76
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C937231CB9;
	Mon,  3 Mar 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="j9pVBoNK"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5D230BDC;
	Mon,  3 Mar 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023454; cv=none; b=AoztpDGGqqTKtgu4SEB6U9PaUGL1AOchIgKWtoVU/1clGrhgdPrXx2xejTsf+U0JFRzHm+th66GQogXzjb3O0rJaGNIs49e1ernGAo1nbzgJO9PavLKuBcCZ/EsMFzKYhZ9UtZB5nj3OXSmymqjwRg9T8a3Q9PUzXAwfBT6T31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023454; c=relaxed/simple;
	bh=bWBOhaMng64IoA/gra5KEY+BlnSAUyrCpjhL1Fodlu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atVivjIvvKcGqWTQDhb5MiIRNuGVJMqekncE70Pmm8Ycxr9etHnzRhq+M8X0t0x1bk12isj2KwPXmceBSO3ZdoBJjIvZkK0LIVdWna58JtncI92Ih4F+q0OTVbaCWu2CDQSSh+37F9V0u12qSAOr3UKCIm5V3FijupTkh/t3T0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=j9pVBoNK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F3F444404;
	Mon,  3 Mar 2025 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741023450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3H6pW4S8PPhnGfrKhhjaR9va9GYV3q8+SK+MUf2Y/Y=;
	b=j9pVBoNKxtdzfOkTKq4db89Q/jQNSzArtAqfsxCepkh8Bc0mcT2dkl4TVqiWt8YhOsz4X9
	9Lfq6HW46gzGqssTxxvsSfMLKsS+5LpuOvW+HQq7j2Cq119OJUk9ihxUcuPUxVkE4OC66l
	L5WaPrfywJo1WkLGRcHurofCJhl/j7ZK+Ce7v1XqNUTOh5mhld7FmsQKULJK6tzIjfjj0p
	VyQsRYw1yXgE3njNP5DKb65gqxUaXtENwQIqLWfdl4TDim4BTaeqJ7nns5OfVi8zUiRolY
	segUlRxFxOKGROzAEhxzCXO8uWNmb0cOfFlS38if1lXviA4oeTleSuTGFwecJw==
Message-ID: <7cd18e37-2d68-4825-bcc4-fc2ac6b9a461@yoseli.org>
Date: Mon, 3 Mar 2025 18:37:28 +0100
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
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <fcc25495-5453-4b15-aece-b01bca3a00ba@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhepfeeiteeghedvgefggfffteehhefhteekfeehhfegueehteeuffeuieekgfffffetnecukfhppeeluddrudeihedrudeihedrudeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeluddrudeihedrudeihedrudeljedphhgvlhhopegludelvddrudeikedruddriegnpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhgl
 hgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrphhophgvshgtuheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhm
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Andrew,

On 03/03/2025 18:20, Andrew Lunn wrote:
> On Mon, Mar 03, 2025 at 06:05:52PM +0100, Jean-Michel Hautbois wrote:
>> When the DP83826 is probed, read the straps, and apply the default
>> settings expected. The MDI-X is not yet supported, but still read the
>> strap.
> 
> What about backwards compatibility? I expect this changes the
> behaviour of the device, potentially introducing regressions?  Please
> add an explanation of why this is safe.

I am not certain it is safe. As far as I know that if straps are used on 
the hardware, then it should be used, and if the behavior has to be 
different, then userspace can change it (or any other way). Am I wrong ?

How could we make is safer, though ? We somehow need to read those ?

Thanks,
JM

> 
>      Andrew
> 
> ---
> pw-bot: cr


