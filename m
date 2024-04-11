Return-Path: <netdev+bounces-86913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCCE8A0C68
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFD01C20A91
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591C144D16;
	Thu, 11 Apr 2024 09:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D513FD8B
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827800; cv=none; b=j29YcuUSrl4ey7FVfRRx+LHKI0TkBn2HQMxT3XMx0LksiF4+NmlNCfP6/aZSPzAgu/36P6u5Y9SlWjm9pqUpqIc4JreC5rlOnQhxeIJMr0R9mmkNDHlNTZa2ktPCaP+CRZ7ONzFDI6+r4WBXE8d1yxnJKtbnn4Tqh07453KYdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827800; c=relaxed/simple;
	bh=SUrphATtzfM10Ss310pH48XTO4QpOVNeGGT7wwrtfmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dy37wkgfdblcGaE3qwyZC77Ru/FBbVs2TKeetVmFafGiQu/tkjgzfQK5ZWTEuKbjNkveElcAkGV0yvFLjkW2yyy5cZT2n8+qPFnQYdBW3noyOgaLIio6pjNn9RPnlb36lYbeNX6w7fzy8Aa/opdjvGvcFi2vlAFS2JpeKiRRcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Axx7mTrRdmTcYlAA--.5243S3;
	Thu, 11 Apr 2024 17:29:55 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxeRKQrRdmUPd3AA--.23186S3;
	Thu, 11 Apr 2024 17:29:53 +0800 (CST)
Message-ID: <d9362c40-fde1-4380-9fdb-2d6599dbaab1@loongson.cn>
Date: Thu, 11 Apr 2024 17:29:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@kernel.org, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712668711.git.siyanteng@loongson.cn>
 <77daabe9ca5c62168d9e54a81b5822e9b898eeb3.1712668711.git.siyanteng@loongson.cn>
 <ZhaPGO77dcYxiqqA@shell.armlinux.org.uk>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZhaPGO77dcYxiqqA@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxeRKQrRdmUPd3AA--.23186S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1rXry3AryxZFy5CF18tFc_yoW8XrW5p3
	y7Aa4qkw1qgr4kK3yYvrn0qr1IkFyrCFyDJ3WrX3yIya98Cr97tr95Krsxu34fWwn8ZryS
	qry5Jw1UZF9FkagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU28nYUUUUU


在 2024/4/10 21:07, Russell King (Oracle) 写道:
> On Tue, Apr 09, 2024 at 10:04:34PM +0800, Yanteng Si wrote:
>> +	/* The GMAC device with PCI ID 7a03 does not support any pause mode.
>> +	 * The GNET device (only LS7A2000) does not support half-duplex.
>> +	 */
>> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
>> +		priv->hw->link.caps = MAC_10FD | MAC_100FD |
>> +			MAC_1000FD;
>> +	} else {
> I'm sorry, but what follows looks totally broken to me.
Sorry. Let's make it better together.
>
>> +		priv->hw->link.caps = (MAC_ASYM_PAUSE |
>> +			MAC_SYM_PAUSE | MAC_10FD | MAC_100FD | MAC_1000FD);
> Parens not required.
>
> This sets 10Mbps full duplex, 100Mbps full duplex, 1000Mbps full duplex.
> It does *not* set 10Mbps half duplex, 100Mbps half duplex, nor 1000Mbps
> half duplex.
OK, I will set them by MAC10 | MAC100 | MAC1000.
>
>> +
>> +		if (loongson_gmac == DWMAC_CORE_3_70) {
>> +			priv->hw->link.caps &= ~(MAC_10HD |
>> +				MAC_100HD | MAC_1000HD);
>> +		}
> Braces not required.
>
> This clears 10Mbps half duplex, 100Mbps half duplex, 1000Mbps half
> duplex, all of which were _NOT_ set. Therefore this code as written
> can be entirely deleted.
>
> Alternatively, this code is completely untested and is functionally
> incorrect.

Sorry.


In fact, this was the version before picking up Serge's patch(1/6), 
which was tested

at the time. Just picked up, between the haste did not test enough. But 
in v11,

I've dropped this function and fixed it in setup().


Thanks,

Yanteng

>


