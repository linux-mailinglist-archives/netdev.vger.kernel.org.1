Return-Path: <netdev+bounces-161645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91AA22DF7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEF91888DE8
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36091E47D9;
	Thu, 30 Jan 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="N+3JK4aw"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1878462
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244520; cv=none; b=blmkdjdvIprQEgsEJbINoQqGQdvmUoZDreWjZTU4s1o1hpp0bx8HVM+U5k9qwMzgzzK0fpW+ZMkeYpdZaLE3kg3DejDD0/R7Od+OTslQqJOz+o389Ib0bEejn7ucNTcsnWAqTW2/GZDWQ4bBQHhygna6WIQ5Ma2PxdKAQr5Tqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244520; c=relaxed/simple;
	bh=CjB8uDNJ43uJFJnrsu1uCFKshhqrk6rkriCxeCy++RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0MYGRtuWfp+2gkuewq8ekhSTh95ZcULWO2cBqC3/T4qDpLoFWoonhLNnBwaQ8j2NZs3MCIEwdmtexqfRrckBQ7bpyO5HELnQH+gji3BANOez4GdX6979+iLNjgCs6yWwd8MEZlNPkCHpX7F9yitPOHEfnnIZOIrIR2GkvLGVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=N+3JK4aw; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 567B8200E2B3;
	Thu, 30 Jan 2025 14:41:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 567B8200E2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738244516;
	bh=NZjzO3wtdQCzmj+58ing4Lc4i1yHW4SW2Z2H3N3cJ8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N+3JK4awtf4n8gKgBBdqb46/36RWmH7d99LODqo/2JB3w1QNjS7PJ8Zs+aRs+rbET
	 oY9iLkKRbBhQk7xEUvXQ0I/52+ffoX4jHJrPFd+vyv9w/O+qG4SZd0s0vfVVBRAkFV
	 3mXgTAg30+YNm3uMwn98p5sFZUa7DsjfJ8AzuKqRShVrpozHgqBNm5tA7aFQIU3uAR
	 cXWL7QGvv8LVX6skAFkDeMfGtOXiidap6Uo4h24xenDPv37hMQ+z9hEvvm6g2h06xl
	 ukbY4o250CaKz5rQ2b61uqPxaSJ0Q89Y1vNFI003jO1/TXzz9GD8uNfwv+k1MlC62s
	 8DIwC5m32qWCw==
Message-ID: <91681490-63fa-405f-84cc-7ec0236eba8a@uliege.be>
Date: Thu, 30 Jan 2025 14:41:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
To: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, dsahern@kernel.org
References: <20250130031519.2716843-1-kuba@kernel.org>
 <20250130031519.2716843-2-kuba@kernel.org>
 <20250130102813.GD113107@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250130102813.GD113107@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 11:28, Simon Horman wrote:
> On Wed, Jan 29, 2025 at 07:15:19PM -0800, Jakub Kicinski wrote:
>> Some lwtunnels have a dst cache for post-transformation dst.
>> If the packet destination did not change we may end up recording
>> a reference to the lwtunnel in its own cache, and the lwtunnel
>> state will never be freed.
>>
>> Discovered by the ioam6.sh test, kmemleak was recently fixed
>> to catch per-cpu memory leaks. I'm not sure if rpl and seg6
>> can actually hit this, but in principle I don't see why not.
>>
>> Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
>> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
>> Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> v2:
>>   - fix spello in the comments
>> v1: https://lore.kernel.org/20250129021346.2333089-2-kuba@kernel.org
> 
> Hi Jakub,
> 
> This fix looks correct to me. And I believe that the double allocation
> issue raised at the cited link for v1 relates to an optimisation
> rather than a bug, so this patch seems appropriate for net without
> addressing that issue.

+1. Just to make sure, do you think I should re-apply a fix for the 
double allocation on top of this one and target net or net-next?

> I am, however, unsure why the cited patches are used in the Fixes tags
> rather than the patches that added use of the cache to the output
> routines.
> 
> e.g. af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
> 
> ...

This was my thought as well. While Fixes tags are correct for #1, what 
#2 is trying to fix was already there before 985ec6f5e623, 40475b63761a 
and dce525185bc9 respectively. I think it should be:

Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and 
injection with lwtunnels")
Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")

