Return-Path: <netdev+bounces-289477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK8oEd9vDGpKhgUAu9opvQ
	(envelope-from <netdev+bounces-289477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:12:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCD58051B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D18E30F3B13
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB463ED3BA;
	Tue, 19 May 2026 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="oOz8ngNK"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEA3ED3CC
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199485; cv=none; b=qid+iHVwXYGZfgazCx9T3yZIrzc9maW2tB0rXodpGB5V42w84u7YQXnTi8d+n+Ryt7T9ZGxvzkt56yuaQGnxH3TCJUHIB3rd6VH2dPx14nTbcgX19zBMXirk7qhYxpz0qcUKDND3DCDackQBd8PqVMddNpJL0WyB5XHHIZdtD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199485; c=relaxed/simple;
	bh=APc+2VsFi1zsRUcmtHELq7ZSfVDMso9CXAzqPoxhQmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMPx/G1JAz8ve4B33b0Yij6NRg/Ny0n89ejFSOdj/IM1ScoobSwyx6szlpwwHvX5UDqYei1A4un1NmHd0S3jNxX8BxntAkF6faqLSGqi4eDZf8J0XLeZT7NtgHLLW6H+S9UK69wQ6HOxHWRPfUh7nqNwwlBHkDSiWjzEzWXmA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=oOz8ngNK; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 53F38B800B8;
	Tue, 19 May 2026 14:04:41 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.34.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0991013C2B0;
	Tue, 19 May 2026 07:04:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0991013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1779199479;
	bh=APc+2VsFi1zsRUcmtHELq7ZSfVDMso9CXAzqPoxhQmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oOz8ngNK381bWSzN8mDC/jHnZoG3ccshFx1qPUWUzSE0jDrd/f4tshagUbi0oERa7
	 dYZXGxsmOyPqF0u34m+BtbSy9b4AJ1WS7tsIg/k8436QXNYp49bvPjisrZ7mVth/Yj
	 faR2k6eX3OMRs3L504PQ23qxIkbQ+0B8FxZWlF9k=
Message-ID: <5e83f1cc-a313-434d-b703-9f020874c03c@candelatech.com>
Date: Tue, 19 May 2026 07:04:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using VRF to limit 'ip monitor' and 'iw event' messages
To: David Ahern <dsahern@kernel.org>
Cc: John-Paul Powers <john-paul.powers@candelatech.com>,
 netdev <netdev@vger.kernel.org>
References: <e89dd0e7-3eaf-6385-7cfa-5f0079fabc96@candelatech.com>
 <ccbe47f5-5895-4db4-a472-1288a55a2b50@kernel.org>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ccbe47f5-5895-4db4-a472-1288a55a2b50@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1779199482-K9SYQSpI44rN
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1779199482;K9SYQSpI44rN;<greearb@candelatech.com>;13ea00862af1a4a136f3e80d149399ed
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289477-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[candelatech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 94BCD58051B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 19:59, David Ahern wrote:
> On 5/18/26 3:51 PM, Ben Greear wrote:
>> Hello David,
>>
>> We are interested in filtering out iw and ip netlink events for
>> processes bound
>> to VRFs.
> 
> are you trying to filter out the events kernel side or in `ip monitor`?

For us, it needs to be kernel side, because it is not really ip monitor we
want filtered, but instead we want Chromium (or some other beastly program
that cannot easily be changed) to be filtered.

>> For instance, Chromium starts spewing errors when we try to run it on a
>> system with many
>> network interfaces, we guess because it is being confused by all of the
>> other network devices
>> going up and down.
>>
>> I think the crux of the problem is to know if a netlink listener socket
>> is bound
>> to a VRF or not, and also to know if the generator of the message is
>> bound to
>> a particular VRF.
> 
> so you are running `ip vrf exec` on ip monitor? ie., how is the netlink
> socket getting bound to a device?
> 
> VRF is only a Layer 3 construct, and a netlink socket is not AF_INET or
> AF_INET6.

So we'd have to plumb down into cgroups with a BPF program like
vrf exec for AF_INET works now, perhaps?

At least many ip events are related to a network interface, so we could
add meta data about that to the netlink msg path and then filter
before it gets sent to the listener netlink sockets...

Given a network device, is there an efficient way to get the vrf-id
to which it belongs?

Thanks for assistance!

--Ben

>> Do you have any suggestions for how we might go about this?  We'll be
>> happy to post
>> the resulting patches for consideration to be included upstream.
> 
> You could add try a filter in `ip monitor` that looks at the device
> index and only emit a message if "sk_bound_dev_if == N" where N is 0 for
> default VRF or the VRF device ifindex. From there, you would have to
> parse the message, identify the dump type, find the netdevice attribute
> and then figure out if it is a VRF device or a port of a VRF device.
> Going to be complicated.
> 
> Kernel side, netlink layer has no knowledge of the attributes, so I
> don't see how a filter could work at that layer.
> 
> This reminds of the kind of filtering (ie., fine details) that Jamal
> wanted to do for tc. Kind of hard to do given the various layers.
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


