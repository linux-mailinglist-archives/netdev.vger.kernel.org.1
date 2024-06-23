Return-Path: <netdev+bounces-105972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C234913F93
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 02:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E00B1C2134D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 00:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B7138E;
	Mon, 24 Jun 2024 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cCkRFk9a"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D8646;
	Mon, 24 Jun 2024 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719189371; cv=none; b=QQx8HGrY4kOImT/j6rz7jNpNiIsuJngtidNDbtb/7RKzBL8yrBhRDe785uCVDUubUslkQcTquBDieNVu07dWVZ3ysoD9ksxpdHSPC4iE/ickzKiCbvT6RMAvAnAiSuPBzPW6qGl3bJ+1y/CRKlA6PnktzgR4YHjzq1zcW5jfnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719189371; c=relaxed/simple;
	bh=gEczXr3/aRUXf2VPgs248HRKsQnARQBdHfOoAsmo040=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajq6SVg0oJJOo6RWNySwwR5WdDlbG8/Yt6A1/AvRxNCBlW8uFjgBIiF7Fzu/nUdT1OmwtDRAQzbIWvbDkzLVfo7wIiuRPFXpW9CjHV54154NHy6KpQlRJfUStQzuO/gXSG77D7ExFOyfyh5acmOvktduep6Njcogs/4K4dA4ezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cCkRFk9a; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1C2B0876D3;
	Mon, 24 Jun 2024 02:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719189367;
	bh=dbF1lZ5TJogsTXnIVeWt+iRJOf+iH4XqnK799DdGU9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cCkRFk9aj+t46TIKKNftzntYw2q47sTJkis4zl89hgzGqw8hBMXSdqLLDmzdFtVNl
	 M/785fnWIqg85cFqYIRhcZV+j5JQ+fCRaB0joSX3unjV2tGymDFRsf5iUXZiukzxA9
	 uk+BnyX5vznvcCymZ3T+3OngEVTb5VTg2MO7+3BVREUu4mGKukZhOLA1k8aJxD7ype
	 Gx5hahz1FzhnD+C7Gqji4InXY6Yd0PksXoFgCSINYKIMeCk5+JzVEm4z62WQOeh9qD
	 xV7UwvqUKAMuhMbHJOBOA+URk7JsI5ShDbBzs3gni3rcDHRN10EQTQDkDS8V8t5xCZ
	 aXsGqgVIJKclA==
Message-ID: <085b1167-ed94-4527-af0f-dc7df2f2c354@denx.de>
Date: Mon, 24 Jun 2024 01:52:49 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <cc539292-0b76-46b8-99b3-508b7bc7d94d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/23/24 10:00 PM, Andrew Lunn wrote:
>>     - $ref: ethernet-phy.yaml#
>>   
>>   properties:
>> +  compatible:
>> +    enum:
>> +      - ethernet-phy-id0000.8201
> 
> I'm not sure that one should be listed. It is not an official ID,
> since it does not have an OUI. In fact, this is one of the rare cases
> where actually listing a compatible in DT makes sense, because you can
> override the broken hardware and give a correct ID in realtek address
> space.

Hmmm, so, shall I drop this ID or keep it ?

I generally put the PHY IDs into DT so the PHY drivers can correctly 
handle clock and reset sequencing for those PHYs, before the PHY ID 
registers can be read out of the PHY.

