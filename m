Return-Path: <netdev+bounces-272309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMb4D+XYxWnQCAUAu9opvQ
	(envelope-from <netdev+bounces-272309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:09:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E1633DBCB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 891D1304F202
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD12C3254;
	Fri, 27 Mar 2026 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Kg3nh85P";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="R2nyM+u+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5B3194098;
	Fri, 27 Mar 2026 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573793; cv=none; b=SChHUQvNlnl0JjmT1H47HeYVI4T67c3lXmGa0Xk4+5gtCuancjITKaWSjNSIerSSjQffLRqvkUAS05JjqvTktYKHpEYi+njupQw0A+nu9INEeqBdDXpvV5O+xvBbg+X3WQDmazmd0lO9aAo7zy1D2+StIJtF6Z8tfpMk2irrsbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573793; c=relaxed/simple;
	bh=bjXv93Krq0wj9XmPC7RqWDmiHZOkdLuXlTkptSP0nPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afA7+H+bqGu4OtO/UGkA09iM7MFyLJkPZsldfzClS+qWK4BorsMUoqq+54ehBFu8qMiVVfRE21R9IiKa/nqVeg/gnJxyVnGpf0MBa1xYSK16QqsLFyQY9jLfu77noLy/ljh5h0NGaXItR0DcwGbg+8ijLINev1BIMfrbVa0oPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Kg3nh85P; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=R2nyM+u+; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62R19E1D020471;
	Fri, 27 Mar 2026 02:09:20 +0100
Received: from [192.168.0.118] (unknown [101.59.90.84])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id CAF86120596;
	Fri, 27 Mar 2026 02:09:09 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1774573749; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njr7CAlrLqWjnq8HpAm3JeplWgmrKAC6gpa47rNgBpk=;
	b=Kg3nh85POhDBMdVzN1QHo7giPOxDzTya74ebzcUjWoDAPR3jklg7e/bPEn+tEgAEWTZ3Lq
	EIg3lTkna8K0RMBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1774573749; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njr7CAlrLqWjnq8HpAm3JeplWgmrKAC6gpa47rNgBpk=;
	b=R2nyM+u+/X+wLP9XfoKEKlmltDQjTRODWX5CVj4gpke/d+EXbytR1ZZfGkh59q8P2QNfZl
	QcZpghNrp7B78imPEoIrbj6dIvsRO2kXvBK1UQAFUCZkFTOPUekwizVNP5D9R6jl88eYSz
	5e17khI0nY6vXFBH9seEqA3AMAljDAYXBu7w8ljhmGaGASZnLpYboHeRFZF7r7PwCFxjnM
	guKnGSVyB+mSf9CGHjV4ULECMhFKObAfWXqWKZa4k0bz6q/ZTtGakxW8WIa7SZTfIm0aU1
	n4jMVBsN/7S5F4LyOXD6F65wNBRSXAVkRlxUHQAkyOD8HZpVaDYU64nccf8Dsg==
Message-ID: <56dca998-220c-4c29-bf3d-2a94292d6d32@uniroma2.it>
Date: Fri, 27 Mar 2026 02:09:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2
 device
Content-Language: it-IT
To: nicolas.dichtel@6wind.com, Andrea Mayer <andrea.mayer@uniroma2.it>,
        netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
        David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>, linux-kernel@vger.kernel.org
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <2bb55d10-38a9-4595-baef-678d59bf4059@6wind.com>
From: Stefano Salsano <stefano.salsano@uniroma2.it>
In-Reply-To: <2bb55d10-38a9-4595-baef-678d59bf4059@6wind.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-272309-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefano.salsano@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97E1633DBCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il 26/03/2026 17:32, Nicolas Dichtel ha scritto:
> Le 22/03/2026 à 01:05, Andrea Mayer a écrit :
>> Hi all,
> Hi,
> 
> first, thank you for posting this RFC.
> 
>>
>> this RFC series adds support for the SRv6 End.DT2U behavior and
>> introduces the srl2 Ethernet pseudowire device, together with
>> corresponding selftests.
>>
>> Motivation
>> ==========
>>
>> The main goal is to enable L2 service delivery through an internal
>> SRv6 L2 endpoint, in a way similar to how VXLAN provides L2 services
>> through a VXLAN netdevice.
>>
>> Today, Linux supports SRv6 L2 decapsulation only through an
>> End.DX2-style model, where the exposed Ethernet frame is forwarded
>> to a configured egress interface. The current implementation does
>> not provide a native netdevice representing the SRv6 L2 service
>> endpoint. This is a significant limitation compared to VXLAN, where
>> the tunnel endpoint is represented by a netdevice that can be
>> attached to a bridge and integrated naturally into the local L2
>> data plane.
>>
>> On the encapsulation side, the existing H.L2.Encaps mode is
>> implemented as a route-based lwtunnel, which only intercepts packets
>> entering the IP routing path. Non-IP protocols such as ARP are
>> never routed and therefore cannot be encapsulated, making it
>> unsuitable for full L2 service delivery.
>>
>> Design
>> ======
>>
>> This series addresses that limitation by introducing srl2, a native
>> SRv6 L2 endpoint interface. The intent is to make SRv6 L2 delivery
>> usable in the same deployment model already familiar from VXLAN: an
>> internal interface that represents the L2 service endpoint and can
>> participate naturally in local L2 forwarding.
> The current design, with vxlan, uses two interfaces: one bridge and one vxlan.
> I presume this design was chosen because the vxlan protocol is implemented in
> the vxlan driver.
> I wonder if using the same design for SRv6 is the best choice. Why not use only
> a bridge interface? Instead of pointing to a port, the FDB entries could point
> to a nexthop id. This enables to associate a srv6 encap directly to a MAC> address. Something like:
> 
> $ ip nexthop list id 1234
> id 1234 encap seg6 mode encap segs ...
> $ bridge fdb show dev br0
> 02:03:04:05:06:07 dev br0 nhid 1234 ...
> 
> What is the gain of having two interfaces?
> In term of scalability, it is interesting to have only one interface.

among our medium-term design goals we have:

1) achieving the feature parity with vxlan
2) being at least isomorphic with vxlan in terms of exposed CLI mechanisms

