Return-Path: <netdev+bounces-304954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b31aNX+JS2otVAEAu9opvQ
	(envelope-from <netdev+bounces-304954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:54:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7CD70F84F
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:54:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=O3QhpEaR;
	dkim=pass header.d=redhat.com header.s=google header.b=lrzOGxgv;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304954-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304954-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC6523938506
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0431A2C25;
	Mon,  6 Jul 2026 10:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9B23395F
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 10:02:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332168; cv=none; b=dWh+9HdzzXdb7y9+hkCunJO1AxGPVPFTqNf4r8Ba1X6mjrSYMKyGETB9P0GF353h2wPz6SlioannWsVC9gdx3aDbeGfFcfY7l7TNdylsDoK/1Dnhnuuid71dC/foZyu0dEaIpBhBYVNZife4WO9XiCz/5iRItxBPhMEjyeuZKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332168; c=relaxed/simple;
	bh=xkUq6E0frsaInzwoabXWgqX0hcjL28UQaT3wfF2LHw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sic97xVyBlGsT44dzedO6YeqM0s4JMZ6cpI6QCyBgPJuuk/37zjUj9AfRauJJF+FgJzx9oiuYqgupywqZ4ddTYMsILY8yw5PIqktZDbsxpXtp3doHDRdfON/Q6f4yJlAXc7KLsESjemqVxBXF6uLKHrVwmptsJzRxqLxVCi54M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3QhpEaR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lrzOGxgv; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783332166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Prx3YP/QlyufoElU3hXt9XT8NpX+Helw1UMh1Uu4rUg=;
	b=O3QhpEaRdSZMOjmJHyCKBWK/bq8YcePg5BfIs4+IiwA8zKdGNNvHrTI5PDQ9ZaQ8kLhH5P
	tampmelPw1T5oRw/yoN/QQyQafnvBT0yPk2iZuDXavUjyvvnIdbfbw3EZmnUbWEp7lC+6O
	nzrYIKytkTz2rv10FVXwplvkvRFj9Us=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-U-Y-0ez6P4WmT8A_bPqFQw-1; Mon, 06 Jul 2026 06:02:44 -0400
X-MC-Unique: U-Y-0ez6P4WmT8A_bPqFQw-1
X-Mimecast-MFC-AGG-ID: U-Y-0ez6P4WmT8A_bPqFQw_1783332163
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493caa3c54eso24514255e9.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783332163; x=1783936963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Prx3YP/QlyufoElU3hXt9XT8NpX+Helw1UMh1Uu4rUg=;
        b=lrzOGxgvCG/rEcJwNGOL9KvQHUmWj+lx7baGLHA/LxQjQAubzAgwOkHY5ytJIdyOKm
         KAjsBQz2IGGbiCrcEEoAaTVkv4fGicYnTUGVeW+vfkBJfSe0p3NOq7qtzFH5H8aUA/Yb
         Htt+xn18JNLrSV0EHm8i6cDNnOKzkhrtV8mLnxWrfuddVDsHmgXVoyLHj7Z4poM2ZJqf
         p53zPIpJVvJrfOP0gVpdwZcIvVEtOscHrHmfFopAZPAImaa96LBffOxQedvHCEs8qqgX
         TZyqnr4uqx6qG0piF+vVhue3W3ZV9zCz+fu0dYY6rDX9IXfTmLubWbS596gsCl/Lqo3l
         PBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332163; x=1783936963;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Prx3YP/QlyufoElU3hXt9XT8NpX+Helw1UMh1Uu4rUg=;
        b=gQEP4avqWXDWLguvqL966APm2XTYITwRhWG1BxiG4JwDGVvQIwI1QQ3gNPO0EcS1pD
         N5EO36KrEfJPqmM5M5Nb32xNQWye/u0EjDMqsh18QJYXPFYPWcTB43It3Yk1HATGYoJ9
         7N825969+sz0P/66uKv4LkHKPd1ndLDDcigwbVt2DEu6yzEz+bybBlK7y+i8p/PYVOjX
         HWOJSwpulmVJzmrs5sxGVmfpuCC/tM5cJwioLA4q0OUY8cSCjN/arVdS575E9fUnDN/E
         1VUERIK82mNTvptrCO9fcLjUjT3VLUbCrWG8njqM16yz6c3N8jdmyLPbV3v4MKGkgGBq
         YUsg==
X-Forwarded-Encrypted: i=1; AHgh+RrGQzucvDA88L1YjJDDMrIY492bG/koabSa5mPsUwN0tqFUpMWr1dmbdrt9HAZLR+WBdPDPqAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5o65LLED7M9r95QkkM3r91TzuzV+IxSoyTmbTNk3pMJYz2MoC
	Ttff/l3+yfPmS0rE9MQ6XbBpA1IsZst+xxNNFa3yAB6E68H1OyDpg0dYsELoUUX+YHuoGpH+GW3
	MTDmKmW9pUG7kcGFDEkFG8GGf9KGc+ZT3otFOBV6+d+WxhRJR7O/ADwnezQ==
X-Gm-Gg: AfdE7cmH2jF7xMgwlvfUvxfB5p2vbNS815/q8tnO+HBPEBi8XliyWMA7Il2/y9X5Xgb
	5TgZa/rSuPGWTkWUWxWd37kMNPE2UvXPjarECG3oOaf9N3hGvR0fiyXKZUNCxFpS8Rg3Zy53Ge/
	kDeqHWg7ggbgigsCI0irNOxgsG2059JpZ+/MiR/BeixMQ4ZAB8sWEp4knvWg+Hx4JeNdxJO5vgN
	VgvEslCkomlrMXcVQ/ZobNgPSKEfBhdd3baomt6WSSm8x5nMR99e1NpK9lFxtxADRaJiajziPxb
	J7skbmVEYX+aDZnMgXNEPxavBSWMwZpHOe6AHyRs7PHfuqpoevcSEKVUpZJ9goEQCcbRgJSAE+q
	4w+ic4s3xCiCkkYHW+ZRXrOlQVRqo/eDRP0xIhWLP2x3skodnyvF2XTLHt6KFKkanNqCej+kU0b
	C0BLMBGzVwVwPE
X-Received: by 2002:a05:600c:46d1:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-493d11f7cdbmr108910135e9.29.1783332163419;
        Mon, 06 Jul 2026 03:02:43 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-493d11f7cdbmr108909625e9.29.1783332162933;
        Mon, 06 Jul 2026 03:02:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63ba971sm595864885e9.13.2026.07.06.03.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:02:41 -0700 (PDT)
Message-ID: <4730638c-9382-4689-a1e0-d6a50bc66c32@redhat.com>
Date: Mon, 6 Jul 2026 12:02:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] qede: fix off-by-one in BD ring consumption on
 build_skb failure
