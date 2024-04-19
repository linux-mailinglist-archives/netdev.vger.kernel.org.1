Return-Path: <netdev+bounces-89572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D748AAC70
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CD21F2125B
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D8745EF;
	Fri, 19 Apr 2024 10:07:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5028278286
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521222; cv=none; b=MeHBMZ99+JY9M9Ivl0Mjc3iRRKx+R7F2TYwDEJg9oil/sGpmut3GB2DQURiMekm54pIRf6fR+hZoeBUiiUAX7S2BOrXGbneL+9R9+veRlOZ/Oj3Sd23a/nmPHxq4Qgw2+UlrYuV+rrQEc5BKpzzHdr2xZwjcsSdCxhyEqbwCwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521222; c=relaxed/simple;
	bh=DXWrggECK7cAoBqFUBoPJNVktnEwj1M0l3zD0vzpWaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErKWbT4rKvsppeGaKPVPVcY8m6euA8j+dPz+0z1wOzknpOqeiK35ixExmDaO9gHB0zJQuj6czYjXPf8s+QZerwzJ3LqbUPUva+a1lyzg+F3Jj/kVKaLgMr6SxsS15mNswUKDbV4sWAugfcsgko9xZIPh1nr8kngs76uKHy+BGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8DxJ+g8QiJmbb8pAA--.8754S3;
	Fri, 19 Apr 2024 18:06:52 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c44QiJmmxyAAA--.46985S3;
	Fri, 19 Apr 2024 18:06:49 +0800 (CST)
Message-ID: <96d06fdc-8326-4394-a0e3-b1f98590deb7@loongson.cn>
Date: Fri, 19 Apr 2024 18:06:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 4/6] net: stmmac: dwmac-loongson: Introduce
 GMAC setup
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <6f0ac42c1b60db318b7d746254a9b310dd03aa32.1712917541.git.siyanteng@loongson.cn>
 <pyqjoofuvrscra6bluwginu5bowzb3dr424sf3riyrtpzsaheg@k3rr25ivcj7s>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <pyqjoofuvrscra6bluwginu5bowzb3dr424sf3riyrtpzsaheg@k3rr25ivcj7s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx_c44QiJmmxyAAA--.46985S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFWUArW7AFW7Zr13JFWUtrc_yoW3XFbEkr
	4xta4qkw15Xr4ktF45K345Ja9rXFWUZr12grW0grs8X34Fqwn09FyDur129w1xu3WxKF1Y
	krnxCa4Iywna9osvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=


在 2024/4/18 20:26, Serge Semin 写道:
>>   	plat->multicast_filter_bins = 256;
>> +	plat->clk_ref_rate = 125000000;
>> +	plat->clk_ptp_rate = 125000000;
> This change is unrelated to the rest of the changes in this patch.
> Please split the patch up into two:
> 1. Add ref and ptp clocks for Loongson GMAC
> 2. Split up the platform data initialization
> First one is a new feature adding the actual ref clock rates to the
> driver. The second patch is a preparation before adding the full PCI
> support.
>
Ok, but we need to reverse the order:

1. Split up the platform data initialization

2. Add ref and ptp clocks for Loongson GMAC


Since loongson_gmac_data() needs to be introduced first, then we can add the

clock rates of GMAC.


Thanks,
Yanteng



