Return-Path: <netdev+bounces-64521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EAF835903
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 01:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16188B20BCF
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 00:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6AA36B;
	Mon, 22 Jan 2024 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ng4zptqf"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D83364
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705884576; cv=none; b=AuFium5fvNYcVNKzfKvQ3keQ0cyuKm1ESHtd8SKKZz+uI21Yn9AELXaMTkakcXKCFzOKL9elSNjBpLklFAusnNig8ZuVF8EDrO4/tRs5zuBcgQ2B/FcMgDiE8N+CoDiNtuYmjOF8itrqAtBcxTzlpMdKf1xJMoD5vpElVrXGXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705884576; c=relaxed/simple;
	bh=jGdF9SxU8YvUBfrD1+Mm+9GekSXou0G2GRCkPz5EgHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LeRJg7OHcPVGdFjoj4m3P+c5EXEFBuS9roYqchy2n4YpHML0jtqHxyru2gW333FG8GuOB1eJ+Xs0YAW0Mx4O/nPlarNELXZm+zVbE0POlswXMcgCAobVXHaVcRetr3tVdpAq5/kRGgUrPvxuIwKCvXuFlxF+cHvE1YV0pGsMX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ng4zptqf; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B318C2C006E;
	Mon, 22 Jan 2024 00:49:32 +0000 (UTC)
Received: from [192.168.22.29] (unknown [50.225.254.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id B7DD013C2B0;
	Sun, 21 Jan 2024 16:49:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B7DD013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1705884571;
	bh=jGdF9SxU8YvUBfrD1+Mm+9GekSXou0G2GRCkPz5EgHs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ng4zptqfPX9KHmYGdGgjIfn6IyjX9HxL1Zhl0jTNmMquMeCi1IHrIbo1z897WQ02/
	 Xr0UgvswRhbotpICrnhJoegucwbaz5bI3LNeOmnWu4QgV0Hwl+fpUyWsQyVrozxzAe
	 HDZNtxjSNVSWpJAux+sYZ6zZ3q78PyTWt03/pqrw=
Message-ID: <fc260731-3fcb-1681-f4a4-20820387e265@candelatech.com>
Date: Sun, 21 Jan 2024 16:49:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Having trouble with VRF and ping link local ipv6 address.
Content-Language: en-MW
To: David Ahern <dsahern@kernel.org>, netdev <netdev@vger.kernel.org>
References: <6f0c873e-8062-4148-74c2-50f47c75565f@candelatech.com>
 <9c01855e-fc0b-4bad-8522-232b71617121@kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <9c01855e-fc0b-4bad-8522-232b71617121@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1705884573-EB_t8TmZ207X
X-MDID-O:
 us5;at1;1705884573;EB_t8TmZ207X;<greearb@candelatech.com>;13ea00862af1a4a136f3e80d149399ed

On 1/21/24 16:38, David Ahern wrote:
> On 1/21/24 5:29 PM, Ben Greear wrote:
>> Hello,
>>
>> I am trying to test pinging link-local IPv6 addresses across a VETH
>> pair, with each VETH
>> in a VRF, but having no good luck.
> 
> This is covered by ipv6_ping_vrf in
> tools/testing/selftests/net/fcnal-test.sh As I recall you can run just
> those tests with `-t ping6` and see the commands with -v. -P will pause
> after each test so you can see the setup and run the ping command manually.

Thanks for the great help, as always.  I guess I'd have to dig more before I understand
why putting the IP of the remote rddVR4 and %<local-dev> on the end makes it work...but it
does.

And, since it is bound to VRF, and there is exactly one netdevice in that VRF, shouldn't it
be able to figure out the device name?

# ip vrf exec _vrf15 ping -6 fe80::d064:9eff:fead:2156%rddVR5
PING fe80::d064:9eff:fead:2156%rddVR5(fe80::d064:9eff:fead:2156%rddVR5) 56 data bytes
64 bytes from fe80::d064:9eff:fead:2156%_vrf15: icmp_seq=1 ttl=64 time=0.047 ms
64 bytes from fe80::d064:9eff:fead:2156%_vrf15: icmp_seq=2 ttl=64 time=0.034 ms
64 bytes from fe80::d064:9eff:fead:2156%_vrf15: icmp_seq=3 ttl=64 time=0.032 ms
64 bytes from fe80::d064:9eff:fead:2156%_vrf15: icmp_seq=4 ttl=64 time=0.038 ms
64 bytes from fe80::d064:9eff:fead:2156%_vrf15: icmp_seq=5 ttl=64 time=0.021 ms


I'll look through that example script when I am fresh.

Thanks,
Ben

> 
>>
>> Anyone see what I might be doing wrong?
>>
>>
>> [root@ ]# ip -6 addr show dev rddVR5
>> 161: rddVR5@rddVR4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
>> noqueue master _vrf15 state UP group default qlen 1000
>>      inet6 fe80::8088:c8ff:fe31:16ea/64 scope link
>>         valid_lft forever preferred_lft forever
>>
>> [root@ ]# ip -6 addr show dev rddVR4
>> 160: rddVR4@rddVR5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
>> noqueue master _vrf14 state UP group default qlen 1000
>>      inet6 fe80::d064:9eff:fead:2156/64 scope link
>>         valid_lft forever preferred_lft forever
>>
>> [root@ ]# ip -6 route show table 15
>> anycast fe80:: dev rddVR5 proto kernel metric 1024 pref medium
>> local fe80::8088:c8ff:fe31:16ea dev rddVR5 proto kernel metric 0 pref
>> medium
>> fe80::/64 dev rddVR5 proto kernel metric 256 pref medium
>> fe80::/64 dev rddVR5 metric 1024 pref medium
>> ff00::/8 dev rddVR5 metric 256 pref medium
>>
>> [root@ ]# ip -6 route show table 14
>> local fe80::d064:9eff:fead:2156 dev rddVR4 proto kernel metric 0 pref
>> medium
>> fe80::/64 dev rddVR4 proto kernel metric 256 pref medium
>> multicast ff00::/8 dev rddVR4 proto kernel metric 256 pref medium
>>
>> [root@ ]# ip vrf exec _vrf15 ping -6 fe80::d064:9eff:fead:2156
> 
> LLAs are local to a device. Give it a device context (%<dev name> after
> the address).
> 
> 
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

