Return-Path: <netdev+bounces-194652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F3CACBB81
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E09C189415F
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFCA1A3150;
	Mon,  2 Jun 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UYJJecdm"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D85139D;
	Mon,  2 Jun 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892512; cv=none; b=GKTOq+ISJGYbfJ1burvmUHDdzYd9kvWFsW98nGvn4aPTqnm7LW0X0ID6KJpyzkjccXtLFsQ9FgGNUb9tCP97Vz1MlNuRF0PbxvM16dykg3HMcITPmPNNeZChudvJzG02pvxUMRuSSJrHwVOYozdNorO+nCr8Y+QH3JPouogd+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892512; c=relaxed/simple;
	bh=Yir4z9iUxeXhxIOYYiF8Uq4KfXiw2labPtJVGZS0zGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c951v/cUSU8UAhB7daDnbyJ2gZO2s9U6Zuzl743tdBIoXecxdhuKaOlEstrdkk97kxMgfRb5XufWHDEbRzcH9GHuyeCgAc1EwdqLrLuilp9mVK1kjSOhEd6NMUtZHOjZ1cVRzQX+iwxafAqflYTqa89MkUxk4LoOVfIXMFbxZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UYJJecdm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1748892487; x=1749497287; i=wahrenst@gmx.net;
	bh=q/cg5ojJ/w13pjpukVEUe8AkJtPgaqLfIdxA24RlIUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UYJJecdmW0vrnH9nxiziF9AlgmYk9DvISm1WEb7CzxqfSLDoa9v5R5GQOsmsNRy5
	 Mn4ExrOrtYetdB0mu08qAJboo3xmxNygzLLhT7zU/VmRJ3x0SatZTyoAJhbDFxITg
	 QFhX0j3QykElnRENPYF1ORMJUWwlRACW5RLWmi+grhUZgTda4Nig1dDLOkl6aJEbZ
	 wKzho9OvH6RGb/jRPhWkZLqeLzLwPLN/a5lp3YdG823dNKjlty4vWQoklrtL7ihGR
	 LcuFKV7eShmEx+UvQ140a5NPZWP4r0vu3UmJW47nfKmIt7j7u8/mZAFIr7/Mf5Xm2
	 +K/1NME73KN4gJzNxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.103] ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1vBwMi1FVH-013lPJ; Mon, 02
 Jun 2025 21:28:07 +0200
Message-ID: <602cc521-9b7e-424b-8956-429d654fc760@gmx.net>
Date: Mon, 2 Jun 2025 21:28:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
To: Frank Li <Frank.li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
References: <20250529191727.789915-1-Frank.Li@nxp.com>
 <047fb49e-1ca8-43a6-b122-0d6fa9a61c74@gmx.net>
 <aD3E2ONB6Ay1wwmk@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <aD3E2ONB6Ay1wwmk@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AJQ2ixEvwg/itP70Uj8xnydOVxM6lyLntqA43DPWy193LI9QDFJ
 BAD5b59iauwBVMTKvwf4334m9vCNhfkI9FLMAnhOdR8F/ya5+BAxDYdyxNztMVoYk0dl5b9
 7XkX/SVLLbkYwpg0sPhM+92ddZHu8eQCzLh5UHgyyw7VxREkOCOHM4U/IBuf6LmACfGMPrA
 1zJmqnV5mO/tWL2N4kEyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uYK9uE2dX1Q=;DKTN5ymCFAqlbh9PnhostIe0JhP
 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

Hi Frank,

Am 02.06.25 um 17:35 schrieb Frank Li:
> On Fri, May 30, 2025 at 10:33:28AM +0200, Stefan Wahren wrote:
>> Hi Frank,
>>
>> thanks for this patch.
>>
>> Am 29.05.25 um 21:17 schrieb Frank Li:
...
>>> +  - Frank Li <Frank.Li@nxp.com>
>>> +
>>> +description: |
>>> +  The QCA7000 is a serial-to-powerline bridge with a host interface w=
hich could
>>> +  be configured either as SPI or UART slave. This configuration is do=
ne by
>>> +  the QCA7000 firmware.
>>> +
>>> +  (a) Ethernet over SPI
>>> +
>>> +  In order to use the QCA7000 as SPI device it must be defined as a c=
hild of a
>>> +  SPI master in the device tree.
>> Could you please add the dropped "(b) Ethernet over UART" description h=
ere?
> Okay, I will add back.
>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qca,qca7000
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  spi-cpha: true
>>> +
>>> +  spi-cpol: true
>> In case of a SPI setup these properties should be required. Unfortunate=
ly
>> i'm not sure how to enforce this. Maybe depending on the presence of "r=
eg"?
> But It think depend on reg is not good idea, which too obscure.
I understand, but this was the first idea which comes to my mind.
>   Ideally it
> should be use two compatible strings. It should treat as two kinds devic=
e.
Back in the days there was a discussion about different compatible=20
strings and it was rejected [1].
> It is really old devices and not worth to update compatible string.
Yes, this powerline communication chip was introduced in 2012 but it's=20
very widespread. Most of the electric vehicles and DC charging stations=20
use this chip.

Regards

[1] - https://lkml.org/lkml/2017/5/19/390
>
> Maybe some one in dt team can provide suggestion!
>
> Rob and Krzysztof Kozlowski:
>    any idea about this?
>
> Frank

