Return-Path: <netdev+bounces-78427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DAF87510E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 14:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F050F1F21AB3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAF012D1F9;
	Thu,  7 Mar 2024 13:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26015F86B;
	Thu,  7 Mar 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819804; cv=none; b=uRNb0MTXqRB0+PZqQhs53L8BA8u9026xwqECMHddWPoDvPY6DaBvaR2+j4Cgf30KXPTuJdp05hSnickPaAp0U8/EnuYbCZjZIX7TeD8KBvYjtwENnm8BODubRBRA1/X8XAX/5UH8T6a65l9f5xpkr2tVVUeM/tbG2EErKmWIhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819804; c=relaxed/simple;
	bh=eZunBR5IonjfmCLeU/OwM5mH/pBJdEWF78x9j91cTus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UwTSJbYenCYLZNOkOQffzCElPFYWn9j3O7im852Yl3iC9GSqaQgMKdVC2UMbfzsgbit9zork4a0lnZYzXXlAy+JwZtlpWkNtOmWtWouN8c1+sjsP1wjY8Df8xTr6dlABjFLr9OcIVX3h4/QQJaWYQqAYpYf6CK//CY89cninKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tr9lD5RKGz1h1ZX;
	Thu,  7 Mar 2024 21:54:16 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id ABF311A016E;
	Thu,  7 Mar 2024 21:56:38 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 21:56:38 +0800
Message-ID: <b4516819-8cc7-46eb-b4ea-9ffd1a0c51e6@huawei.com>
Date: Thu, 7 Mar 2024 21:56:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] xdp, bonding: Fix feature flags when there are no
 slave devs anymore
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <prbatra.mail@gmail.com>, <toke@redhat.com>,
	<kuba@kernel.org>
References: <20240305090829.17131-1-daniel@iogearbox.net>
 <170968502778.5704.4519517843918140180.git-patchwork-notify@kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <170968502778.5704.4519517843918140180.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100009.china.huawei.com (7.221.188.135)


On 2024/3/6 8:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
> 
> On Tue,  5 Mar 2024 10:08:28 +0100 you wrote:
>> Commit 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
>> changed the driver from reporting everything as supported before a device
>> was bonded into having the driver report that no XDP feature is supported
>> until a real device is bonded as it seems to be more truthful given
>> eventually real underlying devices decide what XDP features are supported.
>>
>> The change however did not take into account when all slave devices get
>> removed from the bond device. In this case after 9b0ed890ac2a, the driver
>> keeps reporting a feature mask of 0x77, that is, NETDEV_XDP_ACT_MASK &
>> ~NETDEV_XDP_ACT_XSK_ZEROCOPY whereas it should have reported a feature
>> mask of 0.
>>
>> [...]
> 
> Here is the summary with links:
>    - [bpf,1/2] xdp, bonding: Fix feature flags when there are no slave devs anymore
>      https://git.kernel.org/bpf/bpf/c/f267f2628150
>    - [bpf,2/2] selftests/bpf: Fix up xdp bonding test wrt feature flags
>      https://git.kernel.org/bpf/bpf/c/0bfc0336e134

I had encountered the same issue during riscv bpf selftest regression. 
Happy to see this fixes.

> 
> You are awesome, thank you!

