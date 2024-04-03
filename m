Return-Path: <netdev+bounces-84315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A0896843
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD611F217A6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B206BB33;
	Wed,  3 Apr 2024 08:09:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1C1272DF
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131770; cv=none; b=KyRqYPuVKvitwbbEneGNDvaRtfhmMtWJOGnWVHHgFRz9USEQ/Z2td+H9J0XJLoBcM2oc+AgBzazwDMPN3PUvxZUJ1WOlQEnHEObk4ADLE2J5bU8wyc8vjhLn1SyPUDhxZfxhEMSR2kGUgXpHD8EMlSi9UNiM+a+JVcjm5tfDvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131770; c=relaxed/simple;
	bh=Le7tfdz/BqzvTO5+hSEJ4P5GOTdGP2hENy7pMy9QQwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBRh0pCuE/w57xx3nI1o73J9SV9NC6Rwul4s/Z5nQVpYX5xaNWZpjD0fDg959HpFdgL4jMm9MJ+B0MvjYdSfo86U7a04Uz1mOPIX4wVYdA3obCF9hsQkSDa/O5Ih070CI87ys1BOVr997WlDNirgYBFM88KjsmzsKMsS7w40k8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Bx3+uyDg1mn7MiAA--.14089S3;
	Wed, 03 Apr 2024 16:09:22 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxbs2xDg1mI01yAA--.22105S3;
	Wed, 03 Apr 2024 16:09:21 +0800 (CST)
Message-ID: <e6122e3f-d221-4d95-a6b8-92e67aa51a5a@loongson.cn>
Date: Wed, 3 Apr 2024 16:09:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add
 multi-channel supports for loongson
To: Serge Semin <fancer.lancer@gmail.com>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
 <eqecwmi3guwda3wloxcttkx2xlteupvrsetb5ro5abupwhxqyu@ypliwpyswy23>
 <e1c7b5fa-f3f8-4aa3-af4d-ca72b54d9c8c@loongson.cn>
 <f9c5c697-6c3f-4cfb-aa60-2031b450a470@loongson.cn>
 <roxfse6rf7ngnopn42f6la2ewzsaonjbrfokqjlumrpkobfvgh@7v7vblqi3mak>
 <e57a6501-c9ae-4fed-8b8f-b05f0d50e118@loongson.cn>
 <tr65rdtph43gtccnwymjfkaoumzuwc574cbzxfh2q3ipoip2eo@rzzrwtbp5m6v>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <tr65rdtph43gtccnwymjfkaoumzuwc574cbzxfh2q3ipoip2eo@rzzrwtbp5m6v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxbs2xDg1mI01yAA--.22105S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1xWw1kGFWrWFy3CryrKrX_yoW8Gr17pr
	ZxAFZrtryrXr13WFWDGw43uFn8JrWDGr1jgw43C34fZr4DArnruF1kK3y0krZ7GrWqka15
	GF4rKFWDA3W5KFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU


在 2024/3/23 02:47, Serge Semin 写道:
> +static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
> +					   struct plat_stmmacenet_data *plat,
> +					   struct stmmac_resources *res)
> +{
> +	int i, ret, vecs;
> +
> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> +	 * --------- ----- -------- --------  ...  -------- --------
> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> +	 */
> +	vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
> +	ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
> +		return ret;
> +	} else if (ret >= vecs) {
> +		for (i = 0; i < plat->rx_queues_to_use; i++) {
> +			res->rx_irq[CHANNELS_NUM - 1 - i] =
> +				pci_irq_vector(pdev, 1 + i * 2);
> +		}
> +		for (i = 0; i < plat->tx_queues_to_use; i++) {
> +			res->tx_irq[CHANNELS_NUM - 1 - i] =
> +				pci_irq_vector(pdev, 2 + i * 2);
> +		}
> +
> +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +	}
> +
> +	res->irq = pci_irq_vector(pdev, 0);
> +
> +	return 0;
> +}
>
> Thus in case if for some reason you were able to allocate less MSI
> IRQs than required you'll still be able to use them. The legacy IRQ
> will be also available in case if MSI failed to be allocated.

Great, we will consider doing this in the future, but at this stage, we 
don't want to add too much complexity.


Thanks,

Yanteng


