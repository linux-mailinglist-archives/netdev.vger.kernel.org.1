Return-Path: <netdev+bounces-229928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA94BE21BC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A521F3510A2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD263002C4;
	Thu, 16 Oct 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pBEULoiR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA10248F7D;
	Thu, 16 Oct 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602518; cv=none; b=dHB23W9qwf7uCJn8pjyveM1QCC3uG/ciYkAEWDwPpyY3saEwK0aPQWQcl7yoavGi11OqgTwH4FZph+WfMZXV+h/ATpEPnEKDx4GHU0532Uc/AU+kO5WGCMKFq1UGMFRbMkrwh4fBaSaThShuZjlYOzre7bwI1uXZBxIWxvLBJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602518; c=relaxed/simple;
	bh=qsr1nVJV6SCeROqWZZrDkXqfhgt8sdr2zuj6CMu9BbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cueMQ79VV6s900ZOXqRrtEJf+XBfTKROqXROlBtwCyGuD82F/nBHi1dIFpy8mqiTU7cngepADGaIwX9VpHO92We/6l26HKTzhYepJQ7CcBmc6F2cdxwP4K2WG1P8ipmkt0cZRyo2KBvOS3XmuYMSd5Aa+iZQcH8TsO9ZXF4xTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pBEULoiR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0847F4E410F3;
	Thu, 16 Oct 2025 08:15:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D17616062C;
	Thu, 16 Oct 2025 08:15:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACE2B102F22B9;
	Thu, 16 Oct 2025 10:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760602512; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dXsurt/UB6adbtX7xqXZLThjuVgu/eCgnHbY5gWKelw=;
	b=pBEULoiRmAouS3SHUlKOJyrqWJ1t2pWZMEbbaVEaGbDYSH8OzKzPbTtL5dRUoMhvF95Czb
	2A5X4dM7SfrhDOhll7Qjw/V3SmjgkR3m0USf630ew4Kns4/6FGHU/Sy527JAvABxPeBc53
	tEqrPxK2eGLRHIF2YDaF0FGQTOdf5Jp+vf1PKMPgca8yso8uIL3nlUP7lQ7jhH3f6k/IU3
	GtTcWvhzBu8exiUKbVHyINlfRkh8a/F7HLdPego1MiE4fuabbF4MyWu2ZkNz0FFkCPLrRJ
	KOizvsmFFq+vZVxJOQxaPLAAiy0mCHeWPQulGTJZGpUL73FZIkidBmQbw32sJw==
Message-ID: <328d5953-aec3-4a1e-b2e3-268155793996@bootlin.com>
Date: Thu, 16 Oct 2025 10:14:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: stmmac: Add support for coarse
 timestamping
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015145519.280b6263@kmaincent-XPS-13-7390>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251015145519.280b6263@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 15/10/2025 14:55, Kory Maincent wrote:
> On Wed, 15 Oct 2025 12:27:20 +0200
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
>> Hello everyone,
>>
>> This is another attempt to support the fine vs coarse timestamping modes
>> in stmmac.
>>
>> This mode allows trading off PTP clock frequency adjustment precision
>> versus timestamping precision.
>>
>> In coarse mode, we lose the ability to fine-tune the PTP clock
>> frequency, but get better timestamping precision instead. This is
>> especially useful when acting as a PTP Grand Master, where the PTP clock
>> in sync'd to a high-precision GPS clock through PPS inputs.
>>
>> This has been submitted before as a dedicated ioctl() back in 2020 [1].
>> Since then, we now have a better representation of timestamp providers
>> with a dedicated qualifier (approx vs precise).
>>
>> This series attempts to map these new qualifiers to stmmac's
>> timestamping modes, see patch 2 for details.
>>
>> The main drawback IMO is that the qualifiers don't map very well to our
>> timestamping modes, as the "approx" qualifier actually maps to stmmac's
>> "coars" mode, but we actually gain in timestamping precision (while
>> losing frequency precision).
> 
> https://elixir.bootlin.com/linux/v6.17.1/source/include/uapi/linux/net_tstamp.h#L16
> "approx" was initially added for DMA timestamp point.
> Maybe we should add a new enum value here with a more suitable name.

Yeah, the terminology in stmmac of "coarse/fine" refers to frequency adjustment, while
the "fine/approx" qualifiers refer to timestamping.

I'm OK to add a new value, with the usual risk of seeing the number of qualifiers
explode if different hardware to that in different ways.

I suggest keeping "precise" for the default mode, and maybe use "enhanced" or
a similar term that would imply that the improved precision is done at the expense
of some some other aspect of the system (and therefore probably not
suitable as a default).

Maybe Richard can shed some light on that ?

> Regards,


