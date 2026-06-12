Return-Path: <netdev+bounces-298565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hrrbHxvUK2qJFwQAu9opvQ
	(envelope-from <netdev+bounces-298565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:40:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D850E678644
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:40:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UuKgjlnz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298565-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298565-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C63E5302674A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BA6367B9C;
	Fri, 12 Jun 2026 09:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF14369203;
	Fri, 12 Jun 2026 09:40:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257206; cv=none; b=aPZCeoj8AUvc8ICrJIDrKQ5AURuz7LhNMb7G9dT9egYjF4SJoMUm/eCjq1A6i0CwHuN8bkYgusdsRkaHfaa7m0jlCQ1eC+7gL10f3OUhtoGOi2CJlf9tYQccVdvuKDbI4q8Cc5N0P4BHCGe2b2/EX6FNRwiFGXFjO/jM4l+LerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257206; c=relaxed/simple;
	bh=fzysB5pIN803RVK9B30v9upfAqk/t4VVzBng+aQlha4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=US6mFU5kGwak0EZNbueUnMdQxoERRbknlwz3uN8ml71vR5Z42hcYMB+QX+z+LrJPBkyoYT6fCSmVbItI+3LgeRVkLt6hm9jFVTu50aX5vL+vk766nGPcp2byOK2tAvLLkKEUEgJzAoFkGxvl9tQo67AlyyA10YNy5+vJ+4vC9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuKgjlnz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCEA1F000E9;
	Fri, 12 Jun 2026 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781257203;
	bh=tnMdDldcFeu/oupQsEw5Jczw9eoM5xDyd7gMImQs7bY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UuKgjlnz+unKpHXpQOILgpgXWbg+OtHmGSGxl8fvSNUtio6jkEv0G8iAsi3Np85Z0
	 DyQQjNL22O8p8STi1GP2f2Jpc4nyxUX6JPnHnnQYL4PnA/EV8G5FI0uF3X3h+aiSv3
	 JtIrgErNWYjPvfZBmsE3mpkqd3Puq81P8UHL3PZPOUrY/YfxkJunWgwTzjzWyw0sn3
	 wZtOlkm+OoaIzzvo5f1Va/StG9hLlmDpskE3+c2yo+OE6SQ6dAgLm+ZPWXcvWzFa7t
	 4e2q5FITZp7QBavQDaTrWvQvmiL+6gwYLh/VCSWbbQHnj9sWmAVMZtwno/r+WoAIyJ
	 gKgjmtgi++6/A==
Message-ID: <7be62ade-2598-4c63-8b42-393323a1cc0e@kernel.org>
Date: Fri, 12 Jun 2026 11:39:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] net: sched: add timeout count to NETDEV
 WATCHDOG message
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-5-hawk@kernel.org>
 <3f73e314-756e-494e-a1aa-0bc39c14f41b@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <3f73e314-756e-494e-a1aa-0bc39c14f41b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298565-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:j.koeppeler@tu-berlin.de,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D850E678644



On 04/06/2026 10.30, Paolo Abeni wrote:
> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>> index 237ee1cd0136..2aebab985c00 100644
>> --- a/net/sched/sch_generic.c
>> +++ b/net/sched/sch_generic.c
>> @@ -533,13 +533,12 @@ static void dev_watchdog(struct timer_list *t)
>>   		    netif_running(dev) &&
>>   		    netif_carrier_ok(dev)) {
>>   			unsigned int timedout_ms = 0;
>> +			struct netdev_queue *txq;
>>   			unsigned int i;
>>   			unsigned long trans_start;
>>   			unsigned long oldest_start = jiffies;
>>   
>>   			for (i = 0; i < dev->num_tx_queues; i++) {
>> -				struct netdev_queue *txq;
>> -
>>   				txq = netdev_get_tx_queue(dev, i);
>>   				if (!netif_xmit_stopped(txq))
>>   					continue;
>> @@ -561,9 +560,10 @@ static void dev_watchdog(struct timer_list *t)
>>   
>>   			if (unlikely(timedout_ms)) {
>>   				trace_net_dev_xmit_timeout(dev, i);
>> -				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
>> +				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms (n:%ld)\n",
>>   					    raw_smp_processor_id(),
>> -					    i, timedout_ms);
>> +					    i, timedout_ms,
>> +					    atomic_long_read(&txq->trans_timeout));
> 
> It looks like txq could be uninitialized here if num_tx_queues is 0. I'm
> unsure if some weird/buggy device driver could actually hit that case,
> but grep '->num_tx_queues = 0;' has more than 0 hits in the current tree
> and I would err on the safe side.

Addressed in [V7], by reading out trans_timeout value when it is
accessed/incremented anyhow.  Thus, avoiding the need to deref txq.

[V7] https://lore.kernel.org/all/20260612083530.1650245-5-hawk@kernel.org/

--Jesper

