Return-Path: <netdev+bounces-85196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254BA899BB0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B8FB24BEF
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B9816C44D;
	Fri,  5 Apr 2024 11:14:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A114F9D3
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315643; cv=none; b=C9SSLcoflZQeuWp2M2azF0YJ4Nl4ib6VOvGudOZg8450Jhs0qZng/+mnsELmWQSATy05quaEN2Ub9DKe/hBKi9IFqMYrPe6iqNx/FLhrUGwrDCtW6Tobv7ayNapbziVcg1RYkIzG+oo3Okaww1NUfs0uX2g+N7x0Ypx1RK3Zu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315643; c=relaxed/simple;
	bh=49yOLvI7lOSv5U/xdRmIUsLYtFVEBYukZysO+ceNj5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqndnSj0zoUkotX5BaHO7bZ/fS7v97wJ8e5yi2LlGcN72vszq+M4M7YvxPmqom4ISZIPiL8TLzinqWS9gSfgC4ygRGwv0RboeyTK7/b71XQaHTlaWVh4MM7aqBs+OGaX/hQbuYHXRRjT4V/oSOTvcC/owaV7rokiXTg02oUNn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8CxF+j03A9mboUjAA--.61726S3;
	Fri, 05 Apr 2024 19:13:56 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxbs3w3A9me8dzAA--.24654S3;
	Fri, 05 Apr 2024 19:13:52 +0800 (CST)
Message-ID: <f3a1ae88-2817-4c60-b281-336aedf18384@loongson.cn>
Date: Fri, 5 Apr 2024 19:13:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 02/11] net: stmmac: dwmac-loongson: Refactor
 code for loongson_dwmac_probe()
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <6a66fdf816665c9d91c4611f47ffe3108b9bd39a.1706601050.git.siyanteng@loongson.cn>
 <uvar72vvibm44tgn3trr52mpvrjgnn4ttbmyt2mouwws7pkywq@qcyrmj25c4su>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <uvar72vvibm44tgn3trr52mpvrjgnn4ttbmyt2mouwws7pkywq@qcyrmj25c4su>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxbs3w3A9me8dzAA--.24654S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKF1xuF43CFWrAr4UZr4kKrX_yoWxZF45pa
	93C3ZxKrWxtr1Ika1kZr4UZFyYyrWYk343urWxK3s2ga4qkryvqFyIgrWjkF97ArWku3WI
	vF1jkr48uF1DtFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=

Hi Serge,


Sorry, I seem to have forgotten to reply to the comments on this patch.

