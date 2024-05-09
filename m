Return-Path: <netdev+bounces-94739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA88C0857
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003FA1C20F7C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 00:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ACC36C;
	Thu,  9 May 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="pWaAkx6f"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AA38C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213715; cv=none; b=uc6Mnhcyi4QX/XN0jgeb8CGM7QKQi2zxU8zjzLJn6JCHOOlVy0Eh5yQtZeTIBsV8rVvdwcYz8QmaDHTextsUzPZ7m4ic0xaIqTPnTeI/c0PMLe0PldkG430+4TTB8mUoWL9Htk+qVE+QNqvFGI3ZnnhZzs/KfuQ6mCHyiWrnQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213715; c=relaxed/simple;
	bh=cli6+LgDnP72PgXkJ7oRdn3GdcBeHlRJOFo6WhjzUs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRtH5aO9MAxpc7HJX9/stjoI7uBnfv2exzipgp3pLCyXUatCD6ax4+zhI2gK20dXyrOfUhY/BS/x3kvApA+BPhyicPU/BBvbSctHw6hOcOLa8bkK/z8Y+wfMLqSVc8GqenuEtLF8eGDTMoLcRrUJ6k5/SkCDeiSloL9+uw3+QQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=pWaAkx6f; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715213703; x=1715818503; i=hfdevel@gmx.net;
	bh=cli6+LgDnP72PgXkJ7oRdn3GdcBeHlRJOFo6WhjzUs8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pWaAkx6fwhwWuqObUwI9T2mWmfzfgAQSVMimVVRr+nLQzdNvQ7Rgs/EJ6t/e2uqX
	 sBxeGxAYdlVozqgtKSj0NtQw5BXAGDvaTNn66gaRz7ZvpcFoLtC5Sh0IhsSXGeY/R
	 DHvdTvQ9jnHjf/zn4xQkMcQP5q8/Rt7tCj+vWLNrN5qmZQvADSCXKmVFpbIqIZt9x
	 CanlG+GSsdVyrFRsrhwC8DPuxXWzdAdbgMM9kZf5rNwi9FOga9OqbAynka177eWnh
	 RDNmk8C/WSQE1tCdIEKLUlRyXFvGM4DSS/qaS8dZfTYs6zZLlIs+3p+dV+LzP9RFK
	 VymwbZU73wrWJqE34g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1sljWn3Xxr-011fc7; Thu, 09
 May 2024 02:15:02 +0200
Message-ID: <4a54c821-3b26-47c9-b99f-9b550d5ee706@gmx.net>
Date: Thu, 9 May 2024 02:15:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/6] net: tn40xx: add basic Tx handling
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
References: <bde062c3-a487-4c57-b864-dc7835573553@gmx.net>
 <20240509.080355.803506915589956064.fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240509.080355.803506915589956064.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:slkbhVi0vBPDZqQVNaVHa8ZjumeecDQBvZwSshPC5qUGpGgdxND
 VC5u4pJwqTPEqFjUDodgRxvu8872J/cyhFGDBQwWEfMOFeQREtqU9hhf9luN3xks+dEjPFP
 SEXMxttRXo2H41ZsFEASviCi/5d+YtjCThxNHIat42X/LeIX1+z1DMW5wGKINcF4wvZhxbp
 VPZk8sBQArx8AlR7814tA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gqYt90QZnGc=;nk9Hca60F2YrsK1V8JfO+wShaZJ
 WgyENliuPYm3skBNcLkQGdmpERrqYhvFINEhVy3wccg5n2vjRwHoQkRAmFajX/5P+JQxqyu6F
 08eMCueSqtRF4iIgL3BAqOOa9QHZvGRkjygi5zY3PLAkmXfad6ryAmnpAoYI3E5VIa9xqJQIS
 xUOMwbzBXbplNCMCizvAPqwzJM1d17jQrcgSTCKeZa4A3TAdqMLrMcJNdkyJIvHWSDWJhWxJr
 7qguIAyUgapA15yCmrvqR0u9l4Vv+FWDDZdw3FkNKuTxGy9w+A0vt6D/TuNkQD3bWD82/cPrJ
 8fChhdDPYQcJ0FL974iDxiu1lvRWp1u4FOHf3u/GLc4bMuu685kRP737IgsPkVXYRO/Uxc/Qf
 fuEcv/ke7RXmRyRtpi9XSLS1UpX3MrACYG/wMpvPv5ZQuB0dVuRyLbY71g1u9G+SejTOhO3q8
 nJj/9NLg8xslQwQFPHQCGaqJkqwzIc2OFHAUOX4DZTGKEU5Qrxr3kJzZ9YqJ/3rRQvNdEdbrB
 6OnK13kiNSdlFUOPNa+Vyb42pQjWdvxRoC3FaYJDSfLrXpUolLbKjEUZ7FNCj5z7lb8rmLi7z
 V1qCC3CU8LVEYZAGKVMEgTjv3smOg7ODL36OQxqO81OkZv60RL7YaqDPwHoW2CEiQFJi6UZE+
 qDuXzZboa+UME1lLn613BFkyghTLfFn67X5u1h8bteI76ZWvgvG5WYhSWHItKtcYzJqVhcl0v
 uDr6JHiirXothYGrRqMWsn1O9qyHJFleZBpP7VaMt+HpM7qo521JIn85yRK4/M52zJHTF+Grt
 2yUGTWO99mJSkii1GhIU5Yqql0l5qCYgLmiScjBUCIFrE=


