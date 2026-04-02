Return-Path: <netdev+bounces-274422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QADFIlgnzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:22:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F551385F21
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C27303FF0D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF236C9C8;
	Thu,  2 Apr 2026 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxkEk+bO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRSjU4NF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5E3314C2
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117997; cv=none; b=c1AY1/DnHGqDM5gGEv0wD6ZAS8kQT3ohK0vmCBQb7MMekVM7mJuGNUbGmDyfywBiOht0OrmUl7kTatxKh/tJjnFTvtWQOqrKIrGgljaNmC3f62kVL6DU43QfZLxnjOH4+2BCfBppmBLlFm/0qCsXbq63cDk9OE1yeDS42wvvgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117997; c=relaxed/simple;
	bh=1CNWH0RD5qB7Qw6/e0icv6lX2ZvaieGolweobAmdkbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJ3HtubHCT7KPEvIxEuFN5apEJkqFY2qVqmXjodCjMFebSNQEJx67lF2T66O9/ZmkkuLSCsLo07K7bGtKNiJS7wrH8HeGeE02c0chTW/6o+7XVJFot/jAFtPSi/5AncUnqhcNXUbWEefDjL82AP6BO2EjvVnJovk0OPKCOk02Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxkEk+bO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRSjU4NF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAgv/iNQwR7zFYK7CL0OQLgq1P0LTe7Yih5B8afXkEw=;
	b=UxkEk+bO2y2C4QQNdS8JuHrTZWR+4zYilxwX2wm/xyP5pnxRkcDX36w/LJaW+HpKCW2MKZ
	jZVGel6yaDd2XcYKMT/ZXghxnIgxjsxwZF54UxJwBJkLE/Rkzhn2DqC5fXnuFn4DFTOzZN
	gaZn/mhmbeZqAKwZHM/iESPL+tv4NzQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-KH-h72GFMNaVmBISE9M73g-1; Thu, 02 Apr 2026 04:19:52 -0400
X-MC-Unique: KH-h72GFMNaVmBISE9M73g-1
X-Mimecast-MFC-AGG-ID: KH-h72GFMNaVmBISE9M73g_1775117991
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fc42c83aso4988055e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775117991; x=1775722791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAgv/iNQwR7zFYK7CL0OQLgq1P0LTe7Yih5B8afXkEw=;
        b=gRSjU4NF1ZC75IzfLe8wkVKvdXcUj3uEfCBVs12bmUIt3ACq7D8Ac7zf2WP7jJTVXo
         L3CHKBR/B4MgSrkJNrq8DiXrtWRA1huL9HuuwuwiDLMfUApH3iWiqWPTeM4Cu9VJn8Rc
         p54gZQLhPKeQ4SldJQCB7gXavdrIaAOyQ1fhYEk2nQ20KjlXY7YlloMmbcqMbAeOC4iq
         9Pezqn59ALbM0UQD/LNKfaZD6adqO5QwFL1mx5YEtnx7boR3hWYMpty6Ij5F78HKMG/4
         m7yZ7KM1LC5FFD7LIxjsOpFjJZQWlq5Hmkv2tuFAc0Lh3xymi08iTAEOGK0hkWReLvUT
         OxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117991; x=1775722791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAgv/iNQwR7zFYK7CL0OQLgq1P0LTe7Yih5B8afXkEw=;
        b=YFHWXzodWTZUxYxxinJbjT3ANC8zxrGNJN15Y1ug0QoNE+T/vF9oVHEarqTmKrPWzc
         jmZMEHl2iH/fQbtW+z+v8u9krpYbgL5pUq3PN4Xk7yKaKoCiu5ze4R9vNrMoE1CqThdM
         yzWcc5KA2Uid8I/4gRjXurtoWeUDxdFAFgsfX4/HMWsstWGT9UAv9o1Y8bF2CBVm5Rli
         MDmuWPduCotW1uL6wQuANiRsRwZA6Wz7W3cr+lWC2rh/bl3GqrZl2aRP2jYgHRC3gX1k
         SBwLR8ranjSIwMqGCz/r+r+nP8ZMhYcylOFpT5yMBHP08oXLLZATOMbv8NrHg01pgGVp
         FeDA==
X-Forwarded-Encrypted: i=1; AJvYcCWzHucCZAUz1FqwwYB256YhPDef5F48as4GKTdneKQlRyU99ys29AI7lAEZoldvZjCxT/uu4gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFv/n4pKTyMroOp1F9jAxKI4Th9fJy6er6+QrBLX3VDdYj/kbV
	w3lBU1kvUzx6GjNbl9ljVFa/2t/AWwLsHIgbdAbUThLoaun3coUjqeD/+Pub/tuOKzfbZuFdMSM
	msH2aeJ7GD5VtAzZxu91thbday8N9VvUZqmGyTED53XR2UPFieDsnHUEc+g==
