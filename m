Return-Path: <netdev+bounces-215632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483E0B2FB3F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ABFAE80DE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59AC2EDD50;
	Thu, 21 Aug 2025 13:39:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B82EDD41;
	Thu, 21 Aug 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783556; cv=none; b=Orx4Ao7mJxsIcNsTLUzSgFDre+ryuKgZivO14W6HCZLeG3M6/Dnf2NvpVcs250xB9gKmIc6g20HeRXFrVHO9uou5y/AoUYhsybuwQvIJW+27zpN2cqk+OFFMLyH28cJCq2wJ2zvq5eltmNCLtJ9ARzq/4jw1mMThmrwewc2CRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783556; c=relaxed/simple;
	bh=nB2t3WQDGZmyqwOWHUe4oKJKmrBX6EMje7BAzEJRWNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJeg2bYPLRtgZm/32y3B7b/aK7A0JIXqnbKFBItIWw2f2RKqxeFjYoUUXx1zetDAadLMa3ViE65fFqC9h5gv5GdP6ssNMtNBPFdvQMKbcFYxWn7EAQqmRsn7f4tLIvo7ckzAU0EZzJfVaLekbjmNFeH8/ASEYfXIsXh1jwV9Mgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABXR6tfIadoNV0QDg--.59898S2;
	Thu, 21 Aug 2025 21:38:40 +0800 (CST)
Message-ID: <e0d4e114-9523-4b12-bf32-22d13c7f914f@iscas.ac.cn>
Date: Thu, 21 Aug 2025 21:38:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] net: spacemit: Add K1 Ethernet MAC
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn>
 <20250820-net-k1-emac-v6-2-c1e28f2b8be5@iscas.ac.cn>
 <cf0431cf-523e-488e-87ec-6b5a68699809@linux.dev>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <cf0431cf-523e-488e-87ec-6b5a68699809@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXR6tfIadoNV0QDg--.59898S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryfZFWfAr48ZFy8AFWUurg_yoWxtrXEkF
	W0vwnF9w1DGw10g3WfG3ZF9w4DKr1kXr1xWrZrZws5Jw17AF98XF17Kwnaqr43WFZ2qrn7
	Gr1jyrWYv343ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
	80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
	zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
	8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF
	7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07jgPEfUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Vadim,

On 8/21/25 20:59, Vadim Fedorenko wrote:

> On 20/08/2025 07:47, Vivian Wang wrote:
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
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev> 

Thank you for your review. I appreciate it.

Vivian "dramforever" Wang


