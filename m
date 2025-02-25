Return-Path: <netdev+bounces-169591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD68CA44AC1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B7E860CED
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7E19B5B4;
	Tue, 25 Feb 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="gN6APM9D"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836481A2392
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508611; cv=none; b=XWttHL+/nTi3xht4L3hTAU3p2gBay42U3j4fnew5D2cJd+ENTmvplMHvGDQ0IV4FYmJl6Vwfy5TrkdP2Fwoe/aoHpZrcXEu+UO16SrrRDw8kVPDsdUgZwdwr9a/V9Ebla05zXbOJxqa1YE8L61YxJXcYATg15aiKe6rfWdw7YnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508611; c=relaxed/simple;
	bh=GDYXtvbh87M4jA9Yf67OTbD8hZcmjQEkRG280jMADfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dprHZeYLlFYpWjsllXMDIg0XILENvgDlb154yWq5wKpjHcdxiEVaHDjJMATS95nGlATcSsT4gMYdfkAP5352eQppdsum/ZSxuI3zpoGGmEgZqhgOz953KXBQSLnfz64hT1zhCVeR/DwbPvz5N8mangUyM+jGzkoB7eN59gnIBQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=gN6APM9D; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id BF1C9200E2BD;
	Tue, 25 Feb 2025 19:36:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be BF1C9200E2BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1740508607;
	bh=s5xgb3xloy/EFWinVmbOjbANWLDdpM+4OjDM9+M17ZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gN6APM9DGx6ifuXNS0/0Cl9in7bbb1r6LZ6mOLrzmASg4rzTVjBfvwhPFgRvSjRX5
	 korpRv+QbMTRt6Kd38BVbGa8oQ5g3oc14a7PMbu/qIwLN4P/yOOQIiJlgRcQtySJqU
	 3X4WvJim869KD52yi63R9gGQHW8t4N/z3hiV7q/YxbAfBnc9v+aRGmeov6H2Y/0wD+
	 ZVbzRO+dK4GxsRgZgUyVTmxZdHk+Pz32JDhf3VjdInBTD6TZ6GMhKg+MR1tWOfPluv
	 dx+TIhuMhPJUE54QDLv1NWVCXXx+/2rWfVLUAFuPtiaSgA8K+EITXa41MgjWfGsFPX
	 Pj3tv6Y4rhOYg==
Message-ID: <87ad31d7-2ef6-47ca-be31-2ba2ac85d708@uliege.be>
Date: Tue, 25 Feb 2025 19:36:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net: ipv6: fix lwtunnel loops in ioam6, rpl
 and seg6
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Alexander Aring <alex.aring@gmail.com>, David Lebrun <dlebrun@google.com>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-3-justin.iurman@uliege.be> <Z63zgLQ_ZFmkO9ys@shredder>
 <a375f869-9fc3-4a58-a81a-c9c8175463dd@uliege.be> <Z7ISxnU0QhtRGTnb@shredder>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <Z7ISxnU0QhtRGTnb@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/25 17:31, Ido Schimmel wrote:
> On Thu, Feb 13, 2025 at 11:51:49PM +0100, Justin Iurman wrote:
>> On 2/13/25 14:28, Ido Schimmel wrote:
>>> On Tue, Feb 11, 2025 at 11:16:23PM +0100, Justin Iurman wrote:
>>>> When the destination is the same post-transformation, we enter a
>>>> lwtunnel loop. This is true for ioam6_iptunnel, rpl_iptunnel, and
>>>> seg6_iptunnel, in both input() and output() handlers respectively, where
>>>> either dst_input() or dst_output() is called at the end. It happens for
>>>> instance with the ioam6 inline mode, but can also happen for any of them
>>>> as long as the post-transformation destination still matches the fib
>>>> entry. Note that ioam6_iptunnel was already comparing the old and new
>>>> destination address to prevent the loop, but it is not enough (e.g.,
>>>> other addresses can still match the same subnet).
>>>>
>>>> Here is an example for rpl_input():
>>>>
>>>> dump_stack_lvl+0x60/0x80
>>>> rpl_input+0x9d/0x320
>>>> lwtunnel_input+0x64/0xa0
>>>> lwtunnel_input+0x64/0xa0
>>>> lwtunnel_input+0x64/0xa0
>>>> lwtunnel_input+0x64/0xa0
>>>> lwtunnel_input+0x64/0xa0
>>>> [...]
>>>> lwtunnel_input+0x64/0xa0
>>>> lwtunnel_input+0x64/0xa0
>>>> lwtunnel_input+0x64/0xa0
>>>> lwtunnel_input+0x64/0xa0
>>>> lwtunnel_input+0x64/0xa0
>>>> ip6_sublist_rcv_finish+0x85/0x90
>>>> ip6_sublist_rcv+0x236/0x2f0
>>>>
>>>> ... until rpl_do_srh() fails, which means skb_cow_head() failed.
>>>>
>>>> This patch prevents that kind of loop by redirecting to the origin
>>>> input() or output() when the destination is the same
>>>> post-transformation.
>>>
>>> A loop was reported a few months ago with a similar stack trace:
>>> https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
>>>
>>> But even with this series applied my VM gets stuck. Can you please check
>>> if the fix is incomplete?
>>
>> Good catch! Indeed, seg6_local also needs to be fixed the same way.
>>
>> Back to my first idea: maybe we could directly fix it in lwtunnel_input()
>> and lwtunnel_output() to make our lives easier, but we'd have to be careful
>> to modify all users accordingly. The users I'm 100% sure that are concerned:
>> ioam6 (output), rpl (input/output), seg6 (input/output), seg6_local (input).
>> Other users I'm not totally sure (to be checked): ila (output), bpf (input).
>>
>> Otherwise, we'll need to apply the fix to each user concerned (probably the
>> safest (best?) option right now). Any opinions?
> 
> I audited the various lwt users and I agree with your analysis about
> which users seem to be effected by this issue.
> 
> I'm not entirely sure how you want to fix this in
> lwtunnel_{input,output}() given that only the input()/output() handlers
> of the individual lwt users are aware of both the old and new dst
> entries.

Right. The idea was to compare "orig_dst" with "new dst" before/after a 
call to input()/output() in lwtunnel_input()/lwtunnel_output(). Which, 
of course, would require to modify each of those input/output handlers 
respectively, so that they don't call dst_input()/dst_output() nor 
orig_input()/orig_output() anymore. Would be easier to apply the fix at 
that level, instead of each one by one.

