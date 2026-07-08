Return-Path: <netdev+bounces-305763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m/w3KUksTmo7EgIAu9opvQ
	(envelope-from <netdev+bounces-305763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D0F7248D1
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:54:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QqthG9ND;
	dkim=pass header.d=redhat.com header.s=google header.b=QyXGLIXe;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305763-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305763-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AB71307A2C4
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80D5414DD3;
	Wed,  8 Jul 2026 10:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1ED38E8AB
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:50:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507820; cv=none; b=W7IINY1YhYy96B1jVsqf6y+fl1ysXIkHrpxQqZndXoxDjf2QOVpjUC1XZgcBPY7QjU2jidmVQD5UYK6Larr4IdNple0yCfpyu2SqczhGamX8GD6dAPbF78cdATZJKEZQLAa/z/kBtc44oqT5eu/OuQw1Fl9v8tcwSRO+vABdkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507820; c=relaxed/simple;
	bh=XbtrJUUeM3xNHOoBDhocSvoqSRxhQJf5NIcQJ2vvppI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2JoaUuAeRyldaNLy1cPcuZIW/YUkYFwkrI4++b2ifgtwsryGWflLkQ7u2jw74McIKJqVgqXw0uNudH1fqrsilGphklvuvylCTv+zGd/e+kSk77PjToPEygAUSU/s6f1aZLEPHubt2gR2wVxkeEPzWchji20trivNm1wuPp+R9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqthG9ND; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyXGLIXe; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783507813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RthwfiaiuQwFULsU9rLR+4p2hP6BkmVyKgFOz4tjmA=;
	b=QqthG9ND+/rwaf1cjppmLex2EYwg0ZZka8lr1sZ9MZqqF25l9xr+4Ryglr4dBUU2r57hr0
	CmKgfd2dnH0y2ssVGOdJWjxHtQg/CeMw6aQ6G/huf2dadQRsxGmXsSfytd+a3pcSs/h3Z2
	F0o6MxX0ZGQEF1vNxbXDCka4d9a2uMM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-Lc29S4g6POaz7kRHQI4x_Q-1; Wed, 08 Jul 2026 06:50:12 -0400
X-MC-Unique: Lc29S4g6POaz7kRHQI4x_Q-1
X-Mimecast-MFC-AGG-ID: Lc29S4g6POaz7kRHQI4x_Q_1783507811
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493c20d0468so7259885e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783507811; x=1784112611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RthwfiaiuQwFULsU9rLR+4p2hP6BkmVyKgFOz4tjmA=;
        b=QyXGLIXegC9GU8f+7pf9mscNhjhpghkLNmZwWQ8FttE9MXp9UZfvHghK3670O3CIEu
         KzUnbutFlOEcFKIGWpz+apyBYVZhDx8/SF5LqhmyOomOTjIkerJQmlBdJ6DNh5hvjWfg
         F9mK9gOYZwv5xqLSo1hIb7UG4W+j2Y9QfKpvglZdzziSjPVy1hLsZkivX5o0/ZZ0TLmd
         bD9HGpBnubzcwDZ54p/kMfzXV9VU1EaX9lDX3IlrkF1fiE7PMfR9lQbEhzZ905iIB5U8
         7H3U2u4Gw74t1vyCgFWa9PEGnvLiV2mkCvSKK/gH+dvF3mJNM0J03Ojp9BEkVaBGRmVJ
         Qb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783507811; x=1784112611;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RthwfiaiuQwFULsU9rLR+4p2hP6BkmVyKgFOz4tjmA=;
        b=fExcERpvHxPJTVivH4XcKjcucDyhaIfj1ZKSYwW4CBlc/UPqf5Fj/NZSwJNSPCzkvO
         jY1SsgjNzoDzjmtfD0TKiY9lDTsSJ8KeIYl3SpRVB2GWF5HODUvxCsdjKvF5CV+hR61n
         7f0XAypQtEMFNxdVuwdc1Ew85yZbtmgYnKHvJGvlsauqDKbp5S/zrPkrQ/IVE2MSsL6l
         lRKL4sAgbZSOXhHlIHlxWPK4IPaVQtWCB59/UiB5s1MJXyHpV/YRj6ROuFNV7HtZyCmB
         nJM5Tflil+2I5p7ICiGvyMle1NPtMx+cltPFAhZC13ty5nKXerRMpyKAkPDQE5X/Fngi
         Zjfg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+35zKLCzCby+7nInbIoI9lClxUd3oJNub0xoheswyyVcarQe/4wMIslrmUG/vWqAi0o+gi7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcAcn45qtD7X9HSqdjPwJEU72GdALcIM2jH+qC8Axk/P9aTlo
	q4Z4PM+rk6hkBc/wpIpRiv/bLRJad2n+k7POMpJICq0yCzUbC17OV6k7GatqxboCri8Z7jb+K/H
	HJve0AqLBQrVikXMSzmZ/+fBf0pyxBpKqQWp7U+JhyZ5GlCxKxIPNo/lWIg==
X-Gm-Gg: AfdE7ckholCsnXx13Gj4paiqNWsSCNGsci4+UXQMdIpVg3lk93P0J9lHX4rWvPuADqY
	0NmDTOuNZ3r8+vM8dukuTbdNmsxkDm4JhbytdfWBjJOzq6ci2XHPxWeI0Ye9mfqFF1HMAHfStuM
	dmKZsrMzbjw1SCKfMADouE2DHHzQaBEq273wjd7T/pTZuBdv9a/Q+q2hEysTgjIDF5f4M8ihalX
	D2xYYjMuy4+OStDbdEKspWNlE2QVL8HcUdjCHVoVJ7x6WJnZ/ya+eajRr00K4OLx/4cL6v6HKZJ
	ynfUqVGomavOGLoCjlD/oUDmTg/h8VWRx/Xta+CVjJj4N643PCKpgoSbB3Zo+8isRjaH3l6O5iI
	TZYjER0V81DAc8oIflUjQl90uQ41RSqT6VzexEnq7OwjOM4J4jDp/6HiXQHol1Ro9/UIczJLSt1
	b7bosMvnVdApc4
X-Received: by 2002:a05:600c:3b92:b0:493:e892:f03c with SMTP id 5b1f17b1804b1-493e892f05amr3891795e9.10.1783507811133;
        Wed, 08 Jul 2026 03:50:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3b92:b0:493:e892:f03c with SMTP id 5b1f17b1804b1-493e892f05amr3891245e9.10.1783507810639;
        Wed, 08 Jul 2026 03:50:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f40912sm123922735e9.4.2026.07.08.03.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:50:10 -0700 (PDT)
Message-ID: <15e72c82-ca99-481b-bd53-744fabd503b0@redhat.com>
Date: Wed, 8 Jul 2026 12:50:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
To: Mina Almasry <almasrymina@google.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me, razor@blackwall.org,
 daniel@iogearbox.net, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Joe Damato <joe@dama.to>,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <20260701-tcpdm-large-niovs-v4-1-ca4654f37570@meta.com>
 <CAHS8izNdJ1LTOr_pLjXef6Yv-=JOFPe1GcZtcbStD93Tkpy1XQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAHS8izNdJ1LTOr_pLjXef6Yv-=JOFPe1GcZtcbStD93Tkpy1XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305763-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:almasrymina@google.com,m:bobbyeshleman@gmail.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:joe@dama.to,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,lunn.ch,redhat.com,intel.com,linaro.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,fomichev.me,blackwall.org,iogearbox.net,davidwei.uk,dama.to,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41D0F7248D1

On 7/7/26 10:36 PM, Mina Almasry wrote:
> On Wed, Jul 1, 2026 at 12:22 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>>
>> From: Bobby Eshleman <bobbyeshleman@meta.com>
>>
>> Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
>> This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
>> churn for large flows.
>>
>> Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE, that
>> lets userspace request a larger niov size. The value must be a power of
>> two >= PAGE_SIZE.
>>
>> Measurements
>> ------------

Checkpatch complains about this separator usage:

ERROR: Invalid commit separator - some tools may have problems applying this
#15:
------------

Please replace or remove it in the next revision

>> @@ -90,16 +90,17 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
>>         struct dmabuf_genpool_chunk_owner *owner;
>>         unsigned long dma_addr;
>>         struct net_iov *niov;
>> -       ssize_t offset;
>> -       ssize_t index;
>> +       size_t offset;
>> +       size_t index;
>>
> 
> nit: I would keep this signed. Some of the most frustrating issues I
> ran into is some of the underflowing and then passing a > check or
> something. Although if the LLM is not complaining about this
> particular case, there is probably no issue with it. I also notice a
> lot of existing code that deals with indexes and offsets goes for
> signed.

At very least the above change should go in a separate patch, as is
quite unrelated from the rest.

/P