To: Shigeru Yoshida <syoshida@redhat.com>,
 Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matvey Kovalev <matvey.kovalev@ispras.ru>,
 Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260630164623.3152625-1-syoshida@redhat.com>
 <CAAvyFNhY2Jp5aH6YPrtfc0mBpwuSeT-8u8bODqq=pootpQffmw@mail.gmail.com>
 <CAAvyFNjLcVRQBuMsd31neQpo6BY4HBP-hNMHh=RtFeiWBo96ZA@mail.gmail.com>
 <875x2te8l3.fsf@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <875x2te8l3.fsf@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-304954-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:syoshida@redhat.com,m:jamie.bainbridge@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:matvey.kovalev@ispras.ru,m:Pavel.Zhigulin@kaspersky.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jamiebainbridge@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D7CD70F84F

On 7/5/26 5:53 PM, Shigeru Yoshida wrote:
> Jamie Bainbridge <jamie.bainbridge@gmail.com> writes:
> 
>> On Fri, 3 Jul 2026 at 09:52, Jamie Bainbridge
>> <jamie.bainbridge@gmail.com> wrote:
>>>
>>> On Wed, 1 Jul 2026 at 02:47, Shigeru Yoshida <syoshida@redhat.com> wrote:
>>>>
>>>> qede_rx_build_skb() and qede_tpa_rx_build_skb() do not check for a
>>>> NULL return from qede_build_skb(). When it returns NULL under memory
>>>> pressure, the functions still consume a BD from the ring before
>>>> returning NULL. The callers then recycle additional BDs, resulting in
>>>> one extra BD being consumed (off-by-one). This desynchronizes the BD
>>>> ring, which can corrupt DMA page reference counts and lead to SLUB
>>>> freelist corruption.
>>>
>>> Good catch.
>>>
>>> Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
>>
>> Sorry for the double mail.
>>
>> I believe the Fixes: should be against the problematic original code:
>>
>> Fixes: 8a8633978b842 ("qede: Add build_skb() support.")
>>
>> because that is what you are fixing.
> 
> Thank you for your review.
> 
> The problematic code was introduced in commit 8a8633978b84 ("qede: Add
> build_skb() support."), so putting this in the Fixes tag would be
> correct.
> 
> I'll send the v2 patch with the modified Fixes tag.

No need for a v2: I'll update the fixes tag while applying the patch.
The PW is already quite significant and I think it's currently better to
avoid repost if possible.

Thanks!

Paolo


