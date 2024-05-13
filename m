Return-Path: <netdev+bounces-95900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9548C3D19
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6DF1C20309
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5322146D6B;
	Mon, 13 May 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b="DOWpL+KJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB41EA8F
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588678; cv=none; b=pAlClOHhsbrwXZc8IO5+ekfhwR5PCulUsNqFUCitLc5cH07iC9WQ0q59tHvx3Qn1/3Vlpln272qUWF9VbPJgywPn6d5SfAmCI6OQG3AZSmWzB568GdrCn5HERuFALY0sc5DeEoSH96FNxzFrkVUkYc0NtiO7usKXtQErWSFJs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588678; c=relaxed/simple;
	bh=kPZGcUciagk9Zkn2GCD+FcojYZ9ri8LToUCaM8U8kAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Tvr1iXhPh/9h2YabwvXGAN5nhYkbmwogMQP88paHjW5J6Cko7FPVZEmWsFyQW3tqHmtFVFQxy66e84RBiTAvxBsugWGcieNBo91I9F7MN2Y2kC/BNGIrrAkbTaL/9RHf3i/zyQmHtxBC5HFjoqLM6/tuWlKuzn+ye/uUeNfojMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b=DOWpL+KJ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715588666; x=1716193466; i=radisson97@web.de;
	bh=kPZGcUciagk9Zkn2GCD+FcojYZ9ri8LToUCaM8U8kAI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DOWpL+KJD59+ddKr0yDT3ERyt3f7cWmhTyUJjIjwulkOVnnXM46Ar5i63QJM+3aU
	 8VSMIWzUrsP9Z01rYXlEwDtF5F06aUQdk/eqLhfn7RENW5KlTHGUl9GmjQrdX/7Tz
	 5uKdB9KSmDauldj8h1YN5ELvYgiRHJ2UQ2W0Q6kFfAeo3aY2LVTNRZjcdWhlvGBsT
	 eEGXbtFk0zxCf7G4N9wXE12eaRILnZsDfOGls7GF3OEgILuU90FZbS6m5ZxBvE0mt
	 Jd4wH6bica/lUmVEuXHydG5hus2GV5bVtTPzdvEEwP9zQ/WZpt0RvEwmtqi6aWCZZ
	 p76juWFxOKfTOb7+cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.186.1.202] ([193.174.231.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1sm6S20wFE-00qO9Q; Mon, 13
 May 2024 10:24:26 +0200
Message-ID: <d655c5d6-86fa-4e42-a276-522e681062bb@web.de>
Date: Mon, 13 May 2024 10:24:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: patch device tree and AX88796B
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
References: <a2ef46ba-ba3a-42ea-8449-3e3ae773fa1e@web.de>
 <d8e47275-db48-441e-a06b-0aeb16e32700@lunn.ch>
Cc: vadim.fedorenko@linux.dev, netdev@vger.kernel.org
From: Peter Radisson <radisson97@web.de>
In-Reply-To: <d8e47275-db48-441e-a06b-0aeb16e32700@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UlcVDPFduENorii7odb36Iig3hhdUW0kQhDjzbIfsWi3nN4srZd
 Og0ddHQYVhXuhCCZf8dQct9demYvZLjLo3H7KocU2tygkzElItGbgAyenOPta7R4gFL+qJj
 k3F/MZ39meXD5HFWM04E/RukYgmDqpV5UJdE+yQbeM6AF9oENJIW9dvXpj4Ec8BKxg/M8mp
 NdyO6s4cZYakXKaNeWo8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pAGpMGr2PMw=;JF9KTGs9OOqiZAqohutPvWPVGy9
 A7fUHg+C6DxHIz4WsGN4trU42z9S+y4ffPJbhBLwZAAPUFrWhI0NkI16bZTBJwA9TVyREhpXZ
 3xgZ3XFmw5C1lj/l9z5DJZwA4vbNqy3pTlS/xgBfavlHoSDpuSzMGxm+Fi0j0pkpnkcJO22Gf
 HCsTqqPVqBVu/ouISV+7zZunBekisYhMMMBSFhB9jGoIL7MDvpSTXePApiXptXIbiEoUfYgzi
 yIWv1TjbxU3TYyzmqri2VbXtAh6FkgXbKMPH67cXSr7oanFiwi1Ej15frkY/f/0FfvDfbfvsh
 w2I1RpNwMRHYO6ee7laIpEkFWGwXcfWUrVlBG+FltVdXB0LWahv3uDg+3MIgueNWqnFywK7SD
 9LxJ4IzPBZxX+Qp6xc2zFdMamGNevivDIVAkSQVah0JKpfjMXm+O4Zgch9tvHQIXUMgx/tW6S
 zbBaCQ2feDHO80TM60ST4D3XjikK1i0PXNGHVVn6BBoQ9OcDHsafpACEU5H0lvle0N4jZB33W
 Lt6y8Z0eEIMI+AuImj21YIj9eyA0pAeAQEALL9c6iuogbNzJEbTI53OB7vbsRELqpKBzdGewz
 u0kP3ieq9kfwiRfGI1af1y1LPgTrbpUtYpNLT/qNtBcfkYwQy4wyoo5anlY2Hk2komHDKLqDl
 aRhG4ChVRRhYIH/a9UvdhNDQw2MFFYm/FDKneceJ7TymQx3OYFQTv+jUHaYxrC4CmIG6PHnSG
 jwZHhcbxeoeo+I935IY/omvPzXolKl8IdBKNG1sp3FFm34n7Z8YlpAbEwwgunnDPFZ5mv76/b
 +qiHNVkGwFsYoZxudB2lG9EfjsWhTWMivpD2824zUXkbU=



Am 29.04.24 um 17:28 schrieb Andrew Lunn:
> On Mon, Apr 29, 2024 at 12:24:31PM +0200, Peter Radisson wrote:
>> Hello,
>> we have a custom board that has a AX88796B on board. We have a company
>> that wrote a device tree mapper for the driver (actualy for kernel 5.4)=
.
>> Is somebody interessted in picking that up ?
>
> I'm not saying i will pick it up, but i'm curious.
>
> Do you have patches which extend drivers/net/ethernet/8390/ax88796.c
> to add device tree support?
>

Hello everyone,
could you do use my patches ?

CU

