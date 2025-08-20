Return-Path: <netdev+bounces-215373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D863B2E482
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A4F586409
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC9275AEB;
	Wed, 20 Aug 2025 17:56:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E9273803;
	Wed, 20 Aug 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712596; cv=none; b=tKxZaO/YSwxYoblUbAU0IV1cQysaMwtRt+4DPQonI0A8Y1/NaTRvA0fWseRXrqj4bg6/ifJI00RuJ+82A95cF8nJnxQ2Iu9NvQU+cxCzpf59rifx0cv5/X1oSJQ+FPijfmrOOFd7EyTL4p2MZ5WrWLo3x33XxJQ/A/fBssZzlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712596; c=relaxed/simple;
	bh=PAk45Dqw/IAb5hhcZzBL27LdnwY8NSIC8b5E9cb1V/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkKUX5EHl+gYdw0/C0wY/KaUrexej9Y81DvIpL+hOIuoOD/KbolLMBGth8R95LFR0rJfIrUujJcE3oAj5iOdR0F7y917jGMz2ahXg+CuXVmfl97NVcgbr1g2y9nUMVpmPaJYaIymIK636FTSTmovOYpc3hHJr4Slk2+1BbtrRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.110] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowAB3Z6sLDKZou3TODQ--.64161S2;
	Thu, 21 Aug 2025 01:55:23 +0800 (CST)
Message-ID: <2601e3bd-b3d4-4eb1-bcb5-e4fbd9fe9c96@iscas.ac.cn>
Date: Thu, 21 Aug 2025 01:55:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] riscv: dts: spacemit: Add Ethernet
 support for BPI-F3
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
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
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250812-net-k1-emac-v5-0-dd17c4905f49@iscas.ac.cn>
 <20250812-net-k1-emac-v5-4-dd17c4905f49@iscas.ac.cn>
 <463dcfa3-152e-4a48-9821-debdc29c89b2@hammernet.be>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <463dcfa3-152e-4a48-9821-debdc29c89b2@hammernet.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3Z6sLDKZou3TODQ--.64161S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWrJr43Kw45AFy8Gr45Wrg_yoWfArbE9F
	WSqFnxu34ku3W0gr1UtanxAr1FqrZxWryaqas8twn5J34Ivw4UGw1rJas5JwnxGFy2qrnr
	ZFyagF4jyr12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUkX_TUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 8/13/25 21:34, Hendrik Hamerlinck wrote:
>
> On 8/12/25 04:02, Vivian Wang wrote:
>> Banana Pi BPI-F3 uses an RGMII PHY for each port and uses GPIO for PHY
>> reset.
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>>
> Tested on Banana Pi BPI-F3 and Orange Pi RV2. Verified SSH shell over eth0
> and eth1 interfaces, and basic UDP connectivity using iperf3. Thank you!
>
> Tested-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>

Thank you for the testing! I've already put this trailer on v6, but
forgot to reply here.

I haven't included the DTS patch for Orange Pi RV2 in v6, because the
board DTS is not in v6.17-rc1. However, it is in Yixun's spacemit tree,
AFAICT, so if we get the driver in for v6.18 I'll send the DTS
separately to spacemit mailing list. If we don't, I'll include it
alongside the driver when rebasing to v6.18-rc1.

Vivian "dramforever" Wang



