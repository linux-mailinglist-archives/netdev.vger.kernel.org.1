Return-Path: <netdev+bounces-300268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WYWOFlQnM2oS+AUAu9opvQ
	(envelope-from <netdev+bounces-300268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:01:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4B69CC2D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:01:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=embeddedor.com header.s=default header.b=yZMZNVBC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300268-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A52301E587
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9BF397B0B;
	Wed, 17 Jun 2026 23:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1A388396
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 23:01:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737297; cv=none; b=J108dr8QKzqStYaNSsGUNykodJ80k5p18P4MwhiygSEwHbbCHH4nywO6Sbj1HpWv/mWOtmhosfYl1GhmhukugzS3y4Emiyf5kq2+IQl6NyBa4b30J/1o/aM6sHxd1szNsdSsdCOYPVYSn1FxH+RSD+iaYuj7aVcxrqFD+/RsFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737297; c=relaxed/simple;
	bh=yJ3aqK71SDBWPoY6vQy5kOb4IjGVZxtouMPJ2zd/rEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMbPxuuPhfvzhEIZCD7Z+Rz3rajAwSxCQWdMGqzuhkzNxXY+ooIf7+eo1ZePgd3oWwNPUexaKbGDB8r+6h9SDJ7zHqhysRT0TtN6NuvqJv/w3kwQ2/Bk6rLPhaVxvXgeBRM45gA3NqOCp9XGLTPbBsqCdxgC6d4BBn9pMZuEjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=yZMZNVBC; arc=none smtp.client-ip=44.202.169.35
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id ZszpwYsfjgwLnZzElwXs27; Wed, 17 Jun 2026 22:59:59 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id ZzEkwAw32TzOdZzEkwB0of; Wed, 17 Jun 2026 22:59:58 +0000
X-Authority-Analysis: v=2.4 cv=FbE3xI+6 c=1 sm=1 tr=0 ts=6a3326ee
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=P8mRVJMrAAAA:8 a=PG-tgVoKp2umQT0W9FoA:9 a=QEXdDO2ut3YA:10
 a=Vc1QvrjMcIoGonisw6Ob:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4e9rsRmlGWHjnDFmawkCUUOGv6ZNqpe9gLjegJVQZM4=; b=yZMZNVBC7EcqfiMcLZhm96af6H
	Pxg5it03YSXOKHi3342f1o6BgKog4pQvI8dAgrunlT7dUZoRjCjzieACkrvNsZKtzgdDUygOUFwQ/
	982PmivjVq43fh6o4XUwmPEeQzhoV/t/TfgG4KZnGs+sNPw9z5CnL9WcZ7auAR8QY+gN/8JSmzO6o
	cT5gl+e0fNx8WmzQyl+j2rfi+i+Uqh0ftqodc9IyoDC0E5xrdYLctuatWZTseatFlFq2lieUqjJ3a
	aKQ5iPULoY2FoIoDJYX4hOaHCyItfSz2GfM1tjZjjOwHEisOeH1CETsSLn9oFn+qnx7Gu16M/oj/c
	swNYcLIw==;
Received: from [177.238.16.65] (port=54202 helo=[192.168.0.12])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wZzEi-000000026ua-3Ooc;
	Wed, 17 Jun 2026 17:59:56 -0500
Message-ID: <a95aabe9-6294-42ed-8327-b7d74bb4a8c8@embeddedor.com>
Date: Wed, 17 Jun 2026 16:59:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow
 in tun_dst_unclone
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, Johan Thomsen <write@ownrisk.dk>
References: <20260616100332.1308294-1-i.maximets@ovn.org>
 <9e941b82-23d4-44e6-a240-b7949ace76ab@embeddedor.com>
 <b16e8bac-e149-4052-b1cb-8fd3e1137f9c@ovn.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <b16e8bac-e149-4052-b1cb-8fd3e1137f9c@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.65
X-Source-L: No
X-Exim-ID: 1wZzEi-000000026ua-3Ooc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.12]) [177.238.16.65]:54202
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMGS2K22jbYkVTmbshmjDsJ5FQo/EvNCV3TtFBpVmr+glplpyswQ1VF8bI/g+PvLeDk0Nt2o2L41GxiuKJOptslOcNEVnbIWFQu+aiZ08Bd/uVbJPdK8
 RUkzsCOZ/CUW/F0ipnktYivHju2oCragvGhZcR8utqggbu24w3RCIn+p53mpyAnW/lbzBd0iXPaxoyXIxexDj9wQg0qj9cvY1uY=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300268-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[embeddedor.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,ownrisk.dk];
	FORGED_SENDER(0.00)[gustavo@embeddedor.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:llvm@lists.linux.dev,m:write@ownrisk.dk,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_SOURCE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,embeddedor.com:mid,embeddedor.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7C4B69CC2D



On 6/17/26 16:01, Ilya Maximets wrote:
> On 6/17/26 10:08 PM, Gustavo A. R. Silva wrote:
>> Hi,
>>
>> On 6/16/26 04:03, Ilya Maximets wrote:
>>> kmalloc_flex() in metadata_dst_alloc() sets __counted_by for the
>>> structure to the options_len, which is then initialized to zero.
>>> Later, we're initializing the structure by copying the tunnel info
>>> together with the options, and this triggers a warning for a potential
>>> memcpy overflow, since the compiler estimates that the options can't
>>> fit into the structure, even though the memory for them is actually
>>> allocated.
>>>
>>>    memcpy: detected buffer overflow: 104 byte write of buffer size 96
>>>    WARNING: CPU: X PID: Y at lib/string_helpers.c:1036 __fortify_report
>>>     skb_tunnel_info_unclone+0x179/0x190
>>>     geneve_xmit+0x7fe/0xe00
>>
>> This warning has nothing to do with counted_by. See below for more
>> comments.
>>
>>>
>>> The issue is triggered when built with clang and source fortification.
>>>
>>> Fix that by doing the copy in two stages: first - the main data with
>>> the options_len, then the options.  This way the correct length should
>>> be known at the time of the copy.
>>>
>>> It would be better if the options_len never changed after allocation,
>>> but the allocation code is a little separate from the initialization
>>> and it would be awkward and potentially dangerous to return a struct
>>> with options_len set to a non-zero value from the metadata_dst_alloc().
>>>
>>> Another option would be to use ip_tunnel_info_opts_set(), but it is
>>> doing too many unnecessary operations for the use case here.
>>>
>>> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
>>> Reported-by: Johan Thomsen <write@ownrisk.dk>
>>> Closes: https://lore.kernel.org/netdev/CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com/
>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>> ---
>>>
>>> Johan, if you can test this one in your setup as well, that would
>>> be great.  Thanks.
>>>
>>>    include/net/dst_metadata.h | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>>> index 1fc2fb03ce3f..f45d1e3163f0 100644
>>> --- a/include/net/dst_metadata.h
>>> +++ b/include/net/dst_metadata.h
>>> @@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>>    	if (!new_md)
>>>    		return ERR_PTR(-ENOMEM);
>>>    
>>> -	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>>> -	       sizeof(struct ip_tunnel_info) + md_size);
>>
>> What's going on here is that, internally, fortified memcpy() retrieves
>> the destination size via __builtin_dynamic_object_size() in mode 1.
>>
>> That is:
>>
>> __builtin_dynamic_object_size(&new_md->u.tun_info, 1)
>>
>> For the above case, Clang returns sizeof(new_md->u.tun_info) == 96.
>>
>> So the warning is reporting that 104 bytes don't fit in an object of
>> size 96 bytes, regardless of any counted_by annotation or allocation.
> 
> Hmm.  Does __builtin_dynamic_object_size(&new_md->u.tun_info, 1) return
> 104 when the options_len is 8?  If so, isn't that because it is counted
> by that field?  Asking because the fortification doesn't complain if we
> keep the full 104-byte copy as-is, but set the options_len beforehand,
> as tested by Johan.

