Return-Path: <netdev+bounces-45108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410C7DAECE
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26C4281430
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CB12E6D;
	Sun, 29 Oct 2023 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uh9alWGo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E4C8D2;
	Sun, 29 Oct 2023 22:24:52 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9FBA;
	Sun, 29 Oct 2023 15:24:51 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F5D166072BB;
	Sun, 29 Oct 2023 22:24:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698618289;
	bh=CceHk5gunNkmS5xqnTyMOvT/5Ea2c+1CgMjho/nsIsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uh9alWGouQ7U6jJthpEGwuVHe+CmdXjzGtc0aY68TODT29nPU4vrPOt4UnOKnhPYl
	 1//sMVxcYVCTnIY8joZ85xDL5cS4E1Od5si2MlzQW7T2HNYzOWO1zppZstlFmSmt64
	 hwZphy/RqXi9zkJNfzKRY5Xkv3ZdDA+cFBmkeXg3DB2CiCzxqIISPfiVuM5+Qwh1wX
	 Rb7kDregtZwbcFKuaz0sppThi5rjy7iIrmURUp+uuFD1A4I6LDUwRLRsavbF2F73HP
	 B9/fO78eoxmE4ZROfBb5EqpUTR/hEDnPyv4jGOzlL1cHBPq8wpxAX8VYKWNnzMtLsH
	 SfX2djN/7cteA==
Message-ID: <05186c62-fcad-4d56-8ae8-d802f87a39e2@collabora.com>
Date: Mon, 30 Oct 2023 00:24:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: net: snps,dwmac: Allow exclusive
 usage of ahb reset
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-2-cristian.ciocaltea@collabora.com>
 <3016eff2-fce5-4b5e-bbb2-d56cbb45df85@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3016eff2-fce5-4b5e-bbb2-d56cbb45df85@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/23 13:25, Krzysztof Kozlowski wrote:
> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>> The Synopsys DesignWare MAC found on the StarFive JH7100 SoC requires
>> just the 'ahb' reset name, but the binding allows selecting it only in
>> conjunction with 'stmmaceth'.
>>
>> Fix the issue by permitting exclusive usage of the 'ahb' reset name.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index 5c2769dc689a..a4d7172ea701 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -146,7 +146,7 @@ properties:
>>    reset-names:
>>      minItems: 1
>>      items:
>> -      - const: stmmaceth
>> +      - enum: [stmmaceth, ahb]
> 
> Also, this makes sense only with patch #4, so this should be squashed there.

I added this as a separate patch since it changes the generic schema
which is included by many other bindings.  JH7100 just happens to be the
first use-case requiring this update.  But I can squash the patch if
that's not a good enough reason to keep it separately.

Thanks,
Cristian

