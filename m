Return-Path: <netdev+bounces-85491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76F89AFFA
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 11:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17331F212DE
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1B14A82;
	Sun,  7 Apr 2024 09:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F5F17999
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480803; cv=none; b=mud/PoHSX82o2zY1iLbBDY4WfvLzaNg3ToGoxRdvlQR6Z6w6vLmhPpHAtRBfL6hL2zfilmb2jL98G1gDMadvpVfv1g0wclMS2SKNgPJet8jLDGoHdpymwlfF7l5DnEW/PnZcoxWjbPJgwXLcBuEXpXrIrfqap0HotPDajSTIGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480803; c=relaxed/simple;
	bh=++hMO8MQnM09+iNke66iDJDN0XB3YeebFsTXiZz8ziY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Br9fLkxsNW/Q0EVISK7HmxHKW6qEvwnlDSFUKl2Umac1JN8trNWxZcrgmWZo+QtfEPIALl11A/Mvn1NRi5ZVFMWVxBKBOOaziYxtntOjUKxMp+B88fHzgjoGaf2D7vJtvf5JlQLDk7G5lvbSqaxX/9AU3oT64BrHCYeY2t1AjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8DxfescYhJmnQIkAA--.16967S3;
	Sun, 07 Apr 2024 17:06:36 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLBMaYhJmcYl0AA--.28650S3;
	Sun, 07 Apr 2024 17:06:35 +0800 (CST)
Message-ID: <60b7a9c3-ad98-4493-b1c7-3ee221a3101a@loongson.cn>
Date: Sun, 7 Apr 2024 17:06:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/6] net: stmmac: dwmac-loongson: Add GNET
 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1712407009.git.siyanteng@loongson.cn>
 <3e9560ea34d507344d38a978a379f13bf6124d1b.1712407009.git.siyanteng@loongson.cn>
 <a3975cd6-ae9a-4dc1-b186-5dacf1df5150@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <a3975cd6-ae9a-4dc1-b186-5dacf1df5150@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxLBMaYhJmcYl0AA--.28650S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWry8AF1UKr1UXFWxJw1xtFc_yoW5Ww4kpF
	W0yFy8Ar4qyr4xKa1ktrWvqFy5A39xWa1DXr13W3y2yanFkry8Zr1YqF42qrW7G3Wj9r43
	K34avF1DGwsrAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU


在 2024/4/6 22:46, Andrew Lunn 写道:
>> +	 */
>> +	if (speed == SPEED_1000) {
>> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15))
> It would be good to add a #define using BIT(15) for this PS bit. Also,
OK.
> what does PS actually mean?

In DW GMAC v3.73a:

It is the bit 15 of MAC Configuration Register


Port Select

This bit selects the Ethernet line speed.

* 0: For 1000 Mbps operations

* 1: For 10 or 100 Mbps operations


In 10 or 100 Mbps operations, this bit, along with FES bit, selects the 
exact line
speed. In the 10/100 Mbps-only (always 1) or 1000 Mbps-only (always 0)
configurations, this bit is read-only with the appropriate value. In default
10/100/1000 Mbps configuration, this bit is R_W. The mac_portselect_o or
mac_speed_o[1] signal reflects the value of this bit.
>
>> +	priv->synopsys_id = 0x37;
> hwif.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
> hwif.c:	priv->synopsys_id = id;
> hwif.c:		/* Use synopsys_id var because some setups can override this */
> hwif.c:		if (priv->synopsys_id < entry->min_id)
> stmmac_ethtool.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50)
> stmmac.h:	int synopsys_id;
> stmmac_main.c:			if (priv->synopsys_id < DWMAC_CORE_4_10)
> stmmac_main.c:	if (priv->synopsys_id >= DWMAC_CORE_4_00 ||
> stmmac_main.c:		if (priv->synopsys_id < DWMAC_CORE_4_00)
> stmmac_main.c:	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
> stmmac_main.c:	if (priv->synopsys_id < DWMAC_CORE_5_20)
> stmmac_main.c:	else if ((priv->plat->enh_desc) || (priv->synopsys_id >= DWMAC_CORE_4_00))
> stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
> stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
> stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
> stmmac_mdio.c:		if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
>
> Please add a #define for this 0x37.
>
> Who allocated this value? Synopsys?
It look like this.
>
> /* Synopsys Core versions */
> #define DWMAC_CORE_3_40         0x34
> #define DWMAC_CORE_3_50         0x35
> #define DWMAC_CORE_4_00         0x40
> #define DWMAC_CORE_4_10         0x41
>
> 0x37 makes it somewhere between a 3.5 and 4.0.

Yeah,

How about defining it in 
drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c?

>
> stmmac_ethtool.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50)
> stmmac_main.c:	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
>
> Does the hardware actually provide what these two bits of code
> require? Have you reviewed all similar bits of code to confirm they
> are correct for your hardware?

Yes, because in fact the IP core of our gnet is 0x37, but some chips 
(2k2000) split

the rx/tx register definition from one into two. In order to distinguish 
them, 0x10

was created. it is not worth adding a new entry for this.


According to Serge's comment, we made these devices work by overwriting
priv->synopsys_id = 0x37 and mac->dma = <LS_dma_ops>.


Thanks,

Yanteng


