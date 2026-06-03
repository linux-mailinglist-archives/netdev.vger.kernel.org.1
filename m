Return-Path: <netdev+bounces-294823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 29loEVFOIGrz0gAAu9opvQ
	(envelope-from <netdev+bounces-294823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:54:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7363639753
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:54:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=FC3uMuop;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294823-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294823-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C4793080D74
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B70B3C8723;
	Wed,  3 Jun 2026 15:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF03D75C5
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:47:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501652; cv=none; b=fEZ0m46w5wEEja00ovRwOihMPL3Oy2YCIcshNP2XYm81L94E+wTKv1q+/nsHCtgSpIkFHlXNEwdR2P4E4Gn2TTOX+QIeUXCHyGB84IfgFacfdHoTLaHxXR9bJYFld/UB1s7i7oYKS3TTCeWiKH5aisbtW6HEajMypGyjq81kpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501652; c=relaxed/simple;
	bh=i6wogL21CbsgPEm9Df8TIq0H5sBHUuDGOKcgdmKYPjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWmGjzS3lXgIAjZzRng+sZGcwk3s7UVUICvUXjXMCvBizgHw+di/lsDTAmAEdKM/ZPCD7yb7CN5GCetRcI46NSDCfEeTSX6EOlSBnWSqT1WyIi4k7xeqUQ+mcKtyQs9Jo3hagg2z+5CPxFtTfHv/tXEIuWsKbWFO6j0w0fKrrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FC3uMuop; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b8adf813so701725e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780501648; x=1781106448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QnTS72uQESQmGGPpF458k/vWeMpB7iWHvTRpj4KwHO8=;
        b=FC3uMuopjydP0ZtmtE88NELu3V0RTEbGyNo8f5bp6Oxul2e/5kZ2WddvIgNJv5yZ6j
         3ZfL0e3l82b9MoJT+1J8fapUtvD6LCqrkLA/+BeicaO8JZZcO3sTRkT5KOW0VjYmG2Ny
         jUgl5JwPQ94AgN66OL7s8vPc/JJUitcoJA8ZI356w7bVY4NC3dHBpeZhFOFObGVxJoDi
         QlDU0t0NesoIOi25DoV6wCnkF1YkfC72+63AqmM7hphpqL7cmrY5y8a5jPVBtKtZGEpu
         hsrKvpLgpEfiVAzEN7G3mEWHAC8eMMkvyG1Upv90QHbvZbCXZEFybf/0r5R+nANfoFlS
         Rf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501648; x=1781106448;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnTS72uQESQmGGPpF458k/vWeMpB7iWHvTRpj4KwHO8=;
        b=qDbFwi7MKkAfakeoOdVwDXYqoeL5IpmVkMCIzvCm0wlA2rQjjeeOLNNksezAfJH46K
         KSxKhIFWkqz1ym01m5V3+4JIO/fOhoZcOp3bphggZ+r8PThEpBruEmI5Z1G2zyqV+89N
         ZttjNpwhjAhkZ1e+PTIEAKGp5rJ1vedo+SaFPQpD6GehBozk7nBWLy08iF+0j+l5Lg3M
         5oTLf4b/f0HKOM61yunEIMHodovy0L4+CkIWkyQRArY4g0r0OFSrDTMNuxtdjSCC4W+j
         knus95tnBNd2T64k27c8gu4uDj8BLoOz6QUbWI/NtbrB6wz1cIYwCpopjLh5kZxS7SJo
         oF1A==
X-Forwarded-Encrypted: i=1; AFNElJ88i+H5pFFFahP4pI0sSpqGdUCh+vBHaNkHCD5zI7BNwB/8Kigx/7NNUQEsfc0VlIm5glTouFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSilTpjVXEs7AWwbYGAUdMaKXMvwQEKHXVIJyD+rt11iPiT/3
	aVKfdMrhzDCuyExOGV3IBYQYjyluIPxpV88UZwI5mGjbFgJbVEXRBhI+W3coUvgdGzU=
X-Gm-Gg: Acq92OFA1S47RZQHCy4e4hVgzJLPKmSkFekD0W25FERFuG2VYNTBjFx5M24VewJQyL7
	cmVRjngb4BqYzJ5GiVIRCRs5edBHZkzX/kumrajWJyqQVDPZ7ACcF2mw20i9aCw63jlYSAU66xZ
	znmlwa7s9R4k4hFZoSWk3+o599sATbFkVmzp2/IOvRDRvTuuNspSffnzXG83THvvb2Qq4IsyTO2
	98IkyAN5UsBXriHzp+EKlVQTFD0ACgPLYI/G7UzHTK9unwflmMtAVQH4+H0BPd958EPB87YXRef
	O0HlJRndzXkOWi67mixcP4kmfdD3Ah6iftdLTLCK/F96jEWvt8oEVcfYdGUapStIqS2RVrOVRwl
	Jq326L13CHCfMwjFT+H6WmkQXCdvxBIlTo2QpwXH3pmewQfpae9FNxaWcHm3wnwfWuN3sQRKaf/
	eh30SjKntM7OwZRVl1cKXEd8/OhBl1oyjJoEvpSaZGA9BaacEnY1N4wCO0/nuNWIgVJNIrHwokq
	VVZqge2BfRm0Ro=
X-Received: by 2002:a05:600c:3153:b0:490:bc36:9b2b with SMTP id 5b1f17b1804b1-490bc369c56mr883585e9.2.1780501647991;
        Wed, 03 Jun 2026 08:47:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc40716bsm499655e9.12.2026.06.03.08.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:47:27 -0700 (PDT)
Message-ID: <446021ea-94f1-4df7-8016-c8d98bd7e723@6wind.com>
Date: Wed, 3 Jun 2026 17:47:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
To: Ido Schimmel <idosch@nvidia.com>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: Stefano Brivio <sbrivio@redhat.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, Chris Adams <linux@cmadams.net>,
 Beniamino Galvani <bgalvani@redhat.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>,
 ihuguet@redhat.com, regressions@lists.linux.dev
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth> <ah57wxGjL7JBORR1@zatzit>
 <20260602132118.GA508395@shredder> <ah-SvHdPRrYXX6lx@zatzit>
 <20260603074717.GA569921@shredder>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260603074717.GA569921@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:david@gibson.dropbear.id.au,m:sbrivio@redhat.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,suse.de,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:mid,6wind.com:dkim,6wind.com:from_mime,6wind.com:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7363639753



Le 03/06/2026 à 09:47, Ido Schimmel a écrit :
> On Wed, Jun 03, 2026 at 12:34:36PM +1000, David Gibson wrote:
>> On Tue, Jun 02, 2026 at 04:21:18PM +0300, Ido Schimmel wrote:
>>> On Tue, Jun 02, 2026 at 04:44:19PM +1000, David Gibson wrote:

[snip]

>>>> 2) Could we re-use NLM_F_APPEND?
>>>>
>>>> The short description of this existing flag in linux/uapi/netlink.h is
>>>> "Add to end of list" which sounds like the right thing.  Looking
>>>> closer, however, it seems like what is' used for so far is things
>>>> where the entity added with the NEW<whatever> operation is itself a
>>>> list, and NLM_F_APPEND causes it to be added to rather than replaced.
>>>> It's not used for addresses at present, AFAICT the list of addresses
>>>> is a semantic level above the address entity itself.
>>>>
>>>> So maybe re-using it for the thing I tentatively called
>>>> NLM_F_INSERT_LAST would be confusing?
>>>>
>>>> On the other hand, it's not used for addresses at the moment, so
>>>> AFAICT there's nothing actually preventing us reusing it for this
>>>> purpose. That would save a bit - we only have 2 general and 4 NEW
>>>> specific bits left, by the looks of it.
>>>
>>> This is not really viable. Even if the kernel is not using NLM_F_APPEND
>>> for RTM_NEWADDR, but not rejecting its presence either, then we can
>>> create a change in behavior for a user space that is currently setting
>>> it (intentionally or not).
>>>
>>> Example:
>>>
>>> https://lore.kernel.org/netdev/27c249d80c346a258cfbf32f1d131ad4fe64e77c.camel@debian.org/
>>
>> Hmm.  So, in this example case we have a known, widely deployed
>> userspace that was broken by the change.  Similarly with the
>> original now-reverted "fix" for the ordering, we have a known, widely
>> deployed userspace that was broken.
> 
> It was also reported over three years after the kernel change went in.
> Point is that we have no way of knowing how user space is using these
> flags. Suddenly giving them meaning when we simply ignored them before
> is risky.
+1

