Return-Path: <netdev+bounces-109629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76919293C7
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403381F21D96
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C16A33A;
	Sat,  6 Jul 2024 13:31:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4863626AC2
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720272712; cv=none; b=Y2joSI0tkO/Ph1GPgkEb7FbW4YU4A5ADhRmQTsIa3IwDSr0EldxusUW5q54CHFLUcAn1K/HxQVZAbFgcjXX0C9Nn8eVLUjjxH2OKjjwNOdqM8P6Dt0T6MkIEIm6G5CDW58bsj3wAOxeDd/r2c6k1hS41lCe+Jvi9T7+ma4Jtw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720272712; c=relaxed/simple;
	bh=tSWiw4/TAfdsKhjkofslm1BUUKfWRLlbN1sS3s3zCog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdMQ9jpuovMgrRSMydAicTY9L4M7nFZgw6jWPffIjdKuvs4m3Nr/xacxo2KbUHIlSm37Y9/Vm60XcCYG5hVqrF3aiyeNh1MtM/AVlpB4AXjCJLwSLm1KLP6wxfv0YX68IruWF/tApXhvfSrkHppjrYy9ngd8rz5gvAak3m/pbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8AxXPBDR4lm2ZQBAA--.4769S3;
	Sat, 06 Jul 2024 21:31:47 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxMMQ_R4lmfGM9AA--.39789S3;
	Sat, 06 Jul 2024 21:31:44 +0800 (CST)
Message-ID: <16ce72fa-585a-4522-9f8c-a987f1788e67@loongson.cn>
Date: Sat, 6 Jul 2024 21:31:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
 <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
 <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
 <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
 <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>
 <y7uzja4j5jscllaq52fdlcibww7pp5yds4juvdtgob275eek5c@hlqljyd7nlor>
 <d8a15267-8dff-46d9-adb3-dffb5216d539@loongson.cn>
 <qj4ogerklgciopzhqrge27dngmoi7ijui274zlbuz6qozubi7n@itih73kfumhn>
 <c26f0926-7a2e-4634-8004-52a5929cd80a@loongson.cn>
 <3pmtzvpk5mu75forbcro7maegum2dehzkqajwbxyyjhauakapr@j7sovtlzc6c6>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <3pmtzvpk5mu75forbcro7maegum2dehzkqajwbxyyjhauakapr@j7sovtlzc6c6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxMMQ_R4lmfGM9AA--.39789S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKFyfXFWrtw13tw1kWF4UGFX_yoW7Cw15pr
	48Jr1UGryUJr18Jr1UJr1UJryUJr1UJw1UJr18JF1UJr1UJr1jqr1UXF1jgr1DJr48Jr1U
	Jr1UJr1UZr1UJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4cdbUUUUU


在 2024/7/5 19:53, Serge Semin 写道:
>> $: cat /proc/interrupts
>>
>>             CPU0       CPU1
>>   20:       3826      12138   CPUINTC  12  IPI
>>   21:      15242      11791   CPUINTC  11  timer
>>   22:          0          0   PCH PIC   1  acpi
>>   28:          0          0   PCH PIC   7  loongson-alarm
>>   29:          0          0   PCH PIC   8  ls2x-i2c, ls2x-i2c, ls2x-i2c,
>> ls2x-i2c, ls2x-i2c, ls2x-i2c
>>   34:       7456          0   LIOINTC  10  ttyS0
>>   42:       1192          0   PCH PIC  17  0000:00:06.1
>>   43:          0          0   PCH PIC  18  ahci[0000:00:08.0]
>>   44:         40          0   PCH PIC  19  enp0s3f0
>>   45:          0          0   PCH PIC  20  enp0s3f1
>>   46:       1446          0   PCH PIC  21  enp0s3f2
>>   47:      11164          0   PCH PIC  22  xhci-hcd:usb1
>>   48:        338          0   PCH PIC  23  xhci-hcd:usb3
>>   49:          0          0   PCH PIC  24  snd_hda_intel:card0
>> IPI0:       117        132  LoongArch  1  Rescheduling interrupts
>> IPI1:      3713      12007  LoongArch  2  Function call interrupts
>> ERR:          1
>>
>>
> So, what made you thinking that the enp0s3f0, enp0s3f1 and enp0s3f2
> interfaces weren't working? I failed to find any immediate problem in
> the log.
I'm sorry. I made a mistake. It works fine.
>
> The driver registered eight Rx-queues (and likely eight Tx-queues).
> enp0s3f0 and enp0s3f2 links got up. Even the log reported that two
> interfaces have some network access (whatever it meant in your
> boot-script):
>
>> The device(7a03 and 7a13) can access the network.
> Yes, there is only one IRQ registered for each interface. But that's
> what was expected seeing you have a single MAC IRQ detected. The
> main question is: do the network traffic still get to flow in this
> case? Are you able to send/receive data over all the DMA-channels?

Yes, I can. in this case, enp0s3f0/1/2 can access www.sing.com.


Because I did another test. I turn on the checksum.

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 25ddd99ae112..e1cde9e0e530 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -133,8 +133,8 @@ static int loongson_gmac_data(struct pci_dev *pdev,
                 /* Only channel 0 supports checksum,
                  * so turn off checksum to enable multiple channels.
                  */
-               for (i = 1; i < CHANNEL_NUM; i++)
-                       plat->tx_queues_cfg[i].coe_unsupported = 1;
+               // for (i = 1; i < CHANNEL_NUM; i++)
+                       // plat->tx_queues_cfg[i].coe_unsupported = 1;
         } else {
                 plat->tx_queues_to_use = 1;
                 plat->rx_queues_to_use = 1;
@@ -185,8 +185,8 @@ static int loongson_gnet_data(struct pci_dev *pdev,
                 /* Only channel 0 supports checksum,
                  * so turn off checksum to enable multiple channels.
                  */
-               for (i = 1; i < CHANNEL_NUM; i++)
-                       plat->tx_queues_cfg[i].coe_unsupported = 1;
+               // for (i = 1; i < CHANNEL_NUM; i++)
+                       // plat->tx_queues_cfg[i].coe_unsupported = 1;
         } else {
                 plat->tx_queues_to_use = 1;
                 plat->rx_queues_to_use = 1;
@@ -576,11 +576,11 @@ static int loongson_dwmac_probe(struct pci_dev 
*pdev, const struct pci_device_id
         if (ret)
                 goto err_disable_device;

-       if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
-               ret = loongson_dwmac_msi_config(pdev, plat, &res);
-               if (ret)
-                       goto err_disable_device;
-       }
+       // if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
+               // ret = loongson_dwmac_msi_config(pdev, plat, &res);
+               // if (ret)
+                       // goto err_disable_device;
+       // }

         ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
         if (ret)

In this case, enp0s3f0/1/2 cannot access the www.sing.com.

therefore, the network traffic still get to flow, and I can

send/receive data over all the DMA-channels.

If there are any other tests you would like me to do, please let

me know and I will be happy to do them.

Thanks,

Yanteng


