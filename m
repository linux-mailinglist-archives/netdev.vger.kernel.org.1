Return-Path: <netdev+bounces-261942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMd+IoDfoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:16:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA581BBE06
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B6B830967C5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073C336A024;
	Fri, 27 Feb 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cl01c/ov"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167736BCEB
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215982; cv=none; b=QrYH3cRz8SXfkuNVhBQS0CJRzENckzHt7FO6BitBo1uRplvkPToYkQOJ+OjN3zpctBU94aCVncU8rqnUIQagCBjxYVZhwPyfqsQbFQUFKefzKtXYVJPDoUdP+bsGSKkcpBpPQMMNMuog5dFz3qMcvC2m6IQbk6fA4Jl7QvfWzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215982; c=relaxed/simple;
	bh=XSX08A4UYmmFvKBcPk+WFjZpfcTcLjkXpTOwuq3FONU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec8mbW8pJGzCjKhrvQISi12msq1pP4m/c3HBSSQhi1sEmseEYkmuDFAPzXU5JcPb6jnuPQjDfjCJeBk6e4hXCrgfH2P0zpA/bdCY8DRcdc/MSoy/a5h6PHPfBST+ePzaHGYuSA+/wKmY5ZJiSWpxUr23lgeI8dd2j14+29DhQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cl01c/ov; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZOdOr9lKpEaCbY2gD535SAEdve60L30j37WycSnCsyk=; b=cl01c/ovXZNtp6CsgMmbfLgFbi
	8urSp3SrqTRb+lTp3hGHb11fliCM47W2smPDfdZei/QhzS9xtLcCVqlaznJhBMSo2vqi9/zKNXg3C
	IACxu3n6d3EOJLpuxrkXZi+3FuiOVdyJAjCv0hxoCHIMNOphzEm3zT+ysKRtVxXPeKAn82ZsCIj/l
	nnfe9MrV+PhDvFV6CbfTA9gUmRofqzM22Eg6N+Uz7PX8FWyCO5Zo60OWYdRoXozrQTAwa93Za9Z8H
	ILRF8R4+7Cq+JQZyIaVBmA2AqR/9jdQnzabU1Bz3VcbcXO8I5qKo86axqxKtP/brUe3jy6TbEpdLt
	SECenz6A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw2Kh-00000008tzi-1WER;
	Fri, 27 Feb 2026 18:12:59 +0000
Message-ID: <6b9973f3-2ba5-4d53-a6c3-c0ff37a76c99@infradead.org>
Date: Fri, 27 Feb 2026 10:12:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -net] net: openvswitch: clean up some kernel-doc warnings
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org
References: <20260226221054.1041044-1-rdunlap@infradead.org>
 <5708dc9f-2cc7-463c-a9a7-32e82634c94c@ovn.org>
 <10b1d487-1324-4bc5-843d-e8799b036add@infradead.org>
 <34be72ba-c777-439f-b414-a449d8dae3e7@ovn.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <34be72ba-c777-439f-b414-a449d8dae3e7@ovn.org>
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
	TAGGED_FROM(0.00)[bounces-261942-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EA581BBE06
X-Rspamd-Action: no action



On 2/27/26 2:20 AM, Ilya Maximets wrote:
> On 2/27/26 6:42 AM, Randy Dunlap wrote:
>>
>>
>> On 2/26/26 2:57 PM, Ilya Maximets wrote:
>>> On 2/26/26 11:10 PM, Randy Dunlap wrote:
>>>> Fix some kernel-doc warnings in openvswitch.h:
>>>>
>>>> Mark enum placeholders that are not used as "private" so that kernel-doc
>>>> comments are not needed for them.
>>>>
>>>> Correct names for 2 enum values:
>>>> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>>>>  '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
>>>> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>>>>  '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'
>>>>
>>>> Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
>>>>  '/**', but isn't a kernel-doc comment.
>>>>  * Omit attributes for notifications.
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> ---
>>>
>>> Hi, Randy.  Thanks for the fixes!
>>>
>>> If the private/public is the style to follow, it sounds good to me,
>>> though there seem to be an inconsistency in how the kernel-only
>>> attributes are marked.  I see the OVS_SAMPLE_ATTR_ARG is in the
>>> private section, but OVS_CHECK_PKT_LEN_ATTR_ARG and the
>>> OVS_ACTION_ATTR_SET_TO_MASKED are public.  They should either all
>>> be public or all private, as they are used for very similar purposes,
>>> which is storing extra information about the action to make it easier
>>> for the kernel to work with them.  These attributes should never be
>>> used in the communication with userspace.  So, maybe private?
>>
>> I documented them and made them all public:.
> 
> OK.
> 
>>
>>>
>>> __OVS_CHECK_PKT_LEN_ATTR_MAX is also public for some reason.  I guess,
>>> it is because while it has kernel-doc-style comment, it doesn't start
>>> with /**, so it's not treated like one.  Maybe we should fix that here
>>> just to be consistent?
>>
>> I didn't follow the "it doesn't start with /**", but I made it private:.
> 
> The point was that the comment for the 'enum ovs_check_pkt_len_attr'
> starts with the regular '/*' and not the kernel-doc standard '/**'.
> So I assumed that's the reason why it was missed.

I had already converted that enum to kernel-doc.

> Looking more closely, the same applies also to the
> 'struct ovs_action_push_eth', that documents a filed it doesn't have...
> 

and now I have also converted that one.

>>
>>> note: Some enums and structures do not have kernel-doc comments, so
>>> I guess that's the reason to not mark them.  I suppose it's fine,
>>> since adding extra docs is not the purpose of this patch.
>>
>> I ended up adding comments for several enums, but you might want to correct
>> a few of them.
> 
> Sure.

thanks.

-- 
~Randy


