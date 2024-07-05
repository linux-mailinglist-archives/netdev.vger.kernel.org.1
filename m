Return-Path: <netdev+bounces-109450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423BB9287F5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B931C2269A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9A149C50;
	Fri,  5 Jul 2024 11:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AEE148FF3
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178977; cv=none; b=JC+d4XyeskpY0PzTn0yZ7+kj/eIcfylM94cJNvFQzHFIC+XFMTGobHVuwDcqHZVqIFl5KKiDPYLVpBgrz8AeBZdvP7IcwAZ+qishC7EH/Lw3QzvvqTkhcdoujdJ0JxkSzJX6mawr4kH7G2rJCBX2BzR89BtOE5YHPU0tSmmA0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178977; c=relaxed/simple;
	bh=hYg8z7A28psuDsIWDECxTnRx6lPTWI5XTfsy2sie4jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4e+dPA6dZ/lAE5ARBxR75q92nDUVD4/I8FCcRIT7U9FQ/EnXpCuMh/S1qlIWoSNfLrk6NAxFpGtYNjMZqLfWcvvMBk0SmnUEwFsRU08BRF5mMIAsMMhV2ez0Bk9Ez7qsZhX8YcTvYe5PHyalFPuF//VtnJp3SjeVd6lzIYJcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8Ax0PEY2YdmZkgBAA--.4310S3;
	Fri, 05 Jul 2024 19:29:28 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxusYU2YdmVlI8AA--.9212S3;
	Fri, 05 Jul 2024 19:29:24 +0800 (CST)
Message-ID: <c26f0926-7a2e-4634-8004-52a5929cd80a@loongson.cn>
Date: Fri, 5 Jul 2024 19:29:23 +0800
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
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
 <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
 <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
 <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
 <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>
 <y7uzja4j5jscllaq52fdlcibww7pp5yds4juvdtgob275eek5c@hlqljyd7nlor>
 <d8a15267-8dff-46d9-adb3-dffb5216d539@loongson.cn>
 <qj4ogerklgciopzhqrge27dngmoi7ijui274zlbuz6qozubi7n@itih73kfumhn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <qj4ogerklgciopzhqrge27dngmoi7ijui274zlbuz6qozubi7n@itih73kfumhn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxusYU2YdmVlI8AA--.9212S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoWDJFWfWryfCrWkXr1DAF43urX_yoW7KFWxKo
	WkGw4kZr4rGr1UCr1rG347Ar45Ja43GFnrtr18CFnrJrs3Ar4DJ34Dtr93A39IyF18CF1U
	J34Dtw4DGa4xXFn7l-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=


在 2024/7/5 18:59, Serge Semin 写道:
> On Fri, Jul 05, 2024 at 06:45:50PM +0800, Yanteng Si wrote:
>> 在 2024/7/5 18:16, Serge Semin 写道:
>>>>> Seeing the discussion has started anyway, could you please find out
>>>>> whether the multi-channel controller will still work if the MSI IRQs
>>>>> allocation failed? Will the multi-channel-ness still work in that
>>>>> case?
>>>> Based on my test results:
>>>>
>>>> In this case, multi-channel controller don't work. If the MSI IRQs
>>>> allocation
>>>>
>>>> failed, NIC will work in single channel.
>>> What does "NIC will work in single channel" mean? Do the driver
>>> (network traffic flow with a normal performance) still work even with
>>> the plat->tx_queues_to_use and plat->rx_queues_to_use fields set to
>>> eight? If it's then the multi-channel-ness still seems to be working
>>> but the IRQs are delivered via the common MAC IRQ. If you get to
>>> experience the data loss, or poor performance, or no traffic flowing
>>> at all, then indeed the non-zero channels IRQs aren't delivered.
>>>
>>> So the main question how did you find out that the controller work in
>>> single channel?
>> sorry, I meant that if the MSI allocation failed, it will fallback to INTx,
>> in which case
>>
>> only the single channel works.  if the MSI allocation failed, the
>> multi-channel-ness
>>
>> don't work.
> Could you please clarify what are the symptoms by which you figured
> out that the "multi-channel-ness" didn't work?
>
> Suppose you have an LS2K2000 SoC-based device, the
> plat->tx_queues_to_use and plat->rx_queues_to_use to eight and the
> loongson_dwmac_msi_config() function call is omitted. What is
> happening with the activated network interface and with the traffic
> flow then?

Ok, here are the results of my test in LS2K2000:


v14 based.

$: git diff

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 25ddd99ae112..f05b600a19cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
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


boot on LS2K2000.

dmesg:

