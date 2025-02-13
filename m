Return-Path: <netdev+bounces-166232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D40A351A4
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 23:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD516ECE2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9A2753E4;
	Thu, 13 Feb 2025 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="kjyLStIo"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303E2753E0
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487114; cv=none; b=hUhH59Of6xlDOg7P5gkSxnrL0i35hPTuB/nlhGmo15XZZkNy0k6RcnIjyXChNDzHPJoD4vHsrke+WWY97E6PHIo6IVDXNT4OceboyiISrullNcYFm+6iounBL46YgDUY5Z5o9wtkYXyPDpS9VxwE4woosK9D4hYIQX+vIW696oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487114; c=relaxed/simple;
	bh=UAtrDPA3Si93SMzuBSLoUA0tumdmOWJ8BWijgQamyqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bS8oKKSF1ryvRnQ/Zs2kkLf8KtcYVTa4EvBAtcae4IqGAasi1IoDLQYoFq+6D1dgpGQI1rSEceQ6H+ADUWr+kcJi1ZrEtqYVT+vD2WosPAdVP3hGnfDFPiCGc14xhTXV1uNGiH7NO8cqtM3BVUmsRjlA2dpw7ErZvj57Bz+pIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=kjyLStIo; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [10.136.6.34] (unknown [213.221.151.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 07B58200DFB0;
	Thu, 13 Feb 2025 23:51:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 07B58200DFB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739487110;
	bh=VtoWZ3ftCUdSScHKsI74dhpVOKt0I/TqRYCT4+tCvfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kjyLStIo4se6/D0mOH++lvm8fUJrfiEgLsoc9ltdKZYrbuetj9BjKjidyOLVChjxq
	 JdsuymBkRBHcU+QddxIhwy0BdpNkR3AAKZejHRhadkqN0ZRbojz3lpblX0z+RXxuRU
	 xvrCx0o+E7Pui3UHO0VZyv06nLlq+Vx8Bq2SigeEWm9h2hXK8wwVimtsICmlobBSrj
	 CVvIw5qBm0PCKDlVZEhPmpSanlM0bkFDAhcntgxDXqBV3myNRtmAcM9QpQqKP7P5tr
	 ZO1XWPdva8kJyq6PGvHb6Q7EVimiPhREkjbx/78NUNR4OksUAB7lJbAgb+G+u1eBHR
	 JcoJRe/fZKYVg==
Message-ID: <a375f869-9fc3-4a58-a81a-c9c8175463dd@uliege.be>
Date: Thu, 13 Feb 2025 23:51:49 +0100
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
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <Z63zgLQ_ZFmkO9ys@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/25 14:28, Ido Schimmel wrote:
> On Tue, Feb 11, 2025 at 11:16:23PM +0100, Justin Iurman wrote:
>> When the destination is the same post-transformation, we enter a
>> lwtunnel loop. This is true for ioam6_iptunnel, rpl_iptunnel, and
>> seg6_iptunnel, in both input() and output() handlers respectively, where
>> either dst_input() or dst_output() is called at the end. It happens for
>> instance with the ioam6 inline mode, but can also happen for any of them
>> as long as the post-transformation destination still matches the fib
>> entry. Note that ioam6_iptunnel was already comparing the old and new
>> destination address to prevent the loop, but it is not enough (e.g.,
>> other addresses can still match the same subnet).
>>
>> Here is an example for rpl_input():
>>
>> dump_stack_lvl+0x60/0x80
>> rpl_input+0x9d/0x320
>> lwtunnel_input+0x64/0xa0
>> lwtunnel_input+0x64/0xa0
>> lwtunnel_input+0x64/0xa0
>> lwtunnel_input+0x64/0xa0
>> lwtunnel_input+0x64/0xa0
>> [...]
>> lwtunnel_input+0x64/0xa0
>> lwtunnel_input+0x64/0xa0
>> lwtunnel_input+0x64/0xa0
>> lwtunnel_input+0x64/0xa0
>> lwtunnel_input+0x64/0xa0
>> ip6_sublist_rcv_finish+0x85/0x90
>> ip6_sublist_rcv+0x236/0x2f0
>>
>> ... until rpl_do_srh() fails, which means skb_cow_head() failed.
>>
>> This patch prevents that kind of loop by redirecting to the origin
>> input() or output() when the destination is the same
>> post-transformation.
> 
> A loop was reported a few months ago with a similar stack trace:
> https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
> 
> But even with this series applied my VM gets stuck. Can you please check
> if the fix is incomplete?

Good catch! Indeed, seg6_local also needs to be fixed the same way.

Back to my first idea: maybe we could directly fix it in 
lwtunnel_input() and lwtunnel_output() to make our lives easier, but 
we'd have to be careful to modify all users accordingly. The users I'm 
100% sure that are concerned: ioam6 (output), rpl (input/output), seg6 
(input/output), seg6_local (input). Other users I'm not totally sure (to 
be checked): ila (output), bpf (input).

Otherwise, we'll need to apply the fix to each user concerned (probably 
the safest (best?) option right now). Any opinions?

