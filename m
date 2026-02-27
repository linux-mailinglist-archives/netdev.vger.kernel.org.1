Return-Path: <netdev+bounces-261726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOd5F/guoWnbqwQAu9opvQ
	(envelope-from <netdev+bounces-261726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 06:43:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D334A1B2F43
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 06:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7055310ECA4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 05:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6583AEF3D;
	Fri, 27 Feb 2026 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pqlTM/oZ"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866113D9033
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170943; cv=none; b=GtLN8PIYmBlomRqju4tG8i6B4gxwzrwTF9jHSNtchSmGEoa139+5FfbSSI3Ov6QJiwflPmyKYXwzSK55B98PdeKhq6xViJgmCxvjMy6hMKfRBH9ZCxJVU18yOPNSTr8RnMk4/wy1XTev1qSo6bCZ5COikrY2J8KsaQa5uoQhwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170943; c=relaxed/simple;
	bh=RMgTn//3VD0skLwGXal83rQtLdDKbXTjgdSCa8YcvZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoCGf3ggdmCGKvfuM5Xi5bDXfZsxme4j0A1B8+8Ikq3ALTMnRQXeCfl4k3i1WW8Z+LY30QbuITeqGQ1c5Fo/KmbKwvgmdFKv9ePfOHqax3LfJ7SWfMT8ynHBA8lA3iCCMLT5EXIzBz7XJaXfi90xTYVKGwZC66/om0/j6lSamvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pqlTM/oZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FCXyDNwvU09VY0cJyx8qcSX051IO03LUT5ogxYUChzs=; b=pqlTM/oZFub/wVoLQLV+x22ldG
	2TqPEhB0cVQzjhOsz5eQw+uybU+V1nQow7KADUo3tfnqpaihTCgfOO3urRcSOCLbxBGC3KdsV1Smg
	GcKjWVJXxqpg9mI8Vgg11DNp1ehqbX0/NbM1dwj1u8OfQ7OvaPa8L0ZOpVu5UzCitVIChZxKl/mxb
	kqEt3tepxzL4wtRPCfJgVrsOH1BGn5u7siAIpKq7R5z0y5ya0WTq03wUx/JAGWI7kgvzNWWecPHfv
	CPIH3VFkMNvgukvUFqoM5JKHRGNiJhc0vp/LeyGvHbzbiDorrmkS47u2y99EFDVnD3JW0duG7Vxvd
	CNmrOtiA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvqcE-00000007jll-31YV;
	Fri, 27 Feb 2026 05:42:18 +0000
Message-ID: <10b1d487-1324-4bc5-843d-e8799b036add@infradead.org>
Date: Thu, 26 Feb 2026 21:42:18 -0800
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5708dc9f-2cc7-463c-a9a7-32e82634c94c@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261726-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D334A1B2F43
X-Rspamd-Action: no action



On 2/26/26 2:57 PM, Ilya Maximets wrote:
> On 2/26/26 11:10 PM, Randy Dunlap wrote:
>> Fix some kernel-doc warnings in openvswitch.h:
>>
>> Mark enum placeholders that are not used as "private" so that kernel-doc
>> comments are not needed for them.
>>
>> Correct names for 2 enum values:
>> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>>  '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
>> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>>  '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'
>>
>> Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
>>  '/**', but isn't a kernel-doc comment.
>>  * Omit attributes for notifications.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
> 
> Hi, Randy.  Thanks for the fixes!
> 
> If the private/public is the style to follow, it sounds good to me,
> though there seem to be an inconsistency in how the kernel-only
> attributes are marked.  I see the OVS_SAMPLE_ATTR_ARG is in the
> private section, but OVS_CHECK_PKT_LEN_ATTR_ARG and the
> OVS_ACTION_ATTR_SET_TO_MASKED are public.  They should either all
> be public or all private, as they are used for very similar purposes,
> which is storing extra information about the action to make it easier
> for the kernel to work with them.  These attributes should never be
> used in the communication with userspace.  So, maybe private?

I documented them and made them all public:.

> 
> __OVS_CHECK_PKT_LEN_ATTR_MAX is also public for some reason.  I guess,
> it is because while it has kernel-doc-style comment, it doesn't start
> with /**, so it's not treated like one.  Maybe we should fix that here
> just to be consistent?

I didn't follow the "it doesn't start with /**", but I made it private:.

> note: Some enums and structures do not have kernel-doc comments, so
> I guess that's the reason to not mark them.  I suppose it's fine,
> since adding extra docs is not the purpose of this patch.

I ended up adding comments for several enums, but you might want to correct
a few of them.

> nit: the subject prefix is a little strange.

I hope that I fixed that.
I'll send v2 after 24++ hours.

thanks.
-- 
~Randy


