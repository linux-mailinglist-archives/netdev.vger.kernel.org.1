Return-Path: <netdev+bounces-84553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05159897480
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B463529329F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7B14BFAA;
	Wed,  3 Apr 2024 15:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AE143869;
	Wed,  3 Apr 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159459; cv=none; b=Ek5lLN28xKZzXeIKqaFaA8MA87PxQ0HdVeDdc+nM0lnQJ7zZlDJIUVQjDsb1VIxw4DavW8D0nF05V8vPo8SpqQO9+hIUiOT0SsV5CbfAImeff3vv3FLsmdsgTe4VLjE3qcFnKeq7oU3kh6HVnw+x15WWsX7QnQ2ORlN2jGPMBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159459; c=relaxed/simple;
	bh=3XDlgrsSdW7Oxyc1K1LSiJ6gv8+2nsZ5w1BYvAORxhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQGuNsTYLs6UaFvG6wmhCCG86nGr90nWg5iD6YXHe1/2tzG02nBS5t3QjhEG9XLgzx4h76s4FyrN7MqwaExD6Z0v4cKnFelkiT1VkwuQc0Ltx/MihHPnGIxoZ+jDAbFKyTphcvKZ9WLvtzyfR+zpzBpLzFQqr8cSMAVicAjVzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V8q3B0zpDz4f3jJ5;
	Wed,  3 Apr 2024 23:50:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A5B281A0568;
	Wed,  3 Apr 2024 23:50:52 +0800 (CST)
Received: from [10.82.3.99] (unknown [10.82.3.99])
	by APP1 (Coremail) with SMTP id cCh0CgDnAQvaeg1mi5PLIw--.46271S2;
	Wed, 03 Apr 2024 23:50:52 +0800 (CST)
Message-ID: <9bffde6f-ca7f-40d4-9b27-4e53ed274751@huaweicloud.com>
Date: Wed, 3 Apr 2024 23:50:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add testcase where 7th
 argment is struct
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240403072818.1462811-1-pulehui@huaweicloud.com>
 <20240403072818.1462811-3-pulehui@huaweicloud.com>
 <0f459fc1-1445-6e83-ace4-b2c42abfe884@iogearbox.net>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <0f459fc1-1445-6e83-ace4-b2c42abfe884@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnAQvaeg1mi5PLIw--.46271S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8urW5Aw4furW8Cw13CFg_yoW5AF4fpF
	18Xw15Kry8Jr4fAr17JrWUXFWFvr4kXw1UJry7JF15Zr1DGr10qF1Igr4j9F15Jr4kGr1a
	yw12qry5uryUXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/4/3 22:40, Daniel Borkmann wrote:
> On 4/3/24 9:28 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Add testcase where 7th argument is struct for architectures with 8
>> argument registers, and increase the complexity of the struct.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> Acked-by: Björn Töpel <bjorn@kernel.org>
>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>> ---
>>   tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++++++
>>   .../selftests/bpf/prog_tests/tracing_struct.c | 13 +++++++
>>   .../selftests/bpf/progs/tracing_struct.c      | 35 +++++++++++++++++++
>>   4 files changed, 68 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 
>> b/tools/testing/selftests/bpf/DENYLIST.aarch64
>> index d8ade15e2789..639ee3f5bc74 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
>> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
>> @@ -6,6 +6,7 @@ kprobe_multi_test                                # 
>> needs CONFIG_FPROBE
>>   module_attach                                    # prog 
>> 'kprobe_multi': failed to auto-attach: -95
>>   fentry_test/fentry_many_args                     # 
>> fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
>>   fexit_test/fexit_many_args                       # 
>> fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
>> +tracing_struct                                   # 
>> test_fentry:FAIL:tracing_struct__attach unexpected error: -524
> 
> Do we need to blacklist the whole test given it had coverage on arm64
> before.. perhaps this test here could be done as a new subtest and only
> that one is listed for arm64?

Yeah, I thought so at first, just like fexit_many_args of fentry/fexit, 
but I found that the things struct_tracing does are all in the same 
series, but the number or type of parameters are different, and the new 
use case I added is the same in this way. And I found that the execution 
logic of stract_tracing is relatively simple and clear, triggering all 
hook points, executing all bpf programs, and asserting all parameters.
Shall we need to slice them up?

> 
>>   fill_link_info/kprobe_multi_link_info            # 
>> bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>   fill_link_info/kretprobe_multi_link_info         # 
>> bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>   fill_link_info/kprobe_multi_invalid_ubuff        # 
>> bpf_program__attach_kprobe_multi_opts unexpected error: -95
> 
> Thanks,
> Daniel


