Return-Path: <netdev+bounces-250538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C16D324FB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FF430E1EE3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C128CF4A;
	Fri, 16 Jan 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ScN0bD2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B028C5AA
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572058; cv=none; b=o5WpghacJPMlPT4YM4XSI2tWowzQFChVXN69trJpz/+MWyOJbz67gdmifIxSwWjhpqbIa2HrUgxekljmP6AzRlTDaGBPDMTJaVt5O3jInQ6S9VwICKSnk+EZwnQv4n5nXpUnzXiJsNbLUDaVioXdXzt4F62nBnuy7KvaGd9hpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572058; c=relaxed/simple;
	bh=5HJg1+r27vjf2hpwiUI/JpMFhcLfSGQf53bp9hNPWP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlkTnX/YgArA62CwtLs8E5Cwx+lNAARA31Pe6STlvnKMw5tHkvqXZCa4I6saG+4mVkEB88+UO0M9b2Ck6dGtzVOPiVW/gXkRbzjgW/FoX7gAEbL6M0ZuQifIFVwOZRNSJ1DAAinSaKlez+4d3/3XpomVZTYmVC+HKrqmLcU1GR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ScN0bD2r; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 985951A2785;
	Fri, 16 Jan 2026 14:00:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65FC760732;
	Fri, 16 Jan 2026 14:00:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1AD0F10B68A9F;
	Fri, 16 Jan 2026 15:00:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768572053; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LB6Omhs0m/4Gl4M16+1Ov7LcTMAb+BD/AbzAvX1qW+w=;
	b=ScN0bD2rkbsnJzdBmQtH/DP9dpZdXBRPyXJoLiqw0Egr/8d+fcjxu/JXOzuD7Lh3EdNiTJ
	v7tAXMd6gauQtqGn/JJPnG+Pst+qEczKibMcA0GJa5gKOdur5A99w+fKvDm3Edd9E7MSqA
	y2Q9t9BcyiQYPgdJsptZTD9EWCnQiLUzMXxIKyFaXS/4OHKttCV9xxYKbjBrSgYnHboJZt
	NVWqL8mCoh5YNFYDi5V27stFKGJEZgF1jWGD4x6PQehqMA8x/lzmAWWN4CaJB0uv4a/Yje
	999RIYwN0INg5c5UTr9/buj1mA5SDi83B95wUjff9hWfgHdNYHtIM9CDRoUJuA==
Message-ID: <dc0531a3-b9b9-4b51-8ce7-f03e23ea0877@bootlin.com>
Date: Fri, 16 Jan 2026 15:00:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 16/01/2026 14:43, Jonas Jelonek wrote:
> Hi,
> 
> On 16.01.26 14:23, Maxime Chevallier wrote:
>> I think Russell pointed it out, but I was also wondering the same.
>> How do we deal with controllers that cannot do neither block nor
>> single-byte, i.e. that can only do word access ?
>>
>> We can't do transfers that have an odd length. And there are some,
>> see sfp_cotsworks_fixup_check() for example.
>>
>> Maybe these smbus controller don't even exist, but I think we should
>> anyway have some log saying that this doesn't work, either at SFP
>> access time, or at init time.
> 
> I tried to guard that in the sfp_i2c_configure() right now. The whole path
> to allow SMBus transfers is only allowed if there's at least byte access. For
> exactly the reason that we need byte access in case of odd lengths. Then,
> it can upgrade to word or block access if available. Or did I miss anything in
> the conditions?

Ah true, true. Should you need to respin, maybe add a comment for
clueless people like myself :)

I'll see if I can give this a test today then

Thanks

Maxime


