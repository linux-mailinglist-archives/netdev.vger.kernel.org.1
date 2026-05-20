Return-Path: <netdev+bounces-290119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFU6DhwsDmr87gUAu9opvQ
	(envelope-from <netdev+bounces-290119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:48:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4E359B510
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42E643017ED8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802838911E;
	Wed, 20 May 2026 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="eq+reY7S"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7337BE87
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313689; cv=none; b=AdzxR6y07qUiewmwzziFFQ9iLtPZHsij8NaGnmY/EtyZyUz+KtYTrBanKgmJFqHrp5YmxzCXBGn/u6b4v56kDobh2HrMLi1QH94NJ4/jKQfrhg0ClZ3M0nIcSczgcRZ0rwavjx08pnH+77ghmq8oD4ryz9JomRFZ98ktpyCaq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313689; c=relaxed/simple;
	bh=n9AQjE1hpPxVSJ4m9VEUp01OGG4u8OvAhL1JAAf5J7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2doG08vASEePjsu9b3137vErnBScUrqfOGgbeMH4XWvyRyfajOB2zlbzMzTTYXV6aDGWwcaetDY77XIgAuUPTbKOPJTmJ3FBlfwCGGKMM1Erj1Bq5CcqXCVF9fGifWdgLDifpL+6kQiwJs+Y4SJOua6d6+vH2IZ2R9numf9IlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=eq+reY7S; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D348050AB84
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 21:48:06 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 913168006F;
	Wed, 20 May 2026 21:47:59 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id A813013C2B0;
	Wed, 20 May 2026 14:47:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A813013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1779313677;
	bh=n9AQjE1hpPxVSJ4m9VEUp01OGG4u8OvAhL1JAAf5J7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eq+reY7SA+XkHWaacHYMAayjx9e5HmPWV81EK1g6mlIrObzjf1y6Skm5BEsRv3rAy
	 kTMmA57+wEKv8N0xrlpYYu2jQGZzlZYsEyrnCujZqRCbGReUP5Nv74N0n4Okm8vnXP
	 QJhfjeGjbWGHg35jdn1rLHX2J+2gfInEIK6PTP5w=
Message-ID: <ed746b0a-3e15-34f7-e8dd-28099bfbb8fb@candelatech.com>
Date: Wed, 20 May 2026 14:47:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Using VRF to limit 'ip monitor' and 'iw event' messages
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>
Cc: John-Paul Powers <john-paul.powers@candelatech.com>,
 netdev <netdev@vger.kernel.org>
References: <e89dd0e7-3eaf-6385-7cfa-5f0079fabc96@candelatech.com>
 <ccbe47f5-5895-4db4-a472-1288a55a2b50@kernel.org>
 <5e83f1cc-a313-434d-b703-9f020874c03c@candelatech.com>
 <b5d12c16-ef45-4d55-821a-6366b9f7510d@kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <b5d12c16-ef45-4d55-821a-6366b9f7510d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1779313680-6febiLok2ZMW
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1779313680;6febiLok2ZMW;<greearb@candelatech.com>;13ea00862af1a4a136f3e80d149399ed
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290119-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TO_DN_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: EA4E359B510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 17:15, David Ahern wrote:
> On 5/19/26 8:04 AM, Ben Greear wrote:
>>
>> At least many ip events are related to a network interface, so we could
>> add meta data about that to the netlink msg path and then filter
>> before it gets sent to the listener netlink sockets...
> 
> As I recall this problem has been discussed a few times.
> 
> There can be many netlink listeners - e.g., ip monitor, frr, ...
> 
> The lower level code (ie., the one generating the notification) has no
> idea how many sockets will receive the message and which ones will want
> some filter to be applied to the message before attaching to the socket.
> 
> The higher level code (netlink sockets) has no idea of the content of
> the message, so the ability to run a generic filter that is appropriate
> for netlink level is really difficult.
> 
>>
>> Given a network device, is there an efficient way to get the vrf-id
>> to which it belongs?
>>
> 
> yes, that is true for ip route, link, neigh, addr, tc, ... not so much
> for other netlink users.

We have it at least partially working now, it seems like it will not be as bad as I had feared.

For our purposes, filtering most of the unwanted messages should be sufficient, and anything
we cannot easily figure out the ifindex for, we'll just pass on to the socket.

We'll post a patch for consideration once we get some more edge cases sorted out
and some more testing completed.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



