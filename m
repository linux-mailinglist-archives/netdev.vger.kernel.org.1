Return-Path: <netdev+bounces-264114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML65L5vYqGlmxwAAu9opvQ
	(envelope-from <netdev+bounces-264114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:12:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE79209B94
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBEFF301CCDE
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0492A23E325;
	Thu,  5 Mar 2026 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xAbxzMTO"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED723B61E
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673152; cv=none; b=rZZ9Tssd3fZ8ytvnsnyopM85diJD6i0hrVPiS+4CEd8DBqyydFfcAuhN6QMyciVUd8ga9sVLlbZ7y+su57PLrGvhO/jAhdvljguIoPxMW5etWvgktt5No7x4sTS068vNjBfr9g4JMdgsr4LoWGnK5rZPZrEbxKP46wc+kKPu7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673152; c=relaxed/simple;
	bh=+fczjmJjwIzzNfnJro34b5Z2j36ZovU7gO1WprJ6x3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1rOk9DAfD4T9ezlZvpqtSsh26hndRzDfBR0+Eg/O+PsHvLLVitf5euQdhLl3Jh/gYCMiMSF55jkwT4SMRZCMIpKA+oA+DdQWN63TJLqoaTimF9b8m41KLsBUdBFrgU4modqQFNh/nwhDFKTP37ib7I6oXXAkvD8z+CpRpTl+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xAbxzMTO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce000648-6f4b-405a-9403-0e4570e7b6bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772673149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5M/ymf0LUsYVhVKhDKK6AT0g7a7OiAXZVmWIxfOlCc=;
	b=xAbxzMTO+uCh61IKAh2Z0dnEzpydpF2Sv/D19r+445Ch18x5nzLuI7+r8nJu5w7x1Ye53E
	gj0FTF7Zi00+pXneP0ozSWPwdEX/tBmbqV4pLD3WeOc/uxaQNtRWEk8yYdYuOUjQLLFLEP
	urUIkT0VGFzMBISNYCq2J2uqNfPtCFw=
Date: Wed, 4 Mar 2026 17:12:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 1/2] bpf: test_run: Fix the null pointer
 dereference issue in bpf_lwt_xmit_push_encap
To: Leon Hwang <leon.hwang@linux.dev>, Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-2-yangfeng59949@163.com>
 <cc7b7d2a-9f7e-41ba-9010-dfbf592a0bbd@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <cc7b7d2a-9f7e-41ba-9010-dfbf592a0bbd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3CE79209B94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264114-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,163.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 2:33 AM, Leon Hwang wrote:
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index 178c4738e63b..565fe8cbcdc9 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -1156,6 +1156,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>   		skb->ip_summed = CHECKSUM_COMPLETE;
>>   	}
>>   
>> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
>> +		if (ipv6_bpf_stub) {
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +			dst_hold(&net->ipv6.ip6_null_entry->dst);
>> +			skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
>> +#endif
>> +		} else {
>> +			/* For CONFIG_IPV6=n, ipv6_bpf_stub is NULL */
>> +			pr_warn_once("Please test this program with the IPv6 module enabled\n");
>> +			ret = -EOPNOTSUPP;
>> +			goto out;
>> +		}
>> +	}
>> +
> NIT: it would be more readable to handle the error path first.
> 
> if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
> 	if (!ipv6_bpf_stub) {
> 		pr_warn_once("...");
> 		ret = -EOPNOTSUPP;
> 		goto out;
> 	}
> #if IS_ENABLED(CONFIG_IPV6)
> 	dst_hold();
> 	skb_dst_set();
> #endif

I have adapted this change and applied. Thanks.


