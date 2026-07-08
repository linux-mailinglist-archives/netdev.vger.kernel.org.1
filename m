Return-Path: <netdev+bounces-305725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aBeeMIAfTmqcDgIAu9opvQ
	(envelope-from <netdev+bounces-305725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:59:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1708B723F3B
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:59:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HptC63VL;
	dkim=pass header.d=redhat.com header.s=google header.b=LAhN7SFy;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305725-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305725-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43BCA30265BF
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3B371885;
	Wed,  8 Jul 2026 09:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AB341AC7
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 09:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504694; cv=none; b=Fds6pFrDwtbDtJ0x5dQNNGvXa+w7Kl3yjOMeDuGdAc4gpAYLnO/X1I6ZNLqWc848AH+fIqf/fhiiI0/3Gd+fqV1hsyoorizjEAQnVne+3BgwAA40PL9m+hIs+EJ0/Hdv6wOJiN3fn1UQ4ggpsn/2/mDmyZyYpW17ACkijSWI9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504694; c=relaxed/simple;
	bh=ZPZ8Ghpofvj3SxI2tuKyXiYtS79lSc4K8bhJ3ppreTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufDSlVbIsvuVWwpEmrT2TXz5a+LcKUMOHC06Nd/sVNRcDKuoJYYlUaCCWUoW0NsJMtMABTGna04Dw6n8BW3xcpYoD2TUS5pxk7vwLqkWvuXZYIy+9RZM3FHVgdmkMdbz/7FqEI6qbnLXVzaZy3wUBVEt/WapKL3fqGC+8aW6DBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HptC63VL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAhN7SFy; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783504692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZPaMybjeMNKNpD8AtX/8HSMSCIwjQpAmfLjC6sDrjw=;
	b=HptC63VLBmON6gB8DF7tfthve4rMu6392jSxWg4VPEkAsNgiTj8floUCCtqgw/f48J5MUK
	73ZxaxDzTw7Q5FA+KlEIse8Uq92ByGnNJzTzO0vEBOVvMIX03NhwrsQL/QncvrCouJXeaN
	8Tc+0ExB6e7iHu+CLex1hyfgrWZz8NY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-OPDPZFCxML2alUfR7nbb1Q-1; Wed, 08 Jul 2026 05:58:11 -0400
X-MC-Unique: OPDPZFCxML2alUfR7nbb1Q-1
X-Mimecast-MFC-AGG-ID: OPDPZFCxML2alUfR7nbb1Q_1783504690
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bdaf8549so4781445e9.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783504690; x=1784109490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZPaMybjeMNKNpD8AtX/8HSMSCIwjQpAmfLjC6sDrjw=;
        b=LAhN7SFyMNxgdC3eCNsZJ7NpwILQH0VQ7ps9BlsMbNl6xyYsdYyzFSy0Ks02AH0GHM
         p3yJ0yAhwKENfKrljwmppPUb6so8K3v28GXtIN40ZPu0Ng7QosIqkN5dkKWI9y+xrsNt
         u3KB0K1GTQVyjIFt7J8neEdh8hPWENDJQ/s74WI+cF6DIY37X61Tv/n1KV9OxnewjYr4
         u8v63Lcbo6etOIpsWymXhhYfEvh+LKYp7qzghPkxXcVeb56l40bPXPpmkwwZun/8SPcV
         qcQ3q4cMglE+rytPdjxAjOi0/a9ytzB22pddRqiMeRqnhrPO1lzufCm7F9Twf1BQLd0X
         q59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783504690; x=1784109490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZPaMybjeMNKNpD8AtX/8HSMSCIwjQpAmfLjC6sDrjw=;
        b=tJtFZYA0QAcPz0O9V6CcUTCj6FMGXqNNmyyXLAZwQxtarHg6oHvtP9GQS/IuNNiVQY
         /1h54ppdJu/9+YIXpyoY8SOU8IOxBobO+xaXPWscFdRHQcO59fBEQkK+NUeE4m6Gjnpg
         Gk6keNBCpdrdAwddIrFzfk42Zm+gQMtP+QFtKZkpF3NM/iRm2bfIU+jnplZyOJaNSdGp
         9tXaHG+cSUOQlA9v/Z/Qc/2L/mPCg12nD1HBrL77kswoGvRqHv67YAi7WZt0bH7tMRM8
         u69f3aA5HkBlwO2BKohDl+K3TrQ0EK7e47kep6qIV5GXe1ynvQzP9neDuKv9/z3p9gGC
         bm3w==
X-Forwarded-Encrypted: i=1; AHgh+Ro0vQewKJiPCsxnap6t/xiGlzEtOi8KOan91SgGuYXEEHPEjcqNqAWkwLx/I3a1ooNxLYuHbc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedA1w+HNA0W9SxYe2hP1oEnzU9lmY6Tb7ZzJ2SHWLRspzdaUy
	hs/ZjBRTjbYzs8esjSUvRRbAvdbpjxGoUsrhTbgI2FWQ5r1L5T3ULRZTpwD4RSPjdR1/UDEUAfK
	/z9H9m9GoWqONKT9B4jUFqej0Z1jc2AwRdgqaVzUAwtgp6entpbvo+NfvmQ==
X-Gm-Gg: AfdE7clZUONvrH5Ttv/1EgPsZxuQTQXlaaqj5c2Xh/Ol0fexAACLpJ/oTnFLsp/Z5lg
	VgoXhFtukwKb6gh6T/924/5bdizYBNF0oQrZ3d4OA+XG7CuxUxzm4534AmMLRSSWnANpCpXwqDX
	FlTlGxh78gBtlnvhjKTzQmq+WQaXtI6wXFF0QH+mnRnR07sEd4xZ1PeJh6OnZBEXkt1q5WlmLlY
	gn8mlb5g/EV+8eBqQMDRD0M7tpMajgalF5HAJ7CLD3LlhiTY8mwadSQOxGmSJrL5eBvEvnEGv/D
	gkefVf2EqgB42ZEPHR+D3dfSig6RmCW91u4oUMqqjq0w7fxK3BhL1F779KhbP3CGxufw5rRDbMV
	x5ll54WjyuSlks4+uen/k1EBv4ShGgPavlaWBZ/40c+Lvh9YSGquvey4dLCRXb4+oggxEm1BcXR
	Xuj4UslTwA6fSe
X-Received: by 2002:a05:600c:3e11:b0:493:df1d:7488 with SMTP id 5b1f17b1804b1-493e6904b5dmr20334495e9.16.1783504689796;
        Wed, 08 Jul 2026 02:58:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3e11:b0:493:df1d:7488 with SMTP id 5b1f17b1804b1-493e6904b5dmr20334145e9.16.1783504689342;
        Wed, 08 Jul 2026 02:58:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fccf2dsm135091445e9.15.2026.07.08.02.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 02:58:08 -0700 (PDT)
Message-ID: <e981a64f-ec3f-45d6-b20f-e03b61a91f2b@redhat.com>
Date: Wed, 8 Jul 2026 11:58:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] VEGA: a syzbot-like workflow for LLM-found kernel bugs
To: Yuan Tan <yuantan098@gmail.com>, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
Cc: jhs@mojatatu.com, gregkh@linuxfoundation.org, sven@narfation.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20260708092247.4188498-1-yuantan098@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260708092247.4188498-1-yuantan098@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuantan098@gmail.com,m:linux-kernel@vger.kernel.org,m:workflows@vger.kernel.org,m:jhs@mojatatu.com,m:gregkh@linuxfoundation.org,m:sven@narfation.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1708B723F3B

