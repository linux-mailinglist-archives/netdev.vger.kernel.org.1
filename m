Return-Path: <netdev+bounces-282051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NaywKsIC8WmgbwEAu9opvQ
	(envelope-from <netdev+bounces-282051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:56:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0F48AE70
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F296B300DE13
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6A32939C;
	Tue, 28 Apr 2026 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw00sgar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D21DB551
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402493; cv=none; b=UINrZ6+dUwLdUdx46LMocePXUchjVX27/wq9OKPC3rfeDYDyeM94OzrvSfdJljYYtsuFjTjGYHS+r2Q9nq/fhXawdIva4DcbhL3mtocLeyT9KVkTphEv7R2aMoyBC5U/t74tdT2nMf6RFFDwjr5IFv8I8xtGiQpAPEezQrltx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402493; c=relaxed/simple;
	bh=kY6weZtPmLXKIlpCWJmdY//kQQkChIPvVjk1GsCc5ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpNOkU4Pq5nN+X1Gamy92NyP9JKm92hiY07cd9NeAtUgSvVz6L8StjjeECXSaMu6KcR/q689F1OgKoqmzYi58l9eEzGDn6ZnBGqWeDsJoLh3G4RhtZzwuUAuN2njHP27ClhqIExOuAoQQ168qQiEwnP/YD3bd2xv0YbJvlISUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw00sgar; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso166090305e9.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777402490; x=1778007290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8GtQWzkgfdJFAZ9yR9PSi0GHYtSw+aReGuyyBvgSD8=;
        b=Xw00sgarVN0xfkci67UwjolC2IiI4DoP+B0+l7NDxDQ/RLkfeY5NbKtf5Mv+ziNAcz
         yyz0lZNU4e3RhzQI2dQOWM/OZAZuOVVdJPYJKiV85RpVfokdAA2gcaY29PgZMDTEmqy1
         UFa9KO0jfssPsy+bBhfQ95cdc5egiOBMM9jEAhoJg1Y0I+u1Mm+JBIh3MEXG9bF6Tm1q
         ALPWTs35gqZvkGaqxHnH/heByRgSOMwNuE1nNr2PN4lcjhFXElu3rl8d/pm4FKkAkoK5
         kJ7ztRDSrhFg0/buwGiUufyv3NEPZGdJo5NixQkw3xgK8yX5wur7lh48Bv/ehkZLDnpw
         p5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777402490; x=1778007290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8GtQWzkgfdJFAZ9yR9PSi0GHYtSw+aReGuyyBvgSD8=;
        b=kmVPPBsOTs2RI+dOcKPZrlKhAqW7wJ4m0VZ9YPPSFB7fASu9pS0NTvUamVrkZLWCtN
         a7wO0I7lkEk063ifr2Akq2/7lDelVPYc0tWyOg5brjz5YBswbTzhxYAug4jPq8RRv7IT
         7pGl3In0Mk3GV/42bngGk6cQm+p98FY5ciWR+LH0dyS3ROzelsJ607zDie5wwBXdLCgi
         SOdFsG5vbL7QQOuEjomgTuCr1oWOb7CprBSs3XxqKf3Ng7HUL2bnlCmNbapaes7jN+AD
         0kdJCB/DcfTx4q6/ImOAC6p+RxGehXPSNh2YWk96XuKQ1Hdjg/RgRSLcV1VT44j9xzpu
         /JSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8G6mAjDpOdMUb+7iTrnzUpZpiDQCfoSv3seS4AqTZANI6dqmb8fR9RQFhWaXLb+uxgi67Ad3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIK/iemlOVIeQNYxNpfTn3k4KUyC9Un6CbFrKg4Dq1Ar7QY8JF
	1uK6skqEpyceym3JxRIO9Od6TJpMw5gc3qTr3UdxvFyUSc9P9MxOy/wC
X-Gm-Gg: AeBDieseqalz/83LQ8gy+LAVIFypE//5le4qQcufAfJDNCE8e2LmNQwsKb7whuqXV0A
	u6XKn1Ar1luepicPcLAXNLtFtIO7ypwS9HUyNeh/VrZ+YakXAyAWN4u6FL4i6wZNcz+bmwI+ZSN
	JzRp4pmDh3R360xzRCN37FtO7YJrP55FRl9OBDupFvBd2n8Wpuhs2jZV1po+ySdDOzYe9s01AOQ
	swyloJc0rOvrhZf1igWfFGFCjoTWO3Q14t5YmsB4wlIAlbiGbY+eIVhLPFGQ2ryCy6N8S113mAv
	ibtOy8Xqt94F0nhDMdvsF+uaNEuDRy+ranvx7JKftcOm8eCZgCh3x8UrSNmPtXIXFQL//rACwE1
	L4cqrZgDgV7js5e0KYsKUskALsb1hSPVgywNkfQzJRIsgIx6AJQu6WvNDxYHyX9f50Q9v9Ngt6r
	k8MFx2O1IQLVPrpUX7OUSvvMyIvQgOgBvip3dfypZjmHpv5UY7YbMzcrpKB3W5mRF0bYhFgRJH6
	dXAsYPyTP/BJcwU
X-Received: by 2002:a05:600c:138b:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-48a7b5488ffmr13845835e9.28.1777402489754;
        Tue, 28 Apr 2026 11:54:49 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:2419:61a4:ae0d:bc43? ([2a02:a03f:a75e:9a00:2419:61a4:ae0d:bc43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7beb1581sm3660975e9.15.2026.04.28.11.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 11:54:49 -0700 (PDT)
Message-ID: <61387501-77a7-49b8-8124-7fca5168901c@gmail.com>
Date: Tue, 28 Apr 2026 20:54:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260428153749.785611-1-daniel@iogearbox.net>
 <4497a340-b48e-4615-81eb-90ebc7a0b5d2@gmail.com>
 <34f6054f-5d5d-47c8-b06d-f7b40d74c3f0@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <34f6054f-5d5d-47c8-b06d-f7b40d74c3f0@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31A0F48AE70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282051-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]

On 4/28/26 20:16, Daniel Borkmann wrote:
> On 4/28/26 7:58 PM, Justin Iurman wrote:
>> On 4/28/26 17:37, Daniel Borkmann wrote:
>>> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
>>> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
>>> find a non-extension-header protocol or run out of packet data. The
>>> loops have no iteration counter, relying solely on the packet length
>>> to bound them. For a crafted packet with 8-byte extension headers
>>> filling a 64KB jumbogram, this means a worst case of up to ~8k
>>> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
>>> for example, is used where it parses the inner quoted packet inside
>>> an incoming ICMPv6 error:
>>>
>>>    - icmpv6_rcv
>>>      - checksum validation
>>>      - case ICMPV6_DEST_UNREACH
>>>        - icmpv6_notify
>>>          - pskb_may_pull()       <- pull inner IPv6 header
>>>          - ipv6_skip_exthdr()    <- iterates here
>>>          - pskb_may_pull()
>>>          - ipprot->err_handler() <- sk lookup
>>>
>>> The per-iteration cost of ipv6_skip_exthdr itself is generally
>>> light, but skb_header_pointer becomes more costly on reassembled
>>> packets: the first ~1232 bytes of the inner packet are in the skb's
>>> linear area, but the remaining ~63KB are in the frag_list where
>>> skb_copy_bits is needed to read data.
>>>
>>> Initially, the idea was to add a configurable limit via a new
>>> sysctl knob with default 8, in line with knobs from commit
>>> 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination
>>> options"), but two reasons eventually argued against it:
>>>
>>> - It adds to UAPI that needs to be maintained forever, and
>>>    upcoming work is restricting extension header ordering anyway,
>>>    leaving little reason for another sysctl knob
>>> - exthdrs_core.c is always built-in even when CONFIG_IPV6=n,
>>>    where struct net has no .ipv6 member, so the read site would
>>>    need an ifdef'd fallback to a constant anyway
>>>
>>> Therefore, just use a constant (IP6_MAX_EXT_HDRS_CNT). All four
>>> extension header walking functions are now bound by this limit.
>>>
>>> Note that the check in ip6_protocol_deliver_rcu() happens right
>>> before the goto resubmit, such that we don't have to have a test
>>> for ipv6_ext_hdr() in the fast-path.
>>>
>>> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
>>> IPv6 extension headers ordering and occurrence. The latter also
>>> discusses security implications. As per RFC8200 section 4.1, the
>>> occurrence rules for extension headers provide a practical upper
>>> bound which is 8. In order to be conservative, let's define
>>> IP6_MAX_EXT_HDRS_CNT as 4x that to leave enough room for quirky
>>> setups. In the unlikely event that this is still not enough, then
>>> we might need to reconsider a sysctl.
>>>
>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>
>> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
>>
>> FWIW, I prefer v4 over v3. I didn't like the idea of a new sysctl for 
>> several reasons I already mentioned. So, thanks for this new version, 
>> Daniel.
>>
>> However, I can't help but think 8 would pose absolutely no problem. I 
>> would be very surprised to see someone complain. We're choosing 32 
>> over 8 to be extra safe, at the price of security. RFC8200 provides 
>> the following ordered list which is recommended for senders (without 
>> normative language, though, which was a mistake):
>>
>>        Hop-by-Hop Options header
>>        Destination Options header
>>        Routing header
>>        Fragment header
>>        Authentication header
>>        Encapsulating Security Payload header
>>        Destination Options header
>>
>> So this is the maximum you can have theoretically***, although you 
>> wouldn't for instance use the Authentication header with ESP. I'm not 
>> even talking about ordering or specific number of occurrences here, 
>> just the total number of Extension Headers in a packet (as your patch 
>> does). It's also worth mentioning that it's highly unlikely to see 
>> someone use them all at the same time (in production, of course). This 
>> is why I still think that 8 is safe too, and would provide security as 
>> expected.
> 
> What do you think if we fix this at 12 then to also have the exotic cases
> below covered just in case to be conservative? Would still be an 
> improvement
> over 32 fwiw. I'm also fine if you think straight to 8 is the better 
> choice.
> Either option I can spin a v5, np.

I'm fine either way. IMO, 12 seems like a good compromise to keep 
everyone happy.

