Return-Path: <netdev+bounces-235418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055E5C303D8
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BA4189920F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABEF31690E;
	Tue,  4 Nov 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="00cJqhCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4033128C4
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247753; cv=none; b=La2bKMgG9RwOjlh2WNqlgHPBV9unEIjgZ7xyamu3lYnsHDFDzOyLGX7+FlCqc33WOckb2BdKkPz2bzO0i8esVHCA2k50L3JwXBIXbkbbeV+RIwW5vD7jh//gGZn1HHyEY5j2l1MVwvtUgA1MAEue/2iiD9DJRGTqZFN89F5+vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247753; c=relaxed/simple;
	bh=QqjCyv5q5RfCyuymfbPqbgOb7NBqueUu2hGwxgepz5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdassGFimHPfzyOvEiiNcAD/K8i2XAW4wcBRqOF0ixepUuVS8l7u8qb8tUW9nXbAWFEmDG9kcT02UW7FH3uwGDeXw6EbZlJHaWN5xXJoDPHmR2+glUWGCJ1EGbsRFOkg0T+Js5umfkMoVp3lkBom2B+PgvgHSw5U9+/Ohhl61iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=00cJqhCm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8ED844E414F0;
	Tue,  4 Nov 2025 09:15:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63D24606EF;
	Tue,  4 Nov 2025 09:15:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 547DC10B507AE;
	Tue,  4 Nov 2025 10:15:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762247748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nZfHsIemIQOZ1ThC3pK336yU57Scn0K8tnPQDfblRgY=;
	b=00cJqhCmeGFuHIaEjJtR/3DPQ1/caMaI+8nVm6UBp05+E0GiDEKHAGOf/yzPlN/quI0JBs
	m0Bq2fYGAkFS0flfkvAT4ptsfAsUnAER3EUc/8qWY2PN6gO32mTuWqERu6xWTxSLeuh5ah
	wgOyCAopNClqhlKGA9sZGgTeHQsvkcyGHuHM3fVsY2bMy7h2NULwWriMDiimWnupZalXag
	qqbkbQfPQMNd5iEIDsdRqgQ0h6Ts1tZZ/v2bQKHLqZBwR6wYWhz1FJa6a0lUyFPLA07nEf
	giIIKvzjuZtQdUA0O9RSxZyMXKWiqFBiYOiMtJf1tmhrddmUZIgYPa/ajcUNSg==
Message-ID: <e2541569-bfee-4548-a399-af2e43c7a53a@bootlin.com>
Date: Tue, 4 Nov 2025 10:15:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
To: Romain Gantois <romain.gantois@bootlin.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
 <20251104-sfp-1000basex-v1-3-f461f170c74e@bootlin.com>
 <aQnA8HZjKKgibOz-@shell.armlinux.org.uk> <4689841.LvFx2qVVIh@fw-rgant>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <4689841.LvFx2qVVIh@fw-rgant>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 04/11/2025 10:10, Romain Gantois wrote:
> On Tuesday, 4 November 2025 10:01:36 CET Russell King (Oracle) wrote:
>> On Tue, Nov 04, 2025 at 09:50:36AM +0100, Romain Gantois wrote:
>>> +static void dp83869_module_remove(void *upstream)
>>> +{
>>> +	struct phy_device *phydev = upstream;
>>> +
>>> +	phydev_info(phydev, "SFP module removed\n");
>>> +
>>> +	/* Set speed and duplex to unknown to avoid downshifting warning. */
>>> +	phydev->speed = SPEED_UNKNOWN;
>>> +	phydev->duplex = DUPLEX_UNKNOWN;
>>
>> Should this be done by core phylib code?
> 
> I guess that enough PHY drivers do this by hand that a new phylib helper could 
> be warranted. Maybe something like phy_clear_aneg_results(), which would set 
> speed, duplex, pause and asym_pause to default values.

Note that when phy_port eventually gets merged, we'll have a 
common .module_remove() for PHY SFP :

https://lore.kernel.org/netdev/20251013143146.364919-9-maxime.chevallier@bootlin.com/

We could definitely do that here :)

Maxime

