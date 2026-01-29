Return-Path: <netdev+bounces-254893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHEmI9+we2mSHwIAu9opvQ
	(envelope-from <netdev+bounces-254893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:11:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B762B3D25
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0605300D147
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297030FF3A;
	Thu, 29 Jan 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhViWA9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C82F1FDA;
	Thu, 29 Jan 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713872; cv=none; b=aPgCl8f0HAPV28lTrc4SO9+nElx6lEs7dgAhhz34+MQit0jStun+OiLchz/oHz+w1m7rn231OjISY3Bv0VPYzUEHrJOkeuFW0xSEWAg4jP1TNwhHJ907vfgEHVXJXovf6rpVToLGBYPpf2APMcsbH73BkqzLf7OJAxQbHX2LTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713872; c=relaxed/simple;
	bh=PXiFVpw3vQsBkikcL7ARemeTUV09T2UQRlYXy1KFMhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNuAatHOn0lHbK/gzCeVAVySsDG22LuuLCo+hgQ15tfjtdfkIOwfHrVUy0cLWJkwbTkRzuFXsGDzY/2Oat3e0f4nvp7nB8B5arsZlc5elxbvi+JX72sNjcgnscxBkMcWZdDK3feFfcFft8ht9PJvucxMzfNgP1V6z6ov/Nu7RCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhViWA9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2DCC4CEF7;
	Thu, 29 Jan 2026 19:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769713872;
	bh=PXiFVpw3vQsBkikcL7ARemeTUV09T2UQRlYXy1KFMhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YhViWA9vgk/2iatXTsOD1EjJsLmwtEu4lC1PKvdNLFbb4EtlRZtnx42nZfDd+M/fM
	 v2XajnyB1Ufl58l52nkJpAw4yyeGr70dm3ltFDSn+C7Pt7bmyCcQHGzqkkQVWtAXnm
	 O238HuflTVA7psK90uxDq62YGzJ72UDltGgSXLiHMnrEzWJCrIMLoulepqJFQbLCpY
	 VWA7sb5wHRpS5YqDm9EJ0jDQ/SdG6LjZ2Sn/+n9nA0sa7535VmH7UKci12Og4lGJzn
	 uQm4Neht6K1iIFRphWI35UuUwQ/fA6vs/VHoV2I2hB5xaVg/fQu4sXfa0HmegGozRf
	 qZV3HktHvMeUw==
Message-ID: <10ae780e-07a3-42bd-8f05-cf4f7721a325@kernel.org>
Date: Thu, 29 Jan 2026 20:11:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: sched: sfq: add detailed drop reasons
 for monitoring
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 horms@kernel.org, jiri@resnulli.us, edumazet@google.com,
 xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <176917072608.1186611.11185920960590396939.stgit@firesoul>
 <78899cbc-3e1f-4f84-83a1-a2a5e6301c05@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <78899cbc-3e1f-4f84-83a1-a2a5e6301c05@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254893-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,vger.kernel.org,gmail.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,toke.dk,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B762B3D25
X-Rspamd-Action: no action



On 29/01/2026 11.36, Paolo Abeni wrote:
> On 1/23/26 1:18 PM, Jesper Dangaard Brouer wrote:
>> Add specific drop reasons to SFQ qdisc to improve packet drop
>> observability and monitoring capabilities. This change replaces
>> generic qdisc_drop() calls with qdisc_drop_reason() to provide
>> granular metrics about different drop scenarios in production
>> environments.
>>
>> Two new drop reasons are introduced:
>>
>> - SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: Used when a new flow cannot
>>    be created because the maximum number of flows (flows parameter)
>>    has been reached and no free flow slots are available.
>>
>> - SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: Used when a flow's queue
>>    length exceeds the per-flow depth limit (depth parameter),
>>    triggering either tail drop or head drop depending on headdrop
>>    configuration.
>>
>> The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop()
>> when the overall qdisc limit is exceeded and packets are dropped
>> from the longest queue.
>>
>> The naming uses qdisc-specific drop reasons tied to SFQ tunables,
>> following the pattern established by Eric's FQ commit 5765c7f6e317
>> ("net_sched: sch_fq: add three drop_reason") which introduced
>> FQ_BAND_LIMIT, FQ_HORIZON_LIMIT, and FQ_FLOW_LIMIT.
>>
>> The new drop reasons are inserted in the middle of the enum after
>> SKB_DROP_REASON_QDISC_CONGESTED to group all qdisc-related reasons
>> together. While drop reason enum values are not UAPI, the enum
>> names implicitly become UAPI as userspace tools rely on BTF to
>> resolve names to values. This makes middle-insertion safe as long
>> as names remain stable.
>>
>> These detailed drop reasons enable production monitoring systems
>> to distinguish between different SFQ drop scenarios and generate
>> specific metrics for:
>> - Flow table exhaustion (flows exceeded)
>> - Per-flow congestion (depth limit exceeded)
>> - Global qdisc congestion (overall limit exceeded)
>>
>> This granular visibility allows operators to identify capacity
>> planning needs, detect traffic patterns, and optimize SFQ
>> configuration based on real-world drop patterns.
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> Given the lack of endorsing from any 3rd party, the possible BPF
> alternative and the previous controversial conversation, I'm also not
> going to apply this change, sorry.


I agree that we need someone else "3rd party" to review and ACK this
patch *before* it can be applied. I talked to Toke and Simon yesterday,
and they have promised to take a look.  So, I ask for some time for
them to review it.

I think this patch is simply following the same pattern as existing
code, that adds similar drop_reasons like FQ and CAKE did.  I
unfortunately think it complicated the discussion that I explained *my*
complicated/advanced use-case. I think these drop_reasons are generally
practical for others to use.  It makes is really easy to troubleshoot
qdisc code issues for debugging, where we want these drop_reason to
quickly identify the code (and not be too general).

Like Eric shows in commit 5765c7f6e317 this is also usable from perf:
  perf record -a -e skb:kfree_skb sleep 1; perf script


--Jesper





