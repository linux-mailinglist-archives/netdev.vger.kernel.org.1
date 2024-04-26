Return-Path: <netdev+bounces-91652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C312D8B352B
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E161C211F1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3E143899;
	Fri, 26 Apr 2024 10:16:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B4C142E9F
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126612; cv=none; b=LF/IdNwOz4bEk0iNeCRYU1ducbGFCbcoKGz1xm0SO7T2l/NCVjwqtHsHbWK7SPGOIqmZ85s0Yxye6raOAQmL6Eq6tuTFV7n+oPeLvVgzlQE6ELuMNn4IcX1FQ7hE9xRYBmi4sti6qFGko8cYIoHFD1K3bsvUoQiUUiXA/9lFMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126612; c=relaxed/simple;
	bh=g0p4y1T00BNvjwBoQRhKqpzThtXai51yS2Dby0QSjW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXDJwkrGJbKXNbXKkPUrkhQRd+0wmmy7vjBsA7XpYEMdQUxd4fVVMEZGWxM4h2UY756L+xITnPYvjY2ek7vmI2ABq4f4lrrDFXhwTNhm20e3bhiT69KrM6Wapuw3oCOzzADAOfUjbQCJBAuB6x/EGpzYnvh5I2u9g4nXOtcoaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxLOsOfytmrGkDAA--.7495S3;
	Fri, 26 Apr 2024 18:16:46 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx4VUKfytmIC8GAA--.2885S3;
	Fri, 26 Apr 2024 18:16:43 +0800 (CST)
Message-ID: <36afcb40-7e09-4a17-ad12-c27ac50120e1@loongson.cn>
Date: Fri, 26 Apr 2024 18:16:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/15] net: stmmac: dwmac-loongson: Add
 phy_interface for Loongson GMAC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@kernel.org, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d0ca47778a424a142abbfa7947d8413dfbffc104.1714046812.git.siyanteng@loongson.cn>
 <ZipqaHivDaK/FJAs@shell.armlinux.org.uk>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZipqaHivDaK/FJAs@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx4VUKfytmIC8GAA--.2885S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFyrArW8XF13WF1UXr45XFc_yoW8XF47pr
	4xGrWDJryDJr1fGr45A3WUArW8u34DGw1UC3Wjkay8XF1DWrySqw1jqrW29F17Cr48Jr1U
	Jr1Ut3yUZa4DWFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8oGQDUUUUU==

Hi Russell,

在 2024/4/25 22:36, Russell King (Oracle) 写道:
>> The mac_interface of gmac is PHY_INTERFACE_MODE_RGMII_ID.
> No it isn't!
Ok, that's a typo.
>
>> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> You don't touch mac_interface here. Please read the big comment I put
> in include/linux/stmmac.h above these fields in struct
> plat_stmmacenet_data to indicate what the difference between
> mac_interface and phy_interface are, and then correct which-ever
> of the above needs to be corrected.

Copy your big comment here:

     int phy_addr;
     /* MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
      *       ^                               ^
      * mac_interface                   phy_interface
      *
      * mac_interface is the MAC-side interface, which may be the same
      * as phy_interface if there is no intervening PCS. If there is a
      * PCS, then mac_interface describes the interface mode between the
      * MAC and PCS, and phy_interface describes the interface mode
      * between the PCS and PHY.
      */
     phy_interface_t mac_interface;
     /* phy_interface is the PHY-side interface - the interface used by
      * an attached PHY.
      */

Our hardware engineer said we don't support pcs, and if I understand

your comment correctly, our mac_interface and phy_interface should

be the same, right?


Thanks,

Yanteng



