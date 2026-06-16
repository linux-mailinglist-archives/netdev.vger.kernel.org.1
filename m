Return-Path: <netdev+bounces-299953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zUC9DUy2MWqRpQUAu9opvQ
	(envelope-from <netdev+bounces-299953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F97695485
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:47:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b=Py9mUpUd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299953-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299953-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DABA3025B8C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A33392C39;
	Tue, 16 Jun 2026 20:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B737CD32
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 20:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642826; cv=none; b=cnlwHGxguFIoPMrTbHtzN9emzytWihbXRWrX2JolRB311JJMTqm2oPG8W+h5eqSFP1MsAg9OSs/5MT5FnUQ3cEf8ihcPVbTE1+rQFqAka1fajlmgmTFzGNx8UCrQuThojyKLC9IOiXPNKG+8ZUqIIR+M7Pgx+a5B46nGYLIE4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642826; c=relaxed/simple;
	bh=55ubhwgPFP/ggX+sEQoWYZsZ9CMeijE8qXL6+9SVM4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=se1NCn6oOGrZpRQzvMEXXuKwAu1Ew7T/17zbBLtScMefQOE0YwaGlUaNbSMhKVhKX8JqG9qwwrnYCUsNIKwUsG05pjuSQdrZZZgY1Le9AW68ny0CV2mYu9waMjkRgJw7GHS0hR7XSWal9a/WwoxwU8tPjmkgoOdVwyXlErdmw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Py9mUpUd; arc=none smtp.client-ip=209.85.160.42
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-440ebc72386so2644931fac.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642823; x=1782247623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3bsbmxS4GadL4Z4bToRsBD+Gi0dvukUshOqKGVXCG8=;
        b=Py9mUpUdWt5vXOQMHpSDFKNdc07dV8zSmKyrmmqNUKFTu/VSDcSGSFT/b2qqNsW69W
         SNSwSPbiHJsW7x7URUBqDzziXp+n1NzryTK6BcpA4Rp1Nra3/rgmAqE1ch2zhzeu30wP
         e1wZ/1W1k+2sVKyjipQ8CzHQw2tNo2TI0UXy5fhdoeYEJPL9fckaT7oF38Oax4pwssJK
         0MUYJxjS5vtn2bFYV+tidJ0pp8MVx6j2bH6L5OgHnqOA5K9+Brdd+NsaYlPCCw2f4h8W
         ODsQ5gbidbn8t2I5yA/Zgp1SMqBzcNCcFo72ar7wJ6jooOBG+XkY527bxxeVUQFJ9PNA
         B29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642823; x=1782247623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3bsbmxS4GadL4Z4bToRsBD+Gi0dvukUshOqKGVXCG8=;
        b=VFJiyM8Jjgp//yKt9qoAJjBhpaPGWEG5hZhrqPXPwFnVLC8mdIPLTXfHxmD6EICclR
         L/3CE4WlXNi+pZ74J8BqOGfstZKhO06TUwWmKHxZ+ggUasA4XPUofUlY9stfY04lcgtQ
         2zz1ZTciPxNUMVC/BC/B9jKdiUWvY9Ws3FcKbbBbyTzfmMCDooRZqqHu3Cd5Pavo+zbJ
         ZtR/i9P1oKD/2Y28lKHZZZRILKT+uwBCxf7+XXz3eNQp83Z1ex7GtP0EpMPSKKlUEPSk
         GqnYOttIAynWf0wHYxHFSrW8LWkkmz/usr+3M8WClPTaZJ7rNwbpVS1YfR8peXR0ctaD
         hGvg==
X-Forwarded-Encrypted: i=1; AFNElJ8jXsNkGB3AL0qjaos9pR3awB54sU6pyCZpKEphiRU0jdYZvMBSTU6KPVVi4m6iq0rwP7uuePU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtpiEM2eOkENIZaZcItfRJF0kMQONPNv43q2KSnerkLrXGz2KH
	+wemknlEX7y08vx10rmQP/NifwQ8PUCxX3aQp9KS+BD7t7Ib10DKo8QFqsn8xfZKvkw=
X-Gm-Gg: Acq92OG7jeaY28tPYTOk0hDgeMypt11mqBz8YuU/YqJ8ZD7PuR0raBtOTbQeQVkJ0uS
	O8CFmgXnGUjQODLUyJSuTLHh4yfSQVKHYxIjSfEDh8RsuSVOxI5xH8Q7YQ/y9Nr8r2EdNGoPUeD
	o6DRN5ilWVC3YIg590TFzWfDcaLTC/xF1wXHNLuEm/7M5Z5iEKBeiHkhEGokFUv4d8YIsx+7HNd
	OVQsXpkSc8agvq9tf9dT0fRCE9fy+qtSUh/S0mMOlT1O6BoINhXxGTvCb+tngQIGG41F5MdLpXl
	hxUQunmczCFUsTYjBAJ6v/D3l6dVMtrDAPoavNMzug/eqZJ0AmLd63XL4EYfEwhPlg17T4ybQXq
	WnoG9X12wzSUmkPDRJQnC4vwuj6GBN9mekd5ZiGJLkD9UPRWTXRwRWQudFESbUkk1j/au1d8vPl
	3G1YrQwyyjPgTju37yeaodiXOQnZlCse00P/q7YFMokVOzadIq1z7DylbUtg3r/BoLCoC+q5Tlx
	RZAHVn/Iw==
X-Received: by 2002:a05:6871:538a:b0:442:175:cea7 with SMTP id 586e51a60fabf-4469010a70amr626699fac.1.1781642823167;
        Tue, 16 Jun 2026 13:47:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-443090386basm2851306fac.17.2026.06.16.13.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:47:02 -0700 (PDT)
Message-ID: <910230d8-6a14-4d56-9520-169bd379f3d2@kernel.dk>
Date: Tue, 16 Jun 2026 14:47:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
To: Octavian Purdila <tavip@google.com>, netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
 kvm@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260613000953.467473-2-tavip@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299953-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS(0.00)[m:tavip@google.com,m:netdev@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:akpm@linux-foundation.org,m:avkrasnov@salutedevices.com,m:davem@davemloft.net,m:edumazet@google.com,m:eperezma@redhat.com,m:kuba@kernel.org,m:jasowang@redhat.com,m:kvm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:pabeni@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:mid,kernel.dk:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3F97695485

On 6/12/26 6:09 PM, Octavian Purdila wrote:
> Export iov_iter_restore so that it can be used by modules.
> 
> This is needed by the virtio vsock transport (which can be built as a
> module) to restore the msg_iter state when transmission fails.
> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  lib/iov_iter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af73..067e745f9ef53 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  		i->__iov -= state->nr_segs - i->nr_segs;
>  	i->nr_segs = state->nr_segs;
>  }
> +EXPORT_SYMBOL(iov_iter_restore);

I don't have a problem exporting this to modules, but any new export
should be _GPL. So please change it to that.

-- 
Jens Axboe

