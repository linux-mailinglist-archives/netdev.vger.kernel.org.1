Return-Path: <netdev+bounces-172675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5650EA55AE7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C883B31F8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0B27D78D;
	Thu,  6 Mar 2025 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="UrUqzjkz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6727C16A
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303737; cv=none; b=IJ+xKUAnM3xeJT30ej0Fa4kSRgN+dHoKCOWWY/ztnk/1onLgrMB8qoJ5keQxYov9buq8/h78eU6hKwRZPWDSnVCXygsyiuxaLKmrtLlZl2sVMGwn3pdzv4d0nqu68YJLbBgT3odOpUcjkhHyi+wVHEpSMNZ6ePlPOgDuUpGpOMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303737; c=relaxed/simple;
	bh=ywZ1zNMC6Cpsx8jP3sSiESAhGtT8ek6DoRudfqs218Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixvg4qTuULYBHK6aFiza+DBhfYDrovtlcqzI/ZPD4H7Uk9TllnKrGoLKnBdlgrXgMuubutwop7yXdk2VYix/UApfae51wBIpzV7fLwRvHHeDid55IDyli/yxfCxUnHjEo+i/uDujVX2nE1r3Kqb2hoToekmSU0gLC4zxsgUCwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=UrUqzjkz; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741303735;
 bh=q2c6AS1rlUDUzvA6Yu68aG7T+Ty/a7PAe/Tq0jI31fc=;
 b=UrUqzjkzrzqKGFYiE+hjiz6hJho0xc1vfo7NvFs68dZPibizvzRqn1vEW24/nQ0c8TZEQrEAn
 3Cb/dlEGbqIjw9YyTQtMvXAoec1Xg3krelI0yzdD0aW/Gb8e/lmCKcKJmD32XVU1V1An06VNnCo
 B2gINL7qIGzEuzdNhJi2Rl4tuaZmWK1yB/GFGlGSLrAZ4De/48/fltZvEIx0usx4JeDfz+Kl1KB
 uZXIqfKi2mNHWsNZM+WfalH1W0vWlitYrF/rDANVTQwTE64aJ7dCkZECKocNsRrYK5ZdBJHq6O4
 UA+YM9TdOinE8AtCgWwLzw/+MxIsm4NPdn1HNZcElLvg==
X-Forward-Email-ID: 67ca2fafc1763851c065d15d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <624f2474-9a39-46a3-a6e5-f9966471bf3d@kwiboo.se>
Date: Fri, 7 Mar 2025 00:28:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for
 RK3328
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Wadim Egorov <w.egorov@phytec.de>,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250306203858.1677595-1-jonas@kwiboo.se>
 <20250306203858.1677595-2-jonas@kwiboo.se>
 <d6b15dc2-f6b2-4703-a4da-07618eaed4db@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d6b15dc2-f6b2-4703-a4da-07618eaed4db@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-06 23:25, Andrew Lunn wrote:
> On Thu, Mar 06, 2025 at 08:38:52PM +0000, Jonas Karlman wrote:
>> Support for Rockchip RK3328 GMAC and addition of the DELAY_ENABLE macro
>> was merged in the same merge window. This resulted in RK3328 not being
>> converted to use the new DELAY_ENABLE macro.
>>
>> Change to use the DELAY_ENABLE macro to help disable MAC delay when
>> RGMII_ID/RXID/TXID is used.
>>
>> Fixes: eaf70ad14cbb ("net: stmmac: dwmac-rk: Add handling for RGMII_ID/RXID/TXID")
> 
> Please add a description of the broken behaviour. How would i know i
> need this fix? What would i see?

Based on my layman testing I have not seen any real broken behaviour
with current enablement of a zero rx/tx MAC delay for RGMII_ID/RXID/TXID.

The driver ops is called with a rx/tx_delay=0 for RGMII_ID/RXID/TXID
modes, what the MAC does with enable=true and rx/tx_delay=0 is unclear
to me.

> 
> We also need to be careful with backwards compatibility. Is there the
> potential for double bugs cancelling each other out? A board which has
> the wrong phy-mode in DT, but because of this bug, the wrong register
> is written and it actually works because of reset defaults?

To my knowledge this should have very limited effect, however I am no
network expert and after doing very basic testing on several different
rk3328/rk3566/rk3568/rk3588 I could not see any real affect with/without
this change.

The use of Fixes-tag was more to have a reference to the commit that
first should have used the DELAY_ENABLE macro.

Regards,
Jonas

> 
>     Andrew
> 
> ---
> pw-bot: cr
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


