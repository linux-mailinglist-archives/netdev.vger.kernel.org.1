Return-Path: <netdev+bounces-254157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KoaBnHReWlCzwEAu9opvQ
	(envelope-from <netdev+bounces-254157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:05:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E5A9E9F9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 468003012CEC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D87833D515;
	Wed, 28 Jan 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GS1Mee1z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMQgQQXr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD457221DB1
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591150; cv=none; b=toaE+tfaMonSr5VgHqtNnoAx2gqwuFt6NHOzxN43lkT4rcugwKbLQjAL5Gw8gjDbOYqW+gwNgTj/FC4YuwnoticLRWjl1ufLuDWUp2Zz5GuQ4vmWIT5bdB4Yv9tgW1AEPJMNrhpL0nugtEy+1ETVDWv9Xz7b72TxxZon5J/hBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591150; c=relaxed/simple;
	bh=vHvtxzPEXOaSc58IA9aVoKEeNSkoXrevYV133ucx2iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hq6sfuMIPzjwGJZZO9BUT/tcDMwb8MEUwhS+mkoKwiaLJfEz5JQsEvJCcCd7PEB3DWPgC6xJASU5QfR5DlXcq2dstsiO1bEGEG1O7EOm4/Zb66EUacLDapZ5o1l08tGfAxcnXw1/0UiN2ZlNFnzPod8jiypEnt7TVEeuVuQMzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GS1Mee1z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMQgQQXr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769591147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/j23iN+UkMbSN4vMrWrOPjNdDh2HD+7QDGW6v7K/og=;
	b=GS1Mee1z5qxnk0kbAznOu3A4HCfAHtKqXeFcJB1wJT7Qdlcz8HdcxgXV0vEh6+QxNUjPUf
	NFmDSuDXtSnq44+7vIDXqpLfupUz1cxcujA2ySGlXhE9JReoQZv8+7S1Se5pPfm/icLgzL
	oM0FHNzGjkpzejiZ/WXUFrruuDhN9ns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-CTsBDZAyNTWBfqpzA1AZaQ-1; Wed, 28 Jan 2026 04:05:46 -0500
X-MC-Unique: CTsBDZAyNTWBfqpzA1AZaQ-1
X-Mimecast-MFC-AGG-ID: CTsBDZAyNTWBfqpzA1AZaQ_1769591145
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477c49f273fso71107165e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769591145; x=1770195945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/j23iN+UkMbSN4vMrWrOPjNdDh2HD+7QDGW6v7K/og=;
        b=LMQgQQXrHQOdsYfg9bQc9Bh3NSAs30ZUy+3eLTm4ndR43KaC/PvmN2fnBaloYp1Q49
         iS0v7LLgrfOOk3aTdcqizXM7Q6ms+1T6GEK3a1VTLsxjFUzPhuOkw62wPyi3PfSb2oco
         NWGQsZbNDkFMG+cBpNR1cPNrp+a7hUgu1jFlfveQjfccUv5CqiFOkJR0S0yqPXZkPpx9
         TdYUw9E0kaje/iTz4cl0v6srsJ1NloyHIDr+8Mdu+biJH85aNLTwjU8m6hxuyRaTdZpT
         rA4ttwxEpHBQmTsEDv97MY/4mGMZuH22bqbs9SRsVjeihIVFClpXZHXAGcQFXb4C+0Rd
         MbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769591145; x=1770195945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/j23iN+UkMbSN4vMrWrOPjNdDh2HD+7QDGW6v7K/og=;
        b=La0ZMG9ux9fcVOMYn8575+GUH5KVuwbta+sGl0bUZxdl2+fIrictGpyKCTYvgAfCUk
         Ko8l8FLJ62qQuWCMO6G18VV6+uOmlHojVaCQGqJWSxRr584qSaMsk4oSmzGaRoW5EHsr
         pTw4lNMq8NcpSXtkNT4i6NrMPkkwpilJ+yYdbP3qlxsU9r1/T5lGe5frUxQQMQz6UXr5
         3APNWyO7vDMJMEyltoIltmlKfKJ9WAC7dOsFYc6K8I0QVKckpUngRKzOYb9xByW7vqPK
         pXH6MdITJCNe9wEkXoZp4w+8LD/J1htM0WhvMFi1EAfpt45hVn+ei2qJHkfqbfGIeBrv
         nPMg==
X-Forwarded-Encrypted: i=1; AJvYcCX+/fGVwT1Xap7ootlot1DYbJiWDq8kw8ZElKO2dD9/67fSHyzoiOqYLZd6OIQSWVtk7ko26+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKILGak0ss8wkjIdWtmJWRRCv/0hQNe3u6vaYK6xRq/tv1k5n8
	oxAlbAeGKJolj6eJms0uFb3IePWiov6Mip4KOXUCCMxspDXkVfOEvDE0rdKyRG2BzuL3imRFaF0
	Cy/GBr2coE2aKe7miR38yAVpCMJQsfoPXI0ATtdPI/5wcldQgxsCST+Q5nP6z7sViUw==
X-Gm-Gg: AZuq6aLRVyQdxLLkj2hgnSDy2seBHkL97TaqMQbI2D92wz+uLzpUJXBIDDFnHE62hUM
	HHHRKE/Z9EfaJTFAGxz4LZlDePArak9gqBNj25vgum1bOY/TVr5ahc7s0I1+R4kGuy27Ljlcrq3
	VH6f6KGtOQ012Im+39GkREJG0NkV3cPzw0DeO9zwg506VIIMZq5IsXeAxvYWHgAcRPj7zaHYzW9
	YQcghsdYl6Dw4IZdzxo1dOZddMx/uoaD0mQZfAiheAQmmWjSfgiNm/c6YZmx/0t9W1RqsLckeTG
	w6mD3CKmOzTG6Cgn7FMb8UbR+x6BKt/1N0Sk0ZNPzVgT9ooDVaIbuidhyqpeYVTfe4QRec6o6bv
	/9qr1Z5cvxiOD
X-Received: by 2002:a05:600c:8211:b0:480:4c45:aff5 with SMTP id 5b1f17b1804b1-48069c755e6mr50508675e9.34.1769591145060;
        Wed, 28 Jan 2026 01:05:45 -0800 (PST)
X-Received: by 2002:a05:600c:8211:b0:480:4c45:aff5 with SMTP id 5b1f17b1804b1-48069c755e6mr50508385e9.34.1769591144647;
        Wed, 28 Jan 2026 01:05:44 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd77b8sm50526305e9.3.2026.01.28.01.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 01:05:43 -0800 (PST)
Message-ID: <53ce393d-7071-40d8-b57e-df14405066ca@redhat.com>
Date: Wed, 28 Jan 2026 10:05:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] ppp: enable TX scatter-gather
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20260123014214.225278-1-dqfext@gmail.com>
 <a957214d-62dc-40cd-a422-73b317bc1827@redhat.com>
 <CALW65jYb0prfB-KpxdcNVHB1tBjN3tW286BsvQkCFoXwTu2QKw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALW65jYb0prfB-KpxdcNVHB1tBjN3tW286BsvQkCFoXwTu2QKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254157-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86E5A9E9F9
