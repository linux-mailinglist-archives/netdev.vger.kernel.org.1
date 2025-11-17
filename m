Return-Path: <netdev+bounces-239050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84746C62FCC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F3CA34871C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010F31DD98;
	Mon, 17 Nov 2025 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zr7QG6p2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29341320CA4
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369523; cv=none; b=Fc/DNBl61sRrfUZMkWpR9JcpL3VV5J2HJmB3p2wmnpVihRwlyYL2TKmAuRYYhrs5towVrZJA1IzxZtrx4njZ4m3w7DBLPr1o1tuzVbx0vN3llasEmxpPqfVRVx3MsYtK0RJdcbj4k/g2xbnqqHMLMrbWOqZI3GSshXrQnZmgq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369523; c=relaxed/simple;
	bh=8Z6d1ejx0Uj/IrkRl7yBKSEwL+DAa0E6NOlwx0oQ3LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wnk9YdImbt5KDXyjO/6A63CeRgjTl9dcIuDQT0iBaiuy5aNuwkMjpL/H9B7IIKUTsczpWGqRhWFXS7hg2FziDlM+4Ftu76xzjweHkmY7TeMvdYAvlqNUkJe6eaEBAW9VuuSmv2Akp+/Q8O+F/+uS0Z5gPkEYIUT+zPcUjkRgmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zr7QG6p2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 40AC6C12647;
	Mon, 17 Nov 2025 08:51:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F743606B9;
	Mon, 17 Nov 2025 08:51:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A77E910371D05;
	Mon, 17 Nov 2025 09:51:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763369515; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QY1oVustpLjb4kKFlpFbNvuK8JxAlKLUqgiQYWDRY+w=;
	b=Zr7QG6p2SPrrbofu079EyUFbMCnif2UE/TvjsAKm8EewlOgH8M8FOtrgdERiqhZwOly52c
	tmX4oANKUNzfuIBxDQOGJiyN1vJFBpBVcLBkxGEWJ+yjpdLibzAU4XD5JjBa8a+DqscNzT
	tEb8HazfE/pG24U1XSqfrNmd8APCInMkEzAw5cOKNazQK0iUUk+W589XxZfLi02s8+OKSL
	ZWsItmcP0xhUC7KS34vNi7QStbTt40HwVd0Nsniwp3qO8yW0RNBvw7a+6H7n8tvBm0z6po
	6p+vXU54Cax1Cl8r910eylu9ki9uxJ7slOIEv+7djZ36fe5e01WnqYsmprXYkQ==
Message-ID: <dc492850-6e6b-4c2e-9869-321045c1f1c1@bootlin.com>
Date: Mon, 17 Nov 2025 09:51:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/4] net: dsa: microchip: Ensure a ksz_irq is
 initialized before freeing it
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
 <20251114-ksz-fix-v3-3-acbb3b9cc32f@bootlin.com>
 <f13d7a80-d7cc-46c4-99f4-ea42f419b252@lunn.ch>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <f13d7a80-d7cc-46c4-99f4-ea42f419b252@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 11/14/25 4:00 PM, Andrew Lunn wrote:
> On Fri, Nov 14, 2025 at 08:20:22AM +0100, Bastien Curutchet (Schneider Electric) wrote:
>> Sometimes ksz_irq_free() can be called on uninitialized ksz_irq (for
>> example when ksz_ptp_irq_setup() fails). It leads to freeing
>> uninitialized IRQ numbers and/or domains.
>>
>> Ensure that IRQ numbers or domains aren't null before freeing them.
>> In our case the IRQ number of an initialized ksz_irq is never 0. Indeed,
>> it's either the device's IRQ number and we enter the IRQ setup only when
>> this dev->irq is strictly positive, or a virtual IRQ assigned with
>> irq_create_mapping() which returns strictly positive IRQ numbers.
>>
>> Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
>> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
>> --
>> Regarding the Fixes tag here, IMO before cc13ab18b201 it was safe to
>> not check the domain and the IRQ number because I don't see any path
>> where ksz_irq_free() would be called on a non-initialized ksz_irq
> 
> I would say the caller is wrong, not ksz_irq_free().
> 
> Functions like this come in pairs: ksz_irq_setup() & ksz_irq_free().
> _free() should not be called if _setup() was not successful.
> 
> Please take a look if you can fix the caller. If the change is big,
> maybe we need this as a minimal fix for net, but make the bigger
> change in net-next?

Ok, I'll look at it, I think the change won't be that big.

Best regards,
Bastien

