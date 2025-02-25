Return-Path: <netdev+bounces-169596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E4A44AD3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06F3189C865
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F1194A66;
	Tue, 25 Feb 2025 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="cy1FH/Td"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914C8172A
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509263; cv=none; b=XqiDeGKN9YK83+aW6ZXah2pHLeEPNAfszdllFJqaMxLsEf8B2DOTpyZzKqklEoOEW1jfSsM4GQ4q81ve5vuD5/5I/6kts2TuNmQxoLXi+XbOpPFl2TUA6Sdv+axbcSPSmJ0DrdulnBiPDLzYBmpNRFTauth/cPWu2LnwAVFSjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509263; c=relaxed/simple;
	bh=g1yscw+MXTXtaw6RU0l1o5sI27K4/k/RjH1Ey7Z3rJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bizg/4MRwlY+nm0ajRp/PTGOHx0NzGMw85QNHrP+PQsLu1GMznRxIufVSnLwAeIDqS+bjZfu268o02RjZBHTovEUNhfjNXyZdsFJtQ/SpygmoQEIUrisfRDS0MHrzptiE8WmLYkVAfQ42FObB7ELbTnLUBBg4hC2NXAfwaR92SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=cy1FH/Td; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id BB8EE200E2BC;
	Tue, 25 Feb 2025 19:47:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be BB8EE200E2BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1740509259;
	bh=86QSQes0SjgKZ/+AEit4N0CDIj0TAxvtYKz1XwSeua8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cy1FH/TdJ71UtnQggccPsbsu9p0LtCecFbGFnfTsC2o9FMOtZEnWz9WwhSuGcxCcP
	 khlilwsTjBrAwAssJRS+11yrHeAMmlnW+z4fXBl720ienkxvjNytvZfO7QrRbw/AZC
	 Rxoml1+lCGqyBnDpyHkUhYiJMO6rj00ljaazj7oOhEKU8zPYFO6ZN2wTSHuCqmISnK
	 pLTmBjztk2d27/hJ3xsbt7CnLJNQMTXpMzcGsY8SUvqAXfwmgQHbwuqenWPvPZDf50
	 7G0ckPa+c3Ty5XaQCfnw0HqdKz3gnhU09qboiArh6JYHcJ2ij1XbahCzEj4mmpuP9S
	 IKdk7z1hx9vxw==
Message-ID: <a96fded7-970f-488f-81b4-8ec1dd32647d@uliege.be>
Date: Tue, 25 Feb 2025 19:47:39 +0100
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
 <Z7NKYMY7fJT5cYWu@shredder>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <Z7NKYMY7fJT5cYWu@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/25 15:40, Ido Schimmel wrote:
> On Sun, Feb 16, 2025 at 06:31:06PM +0200, Ido Schimmel wrote:
>> On Thu, Feb 13, 2025 at 11:51:49PM +0100, Justin Iurman wrote:
>>> On 2/13/25 14:28, Ido Schimmel wrote:
>>>> On Tue, Feb 11, 2025 at 11:16:23PM +0100, Justin Iurman wrote:
>>>>> When the destination is the same post-transformation, we enter a
>>>>> lwtunnel loop. This is true for ioam6_iptunnel, rpl_iptunnel, and
>>>>> seg6_iptunnel, in both input() and output() handlers respectively, where
>>>>> either dst_input() or dst_output() is called at the end. It happens for
>>>>> instance with the ioam6 inline mode, but can also happen for any of them
>>>>> as long as the post-transformation destination still matches the fib
>>>>> entry. Note that ioam6_iptunnel was already comparing the old and new
>>>>> destination address to prevent the loop, but it is not enough (e.g.,
>>>>> other addresses can still match the same subnet).
>>>>>
>>>>> Here is an example for rpl_input():
>>>>>
>>>>> dump_stack_lvl+0x60/0x80
>>>>> rpl_input+0x9d/0x320
>>>>> lwtunnel_input+0x64/0xa0
>>>>> lwtunnel_input+0x64/0xa0
>>>>> lwtunnel_input+0x64/0xa0
>>>>> lwtunnel_input+0x64/0xa0
>>>>> lwtunnel_input+0x64/0xa0
>>>>> [...]
>>>>> lwtunnel_input+0x64/0xa0
>>>>> lwtunnel_input+0x64/0xa0
>>>>> lwtunnel_input+0x64/0xa0
>>>>> lwtunnel_input+0x64/0xa0
>>>>> lwtunnel_input+0x64/0xa0
>>>>> ip6_sublist_rcv_finish+0x85/0x90
>>>>> ip6_sublist_rcv+0x236/0x2f0
>>>>>
>>>>> ... until rpl_do_srh() fails, which means skb_cow_head() failed.
>>>>>
>>>>> This patch prevents that kind of loop by redirecting to the origin
>>>>> input() or output() when the destination is the same
>>>>> post-transformation.
>>>>
>>>> A loop was reported a few months ago with a similar stack trace:
>>>> https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
>>>>
>>>> But even with this series applied my VM gets stuck. Can you please check
>>>> if the fix is incomplete?
>>>
>>> Good catch! Indeed, seg6_local also needs to be fixed the same way.
>>>
>>> Back to my first idea: maybe we could directly fix it in lwtunnel_input()
>>> and lwtunnel_output() to make our lives easier, but we'd have to be careful
>>> to modify all users accordingly. The users I'm 100% sure that are concerned:
>>> ioam6 (output), rpl (input/output), seg6 (input/output), seg6_local (input).
>>> Other users I'm not totally sure (to be checked): ila (output), bpf (input).
>>>
>>> Otherwise, we'll need to apply the fix to each user concerned (probably the
>>> safest (best?) option right now). Any opinions?
>>
>> I audited the various lwt users and I agree with your analysis about
>> which users seem to be effected by this issue.
>>
>> I'm not entirely sure how you want to fix this in
>> lwtunnel_{input,output}() given that only the input()/output() handlers
>> of the individual lwt users are aware of both the old and new dst
>> entries.
>>
>> BTW, I noticed that bpf implements the xmit() hook in addition to
>> input()/output(). I wonder if a loop is possible in the following case:
>>
>> ip_finish_output2()                                         <----+
>> 	lwtunnel_xmit()                                          |
>> 		bpf_xmit()                                       |
>> 			// bpf program does not change           |
>> 			// the packet and returns                |
>> 			// BPF_LWT_REROUTE                       |
>> 			bpf_lwt_xmit_reroute()                   |
>> 				// unmodified packet resolves    |
>> 				// the same dst entry            |
>> 				dst_output()                     |
>> 					ip_output() -------------+
> 
> FWIW, verified that this is indeed the case. Reproducer:
> 
> $ cat lwt_xmit_repo.bpf.c
> // SPDX-License-Identifier: GPL-2.0
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> 
> SEC("lwt_xmit")
> int repo(struct __sk_buff *skb)
> {
>          return BPF_LWT_REROUTE;
> }
> $ clang -O2 -target bpf -c lwt_xmit_repo.bpf.c -o lwt_xmit_repo.o
> # ip link add name dummy1 up type dummy
> # ip route add 192.0.2.0/24 nexthop encap bpf xmit obj ./lwt_xmit_repo.o sec lwt_xmit dev dummy1
> # ping 192.0.2.1

Thanks, Ido, appreciate. I'll post a new series based on this (#2) patch 
to take all users into account. Note that the new logic I described 
previously to solve the issue could be applied to lwtunnel_xmit() too. I 
wonder what others might think about it.

