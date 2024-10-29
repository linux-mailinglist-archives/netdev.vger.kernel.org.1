Return-Path: <netdev+bounces-139931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D15439B4AE7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31311B23282
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9134206965;
	Tue, 29 Oct 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVFxTY2/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857620607F;
	Tue, 29 Oct 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208450; cv=none; b=PpU/Ej5mO6WZAY6So5exLyTo/g4TZqwCO8dn95J6YCH+6wsA7Y0S0jwmLE4FsMBsfAtTXIUjWbxM+lp0xegVV2PH+xG0emTCFfHgKIWw4NMTzqp84Gap/o42yFDtx6M+bFK5nXefF4TZISwfGW0cM33iz6P04U708uieyzK3+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208450; c=relaxed/simple;
	bh=bmkKt0GxS/D8qfpTpd3Zd9bJQThQKbbNZIThKzLdY2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOneVrX6b8WNZNGIVyuWIRPg+t+mLgG6JlDzmn/oygtgji9oaxi5wXfaKTlX0EdwBL3AlDGh4eozCvLgj7O7WZggwS4c7W/jLJHd7MD8k7XAo5DQXluJIs87XHJl71qC7o/idtetkp8ES/TE4LLeDApnfrxk2/CZI7w1frpGYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVFxTY2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BABEC4CEE9;
	Tue, 29 Oct 2024 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730208450;
	bh=bmkKt0GxS/D8qfpTpd3Zd9bJQThQKbbNZIThKzLdY2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kVFxTY2/85sYNdCDqT9VYkJUtbKpSDveyq3CfYFDGJpnmUljwYUAnRnBxcxDzaaNm
	 5F7IdqI4ZsusqOEoa/+TCVBPT6gPdbnklMdTuD3bbuO3f/2oNv6NV/AfFdZ+nZvYE6
	 n8MRQcEl0W2lKKs2WDQqjj2IYwW0wrrj5Xf+x6N8HPwyKxZkhzZCPBQFAG352mugMd
	 mmUWrcKW+be6iSDOrpgeSgZiwhIG0NlPSWmGFmOvzEOuLROMhBbwSOqjh33hsmVUAK
	 RVEnObI5vP8Oi1qmHxy2X3v7cXXVyKqWYiskYr4JqcSw/rnoCihG5JM6rdK/rmMy7f
	 4f8/bWe87CnJA==
Message-ID: <e134b98f-5a57-4a37-b46b-8b4017f050a6@kernel.org>
Date: Tue, 29 Oct 2024 14:27:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: net: Add support for Sophgo SG2044
 dwmac
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-3-inochiama@gmail.com>
 <4avwff7m4puralnaoh6pat62nzpovre2usqkmp3q4r4bk5ujjf@j3jzr4p74v4a>
 <mwlbdxw7yh5cqqi5mnbhelf4ihqihup4zkzppkxm7ggsb5itbb@mcbyevoat76d>
 <8eeb1f7c-3198-45ac-be9a-c3d4e5174f1f@kernel.org>
 <gcur4pgotkwp6nd557ftkvlzh5xv3shxvvl3ofictlie2hlxua@f4zxljrgzvke>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <gcur4pgotkwp6nd557ftkvlzh5xv3shxvvl3ofictlie2hlxua@f4zxljrgzvke>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2024 08:16, Inochi Amaoto wrote:
> On Mon, Oct 28, 2024 at 08:06:25AM +0100, Krzysztof Kozlowski wrote:
>> On 28/10/2024 00:32, Inochi Amaoto wrote:
>>> On Sun, Oct 27, 2024 at 09:38:00PM +0100, Krzysztof Kozlowski wrote:
>>>> On Fri, Oct 25, 2024 at 09:09:58AM +0800, Inochi Amaoto wrote:
>>>>> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
>>>>> with some extra clock.
>>>>>
>>>>> Add necessary compatible string for this device.
>>>>>
>>>>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>>>>> ---
>>>>
>>>> This should be squashed with a corrected previous patch 
>>>
>>> Good, I will.
>>>
>>>> (why do you need to select snps,dwmac-5.30a?), 
>>>
>>> The is because the driver use the fallback versioned compatible 
>>> string to set up some common arguments. (This is what the patch
>>
>> Nope. Driver never relies on schema doing select. That's just incorrect.
>>
> 
> Yeah, I make a mistake on understanding you. For me, I just followed
> what others do. But there is a comment before this select.
> 
> """
> Select every compatible, including the deprecated ones. This way, we
> will be able to report a warning when we have that compatible, since
> we will validate the node thanks to the select, but won't report it
> as a valid value in the compatible property description
> """
> 
> By reading this, I think there may be some historical reason? Maybe
> someone can explain this.

I think this is left-over from older times before all specific
compatibles were added here and in their bindings. This binding has been
waiting for some cleanup for a while now, so this is fine.

I still think the patches should be merged, though.

Best regards,
Krzysztof


