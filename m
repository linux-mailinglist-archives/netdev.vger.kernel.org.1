Return-Path: <netdev+bounces-203807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768CAF7435
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EF31C20DDD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD852E62DF;
	Thu,  3 Jul 2025 12:32:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE721D3F8;
	Thu,  3 Jul 2025 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545929; cv=none; b=SuSjA64oJxqRq+VaZsN40UtS8M0CpjbJJ7CMWW1e3yJ6zdmJjmqbVJPxuBBFgGW9lZ2aTH3T4UIvdZSuE6vNOBzYOtCLbBF6DnQ7nia1XTEI7qLZ8ZE0Y60Zj/hi4PSmh/+V05jI8xa89Zug80rimjFFp2YHSwFnXnez/qlIBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545929; c=relaxed/simple;
	bh=oAFqXq1QyFv35ms999RYltPlUo10N7M57paHMCPoPSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFHA4o6msEi59LLkayTEaeQf4h8IoLJLZuwAsOkgA4eibZjUhfNdMliViRPaDuFzkLxPq7AvHUSEoLRFD5Az/h6HW/mTmBDOiSF/A80eg9LGXWrxZZL1XAJc0z0NzzaK4zQ0tS52JbhX4s2vdEyqlVxGd2byglLWMm12k2PCDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAC3Dl8YeGZoHT+zAA--.45946S2;
	Thu, 03 Jul 2025 20:31:20 +0800 (CST)
Message-ID: <17733827-8038-4c85-9bb1-0148a50ca10f@iscas.ac.cn>
Date: Thu, 3 Jul 2025 20:31:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: Add support for
 SpacemiT K1
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Conor Dooley <conor.dooley@microchip.com>, netdev@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-riscv@lists.infradead.org, Simon Horman <horms@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
 Vivian Wang <uwu@dram.page>, Yixun Lan <dlan@gentoo.org>,
 spacemit@lists.linux.dev, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20250703-net-k1-emac-v4-0-686d09c4cfa8@iscas.ac.cn>
 <20250703-net-k1-emac-v4-1-686d09c4cfa8@iscas.ac.cn>
 <175153978342.612698.13197728053938266111.robh@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <175153978342.612698.13197728053938266111.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAC3Dl8YeGZoHT+zAA--.45946S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry3WF48Kr4UWryfuF13CFg_yoW8uF43pa
	ySkwnIkrWjvFy7Jw43tr92v3WFgr4ftFyaqFy2gr17t3Z8XF4ftrWS9r48uF18CrWrJa4f
	Zw17u3WxGry5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxU3wIDUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 7/3/25 18:49, Rob Herring (Arm) wrote:
> On Thu, 03 Jul 2025 17:42:02 +0800, Vivian Wang wrote:
>> The Ethernet MACs on SpacemiT K1 appears to be a custom design. SpacemiT
>> refers to them as "EMAC", so let's just call them "spacemit,k1-emac".
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   .../devicetree/bindings/net/spacemit,k1-emac.yaml  | 81 ++++++++++++++++++++++
>>   1 file changed, 81 insertions(+)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/net/spacemit,k1-emac.example.dts:36.36-37 syntax error
> FATAL ERROR: Unable to parse input tree

My bad. The example still depends on the reset bindings for the constant 
RESET_EMAC0. I just tried with reset v12 [1] and that fixes it.

[1]: https://lore.kernel.org/spacemit/20250702113709.291748-2-elder@riscstar.com/

Vivian "dramforever" Wang

> make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/net/spacemit,k1-emac.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250703-net-k1-emac-v4-1-686d09c4cfa8@iscas.ac.cn
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.


