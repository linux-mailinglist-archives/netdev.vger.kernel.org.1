Return-Path: <netdev+bounces-285342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFYHOIiZ/Gk6RwAAu9opvQ
	(envelope-from <netdev+bounces-285342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:54:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6634E9AB7
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F58F3016D29
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B153F9F36;
	Thu,  7 May 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jus4Um77";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl6uFDo7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C43BED23
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161814; cv=none; b=UL3Tztzrq6+HWsK/uKAlKKcsPb9NW9ricTrjRH1Wsz7V+cg5F+Gtujd8Gwh26+0EuyXpq4OqyWCZfreNBAHuvMF+jkzviJH/YAD7g2zPdQY6syHJ7jZ9Xdx7RPJD6Usn0pWxaGhS+ZrOYHSEEoeFF4FBwmLO1XI+h52iP0reQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161814; c=relaxed/simple;
	bh=mL80r25nZlp+SaFmpiIYq8HdsnIgOd1kmDlzbMqqGTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEQJYrVoEYaC2iinU448e0QYw2L1oZA4lNSOUE95+LLhsSfJz4Q/mnOLOd4Z6mmPhvPM+eT/hZFKkoVW1RNrr6Bnkr7AWh/zCW6+DBllcoN5YIsjr5OS72XLrTGwn4J5oESY5+gr3wRDWfkG+aU0px/uvCHuQgk1oPFhK50dy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jus4Um77; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl6uFDo7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778161811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Qvchlh67OIf3/sW9av3aNf0ZwBEZRq9XV1ClpbKas=;
	b=Jus4Um77haQBia1eRdtxVxIeocPOreE3clQfUxE9dQvO2u7PzX0muRPUvFxOEomDH4cSR7
	eSvFCDSjlwzqR5Lg6+94soyCLH3+/rmq1bOrIaujzgtwoggKRcm+FNv/Ip1h9R5OvqSC22
	oNL4/UPVDc6ZwdBDLIxigwt6Ec0BFl0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-mlOhKqEvOD6CDfJtfJ-tYA-1; Thu, 07 May 2026 09:50:08 -0400
X-MC-Unique: mlOhKqEvOD6CDfJtfJ-tYA-1
X-Mimecast-MFC-AGG-ID: mlOhKqEvOD6CDfJtfJ-tYA_1778161807
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e60b55de2so4256985e9.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778161807; x=1778766607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2Qvchlh67OIf3/sW9av3aNf0ZwBEZRq9XV1ClpbKas=;
        b=hl6uFDo74UKtBdu48m0vnFSBS7pZFX/CN6ubbi2RahigeQOHkbEofhxlUg2aFFc/xA
         WeD4+KCl33s/aCApwFAXBfxvqlHsUUGQr6RPJKvW+GqVFW3tKFXhEcT41diQKiXXXDeR
         UeAIZqYOplHkq73TTaa3PW/gaUJ7S8LYhvssUkpCJStsDg4kQkp6mxkmXjhv0JtMZiGl
         vpVVvDVT/GiPYJ7lX9zm9n7YjJcgs25NjWRFNit7ODuofGYyersXcedJ6pHoQFkXbUQe
         aRZXmdW3ipdaicYGv0VVW6vIZ5/P3QBf8hpmNmlM/GXcU+wjAKXumcnqZH7WRqfZMril
         L7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161807; x=1778766607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2Qvchlh67OIf3/sW9av3aNf0ZwBEZRq9XV1ClpbKas=;
        b=i9yO94UCD2xQMTQw+rO7eKY4thi84DzL+VQOc2mPV9Ud9fOuB/FUC66oYAfakXfw/4
         Lh4Wg/UrRo0iqaEdgvTN/JXoZ6iM3fQggiGR0CEKAyEXulKlI6eGuXwxB71iMXV4foGo
         I3GExVwErvf194wR0yFGkK5Dlrtp9gWCdrJJN7a8m7aRIA34uh9ijtwSBClJMRLlRNbt
         k86zIHwWYUPb2o4A8dDOnTuiAJdzDnvlVGOebRVn4xlLiB7WIhkyWgZh5jm26KiTMocX
         nC/wR0rNljvVnBiN4F9ID2lhLfivz+F2u2RPFcNlWLyUELEGVpqlpnhvpevvDocWztf7
         ot0g==
X-Forwarded-Encrypted: i=1; AFNElJ8R5qUKxU/GqoRLk08jWlfgU/UgFfO5kWJpGxmyol12wDJvRPwU4TITc8S++ep9U9zzHJV83mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDfI3rmJSfvzBWUavqLAnC3MQnnOfGxXf0wwwTvQTLGw0PLpx
	Mup6wUWG5xBMMkty003JCEuMFGxqVSjJIMWcJar24WgyXfhn/EGs1gluwHCh4r7R0RxJDSYJSeg
	jmiUcSgGr/Da4KSit77ieOsqkF74Vmv6pWV94ipSmIcpI8kr3vAoczJs01g==
X-Gm-Gg: AeBDievZuOcRBOfs/gbzhe9SrbsXF+2+DSlMWxnzOKKmrICOyfG+RLgt0vEk61TuY7a
	r4IgSL5z860cLruonCEOzQ6HOer4OQODr40viUHbnDaDnII80IbB0YfjVwmpn8jOESvrv2RwRXb
	TNvF6dH9opDBIOSkL7Ys7H39goViyKSUinvlBxRpvmcid2Ic4zAZDIEkDId5EBfQFCVXX3tKjjF
	liSR+tTTt46ah6Xt6Y3hwnXhmPkjEmurzEe64vRDazLsusUHjQPDTNqJbsThfrnX5F3Ib5be+Iv
	qX4Fh/cXCCR632sOOuylfqW89bDM5aEoLVHkK6vwYziYz1PaR0s6dNl+HrezExOJs6A9QgWoWQr
	YD1u7S44o+pOt/cECTl0ez/B9UqFUjGuhtiuFYW2gzFifF9sPO4bbcs9sKJWNyvZlCDuZYImfel
	qP
X-Received: by 2002:a05:600c:c494:b0:48a:592c:e632 with SMTP id 5b1f17b1804b1-48e51f42760mr127196215e9.16.1778161806918;
        Thu, 07 May 2026 06:50:06 -0700 (PDT)
X-Received: by 2002:a05:600c:c494:b0:48a:592c:e632 with SMTP id 5b1f17b1804b1-48e51f42760mr127195495e9.16.1778161806363;
        Thu, 07 May 2026 06:50:06 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e628d8da6sm8502825e9.4.2026.05.07.06.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 06:50:05 -0700 (PDT)
Message-ID: <ee4fb21a-2420-4e35-9798-413eb3619dc6@redhat.com>
Date: Thu, 7 May 2026 15:50:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] net: eth: fbnic: Fix addr validation in
 pcs write
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Jacob Keller <jacob.e.keller@intel.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Simon Horman <horms@kernel.org>,
 Lee Trager <lee@trager.us>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
 <20260504135815.44226-2-mike.marciniszyn@gmail.com>
 <20260506185819.1c68a71b@kernel.org>
 <1cd8256c-286a-4a73-b0a0-89233cb3c2d0@redhat.com>
 <afyRrWW8XVeO55Ob@PF5YBGDS.localdomain>
 <afyYJ9-qW_QG6f7_@PF5YBGDS.localdomain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <afyYJ9-qW_QG6f7_@PF5YBGDS.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9D6634E9AB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,gmail.com,armlinux.org.uk,intel.com,trager.us,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 3:48 PM, Mike Marciniszyn wrote:
