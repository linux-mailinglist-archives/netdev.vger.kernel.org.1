Return-Path: <netdev+bounces-173003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD2A56D10
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EADB3B51EF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0C21D3E8;
	Fri,  7 Mar 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="HroZ1FVE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179E21B8F8
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363347; cv=none; b=T+Xvs3OCcJ2iG1pw3ELAww8BBbLGs4OQfbpPavSRIG9l8NYmBAO8wzNjg9laj5/wGDrHuW7D0bvxE5NzSpMq6Pl9JoH6/VK76BayigI/URcLqrgSZ4HPJxIi1Ac0UaeN2Hn2z39rG1Sa60okRgeAap20gvd9Zzhwws9B4sioCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363347; c=relaxed/simple;
	bh=pl0XdGNLYz9x5NdFwUSgV/y76o1nKr6GfSx+T2FWcDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfUaKGApVeBaqR3qBTIQw23H4U+g6dIiea9kxEBPuAFlp+QpvKQC8YQtuoOHMBRBCmq/Vy5IWID73xVvgrMdMfGboj8xyUjwLI50xu2lT+qbbr8WtKf9JIggdg/l85F4qn0nTdBfWjWw/Mbig8gNUxDc1IZDB42AbxPMkvg9rVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=HroZ1FVE; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741363339;
 bh=aCrPvOluCec+vwfJ2dRCW1m+hFa1hc7eEdH3qmC/0uk=;
 b=HroZ1FVEb3Ju6eD1H+BtadR1rI7m9tD5k7yR30KBiZsBa3FuDmLSwkWkLCFK1lIYZu9sSLxU0
 0ZHddwHu+aUISVWjyWSuoLRx/iQvOqU79EecADPZH/j6Ukf54bswmqH/VcRo4b1rse/gQeNLfHp
 NZicpfRGHyzBjW0NJNIQ9Av2YKrGTLkHYCG4EuQjSs0LppLJdAAFZ/NJL7EBQuaHchvuqoSgf1v
 zEf4ijL0+RF1JT0fP6iG8PBfV7/pB3ZEk6YzM8AVxh1ji//v4J1HL+JKIbzR6p6/Y7xF5Bm/HQd
 nk1g12ZCMaAIiU2NWNh5Pqvte0qrxhCLy6d/tMQi5qig==
X-Forward-Email-ID: 67cb18782ea74034f8b964f0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <de2fb6c6-b053-4be9-8c44-2476c5eb26a6@kwiboo.se>
Date: Fri, 7 Mar 2025 17:01:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: net: rockchip-dwmac: Add compatible
 string for RK3528
To: Conor Dooley <conor@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wu <david.wu@rock-chips.com>,
 Yao Zi <ziyao@disroot.org>, linux-rockchip@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250306221402.1704196-1-jonas@kwiboo.se>
 <20250306221402.1704196-2-jonas@kwiboo.se>
 <20250307-tipping-womanlike-a1ce2370d8d3@spud>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250307-tipping-womanlike-a1ce2370d8d3@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

On 2025-03-07 16:42, Conor Dooley wrote:
> On Thu, Mar 06, 2025 at 10:13:54PM +0000, Jonas Karlman wrote:
>> Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
>> Ethernet QoS IP.
>>
>> Add compatible string for the RK3528 variant.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> I was not able to restrict the minItems change to only apply to the new
>> compatible, please advise on how to properly restrict the minItems
>> change if needed.
> 
> What do you mean by that? As in, what did you try and did not work?
> Usually you do something like
> if:
>   not:
>     compatible:
>       contains:
>         rockchip,rk3528-gmac
> then:
>   properties:
>     clocks:
>       minItems: 5
> 

Thanks, this seem to work, will use in a v2.

I tried to do something opposite and instead set minItems: 4 when
compatible contains rockchip,rk3528-gmac:

if:
  compatible:
    contains:
      rockchip,rk3528-gmac
then:
  properties:
    clocks:
      minItems: 4

but that resulted in something like:

  rockchip/rk3528-radxa-e20c.dtb: ethernet@ffbe0000: clocks: [[7, 173], [7, 172], [7, 171], [7, 170]] is too short

Regards,
Jonas

>>
>> Also, because snps,dwmac-4.20a is already listed in snps,dwmac.yaml
>> adding the rockchip,rk3528-gmac compatible did not seem necessary.
>> ---
>>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> index 05a5605f1b51..3c25b49bd78e 100644
>> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> @@ -24,6 +24,7 @@ select:
>>            - rockchip,rk3366-gmac
>>            - rockchip,rk3368-gmac
>>            - rockchip,rk3399-gmac
>> +          - rockchip,rk3528-gmac
>>            - rockchip,rk3568-gmac
>>            - rockchip,rk3576-gmac
>>            - rockchip,rk3588-gmac
>> @@ -49,6 +50,7 @@ properties:
>>                - rockchip,rv1108-gmac
>>        - items:
>>            - enum:
>> +              - rockchip,rk3528-gmac
>>                - rockchip,rk3568-gmac
>>                - rockchip,rk3576-gmac
>>                - rockchip,rk3588-gmac
>> @@ -56,7 +58,7 @@ properties:
>>            - const: snps,dwmac-4.20a
>>  
>>    clocks:
>> -    minItems: 5
>> +    minItems: 4
>>      maxItems: 8
>>  
>>    clock-names:
>> -- 
>> 2.48.1
>>


