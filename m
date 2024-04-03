Return-Path: <netdev+bounces-84267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF88962EA
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 05:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88631F24567
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75E1224C6;
	Wed,  3 Apr 2024 03:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4741BF5C;
	Wed,  3 Apr 2024 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114688; cv=none; b=NE5zlEFLB3wXjlYhvJxGrcJy2U5PRL/en0109QSXPqtOVA3TyvG/UAQFVr+yJ+AaYGeLUUDbh52vWtbesc5mXuVI7bH2Sgd8lbWOC3NqzYtAAl/q7t/kYmWPTGhLeco34YJt5rEeyWW1kDEqqx1E6tbwjaJcy+aUdGOz9nglIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114688; c=relaxed/simple;
	bh=A94+6bWLEorCLEX2BhGEGxlfRcLWmEelHOFm+jGI7to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=md2830YllWX+moVlXT30yHhfPWHc7604BVHzbe9KGkgBij5o++UTKs5jPwaZu8wloIFcPjQokgtrin0C/+dDNAIj52RdPvNRWljuI88aDP+2RG0igYWN2aji2SlMx+d6rSfuIAXy+B2fd1T+MmSVvL90bccOrH0yyCp2KdRUfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V8VV54Krlz4f3khf;
	Wed,  3 Apr 2024 11:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1D70B1A0175;
	Wed,  3 Apr 2024 11:24:36 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgAnRQ7yywxmOR2WIw--.30244S2;
	Wed, 03 Apr 2024 11:24:35 +0800 (CST)
Message-ID: <0626619d-5950-497e-aa67-a13cede9b300@huaweicloud.com>
Date: Wed, 3 Apr 2024 11:24:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add testcase where 7th
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
References: <20240331092405.822571-1-pulehui@huaweicloud.com>
 <20240331092405.822571-3-pulehui@huaweicloud.com>
 <967f996f-f660-4615-696e-95c5db0542ad@iogearbox.net>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <967f996f-f660-4615-696e-95c5db0542ad@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnRQ7yywxmOR2WIw--.30244S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4xJr4UAr47XF4rGF4DArb_yoW8Wr4rpa
	yxu34Y9rW8Xrs7Xry3AF4UZrW3JrWkWw1UZryxJayFvFyjgFyYgF40gw4Y9rn8Jrs3uw1a
	yF4jq3y5uw4DZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2024/4/2 22:02, Daniel Borkmann wrote:
> On 3/31/24 11:24 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Add testcase where 7th argument is struct for architectures with 8
>> argument registers, and increase the complexity of the struct.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++++++
>>   .../selftests/bpf/prog_tests/tracing_struct.c | 13 +++++++
>>   .../selftests/bpf/progs/tracing_struct.c      | 35 +++++++++++++++++++
>>   3 files changed, 67 insertions(+)
> 
> The last test from this patch fails BPF CI, ptal :
> 
> https://github.com/kernel-patches/bpf/actions/runs/8497262674/job/23275690303
> https://github.com/kernel-patches/bpf/actions/runs/8497262674/job/23275690364
> 
> Notice: Success: 519/3592, Skipped: 53, Failed: 1
> Error: #391 tracing_struct
>    Error: #391 tracing_struct
>    test_fentry:PASS:tracing_struct__open_and_load 0 nsec
>    libbpf: prog 'test_struct_arg_16': failed to attach: ERROR: 
> strerror_r(-524)=22
>    libbpf: prog 'test_struct_arg_16': failed to auto-attach: -524
>    test_fentry:FAIL:tracing_struct__attach unexpected error: -524 (errno 
> 524)
> Test Results:
>               bpftool: PASS
>            test_progs: FAIL (returned 1)
> Error: Process completed with exit code 1.

Thanks for your reminder. aarch64 does not yet support bpf trampoline 
with more than 8 parameters. I will add tracing_struct to DENYLIST.aarch64.


