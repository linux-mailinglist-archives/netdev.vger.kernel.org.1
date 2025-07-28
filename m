Return-Path: <netdev+bounces-210542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C118BB13DC4
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7399189BBB7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0412E26FDAC;
	Mon, 28 Jul 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="oiR3GXW7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F91586C8
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714733; cv=none; b=Ptd9wug4XoRic8PbQwbDAjLufTLE3+wlhRAcTXGeCN41fnPLnsDLdSHYR7JBJD+ksn3oymRhgaREEwaD56itIYBqQbR1lpJhdvANnk0q4Nbo/KK+gHSZCa/Cf8YKF5q5TK3vSM7DPif4unUykTjnzIwM/M1P018PMFaLjvCxkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714733; c=relaxed/simple;
	bh=S6VysJn3tfj3RHRNBao3+8NaQVXMPeUDKXr5m6VFARI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf5xGZQJ61FJJ5FTfiz4vEjAST2+MAL9R7uwBhzEYC3+ltpJWPkI35HKnY9DdwZ/E6HVczc2a3A4HgW7d/HYLELa+8QxQRjtCxiGBOWAfUL30+9e9X2wbCk1sRgSZkoHHl14mhVNhb7/a9bZuygxy1a8dxcAMW/J0wBtYoEzhgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=oiR3GXW7; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753714725;
 bh=rYuD7fR6ip+mX8V23wp9elDHlgpDSMqOrMV6oJH+6ZI=;
 b=oiR3GXW7ZYBXCTlXqP+wr//crYrR1gP3mD0iR7Aed6aLbspEVKXNxonJ9Mqbz6/KX9buH0cMR
 MAMByEVmdJoMiyhsXo4XyD9V2Ou1Sq5XJBdQsyRFQYh6kKpyDYB1iLRnxajnM8ZykLFXJjVTy85
 rsy6QwUl0VNFQ2V5BIBW7C7yAlOccc5hJeaJr7RgSFrAEqcRTuXENTYbhcd6lW3ZxRMWA5ea20T
 nJr6SnznjwThmFzHv91hIAoZIuy7ehs+7RVYiQd7tRHUJQPJBgcnahqSlNibDSIToPmnS4nrvfd
 GOTEa/quJlqtZ+99bMoxgILaQ25iFjqu3kLqipu4izBg==
X-Forward-Email-ID: 68878ff5351ec66b15a194ff
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <65023e38-0f90-4d12-8615-a595e399b516@kwiboo.se>
Date: Mon, 28 Jul 2025 16:57:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-4-jonas@kwiboo.se>
 <be508398-9188-4713-800a-4d2cd630d247@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <be508398-9188-4713-800a-4d2cd630d247@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 7/27/2025 9:16 PM, Andrew Lunn wrote:
> On Sun, Jul 27, 2025 at 06:03:00PM +0000, Jonas Karlman wrote:
>> The Radxa E24C has a Realtek RTL8367RB-VB switch with four usable ports
>> and is connected using a fixed-link to GMAC1 on the RK3528 SoC.
>>
>> Add an ethernet-switch node to describe the RTL8367RB-VB switch.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Initial testing with iperf3 showed ~930-940 Mbits/sec in one direction
>> and only around ~1-2 Mbits/sec in the other direction.
>>
>> The RK3528 hardware design guide recommends that timing between TXCLK
>> and data is controlled by MAC, and timing between RXCLK and data is
>> controlled by PHY.
>>
>> Any mix of MAC (rx/tx delay) and switch (rx/tx internal delay) did not
>> seem to resolve this speed issue, however dropping snps,tso seems to fix
>> that issue.
> 
> It could well be that the Synopsis TSO code does not understand the
> DSA headers. When it takes a big block to TCP data and segments it,
> you need to have the DSA header on each segment. If it does not do
> that, only the first segment has the DSA header, the switch is going
> to be dropping all the other segments, causes TCP to do a lot of
> retries.

Thanks for your insights!

I can confirm that disable of TSO and RX checksum offload on the conduit
interface help fix any TCP speed issue and reduced UDP packet loss to a
minimum.

Regards,
Jonas

> 
>> Unsure what is best here, should MAC or switch add the delays?
> 
> It should not matter. 2ns is 2ns...
> 
> 	Andrew


