Return-Path: <netdev+bounces-84373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C307896BEC
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FF31C252B0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3539135A72;
	Wed,  3 Apr 2024 10:19:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA79135A6A;
	Wed,  3 Apr 2024 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139556; cv=none; b=fhi+OVnPJc6jvT6uEcuFHl3dMPpP0qRREQ8okheA6+/AfXkFrc//NJ/0c/M5DqIMrvSuWo1afXd7++SbnQ9++lnYLLaeKiMLjLOwkBmf/C8627/N4CQk776++Yp0iG3V8xjUbLpnepsQX2hNRRucrs5I7YF6KeyCUwshoN4p36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139556; c=relaxed/simple;
	bh=SWSVwwsyo4TWr/7EXyrUvFnrNKU5MSXAB4wMT6gT+YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=al1JXjLmW/LUbw5ZPjDL2hsEMgHm/+Y54MJMcLCFK1GPNoZIrMKh4ojNAS+ZlaJZAjhKjyBf/PZnPmw7u6LwdJAOkxu21PcmZBYgmQySMseXYEqziKIaau7ylteCB+LT9LfgikTB0j2alPO/3joaHXtJmrcWkVyAujQnmL7Cu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8ghQ5gHnz4f3kKV;
	Wed,  3 Apr 2024 18:19:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0C46C1A0CB3;
	Wed,  3 Apr 2024 18:19:07 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgCn+GoZLQ1mRk5QJA--.18103S2;
	Wed, 03 Apr 2024 18:19:06 +0800 (CST)
Message-ID: <bb6e839e-c840-4374-8014-5493cad45bdc@huaweicloud.com>
Date: Wed, 3 Apr 2024 18:19:05 +0800
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
To: Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Manu Bretelle <chantr4@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <878r1vrga9.fsf@all.your.base.are.belong.to.us>
 <5005fb56-086c-2aa7-e28b-83f0fc51f988@iogearbox.net>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <5005fb56-086c-2aa7-e28b-83f0fc51f988@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn+GoZLQ1mRk5QJA--.18103S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWUGrWUJry7tF4xKF18Grg_yoWktwcE9r
	Z2yr92vw4rA3Z2y3Z3Cr15Wr4DGr4xGFy8AF10qr98Xwn3Xa1kCan8Xr1fCa13X3yxJr9x
	Kan0qF4ayr1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/4/3 0:03, Daniel Borkmann wrote:
> On 4/2/24 4:27 PM, Björn Töpel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> This patch relaxes the restrictions on the Zbb instructions. The 
>>> hardware
>>> is capable of recognizing the Zbb instructions independently, 
>>> eliminating
>>> the need for reliance on kernel compile configurations.
>>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>
>> Should this patch really be part of this series?
> 
> No, that should be submitted independently.
> 

My initial thought was that I didn't enable CONFIG_RISCV_ISA_ZBB in 
config.riscv64, so I should loosen this restriction to enable zbb 
optimization. It could not be part of this series.

By the way, after reading what Conor and Björn said, I think we should 
align with kernel sematic, that is, emit zbb when CONFIG_RISCV_ISA_ZBB 
is enabled and so that if Zbb is detected they can be used.

> Also, given Eduard's comment, it would be great if you could add the
> instructions to tools/testing/selftests/bpf/README.rst even if not in
> a perfect shape, but it would give developers a chance to get started.
> 
> Thanks,
> Daniel


