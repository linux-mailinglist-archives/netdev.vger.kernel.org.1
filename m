Return-Path: <netdev+bounces-220662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB429B47994
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5989D3C2AA4
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA13F20CCE4;
	Sun,  7 Sep 2025 08:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD41E1DE7;
	Sun,  7 Sep 2025 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233418; cv=none; b=pxI9sjvNbxrUbue3V+LSea8VczdgLdINFpVy0GioKSyqMG8BDUaYlz7uEbWx/B0Perhp/kzQteV2Z9RTXuLbEc/6ktRQqCu6hpmkyvpMSQv3v2zVSVsb+EE4sdYu3cugBDkYlXFNhJzx3QFevRCP7WJyQ4bWgmeYRpAN0rL5i70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233418; c=relaxed/simple;
	bh=r0eJTebCt3MS2Xw6g6hfJ21wZgUkK/hVYw3MMLUbnxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdtVxD332/QQglH984EFE0Y0hiDmOdWQZ+FW2cQA8ayj0WBDG+AGoVlKQGE6zazRzZAfJR+Yst9ZmEx53Hfwc/mq06A3uHcYMB70+B913PReykVZy+VKMaRu4z0EBU+/HiEp58jgOxU97aTDpcmKEO1njKsrvMrjkyHNaA7mBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowABX+hPUQL1oMWdTAQ--.2947S2;
	Sun, 07 Sep 2025 16:22:44 +0800 (CST)
Message-ID: <fbcc1ec3-7ff6-4891-97e3-9763355326f7@iscas.ac.cn>
Date: Sun, 7 Sep 2025 16:22:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/5] net: spacemit: Add K1 Ethernet MAC
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
 <45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>
 <20250905165908.69548ce0@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250905165908.69548ce0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zQCowABX+hPUQL1oMWdTAQ--.2947S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw47JryDGw4rtry5Kw4rKrg_yoW8Gr4rpF
	WrKFs2kFWvqw4xt3yvv3ykX343t3ZxZ3y5Gryqga47ta45Zryfu3yxKrWIyasrGrWkZ3y0
	vry5JFyjkFZ8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYsSdPUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 9/6/25 07:59, Jakub Kicinski wrote:

> On Sat, 6 Sep 2025 00:35:37 +0800 Vivian Wang wrote:
>>>> On a closer look, these counters in ndev->stats seems to be redundan=
t
>>>> with the hardware-tracked statistics, so maybe I should just not bot=
her
>>>> with updating ndev->stats. Does that make sense? =20
>>> For rx/tx packets/bytes I think that makes sense.
>>> But what about rx/tx drops? =20
>> Right... but tstats doesn't have *_dropped. It seems that tx_dropped a=
nd
>> rx_dropped are considered "slow path" for real devices. It makes sense=

>> to me that those should be very rare.
> Pretty sure Simon meant the per-cpu netdev stats in general.
> There are three types of them, if you need drops I think you
> probably want dstats. Take a look.

According to this comment in net/core/dev.c dev_get_stats():

=C2=A0 =C2=A0 /*
=C2=A0 =C2=A0 =C2=A0* IPv{4,6} and udp tunnels share common stat helpers =
and use
=C2=A0 =C2=A0 =C2=A0* different stat type (NETDEV_PCPU_STAT_TSTATS vs
=C2=A0 =C2=A0 =C2=A0* NETDEV_PCPU_STAT_DSTATS). Ensure the accounting is =
consistent.
=C2=A0 =C2=A0 =C2=A0*/

"dstats" is meant for tunnels. This doesn't look like the right thing to
use, and no other pcpu_stat_type gives me tx_dropped. Do you think I
should use dstats anyway?

(And yes the only software-tracked one should be tx_dropped. Since we
pre-allocate the RX buffers, there is no opportunity to drop on RX in
software.)