X-Rspamd-Action: no action



On 1/27/26 3:31 PM, Qingfang Deng wrote:
> Hi Paolo,
> 
> On Tue, Jan 27, 2026 at 8:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> I spent a little time trying to understanding the logic here and I think
>> that enabling features depending on IFF_NO_QUEUE is fragile at best.
>>
>> It looks like that the IFF_NO_QUEUE bit is an inconsistent state for
>> multilink devices using different type of channels.
>> Moreover the user-space could attaching a qdisc to the ppp device after
>> channel initialization.
>>
>> Instead you could always expose the features and linearize as needed
>> when transmitting on !direct_xmit channel; no need to touch the
>> individual channel implementation, you could do such check before
>> calling the ops->start_xmit() calls (possibly creating a new
>> wrapper/helper for that).
> 
> Attaching a new qdisc won't clear the IFF_NO_QUEUE bit. (The flag
> means the interface _can_ run without a qdisc).

Correct.

> As for multilink devices, one is not supposed to bundle channels with
> inconsistent direct_xmit (for example, mix ppp_synctty with pptp) and
> expect better results. But as the driver does not reject that, I may
> add a skb_linearize() to ppp_mp_explode(), or add a check for
> SC_MULTILINK flag in ppp_fix_features().
> 
> What do you think?

AFAICS nothing prevent the user-space from creating multiple channels
with different type even without SC_MULTILINK, so ppp_fix_features()
should likely check the whole channel list.

Also packets could be being transmitted after channel creation and
before the features are updated, so ppp_start_xmit could observe
transient mismatching features and skb layout.

It's not a matter of bad performances: if skb is not linear and the
channel start_xmit assumes linear layout bad things will happen. I think
that even with a correct ppp_fix_features() you will need to check for
linearization in the datapath (as an unlikely condition).

/P


