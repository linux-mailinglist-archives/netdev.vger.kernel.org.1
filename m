Return-Path: <netdev+bounces-229194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC616BD9120
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AD03E76D8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD530FC28;
	Tue, 14 Oct 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VK9bY4Lu"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438430F81C
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442075; cv=none; b=ExN1mtCSoRG7Vbrif5bw1aKo1vkgeEmSWUMBwYhE5WCkyOMAf2QH5dqIvNZaJvbpo94kYny1zLfrCgfRyzrIuB0CQz0LSsY49X5G+/NznJRwYDgmO0N2DSg+ZlEmfxI0tA1WvGjuKNxBjMbozsYCsOs5q1AM0XtxHofrO/AIffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442075; c=relaxed/simple;
	bh=k7rFzhGNs/kmpPOUNJY06YMKy6Ze1Yf7spWA+73lqVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhTOH10ErxQLjpDcCdA//on7loo95nkj1dWuCFAmY1MzJHu++kXpqmaHc3I0kRAEq6RHGqIq5lppuOUG9hoNmDZtSHnbP2kH2WmNEJoDYVHDhOTNGORvua6V/+9lgbj9f78gWT2mROf+mwwhXE2yNB2Wwxeiw/+cBKw2//U2M5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VK9bY4Lu; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <096168a6-8687-4dae-a774-0741d3e5a891@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760442070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd2PoIE+rPMCr6jd3OwU3he0uZl4CmPgrMZ61+ge710=;
	b=VK9bY4LuIi4ji669KYN12TIOH35WJDu8pKASGIJSdi9qQhdHcSOS9ZOqAwGKpQPsCsa/MC
	Any8FgOqFuOI1eRpcwlhhwocJFbU9rKLsGQh3WYropHOaMHnqd5PxuOYzCW6qqbWxTyanS
	cCDvtJaYV62OHRnEZ5m/iARM6dBj9oQ=
Date: Tue, 14 Oct 2025 19:40:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3YzXSBodW5nX3Rh?=
 =?UTF-8?Q?sk=3A_Panic_after_fixed_number_of_hung_tasks?=
Content-Language: en-US
To: "Li,Rongqing" <lirongqing@baidu.com>, Petr Mladek <pmladek@suse.com>
Cc: "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 David Hildenbrand <david@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Russell King <linux@armlinux.org.uk>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Joel Granados <joel.granados@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Phil Auld <pauld@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Simon Horman <horms@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Florian Westphal <fw@strlen.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
 <3acdcd15-7e52-4a9a-9492-a434ed609dcc@linux.dev>
 <38af4922ca44433fa7cd168f7c520dc9@baidu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <38af4922ca44433fa7cd168f7c520dc9@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/14 19:18, Li,Rongqing wrote:
>>>>> Currently, when 'hung_task_panic' is enabled, the kernel panics
>>>>> immediately upon detecting the first hung task. However, some hung
>>>>> tasks are transient and the system can recover, while others are
>>>>> persistent and may accumulate progressively.
>>>
>>> My understanding is that this patch wanted to do:
>>>
>>>      + report even temporary stalls
>>>      + panic only when the stall was much longer and likely persistent
>>>
>>> Which might make some sense. But the code does something else.
>>
>> Cool. Sounds good to me!
>>
>>>
>>>>> --- a/kernel/hung_task.c
>>>>> +++ b/kernel/hung_task.c
>>>>> @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct
>> *t, unsigned long timeout)
>>>>>     	 */
>>>>>     	sysctl_hung_task_detect_count++;
>>>>> +	total_hung_task = sysctl_hung_task_detect_count -
>>>>> +prev_detect_count;
>>>>>     	trace_sched_process_hang(t);
>>>>> -	if (sysctl_hung_task_panic) {
>>>>> +	if (sysctl_hung_task_panic &&
>>>>> +			(total_hung_task >= sysctl_hung_task_panic)) {
>>>>>     		console_verbose();
>>>>>     		hung_task_show_lock = true;
>>>>>     		hung_task_call_panic = true;
>>>
>>> I would expect that this patch added another counter, similar to
>>> sysctl_hung_task_detect_count. It would be incremented only once per
>>> check when a hung task was detected. And it would be cleared (reset)
>>> when no hung task was found.
>>
>> Much cleaner. We could add an internal counter for that, yeah. No need to
>> expose it to userspace ;)
>>
>> Petr's suggestion seems to align better with the goal of panicking on
>> persistent hangs, IMHO. Panic after N consecutive checks with hung tasks.
>>
>> @RongQing does that work for you?
> 
> 
> In my opinion, a single task hang is not a critical issue, fatal hangs—such as those caused by I/O hangs, network card failures, or hangs while holding locks—will inevitably lead to multiple tasks being hung. In such scenarios, users cannot even log in to the machine, making it extremely difficult to investigate the root cause. Therefore, I believe the current approach is sound. What's your opinion?

Thanks! I'm fine with either approach. Let's hear what the other folks 
think ;)