[    0.000000] Linux version 6.10.0-rc5+ (siyanteng@kernelserver) 
(loongarch64-unknown-linux-gnu-gcc (GCC) 14.0.0 20231116 (experimental), 
GNU ld (GNU Binutils) 2.41.50.20231116) #56 SMP PREEMPT_DYNAMIC Fri Jul  
5 19:06:53 CST 2024
[    0.000000] 64-bit Loongson Processor probed (LA364 Core)
[    0.000000] CPU0 revision is: 0014b000 (Loongson-64bit)
[    0.000000] FPU0 revision is: 00000001
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: ACPI 2.0=0xf9c40000 SMBIOS 3.0=0xfdf20000 
INITRD=0xf9b60118 MEMRESERVE=0xf9b60198 MEMMAP=0xf3de0018
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000F9C40000 000024 (v02 LOONGS)
[    0.000000] ACPI: XSDT 0x00000000F9C30000 000064 (v01 LOONGS LOONGSON 
00000002      01000013)
[    0.000000] ACPI: FACP 0x00000000F9C00000 0000F4 (v03 LOONGS LOONGSON 
00000002 LIUX 01000013)
[    0.000000] ACPI: DSDT 0x00000000F9BD0000 001CE6 (v02 LOONGS LOONGSON 
00000002 INTL 20200925)
[    0.000000] ACPI: FACS 0x00000000F9C10000 000040
[    0.000000] ACPI: APIC 0x00000000F9C20000 0000A0 (v06 LOONGS LOONGSON 
00000002 LIUX 01000013)
[    0.000000] ACPI: IVRS 0x00000000F9BF0000 00004C (v01 LARCH LOONGSON 
00000001 LIUX 00000001)
[    0.000000] ACPI: MCFG 0x00000000F9BE0000 00003C (v01 LOONGS LOONGSON 
00000001 LIUX 01000013)
[    0.000000] ACPI: SRAT 0x00000000F9BC0000 0000A0 (v02 LOONGS LOONGSON 
00000002 LIUX 01000013)
[    0.000000] ACPI: SLIT 0x00000000F9BB0000 00002D (v01 LOONGS LOONGSON 
00000002 LIUX 01000013)
[    0.000000] ACPI: VIAT 0x00000000F9BA0000 00002C (v01 LOONGS LOONGSON 
00000002 LIUX 01000013)
[    0.000000] ACPI: PPTT 0x00000000F9B90000 0000D8 (v03 LOONGS LOONGSON 
00000002 LIUX 01000013)
[    0.000000] SRAT: PXM 0 -> CPU 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> CPU 0x01 -> Node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0fffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x90000000-0x26fffffff]
[    0.000000] Node0: mem_type:2, mem_start:0x200000, mem_size:0x2b30000 
Bytes
[    0.000000]        start_pfn:0x80, end_pfn:0xb4c, num_physpages:0xacc
[    0.000000] Node0: mem_type:7, mem_start:0x2d30000, 
mem_size:0xc0d0000 Bytes
[    0.000000]        start_pfn:0xb4c, end_pfn:0x3b80, num_physpages:0x3b00
[    0.000000] Resvd: mem_type:6, mem_start:0x10000000, 
mem_size:0x10000000 Bytes
[    0.000000] Node0: mem_type:7, mem_start:0x90100000, 
mem_size:0x2ffc0000 Bytes
[    0.000000]        start_pfn:0x24040, end_pfn:0x30030, 
num_physpages:0xfaf0
[    0.000000] Node0: mem_type:4, mem_start:0xc00c0000, 
mem_size:0x2b0000 Bytes
[    0.000000]        start_pfn:0x30030, end_pfn:0x300dc, 
num_physpages:0xfb9c
[    0.000000] Node0: mem_type:7, mem_start:0xc0370000, 
mem_size:0x33a70000 Bytes
[    0.000000]        start_pfn:0x300dc, end_pfn:0x3cf78, 
num_physpages:0x1ca38
[    0.000000] Node0: mem_type:9, mem_start:0xf3de0000, mem_size:0x10000 
Bytes
[    0.000000]        start_pfn:0x3cf78, end_pfn:0x3cf7c, 
num_physpages:0x1ca3c
[    0.000000] Resvd: mem_type:9, mem_start:0xf3de0000, mem_size:0x10000 
Bytes
[    0.000000] Node0: mem_type:2, mem_start:0xf3df0000, 
mem_size:0x840000 Bytes
[    0.000000]        start_pfn:0x3cf7c, end_pfn:0x3d18c, 
num_physpages:0x1cc4c
[    0.000000] Node0: mem_type:1, mem_start:0xf4630000, 
mem_size:0x2b40000 Bytes
[    0.000000]        start_pfn:0x3d18c, end_pfn:0x3dc5c, 
num_physpages:0x1d71c
[    0.000000] Node0: mem_type:2, mem_start:0xf7170000, 
mem_size:0x29f1000 Bytes
[    0.000000]        start_pfn:0x3dc5c, end_pfn:0x3e6d8, 
num_physpages:0x1e198
[    0.000000] Node0: mem_type:7, mem_start:0xf9b61000, mem_size:0x4000 
Bytes
[    0.000000]        start_pfn:0x3e6d8, end_pfn:0x3e6d9, 
num_physpages:0x1e199
[    0.000000] Node0: mem_type:2, mem_start:0xf9b65000, mem_size:0x2000 
Bytes
[    0.000000]        start_pfn:0x3e6d9, end_pfn:0x3e6d9, 
num_physpages:0x1e199
[    0.000000] Node0: mem_type:1, mem_start:0xf9b67000, mem_size:0x29000 
Bytes
[    0.000000]        start_pfn:0x3e6d9, end_pfn:0x3e6e4, 
num_physpages:0x1e1a3
[    0.000000] Node0: mem_type:9, mem_start:0xf9b90000, mem_size:0x80000 
Bytes
[    0.000000]        start_pfn:0x3e6e4, end_pfn:0x3e704, 
num_physpages:0x1e1c3
[    0.000000] Resvd: mem_type:9, mem_start:0xf9b90000, mem_size:0x80000 
Bytes
[    0.000000] Node0: mem_type:9, mem_start:0xf9c20000, mem_size:0x30000 
Bytes
[    0.000000]        start_pfn:0x3e708, end_pfn:0x3e714, 
num_physpages:0x1e1cf
[    0.000000] Resvd: mem_type:9, mem_start:0xf9c20000, mem_size:0x30000 
Bytes
[    0.000000] Node0: mem_type:7, mem_start:0xf9c50000, 
mem_size:0x102d000 Bytes
[    0.000000]        start_pfn:0x3e714, end_pfn:0x3eb1f, 
num_physpages:0x1e5da
[    0.000000] Node0: mem_type:4, mem_start:0xfac7d000, mem_size:0xe2000 
Bytes
[    0.000000]        start_pfn:0x3eb1f, end_pfn:0x3eb57, 
num_physpages:0x1e612
[    0.000000] Node0: mem_type:7, mem_start:0xfad5f000, 
mem_size:0x1b3000 Bytes
[    0.000000]        start_pfn:0x3eb57, end_pfn:0x3ebc4, 
num_physpages:0x1e67e
[    0.000000] Node0: mem_type:4, mem_start:0xfaf12000, 
mem_size:0x1d3e000 Bytes
[    0.000000]        start_pfn:0x3ebc4, end_pfn:0x3f314, 
num_physpages:0x1edcd
[    0.000000] Node0: mem_type:7, mem_start:0xfcc50000, 
mem_size:0x507000 Bytes
[    0.000000]        start_pfn:0x3f314, end_pfn:0x3f455, 
num_physpages:0x1ef0e
[    0.000000] Node0: mem_type:3, mem_start:0xfd157000, 
mem_size:0x9f9000 Bytes
[    0.000000]        start_pfn:0x3f455, end_pfn:0x3f6d4, 
num_physpages:0x1f18c
[    0.000000] Resvd: mem_type:5, mem_start:0xfdb50000, 
mem_size:0x1c0000 Bytes
[    0.000000] Resvd: mem_type:6, mem_start:0xfdd10000, 
mem_size:0x400000 Bytes
[    0.000000] Node0: mem_type:7, mem_start:0xfe110000, mem_size:0x21000 
Bytes
[    0.000000]        start_pfn:0x3f844, end_pfn:0x3f84c, 
num_physpages:0x1f194
[    0.000000] Node0: mem_type:4, mem_start:0xfe131000, mem_size:0x21000 
Bytes
[    0.000000]        start_pfn:0x3f84c, end_pfn:0x3f854, 
num_physpages:0x1f19c
[    0.000000] Node0: mem_type:3, mem_start:0xfe152000, mem_size:0x39000 
Bytes
[    0.000000]        start_pfn:0x3f854, end_pfn:0x3f862, 
num_physpages:0x1f1aa
[    0.000000] Node0: mem_type:4, mem_start:0xfe18b000, 
mem_size:0xe51000 Bytes
[    0.000000]        start_pfn:0x3f862, end_pfn:0x3fbf7, 
num_physpages:0x1f53e
[    0.000000] Node0: mem_type:3, mem_start:0xfefdc000, mem_size:0x22000 
Bytes
[    0.000000]        start_pfn:0x3fbf7, end_pfn:0x3fbff, 
num_physpages:0x1f546
[    0.000000] Node0: mem_type:4, mem_start:0xfeffe000, mem_size:0x2000 
Bytes
[    0.000000]        start_pfn:0x3fbff, end_pfn:0x3fc00, 
num_physpages:0x1f546
[    0.000000] Node0: mem_type:7, mem_start:0xff000000, 
mem_size:0x16e200000 Bytes
[    0.000000]        start_pfn:0x3fc00, end_pfn:0x9b480, 
num_physpages:0x7adc6
[    0.000000] Node0: mem_type:1, mem_start:0x26d200000, 
mem_size:0x2e00000 Bytes
[    0.000000]        start_pfn:0x9b480, end_pfn:0x9c000, 
num_physpages:0x7b946
[    0.000000] Resvd: mem_type:0, mem_start:0xee00000, 
mem_size:0x1200000 Bytes
[    0.000000] Resvd: mem_type:0, mem_start:0x90000000, 
mem_size:0x100000 Bytes
[    0.000000] Node0's addrspace_offset is 0x0
[    0.000000] Node0: start_pfn=0x80, end_pfn=0x9c000
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: Loongson 
Loongson-2K2000-7A2000-1w-V0.1-EVB/Loongson-2K2000-7A2000-1w-EVB-V1.21, 
BIOS Loongson-UDK2018-V4.0.05692-stable202402
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] CpuClock = 1400000000
[    0.000000] The BIOS Version: Loongson-UDK2018-V4.0.05692-stable202402
[    0.000000] software IO TLB: area num 2.
[    0.000000] software IO TLB: mapped [mem 
0x0000000006610000-0x000000000a610000] (64MB)
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x05840000-0x05843fff]
[    0.000000] Detected 2 available CPU(s)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000200000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000026fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x000000000edfffff]
[    0.000000]   node   0: [mem 0x0000000090100000-0x00000000f9c0ffff]
[    0.000000]   node   0: [mem 0x00000000f9c20000-0x00000000fdb4ffff]
[    0.000000]   node   0: [mem 0x00000000fe110000-0x000000026fffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000200000-0x000000026fffffff]
[    0.000000] On node 0, zone DMA32: 128 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 33984 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 4 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 368 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 16384 pages in unavailable ranges
[    0.000000] percpu: Embedded 6 pages/cpu s47056 r8192 d43056 u16777216
[    0.000000] pcpu-alloc: s47056 r8192 d43056 u16777216 alloc=1*33554432
[    0.000000] pcpu-alloc: [0] 0 1
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.x 
root=UUID=1ecbf33b-86de-4870-9171-9019c5ed78b3 rw console=ttyS0,115200
[    0.000000] Unknown kernel command line parameters 
"BOOT_IMAGE=/boot/vmlinuz-5.x", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 1048576 (order: 9, 
8388608 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 8, 4194304 
bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 506188
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] Memory: 7900832K/8099008K available (20736K kernel code, 
12889K rwdata, 8548K rodata, 640K init, 1231K bss, 198176K reserved, 0K 
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Dynamic Preempt: full
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to 
nr_cpu_ids=2.
[    0.000000]     Trampoline variant of Tasks RCU enabled.
[    0.000000]     Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] RCU Tasks: Setting shift to 1 and lim to 1 
rcu_task_cb_adjust=1.
[    0.000000] RCU Tasks Trace: Setting shift to 1 and lim to 1 
rcu_task_cb_adjust=1.
[    0.000000] NR_IRQS: 576, nr_irqs: 576, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.000000] Constant clock event device register
[    0.000000] clocksource: Constant: mask: 0xffffffffffffffff 
max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000000] sched_clock: 64 bits at 100MHz, resolution 10ns, wraps 
every 4398046511100ns
[    0.000004] Constant clock source device register
[    0.000116] Console: colour dummy device 80x25
[    0.000158] ACPI: Core revision 20240322
[    0.000247] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.000257] pid_max: default: 32768 minimum: 301
[    0.000292] LSM: initializing lsm=capability,yama
[    0.000301] Yama: becoming mindful.
[    0.000385] Mount-cache hash table entries: 16384 (order: 3, 131072 
bytes, linear)
[    0.000429] Mountpoint-cache hash table entries: 16384 (order: 3, 
131072 bytes, linear)
[    0.001283] rcu: Hierarchical SRCU implementation.
[    0.001286] rcu:     Max phase no-delay instances is 1000.
[    0.001488] smp: Bringing up secondary CPUs ...
[    0.001653] Booting CPU#1...
[    0.001694] 64-bit Loongson Processor probed (LA364 Core)
[    0.001698] CPU1 revision is: 0014b000 (Loongson-64bit)
[    0.001702] FPU1 revision is: 00000001
[    0.001715] CPU#1 finished
[    0.001767] smp: Brought up 1 node, 2 CPUs
[    0.002149] devtmpfs: initialized
[    0.002872] Performance counters: loongarch/loongson64 PMU enabled, 4 
64-bit counters available to each CPU.
[    0.003024] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.003032] futex hash table entries: 512 (order: 1, 32768 bytes, linear)
[    0.003106] pinctrl core: initialized pinctrl subsystem
[    0.003439] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.003695] audit: initializing netlink subsys (disabled)
[    0.003756] audit: type=2000 audit(0.004:1): state=initialized 
audit_enabled=0 res=1
[    0.003930] thermal_sys: Registered thermal governor 'step_wise'
[    0.004038] hw-breakpoint: Found 4 breakpoint and 2 watchpoint registers.
[    0.004449] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.004453] HugeTLB: 112 KiB vmemmap can be freed for a 32.0 MiB page
[    0.004612] Demotion targets for Node 0: null
[    0.072010] raid6: lsx      gen()  4185 MB/s
[    0.140013] raid6: int64x8  gen()  1725 MB/s
[    0.207998] raid6: int64x4  gen()  2148 MB/s
[    0.276039] raid6: int64x2  gen()  1888 MB/s
[    0.343992] raid6: int64x1  gen()  1643 MB/s
[    0.343994] raid6: using algorithm lsx gen() 4185 MB/s
[    0.412000] raid6: .... xor() 2449 MB/s, rmw enabled
[    0.412002] raid6: using lsx recovery algorithm
[    0.412098] ACPI: Added _OSI(Module Device)
[    0.412101] ACPI: Added _OSI(Processor Device)
[    0.412103] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.412106] ACPI: Added _OSI(Processor Aggregator Device)
[    0.414353] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.419490] ACPI Error: Could not enable GlobalLock event 
(20240322/evxfevnt-182)
[    0.419497] ACPI Warning: Could not enable fixed event - GlobalLock 
(1) (20240322/evxface-618)
[    0.419503] ACPI Error: No response from Global Lock hardware, 
disabling lock (20240322/evglock-59)
[    0.419906] ACPI: Interpreter enabled
[    0.419939] ACPI: PM: (supports S0 S3 S4 S5)
[    0.419941] ACPI: Using LPIC for interrupt routing
[    0.419960] ACPI: MCFG table detected, 1 entries
[    0.420518] ACPI: \_SB_.PCI0.PCIB.XHCI.PUBS: New power resource
[    0.424401] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.424413] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    0.424417] acpi PNP0A08:00: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    0.424426] acpi PNP0A08:00: _OSC: platform retains control of PCIe 
features (AE_NOT_FOUND)
[    0.424431] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 
0xfe00000000-0xfe0fffffff] for [bus 00-ff] with loongson_pci_ecam_ops
[    0.425509] acpi PNP0A08:00: ECAM at [mem 0xfe00000000-0xfe1fffffff] 
for [bus 00-ff]
[    0.425534] ACPI: Remapped I/O 0x0000000018000000 to [io 
0x0000-0xffff window]
[    0.425694] PCI host bridge to bus 0000:00
[    0.425698] pci_bus 0000:00: root bus resource [io 0x0000-0xffff window]
[    0.425703] pci_bus 0000:00: root bus resource [mem 
0x40000000-0x7fffffff window]
[    0.425706] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.425735] pci 0000:00:03.0: [0014:7a13] type 00 class 0x020000 
conventional PCI endpoint
[    0.425746] pci 0000:00:03.0: BAR 0 [mem 0x51290000-0x51297fff 64bit]
[    0.425899] pci 0000:00:03.1: [0014:7a13] type 00 class 0x020000 
conventional PCI endpoint
[    0.425908] pci 0000:00:03.1: BAR 0 [mem 0x51298000-0x5129ffff 64bit]
[    0.426034] pci 0000:00:03.2: [0014:7a03] type 00 class 0x020000 
conventional PCI endpoint
[    0.426042] pci 0000:00:03.2: BAR 0 [mem 0x512a0000-0x512a7fff 64bit]
[    0.426054] pci 0000:00:03.2: ROM [mem 0xfffff800-0xffffffff pref]
[    0.426121] pci 0000:00:04.0: [0014:7a44] type 00 class 0x0c0330 
conventional PCI endpoint
[    0.426129] pci 0000:00:04.0: BAR 0 [mem 0x51000000-0x510fffff 64bit]
[    0.426243] pci 0000:00:05.0: [0014:7a54] type 00 class 0x0c0380 
conventional PCI endpoint
[    0.426252] pci 0000:00:05.0: BAR 0 [mem 0x51200000-0x5123ffff 64bit]
[    0.426368] pci 0000:00:06.0: [0014:7a25] type 00 class 0x040000 
conventional PCI endpoint
[    0.426377] pci 0000:00:06.0: BAR 0 [mem 0x512a9000-0x512a90ff 64bit]
[    0.426383] pci 0000:00:06.0: BAR 2 [mem 0x40000000-0x4fffffff 64bit]
[    0.426388] pci 0000:00:06.0: BAR 4 [mem 0x51240000-0x5124ffff 64bit]
[    0.426449] pci 0000:00:06.1: [0014:7a36] type 00 class 0x030000 
conventional PCI endpoint
[    0.426457] pci 0000:00:06.1: BAR 0 [mem 0x51250000-0x5125ffff 64bit]
[    0.426462] pci 0000:00:06.1: BAR 2 [mem 0x512b4000-0x512b40ff]
[    0.426531] pci 0000:00:06.2: [0014:7a37] type 00 class 0x040300 
conventional PCI endpoint
[    0.426539] pci 0000:00:06.2: BAR 0 [mem 0x51260000-0x5126ffff 64bit]
[    0.426609] pci 0000:00:06.3: [0014:7a16] type 00 class 0x048000 
conventional PCI endpoint
[    0.426618] pci 0000:00:06.3: BAR 0 [mem 0x512a8000-0x512a81ff 64bit]
[    0.426685] pci 0000:00:07.0: [0014:7a07] type 00 class 0x040300 
conventional PCI endpoint
[    0.426694] pci 0000:00:07.0: BAR 0 [mem 0x51270000-0x5127ffff 64bit]
[    0.426766] pci 0000:00:08.0: [0014:7a18] type 00 class 0x010601 
conventional PCI endpoint
[    0.426781] pci 0000:00:08.0: BAR 5 [mem 0x512b3000-0x512b33ff]
[    0.426897] pci 0000:00:09.0: [0014:7a49] type 01 class 0x060400 PCIe 
Root Port
[    0.426912] pci 0000:00:09.0: BAR 0 [mem 0x512aa000-0x512aafff 64bit]
[    0.426920] pci 0000:00:09.0: PCI bridge to [bus 01]
[    0.426971] pci 0000:00:09.0: supports D1 D2
[    0.426974] pci 0000:00:09.0: PME# supported from D0 D1 D3hot D3cold
[    0.427076] pci 0000:00:0d.0: [0014:7a49] type 01 class 0x060400 PCIe 
Root Port
[    0.427090] pci 0000:00:0d.0: BAR 0 [mem 0x512ab000-0x512abfff 64bit]
[    0.427098] pci 0000:00:0d.0: PCI bridge to [bus 02]
[    0.427148] pci 0000:00:0d.0: supports D1 D2
[    0.427150] pci 0000:00:0d.0: PME# supported from D0 D1 D3hot D3cold
[    0.427253] pci 0000:00:0f.0: [0014:7a79] type 01 class 0x060400 PCIe 
Root Port
[    0.427267] pci 0000:00:0f.0: BAR 0 [mem 0x512ac000-0x512acfff 64bit]
[    0.427276] pci 0000:00:0f.0: PCI bridge to [bus 03]
[    0.427325] pci 0000:00:0f.0: supports D1 D2
[    0.427328] pci 0000:00:0f.0: PME# supported from D0 D1 D3hot D3cold
[    0.427420] pci 0000:00:16.0: [0014:7a1b] type 00 class 0x088000 
conventional PCI endpoint
[    0.427429] pci 0000:00:16.0: BAR 0 [mem 0x512ad000-0x512adfff 64bit]
[    0.427435] pci 0000:00:16.0: BAR 2 [mem 0x50000000-0x50ffffff 64bit]
[    0.427502] pci 0000:00:19.0: [0014:7a34] type 00 class 0x0c0330 
conventional PCI endpoint
[    0.427511] pci 0000:00:19.0: BAR 0 [mem 0x51100000-0x511fffff 64bit]
[    0.427578] pci 0000:00:1d.0: [0014:7a0e] type 00 class 0x108000 
conventional PCI endpoint
[    0.427586] pci 0000:00:1d.0: BAR 0 [mem 0x512ae000-0x512aefff 64bit]
[    0.427597] pci 0000:00:1d.0: ROM [mem 0xfffff800-0xffffffff pref]
[    0.427656] pci 0000:00:1d.1: [0014:7a1e] type 00 class 0x108000 
conventional PCI endpoint
[    0.427664] pci 0000:00:1d.1: BAR 0 [mem 0x512af000-0x512affff 64bit]
[    0.427675] pci 0000:00:1d.1: ROM [mem 0xfffff800-0xffffffff pref]
[    0.427734] pci 0000:00:1d.2: [0014:7a2e] type 00 class 0x108000 
conventional PCI endpoint
[    0.427742] pci 0000:00:1d.2: BAR 0 [mem 0x512b0000-0x512b0fff 64bit]
[    0.427753] pci 0000:00:1d.2: ROM [mem 0xfffff800-0xffffffff pref]
[    0.427815] pci 0000:00:1d.3: [0014:7a3e] type 00 class 0x108000 
conventional PCI endpoint
[    0.427823] pci 0000:00:1d.3: BAR 0 [mem 0x512b1000-0x512b1fff 64bit]
[    0.427834] pci 0000:00:1d.3: ROM [mem 0xfffff800-0xffffffff pref]
[    0.427895] pci 0000:00:1e.0: [0014:7a2f] type 00 class 0x088000 
conventional PCI endpoint
[    0.427903] pci 0000:00:1e.0: BAR 0 [mem 0x512b2000-0x512b2fff 64bit]
[    0.427914] pci 0000:00:1e.0: ROM [mem 0xfffff800-0xffffffff pref]
[    0.427972] pci 0000:00:1f.0: [0014:7a8e] type 00 class 0x108000 
conventional PCI endpoint
[    0.427981] pci 0000:00:1f.0: BAR 0 [mem 0x51280000-0x5128ffff 64bit]
[    0.427996] pci 0000:00:1f.0: ROM [mem 0xfffff800-0xffffffff pref]
[    0.428189] pci 0000:00:06.0: BAR 2 [mem 0x40000000-0x4fffffff 
64bit]: assigned
[    0.428197] pci 0000:00:16.0: BAR 2 [mem 0x50000000-0x50ffffff 
64bit]: assigned
[    0.428202] pci 0000:00:04.0: BAR 0 [mem 0x51000000-0x510fffff 
64bit]: assigned
[    0.428208] pci 0000:00:19.0: BAR 0 [mem 0x51100000-0x511fffff 
64bit]: assigned
[    0.428213] pci 0000:00:05.0: BAR 0 [mem 0x51200000-0x5123ffff 
64bit]: assigned
[    0.428218] pci 0000:00:06.0: BAR 4 [mem 0x51240000-0x5124ffff 
64bit]: assigned
[    0.428223] pci 0000:00:06.1: BAR 0 [mem 0x51250000-0x5125ffff 
64bit]: assigned
[    0.428229] pci 0000:00:06.2: BAR 0 [mem 0x51260000-0x5126ffff 
64bit]: assigned
[    0.428234] pci 0000:00:07.0: BAR 0 [mem 0x51270000-0x5127ffff 
64bit]: assigned
[    0.428239] pci 0000:00:1f.0: BAR 0 [mem 0x51280000-0x5128ffff 
64bit]: assigned
[    0.428245] pci 0000:00:03.0: BAR 0 [mem 0x51290000-0x51297fff 
64bit]: assigned
[    0.428250] pci 0000:00:03.1: BAR 0 [mem 0x51298000-0x5129ffff 
64bit]: assigned
[    0.428255] pci 0000:00:03.2: BAR 0 [mem 0x512a0000-0x512a7fff 
64bit]: assigned
[    0.428260] pci 0000:00:09.0: BAR 0 [mem 0x512a8000-0x512a8fff 
64bit]: assigned
[    0.428268] pci 0000:00:0d.0: BAR 0 [mem 0x512a9000-0x512a9fff 
64bit]: assigned
[    0.428276] pci 0000:00:0f.0: BAR 0 [mem 0x512aa000-0x512aafff 
64bit]: assigned
[    0.428284] pci 0000:00:16.0: BAR 0 [mem 0x512ab000-0x512abfff 
64bit]: assigned
[    0.428289] pci 0000:00:1d.0: BAR 0 [mem 0x512ac000-0x512acfff 
64bit]: assigned
[    0.428295] pci 0000:00:1d.1: BAR 0 [mem 0x512ad000-0x512adfff 
64bit]: assigned
[    0.428300] pci 0000:00:1d.2: BAR 0 [mem 0x512ae000-0x512aefff 
64bit]: assigned
[    0.428305] pci 0000:00:1d.3: BAR 0 [mem 0x512af000-0x512affff 
64bit]: assigned
[    0.428311] pci 0000:00:1e.0: BAR 0 [mem 0x512b0000-0x512b0fff 
64bit]: assigned
[    0.428316] pci 0000:00:03.2: ROM [mem 0x512b1000-0x512b17ff pref]: 
assigned
[    0.428321] pci 0000:00:1d.0: ROM [mem 0x512b1800-0x512b1fff pref]: 
assigned
[    0.428325] pci 0000:00:1d.1: ROM [mem 0x512b2000-0x512b27ff pref]: 
assigned
[    0.428328] pci 0000:00:1d.2: ROM [mem 0x512b2800-0x512b2fff pref]: 
assigned
[    0.428332] pci 0000:00:1d.3: ROM [mem 0x512b3000-0x512b37ff pref]: 
assigned
[    0.428336] pci 0000:00:1e.0: ROM [mem 0x512b3800-0x512b3fff pref]: 
assigned
[    0.428340] pci 0000:00:1f.0: ROM [mem 0x512b4000-0x512b47ff pref]: 
assigned
[    0.428344] pci 0000:00:08.0: BAR 5 [mem 0x512b4800-0x512b4bff]: assigned
[    0.428349] pci 0000:00:06.3: BAR 0 [mem 0x512b4c00-0x512b4dff 
64bit]: assigned
[    0.428355] pci 0000:00:06.0: BAR 0 [mem 0x512b4e00-0x512b4eff 
64bit]: assigned
[    0.428360] pci 0000:00:06.1: BAR 2 [mem 0x512b4f00-0x512b4fff]: assigned
[    0.428368] pci 0000:00:09.0: PCI bridge to [bus 01]
[    0.428376] pci 0000:00:0d.0: PCI bridge to [bus 02]
[    0.428385] pci 0000:00:0f.0: PCI bridge to [bus 03]
[    0.428898] gpio gpiochip0: Static allocation of GPIO base is 
deprecated, use dynamic allocation.
[    0.429835] iommu: Default domain type: Translated
[    0.429838] iommu: DMA domain TLB invalidation policy: strict mode
[    0.429977] SCSI subsystem initialized
[    0.430072] libata version 3.00 loaded.
[    0.430114] ACPI: bus type USB registered
[    0.430141] usbcore: registered new interface driver usbfs
[    0.430155] usbcore: registered new interface driver hub
[    0.430169] usbcore: registered new device driver usb
[    0.430243] pps_core: LinuxPPS API ver. 1 registered
[    0.430246] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.430251] PTP clock support registered
[    0.430424] efivars: Registered efivars operations
[    0.430557] Advanced Linux Sound Architecture Driver Initialized.
[    0.430901] pci 0000:00:06.1: vgaarb: setting as boot VGA device
[    0.430905] pci 0000:00:06.1: vgaarb: bridge control possible
[    0.430908] pci 0000:00:06.1: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.430922] vgaarb: loaded
[    0.430990] clocksource: Switched to clocksource Constant
[    0.439730] VFS: Disk quotas dquot_6.6.0
[    0.439768] VFS: Dquot-cache hash table entries: 2048 (order 0, 16384 
bytes)
[    0.439895] netfs: FS-Cache loaded
[    0.440018] pnp: PnP ACPI init
[    0.440480] pnp: PnP ACPI: found 5 devices
[    0.443669] NET: Registered PF_INET protocol family
[    0.444034] IP idents hash table entries: 131072 (order: 6, 1048576 
bytes, linear)
[    0.447549] tcp_listen_portaddr_hash hash table entries: 4096 (order: 
2, 65536 bytes, linear)
[    0.447593] Table-perturb hash table entries: 65536 (order: 4, 262144 
bytes, linear)
[    0.447599] TCP established hash table entries: 65536 (order: 5, 
524288 bytes, linear)
[    0.447762] TCP bind hash table entries: 65536 (order: 7, 2097152 
bytes, linear)
[    0.448567] TCP: Hash tables configured (established 65536 bind 65536)
[    0.448848] MPTCP token hash table entries: 8192 (order: 3, 196608 
bytes, linear)
[    0.448906] UDP hash table entries: 4096 (order: 3, 131072 bytes, linear)
[    0.448944] UDP-Lite hash table entries: 4096 (order: 3, 131072 
bytes, linear)
[    0.449070] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.449347] RPC: Registered named UNIX socket transport module.
[    0.449350] RPC: Registered udp transport module.
[    0.449352] RPC: Registered tcp transport module.
[    0.449354] RPC: Registered tcp-with-tls transport module.
[    0.449356] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.449360] NET: Registered PF_XDP protocol family
[    0.449516] PCI: CLS 64 bytes, default 64
[    0.449558] ACPI: bus type thunderbolt registered
[    0.449851] Trying to unpack rootfs image as initramfs...
[    0.455340] Initialise system trusted keyrings
[    0.455464] workingset: timestamp_bits=40 max_order=19 bucket_order=0
[    0.455492] zbud: loaded
[    0.455719] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.455839] NFS: Registering the id_resolver key type
[    0.455851] Key type id_resolver registered
[    0.455853] Key type id_legacy registered
[    0.455864] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.455870] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver 
Registering...
[    0.456125] SGI XFS with ACLs, security attributes, quota, no debug 
enabled
[    0.456299] 9p: Installing v9fs 9p2000 file system support
[    0.456395] xor: measuring software checksum speed
[    0.457876]    8regs           :  6668 MB/sec
[    0.459630]    8regs_prefetch  :  5730 MB/sec
[    0.461108]    32regs          :  6673 MB/sec
[    0.462826]    32regs_prefetch :  5734 MB/sec
[    0.464011]    lsx             :  8430 MB/sec
[    0.464016] xor: using function: lsx (8430 MB/sec)
[    0.464025] Key type asymmetric registered
[    0.464028] Asymmetric key parser 'x509' registered
[    0.696811] Freeing initrd memory: 8384K
[    0.703131] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 249)
[    0.703202] io scheduler mq-deadline registered
[    0.703206] io scheduler kyber registered
[    0.703225] io scheduler bfq registered
[    0.706820] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.707043] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.707976] ACPI: button: Power Button [PWRF]
[    0.708071] Warning: Processor Platform Limit event detected, but not 
handled.
[    0.708074] Consider compiling CPUfreq support into your kernel.
[    0.709585] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
[    0.709711] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq = 34, base_baud = 
6250000) is a ST16650
[    0.709729] printk: legacy console [ttyS0] enabled
[    3.122634] 00:01: ttyS1 at MMIO 0x10080000 (irq = 35, base_baud = 
3125000) is a ST16650
[    3.130855] 00:02: ttyS2 at MMIO 0x10080100 (irq = 35, base_baud = 
3125000) is a ST16650
[    3.139065] 00:03: ttyS3 at MMIO 0x10080200 (irq = 35, base_baud = 
3125000) is a ST16650
[    3.147277] 00:04: ttyS4 at MMIO 0x10080300 (irq = 35, base_baud = 
3125000) is a ST16650
[    3.156772] ACPI: bus type drm_connector registered
[    3.161768] loongson 0000:00:06.1: Found LS7A2000 bridge chipset, 
revision: 16
[    3.169011] loongson 0000:00:06.1: [drm] dc: 400MHz, gmc: 800MHz, 
gpu: 533MHz
[    3.176116] loongson 0000:00:06.1: [drm] Dedicated vram start: 
0x40000000, size: 256MiB
[    3.184263] loongson 0000:00:06.1: [drm] VRAM: 16384 pages ready
[    3.190238] loongson 0000:00:06.1: [drm] GTT: 32768 pages ready
[    3.196202] loongson 0000:00:06.1: [drm] lsdc-i2c0(sda pin mask=1, 
scl pin mask=2) created
[    3.204457] loongson 0000:00:06.1: [drm] lsdc-i2c1(sda pin mask=4, 
scl pin mask=8) created
[    3.212683] loongson 0000:00:06.1: [drm] display pipe-0 has HDMI 
and/or VGA
[    3.219609] loongson 0000:00:06.1: [drm] display pipe-1 has HDMI
[    3.225692] loongson 0000:00:06.1: [drm] Total 2 outputs
[    3.271100] loongson 0000:00:06.1: [drm] registered irq: 42
[    3.276958] [drm] Initialized loongson 1.0.0 20220701 for 
0000:00:06.1 on minor 0
[    3.393066] loongson 0000:00:06.1: [drm] *ERROR* Setting HDMI-1 PLL 
failed
[    3.488719] Console: switching to colour frame buffer device 128x48
[    3.547883] loongson 0000:00:06.1: [drm] fb0: loongsondrmfb frame 
buffer device
[    3.562239] brd: module loaded
[    3.567569] loop: module loaded
[    3.570914] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 
EST 2006)
[    3.578272] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 
2006)
[    3.585249] megasas: 07.727.03.00-rc1
[    3.588930] mpt3sas version 48.100.00.00 loaded
[    3.613177] ahci 0000:00:08.0: version 3.0
[    3.613235] ahci 0000:00:08.0: SSS flag set, parallel bus scan disabled
[    3.619836] ahci 0000:00:08.0: AHCI vers 0001.0300, 32 command slots, 
6 Gbps, SATA mode
[    3.627819] ahci 0000:00:08.0: 2/2 ports implemented (port mask 0x3)
[    3.634137] ahci 0000:00:08.0: flags: 64bit ncq sntf stag pm led clo 
only pmp pio slum part ccc apst
[    3.643751] scsi host0: ahci
[    3.646803] scsi host1: ahci
[    3.649743] ata1: SATA max UDMA/133 abar m1024@0x512b4800 port 
0x512b4900 irq 43 lpm-pol 0
[    3.657969] ata2: SATA max UDMA/133 abar m1024@0x512b4800 port 
0x512b4980 irq 43 lpm-pol 0
[    3.667006] e1000: Intel(R) PRO/1000 Network Driver
[    3.671856] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    3.677585] e1000e: Intel(R) PRO/1000 Network Driver
[    3.682518] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.688423] igb: Intel(R) Gigabit Ethernet Network Driver
[    3.693789] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.699343] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    3.705398] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    3.711438] dwmac-loongson-pci 0000:00:03.0: User ID: 0xd1, Synopsys 
ID: 0x10
[    3.718543] dwmac-loongson-pci 0000:00:03.0: DMA HW capability 
register supported
[    3.725993] dwmac-loongson-pci 0000:00:03.0: RX Checksum Offload 
Engine supported
[    3.733439] dwmac-loongson-pci 0000:00:03.0: COE Type 2
[    3.738635] dwmac-loongson-pci 0000:00:03.0: TX Checksum insertion 
supported
[    3.745641] dwmac-loongson-pci 0000:00:03.0: Wake-Up On Lan supported
[    3.752045] dwmac-loongson-pci 0000:00:03.0: Enhanced/Alternate 
descriptors
[    3.758968] dwmac-loongson-pci 0000:00:03.0: Enabled extended descriptors
[    3.765715] dwmac-loongson-pci 0000:00:03.0: Ring mode enabled
[    3.771517] dwmac-loongson-pci 0000:00:03.0: Enable RX Mitigation via 
HW Watchdog Timer
[    3.779480] dwmac-loongson-pci 0000:00:03.0: device MAC address 
aa:ee:21:fb:67:ac
[    3.789812] mdio_bus stmmac-18:02: attached PHY driver [unbound] 
(mii_bus:phy_addr=stmmac-18:02, irq=POLL)
[    3.800170] dwmac-loongson-pci 0000:00:03.1: User ID: 0xd1, Synopsys 
ID: 0x10
[    3.807296] dwmac-loongson-pci 0000:00:03.1: DMA HW capability 
register supported
[    3.814741] dwmac-loongson-pci 0000:00:03.1: RX Checksum Offload 
Engine supported
[    3.822191] dwmac-loongson-pci 0000:00:03.1: COE Type 2
[    3.827392] dwmac-loongson-pci 0000:00:03.1: TX Checksum insertion 
supported
[    3.834404] dwmac-loongson-pci 0000:00:03.1: Wake-Up On Lan supported
[    3.840814] dwmac-loongson-pci 0000:00:03.1: Enhanced/Alternate 
descriptors
[    3.847735] dwmac-loongson-pci 0000:00:03.1: Enabled extended descriptors
[    3.854487] dwmac-loongson-pci 0000:00:03.1: Ring mode enabled
[    3.860283] dwmac-loongson-pci 0000:00:03.1: Enable RX Mitigation via 
HW Watchdog Timer
[    3.868244] dwmac-loongson-pci 0000:00:03.1: device MAC address 
5e:ee:cb:23:62:f9
[    3.878410] mdio_bus stmmac-19:02: attached PHY driver [unbound] 
(mii_bus:phy_addr=stmmac-19:02, irq=POLL)
[    3.888777] dwmac-loongson-pci 0000:00:03.2: User ID: 0xd1, Synopsys 
ID: 0x10
[    3.895894] dwmac-loongson-pci 0000:00:03.2: DMA HW capability 
register supported
[    3.903355] dwmac-loongson-pci 0000:00:03.2: RX Checksum Offload 
Engine supported
[    3.910803] dwmac-loongson-pci 0000:00:03.2: COE Type 2
[    3.916008] dwmac-loongson-pci 0000:00:03.2: TX Checksum insertion 
supported
[    3.923027] dwmac-loongson-pci 0000:00:03.2: Wake-Up On Lan supported
[    3.929452] dwmac-loongson-pci 0000:00:03.2: Enhanced/Alternate 
descriptors
[    3.936382] dwmac-loongson-pci 0000:00:03.2: Enabled extended descriptors
[    3.943138] dwmac-loongson-pci 0000:00:03.2: Ring mode enabled
[    3.948940] dwmac-loongson-pci 0000:00:03.2: Enable RX Mitigation via 
HW Watchdog Timer
[    3.956915] dwmac-loongson-pci 0000:00:03.2: device MAC address 
2e:38:a1:7d:5e:af
[    3.974895] YT8531 Gigabit Ethernet stmmac-1a:00: attached PHY driver 
(mii_bus:phy_addr=stmmac-1a:00, irq=POLL)
[    3.984956] ata1: SATA link down (SStatus 0 SControl 300)
[    3.991260] xhci_hcd 0000:00:04.0: xHCI Host Controller
[    3.996529] xhci_hcd 0000:00:04.0: new USB bus registered, assigned 
bus number 1
[    4.004015] xhci_hcd 0000:00:04.0: USB3 root hub has no ports
[    4.009737] xhci_hcd 0000:00:04.0: hcc params 0x0230fe65 hci version 
0x110 quirks 0x0000000000000010
[    4.018968] xhci_hcd 0000:00:04.0: xHCI Host Controller
[    4.024241] xhci_hcd 0000:00:04.0: new USB bus registered, assigned 
bus number 2
[    4.031619] xhci_hcd 0000:00:04.0: Host supports USB 3.0 SuperSpeed
[    4.037912] usb usb1: string descriptor 0 read error: -22
[    4.043502] hub 1-0:1.0: USB hub found
[    4.047242] hub 1-0:1.0: 4 ports detected
[    4.051761] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    4.059839] usb usb2: string descriptor 0 read error: -22
[    4.065378] hub 2-0:1.0: USB hub found
[    4.069121] hub 2-0:1.0: config failed, hub doesn't have any ports! 
(err -19)
[    4.076403] xhci_hcd 0000:00:19.0: xHCI Host Controller
[    4.081715] xhci_hcd 0000:00:19.0: new USB bus registered, assigned 
bus number 3
[    4.089187] xhci_hcd 0000:00:19.0: hcc params 0x0238fe6d hci version 
0x110 quirks 0x0000000000000010
[    4.098406] xhci_hcd 0000:00:19.0: xHCI Host Controller
[    4.103666] xhci_hcd 0000:00:19.0: new USB bus registered, assigned 
bus number 4
[    4.111031] xhci_hcd 0000:00:19.0: Host supports USB 3.0 SuperSpeed
[    4.117298] usb usb3: string descriptor 0 read error: -22
[    4.122831] hub 3-0:1.0: USB hub found
[    4.126573] hub 3-0:1.0: 4 ports detected
[    4.130756] usb usb4: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    4.138833] usb usb4: string descriptor 0 read error: -22
[    4.144357] hub 4-0:1.0: USB hub found
[    4.148095] hub 4-0:1.0: 4 ports detected
[    4.152337] usbcore: registered new interface driver usb-storage
[    4.158349] i8042: PNP: No PS/2 controller found.
[    4.163155] mousedev: PS/2 mouse device common for all mice
[    4.171054] rtc-efi rtc-efi.0: registered as rtc0
[    4.176193] rtc-efi rtc-efi.0: setting system clock to 
2024-07-05T11:17:45 UTC (1720178265)
[    4.187282] loongson-rtc LOON0001:00: registered as rtc1
[    4.192591] i2c_dev: i2c /dev entries driver
[    4.199616] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
initialised: dm-devel@lists.linux.dev
[    4.208469] hid: raw HID events driver (C) Jiri Kosina
[    4.213617] usbcore: registered new interface driver usbhid
[    4.219158] usbhid: USB HID core driver
[    4.223261] snd_hda_intel 0000:00:06.2: Force to snoop mode by module 
option
[    4.230390] snd_hda_intel 0000:00:07.0: Force to snoop mode by module 
option
[    4.237601] Initializing XFRM netlink socket
[    4.241883] NET: Registered PF_INET6 protocol family
[    4.247402] Segment Routing with IPv6
[    4.248772] input: HDA Loongson HDMI/DP,pcm=3 as 
/devices/pci0000:00/0000:00:06.2/sound/card0/input1
[    4.251063] In-situ OAM (IOAM) with IPv6
[    4.260527] input: HDA Loongson HDMI/DP,pcm=7 as 
/devices/pci0000:00/0000:00:06.2/sound/card0/input2
[    4.264067] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.279247] NET: Registered PF_PACKET protocol family
[    4.284274] NET: Registered PF_KEY protocol family
[    4.289199] NET: Registered PF_RDS protocol family
[    4.293979] 9pnet: Installing 9P2000 support
[    4.298250] Key type dns_resolver registered
[    4.308694] Timer migration: 1 hierarchy levels; 8 children per 
group; 1 crossnode level
[    4.316790] registered taskstats version 1
[    4.320908] Loading compiled-in X.509 certificates
[    4.323001] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    4.332207] Demotion targets for Node 0: null
[    4.337195] Btrfs loaded, zoned=yes, fsverity=no
[    4.338508] snd_hda_intel 0000:00:07.0: CORB reset timeout#2, CORBRP 
= 65535
[    4.348834] ata2: SATA link down (SStatus 0 SControl 300)
[    4.348854] hdaudio hdaudioC1D0: no AFG or MFG node found
[    4.359682] hdaudio hdaudioC1D1: no AFG or MFG node found
[    4.365065] hdaudio hdaudioC1D2: no AFG or MFG node found
[    4.370452] hdaudio hdaudioC1D3: no AFG or MFG node found
[    4.375835] snd_hda_intel 0000:00:07.0: no codecs initialized
[    4.395001] usb 3-1: new low-speed USB device number 2 using xhci_hcd
[    4.495445] usb 1-2: string descriptor 0 read error: -22
[    4.507691] usb-storage 1-2:1.0: USB Mass Storage device detected
[    4.527001] scsi host2: usb-storage 1-2:1.0
[    4.571348] usb 3-1: string descriptor 0 read error: -22
[    4.602284] input: HID 0c45:760b as 
/devices/pci0000:00/0000:00:19.0/usb3/3-1/3-1:1.0/0003:0C45:760B.0001/input/input3
[    4.670996] usb 1-4: new low-speed USB device number 3 using xhci_hcd
[    4.677658] hid-generic 0003:0C45:760B.0001: input,hidraw0: USB HID 
v1.11 Keyboard [HID 0c45:760b] on usb-0000:00:19.0-1/input0
[    4.689374] clk: Disabling unused clocks
[    4.693078] input: HID 0c45:760b Consumer Control as 
/devices/pci0000:00/0000:00:19.0/usb3/3-1/3-1:1.1/0003:0C45:760B.0002/input/input4
[    4.693309] ALSA device list:
[    4.708323]   #0: HDA Loongson at 0x51260000 irq 49
[    4.713363] Freeing unused kernel image (initmem) memory: 640K
[    4.719162] This architecture does not have kernel memory protection.
[    4.725571] Run /init as init process
[    4.729211]   with arguments:
[    4.729214]     /init
[    4.729216]   with environment:
[    4.729219]     HOME=/
[    4.729221]     TERM=linux
[    4.729223]     BOOT_IMAGE=/boot/vmlinuz-5.x
[    4.765047] input: HID 0c45:760b System Control as 
/devices/pci0000:00/0000:00:19.0/usb3/3-1/3-1:1.1/0003:0C45:760B.0002/input/input5
[    4.777419] hid-generic 0003:0C45:760B.0002: input,hidraw1: USB HID 
v1.11 Device [HID 0c45:760b] on usb-0000:00:19.0-1/input1
[    4.837150] usb 1-4: string descriptor 0 read error: -22
[    4.873736] input: HID 10c4:8105 as 
/devices/pci0000:00/0000:00:04.0/usb1/1-4/1-4:1.0/0003:10C4:8105.0003/input/input6
[    4.885086] hid-generic 0003:10C4:8105.0003: input,hidraw2: USB HID 
v1.11 Mouse [HID 10c4:8105] on usb-0000:00:04.0-4/input0
[    5.575938] scsi 2:0:0:0: Direct-Access     SanDisk  USB Flash Drive  
1.00 PQ: 0 ANSI: 6
[    5.584592] scsi 2:0:0:0: Attached scsi generic sg0 type 0
[    5.599073] sd 2:0:0:0: [sda] 120127488 512-byte logical blocks: 
(61.5 GB/57.3 GiB)
[    5.613043] sd 2:0:0:0: [sda] Write Protect is off
[    5.617810] sd 2:0:0:0: [sda] Mode Sense: 43 00 00 00
[    5.626557] sd 2:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.655313]  sda: sda1 sda2
[    5.659180] sd 2:0:0:0: [sda] Attached SCSI removable disk
[    6.918950] EXT4-fs (sda2): mounted filesystem 
1ecbf33b-86de-4870-9171-9019c5ed78b3 r/w with ordered data mode. Quota 
mode: none.
[   10.047571] systemd[1]: systemd 253.5-2-arch running in system mode 
(+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS 
+OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD 
+LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT 
default-hierarchy=unified)
[   10.079758] systemd[1]: Detected architecture loongarch64.
[   10.191099] systemd[1]: Hostname set to <archlinux>.
[   10.443126] systemd[1]: bpf-lsm: BPF LSM hook not enabled in the 
kernel, BPF LSM not supported
[   10.971483] systemd[1]: Queued start job for default target Graphical 
Interface.
[   11.020663] systemd[1]: Created slice Slice /system/getty.
[   11.043651] systemd[1]: Created slice Slice /system/modprobe.
[   11.067600] systemd[1]: Created slice Slice /system/serial-getty.
[   11.091488] systemd[1]: Created slice User and Session Slice.
[   11.115141] systemd[1]: Started Dispatch Password Requests to Console 
Directory Watch.
[   11.143103] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[   11.167330] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[   11.195087] systemd[1]: Reached target Local Encrypted Volumes.
[   11.219062] systemd[1]: Reached target Local Integrity Protected Volumes.
[   11.243059] systemd[1]: Reached target Path Units.
[   11.255000] random: crng init done
[   11.263067] systemd[1]: Reached target Remote File Systems.
[   11.283162] systemd[1]: Reached target Slice Units.
[   11.303153] systemd[1]: Reached target Swaps.
[   11.323169] systemd[1]: Reached target Local Verity Protected Volumes.
[   11.347228] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   11.385279] systemd[1]: Listening on Process Core Dump Socket.
[   11.407251] systemd[1]: Listening on Journal Socket (/dev/log).
[   11.431233] systemd[1]: Listening on Journal Socket.
[   11.456311] systemd[1]: Listening on udev Control Socket.
[   11.479198] systemd[1]: Listening on udev Kernel Socket.
[   11.519136] systemd[1]: Mounting Huge Pages File System...
[   11.540734] systemd[1]: Mounting POSIX Message Queue File System...
[   11.564711] systemd[1]: Mounting Kernel Debug File System...
[   11.587218] systemd[1]: Kernel Trace File System was skipped because 
of an unmet condition check (ConditionPathExists=/sys/kernel/tracing).
[   11.627137] systemd[1]: Mounting Temporary Directory /tmp...
[   11.649000] systemd[1]: Starting Create List of Static Device Nodes...
[   11.687203] systemd[1]: Starting Load Kernel Module configfs...
[   11.708917] systemd[1]: Starting Load Kernel Module dm_mod...
[   11.751239] systemd[1]: Starting Load Kernel Module drm...
[   11.772925] systemd[1]: Starting Load Kernel Module fuse...
[   11.798154] fuse: init (API version 7.40)
[   11.811252] systemd[1]: Starting Load Kernel Module loop...
[   11.831221] systemd[1]: File System Check on Root Device was skipped 
because of an unmet condition check (ConditionPathIsReadWrite=!/).
[   11.846403] systemd[1]: Starting Journal Service...
[   11.873566] systemd[1]: Load Kernel Modules was skipped because no 
trigger condition checks were met.
[   11.882959] systemd[1]: TPM2 PCR Machine ID Measurement was skipped 
because of an unmet condition check 
(ConditionPathExists=/sys/firmware/efi/efivars/StubPcrKernelImage-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f).
[   11.903720] systemd-journald[200]: Collecting audit messages is disabled.
[   11.915397] systemd[1]: Starting Remount Root and Kernel File Systems...
[   11.932929] systemd[1]: Starting Apply Kernel Variables...
[   11.956991] systemd[1]: Starting Coldplug All udev Devices...
[   11.963448] EXT4-fs (sda2): re-mounted 
1ecbf33b-86de-4870-9171-9019c5ed78b3 r/w. Quota mode: none.
[   11.991703] systemd[1]: Mounted Huge Pages File System.
[   12.011460] systemd[1]: Started Journal Service.
[   12.296620] systemd-journald[200]: Received client request to flush 
runtime journal.
[   12.597780] systemd-journald[200]: 
/var/log/journal/7eb17db7fefc4d3b8010606a2401cee5/system.journal: 
Monotonic clock jumped backwards relative to last journal entry, rotating.
[   12.613378] systemd-journald[200]: Rotating system journal.
[   13.356420] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: renamed from eth1
[   13.368678] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: renamed from eth0
[   13.405276] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: renamed from eth2
[   13.544990] loongson-spi-pci 0000:00:16.0: can't derive routing for 
PCI INT A
[   13.552166] loongson-spi-pci 0000:00:16.0: PCI INT A: no GSI
[   13.683351] usbcore: registered new interface driver uas
[   13.740110] pstore: Using crash dump compression: deflate
[   13.745506] pstore: Registered efi_pstore as persistent store backend
[   14.239611] FAT-fs (sda1): Volume was not properly unmounted. Some 
data may be corrupt. Please run fsck.
[   16.257892] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register 
MEM_TYPE_PAGE_POOL RxQ-0
[   16.266096] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register 
MEM_TYPE_PAGE_POOL RxQ-1
[   16.274199] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register 
MEM_TYPE_PAGE_POOL RxQ-2
[   16.282258] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register 
MEM_TYPE_PAGE_POOL RxQ-3
[   16.290336] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register 
MEM_TYPE_PAGE_POOL RxQ-4
[   16.298461] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register 
MEM_TYPE_PAGE_POOL RxQ-5
[   16.306519] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register 
MEM_TYPE_PAGE_POOL RxQ-6
[   16.314567] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register 
MEM_TYPE_PAGE_POOL RxQ-7
[   16.324050] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: PHY 
[stmmac-18:02] driver [Generic PHY] (irq=POLL)
[   16.343589] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: No Safety 
Features support found
[   16.351552] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: IEEE 1588-2008 
Advanced Timestamp supported
[   16.360581] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: registered PTP 
clock
[   16.367439] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: configuring for 
phy/gmii link mode
[   16.382079] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register 
MEM_TYPE_PAGE_POOL RxQ-0
[   16.390170] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register 
MEM_TYPE_PAGE_POOL RxQ-1
[   16.398229] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register 
MEM_TYPE_PAGE_POOL RxQ-2
[   16.406279] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register 
MEM_TYPE_PAGE_POOL RxQ-3
[   16.414351] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register 
MEM_TYPE_PAGE_POOL RxQ-4
[   16.422422] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register 
MEM_TYPE_PAGE_POOL RxQ-5
[   16.430504] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register 
MEM_TYPE_PAGE_POOL RxQ-6
[   16.438555] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register 
MEM_TYPE_PAGE_POOL RxQ-7
[   16.448025] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: PHY 
[stmmac-19:02] driver [Generic PHY] (irq=POLL)
[   16.467550] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: No Safety 
Features support found
[   16.475464] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: IEEE 1588-2008 
Advanced Timestamp supported
[   16.484478] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: registered PTP 
clock
[   16.491354] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: configuring for 
phy/gmii link mode
[   16.506012] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register 
MEM_TYPE_PAGE_POOL RxQ-0
[   16.514105] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register 
MEM_TYPE_PAGE_POOL RxQ-1
[   16.522167] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register 
MEM_TYPE_PAGE_POOL RxQ-2
[   16.530235] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register 
MEM_TYPE_PAGE_POOL RxQ-3
[   16.538288] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register 
MEM_TYPE_PAGE_POOL RxQ-4
[   16.546331] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register 
MEM_TYPE_PAGE_POOL RxQ-5
[   16.554379] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register 
MEM_TYPE_PAGE_POOL RxQ-6
[   16.562424] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register 
MEM_TYPE_PAGE_POOL RxQ-7
[   16.571852] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: PHY 
[stmmac-1a:00] driver [YT8531 Gigabit Ethernet] (irq=POLL)
[   16.582549] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: No Safety 
Features support found
[   16.590745] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: IEEE 1588-2008 
Advanced Timestamp supported
[   16.599830] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: registered PTP 
clock
[   16.607330] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: configuring for 
phy/rgmii-id link mode
[   16.618296] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Link is Up - 
1Gbps/Full - flow control off
[  329.951433] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Link is Down
[  332.832685] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Link is Up - 
1Gbps/Full - flow control off
[  333.855327] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Link is Down
[  336.928480] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Link is Up - 
1Gbps/Full - flow control off
[  349.215440] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Link is Down
[  351.456477] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Link is Up - 
1Gbps/Full - flow control off

