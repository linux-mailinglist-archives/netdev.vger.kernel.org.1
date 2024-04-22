Return-Path: <netdev+bounces-90074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3558ACA67
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB618B211BF
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048513E3E5;
	Mon, 22 Apr 2024 10:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2342B56452
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781060; cv=none; b=K1UE7sxnhBb40pR41cvNGJ50jvJfHRhwA8eUGpgT24phqcYIbe39ieVQA8YZuDKFDq2nf8D+CM2cfu/vXp0hPtRRaoPv7EFM0yqxDAxdCn93SUZxeH7zF0ejnM8+J7+u0VZJd+vOfgSbngboZqoPUGdp4gGMq0w1fKhIwV38TvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781060; c=relaxed/simple;
	bh=umlnba0C2TDoEPymjKm0fR+gjnADNaKh1UaG9HzAnrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEHyMt72n+W0Mxw84P96ij95lq4cZBuYSZ3iElSwjqJtv4Jt11kcmXDQbtF0+IKiEromYcrvq9b0p3x1TGUXjXaRjCBNnsK+AXR995fk84/8xM3gjbzQbBVDlEsAEAY6K9Z3kK81IIP9lfee/jpnsBZuOD7IVcOCa1gsZjCV9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8BxFvA_OSZmDsEAAA--.4259S3;
	Mon, 22 Apr 2024 18:17:35 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxTN48OSZmbz0BAA--.5514S3;
	Mon, 22 Apr 2024 18:17:33 +0800 (CST)
Message-ID: <0b918781-05bc-4d79-8d5d-52692e773706@loongson.cn>
Date: Mon, 22 Apr 2024 18:17:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 4/6] net: stmmac: dwmac-loongson: Introduce
 GMAC setup
To: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com
Cc: Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <6f0ac42c1b60db318b7d746254a9b310dd03aa32.1712917541.git.siyanteng@loongson.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <6f0ac42c1b60db318b7d746254a9b310dd03aa32.1712917541.git.siyanteng@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxTN48OSZmbz0BAA--.5514S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gry5uF4xKw13Ww1rtFyxWFX_yoWfuFbE9r
	W8X3WkW345Awn7tw4UW34xArZrWrW7XF4fCrn2qr4ktw1rC3sxWrWv9wnFgw4UWa15JFna
	yr1DWanxAw1q9osvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Hi all

在 2024/4/12 19:28, Yanteng Si 写道:
> @@ -42,6 +45,12 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>   	plat->dma_cfg->pblx8 = true;
>   
>   	plat->multicast_filter_bins = 256;
> +	plat->clk_ref_rate = 125000000;
> +	plat->clk_ptp_rate = 125000000;
> +

> +	plat->tx_queues_to_use = 1;
> +	plat->rx_queues_to_use = 1;

Sorry, I forgot to delete them.


This part of the code has been moved to loongson_dwmac_probe() in this 
patch set, Why?


Because we have two different gnet devices: the 2k2000 supports multiple 
channels,

the 7a2000 only supports single channels, and all GMAC devices only 
support single channels.


If we keep this part of the code here, we will get GMAC_VERSION again in 
gnet_data()

  to distinguish them, which will make the code more complex. We can use 
GMAC_VERSION

in probe to distinguish them easily.


  so the patch will be redesigned in v12.


Thanks,

Yanteng


