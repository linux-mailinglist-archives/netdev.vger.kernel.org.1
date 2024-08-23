Return-Path: <netdev+bounces-121248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84A95C58F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4181C2116A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B9B6F2F4;
	Fri, 23 Aug 2024 06:35:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FA748A;
	Fri, 23 Aug 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394918; cv=none; b=jmPE7b/w7p96gnFCxh/l2BPBeiuRbz7uzEdVFPjM//WfWFrnRmJk/6bP/ZFk3ZOybVvYuUzt2s6MT+Pl5Z9J95PmCPYEPayKITHiK8Sgkg73PE/xS7N42XZvsIf7l0SSEMrrwq4Bg7NhpYROszuutj5nwY1LHoE6t4Ho4jcrtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394918; c=relaxed/simple;
	bh=Q3jJpDkjIJIQmMU7LSiBqtpkSvQbFa+Nr1fIpQ2Bzac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XlPTpys27yhzSFFGXttDKdNRw2Pr/94RmAE2cP/exKJYn8o7CesW86oEDGLnRlKYef+Jsio/QLBBRj5jCRhT6MZZ8i20KkS4NfTBamOyiO24cAHErrDuQbH4nW3cULSNfonIFR6rWYrJ9pjHqWWaUnZlhR+afK6N2KCsZYbLfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wqqv23Tstz20mNt;
	Fri, 23 Aug 2024 14:30:22 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2636B1A016C;
	Fri, 23 Aug 2024 14:35:06 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Aug 2024 14:35:05 +0800
Message-ID: <0d2ac86a-dc01-362a-e444-e72359d1f0b7@huawei.com>
Date: Fri, 23 Aug 2024 14:35:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] net: dsa: Simplify with scoped for each OF child
 loop
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240820065804.560603-1-ruanjinjie@huawei.com>
 <20240821171817.3b935a9d@kernel.org>
 <2d67e112-75a0-3111-3f3a-91e6a982652f@huawei.com>
 <20240822075123.55da5a5a@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240822075123.55da5a5a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/22 22:51, Jakub Kicinski wrote:
> On Thu, 22 Aug 2024 10:07:25 +0800 Jinjie Ruan wrote:
>> On 2024/8/22 8:18, Jakub Kicinski wrote:
>>> On Tue, 20 Aug 2024 14:58:04 +0800 Jinjie Ruan wrote:  
>>>> Use scoped for_each_available_child_of_node_scoped() when iterating over
>>>> device nodes to make code a bit simpler.  
>>>
>>> Could you add more info here that confirms this works with gotos?
>>> I don't recall the details but I thought sometimes the scoped
>>> constructs don't do well with gotos. I checked 5 random uses
>>> of this loop and 4 of them didn't have gotos.  
>>
>> Hi, Jakub
>>
>> From what I understand, for_each_available_child_of_node_scoped() is not
>> related to gotos, it only let the iterating child node self-declared and
>> automatic release, so the of_node_put(iterating_child_node) can be removed.
> 
> Could you either test it or disasm the code to double check, please?

Hi, Jakub, I test it with a fake device node on QEMU with a simple
example using for_each_available_child_of_node_scoped() and goto out of
the scope of for_each_available_child_of_node_scoped(), the
of_node_put(child) has been called successfully.