in this way we can port the existing vxlan based solution for cloud 
infrastructures and container networking to srv6

on top of this, we can design srv6 specific machinery for higher efficiency

therefore, the bridge+sr6 solution has to be supported to achieve 
feature parity/isomorphism with vxlan

on top of this, we also include a solution that does not need the bridge 
and terminates an L2 tunnel directly into a single sr6 interface 
characterized by a mac address (this is for the decap side)

for the encap side, we are considering per-mac solutions (see our answer 
to Justin) in a way which is aligned with vxlan design for the reasons 
mentioned above

ciao
Stefano


> 
> Regards,
> Nicolas
> 
>>
>> On top of that, the series adds support for End.DT2U so that Ethernet
>> payloads carried over SRv6 can be decapsulated and delivered into an
>> L2 domain through either a bridge port or an srl2 interface.
>>
>> Relation to RFC 8986
>> ====================
>>
>> RFC 8986 describes End.DT2U in terms of an abstract L2 table
>> associated with the SID. That abstraction specifies the externally
>> observable forwarding behavior of the node, but it does not mandate a
>> specific internal implementation. What matters is functional
>> equivalence.
>>
>> This series enforces that property by restricting valid End.DT2U
>> decapsulation targets to endpoints that provide the required L2
>> forwarding semantics by construction.
>>
>> When the target device is a bridge port, the Linux bridge provides
>> the expected behavior directly: source MAC learning, destination MAC
>> lookup, and unknown-unicast flooding within the corresponding L2
>> domain.
>>
>> When the target device is an srl2 interface, the same model is
>> realized in a degenerate but valid form, corresponding to a minimal
>> two-port L2 domain in which one endpoint is srl2. In that case,
>> forwarding is trivial: frames are delivered to srl2 only when
>> addressed to its MAC address, or when they are broadcast or multicast.
>> No general FDB is required in this case because there are no
>> additional L2 destinations to learn.
>>
>> Any other type of decapsulation target is rejected at configuration
>> time, since it would not guarantee the forwarding behavior required by
>> End.DT2U.
>>
>> The srl2 device is the minimal baseline implementation providing
>> point-to-point L2 encapsulation with a single segment list.
>> Additional features can be added incrementally based on community
>> feedback and use cases.
>>
>> Usage
>> =====
>>
>>    ip link add srl2-0 type srl2 segs fc00::a,fc00::b
>>    ip link set srl2-0 master br0
>>
>>    ip -6 route add fc00::100/128 encap seg6local action End.DT2U \
>>        l2dev srl2-0 dev dum0
>>
>>    # encapsulating traffic from veth-hs into srl2-0
>>    ip link set veth-hs master br0
>>
>> Selftest topology
>> =================
>>
>>              cafe::1                                cafe::2
>>             10.0.0.1                               10.0.0.2
>>            +--------+                             +--------+
>>            |  hs-1  |                             |  hs-2  |
>>            +---+----+                             +----+---+
>>                |                                       |
>>          +-----+------+                         +------+-----+
>>          |   veth-hs  |                         |  veth-hs   |
>>          |      |     |   fcf0:0:1:2::/64       |     |      |
>>          |    br0     +-------------------------+   br0      |
>>          |      |     |                         |     |      |
>>          |   srl2-0   |                         |  srl2-0    |
>>          |    rt-1    |                         |   rt-2     |
>>          +------------+                         +------------+
>>
>> The test verifies IPv4/IPv6 host-to-host and host-to-gateway
>> connectivity over the SRv6 L2 VPN, including ARP resolution
>> through the tunnel.
>>
>> A companion iproute2 series provides userspace support:
>>
>>    [RFC PATCH iproute2-next 0/4] seg6: add SRv6 End.DT2U and srl2 support
>>
>>
>> This is an RFC posting to collect feedback on both the overall design
>> and the userspace API before moving forward with a formal submission.
>>
>> Comments are very welcome, especially on:
>> - the introduction of srl2 as an internal SRv6 L2 endpoint
>> - the choice of constraining End.DT2U targets to bridge ports
>>    and srl2 devices
>> - the netlink/uAPI exposure
>> - the selftest coverage and topology
>>
>> Thanks,
>> Andrea and Stefano
>>
>>
>> Andrea Mayer (3):
>>    seg6: add support for the SRv6 End.DT2U behavior
>>    seg6: add SRv6 L2 tunnel device (srl2)
>>    selftests: seg6: add SRv6 srl2 + End.DT2U L2 VPN test
>>
>>   include/linux/srl2.h                          |   7 +
>>   include/uapi/linux/seg6_local.h               |   3 +
>>   include/uapi/linux/srl2.h                     |  20 +
>>   net/ipv6/Kconfig                              |  16 +
>>   net/ipv6/Makefile                             |   1 +
>>   net/ipv6/seg6.c                               |   1 +
>>   net/ipv6/seg6_local.c                         | 160 ++++-
>>   net/ipv6/srl2.c                               | 269 ++++++++
>>   tools/testing/selftests/net/Makefile          |   1 +
>>   tools/testing/selftests/net/config            |   1 +
>>   .../selftests/net/srv6_srl2_l2vpn_test.sh     | 621 ++++++++++++++++++
>>   11 files changed, 1094 insertions(+), 6 deletions(-)
>>   create mode 100644 include/linux/srl2.h
>>   create mode 100644 include/uapi/linux/srl2.h
>>   create mode 100644 net/ipv6/srl2.c
>>   create mode 100755 tools/testing/selftests/net/srv6_srl2_l2vpn_test.sh
>>
> 


-- 
*******************************************************************
Prof. Stefano Salsano
Dipartimento Ingegneria Elettronica
Universita' di Roma Tor Vergata
Viale Politecnico, 1 - 00133 Roma - ITALY

http://netgroup.uniroma2.it/Stefano_Salsano/

E-mail  : stefano.salsano@uniroma2.it
Office  : (Tel.) +39 06 72597770 (Fax.) +39 06 72597435
*******************************************************************


