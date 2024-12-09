Return-Path: <netdev+bounces-150230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198609E9886
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8748F2836C1
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956771ACED6;
	Mon,  9 Dec 2024 14:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15923233123;
	Mon,  9 Dec 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753685; cv=none; b=sdMSV3uoVKqddaSgPnyimx9SrDlnPxiEbT5UepghQIVRkalSk2aCOYXFwdQXfzDOSF9CAs0RlM7ZOEQor20rNot+yJubmdt/yIUKpyQL5gM4vtCKnoNlxTtJOYxTyd+Cpfb8MfqjfwPM6GjIgh+J5+Nw9xvbzlUMBXIP5Hd8vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753685; c=relaxed/simple;
	bh=X5h63I+ZHkVU/1MVgZhi3mgViCWNLCln4xzMKlyc0qw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SAUkaltXjRScgqWop6p0ICegs+fybOu/pFkgNwfwxLtUJs5B1WoYdC9C76sACpml3iAj/AEPhOkOm+mO+eNJvJYOHqEtg9JdsqTIPqG2jvA7xtNZHwMjn8aCWe69s0X77TOUx7f4SbL30IA2Vn+eH4z2GisxBFp53RFXP3blRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y6P276tx7z1kvfq;
	Mon,  9 Dec 2024 22:12:15 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 324811402CC;
	Mon,  9 Dec 2024 22:14:39 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Dec 2024 22:14:38 +0800
Message-ID: <058dff3c-126a-423a-8608-aa2cebfc13eb@huawei.com>
Date: Mon, 9 Dec 2024 22:14:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
	<wangpeiyang1@huawei.com>, <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the
 debugfs query result is inconsistent.
To: Jakub Kicinski <kuba@kernel.org>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
 <20241107133023.3813095-4-shaojijie@huawei.com>
 <20241111172511.773c71df@kernel.org>
 <e4396ecc-7874-4caf-b25d-870a9d897eb1@huawei.com>
 <20241113163145.04c92662@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241113163145.04c92662@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/11/14 8:31, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 13:59:32 +0800 Jijie Shao wrote:
>> inconsistent：
>> Before this modification,
>> if the previous read operation is stopped before complete, the buffer is not released.
>> In the next read operation (perhaps after a long time), the driver does not read again.
>> Instead, the driver returns the bufffer content, which causes outdated data to be obtained.
>> As a result, the obtained data is inconsistent with the actual data.
> I think the word "stale" would fit the situation better.
>
>> In this patch, ppos is used to determine whether a new read operation is performed.
>> If yes, the driver updates the data in the buffer to ensure that the queried data is fresh.
>> But, if two processes read the same file at once, The read operation that ends first releases the buffer.
>> As a result, the other read operation re-alloc buffer memory. However, because the value of ppos is not 0,
>> the data is not updated again. As a result, the queried data is truncated.
>>
>> This is a bug and I will fix it in the next version.
> Let's say two reads are necessary to read the data:
>
>   reader A                  reader B
>    read()
>     - alloc
>     - hns3_dbg_read_cmd()
>                             read()
>                             read()
>                             read(EOF)
>                              - free
>    read()
>     - alloc
>     - hns3_dbg_read_cmd()
>    read(EOF)
>     - free
>
> The data for read A is half from one hns3_dbg_read_cmd() and half from
> another. Does it not cause any actual inconsistency?
>
> Also, just to be sure, it's not possible to lseek on these files, right?

The patch of this version has the following problems:
  reader A                       reader B
   read()
    - alloc
    - *ppos == 0
     - hns3_dbg_read_cmd()
                                 read()
                                 read()
                                 read(EOF)
                                  - free
   read()
    - alloc
    - *ppos != 0
   read(EOF)
    - free
    
if reader B free the buffer, reader A will alloc a new buffer again,
but *ppos != 0, so hns3_dbg_read_cmd() will not be called.
So reader A cannot get the left data.

I plan to introduce the "need_update" variable in the next version,
with the default value is false. Run the alloc command to change the value to true：
  reader A                           reader B
   read()
    - need_update = false
    - alloc
       - need_update = true
    - *ppos == 0 || need_update
       - hns3_dbg_read_cmd()
                                     read()
                                     read()
                                     read(EOF)
                                     - free
   read()
    - alloc
      - need_update = true
    - *ppos == 0 || need_update
      - hns3_dbg_read_cmd()
   read(EOF)
    - free
So,  after reader A alloc a new buffer again, need_update will set to true.
hns3_dbg_read_cmd() will be called again to update data.

But there's still a problem：
The data for reader A is half from one hns3_dbg_read_cmd() and half from another.
However, due to the short interval between calls to hns3_dbg_read_cmd(),
and the fact that users do little to do like so, this problem is relatively acceptable.

We're also trying to fix the problem completely.
For example, an independent buffer is allocated for each reader:
  reader A                   reader B
   read()                    read()
   - alloc                   - alloc
     - hns3_dbg_read_cmd()    -hns3_dbg_read_cmd()
   read()                    read()
   read()                    read()
   read(EOF)                 read(EOF)
   - free                    - free
  
But, driver needs to maintain the mapping between the buffer and file.
And if the reader exits before read EOF, a large amount of memory is not free:
  reader
   read()
   - alloc
     - hns3_dbg_read_cmd()
   read()
   read()
   == reader exit ==
Maybe it's not a good way

As for lseek, driver needs to call lseek at the right time to reread the data.
  reader A                           reader B
    read()
    alloc
    hns3_dbg_read_cmd()
    *ppos == 0
    read()
                                     read()
                                     read()
                                     read(EOF)
                                     - free
    alloc
    hns3_dbg_read_cmd()
    - *ppos != 0
    - lseek()
    - *ppos == 0
    reread()
    read()
    read(EOF)
    free

I can't find any examples of similar implementations.
I'm not sure if there's a suitable lseek interface that the driver can call directly.


Another way is seq_file, which may be a solution,
as far as I know, each seq_file has a separate buffer and can be expanded automatically.
So it might be possible to solve the problem
But even if the solution is feasible, this will require a major refactoring of hns3 debugfs

Thanks
Jijie Shao



