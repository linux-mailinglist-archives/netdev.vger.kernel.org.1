Return-Path: <netdev+bounces-169723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7C7A455FE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080753A9692
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906625E46F;
	Wed, 26 Feb 2025 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y9LPHaJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2bp7lRM"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1451C84BD;
	Wed, 26 Feb 2025 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552600; cv=none; b=rHHXsJZ62fh3vOLEdPyfhaOwPYT1rEGQcJsJINcjkpR161YErBrCVVr1LwZdMYNuKV4+isyAHcUq/47YMuuqDmF7JdxOykeVutooi55uEkIZupQxFbSfd7mp1j5pZ/amOFxMX3H8MVFjLj6lKk4qFO5RCC3hJpdXRhbksZvyLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552600; c=relaxed/simple;
	bh=XnItWZpT3oZZxPjd9HEvharwKL5dOWJMkAj2c8lY4Rw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=svcqLLQ21orAQ5NX5G5FnosdKhES6P4KblRj2Y0tlpZqh681hVXrPazb16tBdlFuSD3E7VeEurF0eYQxuQsDQS7NnEysqgE5SIepfuZ+JchdEzsaK6Hu9LHYvTM5DTNZZ4D895NlVwMEaEtTBRr1g8tCvM+Qv0rzH0Pmn6T0Y7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y9LPHaJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2bp7lRM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD4FC25401F4;
	Wed, 26 Feb 2025 01:49:55 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 01:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740552595;
	 x=1740638995; bh=CND1Q8F/E/Zja91qSOuemRzNE+ygiM8qRxcIP8zqLs0=; b=
	Y9LPHaJJQdansMPzLOkYEjlxNr4pRweYbEo8VUJ14Jaw7KGX6ZPZJpK5rPS2rfoq
	ELSqUqKMc+ou7Bx4slNVjGARbvQo9rGjyiBpKMvQ8OrQt694BmpId+HKIBQ059b2
	RCmzH3cJxbtBsX5MH8TCMiKRe6CFgkR3sGV16VtmyMFBCeN4DKfUtAEh0qF8LsXt
	tM6eDYHrK+r1BBFNZvQAXymnDWOKtwrAwDtGyTzYAdKygqhoEWup+QP5iH72bXWR
	O8qSFDCBRCpYgv/8NRXtjrCWumpLLDpC2unbnYrG9D8PV4aAQoVI36EPsO1rVXWZ
	Et5vnm38wfKvKi7j6lwtzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740552595; x=
	1740638995; bh=CND1Q8F/E/Zja91qSOuemRzNE+ygiM8qRxcIP8zqLs0=; b=c
	2bp7lRM3NfsAVzd2PrutbWN/WOdnRM9BcUXSlyVK/mGKtNn8aXZ8tDEqzGPRd8MU
	PAdt/0e3HHpCrBlh0ASE93XBhKlkpRkR3Oti6NbKPi4q6LpDIHb3U5Z5v8AT9BYO
	OJtMP0m0LFSHwbw4Yi1A4+4hI6Ll9AeiXOo7awKU8IAJvGLprhSnxJUrW5sKHlsM
	lMHdJsQdxrLB0RZ1T68E4AU3ZeUfBRDMpAKRaCAMV4xV5qpKvHbmm+fZPzg+dpFP
	ZjtuAhVrdBon8Xr6isqqS1aUnI3ifKr9z69dMzw3xWALo97Jo7loJweUs7FbYvIc
	rDgFo0atfvOnmmJUdj0Yw==
X-ME-Sender: <xms:k7m-Z1XuMqeCAXyOMoV53IFSIR3O8v0mFNxDRLlhcNeQEQVai8jbaA>
    <xme:k7m-Z1n0IacjfEuUpfGVZNTo-EohhMo-E8yH_1J0Nh9hHqd-vj48dwl0t9KZ4UWoi
    -0PqP_WSQ5uGeOwntA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekfeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnh
    highessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgifvghirdgtohhmpdhrtghpthht
    ohepshhhrghojhhijhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepshhhvghnjh
    hirghnudehsehhuhgrfigvihdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k7m-ZxZYaRIKDhkg0F8rPM2LOMRwnVAjmQsWBf8IqurddXLQnqM4hw>
    <xmx:k7m-Z4WxKQkqVMnzoIoFrACJ1VSFKmTiWufuUbupsyjr-4ob8phJpg>
    <xmx:k7m-Z_nXHZVYWoYNvRGZ8EalC3iqTItlNAb9S7wsNRHwx9wvFqBOcw>
    <xmx:k7m-Z1dHMdax-zq8gK24rACd_ZpzBrhP0i34guJQpGxLv9b_jODMMw>
    <xmx:k7m-Z5lDgYihus_fDhfVfmt_Vye5Eb-_LEmS3fFbycjz2wrKBIjIrY2f>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0FED62220072; Wed, 26 Feb 2025 01:49:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 07:49:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jijie Shao" <shaojijie@huawei.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Jian Shen" <shenjian15@huawei.com>, "Salil Mehta" <salil.mehta@huawei.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: "Simon Horman" <horms@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <c0a3d083-d6ae-491e-804d-28e4c37949d7@app.fastmail.com>
In-Reply-To: <da799a9f-f0c7-4ee0-994b-4f5a6992e93b@huawei.com>
References: <20250225163341.4168238-1-arnd@kernel.org>
 <da799a9f-f0c7-4ee0-994b-4f5a6992e93b@huawei.com>
Subject: Re: [PATCH 1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR annotation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 26, 2025, at 04:21, Jijie Shao wrote:
> on 2025/2/26 0:33, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Building with W=1 shows a warning about hns_mdio_acpi_match being unused when
>> CONFIG_ACPI is disabled:
>>
>> drivers/net/ethernet/hisilicon/hns_mdio.c:631:36: error: unused variable 'hns_mdio_acpi_match' [-Werror,-Wunused-const-variable]
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/net/ethernet/hisilicon/hns_mdio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
>> index a1aa6c1f966e..6812be8dc64f 100644
>> --- a/drivers/net/ethernet/hisilicon/hns_mdio.c
>> +++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
>> @@ -640,7 +640,7 @@ static struct platform_driver hns_mdio_driver = {
>>   	.driver = {
>>   		   .name = MDIO_DRV_NAME,
>>   		   .of_match_table = hns_mdio_match,
>> -		   .acpi_match_table = ACPI_PTR(hns_mdio_acpi_match),
>> +		   .acpi_match_table = hns_mdio_acpi_match,
>>   		   },
>>   };
>
>
> But I think it can be changed to:
>
> + #ifdef CONFIG_ACPI
> static const struct acpi_device_id hns_mdio_acpi_match[] = {
> 	{ "HISI0141", 0 },
> 	{ },
> };
> MODULE_DEVICE_TABLE(acpi, hns_mdio_acpi_match);
> + #endif
>

That would of course avoid the build warning, but otherwise
would be worse: the only reason ACPI_PTR()/of_match_ptr() exist
is to work around drivers that have to put their device ID
table inside of an #ifdef for some other reason. Adding the
#ifdef to work around an incorrect ACPI_PTR() makes no sense.

     Arnd

