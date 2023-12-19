Return-Path: <netdev+bounces-58885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C817818781
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5861F2472A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92791182C6;
	Tue, 19 Dec 2023 12:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBE218059
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8CxhfDijIFlbpsCAA--.13003S3;
	Tue, 19 Dec 2023 20:30:26 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxneTgjIFl_U8AAA--.2346S3;
	Tue, 19 Dec 2023 20:30:26 +0800 (CST)
Message-ID: <b3afbe08-3cd2-4b7e-8191-f7028f3d6acc@loongson.cn>
Date: Tue, 19 Dec 2023 20:30:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] net: stmmac: Add Loongson-specific register
 definitions
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, loongarch@lists.linux.dev,
 chris.chenfeiyang@gmail.com
References: <cover.1702458672.git.siyanteng@loongson.cn>
 <40eff8db93b02599f00a156b07a0dcdacfc0fbf3.1702458672.git.siyanteng@loongson.cn>
 <8a7d2d11-a299-42e0-960f-a6916e9b54fe@lunn.ch>
 <033fedc9-1d96-408e-911b-9829c6a5e851@loongson.cn>
 <bc36a2a1-1c3c-4adb-8c8a-d4e4427a6999@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <bc36a2a1-1c3c-4adb-8c8a-d4e4427a6999@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxneTgjIFl_U8AAA--.2346S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF18Wr1kAry3tw18KFy7CFX_yoW8XrWxpw
	47WFWkKr4kJr42y3W0ya15WFy5t3ySkFyrGw48G3s7tas8Zr17Cr4rGrs5WasrJr4DA3y2
	qF1DArn3tr4rA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==


在 2023/12/18 23:28, Andrew Lunn 写道:
> On Mon, Dec 18, 2023 at 06:22:04PM +0800, Yanteng Si wrote:
>> 在 2023/12/16 23:47, Andrew Lunn 写道:
>>> On Wed, Dec 13, 2023 at 06:14:23PM +0800, Yanteng Si wrote:
>>>> There are two types of Loongson DWGMAC. The first type shares the same
>>>> register definitions and has similar logic as dwmac1000. The second type
>>>> uses several different register definitions.
>>>>
>>>> Simply put, we split some single bit fields into double bits fileds:
>>>>
>>>> DMA_INTR_ENA_NIE = 0x00040000 + 0x00020000
>>>> DMA_INTR_ENA_AIE = 0x00010000 + 0x00008000
>>>> DMA_STATUS_NIS = 0x00040000 + 0x00020000
>>>> DMA_STATUS_AIS = 0x00010000 + 0x00008000
>>>> DMA_STATUS_FBI = 0x00002000 + 0x00001000
>>> What is missing here is why? What are the second bits used for? And
>> We think it is necessary to distinguish rx and tx, so we split these bits
>> into two.
>>
>> this is:
>>
>> DMA_INTR_ENA_NIE = rx + tx
> O.K, so please add DMA_INTR_ENA_NIE_RX and DMA_INTR_ENA_NIE_TX
> #define's, etc.
OK!
>
>> We will care about it later. Because now we will support the minimum feature
>> set first, which can reduce everyone’s review pressure.
> Well, you failed with that, since you did not provide the details what
> these bits are. If you had directly handled the bits separately, it
> would of been obvious what they are for.

  It is because I did not give a clear reply to serge's comment, which 
was more detailed. :)


Thanks,

Yanteng

>
>        Andrew


