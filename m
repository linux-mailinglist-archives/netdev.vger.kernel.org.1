Return-Path: <netdev+bounces-206335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C56CB02AD2
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 14:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5CA7ACC3B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 12:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444AA275B0B;
	Sat, 12 Jul 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkcU4nEm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE91DFD96;
	Sat, 12 Jul 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752323745; cv=none; b=UcDggK4yL5r4KXRIdenudNAPjjTRnLB4uyb/8P0ey7UP3Z3oEpT8mhkBhtBMwSnZC97x8jd1gqKxJQKLSPA2rxfFu3l/AHZxWBHkw8m8wUjmgBN61mZD78uuFKuBdGs5FfWkdSE0oo2oW9jbCqqODVoBn8SrZKO3X5sv/D9fzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752323745; c=relaxed/simple;
	bh=lXFoGeveBkgpPfzpXT/Ao/zuuvCsduR2W62DWuGCibk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UCzLy5EJ8+BnVqI2mKsoZwMl5xw6pTaSbef/kaijFkFhf7UTQcf37ETVjH/ROqCDVxV7hWDQjNfzrl1R0LDrNDcJrMcjg7c8o1jHP7pWAe5U6/Ixpy/eTJk72JUieoOWFwKGxWbUZKu4EU4I4k+inDac54ZNDEL2GO48DpVdB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkcU4nEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB56C4CEEF;
	Sat, 12 Jul 2025 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752323744;
	bh=lXFoGeveBkgpPfzpXT/Ao/zuuvCsduR2W62DWuGCibk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HkcU4nEmSaxfhj0q87QWOddf180UgwMkXuU/IH0d8XZQNbecFYpReNPy5z5vlMlXO
	 S8adonG+rrJhDcf9Ouo8igpbrKJlRVDoaMAx2Yy6h0PcpQXIsXJ1iY62zYXO28Q3Om
	 8qmnCNPXNp878uWScf8TTPeJwsyuWWhWlQ5M9GIxquvF/DUXwrPbtD795THy1Nmpi+
	 OHsEsgBnMIci0YYE80HCWVjFPhrjh20ax0U2WtpVn1f9qIah9ejcIFjP+3aMpUBT9E
	 6becPzLvmKfK1wxKF1Sr1UJJYDS4Ln/ig2CsEOiaTy+V9CzpOWG8B4fuBFG36ILrX7
	 DaWAgtKXG4lvA==
Message-ID: <b6897cec-eb02-451c-8b81-013a8166e2be@kernel.org>
Date: Sat, 12 Jul 2025 07:35:40 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: altr,socfpga-stmmac.yaml: add minItems
 to iommus
To: Matthew Gerlach <matthew.gerlach@altera.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250707154409.15527-1-matthew.gerlach@altera.com>
 <b752c340-bbb5-479f-bc2c-a9e8541509c3@kernel.org>
 <c048d76e-8187-440f-9f28-b6594810d5dd@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <c048d76e-8187-440f-9f28-b6594810d5dd@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/25 17:23, Matthew Gerlach wrote:
> 
> 
> On 7/8/25 11:54 PM, Krzysztof Kozlowski wrote:
>> On 07/07/2025 17:44, Matthew Gerlach wrote:
>> > Add missing 'minItems: 1' to iommus property of the Altera SOCFPGA SoC
>> > implementation of the Synopsys DWMAC.
>>
>> Why? Explain why you are doing thing, not what you are doing. What is
>> obvious which makes entire two-line commit msg redundant and useless.
> This conversion to yaml was a merge of two separate conversions from 
> Ding Nguyen and myself plus some resolved issues highlighted by Rob 
> Herring, but I missed the minItems:
> 
> https://lore.kernel.org/lkml/20250626234816.GB1398428-robh@kernel.org/
> 
>>
>> Original binding had no iommus and referenced commit does not explain
>> why they appeared during conversion in the first place.
> The text version of the binding was created before the device trees for 
> the Agilex family, which do support iommus, were accepted into the kernel.
>>
>> > > Fixes: 6d359cf464f4 ("dt-bindings: net: Convert socfpga-dwmac 
>> bindings to yaml")
>> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
>> > ---
>> >  Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml | 1 +
>> >  1 file changed, 1 insertion(+)
>> > > diff --git 
>> a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml 
>> b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>> > index c5d8dfe5b801..ec34daff2aa0 100644
>> > --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>> > +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>> > @@ -59,6 +59,7 @@ properties:
>> >        - const: ptp_ref
>> > >    iommus:
>> > +    minItems: 1
>> >      maxItems: 2
>>
>> Why this has to be flexible on given SoC? This is weird. Same hardware
>> differs somehow?
> Dinh can you comment on this binding from 
> https://lore.kernel.org/all/20250624191549.474686-1-dinguyen@kernel.org/?
> 

This might have been a copy/paste error.

DInh


