Return-Path: <netdev+bounces-262216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEPmB7lUo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:48:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B81C88CA
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD3583065AD2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B83317143;
	Sat, 28 Feb 2026 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3V1kSKpM"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8B3033F5
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311656; cv=none; b=MyC0GALRffS9phRuwv3IeRsB20mc3F0cfLwITrrSij6HVg2+KEaLju5D6LB6sO89BLNPLzX/zLcujo+02hlGyQIMuSFmp1HNrWOJHv2UGw07sA8dWD9f8Nui0/bgRYS0Ho+nDnEQqE96AGVIHtjEMSmVNGT0f+BDX8rlfeN8Zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311656; c=relaxed/simple;
	bh=aMxta8OcgOYuoYdQDIvKYmzgkP6ZNu6hava1KxYRR9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2TO48wYCh/3e1nLLLNTWeYXBmoo3l71+lcOzQZWpTTUZ5GUL910gB7VyYh2EJmHumoZ12FOm5ivqqD8ObZnE/EFBKsgCdT4OfwDMd8iLfCC3ONKzSosLlsba1CL9gdPSC9H6+PCVZRW0jwoF97AhPYliN7f32yKft8f8xBzUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3V1kSKpM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=X2lDY4kDa1zrMSQDVyUC0SYDijyb4f3C2MvFpLo/vus=; b=3V1kSKpMWhQuqL9Vg9d+5bS2eV
	T4iXE9aG59bxftkOjuEud8C5WgjPjhRbq6qEI43SqzMxdDv4QtLy9R8nwaZ6vmyPop/dumeMeRBEC
	NLYueLtWjUtDG3B5A5ALJUUsdHPZk0qN4yPoPkkJtC7eJ9tjyotIb1JbylZwItvZfh+jcf/r0SB4l
	0vrSUN3APK6bDs6AlOwegoGztQJ9pVTpucR2+OTcpkumxWyTdzupZHcEAoElddvtWmX2tKST9BQa4
	f7JLZjFrrREJt6YwWCB1411kXa6A1WauI0ALepTaTi58u8sV8FtLTlZtZ5EU8RhAwloJzHHVo2wyD
	DUcvEFgw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwRDn-0000000AGSe-0TjP;
	Sat, 28 Feb 2026 20:47:31 +0000
Message-ID: <b57d3819-b531-4901-81db-b0cd1f16eed5@infradead.org>
Date: Sat, 28 Feb 2026 12:47:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: openvswitch: clean up some kernel-doc
 warnings
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org
References: <20260228010058.2385110-1-rdunlap@infradead.org>
 <4bf254a7-8e4c-4436-befb-1e0a2835100d@ovn.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4bf254a7-8e4c-4436-befb-1e0a2835100d@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262216-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D5B81C88CA
X-Rspamd-Action: no action

Hi Ilya,
Thanks for your careful review of these changes.

On 2/28/26 9:55 AM, Ilya Maximets wrote:
> On 2/28/26 2:00 AM, Randy Dunlap wrote:

>>
>>  include/uapi/linux/openvswitch.h |   72 ++++++++++++++++++++++++++---
>>  1 file changed, 65 insertions(+), 7 deletions(-)
>>
>> --- linux-next-20260227.orig/include/uapi/linux/openvswitch.h
>> +++ linux-next-20260227/include/uapi/linux/openvswitch.h



>> @@ -291,12 +313,13 @@ enum ovs_vport_attr {
>>  
>>  /**
>>   * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_UPCALL* commands
> 
> Not a problem of this patch, but this line is also wrong, there are no
> such commands.  These are attributes for OVS_VPORT_ATTR_UPCALL_STATS.

I corrected that.


>> @@ -652,6 +681,8 @@ enum ovs_flow_attr {
>>   * %UINT32_MAX samples all packets and intermediate values sample intermediate
>>   * fractions of packets.
>>   * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
>> + * @OVS_SAMPLE_ATTR_ARG: same as @OVS_SAMPLE_ATTR_PROBABILITY, for in-kernel
>> + * use, passing &struct sample_arg.
> 
> I wouldn't call it 'the same', more like 'extended', or just omit that part of
> the description, keeping only what's after the comma.  Or maybe "For in-kernel
> use, passing &struct sample_arg derived from other attributes.".
> 
>>   * Actions are passed as nested attributes.
> 
> This line belongs to OVS_SAMPLE_ATTR_ACTIONS.

OK, moved it.


>>   * @OVS_ACTION_ATTR_PUSH_MPLS: Push a new MPLS label stack entry onto the
>>   * top of the packets MPLS label stack.  Set the ethertype of the
>>   * encapsulating frame to either %ETH_P_MPLS_UC or %ETH_P_MPLS_MC to
>> @@ -997,6 +1050,7 @@ enum ovs_psample_attr {
>>   * start of the packet or at the start of the l3 header depending on the value
>>   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
>>   * argument.
>> + * @OVS_ACTION_ATTR_DEC_TTL: Nested OVS_DEC_TTL_ATTR_* action.
> 
> "Decreate TTL or hop limit of the packet.  Execute nested %OVS_DEC_TTL_ATTR_*

   Decrement
?

> actions if the value is less or equal to 1."

thanks.
-- 
~Randy


