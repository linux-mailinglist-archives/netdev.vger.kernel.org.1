Return-Path: <netdev+bounces-220412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A06B45E4B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5828A00B3F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A4302168;
	Fri,  5 Sep 2025 16:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6331D72C;
	Fri,  5 Sep 2025 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090223; cv=none; b=aGGQKseBgi8s+m0fJDBNWmOH0Ir3yn7dzZzqdPkQDJx7omEqS/0MtgTNhwlxSXzxb4eguwZSbMQJidWCcDHiLRM3TAO1ts6FP+BGNm3D7H2q1OxZhXvGlDt/JehBSnTcdp4nUXGNydt1Lpuc9HQc4kHqtsD+Yd/zGMfKYk4AKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090223; c=relaxed/simple;
	bh=WMWV/zs7VqRch5M/3X1/0RlFh3MfGA58RBWGgbiM7Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUQAuOGbtqe9J1M4unug97MwwHw/s465e6JvlTxceoGlDzqoQyYr5N8pStj9OyIpY71tFKGWMzG9FjPu/5ZlD5SLE/NI2GRnTTyr6Y8MbVZOaQqELkAvsIDkS8RutFhIDfEOQ5LCVDw9rMIiEJbQqgGmJ7Q9fFOTlu108Zmbpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAAHqRJZEbtoxoHZAA--.36388S2;
	Sat, 06 Sep 2025 00:35:37 +0800 (CST)
Message-ID: <45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>
Date: Sat, 6 Sep 2025 00:35:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/5] net: spacemit: Add K1 Ethernet MAC
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, Vivian Wang <uwu@dram.page>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
 <20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
 <20250905153500.GH553991@horms.kernel.org>
 <0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>
 <20250905160158.GI553991@horms.kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250905160158.GI553991@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAAHqRJZEbtoxoHZAA--.36388S2
X-Coremail-Antispam: 1UD129KBjvJXoWruFW5Ary5JFW7Wr13trW8WFg_yoW8Jr4fpa
	y8Ka1qyF4Ut347JrWDX397Ar92yFn3JrW3Xrn3WayYgas0yr13t34xtrWjkw1DCrWF9w40
	va1jqr9FgFW5WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUvaZXDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 9/6/25 00:01, Simon Horman wrote:

> On Fri, Sep 05, 2025 at 11:45:29PM +0800, Vivian Wang wrote:
>
> ...
>
> Hi Vivian,
>
>>>> +		status = emac_rx_frame_status(priv, rx_desc);
>>>> +		if (unlikely(status == RX_FRAME_DISCARD)) {
>>>> +			ndev->stats.rx_dropped++;
>>> As per the comment in struct net-device,
>>> ndev->stats should not be used in modern drivers.
>>>
>>> Probably you want to implement NETDEV_PCPU_STAT_TSTATS.
>>>
>>> Sorry for not mentioning this in an earlier review of
>>> stats in this driver.
>>>
>> On a closer look, these counters in ndev->stats seems to be redundant
>> with the hardware-tracked statistics, so maybe I should just not bother
>> with updating ndev->stats. Does that make sense?
> For rx/tx packets/bytes I think that makes sense.
> But what about rx/tx drops?

Right... but tstats doesn't have *_dropped. It seems that tx_dropped and
rx_dropped are considered "slow path" for real devices. It makes sense
to me that those should be very rare.

So it seems that what I should do is to just track tx_dropped and
rx_dropped myself in a member in emac_priv and report in the
ndo_get_stats64 callback, and use the hardware stuff for the rest, as
implemented now.

Vivian "dramforever" Wang


