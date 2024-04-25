Return-Path: <netdev+bounces-91229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA28B1C90
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22651F2282B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D4578C96;
	Thu, 25 Apr 2024 08:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8F1859
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032549; cv=none; b=MMwWDn8LNS0KoqFUZsD8pLETJb9mGlzD1TPbzD7vc3LUFg9frOeQNtBUO1EzmQWpPH/+FM3GZ0t25Yq1VN8wNZFVEP088OiLMvbFKUmoX2KDF9Xmd/+F01v53BUieIJAKEDYhnRMxNZ1Mj1ofJlJEgbmr9TqHbJUMN7CBPUU+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032549; c=relaxed/simple;
	bh=AKrx4Dxd0uSxEj+4XyRDYHDI3K5C+EDDvKHbDR96cMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epbBJ1p5W2gkbL94eO3liqEPfA9Faz/SGvWOv7uhebYeO5hxeJR1j73+s0BXUGUaoFjndWQtKpeSB67gMeGcx90uy23SfRaAH8nT4YoheuXaA7Fa7FSKPZgu3rpTGFqV6XlV/qbBbZX/KwW+wldvTVG+wMQilsw9gj5ELQSiEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Bx+umhDypmYLUCAA--.552S3;
	Thu, 25 Apr 2024 16:09:05 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrdyeDypmU+MEAA--.17620S3;
	Thu, 25 Apr 2024 16:09:02 +0800 (CST)
Message-ID: <bc930a7b-6193-495b-90b4-e00d89477767@loongson.cn>
Date: Thu, 25 Apr 2024 16:09:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <9a8e5dfef0e9706e3d42bb20f59ea9ffa264dc8c.1712917541.git.siyanteng@loongson.cn>
 <CAAhV-H76DNwB5mrzTYZ=oo=NXHamUZa18g5Skst7i9bC5pnbWA@mail.gmail.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <CAAhV-H76DNwB5mrzTYZ=oo=NXHamUZa18g5Skst7i9bC5pnbWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxrdyeDypmU+MEAA--.17620S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrXr15Xw13tF43Aw1UCw1fXwc_yoWxWrc_Za
	42kr18Jr1rJF1xCw1YgrnxAFZxXryjy3WrCF92kryku3ZaqF4rur4rAr17Xay7Gwn7Ar98
	Xwn3tw4fArWxWosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU


在 2024/4/24 21:37, Huacai Chen 写道:
>> +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>> +{
>> +       struct stmmac_priv *priv = apriv;
>> +       struct stmmac_resources res;
>> +       struct mac_device_info *mac;
>> +       struct stmmac_dma_ops *dma;
>> +       struct pci_dev *pdev;
>> +       u32 loongson_gmac;
>> +
>> +       memset(&res, 0, sizeof(res));
>> +       pdev = to_pci_dev(priv->device);
>> +       res.addr = pcim_iomap_table(pdev)[0];
>> +       loongson_gmac = readl(res.addr + GMAC_VERSION) & 0xff;
> We can add a "gmac_version" in loongson_data, then we only need to
> read it once in the probe function.

Okay!


Thanks,

Yanteng


