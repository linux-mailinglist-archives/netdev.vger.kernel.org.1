Return-Path: <netdev+bounces-95953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671418C3E5E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C525BB20A59
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B31487EC;
	Mon, 13 May 2024 09:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B1147C91
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593813; cv=none; b=llDAXASFIM3AliIMbQiyjZiXgEIVbozLzbE7otRtu1zSGCwx04LFqQJ045K+0LhCagvJadU8/lxNDVmztxCYFi/UOwdCEcYmVBAl1Qv2g9CQlRcaXIYHFE131THWTpHFLX50i7SBYZ1FgZ5Cz8WiBf2TkkD7BG/O8C1IKqHLI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593813; c=relaxed/simple;
	bh=gp6HtZCnCU1BerVBgFSc+nd/qlWjR+Lq4BMvI8Z88KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZEVOTYPjN/V678J+k45TAYV2WjfPaGlj69d1TJr9Z6htzw8+uw1qCIZ4rMewi1LjjJkv1pVXHPCxeGbpVbAAmlb6o1vcLwgBwQaL4toESGDkU1LAoaAvJWez2XcSD9Kz9/gBWIdo6rBTbGJRjbAasWSUGh/IagZxWhWoTFMkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8AxTetR4kFmDyEMAA--.23059S3;
	Mon, 13 May 2024 17:50:09 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjldP4kFma8scAA--.46677S3;
	Mon, 13 May 2024 17:50:08 +0800 (CST)
Message-ID: <0dba2790-3885-47eb-85a1-d8b7a1c382ac@loongson.cn>
Date: Mon, 13 May 2024 17:50:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/15] net: stmmac: dwmac-loongson: Use
 PCI_DEVICE_DATA() macro for device identification
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <46cd3872bef7854dbdb3cc41161a65147f4a7e2c.1714046812.git.siyanteng@loongson.cn>
 <xh34h5zd3f4hjjpafsg2i6uzeigxjb7g6zwbybgvkgmydw6ouy@ueeozv6lottf>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <xh34h5zd3f4hjjpafsg2i6uzeigxjb7g6zwbybgvkgmydw6ouy@ueeozv6lottf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxjldP4kFma8scAA--.46677S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruw4DJF18tw4DKw1UGr47KFX_yoW3XFgE9a
	s7ZFs7Ca1DKF1fAws3K3W5Ja4a9FsFk393Kw4jqFs7Xry8JF9rWF1vk34ktF1UXanIkr4S
	9rnxuw1jyw1xAosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6rWOUUUUU=


在 2024/5/3 21:43, Serge Semin 写道:
> On Thu, Apr 25, 2024 at 09:04:36PM +0800, Yanteng Si wrote:
>> Just use PCI_DEVICE_DATA() macro for device identification,
>> No changes to function functionality.
> Some more verbose commit log:
>
> "For the readability sake convert the hard-coded Loongson GMAC PCI ID to
> the respective macro and use the PCI_DEVICE_DATA() macro-function to
> create the pci_device_id array entry. The later change will be
> specifically useful in order to assign the device-specific data for the
> currently supported device and for about to be added Loongson GNET
> controller."
>
> Other than that the change looks good:
>
> Reviewed-by: Serge Semin<fancer.lancer@gmail.com>

OK, Thanks!


Thanks,

Yanteng


