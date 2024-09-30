Return-Path: <netdev+bounces-130365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3298A37F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498D21C22EB0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C9518E023;
	Mon, 30 Sep 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eX0ojKVc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75118EFE1;
	Mon, 30 Sep 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700736; cv=none; b=LuBC6jua1t5/Dgh/LYisEcuSVO74OPp7SAx1k7Sx77BaUJMe4t15KlDWr7t6e1PDwqc+W74L7j/WkkSiyg0fDu6nLbJimXj42lkqj3xAZT8q/9SStC9lmEOC6HCg+lLbWdyx4Q+k8LKLLBJHvt/tFetyy9wjwNEitXm/ZvbTnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700736; c=relaxed/simple;
	bh=KXWDpFrAIhachM2EMwPDXtL0tFet7X4Ku8wgw9+P3y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpqE5oInwbagfdFGH5pmwBdX9ytA2qqd/2SUrOfD2ANwB03b49AX20nvX/rJOQ82xP8d96CjP+YhOiDx72dtFicL0pXSmKctdf3I3djHGgvs3ttu0M0kEEX2sFGKZA1QAKMlVDt+Fy+nnQplZaA5js2f8jdU6acxALwFvSQ2cJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eX0ojKVc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727700705; x=1728305505; i=markus.elfring@web.de;
	bh=KXWDpFrAIhachM2EMwPDXtL0tFet7X4Ku8wgw9+P3y4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eX0ojKVctUoGhhukf8ccA6EtfnMcphjBOrNC6sxdX5lRCDk6bzv2X/teIngs7Qdw
	 DE2N/yKAtOSV5oSoeljkJ+HKM5FRdLyFxcolTqveujxuHUgS+i0ntQ0MiowC0mwZI
	 85vDDHE0gNc1NAsk0o+pwsjDO0sL9ghkcPWT4/cBZsd7ADAyLJ4ydUDbiLQYCMTcz
	 xYCpOMT14XnrZvxYHdyUojyWNHEuC86zm8sKbHu92spqkS+AqUaDO9cxiA4kCb0G1
	 7J7N/bOID8yN68nNj9FnIvqNKewIkun5YvCbNBo6WELUxPF+EkyG9RCtDK1F5R6xp
	 GGD6sNCY4f9daWLOGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7aV-1sTZRW0fWB-00StZN; Mon, 30
 Sep 2024 14:51:45 +0200
Message-ID: <3f4228f2-3ad5-4491-8236-6a7fbc5274ff@web.de>
Date: Mon, 30 Sep 2024 14:51:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cleanup: make scoped_guard() to be return-friendly
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <21be0ed9-7b72-42fb-a2fb-b655a7ebc072@web.de>
 <34d2f916-3551-4b75-b87a-9d413662369b@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <34d2f916-3551-4b75-b87a-9d413662369b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kAxrK46s8Wcx8kQGjxB1JNRJToJMJxN4A2l42eOMuO4XWZv2p+0
 abDsr+S8U/ZrPYMkqQVuKJa7qfyU9Rosw6Ug3XyivMVNBnOhs4uipe/e6uuyLyoLPl2AhlB
 ZzpgId0/Rr0BqfxvhgQisQRXIaipG4A+9afB9IYZVGj5/CjiJ5jEWTQ6JxHw04FH2wfNu1K
 rTNWhKtSV2ZasmaLiLSNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pgE1M2bA76s=;zenY1a8l/x+gQ+Pvwa4rnufisuH
 BBwUyCoA9lDJlBQYER7Xtpb6kfkl72B6emyZRfwD/I5BvbeyMQp5vW6HqKqi89EPHXSwxmRRq
 RYDUSGyoJ2f7ibdZrNNLICa586I0d1qsgg30h13F54m/t4K0S1Z+CBVNhL0hvBeWnnmEcfbA6
 ratQzQG1/HnoC/GAA3RTKHIB0QAo3giRURA/iCh9pjifEzaQd4fcz1CJiNZ8fGGewa3oyF7lL
 9UahG6/FO7jGoS+KrqSrjmBKacUmqhlUHZhp3UogPIyDFHy4jrYFP5ftY4SopgvKgKSdG3DEF
 FhLSVh5Z9TrLi/pEzDRPjEXnvPACbgS0HsvkOb036mXr0nhXDT3KMa5+pxR4bBCSOrLOlNGGT
 LZRFUyVx15ZQvEeM6U9b8W6ecKMz/sl35nmqhOxu1YXlePlKNy8i7LcV1XQ1Ce71IQO0PBhNS
 9V0L6fIrI1QHCLfAfsdPALZx5gZ2HuqD0nyu4b6wkYuwjBDFONl2CaJmjjmYijdD2XFqZ2W5w
 nx/pXjEjJ7YME4ZjmyzsFmueG4cJJ2OH2D1AcOsk+jy0z3X583PNaRB60ZrAXr986IedrHIGO
 uR8teT5rNT7ER6cyAU4NxoSj1C7/RRpNVvADyoyHtxrRyNATNb+7qYZFXO2Ou8chStMYyZjgo
 WQ9xjAjhmG0hOTc5tE8R3UIfX7J7XRUT1Mya0DBI+uh5It8oyg/yx7VIocFs3Z5VFoGpDAQEM
 b16ihtYH5aYiCWLH3aW8PWT/yFHdlJsQMlhYRDVOvlw9za0mM6M2gAWr4SfAnr725yPPBfXvn
 MhuwBvZdC/kpXmQinRxCNzNA==

>> * Would you ever like to avoid reserved identifiers in such source code=
?
>> =C2=A0 https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+de=
clare+or+define+a+reserved+identifier
>
> we already don't care about this guideline (see __guard_ptr())

Please take another look at name conventions.
How do you think about to avoid that this software depends on undefined be=
haviour?

Regards,
Markus

