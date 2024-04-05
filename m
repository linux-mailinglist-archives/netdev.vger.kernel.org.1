Return-Path: <netdev+bounces-85165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17DF899A8B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6851F227B6
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63A16133F;
	Fri,  5 Apr 2024 10:17:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88A127447
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312265; cv=none; b=SgU3nt1hdGn30aYU2apNDjOYU+ea8/gwjuJ+wmorFTxGcvVquR4JOzcRdY721TEUJqbTE3NnTpkt+tZ23gC58ZRMvXCPaSM8Z35iJh4P5QhwrtAmB+M6eUsXItIt5DVRY7aBbxK0P8RGsaaqaX9CiSTWdOaNQDKW6Pg0BScet/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312265; c=relaxed/simple;
	bh=TZO+VHzmRFkWhTmoEsko1dLWdWbn2IrpKBz1BOZgWEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQs4hBNHv0AAO87w5y7jRE1JJTelp6H6cdf5SL/E0lZoc57AgzAFdlMItlAJEu+QbS+KWf1vkkGtCShIAfxoif1NYdKdF6tT6XjYiiqSORdCWkxI6gQeH5UMEfYV3XRixl4oz2qaoRcaLr5I0wCQR33IegNOXLd4CXLkBtKp90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8BxGLq8zw9mRoEjAA--.604S3;
	Fri, 05 Apr 2024 18:17:32 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxthG6zw9m58JzAA--.16167S3;
	Fri, 05 Apr 2024 18:17:31 +0800 (CST)
Message-ID: <05c3033f-935c-4ac0-9bc4-2653ce5ced3d@loongson.cn>
Date: Fri, 5 Apr 2024 18:17:30 +0800
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
 <e6122e3f-d221-4d95-a6b8-92e67aa51a5a@loongson.cn>
 <7myfmz72mdp74k3pjtv6gmturdtm7pkghcwpom62hl52eafval@wmbtdwm5kitp>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <7myfmz72mdp74k3pjtv6gmturdtm7pkghcwpom62hl52eafval@wmbtdwm5kitp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxthG6zw9m58JzAA--.16167S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw1kXF1Uur43Zw4rtF15KFX_yoW8tr43pr
	Z3AFW7trW8XryxG3WDXF4fWr15ArWUGr13Wa13G34xZrZ0vrnFkF1kt3yru397CrZ0k3WY
	vF4UKFsxAas8GagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==


在 2024/4/3 20:03, Serge Semin 写道:
> On Wed, Apr 03, 2024 at 04:09:21PM +0800, Yanteng Si wrote:
>> 在 2024/3/23 02:47, Serge Semin 写道:
>>> +static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
>>> +					   struct plat_stmmacenet_data *plat,
>>> +					   struct stmmac_resources *res)
>>> +{
>>> +	int i, ret, vecs;
>>> +
>>> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
>>> +	 * --------- ----- -------- --------  ...  -------- --------
>>> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
>>> +	 */
>>> +	vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
>>> +	ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
>>> +		return ret;
>>> +	} else if (ret >= vecs) {
>>> +		for (i = 0; i < plat->rx_queues_to_use; i++) {
>>> +			res->rx_irq[CHANNELS_NUM - 1 - i] =
>>> +				pci_irq_vector(pdev, 1 + i * 2);
>>> +		}
>>> +		for (i = 0; i < plat->tx_queues_to_use; i++) {
>>> +			res->tx_irq[CHANNELS_NUM - 1 - i] =
>>> +				pci_irq_vector(pdev, 2 + i * 2);
>>> +		}
>>> +
>>> +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>>> +	}
>>> +
>>> +	res->irq = pci_irq_vector(pdev, 0);
>>> +
>>> +	return 0;
>>> +}
>>>
>>> Thus in case if for some reason you were able to allocate less MSI
>>> IRQs than required you'll still be able to use them. The legacy IRQ
>>> will be also available in case if MSI failed to be allocated.
>> Great, we will consider doing this in the future, but at this stage, we
>> don't want to add too much complexity.
> This comment isn't about complexity. Moreover the code in my comment
> is simpler since the function is more coherent and doesn't have the
> redundant dependencies from the node-pointer and the
> loongson_dwmac_config_legacy() function. In addition it provides more
> flexible solution in case if there were less MSI vectors allocated
> then required.

I just tried it, the network card doesn't work, the reason is not clear.

Considering that the overall change is a little big, I want to send the 
current

working state as the patch v9.


However, I will continue to analyze the reasons for the failure and 
submit them

as a separate patch in the future. Is that OK?


Thanks,

Yanteng


