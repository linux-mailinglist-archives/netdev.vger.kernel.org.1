Return-Path: <netdev+bounces-109165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C992731B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8358DB2241A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD261AB535;
	Thu,  4 Jul 2024 09:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A45171A7
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085548; cv=none; b=ja5m759E4o3vpXsiGXlLcHihiomUms+F+a/rTmowhUHrJUs6pkpcNBDzzleoNUy4jBcfdQ1AR34Qep7KNRH2UGBAQo7VOi/csgMeWFhjtS3qu9ah5K3eBHvQMGZKuupCAEVR4Pdi2eBO64a+1LiYvnR0pTunO8GHM0cGFjRvIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085548; c=relaxed/simple;
	bh=+KJrw2uVVohWtr1jzVvmdI3TTSiQZzgjnMhs5jqRhFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qq/A332qC4GMNgZMOFFpGkG0nAS4N5uzOMnk1RAh85JTovE37/X2fTLHwgzkgotUVjepU/Xmfr9EcBNhPnX607dSWogPyrn7NzAMmjQcaK/1r7214btWlNBNn0ugOu4wfsWEBDCDlRU0FB58EicsiZGOuSqZy4A23ol18yryBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8Bx7vAobIZmR+IAAA--.3015S3;
	Thu, 04 Jul 2024 17:32:24 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnscmbIZmXuY6AA--.6180S3;
	Thu, 04 Jul 2024 17:32:23 +0800 (CST)
Message-ID: <0aa9bb3e-f81c-4677-8872-e01cb6522881@loongson.cn>
Date: Thu, 4 Jul 2024 17:32:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 13/15] net: stmmac: dwmac-loongson: Drop
 pci_enable/disable_msi temporarily
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <2c5e376641ac8e791245815aa9e81fbc163dfb5a.1716973237.git.siyanteng@loongson.cn>
 <zniayk52akd6dfbfoga7f6m6ubdmteijkr2luubccmqiflhuya@x2cfleoodqlh>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <zniayk52akd6dfbfoga7f6m6ubdmteijkr2luubccmqiflhuya@x2cfleoodqlh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnscmbIZmXuY6AA--.6180S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWfurW3JFy5Xw4fGw18Xrc_yoW8ZrWUp3
	yFv3s3Kr1DZFyI9anIvr4DJa48ZF1jqrWkGrWkK3Wjk3sxZw1xtF1xKFW5ZFyIvw4kW3Wa
	qFZ7XF1kC3yDuFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU28nYUUUUU


在 2024/7/1 09:17, Serge Semin 写道:
>> [PATCH net-next v13 13/15] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi temporarily
> You don't drop the methods call "temporarily" but forever. So fix
> the subject like this please:
> [PATCH net-next v13 13/15] net: stmmac: dwmac-loongson: Drop pci_enable_msi/disable_msi methods call
>
> I understand that you meant that the MSI IRQs support will be
> added later in framework of another commit and for the multi-channel
> device case. But mentioning that in a way you did makes the commit log
> more confusing than better explaining the change.
>
> On Wed, May 29, 2024 at 06:21:08PM +0800, Yanteng Si wrote:
>> The LS2K2000 patch added later will alloc vectors, so let's
>> remove pci_enable/disable_msi temporarily to prepare for later
>> calls to pci_alloc_irq_vectors/pci_free_irq_vectors. This does
>> not affect the work of gmac devices, as they actually use intx.
> As I mentioned in v12 AFAICS the MSI IRQs haven't been utilized on the
> Loongseon GMAC devices so far since the IRQ numbers have been retrieved
> directly from device DT-node. That's what you should have mentioned in
> the log. Like this:
> "The Loongson GMAC driver currently doesn't utilize the MSI IRQs, but
> retrieves the IRQs specified in the device DT-node. Let's drop the
> direct pci_enable_msi()/pci_disable_msi() calls then as redundant."
>
> If what I said was correct and MSIs enable wasn't required for the
> platform IRQs to work, then please use the log and move this patch to
> being submitted between
> [PATCH net-next v13 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
> and
> [PATCH net-next v13 05/15] net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification
>
> so the redundant pci_enable_msi()/pci_disable_msi() code wouldn't be
> getting on a way of the subsequent preparation changes.

Ok, Thanks!


Thanks,

Yanteng


