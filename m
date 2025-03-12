Return-Path: <netdev+bounces-174234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E940A5DEBE
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FA61892FF1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC8E2475DD;
	Wed, 12 Mar 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="yZlSrmGB"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ABB198E8C
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789169; cv=none; b=Ds5ppQWXRIX+pNxRWyqS4lbUsjr9FVWtWA3VnZoD5vuGRBPY1Hv6WEMYxZ1ZktSBvvYEeYcKGxlZmteC5aE9dSGLvh3NQOrePP2udqCyFq68k6A4AIuXyXu7cdlO/kTAGJrPecvt5V6Oiy5kdj4y6Y30gVmUMj6Ll1uOs1PIT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789169; c=relaxed/simple;
	bh=l6nNXdCpgJxrZvpjQOfG+qBFsIyjfHJ5/lBp08zMHhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8JQMqVnLqSQFu4UIYhpslqoidqSPxbbm8fB5OBhqr1aQ7Uvy0hRm4ZEtUHX3K/zUz8iPmfQVFjC6XEIZc2c8dXlvPFIAKkhFUlGL8g6Be8vUyUrGt+KgSltc4SI+B6k/xwmi5GwnbgAH4hIqrY2kC8H+TPRDBK2k+czDVNHmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=yZlSrmGB; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.0.223] (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 8687D20228E0;
	Wed, 12 Mar 2025 15:19:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 8687D20228E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741789158;
	bh=3KMOU03HqMuaEY1n4MadP8AIyiQSXq30TfnFXO5hJhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yZlSrmGBMjJKffteHTR/WhWVqXQLkVrKunBPUo07qO7VUMbij1rDlVroLK3IndYSR
	 z8Nvg/poLC5eyRq2rIe6NIhF7dJJZmBJIrlWThZvYi6kikdjkMYuOvoKWp9vnrJ7Td
	 cnVk4WlrLQhJdBn+7EGEQOfZVSV1c8BQpVZK7Y/iN8B382YIuD4uGqIH5pwmdTPq+P
	 +Z3wvPzKYmigxU60ysUVAcskgYqf04eqrH5S74tW2Vpmm+klBdOMBettuK+gGHKQAR
	 GjtFYRPxRYti7z3bsBoj72TpCpNee+tEgwO5zLDJRbY7QewNoIb/SNZTAvYdxmEuMS
	 fhd6oSDy7phGw==
Message-ID: <18ae19a5-9f2b-4f8d-af8d-1833a309dc51@uliege.be>
Date: Wed, 12 Mar 2025 15:19:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/7] net: fix lwtunnel reentry loops
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Andrea Mayer <andrea.mayer@uniroma2.it>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250311141238.19862-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 15:12, Justin Iurman wrote:
> When the destination is the same after the transformation, we enter a
> lwtunnel loop. This is true for most of lwt users: ioam6, rpl, seg6,
> seg6_local, ila_lwt, and lwt_bpf. It can happen in their input() and
> output() handlers respectively, where either dst_input() or dst_output()
> is called at the end. It can also happen in xmit() handlers. This patch
> prevents that kind of reentry loop by redirecting to the origin input()
> or output() when the destination is the same after the transformation.
> 
> Here is an example for rpl_input():
> 
> dump_stack_lvl+0x60/0x80
> rpl_input+0x9d/0x320
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> [...]
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> ip6_sublist_rcv_finish+0x85/0x90
> ip6_sublist_rcv+0x236/0x2f0
> 
> ... until rpl_do_srh() fails, which means skb_cow_head() failed.
> 
> Justin Iurman (7):
>    net: ipv6: ioam6: fix lwtunnel_output() loop
>    net: ipv6: rpl: fix lwtunnel_input/output loop
>    net: ipv6: seg6: fix lwtunnel_input/output loop
>    net: ipv6: seg6_local: fix lwtunnel_input() loop
>    net: ipv6: ila: fix lwtunnel_output() loop
>    net: core: bpf: fix lwtunnel_input/xmit loop
>    selftests: net: test for lwtunnel dst ref loops
> 
>   net/core/lwt_bpf.c                            |  21 ++
>   net/ipv6/ila/ila_lwt.c                        |   8 +
>   net/ipv6/ioam6_iptunnel.c                     |   8 +-
>   net/ipv6/rpl_iptunnel.c                       |  14 +
>   net/ipv6/seg6_iptunnel.c                      |  37 ++-
>   net/ipv6/seg6_local.c                         |  85 +++++-
>   tools/testing/selftests/net/Makefile          |   1 +
>   tools/testing/selftests/net/config            |   2 +
>   .../selftests/net/lwt_dst_cache_ref_loop.sh   | 250 ++++++++++++++++++
>   9 files changed, 412 insertions(+), 14 deletions(-)
>   create mode 100755 tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
> 

You can ignore this series: -v2 is on its way to cancel patches #2 to #6 
included. This is the result of the discussion we had with Andrea during 
Netdevconf. He's going to handle sr-related loops in a dedicated patch, 
so that he can better track the drop reason and adapt statistics. All 
other loops (whatever the lwtunnel user) are caught by the patch I sent 
a few hours ago: "net: lwtunnel: fix recursion loops". That's the plan. 
Shout if you disagree.

