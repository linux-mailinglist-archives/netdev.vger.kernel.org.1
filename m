Return-Path: <netdev+bounces-92291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8088B67AE
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0EE1F227D1
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9E1FAA;
	Tue, 30 Apr 2024 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="IC6I0rXC"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872F523A;
	Tue, 30 Apr 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441835; cv=none; b=AUQwvKlkhomTErH6RcVGjKjxklJtwTasx7tD9tN/AUtPo3pfShfLYglkh5ajclkkwBqTp68Cy4Y5bDIOC7jVA63fAUoUhLu1UNJJt+C5WVsCu/8JfyPe6fX2vC1L/Ww5LQ9SKmR8yBWKigtF8czj+EdsjxHj+evJFuxZT3Zwj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441835; c=relaxed/simple;
	bh=b741OSvYDDjl8rHNwRbREyNb0QV2+n35kf+AbkDkjo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHlYS0RvyH16ny8TQ4AM+lCi7SV8F6AmOPLEXbrsBKzqtGUl81UZ6RHYEqx/P37FuNzAmdar4XaHsWCWh+pXYcwX//iCWZ91hzq6f5j11jjn8KU6G2f2Oo/+8GSwKagHfyq3VxSLuijw4ozrIL1mb8tsFQ34y78r6gbAEdnKfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=IC6I0rXC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CA1B2886BF;
	Tue, 30 Apr 2024 03:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714441831;
	bh=/t2bBqVs4+650OzcYG2JSdQEplomh55iDwLiA/7Z17k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IC6I0rXC2rbe3WapiR0gD3ATCpJNJH+9f6YcRM7m8tfPm4voZrMKWQ+iRILk7ITDW
	 krXIevjVGnMu4jb6EJYSx4pEd4b7QdFe4O7wDhnNkr8sw6ZXbIFRtSYGMaQboZ80Qo
	 Tfo6z8z9HOVD9cFalZ0PU5tClT0fjEkHQAdHtZvOz9dP1DZBjZsQxnwHNvZLplymw5
	 HR6lRgSK6umdB82c5y+hrN37IVLzClkOoIboxvKhD96pWMiHKFgBe00be2LkEnfqTg
	 WMElCZ99vh1EXXqVtCIU5il7ules7ccV1lqQD8itNF0JOeh3UKjradL/dNjUCFH3dQ
	 WdDhM9OzyFyoA==
Message-ID: <5bb35d60-1f0d-48f6-a0be-09f935af1fbd@denx.de>
Date: Tue, 30 Apr 2024 03:10:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT
 binding
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 "David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240319042058.133885-1-marex@denx.de>
 <97eeb05d-9fb4-4c78-8d7b-610629ed76b3@linaro.org>
 <93eeb045-b2a3-41d7-a3f2-1df89c588bfd@denx.de>
 <793d016d-2bde-407a-8300-f42182431eb1@linaro.org>
 <c21823f2-4dd7-490a-8b76-7cab422428ba@denx.de>
 <CABBYNZJk33ZcKc9EPi+Hmqb-pq3vSSzB3wkS4nJ45dxG6dBMUw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CABBYNZJk33ZcKc9EPi+Hmqb-pq3vSSzB3wkS4nJ45dxG6dBMUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/29/24 10:57 PM, Luiz Augusto von Dentz wrote:
> Hi Marek,

Hello Luiz,

> On Mon, Apr 29, 2024 at 4:44 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/29/24 8:22 PM, Krzysztof Kozlowski wrote:
>>> On 29/04/2024 17:10, Marek Vasut wrote:
>>>> On 3/19/24 6:41 AM, Krzysztof Kozlowski wrote:
>>>>> On 19/03/2024 05:20, Marek Vasut wrote:
>>>>>> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
>>>>>> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
>>>>>> This chip is present e.g. on muRata 1YN module.
>>>>>>
>>>>>> Extend the binding with its DT compatible using fallback
>>>>>> compatible string to "brcm,bcm4329-bt" which seems to be
>>>>>> the oldest compatible device. This should also prevent the
>>>>>> growth of compatible string tables in drivers. The existing
>>>>>> block of compatible strings is retained.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>
>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Is there any action necessary from me to get this applied ?
>>>
>>> I recommend resending with proper PATCH prefix matching net-next
>>> expectations.
>>
>> I don't think bluetooth is net-next , it has its own ML and its own
>> 'Bluetooth:' subject prefix. Its patchwork.k.o project also doesn't seem
>> to contain many patches with 'net'/'net-next' prefix. Also DT bindings
>> do not seem to use it per 'git log
>> Documentation/devicetree/bindings/net/bluetooth/'. But the bot is
>> complaining about the prefix. Hence my confusion.
> 
> Well usually we require Bluetooth: prefix to indicate this patch is
> for bluetooth/bluetooth-next trees, or you can do via subject e.g.
> [bluetooth-next v1...] otherwise it could be merged via other trees.

Thank you for clarification. Hopefully the V3 is better.