> On Thu, May 07, 2026 at 09:20:45AM -0400, Mike Marciniszyn wrote:
>> On Thu, May 07, 2026 at 09:20:53AM +0200, Paolo Abeni wrote:
>>> On 5/7/26 3:58 AM, Jakub Kicinski wrote:
>>>> On Mon,  4 May 2026 09:58:12 -0400 mike.marciniszyn@gmail.com wrote:
>>>>> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
>>>>>
>>>>> The DW IP has two distinct PCS address ranges cooresponding
>>>>> to the C45 PCS registers.
>>>>>
>>>>> The shim translates the PCS addr/regno into specific CSR writes
>>>>> into one of those two zero-relative.
>>>>>
>>>>> This patch fixes a one off in the test that could allow an invalid
>>>>> CSR write if an addr == 2 was called.
>>>>>
>>>>> This patch contains a fix for addr validation in fbnic_mdio_write_pcs()
>>>>> to only return actual CSR reads for addr 0 and 1.
>>>>>
>>>>> There are as of yet, no real impact for the bug as no PCS writes are
>>>>> not yet present.
>>>>
>>>> Hi Paolo! Was there a reason / do you recall why this was not applied?
>>>> (I dropped it from patchwork now. If the omission was accidental it has
>>>> to be reposted)
>>>
>>> Darn, limited capacity here plus re-submission glitch: v3 had a slightly
>>> different cover title (due to typo) WRT v2 so PW did not mark v2 as
>>> superseded. I process patches via PW in sequence, when I reached v2 I
>>> considered the sashiko comment not blocking and I apply it. I was unable
>>> to reach v3 until now.
>>>
>>> TL;DR: @Mike: please re-submit 1/4 and double check there are not other
>>> differences between v2 and v3 - otherwise more patches needed. Also
>>> please ensure you keep the series title consistent among revision, or at
>>> least manually remove old revisions from PW upon resubmission.
>>>
>>> Thanks,
>>>
>>> Paolo
>>>
>>
>> I double checked v2 -> v3 for the other patches are ok.
>>
>> I'm just now resending 1/4 of the series.  I reworded the commit message
>> to fix the AI review comment.
>>
>> Mike
> 
> The patch isn't showing up on either lore or patchwork.
> 
> I may need to bump the rev?

Wait a bit more. 1h latency can happen quite easily.

/P


