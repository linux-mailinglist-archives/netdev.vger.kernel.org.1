Return-Path: <netdev+bounces-286827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ApUJiNEAmofpwEAu9opvQ
	(envelope-from <netdev+bounces-286827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:03:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A4516131
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 406223033D0E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454AE4BC001;
	Mon, 11 May 2026 21:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6D3C945B
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533407; cv=none; b=nP1RTmnkho3x3yCX3LQQ/nGrdcv69OQ6Lau4/Wa53LMkBbjeBF9cm/7ikzbvT7mhckbJta8o9jr9Ezv1eAjBwRr3tHtBt6lQAHK7L50UQC91O3hfWkacJuM5bHCxG4OU6DsGqnfBMvH3dCRUCAbpXaY+uOYuGpYPeBZvbVq4OXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533407; c=relaxed/simple;
	bh=+NPExyxgo8HU6B6S+16brBkL/23BFRjYZRCRMSCRDlY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kb+u4Q9MAd4iCYFcR3wkfLZmP12yA8SO1/oGlGWTxT/Xe5Qj9HKsQ4FwLSStn1fCjhfMlPUcvXzMhsDt47Km8Wxxhhu22m4A2Tcxuuxz9XJjidcSRmkLjKAprdIFYmtvasHw8X2KJsJpt7iM78JWXDdx8gGcrDJnlD7pcwkxwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso29171465e9.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533404; x=1779138204;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jz3M0PDIssZI97ILfGYCglTutVrokgfI2vbgfWrvds4=;
        b=IplofirTlsNFxUW3UaE/KLNMXlQGQHUMWZteTfIA81Jg6ZvF7Ju8h5dv+xmG2Q7d1Q
         zDb4hziFEA2tqYPjlKyCKAA52vT48s3eeW5DW1OQ+dcb1qQPt39z3+/65wo3Tq5DIUcU
         gJ2UVms6BO0rwFAt+e9S9DV5wSE2v8TCf4BqlphImJFZGJLibUpc+Af85sT355RM2zeN
         Vs8Op3aGVd8j7q74IrC6ykC++pHa/oI8Ux24bvKGnZkSPQ9oaneP8yflM3w4jieUeTAP
         462LQu6fADsVaMrEQQl3dz9q1l4y3/nEOCJlgpvXjnUMIBrysTujV3sfS/25+vLCRvV5
         L9sA==
X-Forwarded-Encrypted: i=1; AFNElJ8hG/Dw8k/vC+XtlR2wC2ilBsWqdPtMCs29kROXoqSYFQkNdJSVZQO+Cw7cDfBuk15fKU+EWJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbAtN0qSZxyX3b1ohk6c3r5plYCPyxsBb4khbQb1TEVRzBLxp
	ROZyOt/T1/9Pm774yEJk2xHxHC5QFBf0XJaaWDW7/BDUCmrVH2GI7lIX
X-Gm-Gg: Acq92OEZTl6pnN9F7kB+ttGReOPdmJCCAp+D/bo8dTR1vlQuZ4DWQsL/7Cvn+44SRiR
	NX5JtbPAW5QuLKIYjx4BiEI0IYsIaA4nkoRt1ek+/KET8vjhmPpxVFXir5mHUd3az6AcFD7UAh8
	zA1PrblOibz4pCD2AsOEyNqy0K+A6UYRLDqsK+n2jxmorXB/+QlB5ahZItBRjZaJnIgc7RMStLD
	02+5992Fq2FUPdCwpPQaFvbZAE7lQMI/wcfoxUVDU7IrSLzBMTYxgcejD754Lx25nxfnSq717CD
	J7eCcYpvbdg8K20kDCXK+t2/70sR5nMIak7rLlhI5IBXB5B+DiD2R7EHLc2+Dbe9RsUlPyzqG0/
	iGOGY9+mZQk2ww5yDBFokPHkSnwLZb2WFvmu0lGWwnxtWr/T4TF1Vx1o3uOwA7C/l4TeJ3PIW1s
	SjwNoQsF6Xlj8n5uDyxkrngTuLlMz2pRCzytwIfKedgVNFyy6sA4pyBHxXyZMqETO70g6JoLAv3
	mE=
X-Received: by 2002:a05:600c:8b62:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e6748afe8mr234131845e9.5.1778533403812;
        Mon, 11 May 2026 14:03:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:96b:a101:6f5c:d416:bfa6:dfbd? ([2a0a:ef40:96b:a101:6f5c:d416:bfa6:dfbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f4389a6sm2225605e9.22.2026.05.11.14.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 14:03:23 -0700 (PDT)
Message-ID: <3bfcf406-fdde-4303-9bd6-0d8d21ddba37@linux.win>
Date: Mon, 11 May 2026 22:03:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ignat Korchagin <ignat@linux.win>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>, Kamran Khan <kz@inspirated.com>
Cc: Jeff Barnes <jeffbarnes@linux.microsoft.com>,
 Andy Lutomirski <luto@amacapital.net>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
 <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com>
 <0b8bba44-f6bb-4d69-b9d4-5787c276d41a@inspirated.com>
 <20260510163204.GA2279@sol>
Content-Language: en-GB
In-Reply-To: <20260510163204.GA2279@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 435A4516131
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux.win];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ignat@linux.win,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 10/05/2026 17:32, Eric Biggers wrote:

> On Sun, May 10, 2026 at 08:54:07AM -0700, Kamran Khan wrote:
>> Hi,
>>
>> AF_ALG is useful not just for hardware-offloading, but also for memory
>> isolation so that applications only get oracle access to the crypto keys and
>> a memory-safety vulnerability in user applications would not immediately put
>> the secret key material at risk.
> Note that if that memory-safety vulnerability leads to code execution in
> the application, then it doesn't matter that it "only" has oracle
> access.  It can still decrypt any data encrypted by that key.


I don't think fully discounting hardware offloading is beneficial here. 
HW accelerators will be produced and without a common interface vendors 
would start implementing their own "bespoke" drivers with bespoke 
userspace interfaces (we already had such proposals), which in turn may 
introduce more attack surface. Yes, AF_ALG needs substantial 
improvement, but at least it can be a standardisation point.


> The relevant threat model would be arbitrary reads, not any
> "memory-safety vulnerability".
>
>> I understand and appreciate the concern with complex attack surface and the
>> increased frequency of attacks in this area. But I fear that completely
>> removing AF_ALG increases the risk for userspace applications relying on it
>> for memory isolation.
>>
>> What alternatives do userspace applications have on Linux for ensuring
>> crypto keys are not exposed in user memory? That is, FreeBSD and NetBSD
>> natively provide /dev/crypto; removing AF_ALG would kill the only equivalent
>> option on the Linux side for kernel-delegated cryptography.
> The standard solution is simply to use an isolated userspace process
> like ssh-agent.  Yes, the keys will be in "user memory".  But "not
> exposed in user memory" is *not* a correct statement of the problem.
>
> (Also note that protecting not-actively-in-use data from arbitrary read
> primitives doesn't require cryptography at all.  That can be done simply
> by using mprotect() to remove read permission from the memory, then
> temporarily adding it back when it needs to be accessed.)
>
> In any case, any hypothetical security benefit provided by AF_ALG would
> have to be *very high* to outweigh the continuous stream of
> vulnerabilities in it.  I understand that people using AF_ALG might not
> be familiar with that continuous stream of vulnerabilities, but it would


Is it actually that much compared to other features/subsystems, like 
eBPF or user namespaces? But we don't rush to deprecate those - instead 
trying to harden them and come up with better design.


> be worth spending some time researching what has been going on.
>
> - Eric


Ignat