在 2024/2/5 22:43, Serge Semin 写道:
> On Tue, Jan 30, 2024 at 04:43:22PM +0800, Yanteng Si wrote:
>> The driver function is not changed, but the code location is
>> adjusted to prepare for adding more loongson drivers.
> Having the word "refactoring" in the subject is always suspicious
> because submitters very often try to hind behind it many small
> changes they didn't want to/didn't know how to unpin from a more bulky
> change. Moreover if there is no detailed explanation what is done and
> why, it raises too many review questions and makes the reviewers life
> much harder. So it would have been much better for us if you split up
> this change into the smaller patches (see my last comment for a
> presumable subset of the patches) to simplify the review process and
> improve the driver bisectability especially seeing there actually are
> functional changes introduced here despite of what is said in the
> commit log.
OK. I will resplit it.
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 61 +++++++++++++------
>>   1 file changed, 42 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 9e40c28d453a..e2dcb339b8b0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -9,7 +9,12 @@
>>   #include <linux/of_irq.h>
>>   #include "stmmac.h"
>>   
>> -static int loongson_default_data(struct plat_stmmacenet_data *plat)
>> +struct stmmac_pci_info {
>> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>> +};
>> +
>> +static void loongson_default_data(struct pci_dev *pdev,
>> +				  struct plat_stmmacenet_data *plat)
>>   {
>>   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>>   	plat->has_gmac = 1;
>> @@ -34,23 +39,37 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>>   
>>   	/* Disable RX queues routing by default */
>>   	plat->rx_queues_cfg[0].pkt_route = 0x0;
>> +}
>> +
>> +static int loongson_gmac_data(struct pci_dev *pdev,
>> +			      struct plat_stmmacenet_data *plat)
>> +{
>> +	loongson_default_data(pdev, plat);
>> +
>> +	plat->multicast_filter_bins = 256;
> Why do you need to move this here from the function tail?
OK, restore it.
>
>> +
>> +	plat->mdio_bus_data->phy_mask = 0;
> This is already zero. Why do you need this?
OK, drop it.
>
>>   
>> -	/* Default to phy auto-detection */
> What is wrong with this comment?
Sorry, restore it.
>
>>   	plat->phy_addr = -1;
>>   
>>   	plat->dma_cfg->pbl = 32;
>>   	plat->dma_cfg->pblx8 = true;
>>   
>> -	plat->multicast_filter_bins = 256;
>>   	return 0;
>>   }
>>   
>> -static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +static struct stmmac_pci_info loongson_gmac_pci_info = {
>> +	.setup = loongson_gmac_data,
>> +};
>> +
>> +static int loongson_dwmac_probe(struct pci_dev *pdev,
>> +				const struct pci_device_id *id)
>>   {
>> +	int ret, i, bus_id, phy_mode;
>>   	struct plat_stmmacenet_data *plat;
>> +	struct stmmac_pci_info *info;
>>   	struct stmmac_resources res;
>>   	struct device_node *np;
>> -	int ret, i, phy_mode;
> Reverse xmas tree order please.
OK.
>
>>   
>>   	np = dev_of_node(&pdev->dev);
>>   
>> @@ -69,18 +88,17 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	if (!plat->mdio_bus_data)
>>   		return -ENOMEM;
>>   
>> +	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
>> +				     GFP_KERNEL);
>> +	if (!plat->dma_cfg)
>> +		return -ENOMEM;
>> +
> Why do you need this moved above the mdio_node getting procedure? They
> seem independent.
Sorry, restore it.
>
>>   	plat->mdio_node = of_get_child_by_name(np, "mdio");
>>   	if (plat->mdio_node) {
>>   		dev_info(&pdev->dev, "Found MDIO subnode\n");
>>   		plat->mdio_bus_data->needs_reset = true;
>>   	}
>>   
>> -	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
>> -	if (!plat->dma_cfg) {
>> -		ret = -ENOMEM;
>> -		goto err_put_node;
>> -	}
>> -
>>   	/* Enable pci device */
>>   	ret = pci_enable_device(pdev);
>>   	if (ret) {
>> @@ -98,9 +116,16 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   		break;
>>   	}
>>   
>> -	plat->bus_id = of_alias_get_id(np, "ethernet");
>> -	if (plat->bus_id < 0)
>> -		plat->bus_id = pci_dev_id(pdev);
> This is a functional change because further bus_id is no longer
> initialized by the pci_dev_id() method as a fallback case. If you are
> sure this is required please unpin to a separate patch and explain.
Hmm, I will merge it into  [PATCH net-next 03/11] .
>
>> +	pci_set_master(pdev);
>> +
>> +	info = (struct stmmac_pci_info *)id->driver_data;
>> +	ret = info->setup(pdev, plat);
>> +	if (ret)
>> +		goto err_disable_device;
>> +
>> +	bus_id = of_alias_get_id(np, "ethernet");
>> +	if (bus_id >= 0)
>> +		plat->bus_id = bus_id;
>>   
>>   	phy_mode = device_get_phy_mode(&pdev->dev);
>>   	if (phy_mode < 0) {
>> @@ -110,11 +135,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	}
>>   
>>   	plat->phy_interface = phy_mode;
>> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
> This is just dropped. Are you sure that the driver will work correctly
Yes, We only need to set phy_interface.
> after this change is applied? Russell already asked you about this change
> here:
> https://lore.kernel.org/netdev/ZZPnaziDZEcv5GGw@shell.armlinux.org.uk/
>
> Anyway please unpin it to a separate patch and explain.
OK.
>
>>   
>> -	pci_set_master(pdev);
>> -
>> -	loongson_default_data(plat);
>>   	pci_enable_msi(pdev);
>>   	memset(&res, 0, sizeof(res));
>>   	res.addr = pcim_iomap_table(pdev)[0];
>> @@ -212,8 +233,10 @@ static int __maybe_unused loongson_dwmac_resume(struct device *dev)
>>   static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>>   			 loongson_dwmac_resume);
>>   
>> +#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>> +
>>   static const struct pci_device_id loongson_dwmac_id_table[] = {
>> -	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
>> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> If I were you and needed to preserve all the changes I would have
> split the patch up into the next patches:
> 1. Use PCI_DEVICE_DATA() macro for device identification
> 2. Drop mac-interface initialization
> 3. Don't initialize MDIO bus ID with PCIe device ID
> 4. Introduce device-specific setup callback

OK, I will.


Thanks,

Yanteng



