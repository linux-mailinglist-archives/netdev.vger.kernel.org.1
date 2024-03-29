Return-Path: <netdev+bounces-83226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1A891676
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FF0286C73
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7651C39;
	Fri, 29 Mar 2024 10:06:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3593D0D2;
	Fri, 29 Mar 2024 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706760; cv=none; b=ioqasBo9rTaOfIXUPiWtCmp5fIzzRJHFTi9HErmR3BDU5tqG1yt8N7mAoYOylGf8UUf7JcbBcljNx+gARx+ijyKfUzZhxrShT5DaE91kV3PExCK5ZuqfyBmlfEXuujNea8ODV0bfruoc1nFRFHGL62cvHNAsnBUErdgZZOnVd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706760; c=relaxed/simple;
	bh=aqgWLAlXcnotGgSYgY9TrilUarV/SJyTu/HI/BjiZp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOzdht9AS3lP1BnviCQvWSOxRwFml7+mLwiPqWI4mPC8wWuMn4L9ASFZxw656zLlfHFxIzjTnGJ3v8ghyjBert95PoftbBJPglhyXoim4jrD0kkpLMjMmYiw99T1vqK+t3GIu9Mq7i7cRv9H0o3zwMYwPqpg+5w8s8qs3maIEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V5bdG5nCfz4f3mHL;
	Fri, 29 Mar 2024 18:05:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 07B5C1A0172;
	Fri, 29 Mar 2024 18:05:47 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgCXZg91kgZmxne1IQ--.1768S2;
	Fri, 29 Mar 2024 18:05:43 +0800 (CST)
Message-ID: <ed3debc9-f2a9-41fb-9cf9-dc6419de5c01@huaweicloud.com>
Date: Fri, 29 Mar 2024 18:05:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb
 instructions
Content-Language: en-US
To: Stefan O'Rear <sorear@fastmail.com>, Conor Dooley <conor@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Manu Bretelle <chantr4@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
 <20240328-ferocity-repose-c554f75a676c@spud>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20240328-ferocity-repose-c554f75a676c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXZg91kgZmxne1IQ--.1768S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF43GrWDCry7Wr1rZr1rXrb_yoW5tF47pa
	10kF1qka1DJa4Ik392qF18Wr1YvF4rKr43Jrn8J348A34jqrW2qF1kKa15uF1DXryrGr1j
	qr4UKF17u34DZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/3/29 6:07, Conor Dooley wrote:
> On Thu, Mar 28, 2024 at 03:34:31PM -0400, Stefan O'Rear wrote:
>> On Thu, Mar 28, 2024, at 8:49 AM, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> This patch relaxes the restrictions on the Zbb instructions. The hardware
>>> is capable of recognizing the Zbb instructions independently, eliminating
>>> the need for reliance on kernel compile configurations.
>>
>> This doesn't make sense to me.
> 
> It doesn't make sense to me either. Of course the hardware's capability
> to understand an instruction is independent of whether or not a
> toolchain is capable of actually emitting the instruction.
> 
>> RISCV_ISA_ZBB is defined as:
>>
>>             Adds support to dynamically detect the presence of the ZBB
>>             extension (basic bit manipulation) and enable its usage.
>>
>> In other words, RISCV_ISA_ZBB=n should disable everything that attempts
>> to detect Zbb at runtime. It is mostly relevant for code size reduction,
>> which is relevant for BPF since if RISCV_ISA_ZBB=n all rvzbb_enabled()
>> checks can be constant-folded.

Thanks for review. My initial thought was the same as yours, but after 
discussions [0] and test verifications, the hardware can indeed 
recognize the zbb instruction even if the kernel has not enabled 
CONFIG_RISCV_ISA_ZBB. As Conor mentioned, we are just acting as a JIT to 
emit zbb instruction here. Maybe is_hw_zbb_capable() will be better?

Link: 
https://lore.kernel.org/bpf/20240129-d06c79a17a5091b3403fc5b6@orel/ [0]

>>
>> If BPF needs to become an exception (why?), this should be mentioned in
>> Kconfig.
> 
> And in the commit message. On one hand I think this could be a reasonable
> thing to do in bpf as it is acting as a jit here, and doesn't actually
> need the alternatives that we are using elsewhere to enable the
> optimisations nor the compiler support. On the other the intention of
> that kconfig option is to control optimisations like rvzbb_enabled()
> gates, so this is gonna need a proper justification as to
> 
> As I said on IRC to you earlier, I think the Kconfig options here are in
> need of a bit of a spring cleaning - they should be modified to explain
> their individual purposes, be that enabling optimisations in the kernel
> or being required for userspace. I'll try to send a patch for that if
> I remember tomorrow.
> 
> Thanks,
> Conor.
> 
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>>   arch/riscv/net/bpf_jit.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>> index 5fc374ed98ea..bcf109b88df5 100644
>>> --- a/arch/riscv/net/bpf_jit.h
>>> +++ b/arch/riscv/net/bpf_jit.h
>>> @@ -20,7 +20,7 @@ static inline bool rvc_enabled(void)
>>>
>>>   static inline bool rvzbb_enabled(void)
>>>   {
>>> -	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
>>> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
>>> +	return riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
>>>   }
>>>
>>>   enum {
>>> -- 
>>> 2.34.1
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


