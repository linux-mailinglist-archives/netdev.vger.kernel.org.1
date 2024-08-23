Return-Path: <netdev+bounces-121211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F00595C331
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 04:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A142846D7
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0851D68F;
	Fri, 23 Aug 2024 02:22:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D51CD31;
	Fri, 23 Aug 2024 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379767; cv=none; b=T4+JJWoOjnMVvcgdlWOn58LCsXWEWlyrDVL1DH2WoEg58wTS2RqIw1SfdvIgjuca2yivAyDYjUEpv966RdwlypNeQpadHIZvPwbCxWwq32SXzObKkcy6hPqfXtrXUrYB1M8E/Z1IAljH03OFDXt4IsZLClwotp1DS5QN273y4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379767; c=relaxed/simple;
	bh=8KL7MTrygBMgomFjnluh/MCBLYW4sB+6AgAp1hrLzug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LHgIo37MaWXRURKQPJb5vX4RY+kCAGKm3frYGUWgUkge0g1+8kpTds8nC9GKV7vBtKWxhvQpt8lkhg86z3SXCOyOU4S9JPszOWjyIqWb3J51Up59t1E1GRZS6UyuQixj8ogxmIfWny8p7DdE672aA2NWeuft8QDzVindFoJff0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WqkNN1N0wz13vKd;
	Fri, 23 Aug 2024 10:21:56 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FED41800D2;
	Fri, 23 Aug 2024 10:22:37 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Aug 2024 10:22:36 +0800
Message-ID: <c8bedc8c-2985-d32d-3f4c-62b725ba822d@huawei.com>
Date: Fri, 23 Aug 2024 10:22:35 +0800
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Thank you! I'll try to test it and double check it.


