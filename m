Return-Path: <netdev+bounces-306617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wMrDDrgOUWou+wIAu9opvQ
	(envelope-from <netdev+bounces-306617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:24:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC1873C367
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:24:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=h0SnsiL1;
	dkim=pass header.d=redhat.com header.s=google header.b=LcWVOA47;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306617-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306617-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3A03020027
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7F361DDC;
	Fri, 10 Jul 2026 15:20:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D13630AD
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:20:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696810; cv=none; b=Ii5AKc2i3mdt+JIAiy1r+ioNi8Bon2GJ4yaHF5bCPNtBqsZKP03s+Q5rUR3Zlqg1QCQ/AuDBQqiNpFCVLMR3KDxXm6HUZbmw3rdEYVOYx0VFVDjiOhfOipn1sF/Ud3W5B84VCt4DlC1S63cI1c0aCBsCf1ukAD9jgLyKzXX5jC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696810; c=relaxed/simple;
	bh=Hq/TfuYH3r/+IOSoegS8Ha91hOvkuzWStjGeFh2FIQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4RyBdMqZQ8/aWo18673o2ZqP348s4VMSZ4Z+3uEB3a9KKEPdXrP9xoNmZ51ywsH7wSONtax+CrZTURSHrPDUJKMbIUeFDV09XZIk0BtinDpn+HApZcidlXz1NUouxof7xb/fdc7kJuk7ieF3w+QRLwy+suTap2MKpj/kfal8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0SnsiL1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcWVOA47; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783696808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmIvcZNa9p0mV3n0KTWqdfWBLJbdo7zW7kmxA8+Ij2s=;
	b=h0SnsiL1p9SqBUfrEtr4HAwkEp1PvAjfsKNPwD5zME/W0A8esvGhUe55ZTLfxjHwiEEdX1
	Y5muHUinBWWs8OtnY3MlVS5RyxW3zpRa49CXL8Q/X2enqXPhqbGcHPCzE+BZwRk6gyT1Lg
	orFlW5jB3PjUV+2xgWlYdcmGtSYFc/0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-v-alUUDqNouDXT4jL_jIbA-1; Fri, 10 Jul 2026 11:20:06 -0400
X-MC-Unique: v-alUUDqNouDXT4jL_jIbA-1
X-Mimecast-MFC-AGG-ID: v-alUUDqNouDXT4jL_jIbA_1783696805
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bdaf8549so9605865e9.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783696805; x=1784301605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EmIvcZNa9p0mV3n0KTWqdfWBLJbdo7zW7kmxA8+Ij2s=;
        b=LcWVOA47aOs/b8VksVAa0Rt0VIHI4/R9zky53YkO7LId+QBrsUHnAkza8mVh06eWUM
         grzSp9Hcm5xYd7DBnkLCcr0Tc9JMvUaUHkrwHSCc6kjuxbYlzh968bbKyvbDeZIabizy
         V4z46XZOPqdLZSBVZ0vlbAQncxY40sM9/unCxYY6lxw4kwFebYZPjS9i22tz1J4MFIGN
         spASpI42vbV6BtMU9jIeqf0nuH9p23VclzlOtE+7c7mRx/G/TV7W0J42rey+l2zicH/a
         imE0c6TWMUxgrFScNvmXTQ/Bjb5OQ6NUIJQ7/gychXO12/o700QnovoAVga3/okkCqTk
         9bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696805; x=1784301605;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EmIvcZNa9p0mV3n0KTWqdfWBLJbdo7zW7kmxA8+Ij2s=;
        b=RgtOW5fcthvNkjXoCTdO625xD1Zl5WcdJRfJg25K6SzIBnZ5DrUB7111I/ETwS/d7x
         ZMC6yFlIc2UO1eLi11iYHo7RAlJJsrwRvw8qMXEKcz37zIkJaHC0shzvMH0CM8dnZKrw
         0IHDCL+7fkvUBAujP2iOPkCXWRjMo0UvvZE9m2LR9+q1UUqhqU+UJm0GG4m+nNUeZXRF
         ifmH8TGcIh0g48ZVYq8G18pbq1QIvS+lmA/mGedoG0g+jfxjA73EcGtHHMPLPQ5WnbRr
         sJ4QmqWGT3zCMW6A81kTqH3LqTmETBI0tcP+iKJjkfospxKH7i82ynuftfx6WDxg/tav
         s5YA==
X-Forwarded-Encrypted: i=1; AHgh+RpOlcS6hCbw+JUkY+BpOTOFzc6zEpz+/K/TdQp+AOyRPAWU7vvEiuu/Ib3+uZwiI3J8wgfOs4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGR0Zy0UP+p5M0Lz60pkw6j3Hx5sBpBtkW7YpGu24ibqrslFt5
	/CA2xYnV1CyGqTpCATToOvy47lSf8R9Y2akhahg34fTYIBF2wPRN7x7HAsAa+HhghE6jza7Mmv0
	a09XpxyjbgpcS4KmvBaWyj7Z5LC8U0eFVbmdGpfob9xDzEhPE9mNnTVe/oQ==
X-Gm-Gg: AfdE7clkMr5BC21ZBATHkxrAq3FBrvtOGWlxjDX1FhfuqO+f/n66elq1vnTe9evrdDD
	o5EOowV04CtRx+I78ojbuZLMvdUCAYHCQ3CCebHTyH9GjH6Dav6T8EEm5P576WLf/LmAm/IUpgE
	jq2Y9MpBudHjynH5Td8FkeXKTbKV0mXXyKs+0iOioRB/z3Ir2MFKjYkN+wtfCl3Y/XW3LdOvJCC
	nMKkR4Vb8Dl8yhdeNjKZrP3SZ/NRDNgCVN2lFLITI7gP+0WTp52oCYzHLvQqPuyABv791zTa5Bb
	94CSC66lnbnaVp0lrWUv2nvzUHcGllorAVutYCc6CPXnEpDl7ghUoKSHhCwSYjL0pkpLq75w65F
	MOYCj/Lb2pq1n2bulgPYAsJ27H7SGO3d1HcL70fvkcCnXeMN4wSfMQ2Qnx+kYgL+y0HIpOmI4iQ
	m7rntBM9BhPHqn
X-Received: by 2002:a05:600c:6087:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-493e6892f6bmr121300735e9.5.1783696805302;
        Fri, 10 Jul 2026 08:20:05 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-493e6892f6bmr121300305e9.5.1783696804801;
        Fri, 10 Jul 2026 08:20:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm44901265e9.13.2026.07.10.08.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:20:04 -0700 (PDT)
Message-ID: <aa56a163-7333-4559-86be-ac40a806fa07@redhat.com>
Date: Fri, 10 Jul 2026 17:20:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] net: pktgen: add support for SO_TXTIME
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, andrew@lunn.ch, Willem de Bruijn <willemb@google.com>
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
 <20260706133433.3142805-8-willemdebruijn.kernel@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260706133433.3142805-8-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306617-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BC1873C367

