Return-Path: <netdev+bounces-275286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5CIrDPVN0Gnr6AYAu9opvQ
	(envelope-from <netdev+bounces-275286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A663990DA
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57E1A3007B27
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B741EF09B;
	Fri,  3 Apr 2026 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ijT1Xry5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB75625
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259117; cv=none; b=me5/xR/OVqa5ex1hHFJH2qDh+EbRpYS+zPHDpBfZdmBbauqMPHadH1x7e1YLDs0oHYV7zqEKrQE85l9Yjk53P0e2/CeCy0aAh4Z6t6FHwN0rj9LIV7eXcXE5cH6mzMdMx9TnJ8cv+0ZmluY3NRws0bgPjZPkr2lQiZLw+WI5hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259117; c=relaxed/simple;
	bh=EiHYEUqXbnGdg4Io2k4aazz5Cz2UWHqWKj8qDSWnN8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJVFtyIMUjp+yQoSypKvneD3yq0uRV5uV2gHQgw/8IogWHanaveZGg5zmGpaQOBCcDnel/an/BmG7JR8qrsWbHJlNM3+XlTsKoaPiZNzxz6PcoFtCUCqFB77BclzhVaGScyhxkY8dxImSltWDfgof5u/r2v+sTQkOSQI1WTk4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ijT1Xry5; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EiHYEUqXbnGdg4Io2k4aazz5Cz2UWHqWKj8qDSWnN8Y=; t=1775259116; x=1776123116; 
	b=ijT1Xry5p8C5qIAg3Ddv5ol5LZABZHdL0/GOtrJD6eiRpbWAkOvD1oPVUFreY1k8altq60RxlCP
	WVnunXfQkS5X0MtaWiz3rWDydaf2ygA/Dm9clzkORW+35IugIvVrEXyo4gvvoq6waoi87mpqTlGm0
	uXsGT+aKNDPbXa0KBCzmDxkaefbVFMjcqnqFudLYk41wU7zDg7S2Y2eNLBLsZkPJGE595bp2LECYs
	HvmOLVZR5cDSbAhgWiH1cH46Cud3lcR0wUaVpF4/gqF4RYt9SzCyHL4AbVyAwa+1ZO4I27IYSgfxN
	mXtO+wjHFELiw9krNg7aD+5o1A8qv5YCDq1A==;
Received: from mail-yx1-f47.google.com ([74.125.224.47]:48298)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1w8nZj-0003u2-O4
	for netdev@vger.kernel.org; Fri, 03 Apr 2026 16:05:17 -0700
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65005a8840dso2372781d50.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:05:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWx77p+iEFRCdDXc1wZdjks/ecDZNpbpXSklgRjVaTvaaS8kcEZ9oNexkwMQ7eQJOcbDLm5Eu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WC+cxIrORMdweWQTTPmYeJt5kGyR4paVTJdjTKv9ZEkwoQBR
	/LwNNagNsmM+6miQtkJwEOIcmebo0gUuB0SmicXRbktRLLrf5bIcHyNfRme3yrxbzDMQuKrw0GC
	ds0DAeuQmN+2ye+9ATIJwMrJ0G1u6Gho=
X-Received: by 2002:a05:690e:bcd:b0:649:ed08:1a01 with SMTP id
 956f58d0204a3-650487ff730mr4238404d50.35.1775257515063; Fri, 03 Apr 2026
 16:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316223228.2611-9-ouster@cs.stanford.edu> <20260318072131.268946-1-pabeni@redhat.com>
 <CAGXJAmy7=A+Jc+iJ6jwddWs6x0z4pOudRs31Q41m9HMZ4yTWnw@mail.gmail.com> <6fb603dd-7bc2-4b60-bf93-7247d05f3250@redhat.com>
In-Reply-To: <6fb603dd-7bc2-4b60-bf93-7247d05f3250@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 3 Apr 2026 16:04:39 -0700
X-Gmail-Original-Message-ID: <CAGXJAmx6YsBYQCagvHs1DPTd-b-yHYVTN67-JCApQdG+x6-cjg@mail.gmail.com>
X-Gm-Features: AQROBzBx-m95OVEa-wxTtrUhdXC2v216RdgAWhvgE2eouZA4aO3K02ktfILiYs0
Message-ID: <CAGXJAmx6YsBYQCagvHs1DPTd-b-yHYVTN67-JCApQdG+x6-cjg@mail.gmail.com>
Subject: Re: [net-next,v17,08/14] net: homa: create homa_rpc.h and homa_rpc.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.8
X-Scan-Signature: 078eb853d78558c6c655f7b6c94b391a
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275286-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.650];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54A663990DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 1:55=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> >> [ ... ]
> >> Paolo also suggested using deferred SKB freeing (skb_attempt_defer_fre=
e) to
> >> reduce the cost. While you mentioned that GRO is implemented in the fu=
ll
> >> Homa but was left out of the initial patch series, would it be benefic=
ial to
> >> include at least some of these optimizations in this initial submissio=
n?
> >>
> >> Reference: https://lore.kernel.org/netdev/9209dfbb-ca3a-4fb7-a2fb-0567=
394f8cda@redhat.com/
> >
> > When I asked ChatGPT about homa_attempt_defer_free it said that it
> > only works if the skb has no dst, no destructor, and no skb_nfct. I'm
> > a bit unsure how to proceed. Is homa_attempt_defer_free only intended
> > for incoming packets? If so, then presumably there is no dst? But what
> > about the other fields? Do I need to do something to clean them up
> > before calling homa_attempt_defer_free?
> skb_attempt_defer_free() usage is intended for the RX path only.
>
> Incoming packets get state (dst, extensions, ct...) attached in the rx
> path before reaching the socket. You should free/release the state, if
> possible, before inserting the skb into the receive queue, so that you
> could defer free them after read.

I have modified Homa to use skb_attempt_defer_free, and this made a
significant difference in the throughput of the critical path copying
data from skbs to user space. Thanks for the suggestion.

However, skb_attempt_defer_free is not currently exported, so the
patch series will now include an EXPORT_SYMBOL line for that in
skbuff.c; hopefully that will be OK...

-John-

