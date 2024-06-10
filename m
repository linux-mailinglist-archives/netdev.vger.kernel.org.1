Return-Path: <netdev+bounces-102246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792C902156
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8EB286186
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558E97E576;
	Mon, 10 Jun 2024 12:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600A17FBA2
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021556; cv=none; b=eyel187gpXYwnMglr6cdLrEHwQkp+jWFPwHieTFEKreqcFRJXL6n4mSgo/qEG8X9WmPxMg8j7pm3SOi1aHycQ5wUPhjoCY7pMVMSYJinCGZuU2+Eh3qjOmoAzTfF2uSBD3RwOVrmXv99I3VsiEUe0Tj8ccGxFCyHR/t5ZtE+lLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021556; c=relaxed/simple;
	bh=LZ3fBW/xy4JqHLBOXssr2Pe+OQ8bvplX/E+G9CoSPxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qU3svp3wc4q6CHxwX/hRA4cB7RAlqWkH0ATtyfF7KeodZymvNVpClc2ZeWeurTmdNZGpGaczFBn0hhgxF2G1YIfvtoI7chpB63Hs2WG6iTXizhbmNVt3nGw+d0NfRa5a+eYf2wajZiYwJetP/DMIqbY7BnOaOzyjKBTIWb1jdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.86])
	by gateway (Coremail) with SMTP id _____8AxUPCo7WZmW1kFAA--.22055S3;
	Mon, 10 Jun 2024 20:12:24 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.86])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxVcWl7WZmQuUaAA--.55371S3;
	Mon, 10 Jun 2024 20:12:22 +0800 (CST)
Message-ID: <1b7f7f4a-86fe-44fe-b186-4dbfa20c44fd@loongson.cn>
Date: Mon, 10 Jun 2024 20:12:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H4J+ZXryKC9wAKBwavJxMZWFZ8ODgNE_6+v0NquSWq8Fw@mail.gmail.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <CAAhV-H4J+ZXryKC9wAKBwavJxMZWFZ8ODgNE_6+v0NquSWq8Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxVcWl7WZmQuUaAA--.55371S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4UArWkCrW3ZFy3JF1kJFc_yoWrJr47pr
	W7AFZIgrZ7Gr4Y9a1vyw4DXryYvrWFq3srWF42kwnYkFyqyryUXFy0kFWYvrWxurWDJr12
	vFWq9w4kWFsrKwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

Hi all,

在 2024/5/30 10:46, Huacai Chen 写道:
>>   #define PCI_DEVICE_ID_LOONGSON_GMAC    0x7a03
>> +#define PCI_DEVICE_ID_LOONGSON_GNET    0x7a13
>> +#define DWMAC_CORE_LS2K2000            0x10    /* Loongson custom IP */
> It is not suitable to call 0x10 "LS2K2000", because LS2K2000 is the
> name of the whole SOC, not the NIC IP. As an example, ThinkPad is the
> name of a whole computer series, you cannot call its CPU "ThinkPad
> CPU". Right?
>  From my point of view, the name "LOONGSON_DWMAC_CORE_1_00" in V12 is
> much better.
>
> If any macro name for 0x10 is unacceptable, and open-code 0x10 is also
> unaccpetable, then there is an alternative way, apply the below patch
> on top of this one:
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index b41ffdc6d3d0..81293e2570e8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -66,11 +66,10 @@
>
>   #define PCI_DEVICE_ID_LOONGSON_GMAC    0x7a03
>   #define PCI_DEVICE_ID_LOONGSON_GNET    0x7a13
> -#define DWMAC_CORE_LS2K2000            0x10    /* Loongson custom IP */
>   #define CHANNEL_NUM                    8
>
>   struct loongson_data {
> -       u32 loongson_id;
> +       int has_multichan;
>          struct device *dev;
>   };
>
> @@ -370,7 +369,7 @@ static struct mac_device_info
> *loongson_dwmac_setup(void *apriv)
>           * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
>           * original value so the correct HW-interface would be selected.
>           */
> -       if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
> +       if (ld->has_multichan) {
>                  priv->synopsys_id = DWMAC_CORE_3_70;
>                  *dma = dwmac1000_dma_ops;
>                  dma->init_chan = loongson_gnet_dma_init_channel;
> @@ -397,7 +396,7 @@ static struct mac_device_info
> *loongson_dwmac_setup(void *apriv)
>          if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
>                  mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
>          } else {
> -               if (ld->loongson_id == DWMAC_CORE_LS2K2000)
> +               if (ld->has_multichan)
>                          mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>                                           MAC_10 | MAC_100 | MAC_1000;
>                  else
> @@ -474,6 +473,7 @@ static int loongson_dwmac_probe(struct pci_dev
> *pdev, const struct pci_device_id
>          struct stmmac_pci_info *info;
>          struct stmmac_resources res;
>          struct loongson_data *ld;
> +      u32 gmac_version;
>          int ret, i;
>
>          plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> @@ -530,9 +530,19 @@ static int loongson_dwmac_probe(struct pci_dev
> *pdev, const struct pci_device_id
>
>          memset(&res, 0, sizeof(res));
>          res.addr = pcim_iomap_table(pdev)[0];
> -       ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
> +       gmac_version = readl(res.addr + GMAC_VERSION) & 0xff;
>
> -       if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
> +      switch (gmac_version) {
> +      case DWMAC_CORE_3_50:
> +      case DWMAC_CORE_3_70:
> +           ld->has_multichan = 0;
> +                  plat->tx_queues_to_use = 1;
> +                  plat->rx_queues_to_use = 1;
> +                  ret = loongson_dwmac_intx_config(pdev, plat, &res);
> +           break;
> +
> +        default:
> +             ld->has_multichan = 1;
>                  plat->rx_queues_to_use = CHANNEL_NUM;
>                  plat->tx_queues_to_use = CHANNEL_NUM;
> @@ -543,12 +553,8 @@ static int loongson_dwmac_probe(struct pci_dev
> *pdev, const struct pci_device_id
>                          plat->tx_queues_cfg[i].coe_unsupported = 1;
>
>                  ret = loongson_dwmac_msi_config(pdev, plat, &res);
> -       } else {
> -               plat->tx_queues_to_use = 1;
> -               plat->rx_queues_to_use = 1;
> +    }
>
> -               ret = loongson_dwmac_intx_config(pdev, plat, &res);
> -       }
>          if (ret)
>                  goto err_disable_device;
>
Huacai's method works.


Thanks,

Yanteng

> Huacai


