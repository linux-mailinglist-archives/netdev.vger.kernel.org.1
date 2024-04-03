Return-Path: <netdev+bounces-84384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3142896C9B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0728B2B9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5041487DF;
	Wed,  3 Apr 2024 10:32:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7D1482E1;
	Wed,  3 Apr 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140329; cv=none; b=Rey3cTEdrXRv6QQ1qz6TLt3APBqkAviPT9Cd+ABQwy3GVPpNeLoYcCHFUyHyCqLoH+/lX5LFfywVVrcrAwGUF9nNxhHGL5NYxLe/S6y3dxYSOGIK5PNTRo7ZQfM1RTSmP7e3XAZLk51Ro/w8KnVXdFb6GjTDEyxb9YZr0Fp3Ouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140329; c=relaxed/simple;
	bh=AwY3Gsc9AV2Km7e7jnYZB1dUudZG7WwX8VIo6+1zDtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGgf20dJ24iM82z1CImETS0RPbLj+kiytt8WpuNb0aqZ0ZeNGp7LWyl66L8GODqSqlVvTHuoF1jaVQoZBsM+r5dojeooyKM93h6HEAmlOM2SBk27Ymwdo1l3jbIuSgflwFGvZ1S18hz5p68P4sjNDWpoXvpkTBtWj50tAWupRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8gzL2CTFz4f3lXK;
	Wed,  3 Apr 2024 18:31:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 86A451A016E;
	Wed,  3 Apr 2024 18:32:02 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgAXOg0fMA1m63l0JA--.50696S2;
	Wed, 03 Apr 2024 18:32:00 +0800 (CST)
Message-ID: <6feb3403-4214-4143-b0bc-c95daf8eea2b@huaweicloud.com>
Date: Wed, 3 Apr 2024 18:31:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/5] Support local vmtest for riscv64
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Manu Bretelle <chantr4@gmail.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <32b3358903bf8ba408812a2636f39a275493eb91.camel@gmail.com>
 <e995a1f1-0b48-4ce3-a061-5cbe68beb6dd@huaweicloud.com>
 <f91237f311f183d57c4620bc2e6099df8aefccb0.camel@gmail.com>
 <52117f9c-b691-409f-ad2a-a25f53a9433d@huaweicloud.com>
 <f20d1e2a2f5fa10f29bf1fddbaf99c3f185e8530.camel@gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <f20d1e2a2f5fa10f29bf1fddbaf99c3f185e8530.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXOg0fMA1m63l0JA--.50696S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5Zw1xXF48tFW3Xw4rGrg_yoW5Ar1kpF
	47CF1Ivr1DJrn8twsFya4YyFWFvrZ5GF13Z3ykJ340yF909rWIgFsakFW5ZFZruryqq3yY
	v3y2vrWYy3ZrtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/4/3 7:40, Eduard Zingerman wrote:
> On Sat, 2024-03-30 at 18:12 +0800, Pu Lehui wrote:
> [...]
> 
>>> Looks like I won't be able to test this patch-set, unless you have
>>> some writeup on how to create a riscv64 dev environment at hand.
>>> Sorry for the noise
>>
>> Yeah, environmental issues are indeed a developer's nightmare. I will
>> try to do something for the newcomers of riscv64 bpf. At present, I have
>> simply built a docker local vmtest environment [0] based on Bjorn's
>> riscv-cross-builder. We can directly run vmtest within this environment.
>> Hopefully it will help.
>>
>> Link: https://github.com/pulehui/riscv-cross-builder/tree/vmtest [0]
> 
> Hi Pu,
> 
> Thank you for sharing the docker file, I've managed to run the tests
> using it. In order to avoid creating files with root permissions I had
> to add the following lines at the end of the Dockerfile:
> 
> + RUN useradd --no-create-home --uid 1000 eddy
> + RUN passwd -d eddy
> + RUN echo 'eddy ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
> + # vmtest.sh does 'mount -o loop',
> + # ensure there is a loop device in the container
> + RUN mknod /dev/loop0 b 7 20
> 
> Where 'eddy' is my local user with UID 1000.
> Probably this should be made more generic.
> I used the following command to start the container:
> 
> docker run -ti -u 1000:1000 \
>      --rm -v <path-to-kernel-dir>:/workspace \
>      -v <path-to-rootfs-image-dir>:/rootfs \
>      --privileged ubuntu-vmtest:latest /bin/bash
> 
> Also, I had to add '-d /rootfs/bpf_selftests' option for vmtest.sh in
> order to avoid polluting user directory inside the container.
> Maybe OUTPUT_DIR for vmtest.sh should be mounted as a separate volume.
> 
> I agree with Daniel, it would be great to document all of this

Forgot to reply to this in my last email. It my pleasure to do this.

> somewhere in the repo (or even scripted somehow).
> 
> Using the specified DENYLIST I get the following stats for test_progs:
> 
>    #3/2     arena_htab/arena_htab_asm:FAIL
>    #3       arena_htab:FAIL

Puranjay has submitted to riscv bpf arena and will be merged soon. So I 
didn't add it to DENYLIST.riscv64.

https://lore.kernel.org/bpf/20240326224943.86912-1-puranjay12@gmail.com/

>    #95      get_branch_snapshot:FAIL
>    #172/1   perf_branches/perf_branches_hw:FAIL
>    #172     perf_branches:FAIL

riscv sbi pmu driver not support branch sampling yet.  The following 
patch should be used for better regression.

https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?id=ea6873118493

>    #434/3   verifier_arena/basic_alloc3:FAIL
>    #434     verifier_arena:FAIL
>    Summary: 531/3581 PASSED, 64 SKIPPED, 4 FAILED
> 
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> 
>> PS: Since the current rootfs of riscv64 is not in the INDEX, I simply
>> modified vmtest.sh to support local rootfs.
> 
> Could you please add this change to the patch-set?

yep, will try to make it more convenient.

> 
> [...]