Hi,

On 7/8/26 11:22 AM, Yuan Tan wrote:
> The rough idea
> ==============
> 
> VEGA would have a public dashboard, similar to syzbot, and would
> send selected bug reports to the relevant kernel mailing lists.
> 
> The goal is to send reports that contain enough information for maintainers
> or other developers to pick up, understand, reproduce and fix the issue.
> 
> For each public report, we expect to include:
> 
>   - a description of the bug
>   - the tested kernel tree and commit
>   - the kernel config and environment
>   - the crash log
>   - a minimized user-space reproducer
>   - the suspected introducing commit
>   - a suggested fix patch
> 
> The suggested fix patch is meant to reduce maintainer burden. It still need
> human review, but hopefully it can save a lot time from building a patch
> from scratch.

Thanks for sharing. This sounds very interesting to me, modulo final
impact on the ML - overall load is severely increased since the LLM era,
while the maintainers pool not so much.

A few notes on top of my head:
- the amount/rate of reports is critical. The higher the rate, the
better need to be the reproducer and the suggested patch.
- the crash log should include the decoded stack trace.
- IIRC syzbot reports sharing is [always] human
moderated/limited/controlled. I think that is the correct default and I
hope it should be possible for you, too.
- it's not entirely clear to me who exactly is 'you' and would
appreciate more info about that.
- it would be great to discuss this topic in person, i.e. in the
upcoming NetDev.

Thanks,

Paolo