On 7/6/26 3:34 PM, Willem de Bruijn wrote:
> @@ -1141,6 +1157,49 @@ static ssize_t pktgen_if_write(struct file *file,
>  			(unsigned long long) pkt_dev->delay);
>  		return count;
>  	}
> +	if (!strcmp(name, "txtime_delay")) {
> +		max = min(10, count - i);
> +		len = num_arg(&user_buffer[i], max, &value);
> +		if (len < 0)
> +			return len;
> +
> +		/* in queue_xmit mode fq may clear tstamp, do not reuse skb */
> +		if (value > 0 && pkt_dev->clone_skb > 0)
> +			return -EINVAL;
> +
> +		pkt_dev->txtime_delay = (u64)value;

It looks like `pkt_dev->txtime_delay` access pattern is the same way as
`pkt_dev->txtime_clockid,`. I think WRITE_ONCE() is needed here, and
READ_ONCE() in pktgen_xmit().

> @@ -3557,6 +3633,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		}
>  		pkt_dev->last_pkt_size = pkt_dev->skb->len;
>  		pkt_dev->clone_count = 0;	/* reset counter */
> +
> +		if (pkt_dev->flags & F_TXTIME && pkt_dev->txtime_delay) {

`pkt_dev->flags` is accessed at the beginning of this function with a
READ_ONCE. I think it should be better to consolidate the two reads.

/P


