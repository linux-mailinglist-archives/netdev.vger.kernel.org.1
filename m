Return-Path: <netdev+bounces-272551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMm/HMV9xmlTLAUAu9opvQ
	(envelope-from <netdev+bounces-272551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:53:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72334497E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC04300FEDB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772433AF669;
	Fri, 27 Mar 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zka115Wk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACB39890F
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615760; cv=none; b=pNUx8lepQEGZhrA+Vrv8y/VzIFGQVvwXKLY9LVUT2APphtq1FLiAzq9dZsQ+xHXNMXY20cJ/DmbBFgIJ+5p3tB1YmAG7bzCTJjkVgrah4h7ZDiX614lTd/jhBwZF3iQoq2U8tjt2P1yDq228jmiDnSdiSY2uWiap8DHw//us568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615760; c=relaxed/simple;
	bh=b7ElzXcXcist9AsYV8c8hZGYqPwSpchrOE5v/dVGw/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfyQep261NfoXZJs3EqEN54Rs2ZezOQrAQmhTp1mLwzVhOQzW4r5MMeOnXJ00SGXU8EyR8tlwZI2AjUqnAsNHoz7wD2maLjrKk6qaqMSFBeNG9NxZD/OnTqIaZN/NPeUV06HI3IiGF6zVuEJq2k6nqznlTQjmNCFcx18ypmDptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zka115Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23982C19423;
	Fri, 27 Mar 2026 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774615760;
	bh=b7ElzXcXcist9AsYV8c8hZGYqPwSpchrOE5v/dVGw/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zka115Wk8Hvqqmq44xi4NOiyHs3Or/Otg7CVznzDi6LC5iUMLKCzhe1eFxi86EXZS
	 ze8m1Zdlok+9DXOLhVT3foFRC2aXFLf8VJWApomUZ3ucb61ZRjmJhmpiX3GZMJ21LO
	 aUzO5cM2/4RySWnYX4xrlzAUSzsHWd+hSjEyi3XkXP+4LhXIHx3PEhF92gvEUHZeG0
	 6EYaeV5n2xHPgsyCP7HDZJZnCnIjj9F7RfyBa1w8WW7ehDl1hMKuzfmtbIyY0haA5G
	 3rmL78nrlNq+mqyqCccEEMBRdaEV4Gi8zcDvLyjr+4fj92ELeZi7c+wQb3dwkiuYul
	 bwDiCNao/V9Pg==
Message-ID: <7f00346d-5dc6-421b-8d61-75c1c3898c30@kernel.org>
Date: Fri, 27 Mar 2026 13:49:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] veth: add Byte Queue Limits (BQL) support
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, j.koeppeler@tu-berlin.de, kernel-team@cloudflare.com,
 Chris Arges <chris.arges@gmail.com>,
 Mike Freemon <mike.freemon@cloudflare.com>
References: <20260324174719.1224337-1-hawk@kernel.org>
 <87h5q1d2j9.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87h5q1d2j9.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272551-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,tu-berlin.de,cloudflare.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,medium.com:url]
X-Rspamd-Queue-Id: AB72334497E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/03/2026 10.50, Toke Høiland-Jørgensen wrote:
> hawk@kernel.org writes:
> 
>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>> latency by dynamically limiting in-flight bytes in the ptr_ring and
>> moving buffering into the qdisc where AQM algorithms can act on it.
>>
>> Problem:
>>    veth's 256-entry ptr_ring acts as a "dark buffer" -- packets queued
>>    there are invisible to the qdisc's AQM.  Under load, the ring fills
>>    completely (DRV_XOFF backpressure), adding up to 256 packets of
>>    unmanaged latency before the qdisc even sees congestion.
>>
>> Solution:
>>    BQL (STACK_XOFF) dynamically limits in-flight bytes, stopping the
>>    queue before the ring fills.  This keeps the ring shallow and pushes
>>    excess packets into the qdisc, where sojourn-based AQM can measure
>>    and drop them.
> 
> So one question here: Is *Byte* queue limits really the right thing for
> veth? As you mention above, the ptr_ring is sized in a number of
> packets. On a physical NIC, accounting bytes makes sense because there's
> a fixed line rate, so bytes turn directly into latency.
> 
> But on a veth device, the stack processing is per packet, and most
> processing takes the same amount of time regardless of the size of the
> packet (e.g., netfilter rules that operate on the skb only).
> 
> So my worry would be that when you're accounting in bytes, if there's a
> mix of big and small packets, you'd end up with the BQL algorithm
> scaling to a "too large" value, which would allow a lot of small packets
> to be queued up, adding extra latency (or even overflowing the ring
> buffer if the ratio is large enough).
> 
> Have you run any such experiments? 

Thank for bring this up.
Yes, we have considered this (and agree).

Jonas is conduction some experiments.
I will let Jonas answer?

 > And have you tried just accounting> the queue in packets, so instead of:
> 
> +		netdev_tx_sent_queue(txq, skb->len);
> 
> you'd just do:
> 
> +		netdev_tx_sent_queue(txq, 1);

I've been playing with using 1000 instead of 1, as that seems to work
better with the DQL algorithm[1].

--Jesper

[1] 
https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83



