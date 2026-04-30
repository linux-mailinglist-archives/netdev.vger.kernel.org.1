Return-Path: <netdev+bounces-282722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKdpKSoi82nIxQEAu9opvQ
	(envelope-from <netdev+bounces-282722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:34:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A718A49FDF9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7F543006010
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616E399015;
	Thu, 30 Apr 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyC2ie09";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiXgsBrY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B412F8BF0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541666; cv=none; b=LbxklY8FYW7KoqdWbsHU5EDVoeNTiM0J6rNaHNaeDI2D28Tr+exXMIhuXkG2T5oTb4BtwgwQAEWwrS3FEu1kaER+PWtY+1dqOgLdN0Rwe9VDtv+dymOHPEBPZyd/CIMqBJ6SG5AcgVeT6ROAP7R0aBVUos95g7zUAOwQ/gxSFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541666; c=relaxed/simple;
	bh=6TManpl4gcqzmqAn+8fUAGVRHhuyH7T7ouTpR8dqiSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icVkcBDoERPe53AmHY3BFoS3jnt6a3ULcrHlpvOqH7jA/u9LEIZ+CsNPpZC+PQBMrsecSYcMZTlJ6SELgrAyLDjMP1ACSl1cZVSl7Iyo840XFjrdN5edHv2wjY485HJbA3cS0bvVEHoDY28aWYHftjyNCOTSg4XSHTL0tFp7oJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyC2ie09; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiXgsBrY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777541663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVHyDFwjO6klzKvDUezrJjMUwHWUlJqJfALG2/aYsdI=;
	b=EyC2ie09pSYehijGa4aUDyVQlsGTq7t92C2exawAd3xXA4yIBJqkm7rrmnRSam8Ra2Lwg5
	ixT1dpaRZXxnxr/Y19CYC9dn53XWbWa6gvdq6jBwH+DLfVKP1WNAA1OaXihrZ6CMXGUex2
	ulRICzpLzwIeZ282keJE2jAJYumGHzs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-qwP4jzFNMauItvCF22XYfg-1; Thu, 30 Apr 2026 05:34:22 -0400
X-MC-Unique: qwP4jzFNMauItvCF22XYfg-1
X-Mimecast-MFC-AGG-ID: qwP4jzFNMauItvCF22XYfg_1777541661
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso618371f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777541661; x=1778146461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVHyDFwjO6klzKvDUezrJjMUwHWUlJqJfALG2/aYsdI=;
        b=OiXgsBrY+SZzSz1ZH+nyxFo5mHQ96KWjIOiiNG/RxX83uiZbip9eRrJti1ZIPYy4eO
         5Wgt4sFhZAelDNKRXfYeN88aVfBDwT35NSnRqqMnWE2g/Q+2L0ZHM6IYQDsfE+jU+rw/
         V+UsuiIWYO2aMAR52/XPfuXOrO4ASROqG0yeJ0rseO4NEak8N33EuzGHSqV617vcXXCj
         ATfi3NohVHrFdl1ka36Wk64UUtDcfnSg+05qhUztgFZuufTFrkYmFD+cg88wql2QAncK
         OQPVlzk86vYWvqPRfrzYzEmMOWyRtQL7rJ5edu5mLJenYOXHxvC+qt7X1Vh4FZeGUYpG
         Btuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777541661; x=1778146461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVHyDFwjO6klzKvDUezrJjMUwHWUlJqJfALG2/aYsdI=;
        b=rrqAJkWlFFRzQbZ95CTzj74VIlcn2nVTroHPw7ALvSOH+L2sRnWrzUXpAbV0hUNu2b
         L9dS2zSzSQYz0oWCwjTXdd1JK29b64PaoKbfRGymsf/UBsGUN9+CKDuohR6e22PZZt+H
         nv8g8NNJRffn0BDmMjXEvTugUDyE7htUNpZTWgS6U26X65nJj5lVMT/89ti3qKDxqLJH
         S8etBB0q9UsysN9153Ta+Ck2zZmqbOsCdsk8f8HoTd90/H7FPFBiMyOSpxJWXOB7dD32
         RfsPV2Nyqn0/Jd2COprt2NQb9GLmtX2DLnqR0g14Ui+A8RbkuT+gmglngGEOxbzHyDGa
         3MHg==
X-Forwarded-Encrypted: i=1; AFNElJ9LrgOeoVwtRY0FxNJrX+DIR6bnxqQo9a2qRH3tYdgJ7RP9VX023jbVTWuPbn2LyU2KDyHTh44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsAzNG29SbReyDBBjbs8zkqBX04MEfSsdzhWMiyuWOHBVpCb6
	Ii5S8maz2FiVDhkZn5yANsRS9UHjH86a6qaks1YBeRn5BoHacqt9TUM8qKlfsN81qJww8rUTYBo
	I7BzZQUQHpkomRulcxDOUcmmUVjR/1v5zYfn+TR2ICHKI2eqUkxwwp+r4HQ==
X-Gm-Gg: AeBDievPVFEQfrDpBEvbZJ6pGH2BSNXp+g9WU3Nio/sLrN7JbJan7k1XeMPoF456EAo
	GxShm17TBuUgsBGNxIlPYgw3PYjSrgWF9rVPDht9VcQFImBi08hIAs0x53ON8jXkoQLluacMxj3
	Or5K1j56+B47wgX7i3JDYaVK9w60LeYEpAf59CsFbiqIVwqQALh2nytDh2H2Azg5mgDhcgenjao
	iSGacqrwgvgdIBuhuum3lSI0/BcuC7S7aVwEVHzOHYUdnP0kza7yFJddeaQZbHToRE1jUkFkhap
	deF/HO2w4uTCyC+FYQ60228YKF+A8bu8yy6WYZZumtSlsag/al5kHZIemR0KZW/OzOyGAaTOuFn
	WkppFpF3nPkyg/C760F/vLEkgbvG3ILzwiqMbdYrLiujWQ6aUObwe7qexFkLcJJYsJw==
X-Received: by 2002:a05:6000:40dd:b0:447:55b5:d532 with SMTP id ffacd0b85a97d-4493ec62a60mr3634735f8f.37.1777541660745;
        Thu, 30 Apr 2026 02:34:20 -0700 (PDT)
X-Received: by 2002:a05:6000:40dd:b0:447:55b5:d532 with SMTP id ffacd0b85a97d-4493ec62a60mr3634660f8f.37.1777541660114;
        Thu, 30 Apr 2026 02:34:20 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c0csm11853942f8f.29.2026.04.30.02.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 02:34:19 -0700 (PDT)
Message-ID: <9d7f1bbc-155d-4c18-bcf7-732ebe4cbf67@redhat.com>
Date: Thu, 30 Apr 2026 11:34:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 1/2] net: pppoe: implement GRO/GSO support
To: Qingfang Deng <dqfext@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-ppp@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
References: <20260326081127.61229-1-dqfext@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326081127.61229-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A718A49FDF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282722-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 3/26/26 9:11 AM, Qingfang Deng wrote:
> +static int pppoe_gro_complete(struct sk_buff *skb, int nhoff)
> +{
> +	struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb->data + nhoff);
> +	__be16 type = pppoe_hdr_proto(phdr);
> +	struct packet_offload *ptype;
> +	unsigned int len;
> +
> +	ptype = gro_find_complete_by_type(type);
> +	if (!ptype)
> +		return -ENOENT;
> +
> +	len = skb->len - (nhoff + sizeof(*phdr));
> +	len = min(len, 0xFFFFU);

