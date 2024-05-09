Return-Path: <netdev+bounces-94910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155BC8C0FD5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4498C1C228D3
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674B13B7A1;
	Thu,  9 May 2024 12:44:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366913AD33
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258650; cv=none; b=c3TqRXFL6iN0L4zOEkqB0m4lfk+ILXKA7JBSBwvnOOGogBH8J6gp5a8Q0d+0QqyPTz5zLiiuY+cnrdN9e0iHRWtVvUjxwcIGSOQJZyGn0qAIZS7N8TK0DdnBFIH2fDttMzJ8Fs9FjpcyxeDxnx+0uH+3eTX0MjLrg0FUFw810cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258650; c=relaxed/simple;
	bh=d2bGHyQG/R+TnIA9Tx8iuEMCGI0KEtcVYWFsD1wto3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVYbZm8qRzbwfwcb7XO4QX4jViScEY8coyJSHLvRSfdpmZpc8cOtZ4DL5gEWa0Vjl/Ao6TqXpNFKlPIc24DeZUefqbtqh27P2IDayJP7gl/FXM34UWy64g1liWnqUCgZq5ydP/pa5eC180Cifp+nj5mPZbXM4RwkXeZjtJ+msxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8AxY+oUxTxm7vgJAA--.13921S3;
	Thu, 09 May 2024 20:44:04 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxX1URxTxmzgQXAA--.27140S3;
	Thu, 09 May 2024 20:44:03 +0800 (CST)
Message-ID: <c591f1ef-7540-4713-8e98-ce6f466efeb0@loongson.cn>
Date: Thu, 9 May 2024 20:44:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/15] net: stmmac: Move the atds flag to the
 stmmac_dma_cfg structure
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <3f9089bae8391d1263ef9c2b7a7c09de56308387.1714046812.git.siyanteng@loongson.cn>
 <3yllm6pibimhkuorn3djjn7wtvsvgsf4metobfhsrlnekettly@6lnq6fyac72a>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <3yllm6pibimhkuorn3djjn7wtvsvgsf4metobfhsrlnekettly@6lnq6fyac72a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxX1URxTxmzgQXAA--.27140S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF1xKw18GF1xAr45GF4DAwc_yoWDtrg_Ww
	4aqF1UWw1UAFy2kF4Skr1F9ry7WFWUCFnFgw48trWfJ34rXFZ3XF95ur95Zw18AanxZFsF
	k343ta4Iywn8WosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU


在 2024/5/3 03:10, Serge Semin 写道:
> "ATDS (Alternate Descriptor Size) is a part of the DMA Bus Mode configs
> (together with PBL, ALL, EME, etc) of the DW GMAC controllers. Seeing
> it's not changed at runtime but is activated as long as the IP-core
> has it supported (at least due to the Type 2 Full Checksum Offload
> Engine feature), move the respective parameter from the
> stmmac_dma_ops::init() callback argument to the stmmac_dma_cfg
> structure, which already have the rest of the DMA-related configs
> defined.
>
> Besides the being added in the next commit DW GMAC multi-channels
> support will require to add the stmmac_dma_ops::init_chan() callback
> and have the ATDS flag set/cleared for each channel in there. Having
> the atds-flag in the stmmac_dma_cfg structure will make the parameter
> accessible from stmmac_dma_ops::init_chan() callback too."
>
> Other than that the change looks good. Thanks.
>
> Reviewed-by: Serge Semin<fancer.lancer@gmail.com>

Ok, I'll pick them up, thanks for your comment.


Thanks,

Yanteng


