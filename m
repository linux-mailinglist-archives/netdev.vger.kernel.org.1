Return-Path: <netdev+bounces-92187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751118B5D72
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2E3B228CA
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E6127B57;
	Mon, 29 Apr 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LT8pKSHm"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15391272D6;
	Mon, 29 Apr 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403450; cv=none; b=uEP40IpQvb8Os7FWcql1W6Z1ndnh5qpcrALo4stIiPYiqRSakYsw6MpfhgWgCmuwJgtv6koV4vQuMqxDe40F0KbEFgSrcXdDTWsS9RKGSLqXrTjbDqa6/SvuaOi2rGOWYQB2GxO2OrP3gmLPdeZsNmhM/F15p0V1AgoEHtaqoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403450; c=relaxed/simple;
	bh=8L8NBC0tuW5E0IO/qcCgf442V11CmQ8oFUvg3oL+A30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPRdgvWWcNlZvfaczbELaQENNqxHCqE1zmznAabIGggPLJWInWLhsCFCYDa0h90+BwmoI2x6/mo45BkdWeIY5Tf1zKENH6gZ5P/z5CHfbhu9i7igC0q4M4QHtyoXlFNQEVLx3SVEt7zaVKx/xOV7Y+3BBypjLYvvmdi43O4j9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LT8pKSHm; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8094788155;
	Mon, 29 Apr 2024 17:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714403445;
	bh=qHYA/D1msUd7p69S7hlOfXNJ8AvqD4n0cCmw28Z+mks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LT8pKSHmWio28RlZ2qybtunuy0ffJhJCqXw6r+ACq5XvDIcAA4PjGC0P0EgewZ8m6
	 qxxnsURhudhbCZLOabRTdlvoWD79Vf/czuSs0zx+Ig+aGv9701a1ZKhtHuNHOH+fW8
	 fe6ldB0A37NHEKBpZPPQWvSdjxZpxsntZH0xeAYyMA9kpHybB9osBp3Johoksbgsr0
	 nWyIpIomYPGJ8830MNUjYWUKxRLlnqw4uFth4QspQgME4QcnBlDKieeM1ZKO8YwpbF
	 T5l1aTDsHwTETIDmvvWqizO2z0DdtB1Vnow0L+EpHcbdpLh3R5+qYAKLnfbC9GZJHm
	 HjkYm+zIi4v0A==
Message-ID: <93eeb045-b2a3-41d7-a3f2-1df89c588bfd@denx.de>
Date: Mon, 29 Apr 2024 17:10:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT
 binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20240319042058.133885-1-marex@denx.de>
 <97eeb05d-9fb4-4c78-8d7b-610629ed76b3@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <97eeb05d-9fb4-4c78-8d7b-610629ed76b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/19/24 6:41 AM, Krzysztof Kozlowski wrote:
> On 19/03/2024 05:20, Marek Vasut wrote:
>> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
>> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
>> This chip is present e.g. on muRata 1YN module.
>>
>> Extend the binding with its DT compatible using fallback
>> compatible string to "brcm,bcm4329-bt" which seems to be
>> the oldest compatible device. This should also prevent the
>> growth of compatible string tables in drivers. The existing
>> block of compatible strings is retained.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Is there any action necessary from me to get this applied ?

