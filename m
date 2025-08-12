Return-Path: <netdev+bounces-212867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B95B22514
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBFB1AA6128
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01BD2ECD18;
	Tue, 12 Aug 2025 10:58:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99F2EBDFD;
	Tue, 12 Aug 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996323; cv=none; b=jmF8JqTearv5mg/1LRnm+ZdKGbnIcvcJlTEnqLWzrNyMwgNGgE7YP7ziSa8HO+OJ0iZXdHCBIv7Yb6qvb1Hk36kRTF3USDeZZcHzhYQwPRAIfWa7j+c9Ob9cp7Y/5urHkAczWVZkJA+WQt2OavUym1BqWlpby7caLfwDpC1VrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996323; c=relaxed/simple;
	bh=kRgbW2F922teXyx2IY6WyMvEq9qFXLQDjnwHV9zkJxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbBhXKRPa2ydAM7+EeUARfGLEQs6rC6WZX/IoYuth3MWRyhgZOI5Tk1CDdk6tyiuY2Nl30z40anBGNfJFhJy11DcKaD38isrhoLnQjpJNrCsPKyJxXs/VKBCMLwFEbNF975bh04r0ZMv14aJAW9F9UFx9mXz9N/c6tiYm0YDIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAAXrFwmHpto6U4ZCw--.2240S2;
	Tue, 12 Aug 2025 18:57:42 +0800 (CST)
Message-ID: <0c894603-08dc-4dcd-a866-0a1d121cdb89@iscas.ac.cn>
Date: Tue, 12 Aug 2025 18:57:42 +0800
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
 <ac9cce0b-d29e-499b-8a86-28979cd12fb5@lunn.ch>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <ac9cce0b-d29e-499b-8a86-28979cd12fb5@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAAXrFwmHpto6U4ZCw--.2240S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8ZFWfWFy7tFyxWw4xXrb_yoW8Gry7pF
	yUJaykGrWjqF1kXFn8XrWUAFyIqwn3Kw17uF1YyayagF9FyryfC34rWFWUCwnrCrWDCr1a
	kw1jkFn7Gay2grDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 8/12/25 11:45, Andrew Lunn wrote:

>> +static void emac_get_pause_stats(struct net_device *dev,
>> +				 struct ethtool_pause_stats *pause_stats)
>> +{
>> +	struct emac_priv *priv = netdev_priv(dev);
>> +	struct emac_hw_tx_stats *tx_stats;
>> +	struct emac_hw_rx_stats *rx_stats;
>> +
>> +	tx_stats = &priv->tx_stats;
>> +	rx_stats = &priv->rx_stats;
>> +
>> +	scoped_guard(spinlock_irqsave, &priv->stats_lock) {
>> +		emac_stats_update(priv);
>> +
>> +		pause_stats->tx_pause_frames = tx_stats->tx_pause_pkts;
>> +		pause_stats->rx_pause_frames = rx_stats->rx_pause_pkts;
>> +	}
>> +}
> You have pause statistics, but not actual configuration of pause.
>
>> +static void emac_adjust_link(struct net_device *dev)
>> +{
>> +	struct emac_priv *priv = netdev_priv(dev);
>> +	struct phy_device *phydev = dev->phydev;
>> +	u32 ctrl;
> Normally the adjust_link callback you configure the hardware with the
> result of pause negotiation.

Thanks for the tip, I will fix emac_adjust_link next version.

>> +/* Called when net interface is brought up. */
>> +static int emac_open(struct net_device *ndev)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	struct device *dev = &priv->pdev->dev;
>> +
>> +	int ret;
> Extra blank line.

Oops. I will fix next version.

Thanks,
Vivian "dramforever" Wang

>
>     Andrew
>
> ---
> pw-bot: cr


