Return-Path: <netdev+bounces-109158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E19272C5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA29D1C21DF1
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0F19885E;
	Thu,  4 Jul 2024 09:15:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73516F859
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084557; cv=none; b=RytY8cvfyKgaajQNlq050U1iDu/XekA6qwrFXg36o9pgtvRAjSPEfurE+gCXH6v7JyfU2J52v09n2X1TNTA+0ec/nJLh2V1Qd1xwelWkMfvi4vuYOjwS19QxTqq9zw1mtOW2NveW4yvrKqLwvqduYbY9mK8BGXKymEcetdrUA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084557; c=relaxed/simple;
	bh=pBpNJoDLpaV4HYPeuMFdMoFUmS0fa+6PsYdgOx4tbJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvqPZE1q0OuyB8831rUaEkPnAFfCqvR4Zg6xK9gVevAz4LdJBNVqc7506z+9MUwt1H0K6bTmZasQTqtYBBjts17yJ3yaCO7jfkO1rX48m4bFlKaMTNHfBhHt5S4Y7WyZO0kYe3Wld743wbo/7uWCmcz5+yEEcDk5GBfHAtsyr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8DxjPBIaIZmJ+EAAA--.3061S3;
	Thu, 04 Jul 2024 17:15:52 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxssRFaIZmU+I6AA--.59760S3;
	Thu, 04 Jul 2024 17:15:49 +0800 (CST)
Message-ID: <ced74b4d-4e23-4803-858e-da146a19bb26@loongson.cn>
Date: Thu, 4 Jul 2024 17:15:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 11/15] net: stmmac: dwmac-loongson: Add
 loongson_dwmac_dt_config
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b7dbb5c3cc6beef74a5d8df193394a8a8a2b46a1.1716973237.git.siyanteng@loongson.cn>
 <izezculld3evoafk2eot5xx3fwnfughgu37silhq3qv5orwi4w@iy75t6wl2tsr>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <izezculld3evoafk2eot5xx3fwnfughgu37silhq3qv5orwi4w@iy75t6wl2tsr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxssRFaIZmU+I6AA--.59760S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2
	Ij64vIr41l4c8EcI0En4kS14v26r126r1DMxAqzxv26xkF7I0En4kS14v26r126r1DMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vD73UUUUU==


在 2024/7/2 17:46, Serge Semin 写道:
> On Wed, May 29, 2024 at 06:20:27PM +0800, Yanteng Si wrote:
>> While at it move the np initialization procedure into a dedicated
>> method. It will be useful in one of the subsequent commit adding the
>> Loongson GNET device support.
> As I just mentioned please merge in this patch content into the
> previous patch:
> [PATCH net-next v13 10/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
>
OK.


Thanks,

Yanteng


