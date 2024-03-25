Return-Path: <netdev+bounces-81659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22A88AA72
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80221F64B07
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F426FE0A;
	Mon, 25 Mar 2024 15:28:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3E28E8;
	Mon, 25 Mar 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380488; cv=none; b=kA/33/6LbQvaqLyVefucPg5sMap1SZviMoMPp/lxQ7yoBnv3yttjFJn8BESsHfg8wc6QZHEWZXw90pX+zRt81h2naYgzlxiT/Q1jUoHxM5Nh1LV0e3z7k0IvOWhokAY7PaSxfX0Hl+U48NwtUmTrUimQkwxDdSLOfx3CFiXbRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380488; c=relaxed/simple;
	bh=hMXg5saqaifE31pMQbOF4XfRIR9/fA1LTFkNUCFvde4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGtakKakkRppvwqaDrIOZDgV3Ezihklgi12dBOZ05p4mygNqq3sMwQHYUGKrD1+av1XlFlinaagy/lhT5AQ+XQmH8CT6ppxQdFIBYBfWEUgj4EngWtM9ASvd2JiTE4R93fb6K7uD+NI1QF3ppkQagS1y7jHOfawZTjRBdoQqT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3Gyz5Jyyz4f3jkN;
	Mon, 25 Mar 2024 23:27:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BA7D31A019F;
	Mon, 25 Mar 2024 23:27:59 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgB35wr+lwFm8VTeIA--.54768S2;
	Mon, 25 Mar 2024 23:27:59 +0800 (CST)
Message-ID: <c0890fc2-53ea-401a-a3b4-a9bf6181a867@huaweicloud.com>
Date: Mon, 25 Mar 2024 23:27:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] riscv, bpf: Fix kfunc parameters incompatibility
 between bpf and riscv abi
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>,
 Network Development <netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?Q?l?= <bjorn@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240324103306.2202954-1-pulehui@huaweicloud.com>
 <CAADnVQLhfN7f6AFxa_19E0g2_YADEkrfPPffi43HeH9VCi8MqQ@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAADnVQLhfN7f6AFxa_19E0g2_YADEkrfPPffi43HeH9VCi8MqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB35wr+lwFm8VTeIA--.54768S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF47Ar4DArWDuFW5Gr43Awb_yoWrXw17pF
	15Jr1rCr4kXw1UZF17tr18Ar1akw1qva17ZFW8KF98CrWqgr95Gr1jk3yYq3Z5Cr18uF17
	ArZFvF42yw1kC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/3/25 2:40, Alexei Starovoitov wrote:
> On Sun, Mar 24, 2024 at 3:32 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
[SNIP]
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 869e4282a2c4..e3fc39370f7d 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1454,6 +1454,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>                  if (ret < 0)
>>                          return ret;
>>
>> +               if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>> +                       const struct btf_func_model *fm;
>> +                       int idx;
>> +
>> +                       fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
>> +                       if (!fm)
>> +                               return -EINVAL;
>> +
>> +                       for (idx = 0; idx < fm->nr_args; idx++) {
>> +                               u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
>> +
>> +                               if (fm->arg_size[idx] == sizeof(int))
>> +                                       emit_sextw(reg, reg, ctx);
>> +                       }
>> +               }
>> +
> 
> The btf_func_model usage looks good.
> Glad that no new flags were necessary, since both int and uint
> need to be sign extend the existing arg_size was enough.
> 
> Since we're at it. Do we need to do zero extension of return value ?
> There is
> __bpf_kfunc int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
> but the selftest with it is too simple:
>          return bpf_kfunc_call_test2((struct sock *)sk, 1, 2); >
> Could you extend this selftest with a return of large int/uint
> with 31th bit set to force sign extension in native

Sorry for late. riscv64 will sign-extend int/uint return values. I 
thought this would be a good test, so I tried the following:
```
u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym; <-- here change int to u32
int kfunc_call_test2(struct __sk_buff *skb)
{
	long tmp;
	
	tmp = bpf_kfunc_call_test2(0xfffffff0, 2);
	return (tmp >> 32) + tmp;
}
```
As expected, if the return value is sign-extended, the bpf program will 
return 0xfffffff1. If the return value is zero-extended, the bpf program 
will return 0xfffffff2. But in fact, riscv returns 0xfffffff2. Upon 
further discovery, it seems clang will compensate for unsigned return 
values. Curious!
for example:
```
u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym;
int kfunc_call_test2(struct __sk_buff *skb)
{
	long tmp;
	
	tmp = bpf_kfunc_call_test2(0xfffffff0, 2);
	bpf_printk("tmp: 0x%lx", tmp);
	return (tmp >> 32) + tmp;
}
```
and the bytecode will be:
```
  0:       18 01 00 00 00 00 00 f0 00 00 00 00 00 00 00 00 r1 = 
0xf0000000 ll
  2:       b7 02 00 00 02 00 00 00 r2 = 0x2
  3:       85 10 00 00 ff ff ff ff call -0x1
  4:       bf 06 00 00 00 00 00 00 r6 = r0
  5:       bf 63 00 00 00 00 00 00 r3 = r6
  6:       67 03 00 00 20 00 00 00 r3 <<= 0x20 <-- zero extension
  7:       77 03 00 00 20 00 00 00 r3 >>= 0x20
  8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
10:       b7 02 00 00 0b 00 00 00 r2 = 0xb
11:       85 00 00 00 06 00 00 00 call 0x6
12:       bf 60 00 00 00 00 00 00 r0 = r6
13:       95 00 00 00 00 00 00 00 exit
```

another example:
```
u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym;
int kfunc_call_test2(struct __sk_buff *skb)
{
	long tmp;
	
	tmp = bpf_kfunc_call_test2(0xfffffff0, 2);
	return (tmp >> 20) + tmp; <-- change from 32 to 20
}
```
and the bytecode will be:
```
  0:       18 01 00 00 00 00 00 f0 00 00 00 00 00 00 00 00 r1 = 
0xf0000000 ll
  2:       b7 02 00 00 02 00 00 00 r2 = 0x2
  3:       85 10 00 00 ff ff ff ff call -0x1
  4:       18 02 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 r2 = 
0xfff00000 ll <-- 32-bit truncation
  6:       bf 01 00 00 00 00 00 00 r1 = r0
  7:       5f 21 00 00 00 00 00 00 r1 &= r2
  8:       77 01 00 00 14 00 00 00 r1 >>= 0x14
  9:       0f 01 00 00 00 00 00 00 r1 += r0
10:       bf 10 00 00 00 00 00 00 r0 = r1
11:       95 00 00 00 00 00 00 00 exit
```

It is difficult to construct this test case.

> kernel risc-v code ?
> I suspect the bpf side will be confused.
> Which would mean that risc-v JIT in addition to:
>          if (insn->src_reg != BPF_PSEUDO_CALL)
>              emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
> 
> need to conditionally do:
>   if (fm->ret_size == sizeof(int))
>     emit_zextw(bpf_to_rv_reg(BPF_REG_0, ctx),
>                bpf_to_rv_reg(BPF_REG_0, ctx), ctx);
> ?

Agree on zero-extending int/uint return values ​​when returning from 
kfunc to bpf ctx. I will add it in next version. Thanks.


