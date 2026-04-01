Return-Path: <netdev+bounces-274110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id akCEB8cczWk0aQYAu9opvQ
	(envelope-from <netdev+bounces-274110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:25:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75C37B2E8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 690D8301DB4F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE911423A97;
	Wed,  1 Apr 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sPNY4QSE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jhGBGzOK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sPNY4QSE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jhGBGzOK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE19425CDD
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049907; cv=none; b=XZ47xd4Fm/N4JWB3XJoI+yK1QyqyBlK9yYoLSNt3k4kU+dljgIoQv6NmVMlyH7vDaRzD/fJWb1RJ6b+TJu80bk56FPrc0sAqVxDJ4QbU7iwmVnzWSRLeUWymyDJW6TzJz+Mxfr68up5BRLB6wykSF4p3mg4w4dA/J0XglHgnIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049907; c=relaxed/simple;
	bh=yrAiEe3hMwdtMqlM5yyE08W+WcGcpRKJkzW6T+Zj62Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwWt8f6CHsOFtz1WZLDpDA6jAtQMWHjYkdNygiwayd57tsYCZ+4OAbil/wlfe5BiS7iMhJO4H46IGZH0Q0xMEPYiyouMKo4LdrrABOs7bipTTRSVVFvtnPgfV9bb+HxmPgG2cxmlNgAy6//69cKZN5RsYKPGjimmBqAakfmhC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sPNY4QSE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jhGBGzOK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sPNY4QSE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jhGBGzOK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FE0B5C055;
	Wed,  1 Apr 2026 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775049903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cflPi1gwmWX95H1Di+2W7uMrJ74d0vZDUiJvvvqQrCI=;
	b=sPNY4QSEeDFv/Ac1CD3IuG66bOQxNLXlURFSuRx2d7Paw2XsJRVTB31LVT2FQrUjWxeXD9
	qdq+Qw5R4CRWAQHr6u1/bzcnoaOrrMnymabTj/d2ffeeZ13d7iFwIujfT7MCYMRm03msPu
	ZpjfXOaSvtSG+qqxDTbDzJ7/KFAihtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775049903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cflPi1gwmWX95H1Di+2W7uMrJ74d0vZDUiJvvvqQrCI=;
	b=jhGBGzOKd5CnPeq/Fq9fhG7IevPWYHkbLt6qM/rmLVQvcbBxFMcici2Q06v0c1YrDBdmfF
	C5tRajdFRh4zdEAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sPNY4QSE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jhGBGzOK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775049903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cflPi1gwmWX95H1Di+2W7uMrJ74d0vZDUiJvvvqQrCI=;
	b=sPNY4QSEeDFv/Ac1CD3IuG66bOQxNLXlURFSuRx2d7Paw2XsJRVTB31LVT2FQrUjWxeXD9
	qdq+Qw5R4CRWAQHr6u1/bzcnoaOrrMnymabTj/d2ffeeZ13d7iFwIujfT7MCYMRm03msPu
	ZpjfXOaSvtSG+qqxDTbDzJ7/KFAihtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775049903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cflPi1gwmWX95H1Di+2W7uMrJ74d0vZDUiJvvvqQrCI=;
	b=jhGBGzOKd5CnPeq/Fq9fhG7IevPWYHkbLt6qM/rmLVQvcbBxFMcici2Q06v0c1YrDBdmfF
	C5tRajdFRh4zdEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3BCA4A0B0;
	Wed,  1 Apr 2026 13:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V3KLMK4czWk9QgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 13:25:02 +0000
Message-ID: <e10d488a-8c37-49ab-9dd9-61625958039a@suse.de>
Date: Wed, 1 Apr 2026 15:24:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net v2] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, petrm@nvidia.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, kees@kernel.org,
 Yiming Qian <yimingqian591@gmail.com>
References: <20260401081741.4273-1-fmancera@suse.de>
 <20260401081741.4273-2-fmancera@suse.de> <20260401130257.GB1808730@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260401130257.GB1808730@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274110-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.976];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 9E75C37B2E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 3:02 PM, Ido Schimmel wrote:
> On Wed, Apr 01, 2026 at 10:17:41AM +0200, Fernando Fernandez Mancera wrote:
>> -static size_t nh_nlmsg_size_grp(struct nexthop *nh)
>> +static size_t nh_nlmsg_size_grp(struct nexthop *nh, u32 op_flags)
>>   {
>>   	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
>>   	size_t sz = sizeof(struct nexthop_grp) * nhg->num_nh;
>> @@ -1013,6 +1013,21 @@ static size_t nh_nlmsg_size_grp(struct nexthop *nh)
>>   	if (nhg->resilient)
>>   		tot += nh_nlmsg_size_grp_res(nhg);
>>   
>> +	if (op_flags & NHA_OP_FLAG_DUMP_STATS) {
>> +		tot += nla_total_size(0) +	  /* NHA_GROUP_STATS */
>> +		       nla_total_size(4);	  /* NHA_HW_STATS_ENABLE */
>> +		tot += nhg->num_nh *
>> +		       (nla_total_size(0) +	  /* NHA_GROUP_STATS_ENTRY */
>> +			nla_total_size(4) +	  /* NHA_GROUP_STATS_ENTRY_ID */
>> +			nla_total_size_64bit(8)); /* NHA_GROUP_STATS_ENTRY_PACKETS */
>> +
>> +		if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS) {
>> +			tot += nhg->num_nh *
>> +			       nla_total_size_64bit(8); /* NHA_GROUP_STATS_ENTRY_PACKETS_HW */
>> +			tot += nla_total_size(4);	/* NHA_HW_STATS_USED */
>> +		}
>> +	}
>> +
> 
> This looks correct
> 
>>   	return tot;
>>   }
>>   
>> @@ -1047,14 +1062,14 @@ static size_t nh_nlmsg_size_single(struct nexthop *nh)
>>   	return sz;
>>   }
>>   
>> -static size_t nh_nlmsg_size(struct nexthop *nh)
>> +static size_t nh_nlmsg_size(struct nexthop *nh, u32 op_flags)
>>   {
>>   	size_t sz = NLMSG_ALIGN(sizeof(struct nhmsg));
>>   
>>   	sz += nla_total_size(4); /* NHA_ID */
>>   
>>   	if (nh->is_group)
>> -		sz += nh_nlmsg_size_grp(nh) +
>> +		sz += nh_nlmsg_size_grp(nh, op_flags) +
>>   		      nla_total_size(4) +	/* NHA_OP_FLAGS */
>>   		      0;
> 
> But the AI review [1] also mentions missing accounting for NHA_FDB which
> seems like a legit issue (even if we can't currently trigger it).
> 
> In the single nexthop case we have:
> 
> sz = nla_total_size(4);  /* NHA_OIF */
> 
> Which covers NHA_FDB since it's mutually exclusive with NHA_OIF.
> 

Yes, seems legit. Probably the issue cannot be reproduced because some 
padding might be absorbing the impact. Thank you Ido for pointing it out.

I guess it makes sense to fix this on a v3 instead of a separate patch. 
Even though, this has been affecting nexthop_notify() path since group 
support was implemented.

Thanks,
Fernando.

> [1] https://sashiko.dev/#/patchset/20260401081741.4273-1-fmancera%40suse.de


