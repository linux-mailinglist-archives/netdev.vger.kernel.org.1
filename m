Return-Path: <netdev+bounces-202314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B091AED259
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 04:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC818946F3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 02:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3C79D2;
	Mon, 30 Jun 2025 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y+suG37x"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA63C38
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751249802; cv=none; b=tOuaijrncEVrDyiKnoEoI/3rFToheSUEzMx66NAqNqb4/FkR8WBnAQZpI9GeWI14VkFYMjMhnr9cgSKb/rp8g9a0Q9+TXL2z3y1I/29Wwagc3rbz041S2mC11UTQQZaW7Avo78EHNh+OvL7yWgF0bbJ7uLGD6NeEelSBFuVU240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751249802; c=relaxed/simple;
	bh=B1XLNkpeS8NfNTBT1GpddtwssUrLMKYAjPEkicgNxqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGjO+4584YLtINzrvXzuKhhnF/lAmLatmpeSvlNXtwwmrdQDu3XNIqikmKnRo7rtGA/VIL3WLhGxF5GWKIHuyMAzPhrSCYuFcMs+1C3/QrU8rIOtljhhrINFB+0ooKUHf10yvfGWAgF52Tne78ywSNDbtcdhkcJILPcfZz2ONyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y+suG37x; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e7fa26f-16b0-4564-80e8-4f2b5bcae3e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751249788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFjDOLlecrclWt7YJmrrObsIk820FSakImsrzSFHDw8=;
	b=Y+suG37x8DCkAZOCu1nt4ebEM9AELhOVAXOvGG+LAVn0o4CikCtI+Qx+xhmntwH8tajLPa
	KKWOVmi9CpAO3bTJX1+JFeSKt4bj/zCKrhygkRFCGzGgCjwb8+nVUX5Y+E7O0MvYTWWIwp
	llBFzp9AwtrGI9r9mriTD53Bstw3yi4=
Date: Mon, 30 Jun 2025 10:16:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: add support for dwmac 5.20
To: Andrew Lunn <andrew@lunn.ch>, Jisheng Zhang <jszhang@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250629094425.718-1-jszhang@kernel.org>
 <4d5a599a-60e5-4141-8671-ffcbda3aca02@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <4d5a599a-60e5-4141-8671-ffcbda3aca02@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 6/30/25 2:26 AM, Andrew Lunn 写道:
> On Sun, Jun 29, 2025 at 05:44:25PM +0800, Jisheng Zhang wrote:
>> The dwmac 5.20 IP can be found on some synaptics SoCs. Add a
>> compatibility flag, and extend coverage of the dwmac-generic driver
>> for the 5.20 IP.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
>> index b9218c07eb6b..cecce6ed9aa6 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
>> @@ -59,6 +59,7 @@ static const struct of_device_id dwmac_generic_match[] = {
>>   	{ .compatible = "snps,dwmac-3.72a"},
>>   	{ .compatible = "snps,dwmac-4.00"},
>>   	{ .compatible = "snps,dwmac-4.10a"},
>> +	{ .compatible = "snps,dwmac-5.20"},
>>   	{ .compatible = "snps,dwmac"},
>>   	{ .compatible = "snps,dwxgmac-2.10"},
>>   	{ .compatible = "snps,dwxgmac"},
> 
> I can see a compatible flag being added. But what about the extending
> the coverage of the dwmac-generic driver part?
I don't think the timing is ripe yet (including the patch itself).
Maybe it would be better to do this when a hardware driver is to
be introduced into the kernel.

Thanks,
Yanteng


