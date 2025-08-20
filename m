Return-Path: <netdev+bounces-215368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C4B2E468
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533B15E4BAB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57272737FB;
	Wed, 20 Aug 2025 17:49:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8E26B2D7;
	Wed, 20 Aug 2025 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712141; cv=none; b=Vj868QohH2ZzdEmG44K+0SSyU11L2FasdQbFIwYYXKjgSxvYNzmfJuLkAQWQP0lT8zwvxw/Dc62jjxud1cIDN5OUVxXfso3Tkz4qLj4sHxQ2eDaDOoV+dJojDXJ/b4WwXOVQanw6Vfms2PbYTkocz5h/OJoOQgehf5d/OXrQQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712141; c=relaxed/simple;
	bh=wFEaUXSKxGKGDrafji9rNYNmODBy+B6j/W4l+Y+SZpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElwwTEDZBqPB7k4DZcSN6Ok03NjW4SjU3t0n9bmQriP3R2SpKgLpZGgqHB5Dbcl3DebE6MwpEk8eIv46U0cpW9ATs8ZTaSbvaG+Io+kba3qxmHZVgBeYGTJrcsXL8NgSvM8CQ8acYVO0RXVNPaOcyO+16ZbM6vuY+4X5iXAB6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.110] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowADXA6hiCqZoxxbODQ--.27375S2;
	Thu, 21 Aug 2025 01:48:18 +0800 (CST)
Message-ID: <ca3404c1-7773-4b47-8a95-b61e5cd9be96@iscas.ac.cn>
Date: Thu, 21 Aug 2025 01:48:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] net: spacemit: Add K1 Ethernet MAC
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn>
 <20250820-net-k1-emac-v6-2-c1e28f2b8be5@iscas.ac.cn>
 <3c8d191c-efd6-4756-9c71-109236d4c54c@bootlin.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <3c8d191c-efd6-4756-9c71-109236d4c54c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXA6hiCqZoxxbODQ--.27375S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWfKr45KrW5tF15Gr18uFg_yoW3CrcE9F
	1vvwn7Zw1UK3WUGw4fKanFvws8Kr1kXr1xWr9rtws3t342yFyDWFnrK34Sgr43XrWvqrnr
	Gw10vFWIkw17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jgPEfUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Maxime,

On 8/20/25 19:34, Maxime Chevallier wrote:
> Hi Vivian,
>
> On 20/08/2025 08:47, Vivian Wang wrote:
>> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
>> that only superficially resembles some other embedded MACs. SpacemiT
>> refers to them as "EMAC", so let's just call the driver "k1_emac".
>>
>> Supports RGMII and RMII interfaces. Includes support for MAC hardware
>> statistics counters. PTP support is not implemented.
>>
>> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>
> I've read through the driver and it's looking good to me
>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com> 
>
Thank you for the review. I appreciate it.

Vivian "dramforever" Wang


