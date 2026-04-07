Return-Path: <netdev+bounces-275952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFfqAVbl1GluygcAu9opvQ
	(envelope-from <netdev+bounces-275952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:07:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BCB3AD7B4
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855FF3013D65
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89C53A6EFD;
	Tue,  7 Apr 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIwCV8wQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rZcB61Kc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE539FCDB
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559924; cv=none; b=OEWNF+FFtO2RtHKiPI0oAnamX2CgYlH3MzCAv5JR582N4s1WcIWnCIyWfdhlzKK5VBg6JmvAd4gjabw0v4jVhC4cVjgurHDs9Q4wx0MZk8mYoiULOV8BXgrXWQb1bG4uMpaGuUVgsVENar8Rxt1nkCNFv2vnxHWWD7YeGN7u5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559924; c=relaxed/simple;
	bh=AASHIeM6Gd/EK8pPUVGREs94mOWAxENDbLt05y2wNeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsTMLUypDYWg5Cb8pJcp3aTRdIkLy2Wm2ofNQpFyQmjLPYTAXdgqxfpaYK8G6xkdmlrEjT5HlCnz2Mq4o/IAA08SXZ6+vDN/YZPzv8O7yfopvB0/DvDlGHJdK5h2/mk2+F8qOdCm/KfFYCRpJAMXDHwPdFp8Bp6f/yFzHxDNn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIwCV8wQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rZcB61Kc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775559922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbK7CgYMpXwezHmMj9q3jIIWcerGUMg8y8tq/mmBKaU=;
	b=eIwCV8wQbO7XXAOzetcW3/z0oCvl8Mo3G6fvtgvHWd4elWtleO6aSzodAHlL4BUX+FeqxM
	3pmTad4O5mUAyjiBkr6b3tTfEsH5Um23y/purXaftoQdbv1TQs/bo62iZQ6Ad70dlwt/q4
	gQ4/0Qp1+3mgnjcJnmbL1LA3O2eb4iY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-qf-0m_8eMNaqrxeX5zuRuw-1; Tue, 07 Apr 2026 07:05:21 -0400
X-MC-Unique: qf-0m_8eMNaqrxeX5zuRuw-1
X-Mimecast-MFC-AGG-ID: qf-0m_8eMNaqrxeX5zuRuw_1775559920
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0120047so2665305e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775559919; x=1776164719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbK7CgYMpXwezHmMj9q3jIIWcerGUMg8y8tq/mmBKaU=;
        b=rZcB61Kc8NPGgYbMzb/JYMGXuNdvI5f5gUsLxbyal5GzR7v165QukGPFpNhy0ofZ1E
         XDx+krKgaeJKQXA/e4Xf5jHfnabAs4abVfIi3+jtvO7sqmMKUSmIIeCDIK3QPLDVvYyT
         pIaf7RK2m+m83coHckxLAGV22SSJ2XVKw8+gWS29ikT5+XRR9gNZPZ3nmSZj4qLu2v99
         xoHGXI3podZuvwWKPOIzVurcOMnxeyTZfccZAV3Q0nNxYde7lo967WpRetGZQoDbC3jA
         zO7N52JlG2tuol+Fnk1Kw6V+Bq5jeUUdYEoeRMgaJQUZCUmlcPA/fO+S+gjCniyd6TwY
         XHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775559919; x=1776164719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbK7CgYMpXwezHmMj9q3jIIWcerGUMg8y8tq/mmBKaU=;
        b=W5HJ36DFs4yVRFOgMU1EOePH7tr5YtTjOqjrHFX7w7pQXTuCAB8IrlS7HunYgbC+hu
         l1crDRghWUwOzcqrzIK2/UQ5FXshJUgL62kJpjgfDECn1r6zOcW+kIDW80o3aXSbel4q
         PRFxEbbBaCcxVCmbcV2LwqZbYt2Czuizi+NKoC+phVIXwPTjrlGGAUOIap49XqBMFi3e
         qQ4bcOeZ6J4KgemM/R4RuPzCN1hk93xLHXYZ5+ZyZloqu+7leKhgT5zSIoCPnHHJDjFt
         WI7ARQvogO3AJjkBWfoZebcmAQF1RKZ89Q+9nXZTbu9ugqIkq5clxa1YH0Bkfxl2QP5H
         YmbA==
X-Forwarded-Encrypted: i=1; AJvYcCWjZet1GagwmQ+h38AqRJ9R0lwzmvD+Ddtt0v3c0yUvVTg4iM+mLZkmME5pxJMjCgc1IeZw6ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DwtX/Ft4xvz8u5492joHBfbBnKgI9p+lSLO+Kc93FHHl2Z4Y
	ffU4uZS1HOUDSjs2heyxEsmNlqWkqcNh91tmn+NCiBiu6yU2+x79kKm3ltdbXTE8mxuJI8eGvus
	/cQIhlR2D154sHMrN//ZHb/fzDzhd/P1covpLg0nEW92MLdDlGB730W9tvA==
X-Gm-Gg: AeBDievg9FVn8nrdbm2YPJrugyNEk2CKsCl+aJM5pr80QCWJApho8T6a60YwjTykYue
	myKAGzlvL7xnfGGDo7cvvYp9vE2v5R5Q7/KYeLcXyjADp8RHM1GbEO2YsXKQnTxEluDyJV4fhyG
	TncZS2B2NYaDL0WKQ/kLGVUAmfbeJR6zB8nQoLBRvNA2vIt9QiMx64eQrDwGG6/w+wSLj5VDwO1
	J24wf6uSpG9ihI5TE1hdYGh0EZ+J8AzPoAEbK6oX/g9ZmCRV+lwRVLy0j0oFp7tZc8XB3qkajAV
	bSANsG+X/0ADlFu0Ebj9yYA03QVzpnuwYY7iy1+dg2DON6Qg1MAaRzRs8z9K495N5AfCRW4XqFj
	ZnkJXe1WMtZ+2ZdzPzm4Gd5miUHbU772G9pl8RO2PreiTvVd81bl6jES0FA==
X-Received: by 2002:a05:600c:8207:b0:488:c282:e77e with SMTP id 5b1f17b1804b1-488c282e7ecmr4113895e9.28.1775559919417;
        Tue, 07 Apr 2026 04:05:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8207:b0:488:c282:e77e with SMTP id 5b1f17b1804b1-488c282e7ecmr4113325e9.28.1775559918924;
        Tue, 07 Apr 2026 04:05:18 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1b19esm165793205e9.6.2026.04.07.04.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:05:18 -0700 (PDT)
Message-ID: <5428a986-98f0-425d-858d-5ef766992d0e@redhat.com>
Date: Tue, 7 Apr 2026 13:05:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] pppoe: drop PFC frames
To: qingfang.deng@linux.dev, Simon Horman <horms@kernel.org>
Cc: linux-ppp@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 Jaco Kroon <jaco@uls.co.za>, James Carlson <carlsonj@workingcode.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Guillaume Nault <gnault@redhat.com>
References: <20260403083926.68320-1-qingfang.deng@linux.dev>
 <20260406144828.GH395680@kernel.org>
 <e3ada3f0bb0c389d592657b37c462944e633a0d6@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e3ada3f0bb0c389d592657b37c462944e633a0d6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275952-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 57BCB3AD7B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 5:19 AM, qingfang.deng@linux.dev wrote:
> April 6, 2026 at 10:48 PM, Simon Horman wrote:
>> I think it would be best to add/use a #define rather than
>> open coding the magic value 0x01. And perhaps expanding
>> the comment to note that skb->data[0] is the first byte
>> of the PPP protocol would be nice too.
> 
> The field does not have a canonical name. As per RFC1661, the LSB of the 
> first octet is used to test if the protocol field is compressed, and the 
> same code snippet is used in ppp_generic.c.
> 
> I could instead add a helper function:
> 
> static inline bool ppp_skb_is_compressed_proto(const struct sk_buff *skb)
> {
> 	return skb->data[0] & 0x01;
> }
> 
> What do you think?

The helper LGTM, and could be re-used in ppp_generic.c, too.

/P


