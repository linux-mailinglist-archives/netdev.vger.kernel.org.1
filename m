Return-Path: <netdev+bounces-212164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E651AB1E808
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF9718C8681
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EBD275B17;
	Fri,  8 Aug 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="dZZfc0PL"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910EB275B0D
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655079; cv=pass; b=URoeNcvoJrdtTLH8bDNFVppezhtxrSkeN9qomCDDiFKsNhuvHcbblLWO4v5M2+K/bgsNIzvZ18/lJR3RHio6iAFTJ2HnqU13/DfcNcgQXA8YMzgB1XUwPpn0ajnSgX8rMzR6GV83pPL3fcufAe9wBq4DyquAN2EKWX72t+nq7po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655079; c=relaxed/simple;
	bh=kFNdj7zsofbq4xqsJGF+WhNPUU6uRG3Ad84WahwFgYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMetLDU64TGUbj2/gy+Vgs4QtXo+9hVGfnHIVvq8jL2Wqva+BzMrhag7phIsVE3RLa6nzrmyBVND4XT8Jxd9cimWs4FP7VcPENeI1/UeO5ghOFKOrvM15/WN3a6l3JMJ2K9lI22REmjnXyd61W1Lke85iG1wvpXeOVOnbdMUSro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=dZZfc0PL; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1754655027; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q3d+nrl3B1mHKjEuK6JqO+MrcLeYXLHzGAgpN1yv6E64JnVgoMx0Xl4INfybZAZyU8KAZMRjsEVKVhVTeXYrbADvS0foLUm8mHh+GNk76YUQmRIN2qD7nhuZu7Y6YJxe1rmYJkK0uE/6C2wabM86UvqO7JqHSRun27PKTGB2qjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754655027; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fURTIr4AGdhw8D8qa3WbrFc09ZmCpIV3CYwifJ9V2sE=; 
	b=WIe0jWueD/fKI1qO0f/R7n3ODDmyA8KYIa7L2M3S877RRzIOkKdOVdcdxxY8msAMkibnT4VedyeRdKjW37yQ18sY+DfL9GMoqt05z5hyVYCBthMOg8T4W4Jio2cjswvO6F8V5VwOHDrbULgDbAtWMv4ZxlHxCER1QasXdE7heFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754655027;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fURTIr4AGdhw8D8qa3WbrFc09ZmCpIV3CYwifJ9V2sE=;
	b=dZZfc0PLr3/XOd0EjAMyo12vGlKqLRh62saTF9ZjPPK5/4Puo2plM8eZpyUpe2bx
	x7vgY5GNms2vvWMQl7gwodpD2WWZdvvKqTUFZWuuo1P7Id52TIBXhpiQJOZq6butvb4
	kTztgwhI14zmEZ9J4Ct2XB3KglBJiz9xvjauhLfQppJ5yMjjcCg/FBZy+CduN4cc5pZ
	KdrAbXsVzi3Vt4kumxc5wzUtz9jZaH/F5pHqi9QQJodmI4x6Tm564G8YYHrYoVzPnJs
	suH0GxD6IXjmDIbd13CSuNX46vqWwFQUDPcQQx6azzrkV5rJZgjXHipIwV21xIX5yWw
	SAECTnpQIQ==
Received: by mx.zohomail.com with SMTPS id 1754655024162304.97716570204375;
	Fri, 8 Aug 2025 05:10:24 -0700 (PDT)
Message-ID: <bd1d44bf-1014-4df8-94bb-a8acba000883@machnikowski.net>
Date: Fri, 8 Aug 2025 14:10:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] ptp: Introduce
 PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
To: Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
 Andrew Lunn <andrew@lunn.ch>, Miroslav Lichvar <mlichvar@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
 "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
 <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, Julien Ridoux <ridouxj@amazon.com>,
 Josh Levinson <joshlev@amazon.com>
References: <20250724115657.150-1-darinzon@amazon.com>
 <aIMDc8JC4prOmpLQ@hoboy.vegasvil.org>
 <3f722a52642dc42ad8d5e23ab06c14050d7bf8a6.camel@infradead.org>
 <aIhGJ9BzR1wY7ij_@hoboy.vegasvil.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <aIhGJ9BzR1wY7ij_@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/29/2025 5:55 AM, Richard Cochran wrote:
> On Fri, Jul 25, 2025 at 11:25:24AM +0200, David Woodhouse wrote:
>> The vmclock enlightenment also exposes the same information.
>>
>> David, your RFC should probably have included that implementation
>> shouldn't it? 
> 
> Yes, a patch series with the new ioctl and two drivers that implement
> it would be more compelling.
> 
> Thanks,
> Richard
> 
> 
> 
Wouldn't it be more useful if it came with the API to set these values?
This way a clock could be controlled by ptp4l and the set the clock
quality parameters and other apps could get it from there.

Thanks,
Maciek

