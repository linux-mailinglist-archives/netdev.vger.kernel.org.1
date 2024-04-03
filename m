Return-Path: <netdev+bounces-84366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BE0896B9C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A70D1F294C8
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7445313DDAC;
	Wed,  3 Apr 2024 10:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019D13D61B;
	Wed,  3 Apr 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138746; cv=none; b=H8fDLAQI9Q/yhylsZnYQRO24lJKph6PRZHUoGINi8EeVHSlpJbDzkW+3g7p2J7j2I6XLjx2ZImqJx9NUJrhpGXY4gpUnCQiG+vyD02G5IWwSzuoX8h0mNRnQFe292ZRW2bpWC+2xis84dBzy1RJocMECGzJf47jQBJI8XlR6FtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138746; c=relaxed/simple;
	bh=olgsQH1bTYPGG9AtE4GyA/NCpvsSuDDkBqeFOxiuFj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGKlibfaPsNPbwEn+J1gSbtYoY3jIWr0M2ddhux0D05nwcacx/Xbbc8cMbbPzeGGAruSZybTqZBRmMNUYJElyRUE7TTn1r25qys5Is9dBbimkivmwJ0jj9158bwgHLsJyZgz+nczl47JF7o3g9PKzAfySXa5TKi+aqqAFp+gHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8gNv4TDxz4f3lXX;
	Wed,  3 Apr 2024 18:05:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D3EFD1A0172;
	Wed,  3 Apr 2024 18:05:39 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgD3R2ryKQ1m0FhPJA--.17610S2;
	Wed, 03 Apr 2024 18:05:39 +0800 (CST)
Message-ID: <d6eae62b-60fd-4f3c-92e4-7ea5f1c4fc68@huaweicloud.com>
Date: Wed, 3 Apr 2024 18:05:38 +0800
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
To: Conor Dooley <conor@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: Stefan O'Rear <sorear@fastmail.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
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
 <ed3debc9-f2a9-41fb-9cf9-dc6419de5c01@huaweicloud.com>
 <87cyr7rgdn.fsf@all.your.base.are.belong.to.us>
 <20240402-ample-preview-c84edb69db1b@spud>
 <871q7nr3mq.fsf@all.your.base.are.belong.to.us>
 <20240403-gander-parting-a47c56401716@spud>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20240403-gander-parting-a47c56401716@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3R2ryKQ1m0FhPJA--.17610S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur17Aw43Cw47GF15Xr15twb_yoW5Ar13pa
	95KF4Ika1DJr12y3sFyr48WrySvr1rCF45Grn8Gry8Awn8XF1xKrW2gr15CF97urZ7Kw1a
	vr48Jry2y3Z0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2024/4/3 9:20, Conor Dooley wrote:
> On Tue, Apr 02, 2024 at 09:00:45PM +0200, Björn Töpel wrote:
> 
>>>> I still think Lehui's patch is correct; Building a kernel that can boot
>>>> on multiple platforms (w/ or w/o Zbb support) and not having Zbb insn in
>>>> the kernel proper, and iff Zbb is available at run-time the BPF JIT will
>>>> emit Zbb.
>>>
>>> This sentence is -ENOPARSE to me, did you accidentally omit some words?
>>> Additionally he config option has nothing to do with building kernels that
>>> boot on multiple platforms, it only controls whether optimisations for Zbb
>>> are built so that if Zbb is detected they can be used.
>>
>> Ugh, sorry about that! I'm probably confused myself.
> 
> Reading this back, I a bunch of words too, so no worries...
> 
>>>> For these kind of optimizations, (IMO) it's better to let the BPF JIT
>>>> decide at run-time.
>>>
>>> Why is bpf a different case to any other user in this regard?
>>> I think that the commit message is misleading and needs to be changed,
>>> because the point "the hardware is capable of recognising the Zbb
>>> instructions independently..." is completely unrelated to the purpose
>>> of the config option. Of course the hardware understanding the option
> 
> This should have been "understanding the instructions"...
> 
>>> has nothing to do with kernel configuration. The commit message needs to
>>> explain why bpf is a special case and is exempt from an
> 
> And this s/from an//...
> 
>>> I totally understand any point about bpf being different in terms of
>>> needing toolchain support, but IIRC it was I who pointed out up-thread.
> 
> And "pointed that out".
> 
> I always make a mess of these emails that I re-write several times :)
> 
>>> The part of the conversation that you're replying to here is about the
>>> semantics of the Kconfig option and the original patch never mentioned
>>> trying to avoid a dependency on toolchains at all, just kernel
>>> configurations. The toolchain requirements I don't think are even super
>>> hard to fulfill either - the last 3 versions of ld and lld all meet the
>>> criteria.
>>
>> Thanks for making it more clear, and I agree that the toolchain
>> requirements are not hard to fulfull.
>>
>> My view has been that "BPF is like userland", but I realize now that's
>> odd.
> 
> Yeah, I can understand that perspective, but it does seem rather odd to
> someone that isn't a bpf-ist.
> 
>> Let's make BPF similar to the rest of the RV kernel. If ZBB=n, then
>> the BPF JIT doesn't know about emitting Zbb.
> 

Hi Conor and Björn,

Thanks for your explanation. I totally agree with what you said, 
"CONFIG_RISCV_ISA_ZBB only controls whether optimizations for Zbb are 
built so that if Zbb is detected they can be used.".

Since the instructions emited by bpf jit are in kernel space, they 
should indeed be aligned in this regard.

PS: It's a bit difficult to understand this,😅 if I'm wrong please don't 
hesitate to tell me.


