Return-Path: <netdev+bounces-224700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D170B887BE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F571898880
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A62EB5C4;
	Fri, 19 Sep 2025 08:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53959219A7E;
	Fri, 19 Sep 2025 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272122; cv=none; b=i6/djmCb1vJddXMxtbSG0iozVn4RwdjRrfpp8ROv46Lf1/x7hwm9X75lScn1EaL5JsOqiLFqZ2HQmIINFrJ/PbPjQyhz/vkkq6wetc/W6oHsJuQBMWE/t/1rkbB/xmf9e/NTHq7m7tSxu04XsWCOYnF76+v2jU1PnZmYJJ5g1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272122; c=relaxed/simple;
	bh=MxZDacxNXOiKS5PN5/vgRiUlqrC/te+ID8PxAHyhgYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksQxUBykV681xl+m0dbY3u39yzSX7RByRrl2iARj2ch+k2yxA5la8aECA+K1PmXwa7ZDlwVv7fuKAP6m52UwJeS3bsaHU6pTnNH0tJyhJs4mMJvn+SSHg7p5WYUMfZZC2dUN5+NjpuYzxkwfS/6Ho6vhIGEVbpYtLhvmg7gaOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.3.223] (unknown [124.16.136.211])
	by APP-03 (Coremail) with SMTP id rQCowAD3PnkUGs1oZXWwAw--.135S2;
	Fri, 19 Sep 2025 16:53:41 +0800 (CST)
Message-ID: <c3f2bc47-b7d3-4054-ae09-3265470c2306@iscas.ac.cn>
Date: Fri, 19 Sep 2025 16:53:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 0/5] Add Ethernet MAC support for SpacemiT K1
To: Marek Szyprowski <m.szyprowski@samsung.com>,
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
 Conor Dooley <conor.dooley@microchip.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
 <CGME20250919082706eucas1p1fa29f9e90e1afdf3894b5effd734cf3f@eucas1p1.samsung.com>
 <a52c0cf5-0444-41aa-b061-a0a1d72b02fe@samsung.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <a52c0cf5-0444-41aa-b061-a0a1d72b02fe@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3PnkUGs1oZXWwAw--.135S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rtFW3Xr4kXF1fXFWDJwb_yoW8WFW3pa
	ykAas0kr1Dtr42kr4jgr4vyayIva1kKF1Durn5Kry09a98AFn7tr9Ygw45A34jvrZ7Zr4Y
	yayUX395JFyDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jBYLkUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Marek,

Thanks for the testing.

On 9/19/25 16:27, Marek Szyprowski wrote:
> Hi All,
>
> On 14.09.2025 06:23, Vivian Wang wrote:
>> SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
>> Add devicetree bindings, driver, and DTS for it.
>>
>> Tested primarily on BananaPi BPI-F3. Basic TX/RX functionality also
>> tested on Milk-V Jupiter.
>>
>> I would like to note that even though some bit field names superficially
>> resemble that of DesignWare MAC, all other differences point to it in
>> fact being a custom design.
>>
>> Based on SpacemiT drivers [1]. These patches are also available at:
>>
>> https://github.com/dramforever/linux/tree/k1/ethernet/v12
>>
>> [1]: https://github.com/spacemit-com/linux-k1x
> This driver recently landed in linux-next as commit bfec6d7f2001 ("net: 
> spacemit: Add K1 Ethernet MAC"). In my tests I found that it 
> triggers lock dep warnings related to stats_lock acquisition. In the 
> current code it is being acquired with spin_lock(). For tests I've 
> changed that to spin_lock_irqsave() and the warnings went away, but I'm 
> not sure that this is the proper fix. I've also checked the driver 
> history and 'irqsave' locking was used in pre-v7 version, but it was 
> removed later on Jakub's request and described a bit misleading as 
> "Removed scoped_guard usage".

Oops, I had assumed that irqsave was unnecessary and missed that the
statistics functions are called with softirq enabled during
register_netdev. The ones called at probe time should be changed to
_irqsave or some other variant.

I'll take a look at the details myself and send a fix.

Thanks,
Vivian "dramforever" Wang


