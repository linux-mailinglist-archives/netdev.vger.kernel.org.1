Return-Path: <netdev+bounces-82832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DC988FE3D
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1C1C2906C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10102D792;
	Thu, 28 Mar 2024 11:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D30E7C0B5
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626075; cv=none; b=JnJwGNvVHjHCCdCx+9q3rt4tOprShx/Hwbv1ecHBNflrIoAWOSUQTqx28sh8ej6qoI7O8Rq4IMH0oJJTIolmXYX6d+eKnowWKuic91Ji4P14YNdTWUYORN0v7krjx2VUsueTs/OZUcOd1YRNdSQiMhcsDhAI/KOdO8v+Efr9qUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626075; c=relaxed/simple;
	bh=h1X589wqtBEGZAUBFr3UIluntM+OpRWUqYpbqIg+DjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qu4aogZhtlz1mDwRWFktb2twnbYcXNn14bD4nt+9Z1Yd9ot750ZC+fpFOSTve9t87EewvTLgLOOCDsHP5RDEGki9ARLa2KSgHcjIvma1tXXqO+fdOAVPFDoI62bh4VlpONUwNFfbJFFah+rReQyKXGqi3wMbfWMjSbXUg+w6xXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8AxafBVVwVmxQ8gAA--.9524S3;
	Thu, 28 Mar 2024 19:41:09 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx7c5RVwVmuvhrAA--.15887S3;
	Thu, 28 Mar 2024 19:41:06 +0800 (CST)
Message-ID: <bd25e13d-7cfd-433b-9640-e077882c510d@loongson.cn>
Date: Thu, 28 Mar 2024 19:41:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET
 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <027b4ee29d4d7c8a22d2f5c551f5c21ced3fb046.1706601050.git.siyanteng@loongson.cn>
 <ftqxjh67a7s4iprpiuw5xxmncj3bveezf5vust7cej3kowwcvj@m7nqrxq7oe2f>
 <d0e56c9b-9549-4061-8e44-2504b6b96897@loongson.cn>
 <466f138d-0baa-4a86-88af-c690105e650e@loongson.cn>
 <x6wwfvuzqpzfzstb3l5adp354z2buevo35advv7q347gnmo3zn@vfzwca5fafd3>
 <a9958d92-41da-4c3a-8c57-615158c3c8a2@loongson.cn>
 <09698d20-7188-45ed-89c5-1161bd52f2b1@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <09698d20-7188-45ed-89c5-1161bd52f2b1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx7c5RVwVmuvhrAA--.15887S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4xKFykZF15GF43JFyDtwc_yoW8Gw1fpa
	97ta18trWkCrn7CrZrZw4DZryfArZ7Z345GryUtFyS934Yg3ZY9r18Ww4q9wn3GFWkWFsI
	qa1UXFW8Zw4kXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2024/3/21 22:55, Andrew Lunn 写道:
>> Because the default return value of gnet's mdio is 0xffff, when scanning for
>> phy,
>>
>> if the return value is not 0, it will be assumed that the phy for that
>> address exists.
> That is not correct. The MDIO bus has a pull up on the data line. If
> there is no device at a given address, that pull up results in 0xffff
> being read. phylib understands this, it knows that a read with the
> value of 0xffff probably means there is no device at that address. So
> it will not create a device.
OK. I've got it.
>
>>   Not specifying an address will cause all addresses' phy to be detected, and
>> the
>>
>> lowest address' phy will be selected by default. so then, the network is
>> unavailable.
> Do you have multiple PHYs on the bus? If there is only one PHY the
Only one.
> first PHY should be the PHY you want, and phy_find_first() will do

static int loongson_gnet_data(struct pci_dev *pdev,
                   struct plat_stmmacenet_data *plat)
{
     struct net_device *ndev = dev_get_drvdata(&pdev->dev);
     struct stmmac_priv *priv = netdev_priv(ndev);
     struct phy_device *phydev;

     phydev = phy_find_first(priv->mii);
     plat->phy_addr = phydev->mdio.addr;

If I understand your comment correctly, this doesn't seem to work

because the mii hasn't been initialized at this point.


So, how about plat->phy_addr = -1;  ?


Thanks,

Yanteng



