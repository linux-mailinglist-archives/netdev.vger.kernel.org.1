Return-Path: <netdev+bounces-172633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F7A55962
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC616FFDC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF23027605B;
	Thu,  6 Mar 2025 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="O49Galcy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE027C167
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298855; cv=none; b=pg9teg92amGr3HU6xQf54mIMZmB+4MFqH2FGfN73uOEgHezINYModu0JkHrd+0ULV1ai2R98cQ2pr9nSaXsXsRxllQIOK4uAY5vM5zcaVd9A6Nzvoixiis62//oTIsVCMLtLHud1pf4wqlO6ufW2HMhSXUQzzVLnTVi9uxeALx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298855; c=relaxed/simple;
	bh=7tDo5DWEMkYG3zcoTZWVRr+FxxU6j/PboeVsoG8JLU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+MOH5U8zi8jI2SgwiNRdk3PS8di1knz4Wpgs6GtfkHk+5MBaLNz/kDE1fbnK2VvOn5e9Rar8xiaak3pN6Nv98ynGhmDH7bOdK7UpsWIjnSA+O7umA6GiDuiixjqK66KfIDnBu3zB85pmv8OVhkp3cFZlvZLFct/Vuqg1I+Mi0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=O49Galcy; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741298851;
 bh=0HCYfVxow/nYeBfs/TuiH44ZuKNSPm8doYeM7l980w8=;
 b=O49GalcyoaCyVCNa4IEn9iDmdhjKIdJuDpbieBTkvB7FgL1643d8f1JeNNqQ170SbryoZq2MY
 rPuFNlRJL6Ph8qLSlSPvmIf/rl7W19yw5Sp2EuMkFmlISxp3wT6jOMCNPFYOUIou9brPxEV/+Yp
 iPO3xg8c953BBGM1jefAm1b6vXzwqKuprLIsBCpDochhaYh9JtY93JQ/6XS8RNsxaAmTNTcOWT+
 lcSTorJaEn9Xqkn11WS94q1tVCF9PuDnpOX5gdYx8D6wr4gQ+Gu1zBvKMS0G4PnaBrgKjksSZbV
 MMlNq3NJMkx+Z2ebWKgITJ0aI4DmCZXBrVXSc5SN14GQ==
X-Forward-Email-ID: 67ca1ca0c1763851c065bef2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3ab13afd-0a9f-485e-bdf2-7b413d418065@kwiboo.se>
Date: Thu, 6 Mar 2025 23:07:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Use DELAY_ENABLE macro for RK3328, RK3566/RK3568 and
 RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250306203858.1677595-1-jonas@kwiboo.se>
 <41bb2c8d963e890768bceb477488250e@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <41bb2c8d963e890768bceb477488250e@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dragan,

On 2025-03-06 22:41, Dragan Simic wrote:
> Hello Jonas,
> 
> On 2025-03-06 21:38, Jonas Karlman wrote:
>> Almost all Rockchip GMAC variants use the DELAY_ENABLE macro to help
>> enable or disable use of MAC rx/tx delay. However, RK3328, 
>> RK3566/RK3568
>> and RK3588 GMAC driver does not.
>>
>> Use of the DELAY_ENABLE macro help ensure the MAC rx/tx delay is
>> disabled, instead of being enabled and using a zero delay, when
>> RGMII_ID/RXID/TXID is used.
>>
>> RK3328 driver was merged around the same time as when DELAY_ENABLE was
>> introduced so it is understandable why it was missed. Both 
>> RK3566/RK3568
>> and RK3588 support were introduced much later yet they also missed 
>> using
>> the DELAY_ENABLE macro (so did vendor kernel at that time).
>>
>> This series fixes all these cases to unify how GMAC delay feature is
>> enabled or disabled across the different GMAC variants.
>>
>> Jonas Karlman (3):
>>   net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3328
>>   net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3566/RK3568
>>   net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3588
>>
>>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> As far as I can tell, the RV1126 GMAC should also be converted to use
> the DELAY_ENABLE macro, which the vendor kernel already does. [*]  
> Perhaps
> that could be performed in new patch 4/4 in this series?

Good catch, the RV1126 seem to use a slight different M0/M1 variant and
unfortunately I do not have access to any RV1126 board to do any runtime
testing. For RK3328, RK356x and RK3588 I could at least do runtime
testing.

I can add an untested patch for RV1126 in a v2 if needed :-)

> 
> BTW, it would be quite neat to introduce the DELAY_VALUE macro, which
> makes the function calls a bit more compact. [*]

Personally, I do not see a real need for the DELAY_VALUE macro, current
use of the soc_GMAC_CLK_yX_DL_CFG() macro is readable enough.

The ENABLE_DELAY at least helps remove an otherwise more complex enable
or disable conditional handling.

Regards,
Jonas

> 
> [*] 
> https://raw.githubusercontent.com/rockchip-linux/kernel/refs/heads/develop-5.10/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c