I see. If that is the case, then, internally, fortified memcpy() ends up
using mode 0 instead of mode 1. Something like this:

__builtin_dynamic_object_size(&new_md->u.tun_info, 0)

The above will effectively consider the allocation and counted_by because
it will interpret new_md->u.tun_info as an open-ended object due to the
flexible-array member (in struct ip_tunnel_info) whose size is determined
by counted_by.

I'm not entirely convinced we really want this.

-Gustavo

> 
>>
>> Of course, in this case, the write of 104 bytes into new_md->u.tun_info
>> is intentional and controlled, but what if it weren't?
>>
>> On the other hand, for this same case, GCC currently returns SIZE_MAX,
>> which translates to -1 inside fortified memcpy(). Thus, bounds-checking
>> is bypassed, which is why this warning doesn't show up with GCC.
>>
>> However, this is a bug in GCC. We're already looking into that.
>>
>> I think we've had just a handful of cases like this across the whole
>> kernel tree. We can deal with them as you did here (by directly copying
>> the composite structure first, and then using memcpy() to copy into the
>> flexible-array member). If these cases ever become more common, we
>> could create some kind of helper to do both things at once. :)
>>
>>> +	/* Copy in two stages to keep the __counted_by happy. */
>>
>> So based on my comments above, this code comment is not correct.
> 
> I feel like some comment is still needed, do you have some suggestions
> for what would be a better wording?
> 
>>
>>> +	new_md->u.tun_info = md_dst->u.tun_info;
>>
>> This is fine.
>>
>>> +	memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
>>> +	       ip_tunnel_info_opts(&md_dst->u.tun_info), md_size);
>>
>> Is ip_tunnel_info_opts() really needed here?
>>
>> Probably this works just fine:
>>
>> memcpy(new_md->u.tun_info.options, md_dst->u.tun_info.options, md_size);
> 
> The logic here is: we have the access function, therefore we should use it.
> It gives a bad example if we don't.
> 
> Best regards, Ilya Maximets.


