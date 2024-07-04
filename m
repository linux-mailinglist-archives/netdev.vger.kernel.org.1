Return-Path: <netdev+bounces-109160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D42349272CA
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898F01F239E1
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE50C1A256C;
	Thu,  4 Jul 2024 09:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF7224D7
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084688; cv=none; b=s+PIthlcL4SyhEsydvqtQUikE4tYoRxP/7q4Yp6limd0KTQGCe1iDxeJ3x0HFoRyB/28TzN8JVX7w47LurHQM5aaUHLFMWoId5Nmk/Xqd/rtF1rD72NC5UblshN2ZiKUw8fFSycQClGkavfNFqBStvi1xDHO/F2zEDT5dmSClyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084688; c=relaxed/simple;
	bh=zB3hqiGaRZYjMwEic/NGAi+fzFCaldbxgFQ38OIB0yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH+YfhXAiYUnZWLYP/y//1EGT5OOG9pUyusUX8m6hseOiRVL709UhBXTg7fB1HpMGpFUFmv2i+kf9I7pY/sByUX7H5lckZsvPVUdE7rxs7ngFnhAOtWpWqevlHLzdXH0bE3F0MCulRjX++e6sBAx7fGDxAlkDAl41ovIbqIVVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8AxTevNaIZmVeEAAA--.2677S3;
	Thu, 04 Jul 2024 17:18:05 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx68bLaIZm6uI6AA--.5077S3;
	Thu, 04 Jul 2024 17:18:04 +0800 (CST)
Message-ID: <4c0e463f-bb44-44e5-9fc1-d0187e3229fd@loongson.cn>
Date: Thu, 4 Jul 2024 17:18:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 09/15] net: stmmac: dwmac-loongson: Introduce
 PCI device info data
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <817880fd50d623ac84f6a01fc7eb3748864386a8.1716973237.git.siyanteng@loongson.cn>
 <3k5aa676afjee64acvwa4dd4vlhzusjxvktwfzrvqzh7xahd5a@am6cxil2i5kw>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <3k5aa676afjee64acvwa4dd4vlhzusjxvktwfzrvqzh7xahd5a@am6cxil2i5kw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx68bLaIZm6uI6AA--.5077S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFWkuw4UuFW3uw15try3Jrc_yoW8JFykpa
	98ua1xAF9rJ343C3s3ZF4qqF1IyFn5A34YvrWrKa47Grn8GrnrWay7Ka98ZayDJrykt342
	qayUK397A3Z0krXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==


在 2024/7/2 17:18, Serge Semin 写道:
> On Wed, May 29, 2024 at 06:19:48PM +0800, Yanteng Si wrote:
>> Just introduce PCI device info data to prepare for later
>> ACPI-base support. Loongson machines may use UEFI (implies
>> ACPI) or PMON/UBOOT (implies FDT) as the BIOS.
>>
>> The BIOS type has no relationship with device types, which
>> means: machines can be either ACPI-based or FDT-based.
> AFAICS the commit log is misleading because the DT-less (ACPI-based)
> setups is being added in the next commit and it's implemented by using
> the if-else statement with no setup() callback infrastructure
> utilized.
>
> But this change is still needed for adding the Loongson GNET support
> later in the series. The setup() callback will be pre-initialized with
> the network controller specific method based on the PCIe Device ID. So
> to speak, please alter the commit log with the correct justification.
> Like this:
>
> "The Loongson GNET device support is about to be added in one of the
> next commits. As another preparation for that introduce the PCI device
> info data with a setup() callback performing the device-specific
> platform data initializations. Currently it is utilized for the
> already supported Loongson GMAC device only."
>
Ok, Thanks!


Thanks,

Yanteng


