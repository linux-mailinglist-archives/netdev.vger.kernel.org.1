Return-Path: <netdev+bounces-91537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25988B2FAD
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32DB1F23AAF
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 05:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F78713A25C;
	Fri, 26 Apr 2024 05:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E526AE3
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714108371; cv=none; b=ZQ3FIhRNQSs4YiWUH2u6utb+h00VUAsb02VpvRYD300pWUzIJjT4o+fqun3y7/qAafupsBHDWjRYCfao2QDuwwK4aXGfppai4vO/fYEd/ItpFj/Bp/0OWBzPPVjY51w/0deMZqYixnWhxFTNUS9Qkv+op1e9aeXyhq+fV2eywf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714108371; c=relaxed/simple;
	bh=QsEAgmWv5w/OYPcRYXKhGBJwzoQU/+nQXrLjveiBIb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ht5DWLAKP0XVfPo2euo/K8i5pem6QL885HkL8QeWdwh23AlRMBxUvSPx28s14UCq+vlxQ+IiV3Heqk4mkIv65WS5DmraRaXJYpBg6Fx4tqZuo8at9WYXRrBbGXd2wwflQfWbd0tnp4hPERJ3160lQrZ9/U5wZfciOKwigW04m1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8BxV_DONytmy00DAA--.14174S3;
	Fri, 26 Apr 2024 13:12:46 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxjd7LNytm_OoFAA--.19620S3;
	Fri, 26 Apr 2024 13:12:45 +0800 (CST)
Message-ID: <e8267bf9-e2ee-47e5-b199-1d28322e1c6f@loongson.cn>
Date: Fri, 26 Apr 2024 13:12:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com
Cc: Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxjd7LNytm_OoFAA--.19620S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw4ruFyDJFy3JF15AF1rXwc_yoW5Jry5pr
	Z3AFW7trWrJr13XF4DGw43XF15JrWUJ3y2gw43A3savrW0krnIyF1kG3y0vrWxGrWqka15
	Ga1rKFWkZ3WUGFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4R6wDUUUU

Copy here a comment from v11 that didn't get a clear response.


In v11:

在 2024/4/25 21:11, Yanteng Si 写道:
> +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> +				     struct plat_stmmacenet_data *plat,
> +				     struct stmmac_resources *res,
> +				     struct device_node *np)
> +{
> +	int i, ret, vecs;
> +
> +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		dev_info(&pdev->dev,
> +			 "MSI enable failed, Fallback to legacy interrupt\n");
> +		return loongson_dwmac_config_legacy(pdev, plat, res, np);
> +	}
> +
> +	res->irq = pci_irq_vector(pdev, 0);
> +	res->wol_irq = 0;
> +
> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> +	 * --------- ----- -------- --------  ...  -------- --------
> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> +	 */
> +	for (i = 0; i < CHANNEL_NUM; i++) {
> +		res->rx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 1 + i * 2);
> +		res->tx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 2 + i * 2);
> +	}
> +
> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +
> +	return 0;
> +}

* First,Serge wrote:


   Once again. Please replace this with simpler solution:

   static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
   +					   struct plat_stmmacenet_data *plat,
   +					   struct stmmac_resources *res)
   +{
   +	int i, ret, vecs;
   +
   +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
   +	 * --------- ----- -------- --------  ...  -------- --------
   +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
   +	 */
   +	vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
   +	ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
   +	if (ret < 0) {
   +		dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
   +		return ret;
   +	} else if (ret >= vecs) {
   +		for (i = 0; i < plat->rx_queues_to_use; i++) {
   +			res->rx_irq[CHANNELS_NUM - 1 - i] =
   +				pci_irq_vector(pdev, 1 + i * 2);
   +		}
   +		for (i = 0; i < plat->tx_queues_to_use; i++) {
   +			res->tx_irq[CHANNELS_NUM - 1 - i] =
   +				pci_irq_vector(pdev, 2 + i * 2);
   +		}
   +
   +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
   +	}
   +
   +	res->irq = pci_irq_vector(pdev, 0);
   +
   +	return 0;
   +}

* Then, Yanteng wrote:

   Well, I'll try again.

* And then,Hiacai wrote:

   In full PCI system the below function works fine, because alloc irq
   vectors with PCI_IRQ_LEGACY do the same thing as fallback to call
   loongson_dwmac_config_legacy(). But for a DT-based system it doesn't
   work.

* Last, Yanteng wrote:

   Hi Serge,
   How about we stay the same in v12?


Thanks,
Yanteng