AFAICS, when the computed len is >= 64K, and the above min() will
truncate it, later pppoe_rcv() will drop the packet.

I think you should prevent such case at GRO time, flushing the chain
when it grows too big.

> +	phdr->length = cpu_to_be16(len);
> +
> +	return INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
> +				  ipv6_gro_complete, inet_gro_complete,
> +				  skb, nhoff + PPPOE_SES_HLEN);
> +}
> +
> +static struct sk_buff *pppoe_gso_segment(struct sk_buff *skb,
> +					 netdev_features_t features)
> +{
> +	unsigned int pppoe_hlen = sizeof(struct pppoe_hdr) + 2;
> +	struct sk_buff *segs = ERR_PTR(-EINVAL);
> +	u16 mac_offset = skb->mac_header;
> +	struct packet_offload *ptype;
> +	u16 mac_len = skb->mac_len;
> +	struct pppoe_hdr *phdr;
> +	__be16 orig_type, type;
> +	int len, nhoff;
> +
> +	skb_reset_network_header(skb);
> +	nhoff = skb_network_header(skb) - skb_mac_header(skb);
> +
> +	if (unlikely(!pskb_may_pull(skb, pppoe_hlen)))
> +		goto out;
> +
> +	phdr = (struct pppoe_hdr *)skb_network_header(skb);
> +	type = pppoe_hdr_proto(phdr);
> +	ptype = gro_find_complete_by_type(type);
> +	if (!ptype)
> +		goto out;
> +
> +	orig_type = skb->protocol;
> +	__skb_pull(skb, pppoe_hlen);
> +	segs = ptype->callbacks.gso_segment(skb, features);
> +	if (IS_ERR_OR_NULL(segs)) {
> +		skb_gso_error_unwind(skb, orig_type, pppoe_hlen, mac_offset,
> +				     mac_len);
> +		goto out;
> +	}
> +
> +	skb = segs;
> +	do {
> +		phdr = (struct pppoe_hdr *)(skb_mac_header(skb) + nhoff);
> +		len = skb->len - (nhoff + sizeof(*phdr));
> +		phdr->length = cpu_to_be16(len);
> +		skb->network_header = (u8 *)phdr - skb->head;

I understand is quite late for the following question, but...
The network headers points to the pppoe hdr. Should it point to the
actual IP hdr?

Why not? A comment in the code or in the commit message would be
appreciated.

/P


