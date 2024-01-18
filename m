Return-Path: <netdev+bounces-64178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92D8319B0
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 13:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8000B1C21BAC
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781724B4E;
	Thu, 18 Jan 2024 12:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB611CAF
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582623; cv=none; b=JYrHmfUTybIRsH4suCBSK1L6fDXwHXChlBu/wIhcErzwTdDP19+iTDeMuzgz+pUoqY/cMiVtvJRBoCK51MADOGJVx5l23X5RUj+3NbHKO/BreZHNTfdVZnoF35HMrmGD/EbrN45/q9b6AxqOb3fjz7dgkfNv4+tX0ZMmivtFoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582623; c=relaxed/simple;
	bh=E6w2t2lkA3VRpDyQnNJbxVVBH0jclVguAgYbTSBVxRI=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam; b=ZSxX+qRo9Br5dcqwCawKO+iurC9W7KceZcmAjvEcbl32Y5rBy94BhUZfwIvymbVi1Zwh0bHjGse3cMj9I33BAqb545b/lLE8GP0xeM97H0RqkOEq3gkyzoJZLsnz9MKmVCcb0LdK/ZgYy3eRQJM2fcGNBcCH0g4TUEQNO+AcNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.108.41])
	by gateway (Coremail) with SMTP id _____8CxifAaIKllqqYBAA--.8192S3;
	Thu, 18 Jan 2024 20:56:58 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.108.41])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3c4XIKllRJAIAA--.43624S3;
	Thu, 18 Jan 2024 20:56:57 +0800 (CST)
Message-ID: <b9620173-637e-4a56-8db2-60e1e0c3835e@loongson.cn>
Date: Thu, 18 Jan 2024 20:56:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/9] net: stmmac: dwmac-loongson: Add full PCI
 support
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <b43293919f4ddb869a795e41266f7c3107f79faf.1702990507.git.siyanteng@loongson.cn>
 <ZZPoKceXELZQU8cq@shell.armlinux.org.uk>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZZPoKceXELZQU8cq@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Ax3c4XIKllRJAIAA--.43624S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtw18AF4ktFWUCFy5XFykXrc_yoWkKFXEqF
	W8ZF1kZF4rW3Wvyr43Wr1Yyr1SgF1qqrZ3Krn2vr10y3sxWay3Gr4Fgr1fZFW7uw4Iqw4r
	tr15Gwsaqw48XosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=


在 2024/1/2 18:40, Russell King (Oracle) 写道:
> On Tue, Dec 19, 2023 at 10:17:06PM +0800, Yanteng Si wrote:
>> @@ -125,42 +126,48 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   	if (ret)
>>   		goto err_disable_device;
>>   
>> -	bus_id = of_alias_get_id(np, "ethernet");
>> -	if (bus_id >= 0)
>> -		plat->bus_id = bus_id;
>> +	if (np) {
>> +		bus_id = of_alias_get_id(np, "ethernet");
>> +		if (bus_id >= 0)
>> +			plat->bus_id = bus_id;
>>   
>> -	phy_mode = device_get_phy_mode(&pdev->dev);
>> -	if (phy_mode < 0) {
>> -		dev_err(&pdev->dev, "phy_mode not found\n");
>> -		ret = phy_mode;
>> -		goto err_disable_device;
>> +		phy_mode = device_get_phy_mode(&pdev->dev);
>> +		if (phy_mode < 0) {
>> +			dev_err(&pdev->dev, "phy_mode not found\n");
>> +			ret = phy_mode;
>> +			goto err_disable_device;
>> +		}
>> +		plat->phy_interface = phy_mode;
>>   	}
>>   
>> -	plat->phy_interface = phy_mode;
>> -
> So this is why phy_interface changes in patch 2. It would have been good
> to make a forward reference to this change to explain in patch 2 why the
> "default" value has been set there. Or maybe move the setting of that
> default value into this patch?

This sounds great, I will try it.


Thanks,

Yanteng

>


