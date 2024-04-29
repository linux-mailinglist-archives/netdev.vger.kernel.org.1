Return-Path: <netdev+bounces-92252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319288B63CC
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 22:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CAA1C219A8
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BB178CF1;
	Mon, 29 Apr 2024 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CTNjgoqN"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA8179950;
	Mon, 29 Apr 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423474; cv=none; b=Duj+1uA/8ATTJ7GfGMzsIDDQIMBkPRyF/CGUcfN9w1vK0WlxAfDsFsptXOtwFDN1d4+VS9P6cTrYLpkROp7xels3kcikJ0ASxml5xFRn085UMpqznp9LXsyd3+jFDm8PKJd7ppz+KQNVbFxZi8h5ZHrX5LZA7mxS5WTS+k/dw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423474; c=relaxed/simple;
	bh=4ArbJmboZJkva+40RgFBkMMMnhvs/jRgCk9AgEu8Q2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOInKql6n9Z9jxRtVfngTu8SO5XWFXbyiFqOjOHZWGOxRzxdb8I24orMZGqAifQeSfPLqb/m8Hlt/f+dmFUIfVZ7uf205X/D/9RTLO3YmAG/wN887Ozh11AxHARqdSrLZH/52bxYgdx9/xrSHZ67Uu/Sa8qfaxihmaYb6QQ7gK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CTNjgoqN; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9A7A8888D7;
	Mon, 29 Apr 2024 22:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714423470;
	bh=AsfAKdnfhBOp5OD5DjPCztspGKTLGOlMTtGRezi6dLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CTNjgoqN+/dFyq+wRwFHbU4s+hNq2hJtj6QbEf/upPPf/e0cmkarAC/wNFsWzLagz
	 dzavVnYQVRjsElt3YQBJ/WwRYyQCsI3gQdsK1axjRWBFlBWm+lMwOvQrH8UMfilrpw
	 M46RfkuRXLhKlwAUL9PZ1/WRJ8MERAD2JwljycPcgWOPx87VcIRpLq44FqJocUSNrQ
	 GvbC/5bUNeA+D5bPaSb65rH2X6ay5jlDDLSmilSh7pgfKDIe40yXcE7gFFlb4JyPLI
	 i6zLABSN4BX9HpxrAUxf9QRPPwKxOlZJsAoiXNY1Dh2DDWtc3hPoGYA4lcJ5m2c28c
	 s9OPSuXTIVIwg==
Message-ID: <c21823f2-4dd7-490a-8b76-7cab422428ba@denx.de>
Date: Mon, 29 Apr 2024 22:44:29 +0200
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
 <93eeb045-b2a3-41d7-a3f2-1df89c588bfd@denx.de>
 <793d016d-2bde-407a-8300-f42182431eb1@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <793d016d-2bde-407a-8300-f42182431eb1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/29/24 8:22 PM, Krzysztof Kozlowski wrote:
> On 29/04/2024 17:10, Marek Vasut wrote:
>> On 3/19/24 6:41 AM, Krzysztof Kozlowski wrote:
>>> On 19/03/2024 05:20, Marek Vasut wrote:
>>>> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
>>>> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
>>>> This chip is present e.g. on muRata 1YN module.
>>>>
>>>> Extend the binding with its DT compatible using fallback
>>>> compatible string to "brcm,bcm4329-bt" which seems to be
>>>> the oldest compatible device. This should also prevent the
>>>> growth of compatible string tables in drivers. The existing
>>>> block of compatible strings is retained.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Is there any action necessary from me to get this applied ?
> 
> I recommend resending with proper PATCH prefix matching net-next
> expectations.

I don't think bluetooth is net-next , it has its own ML and its own 
'Bluetooth:' subject prefix. Its patchwork.k.o project also doesn't seem 
to contain many patches with 'net'/'net-next' prefix. Also DT bindings 
do not seem to use it per 'git log 
Documentation/devicetree/bindings/net/bluetooth/'. But the bot is 
complaining about the prefix. Hence my confusion.

