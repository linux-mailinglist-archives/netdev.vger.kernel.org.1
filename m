Return-Path: <netdev+bounces-212735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A993B21B76
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E296E3AD2B3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF82E3380;
	Tue, 12 Aug 2025 03:11:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF27253359;
	Tue, 12 Aug 2025 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968314; cv=none; b=Zt5OFaOQl8wjuOf4nAdb9bFB2snYjfQa9fRDqgiouWdB+8XbPFOftY9B0UjLY+E1oFJoYE6I22g+QsXKwwDa0M8z7gIDPaF9LYHr1p3QYd4UU+7jQ/ay+KSlmkNDwLvQEUkJ++mMMOB8CM0hVnuSciP1df48qzOKldoIn0ovPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968314; c=relaxed/simple;
	bh=J+5V0xx3lI2r04i1in4bjdw1bkLd9VZSX0KX29JPZI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQ+34POUyZjjJwXItI1J82u4j5oO7YGUvuqrfzly8hoEm3XHVPZi6k2mqWrq8KqOxkqX5zgVEotfWdLGgCIoz58HYPSmdYHSr+qTxsAAfUpi2AZcKrjQ/RvwbsPdkStIOYAltehEoiGQSD+g+ksc1bJen8TP5BVBWEphWXaJ1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.111] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowADnPl+_sJpoQFIJCw--.51801S2;
	Tue, 12 Aug 2025 11:10:56 +0800 (CST)
Message-ID: <86b99a5f-02a0-43cc-9f7b-4ed3a260b4df@iscas.ac.cn>
Date: Tue, 12 Aug 2025 11:10:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] net: spacemit: Add K1 Ethernet MAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <uwu@dram.page>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250812-net-k1-emac-v5-0-dd17c4905f49@iscas.ac.cn>
 <20250812-net-k1-emac-v5-2-dd17c4905f49@iscas.ac.cn>
 <5c32fde3-0478-4029-9b71-e46a60edf06b@lunn.ch>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <5c32fde3-0478-4029-9b71-e46a60edf06b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowADnPl+_sJpoQFIJCw--.51801S2
X-Coremail-Antispam: 1UD129KBjvdXoW5Kry3GFyDKrWxXFy7JF1rCrg_yoWxWwc_Gw
	1Fk3yFkFs0yrs0y34Sgw15Ar1fKa95XF9xZw1v9r4xCF9xtFW29ryDuFnIq3WxWrZxGr95
	trnI9w4UWrn7AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jDsqXUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Andrew,

On 8/12/25 10:17, Andrew Lunn wrote:
>> +/* Caller must hold stats_lock */
>> +static void emac_stats_update(struct emac_priv *priv)
>> +{
>> +	u64 *tx_stats_off = (u64 *)&priv->tx_stats_off;
>> +	u64 *rx_stats_off = (u64 *)&priv->rx_stats_off;
>> +	u64 *tx_stats = (u64 *)&priv->tx_stats;
>> +	u64 *rx_stats = (u64 *)&priv->rx_stats;
>> +	u32 i, res;
> Rather than the comment, you could do:
>
> 	assert_spin_locked(priv->stats_lock);

Thanks, I'll use assert_spin_locked.

I don't think there's anything else that needs a similar assertion, but
I'll check for sure and update next version.

Vivian "dramforever" Wang


> 	Andrew