The device(7a03 and 7a13) can access the network.

$: cat /proc/interrupts

            CPU0       CPU1
  20:       3826      12138   CPUINTC  12  IPI
  21:      15242      11791   CPUINTC  11  timer
  22:          0          0   PCH PIC   1  acpi
  28:          0          0   PCH PIC   7  loongson-alarm
  29:          0          0   PCH PIC   8  ls2x-i2c, ls2x-i2c, ls2x-i2c, 
ls2x-i2c, ls2x-i2c, ls2x-i2c
  34:       7456          0   LIOINTC  10  ttyS0
  42:       1192          0   PCH PIC  17  0000:00:06.1
  43:          0          0   PCH PIC  18  ahci[0000:00:08.0]
  44:         40          0   PCH PIC  19  enp0s3f0
  45:          0          0   PCH PIC  20  enp0s3f1
  46:       1446          0   PCH PIC  21  enp0s3f2
  47:      11164          0   PCH PIC  22  xhci-hcd:usb1
  48:        338          0   PCH PIC  23  xhci-hcd:usb3
  49:          0          0   PCH PIC  24  snd_hda_intel:card0
IPI0:       117        132  LoongArch  1  Rescheduling interrupts
IPI1:      3713      12007  LoongArch  2  Function call interrupts
ERR:          1



Thanks,

Yanteng


