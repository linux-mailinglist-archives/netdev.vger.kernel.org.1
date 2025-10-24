Return-Path: <netdev+bounces-232439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB92AC05BF9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13933A7E55
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC031D742;
	Fri, 24 Oct 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wFOTnljM"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9B313527
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303262; cv=none; b=tjP2xEQk+7GQjVKa6fRefP65SAIkxcZzwtR7GXgFE2GTgpNZCh6FpxNU6ox4pSbjn4Pu0blQhW4Yw/+PLU/OLLUSojWYwSKfOKU8zCAk0GGpdtnscsu7Te8LHbjUX+9Wj5CEuPCo4KhNBeaij82+P1nxYd6H4hayf1g3YWMgGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303262; c=relaxed/simple;
	bh=YRuUk72X48LKbl0NGFTto3u3r+cewoHN+3hW6sCm2Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lu7fY3qJvQUFQ7od4V2iXKRdXj1BaXKb/koQ+WzS8BmDrEC5MgBKeFks0mYODU3tuEpuf0KR3+TAOnOUUlIBtNvps8TaOjDLiRcEG+XMXlLwmc6RCcYNVNhbUwvEFML7zI8eqUy2kRlWmVCNKAdKHRSXN2UxbKt3au6Cx6vshqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wFOTnljM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 340764E412D8;
	Fri, 24 Oct 2025 10:54:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ECEF160703;
	Fri, 24 Oct 2025 10:54:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96ECB102F2355;
	Fri, 24 Oct 2025 12:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761303255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=y1Ao409MtaPgUYRpBahYZXHRywkGhOPNNwYQ3CbOmSk=;
	b=wFOTnljMgZcJ9fFHGVUItDYZLELl/nQ9UUjZkKVBZJ440S5fcemvTZjmbaMAdRgSKyuPz/
	8lsfoDzhq2GxO9LzzfOwG4pEW1uh+ApYVf0cjxtPFBmz3Z3b41IxtAqXOjgpkrg4ZMVwRf
	LsrdvvwKXqgxFfBn+dwd1CAiRrutSKALKw/kGdv9Xuxfu8LVqJ4+jn821L91R9OTL6Mdu6
	NcFpnAtXY3nHeQn1imhGR8o123Lrkivf8wYdoLljGN/f/V2m/fW7MHsCuz0u2op1dJNw5L
	6yL9i5xDEF+X/qPX1MthiIvhw+8BJruccXktW9g7OJwJ8DS4bhbeNq4ZuA74Sw==
Message-ID: <1a1cacb5-0005-4b32-8e68-624644a38f92@bootlin.com>
Date: Fri, 24 Oct 2025 12:53:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <28d91eca-28dd-4e5b-ae60-021e777ee064@bootlin.com>
 <aPtZg_v3H53hiQXo@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aPtZg_v3H53hiQXo@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 24/10/2025 12:48, Russell King (Oracle) wrote:
> On Fri, Oct 24, 2025 at 08:44:07AM +0200, Maxime Chevallier wrote:
>> Hello Russell,
>>
>> On 23/10/2025 11:36, Russell King (Oracle) wrote:
>>> Hi,
>>>
>>> This series cleans up hwif.c:
>>>
>>> - move the reading of the version information out of stmmac_hwif_init()
>>>   into its own function, stmmac_get_version(), storing the result in a
>>>   new struct.
>>>
>>> - simplify stmmac_get_version().
>>>
>>> - read the version register once, passing it to stmmac_get_id() and
>>>   stmmac_get_dev_id().
>>>
>>> - move stmmac_get_id() and stmmac_get_dev_id() into
>>>   stmmac_get_version()
>>>
>>> - define version register fields and use FIELD_GET() to decode
>>>
>>> - start tackling the big loop in stmmac_hwif_init() - provide a
>>>   function, stmmac_hwif_find(), which looks up the hwif entry, thus
>>>   making a much smaller loop, which improves readability of this code.
>>>
>>> - change the use of '^' to '!=' when comparing the dev_id, which is
>>>   what is really meant here.
>>>
>>> - reorganise the test after calling stmmac_hwif_init() so that we
>>>   handle the error case in the indented code, and the success case
>>>   with no indent, which is the classical arrangement.
>>>
>>>  drivers/net/ethernet/stmicro/stmmac/common.h |   3 +
>>>  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 166 +++++++++++++++------------
>>>  2 files changed, 98 insertions(+), 71 deletions(-)
>>
>> I didn't have the bandwidth to do a full review, however I ran tests
>> with this series on dwmac-socfpga and dwmac-stm32, no regressions found.
>>
>> For the series,
>>
>> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Thanks, it's good to have someone else testing. I do need to post v2
> with some tweaks to patches 2, 3 and 4 due to a typo that gets
> eliminated in later patches. "verison*" -> "version*" in one instance.
> 
If it's only typos, feel free to keep the t-b tag :)

Thanks,

Maxime


