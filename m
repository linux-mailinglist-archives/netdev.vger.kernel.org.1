Return-Path: <netdev+bounces-106322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66000915BF8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 04:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194F32838E7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 02:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320C1B950;
	Tue, 25 Jun 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BpxykPKK"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1971870;
	Tue, 25 Jun 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719280929; cv=none; b=I0u/BAaZb3RA2lS/p4yfrdV2mL9HSf3wNlm0YJs9yRXTNyCNQMS14yhoDA3EWEkFrBJ4V538hsWKkEJgFEBrQHQln5JzToOCUitjCwMx7Fnn3muBEiJRRw58T+3N6llEaV+WALH3WtCZG9iuvrgiSD80a7CHWjB3Ojeg/PFl4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719280929; c=relaxed/simple;
	bh=n7plnemK0bPcTgAriIg2nQvRQCKhZS1ICeIVNSUysl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWDZo4S9vfJ9bK53Jo/VBjVQQ4edn2+qE6HrGn/bO0qhil8gg7r5CEz4UO8ZMnRb1HHSUlY3eBrQ+1Xvmw0rlBmkKfGKDzx7xtHzJj5yMoX97DZqdRw3eihRdWABAuqG7IFrtqzdJco1ZUnBQpNzdE02icKNQx3dGjumnYEoTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BpxykPKK; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0F58A8332E;
	Tue, 25 Jun 2024 04:02:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719280925;
	bh=KGZYXNlFvRfvoevz2cvG9Yp3fnK+FiUyFAiZIqZQ258=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BpxykPKK0qbJjW3S6YRh3GqBj6ggDjH3VYswjHKqi1zezoztWijKpQDW1wm9m1HEq
	 tYHRLGxtQTM6yuF3/CU8N2kfusqReJ/aGfLkaY6VNMod65o2uSx2fRtozl9liTqY57
	 Ajw+/pY0cfG4TOcM98vbaP3e2TuxJfg97QN9gqoUxdeNr1VBXDDdGSTE3HcZfpMSyE
	 MHAo4tSNEDecpc+QUd6CD3Eb8pNvgWxLfoMzRKLhEIx9YXj6ioOj8is1ut2/lKe4vq
	 GJxqIXpzuhazzDALdKtLMwCdqhuDW29SiGCBS8XCuG/NaWO5gVI/fbOMm3r8GXbiRU
	 /+sCf32lfddpg==
Message-ID: <246afe9f-3021-4d59-904c-ae657c3be9b9@denx.de>
Date: Tue, 25 Jun 2024 02:32:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Joakim Zhang <qiangqing.zhang@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 kernel@dh-electronics.com
References: <20240623194225.76667-1-marex@denx.de>
 <cc539292-0b76-46b8-99b3-508b7bc7d94d@lunn.ch>
 <085b1167-ed94-4527-af0f-dc7df2f2c354@denx.de>
 <bad5be97-d2fa-4bd4-9d89-ddf8d9c72ec0@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <bad5be97-d2fa-4bd4-9d89-ddf8d9c72ec0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/24/24 3:52 PM, Andrew Lunn wrote:
> On Mon, Jun 24, 2024 at 01:52:49AM +0200, Marek Vasut wrote:
>> On 6/23/24 10:00 PM, Andrew Lunn wrote:
>>>>      - $ref: ethernet-phy.yaml#
>>>>    properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ethernet-phy-id0000.8201
>>>
>>> I'm not sure that one should be listed. It is not an official ID,
>>> since it does not have an OUI. In fact, this is one of the rare cases
>>> where actually listing a compatible in DT makes sense, because you can
>>> override the broken hardware and give a correct ID in realtek address
>>> space.
>>
>> Hmmm, so, shall I drop this ID or keep it ?
>>
>> I generally put the PHY IDs into DT so the PHY drivers can correctly handle
>> clock and reset sequencing for those PHYs, before the PHY ID registers can
>> be read out of the PHY.
> 
> Are there any in kernel .dts files using it?

git grep ethernet-phy-id0000.8201 on current next-20240624 says no.

> We could add it, if it is
> needed to keep the DT validation tools are happy. But we should also
> be deprecating this compatible, replacing it with one allocated from
> realteks range.

I think we should drop from the bindings after all, I will prepare a V2 
like that, OK ?