X-Gm-Gg: ATEYQzxMgx1riHj/Hbp+jyLQ7YCjdc/kLEzeB4nreKVsrznMXBSPATEE23P/H0wQ55J
	JVs1lkoDCwjg8Fquha0rfS7AKl9W621pKzPXb+ErceNwMHQc2BkBgLBpEzVPgpRUKqtZHya/+rY
	bilTdxgwlGD16cYC6OmERqrw6A66LSjUgjqfb9O+cLHCNWCIWv83wPj73b/un58XGt06twDYGqz
	fHdhAX6H5cTxPKAerRvgcclEmqyjgUaDqbVwnO+GaWpAUIjzzyX5BFYVZyr7bDsvFpPK44T9wdp
	1Nx5fdbwZv3s6LbJcYs5iiCvUoOV2qr9wUAvH4vg4TqB+BnvUueMyuNcVQytuCyASZtnpkC3sZq
	z90ByNv3r0E3I2hQWjgyP9i+/wYeLU1KT+NbwpSb3nRJ3tpt5KX/W4tOjSA==
X-Received: by 2002:a05:600c:34d0:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-4888355e6d5mr123196075e9.2.1775117991012;
        Thu, 02 Apr 2026 01:19:51 -0700 (PDT)
X-Received: by 2002:a05:600c:34d0:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-4888355e6d5mr123195415e9.2.1775117990458;
        Thu, 02 Apr 2026 01:19:50 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a66c766sm48158205e9.8.2026.04.02.01.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 01:19:49 -0700 (PDT)
Message-ID: <d8464e0b-4622-43f8-b527-f6200bafd632@redhat.com>
Date: Thu, 2 Apr 2026 10:19:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v36 3/8] eea: probe the netdevice and create
 adminq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Dust Li <dust.li@linux.alibaba.com>
References: <20260329132222.130912-1-xuanzhuo@linux.alibaba.com>
 <20260329132222.130912-4-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260329132222.130912-4-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-274422-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F551385F21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 3:22 PM, Xuan Zhuo wrote:
> +static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
> +			     dma_addr_t req_addr, dma_addr_t res_addr,
> +			     u32 req_size, u32 res_size)
> +{
> +	struct eea_aq_cdesc *cdesc;
> +	struct eea_aq_desc *desc;
> +	int ret;
> +
> +	desc = ering_aq_alloc_desc(enet->adminq.ring);
> +
> +	desc->classid = cmd >> 8;

Here there are a couple of example where a reply to the AI reviews would
have been very useful.

Sashiko says:

---
Is it possible for ering_aq_alloc_desc() to return NULL if the admin
ring is full?
If so, will this cause a NULL pointer dereference when accessing
desc->classid?
---

AFAICS this is allucinating, as ering_aq_alloc_desc() never returns NULL.

> +	desc->flags = cpu_to_le16(enet->adminq.phase);
> +
> +	ering_sq_commit_desc(enet->adminq.ring);
> +
> +	ering_kick(enet->adminq.ring);
> +
> +	++enet->adminq.num;
> +
> +	if ((enet->adminq.num % enet->adminq.ring->num) == 0)
> +		enet->adminq.phase ^= EEA_RING_DESC_F_AQ_PHASE;

Sashiko says:

---
Does this code require a lock to serialize access?
Concurrently modifying enet->adminq.num and enet->adminq.phase from
multiple threads could lead to data races and ring corruption if
administrative commands are triggered simultaneously.
---

Again, AFAICS this is allucinating, as all the calls are under the rtnl
lock. This check took a lot of time to me, because I had to go up in the
call stack a few hops looking for any lock. A reply clarifying the
locking would have been very helpful.

> +	ret = le32_to_cpu(cdesc->status);
> +
> +	ering_cq_ack_desc(enet->adminq.ring, 1);
> +
> +	if (ret)
> +		netdev_err(enet->netdev,
> +			   "adminq exec failed. cmd: %d ret %d\n", cmd, ret);
> +
> +	return ret;
> +}

Sashiko says:

---
Are device statuses returned as positive integers?
If this returns a positive value during eea_net_probe(), it will bubble
up to the PCI subsystem. Since the driver model treats a return value >
0 as a successful probe, the PCI core might believe the device is
successfully bound even though the error path in eea_net_probe() freed
the resources.
Could this lead to a use-after-free during device removal?
---

This looks real to me, and was already reported in the previous
iteration. The question is: why do you consider this invalid? Or did you
miss the remark? A reply to this comment would have been helpful.

The bottom line is please go over the comments reported by sashiko, and
either take care of them (dropping a line in the changelog about the
update) or reply on the ML explaining why the comment is not valid, with
a single reply per patch touching all the relevant comments.

I understand it takes a significant effort, but if you leave this
entirely on us, the only choice we have is to unconditionally set to
change request any patches with AI remarks due to the volume of comments
and capacity limits.

Thanks,

Paolo


