Return-Path: <netdev+bounces-171501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C1DA4D3F3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 07:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420F93AE670
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4762F1F461A;
	Tue,  4 Mar 2025 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="jllluqPF"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F01F150D;
	Tue,  4 Mar 2025 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070227; cv=none; b=soJUwcZGIdeUcBJ6isyiXSu5E49IlQtZz1u2yc2Qt2NA/RHQkojXFD7TV48i9obAIaOXz0aykP9VRefrND4I3zcOyY42FZ4ar+nHUrSTz1HUrIMtIwdIbM71HEenTE8KsGsGSe6DBSHCAQOYMydOBLZDB9Nx+8pFawWc6MJ24sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070227; c=relaxed/simple;
	bh=Pof+IzNFFSwumliPuC0y0GUgCeiXKgFaH2lhS0EXipQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8EHaWWwQCbaUmPxtzsPnItkP9RcGN5sbdu9EeFeDx5stl5sxFB2wk9r/vh1nATkp0hx+OeTEAanZ3wKwipUzYSnUM+O3idB5y0hEaPKyQl4Uep5XHeV5sZLfEXuIRGTq5N36Uq74xVO7LfUIsPR975jSDTTSFtphv3zHwJ5YA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=jllluqPF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85FB544312;
	Tue,  4 Mar 2025 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741070223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpUcGbb9YZkLLOOR+VEMMuMvQQVcm/kEbmlQs/v60T4=;
	b=jllluqPF5OIY/FIHof76m6a2aw7KVkPhiF/vYRQNHOqMffUfeXGKqd+zJSblY4zhdsEnU4
	aNYnN2GFqc5e3cMvjEQzHeS651pm72/NonBxvfITlBik+Ro/zf5LKbg+L60OqoYiCj8z+c
	IDMJBodOr47dmAAE3cr1450IUMqtVzCUY4R3WzPe8dKhbsOwfT1+XKrIJjpEB+ZUcXo8c2
	SenhXEu2afneXDK+ArM8Yh2xZfTu2lJnDa4Wsv0oQpJGUqMjyVs/irYpKEj8SgEcS5phmW
	EcB0V/S1VsSNw9b81yB/lD6ZENXDVDnIFIVqHwgPXjpLkOOlwB6u9N0FskLjPw==
Message-ID: <a545c67f-de26-4224-8d20-c8abdbd6a9c7@yoseli.org>
Date: Tue, 4 Mar 2025 07:37:00 +0100
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeefieetgeehvdeggffgffetheehhfetkeefhefhgeeuheetueffueeikefgffffteenucfkphepledurdduieehrdduieehrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledurdduieehrdduieehrdduleejpdhhvghloheplgduledvrdduieekrddurdeingdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhog
 hhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtrghtrghlihhnrdhpohhpvghstghusehlvghitggrqdhgvghoshihshhtvghmshdrtghomh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hello Andrew,

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

Thanks you for your remarks, indeed, ip link set + ethtool -s works fine 
to force the link mode wanted. Event the master/slave can be specified, 
so there is no need for this patch 2/2.

Thanks !
JM

