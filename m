Return-Path: <netdev+bounces-85561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F9289B5F0
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 04:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AB51F21285
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409B380;
	Mon,  8 Apr 2024 02:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A047364
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543452; cv=none; b=irxzjCcWzlAJXXh8nrTP2KELF2JFltPO0Bv9VRBstzt3ARl1IAPQkgaRmqagtBwJWQJQ4dw1BNw25R6HJFTf6M/aHNLkg/QKXKJ8MeIxxquTMSv6O4oetSrV5GDdT7QLeahOjCgaE9iOwq4ScVXd6rE2vl/4pL0oaFNPO1IlLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543452; c=relaxed/simple;
	bh=7ECCTnpEPzR90LOv2joII/8vy8L91A9B1hixB1rxHBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDurHJBRh23S05+iGqJEiZNUeqf0MKGRnN14GJQyraCiFP8Sw6aBTO0fngdEBTuXGIXw8wSDfsKFFsFfCvRVE1dK8ZQsmgnjaVAN/0xKtz5rDCLzPTCudY0G+t1TYiR1iVRIvVzW2QISHD0eC0dsT8GY8t4UbDBuyzqPBp8vYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8CxprnVVhNm2UEkAA--.2245S3;
	Mon, 08 Apr 2024 10:30:45 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX8_NVhNmgSR1AA--.28322S3;
	Mon, 08 Apr 2024 10:30:38 +0800 (CST)
Message-ID: <95b372a0-f720-4ee4-8261-796a58f9ad81@loongson.cn>
Date: Mon, 8 Apr 2024 10:30:37 +0800
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
 <60b7a9c3-ad98-4493-b1c7-3ee221a3101a@loongson.cn>
 <33bda648-31b6-4da7-bf25-b0d2d41ad139@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <33bda648-31b6-4da7-bf25-b0d2d41ad139@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxX8_NVhNmgSR1AA--.28322S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFW8Kw18ury3AF47Ary8CrX_yoWrZF18pr
	18AFyqkry8trW8tw1ktF1UAFyUt348Jw4UJrn5K3W7JF1qyrWjqr1qqF4Ygrn8Xr4xArWj
	gry7Xrn8Zr4DJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==


在 2024/4/7 23:27, Andrew Lunn 写道:
> On Sun, Apr 07, 2024 at 05:06:34PM +0800, Yanteng Si wrote:
>> 在 2024/4/6 22:46, Andrew Lunn 写道:
>>>> +	 */
>>>> +	if (speed == SPEED_1000) {
>>>> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15))
>>> It would be good to add a #define using BIT(15) for this PS bit. Also,
>> OK.
>>> what does PS actually mean?
>> In DW GMAC v3.73a:
>>
>> It is the bit 15 of MAC Configuration Register
>>
>>
>> Port Select
> Since this is a standard bit in a register, please add a #define for
> it. Something like
>
> #define MAC_CTRL_PORT_SELECT_10_100 BIT(15)
>
> maybe in commom.h? I don't know this driver too well, so it might have
OK.
> a different naming convention.
>
> 	if (speed == SPEED_1000) {
> 		if (readl(ptr->ioaddr + MAC_CTRL_REG) & MAC_CTRL_PORT_SELECT_10_100)
> 		/* Word around hardware bug, restart autoneg */
>
> is more obvious what is going on.
great!
>
>>>> +	priv->synopsys_id = 0x37;
>>> hwif.c:		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
>>> stmmac_mdio.c:	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
>>> stmmac_mdio.c:		if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
>>>
>>> Please add a #define for this 0x37.
>>>
>>> Who allocated this value? Synopsys?
>> It look like this.
> That did not answer my question. Did Synopsys allocate this value?  If
> not, what happens when Synopsys does produce a version which makes use
> of this value?

Hmm, that will not happen, because the value already exists, and we can 
find it in the code.

title: Synopsys DesignWare MAC

maintainers:
   - Alexandre Torgue <alexandre.torgue@foss.st.com>
   - Giuseppe Cavallaro <peppe.cavallaro@st.com>
   - Jose Abreu <joabreu@synopsys.com>

# Select every compatible, including the deprecated ones. This way, we
# will be able to report a warning when we have that compatible, since
# we will validate the node thanks to the select, but won't report it
# as a valid value in the compatible property description
select:
   properties:
     compatible:
       contains:
         enum:
           - snps,dwmac
           - snps,dwmac-3.40a
           - snps,dwmac-3.50a
           - snps,dwmac-3.610
           - snps,dwmac-3.70a
           - snps,dwmac-3.710
           - snps,dwmac-4.00
           - snps,dwmac-4.10a
           - snps,dwmac-4.20a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
           - snps,dwxgmac
           - snps,dwxgmac-2.10

           # Deprecated
           - st,spear600-gmac

There are a lot of calls like that. Let's grep -rn dwmac-3.70a:

drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c:57: { .compatible = 
"snps,dwmac-3.70a"},
drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:524: 
of_device_is_compatible(np, "snps,dwmac-3.70a") ||

arch/arm64/boot/dts/amlogic/meson-axg.dtsi:279: "snps,dwmac-3.70a",
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:171: "snps,dwmac-3.70a",
arch/arm64/boot/dts/amlogic/meson-gx.dtsi:585: "snps,dwmac-3.70a",
arch/arm64/boot/dts/amlogic/meson-s4.dtsi:489: "snps,dwmac-3.70a",
arch/loongarch/boot/dts/.loongson-2k0500-ref.dtb.dts.tmp:114: compatible 
= "snps,dwmac-3.70a";

......

>>> /* Synopsys Core versions */
>>> #define DWMAC_CORE_3_40         0x34
>>> #define DWMAC_CORE_3_50         0x35
>>> #define DWMAC_CORE_4_00         0x40
>>> #define DWMAC_CORE_4_10         0x41
>>>
>>> 0x37 makes it somewhere between a 3.5 and 4.0.
>> Yeah,
>>
>> How about defining it in
>> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c?
> No, because of the version comparisons within the code, developers
> need to know what versions actually exist. So you should include it
> along side all the other values.

OK, Let's:

@@ -29,6 +29,7 @@
  /* Synopsys Core versions */
  #define        DWMAC_CORE_3_40         0x34
  #define        DWMAC_CORE_3_50         0x35
+#define        DWMAC_CORE_3_70         0x37
  #define        DWMAC_CORE_4_00         0x40
  #define DWMAC_CORE_4_10                0x41
  #define DWMAC_CORE_5_00                0x50


Thanks,

Yanteng


