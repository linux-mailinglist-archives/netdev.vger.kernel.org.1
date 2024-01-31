Return-Path: <netdev+bounces-67494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF42843B14
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80FC4B2F545
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11962A09;
	Wed, 31 Jan 2024 09:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777767E90
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692959; cv=none; b=OJir49FrE+1bAp7jMeqfpH2ky0FokbLuUs5oktzCyPdgexRLiwyaXeMdCXbbc0wCLbOPgBhSvb3ZXloCIa+pbrNOVAgD+6PQ8jE7kHYff8t7Q5R3gUJCjxUA6rVQL//D//fX6QJU0q2ki+oQuftZUs1NUjqXoidplyvzHO09d8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692959; c=relaxed/simple;
	bh=pBgFKbXqQWJN0wMbH19h+3J1JlgtYbaVJ7jA9y+6INU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ferW71Yc89uLPZs2d28P0soGXLDTjJfZlEwzMMdhPH1WGM8u5RMdddQyTieVbPrjnxHQN1uLH4njNjwrDy0bGrDy0AMzoSU2kwEsK5m2ovMdqSB4subeukL6BMzZNoX5HpIbH0zlR4DnHE09DwtByONErYle20wn+w033b0sD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8CxF+j4ELplDNoIAA--.7011S3;
	Wed, 31 Jan 2024 17:20:56 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjhP2ELpllt0pAA--.41296S3;
	Wed, 31 Jan 2024 17:20:55 +0800 (CST)
Message-ID: <55cec396-6502-4ac2-b1b5-900a0d1a1903@loongson.cn>
Date: Wed, 31 Jan 2024 17:20:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 00/11] stmmac: Add Loongson platform support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <20240130181056.42944840@kernel.org>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240130181056.42944840@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxjhP2ELpllt0pAA--.41296S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw4UAFWUtFy7KFyfZrW5Arc_yoWDAFg_uF
	42vwnxXF4DGr4jyr4Ut345ZrZYqrnFgF1fKF4DuFWfuFn7Zr95J3Z3ur95AF13Cw47ZFn8
	Gr1IqFWfAw1xtosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
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


在 2024/1/31 10:10, Jakub Kicinski 写道:
> On Tue, 30 Jan 2024 16:43:20 +0800 Yanteng Si wrote:
>> * The biggest change is according to Serge's comment in the previous
>>    edition:
> Looks like there's a trivial build issue here:
>
> ERROR: modpost: "dwmac1000_dma_ops"
> [drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.ko] undefined!
>
> Please wait for Serge's review before posting v9.

OK!  Will fix with:

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c 
b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 5f7b82ad3ec2..0323f0a5049c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -296,3 +296,4 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
         .get_hw_feature = dwmac1000_get_hw_feature,
         .rx_watchdog = dwmac1000_rx_watchdog,
  };
+EXPORT_SYMBOL_GPL(dwmac1000_dma_ops);


Thanks,

Yanteng


