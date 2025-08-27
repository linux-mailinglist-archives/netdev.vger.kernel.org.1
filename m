Return-Path: <netdev+bounces-217287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F589B38394
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D3F3AE3D1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ACB28504D;
	Wed, 27 Aug 2025 13:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5D1BCA07;
	Wed, 27 Aug 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300692; cv=none; b=jtyDOedFcaIunrfPEke4QCGaoRcnNdLtNJGbP35gYR1fH3iuSGMCKPCmEzBge10CTh2rp5XmxWnFjddn2jrYcFmsKqbhQMHWMx2f2Ned9fJpW83clxCnDmrb1PQrsCDKuFqYtkRsv3zktPZavBrHmjTg4pa8oe1KrqzaIrvPm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300692; c=relaxed/simple;
	bh=cheHazgTGDhKXw7vq6atCi2XUFv5oxx6gGI7RH7+KeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMWjyWXrFa4WuslZ41F73cmhEN++VtFGDP87y3f80QqrQo+13nBX5A2xBHHNJHEmZ/ZHU25vMns0mwS8ASObNhY9mqs6HKa692065Qv0G0O0dkZdfIl8nrvAc3h63L+wq/YQCGeCaXrD1piLb7+gojXKM+Slu8vYjQIiFuJWUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.102] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAC3SFljBa9oUlCJDw--.28806S2;
	Wed, 27 Aug 2025 21:17:24 +0800 (CST)
Message-ID: <9b83e78a-0456-4b43-9380-0e2b83933246@iscas.ac.cn>
Date: Wed, 27 Aug 2025 21:17:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/5] net: spacemit: Add K1 Ethernet MAC
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250826-net-k1-emac-v7-0-5bc158d086ae@iscas.ac.cn>
 <20250826-net-k1-emac-v7-2-5bc158d086ae@iscas.ac.cn>
 <eb127fd167cfbd885099a7c4c962eb1135a5a8a0.camel@pengutronix.de>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <eb127fd167cfbd885099a7c4c962eb1135a5a8a0.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zQCowAC3SFljBa9oUlCJDw--.28806S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUZF43Jw1kKr4rArWrZrb_yoWrJFy8pa
	ykJF9IkF4xAr17Kws3Xr4UAF93Xw4IyFyUCrySyw4rXwnFyr1fGry8KrWYkw1vyrZ8CryY
	va1UZa4I9Fs8u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
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
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07bIBTOUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi=C2=A0Philipp,

Thanks for your review.

On 8/26/25 16:54, Philipp Zabel wrote:
> On Di, 2025-08-26 at 14:23 +0800, Vivian Wang wrote:
>> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
>> that only superficially resembles some other embedded MACs. SpacemiT
>> refers to them as "EMAC", so let's just call the driver "k1_emac".
>>
>> Supports RGMII and RMII interfaces. Includes support for MAC hardware
>> statistics counters. PTP support is not implemented.
>>
>> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>  drivers/net/ethernet/Kconfig            |    1 +
>>  drivers/net/ethernet/Makefile           |    1 +
>>  drivers/net/ethernet/spacemit/Kconfig   |   29 +
>>  drivers/net/ethernet/spacemit/Makefile  |    6 +
>>  drivers/net/ethernet/spacemit/k1_emac.c | 2193 ++++++++++++++++++++++=
+++++++++
>>  drivers/net/ethernet/spacemit/k1_emac.h |  426 ++++++
>>  6 files changed, 2656 insertions(+)
>>
> [...]
>> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/eth=
ernet/spacemit/k1_emac.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..9e558d5893cfbbda0baa7a=
d21a7209dadda9487e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
>> @@ -0,0 +1,2193 @@
> [...]
>> +static int emac_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct reset_control *reset;
>> +	struct net_device *ndev;
>> +	struct emac_priv *priv;
>> +	int ret;
>> +
>> +	ndev =3D devm_alloc_etherdev(dev, sizeof(struct emac_priv));
>> +	if (!ndev)
>> +		return -ENOMEM;
>> +
>> +	ndev->hw_features =3D NETIF_F_SG;
>> +	ndev->features |=3D ndev->hw_features;
>> +
>> +	ndev->max_mtu =3D EMAC_RX_BUF_4K - (ETH_HLEN + ETH_FCS_LEN);
>> +
>> +	priv =3D netdev_priv(ndev);
>> +	priv->ndev =3D ndev;
>> +	priv->pdev =3D pdev;
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	ret =3D emac_config_dt(pdev, priv);
>> +	if (ret < 0) {
>> +		dev_err_probe(dev, ret, "Configuration failed\n");
>> +		goto err;
> I'd just
> 		return dev_err_probe(...);
> here.
>
>> +	}
>> +
>> +	ndev->watchdog_timeo =3D 5 * HZ;
>> +	ndev->base_addr =3D (unsigned long)priv->iobase;
>> +	ndev->irq =3D priv->irq;
>> +
>> +	ndev->ethtool_ops =3D &emac_ethtool_ops;
>> +	ndev->netdev_ops =3D &emac_netdev_ops;
>> +
>> +	devm_pm_runtime_enable(&pdev->dev);
>> +
>> +	priv->bus_clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>> +	if (IS_ERR(priv->bus_clk)) {
>> +		ret =3D dev_err_probe(dev, PTR_ERR(priv->bus_clk),
>> +				    "Failed to get clock\n");
>> +		goto err;
> Same here.
>
>> +	}
>> +
>> +	reset =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev=
->dev,
>> +								     NULL);
>> +	if (IS_ERR(reset)) {
>> +		ret =3D dev_err_probe(dev, PTR_ERR(reset),
>> +				    "Failed to get reset\n");
>> +		goto err;
> And here.
>
>> +	}
>> +
>> +	emac_sw_init(priv);
>> +
>> +	if (of_phy_is_fixed_link(dev->of_node)) {
>> +		ret =3D of_phy_register_fixed_link(dev->of_node);
>> +		if (ret) {
>> +			dev_err_probe(dev, ret,
>> +				      "Failed to register fixed-link");
>> +			goto err_timer_delete;
> If you can move this section before emac_sw_init(), this could also
> just return.
I'll take a look on these and clean up in next version, thanks.
>> +		}
> Then here a function calling of_phy_deregister_fixed_link() could be
> registered with devm_add_action_or_reset(), to avoid duplicated cleanup=

> in the error path and in emac_remove().

I'll deal with this. This should be fine, as it's probe-time only.

Thanks,
Vivian "dramforever" Wang


