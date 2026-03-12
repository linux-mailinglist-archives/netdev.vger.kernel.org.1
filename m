Return-Path: <netdev+bounces-267207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGJ2KOsis2mASgAAu9opvQ
	(envelope-from <netdev+bounces-267207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:32:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 058BE2793EA
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB983021708
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF377359A8B;
	Thu, 12 Mar 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kWpAfTXe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE6346FCF
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346881; cv=pass; b=eDuuNNlkEqAvOQGKmFm6VgGoRWnXL9aMe/QkMCriuTe3kdEUQa5rbldov6WFm0Dau+9FvZCWx7XhdPbigaComSVm+3Oac0TeGc3bSi0+XaXXeKv2DQBVi6Kb3YHanDfoYw/llB3WVWkWafuvrVW0H+40biuONE9JcwYr57m8PJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346881; c=relaxed/simple;
	bh=rWFm2EJQYF+xKWmWkqIgMk3bsRLSIOMtzdcOxM5yeqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/+U5Z+PKBRM9Ea56z1+1naUtR8bckt26RA/Ojbg8eI781s2VHhLVt8UnA1F8pmXj28N/yRqSqLWHcrz7LlRxc7GKUiPC9erWY/z3SEQta2n8WR1WZyY/hO4EBEs94BB9M2jiCUX+L0X3ZjWCKcqbfT3JboBroW9AJ50bKdPFkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=kWpAfTXe; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82a13374cf6so777104b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773346880; cv=none;
        d=google.com; s=arc-20240605;
        b=LwvBXTENx0xSadea+Cn50AU88xsiYmikVXxx0jbGz3iCOQTtNCw0+0+mjm5hNIGHaP
         IR6AHkIFUMEfo9/thVUEzjJn1uawLzUK+DAby9rDzCbAyyl2TMZkc7+vf58R+1m482Nv
         eZ6f58Yx41Xbob/gg71xSRUQd8bAiivHQvY+UT17gTDOeMQlthNPJMetv+JiQ29Yft68
         QK5KQmTLsU7Gfh2+DbC6EQee7SGymrGF+gzRNJCIT12xy8mjJWrWh+eLsxhcRZPuUvB7
         5cPzU2vbylvKU5pVFa4id0O2GsN/FIJPTT0yTjgh3UzQuJlmms7asgQ9G6vPqUu/PAXq
         gvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+9P/uwGyyTSHvuS/JIPtKcbvn1iaK3U44+sV3iWdSA=;
        fh=GwZSyst1/uwNDBzdOZIWelmvEDCuAqhGpiMErsPAPlU=;
        b=AN0PDa3Zwau7hfpfTOiZhHJQRpBNmqhfpArkO8NNy7/uhMJu9Z9GoNnTi7gd6XmEXC
         LI7si+razLKZ6zlIER96mpKGMCxN2dhZByG+HmQOu6HE8fDuudAgYJ3K1Jd/SdLJ8C7s
         lGCLV9MHFaNnPJ66mQbsgas7XlccJID1H3kIsPWf+HJM7egb/wHtBa6uOYg7vjamphpS
         LkCT8BfvVuwzckiIUg6Gvva6NjAxkQ26F2IaDhThruQ/N0x9LP7QqaW+tNdtPLbn2kXr
         kLA1lIQewbEOZf8fbOVvmW6D1dcmoREZfqicNcGd+a72rj8+9X1VlSnDf6alRKcY9gqo
         K6Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773346880; x=1773951680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+9P/uwGyyTSHvuS/JIPtKcbvn1iaK3U44+sV3iWdSA=;
        b=kWpAfTXedUIHA2FqHttCVEz2fhKFR2zlWbdXyAWMBiKifSWlwZRoEvMPjYiOKKB5eO
         OfSMkNZ6ROBW+1juzDaY8xz5Fo2bpenkVStxTpqVR4qKLzrVTJZu3wV8no1b/VP/cOwM
         IaT38UA4p598Z7kbh0FlLKKbHNQfByEffGHP6WEJf3NRvThQ8h25uR/loRQ+J+9q8kZl
         CK+jT2B51pxPYnuM4+Oe014wgyXBhCfqyhDb9xAWYXt58a+uGjbz0hElZJDvaYFUxJWx
         mjZ0aCeQD8rULpd+mcjhbfQfQ4kgtO3rbF1JncNuCcNxBBkdTnTxEwiEDQN/Xpggsg2y
         uLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346880; x=1773951680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+9P/uwGyyTSHvuS/JIPtKcbvn1iaK3U44+sV3iWdSA=;
        b=XVyGJro8FPqhe5Vx6tYkWSt0+P5pYdYK0yWYr3NAeQdO8b3wA2CWkNAW8RQV9AbOM5
         bapIgre3Ya6gD1ZW+HPeW5cTS9WfuzUVLovMT9jVpxYil4ALoBoJ/rytYz5b0kf6us+X
         oWS5ER+0E9fdHuC0iqPfLxSTfRWtzQ7v7HF/LBX4fZaVS/snNzpq9O8nAOjsrBMJ4NWP
         585A7nnT5VqIZdU0xzfYixdoYqoeaUyko2JA5vT1TQv8bfhzQ4oqX1YxS2yqzjMke6zt
         1VUTDfCihuqgD9BTE2oFaGJD/QZsPEII/xnLuEWw+Q9Wegev+0egssl5uEkkvrualUEz
         JZgw==
X-Gm-Message-State: AOJu0YwpyZ++MP7rCyjJmQ/3mlt93/j7yy6s+b71FHPZm4yHNWUjmvZf
	soPFrm1zm6P26WTZC8lfZz9HwIYXy4m3jpaJ1qvzL4+tB1cbW9Q4jNmaZH7Be81mY8Vk1zGYj46
	IRXHNdF1mKi8gXDIFZkdvmnj714SGgQMSkqUVyPLz
X-Gm-Gg: ATEYQzyIuta0MaYX17dX/Ry1dvI7eo8yOVjRQAarmPS1D67fE0MmwWrKPREhLi/74j0
	wr1FEpujgErTPmH007G6JRt+cOxLY8KckLJ0I5Mi32f76dq1ID1rty5+x4rgOWl/nqy05TOrzST
	xqtUsD8UMtEfnKk3IrsI8rquBTKycvTkNK9il81Z978Ql4CI11Ke5l9O14AyfQSPt/F58Ypktuw
	G5dNJberC61ctDZwBP7WvZC79ZbLkpvPT+zfS4yobxxVbp34XqaSXz13Tmdqh5m8IJnqedW51Od
	Jq9u7l+r6fxlLls=
X-Received: by 2002:a05:6a00:a25c:b0:827:171c:d0e2 with SMTP id
 d2e1a72fcca58-82a1971ec7cmr544957b3a.18.1773346879664; Thu, 12 Mar 2026
 13:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com> <20260312165757.GA3411905@mingi>
In-Reply-To: <20260312165757.GA3411905@mingi>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 12 Mar 2026 16:21:07 -0400
X-Gm-Features: AaiRm51xawozrpvQ12NLcSLFc3T40Y-m9MHDUIfw5JzZK28wMk_-CfnKyu090GM
Message-ID: <CAM0EoM=v6AuzmR+s4OAiKa3jXp_Hb+qgp_gh7FeeGrvMiztiQQ@mail.gmail.com>
Subject: Re: [RFC Patch net-next 0/2] net_sched: Move GSO segmentation to root qdisc
To: Mingi Cho <mgcho.minic@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, mincho@theori.io, 
	victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [13.84 / 15.00];
	DBL_SPAM(6.50)[test:email];
	MW_SURBL_MULTI(6.00)[test:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	ABUSE_SURBL(0.00)[test:email];
	CRACKED_SURBL(0.00)[test:email];
	CT_SURBL(0.00)[test:email];
	TO_DN_SOME(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DM_SURBL(0.00)[test:email];
	NEURAL_HAM(-0.00)[-0.803];
	PH_SURBL_MULTI(0.00)[test:email];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-267207-lists,netdev=lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 058BE2793EA
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Thu, Mar 12, 2026 at 12:58=E2=80=AFPM Mingi Cho <mgcho.minic@gmail.com> =
wrote:
>
> On Tue, Jul 01, 2025 at 04:29:13PM -0700, Cong Wang wrote:
> > This patchset attempts to move the GSO segmentation in Qdisc layer from
> > child qdisc up to root qdisc. It fixes the complex handling of GSO
> > segmentation logic and unifies the code in a generic way. The end resul=
t
> > is cleaner (see the patch stat) and hopefully keeps the original logic
> > of handling GSO.
> >
> > This is an architectural change, hence I am sending it as an RFC. Pleas=
e
> > check each patch description for more details. Also note that although
> > this patchset alone could fix the UAF reported by Mingi, the original
> > UAF can also be fixed by Lion's patch [1], so this patchset is just an
> > improvement for handling GSO segmentation.
> >
> > TODO: Add some selftests.
> >
> > 1. https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@=
gmail.com/
> >
> > ---
> > Cong Wang (2):
> >   net_sched: Move GSO segmentation to root qdisc
> >   net_sched: Propagate per-qdisc max_segment_size for GSO segmentation
> >
> >  include/net/sch_generic.h |  4 +-
> >  net/core/dev.c            | 52 +++++++++++++++++++---
> >  net/sched/sch_api.c       | 14 ++++++
> >  net/sched/sch_cake.c      | 93 +++++++++++++--------------------------
> >  net/sched/sch_netem.c     | 32 +-------------
> >  net/sched/sch_taprio.c    | 76 +++++++-------------------------
> >  net/sched/sch_tbf.c       | 59 +++++--------------------
> >  7 files changed, 123 insertions(+), 207 deletions(-)
> >
> > --
> > 2.34.1
> >
>
> Hi Cong,
>
> I tested the proposed patch and found that the reported bug was fixed. A =
qlen mismatch between Qdiscs can potentially cause UAF, so I believe this p=
atch needs to be applied.
>
> When executing the PoC on the latest kernel without the patch applied, a =
warning message occurs in drr_dequeue() as shown below.
>
> Before applying the patch:
>
> root@test:~# ./poc
> qdisc drr 1: dev lo root refcnt 2
> qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> [    7.588847] drr_dequeue: tbf qdisc 2: is non-work-conserving?
>
> Testing after applying the patch to the v6.17 kernel shows that the warni=
ng message has disappeared.
>
> After applying the patch:
>
> root@test:~# ./poc
> qdisc drr 1: dev lo root refcnt 2
> qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p

Please test against latest net-next kernel then report back on the UAF
- not a "potential" but a real one.

cheers,
jamal

