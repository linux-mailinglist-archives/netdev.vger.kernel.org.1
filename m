Return-Path: <netdev+bounces-297657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wUVOCS9XKWoaVQMAu9opvQ
	(envelope-from <netdev+bounces-297657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0B2669398
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lwcs9k8s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297657-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297657-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD93C308AAD3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCABD40629C;
	Wed, 10 Jun 2026 12:21:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579A3EAC61;
	Wed, 10 Jun 2026 12:21:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094104; cv=none; b=oK5qNzELYFRE07oZAIannjw6vhxICv7a1QTlmLWLjWPUkUu6lS5N6Uzs5uplRKGgrxYHW28cYERwo/dcLUm5h8bOBr/wx9OtNuRzAOXLnffkz2YiYq6ldaC1Sl+NB4WBHZB5VZkKwmitap9ZpkmTHElYI0l+BY54VrX2TUhoU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094104; c=relaxed/simple;
	bh=d0l/dHJdExBIlQM6KUzlKfQwWAgL4a+FKUHuWytkyc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioqwtmWi+W1h2vp6CdXTT6zQ6aU1PjqNgfXUjpzm+IK76xYuJLdDUterXlfbej8+5YnGUFLQyI5Kreyy0NmxDZ657m/cjingtPXSY6pj+WwZ7F0uS/lxIP1ifcMnLwL+z8GdNtCVMXPLTQcEDfUafUjjEEYx917yMWodYOo2pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwcs9k8s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879881F00893;
	Wed, 10 Jun 2026 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781094103;
	bh=B7hcHOLd1VJ3srRjTkD53x+D+s0NHnSIqCb/3hDyXcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Lwcs9k8slHd89VbEutEdOnjL/JN7IbzRVAfhDuPmIIWIDHJ4gD+QLVRczE50oIzSp
	 ojaSA8ofF1saCn35O4RoELGZyY25MFabPtWexy0TKfkDkox7zJdzNUJx6yi/bxNSz7
	 9UooaV5jXix2d6uhtUkIgDjJOWKNPhkJGU0MEmxL6VAUpxWtpOveq3S4Pnhxa5tFF2
	 rdE51AKvXzGi93gdmYd0NCpZvVV3pV4v1lmyx6YQRIGtcQsN6QvZDghclMOTPGdgV2
	 PW7WP35s3IQaIdpIGjFCpHpEjZHZFso3UQuNOC/+1m56FJFctb38EKy/39K2yi+nfx
	 6viaS9/bPbV+Q==
Message-ID: <8f032f16-04d7-466f-9006-ef80d91e8c6a@kernel.org>
Date: Wed, 10 Jun 2026 14:21:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-3-hawk@kernel.org>
 <a7d86867-3c2b-4fbb-902b-61c4e2a561bc@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <a7d86867-3c2b-4fbb-902b-61c4e2a561bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A0B2669398



On 04/06/2026 10.19, Paolo Abeni wrote:
> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>> @@ -348,10 +381,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>>   {
>>   	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>>   	struct veth_rq *rq = NULL;
>> -	struct netdev_queue *txq;
>> +	struct netdev_queue *txq = NULL;
> 
> Minor nit: please fix the variables declaration order above.
> 
>> @@ -1092,6 +1137,24 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
>>   		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>>   	}
>>   
>> +	/* Reset BQL and wake stopped peer txqs.  A concurrent veth_xmit()
>> +	 * may have set DRV_XOFF between rcu_assign_pointer(napi, NULL) and
>> +	 * synchronize_net(), and NAPI can no longer clear it.
>> +	 * Only wake when the device is still up.
>> +	 */
>> +	peer = rtnl_dereference(priv->peer);
>> +	if (peer) {
>> +		int peer_end = min_t(int, end, peer->real_num_tx_queues);
> 
> Sashiko noted you may need to additionally complete/reset the tx queue
> in the <old_real_num_tx_queues> .. <new_real_num_tx_queue> range, and I
> think it's right.
> 

Trying a new approach in V7, that avoids calling reset. Instead, before
ptr_ring_cleanup(), consume any remaining packets and do the correct BQL
accounting.  Lets see if that pleases Sashiko ;-)

--Jesper