On 09.05.2024 01.03, FUJITA Tomonori wrote:
> Hi,
>
> Thanks for reviewing!
>
> On Wed, 8 May 2024 19:46:05 +0200
> Hans-Frieder Vogt <hfdevel@gmx.net> wrote:
>
>>> +#define TN40_SHORT_PACKET_SIZE 60
>>> +#define TN40_FIRMWARE_NAME "tn40xx-14.fw"
>> why is here a new firmware name defined?
>> The TN4010 uses the identical firmware as the tehuti ethernet
>> driver. I
>> suggest therefore to define instead, in order to avoid storing the
>> same
>> firmware twice:
>>
>> #define TN40_FIRMWARE_NAME "tehuti/bdx.bin"
> Ah, I overlooked the firmware for TN30xx. But TN40xx and TN30xx use
> the identical firmware? On my environment, seems that they are
> different.
>
> $ cmp tn40xx-14.fw tehuti/bdx.bin
> tn40xx-14.fw tehuti/bdx.bin differ: byte 21, line 1

the firmware in the linux drivers from tehuti (versions 0.3.6.*) and the
Windows drivers (4.4.405.15*) have indeed a firmware included (in file
tn40_fw.h) that is 16 bytes longer than the firmware tehuti/bdx.bin in
linux-firmware (42784 bytes instead of 42768 bytes). The difference
between the two is, that the firmware in the out-of-tree driver has the
first 16 bytes duplicated. Everything after the first 16 bytes is identica=
l.

md5sums:
tehuti/bdx.bin: b8e1cf61ae0a0eea2b47bd8d81e1c045
firmware from tn40_fw.h:=C2=A0 2ad73a519d78eab9155277ac0fd3615a

Unfortunately, I don't have drivers for the TN30xx (nor hardware), to do
a direct firmware comparison of the drivers distributed by Tehuti. So I
can't double-check.

Running two TN4010 cards with the firmware from linux-firmware has given
me no indication that the duplicate 16 bytes in the beginning are
actually relevant.

Comparing the tehuti driver in the linux kernel with the out-of-tree
driver reveals, that most (maybe even all) register addresses are the
same in those two drivers, leading to the conclusion that in fact the
two chips must be very similar in function.

So, maybe I am overlooking something, but for me it looks like that the
same firmware can be used between the TN3020 and the TN4010.

Give it a try with the tehuti/bdx.bin firmware and check yourself.

Thanks for your effort of mainlining a tn40xx driver!

Best regards,
Hans


