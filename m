Return-Path: <netdev+bounces-264046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ8dMUWlqGkYwQAAu9opvQ
	(envelope-from <netdev+bounces-264046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:33:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E320802E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 514F5305A403
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAED376460;
	Wed,  4 Mar 2026 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ks0lrOvf"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19137DE9D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659958; cv=none; b=p8JjgZr8t0JdquJN7ATXBftAbQnmtPnCAw43K4Q50aCRV5DQxxRz0QjqYu1Ofm16NZGOptMdGWrAA8dtDHhMkf9vzh7rFi9J4ETSDEdYVyECtwCi1ZppU7F/OaJVZK0JVrLcTQsNSXphtg6kKxie+56jIxCXXOn+xjHMqQR39Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659958; c=relaxed/simple;
	bh=+8V+FxlJDSn/KOuKsaOTb1eH0q8RGzORKY2d5RSmFKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCYti8ok++M9SmUTEjDYEweDfwixabQl3lD3yCTbQMgaGaNziEAMVu3ufIftCYQKmiFLKOJ6r/KPUUcKmsdZ2EuCeu/GjzXta6AhlDODYV1PoPcj2iqAzu/t7hDIRSL0FZHOdq8mGUpFObO78e5MTkKSe6zB/ltt+D/1CFWf4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ks0lrOvf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0yYkWRHx4brOU7i4G0d/tbUPWD67KXfRJ/i5jDLEW94=; b=Ks0lrOvfy15GeVPYXlLmQvMgfi
	/Y+NMYDkAAsXd5EXiiTJIlFPKoBGqiwy5uCp8+RVC+cHb+I9pnV82e8ptZ3h5rIMfO2sVuYJrY71I
	9U4tq4NRlyJhY2k2W2ZT7Lhtb3LPqPdtjMq4WwYSgduroHFRbkcGI30wqU23x8SdxXDH6dX+HWUOC
	RtoxbrvApK25SEuhf4gH5EGmSg9zm/+y8XSRFOotwTXTvbw3GgRzqLbBcz7bJePRWDCkprtNBbZmK
	BttymvHGGPZlSp42Twq1aVCebWAQcjimQ+mLrSd5GvIB79TjCw9KpBs+v7PYA0d8AqqqYWceHDrM4
	CzaUk8Qg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxtpX-00000000WjT-2oL1;
	Wed, 04 Mar 2026 21:32:31 +0000
Message-ID: <1951696d-f034-47d4-b356-a7a379cf1056@infradead.org>
Date: Wed, 4 Mar 2026 13:32:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: openvswitch: clean up some kernel-doc
 warnings
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org
References: <20260304012437.469151-1-rdunlap@infradead.org>
 <0d1f4fcc-82dc-42c2-839a-f903128ccfac@ovn.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0d1f4fcc-82dc-42c2-839a-f903128ccfac@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 553E320802E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264046-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,infradead.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ovn.org:email]
X-Rspamd-Action: no action

Hi Ilya,

On 3/4/26 1:23 PM, Ilya Maximets wrote:
> On 3/4/26 2:24 AM, Randy Dunlap wrote:
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
>> Convert one comment from "/**" kernel-doc to a plain C "/*" comment:
>> Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
>>  '/**', but isn't a kernel-doc comment.
>>  * Omit attributes for notifications.
>>
>> Add more kernel-doc:
>> - add kernel-doc for kernel-only enums;
>> - add missing kernel-doc for enum ovs_datapath_attr;
>> - add missing kernel-doc for enum ovs_flow_attr;
>> - add missing kernel-doc for enum ovs_sample_attr;
>> - add kernel-doc for enum ovs_check_pkt_len_attr;
>> - add kernel-doc for enum ovs_action_attr;
>> - add kernel-doc for enum ovs_action_push_eth;
>> - add kernel-doc for enum ovs_vport_attr;
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> v5: fix one description (thanks, Ilya);
>>     put periods at the end of enum short desriptions;
> 
> I don't see this change in the code.  Did you not include it in the patch?
> It's a minor thing.  Not sure it's worth a re-spin.

Argh. I'm sure that I did that but I don't know what happened to it. :(

> There is also a couple checkpatch warnings for lines with 81 characters, but
> I'm not sure if it makes sense to wrap those.  May become harder to read.

Yeah, I thought that it was OK like this.

> Either way:
> 
> Acked-by: Ilya Maximets <i.maximets@ovn.org>

Thanks. I don't plan to respin the patch unless someone else speaks up.

-- 
~Randy


