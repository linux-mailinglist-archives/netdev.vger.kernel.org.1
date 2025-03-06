Return-Path: <netdev+bounces-172538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3BDA554BB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A867B3B9B15
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF125DB02;
	Thu,  6 Mar 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="2sgfXjRV"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3B25D54C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284880; cv=none; b=O3A7kriSsEazosa+JuFkJwywqX+As8oa+iCWcbufuLHdbKDJ9D2oIYOKKERDgbnn9kspwMMzO2vyaRc5vkGHTbjn1jz7apOCbYYWnp1T9Qjt2eTVHky4kSWgcmOWWTWsgz2zR+E8MPeFgYsqcf50K8KvUHbKx4ynodVgTopEjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284880; c=relaxed/simple;
	bh=nj39y0/RLYdLxWetQ5NcBQHnVx5h7Q6DfqoJEQ8PqtI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PofMQncfkbKxHNaQhgW6ToZFyNH84aFs74p8ATrggdW+ud8cgOwqdDgrhUs5G9T5trSNxO0kA57Ya5lpMw1CZ6p0/V0GfL0JAb/FHv2LI+Kiv1EFuR5vKgZeZnV9qpf7yw6Akxz+mtWyot5gorIar7hw8T686omTpJTCubwQ0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=2sgfXjRV; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id F32282011FC6;
	Thu,  6 Mar 2025 19:14:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be F32282011FC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741284870;
	bh=QCs7Kgi6Q1FZhgoOgT6487jEkyHPvKkB6c/NEG4l4S0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=2sgfXjRVW3Z13ilaJFCYmIOHJiQRnc5ShMHEAe+y/50YJIOLZ41nXv9Jg7IQWU2yg
	 fcEmCn7raSDS7V6txO1I86Q+oes7PDI+zprgIokII8kMCZriqZw27Ap/pkLi2+/fT9
	 FJ53gAna10SGurLZiMMjQ897bCWv6AEKsuYqVELfeDxeNp2h/pTkf4TGqcHaEaY385
	 MeiRba1C4WRUvjor3xa/Wr7F0h78SSwvpAVROjbmZq87xoZ8D9DKSPtnLlYj+jp6R1
	 0qiqpsQy86fnwkufqvzfafO5xHEkwXpD6cvVrOnsKrEqlRoc9eHkIex9theF4Dqble
	 iwR2o5YCcOcqA==
Message-ID: <df2bda3f-11ac-4c13-9d92-b44ea0f81da6@uliege.be>
Date: Thu, 6 Mar 2025 19:14:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Justin Iurman <justin.iurman@uliege.be>
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

Ido,

That loop is another beast which is out of scope of the series I'm about 
to send. Indeed, what I'm doing right now is to prevent reentry loops 
within lwtunnel_{input|output}(). Which, by the way, is also applied to 
seg6_local no matter what. The reported loop above is an infinite ping 
pong game between two fib rules (vs an infinite loop within the same fib 
rule -- what I'm fixing). If we want to fix that issue as well, we may 
reuse something like dev_xmit_recursion() in 
lwtunnel_{input|output|xmit}() to catch these buggy cases. Thoughts?

>> [...]
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

This one's also something special because it's neither input nor output, 
it's xmit. In that case, we cannot apply the same fix as for the others 
(ioam6, rpl, seg6, ila). Here, what I suggest is simply to disallow 
BPF_LWT_REROUTE when the dst_entry remains unchanged (which is, IMO, a 
buggy case), as follows:

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index ae74634310a3..ee3546d78903 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -180,6 +180,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
         struct net_device *l3mdev = 
l3mdev_master_dev_rcu(skb_dst(skb)->dev);
         int oif = l3mdev ? l3mdev->ifindex : 0;
         struct dst_entry *dst = NULL;
+       struct dst_entry *orig_dst;
         int err = -EAFNOSUPPORT;
         struct sock *sk;
         struct net *net;
@@ -201,6 +202,8 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
                 net = dev_net(skb_dst(skb)->dev);
         }

+       orig_dst = skb_dst(skb);
+
         if (ipv4) {
                 struct iphdr *iph = ip_hdr(skb);
                 struct flowi4 fl4 = {};
@@ -254,6 +257,16 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
         if (unlikely(err))
                 goto err;

+       /* avoid lwtunnel_xmit() reentry loop when destination is the same
+        * after transformation (i.e., disallow BPF_LWT_REROUTE when 
dst_entry
+        * remains the same).
+        */
+       if (orig_dst->lwtstate == dst->lwtstate) {
+               dst_release(dst);
+               err = -EINVAL;
+               goto err;
+       }
+
         skb_dst_drop(skb);
         skb_dst_set(skb, dst);

