Return-Path: <netdev+bounces-157942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187CAA0FE59
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453471888DE6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769A22FE08;
	Tue, 14 Jan 2025 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F+yGNX+E"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1C1EB2E
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736819908; cv=none; b=m00hDG8E9bcB2kwf7WiEL0sPUD52IKT9+HYBuRLtMVuP34zjbPlwOBGg6Swkz0XssAF5PczvgjlK8a4+18nwuDcEjDI4Er9k0/YfzijqM0JV0qiR4zyBenjuIdPTaiOB/5JNRvA87MxP0/nLdXp7u0DqcbaY50Tp3P7/r6tOlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736819908; c=relaxed/simple;
	bh=PFy9CgnBqqJNB/6aK4MKFrwZ+j/F3X6PjicIez+5qDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxDlQAcLzBKzdKHNY1eQp0g8H/fVoa8AVXIzNgP5QUb9SLV0+c8YO34XZ+Eb9sFZ1iVMAD1nEgMbMIKNHAcp3VZzkQKqPY6AC8dIhSAnF041jUay7gqFOlH5aPS3dJoxS4pF4/dvthIYbzwNIJVtBpot2pDPSdsgtw61/k23BGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F+yGNX+E; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e48f70bd-bb2b-4443-bb76-1b3511700043@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736819898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1DH/dRPY0Nuv7rtnJpzenWYHpKBr5t8Ih4nWX4KnGc=;
	b=F+yGNX+EtQuMGlvoRx0cEcpciJ9enfIt5EaNKn6B6+JuXPjh0SxIMd7/fpqz1spYD3oTjD
	bNMwUbsGPaQhWVE2B9NdjxMqqkYWVpXNjOkeHWI0JGrv5g8zl3uQiSMWaYv+hOA5gqPcwp
	X50P45HGDhNCF2i2HNQQY3B6FjCuqC0=
Date: Tue, 14 Jan 2025 09:58:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/5] net: stmmac: stm32: Use
 syscon_regmap_lookup_by_phandle_args
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
 <20250112-syscon-phandle-args-net-v1-5-3423889935f7@linaro.org>
 <5d97dd34-f293-4403-b605-c0ae7b5490fd@linux.dev>
 <c4714984-8250-4bf2-9ac1-5a9204d3aca8@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <c4714984-8250-4bf2-9ac1-5a9204d3aca8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2025/1/14 01:01, Andrew Lunn 写道:
> On Mon, Jan 13, 2025 at 04:05:13PM +0800, Yanteng Si wrote:
>> 在 2025/1/12 21:32, Krzysztof Kozlowski 写道:
>>> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
>>> syscon_regmap_lookup_by_phandle() combined with getting the syscon
>>> argument.  Except simpler code this annotates within one line that given
>>> phandle has arguments, so grepping for code would be easier.
>>>
>>> There is also no real benefit in printing errors on missing syscon
>>> argument, because this is done just too late: runtime check on
>>> static/build-time data.  Dtschema and Devicetree bindings offer the
>>> static/build-time check for this already.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 9 ++-------
>>>    1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> index 1e8bac665cc9bc95c3aa96e87a8e95d9c63ba8e1..1fcb74e9e3ffacdc7581b267febb55d015a83aed 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> @@ -419,16 +419,11 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>>>    	}
>>>    	/* Get mode register */
>>> -	dwmac->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscon");
>>> +	dwmac->regmap = syscon_regmap_lookup_by_phandle_args(np, "st,syscon",
>>> +							     1, &dwmac->mode_reg);
>> The network subsystem still requires that the length of
>> each line of code should not exceed 80 characters.
>> So, let's silence the warning:
>>
>> WARNING: line length of 83 exceeds 80 columns
>> #33: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c:307:
>> +							     &dwmac->intf_reg_off);
> checkpatch should be considered a guide, not a strict conformance
> tool. You often need to look at its output and consider does what it
> suggest really make the code better? In this case, i would disagree
> with checkpatch and allow this code.
>
> If the code had all been on one long line, then i would suggest to
> wrap it. But as it is, it keeps with the spirit of 80 characters, even
> if it is technically not.
Oh, I got it! Thanks for explaining. You cleared up my confusion.

I made those comments based on my past experience. Actually, I
hesitated for ages before hitting the send button. I couldn't
figure out a better way other than refactoring the function.
I guess I might have come across as a bit unreasonable. But
now I understand the reasoning behind the ‘80 - character’
thing. I'll be more confident when dealing with this kind
of situation in the future.


Thanks，
Yanteng

> 	Andrew


