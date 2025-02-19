Return-Path: <netdev+bounces-167881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC632A3CA6D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1473B243C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74724E4B7;
	Wed, 19 Feb 2025 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zh3zspZ2"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC624E4A3
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998337; cv=none; b=egLaGx/pspuvO0t6MqOwcpMH+Gs5hFaq0Vrvw5pt1geylveDwryTkGwguC2S5kWL644RsrnggKR4WhKuPRCpB3Dc1AZmD6vI7Qh8oVeugaF0oorK6WfxtbvtFiQ4Mw+A4ZeaWGV8pleHtQnjIwkdSF/KJmt3Ls9f0cyA77UDkt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998337; c=relaxed/simple;
	bh=5xM591Q9pMY4myUmlKylPMFrmVvIMKXhUKSFxtN3m0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+sQ9m7Y5OXmi+tjLQlox79PztbJa4IOJyZdlhNg7X+fv6sDnvXv+Rp7NGJ/2Ni4AQ8YYgjGla18uuNrw7G3n3ZoD1/D7aT4NvqSYUzpuUYtLQmk7LIswmz2AUjGaReEff2NNEkZBGXSa7goFI6Ocgj0hhyjgQjSu0XssLHYm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=zh3zspZ2; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F2D722C019A;
	Thu, 20 Feb 2025 09:42:31 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1739997751;
	bh=1OF9sa6quHwoXM17gF/nCRzqK14R3hUHb3M+ii+Vwkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zh3zspZ2gbCGDQDjdDM8IzzRl6EKqqPWDjMzeGi1796lk1kGeteG4iDdloA7wCLL2
	 8Y2C9zeZq7d8Qx5SEEB0HFZZad36tjUc3TJEtro6+AvBi4SjHzHD4UaXqFIhEzd/qK
	 hdcovdikriFgSRjDJdsfGSCoaf+XDfd6GNbDhiodvMu0fQxizWQYuo7hi4J2MSbcWa
	 fReNYs87i0IWhY0gCMuL7CONeztsD1UXWofQ400ntIIWSGc4djmbGvVETmqKMVoRmq
	 CAWeFEbjEpH+x4EAdVMnP73RYGHAjIWpSlPBEzFMGQcDSSihjsQNGUnqhP0eTCV6ml
	 AlmD8qjGOo80A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67b642370000>; Thu, 20 Feb 2025 09:42:31 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 9E0AD13ED2A;
	Thu, 20 Feb 2025 09:42:31 +1300 (NZDT)
Message-ID: <f051fd62-4762-412e-a11e-ff96d468476c@alliedtelesis.co.nz>
Date: Thu, 20 Feb 2025 09:42:31 +1300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RESEND PATCH net-next 3/5] dt-bindings: net: Add Realtek MDIO
 controller
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, linux-mips@vger.kernel.org,
 tsbogend@alpha.franken.de, andrew+netdev@lunn.ch, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 lee@kernel.org, davem@davemloft.net
References: <20250218195216.1034220-1-chris.packham@alliedtelesis.co.nz>
 <20250218195216.1034220-4-chris.packham@alliedtelesis.co.nz>
 <173997391420.2383401.13425265155310657100.robh@kernel.org>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <173997391420.2383401.13425265155310657100.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ccpxrWDM c=1 sm=1 tr=0 ts=67b64237 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=Cr900lsLVkzRsI26oPQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Hi Rob,

On 20/02/2025 03:06, Rob Herring (Arm) wrote:
> On Wed, 19 Feb 2025 08:52:14 +1300, Chris Packham wrote:
>> Add dtschema for the MDIO controller found in the RTL9300 Ethernet
>> switch. The controller is slightly unusual in that direct MDIO
>> communication is not possible. We model the MDIO controller with the
>> MDIO buses as child nodes and the PHYs as children of the buses. The
>> mapping of switch port number to MDIO bus/addr requires the
>> ethernet-ports sibling to provide the mapping via the phy-handle
>> property.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>
>> Notes:
>>      This is technically v7 of [1] and [2] which are combined now that
>>      rtl9301-switch.yaml under net/ the only change from those is that the
>>      $ref: in rtl9301-switch.yaml can now use a relative path
>>
>>      I could technically do away with the reg property on the mdio-controller
>>      node. I don't currently need to use it in my driver and it looks like
>>      the register offsets are the same between the RTL9300 and RTL9310.
>>
>>      [1] - https://lore.kernel.org/lkml/20250204030249.1965444-6-chris.packham@alliedtelesis.co.nz/
>>      [2] - https://lore.kernel.org/lkml/20250204030249.1965444-4-chris.packham@alliedtelesis.co.nz/
>>
>>   .../bindings/net/realtek,rtl9301-mdio.yaml    | 86 +++++++++++++++++++
>>   .../bindings/net/realtek,rtl9301-switch.yaml  | 31 +++++++
>>   2 files changed, 117 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
>>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>
> Missing tags:
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Sorry about that. I wasn't sure since this was spun off from the other 
series and because it now includes changes to 
realtek,rtl9301-switch.yaml. I should have at least mentioned that.

If there is another round for this one I'll include your r-by.


