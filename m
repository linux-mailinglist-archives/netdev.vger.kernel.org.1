Return-Path: <netdev+bounces-89783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5A8AB8DA
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 04:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDC61F214EE
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 02:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F7B625;
	Sat, 20 Apr 2024 02:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B1F1118C
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580892; cv=none; b=q4N7O56GLNQtltvFEVwB2sRgFIthLJaYiRRHkqplqD7qIjGvGL2BrKizhni5ii/EQGJRnTCwc3S2tp+oR6ThhEk/fGoDy2a5PFWCHts6Ht8QR0oV8wCih+vESK4H9biv3BA6/D3tyZjRV5eo19vOy3Bb6VM9K4fftocRF3pDsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580892; c=relaxed/simple;
	bh=0lLZDHtuLC3gDotFJzEhLBZy+fIW+zuuu7IctPIsQDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTtrL/oV449p10tgMtBwCsUSfdEsclHn/JJR8MOuupkUE7DlRRXLKoK3r3S3ECipDE9Gl/9lzJkIDXZ87aSA9UyV1GsKmL1dU7n/hA7QAH7eG/0pDOrlvl2upEFxWbgbxl0GXv9M37vWEM7huxjn52CAq6eR3Lerkqa+rOtBnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8AxU_JXKyNmyEIAAA--.1639S3;
	Sat, 20 Apr 2024 10:41:27 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxIeBUKyNmEosAAA--.3102S3;
	Sat, 20 Apr 2024 10:41:25 +0800 (CST)
Message-ID: <1abf101b-87b8-448a-bd2a-bc9fb7c28852@loongson.cn>
Date: Sat, 20 Apr 2024 10:41:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 5/6] net: stmmac: dwmac-loongson: Add full
 PCI support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <ae660c8872297b562ee4e62cd852ba96f307e079.1712917541.git.siyanteng@loongson.cn>
 <adnsyedexlqbncmadqzsr7f2vnqcvilzow4n3ibajxek4qes4m@pmwhb636j2qp>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <adnsyedexlqbncmadqzsr7f2vnqcvilzow4n3ibajxek4qes4m@pmwhb636j2qp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxIeBUKyNmEosAAA--.3102S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7V
	AKI48JMxAqzxv262kKe7AKxVWUXVWUAwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vD73UUUUU==


在 2024/4/18 21:08, Serge Semin 写道:
>> -	np = dev_of_node(&pdev->dev);
>> -
>> -	if (!np) {
>> -		pr_info("dwmac_loongson_pci: No OF node\n");
>> -		return -ENODEV;
>> -	}
> Hm, I see you dropping this snippet and never getting it back in this
> patch. Thus after the patch is applied np will be left uninitialized,
> which will completely break the driver. Please make sure it's fixed.
>
> This problem has been introduced at the v9 stage, which I didn't have
> time to review. There were no problem like that in v8.

Okay, I will restore it.


Thanks,

Yanteng


