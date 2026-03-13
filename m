Return-Path: <netdev+bounces-267459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGYFIToVtGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:46:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298542842CC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0209530ADDF2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC212D7D2E;
	Fri, 13 Mar 2026 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfBz//IE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1A4F5E0
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409099; cv=none; b=cqdORb1HtriAIQCwH7zbhhLK/qv/f6C585I0JOSU67NjupjNzRsfMDyFpX6nVaNwI+c+fOYY+BjZyNrM3cRwqm9138w6gEEfkYZgGRExvUxxSPFuX7BSUSARnmn/m0JdACLqTjkrCynIJzH0FL24/LcGURTnkRH3Ty6OT/pkRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409099; c=relaxed/simple;
	bh=fO5y8niSu6wuGZHGL0mqjSx29+jZxTAClpXuoNkRjnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGTsFGen0m6hYw+otbHp2OvVLBKhEn+cFRxOVBtEjcsL5vATLdDQCbTNj5hC4i/tH1uIMI6DTSMfiNThgasJNa2WRJQtvb94KL5eTFGVugUtXrGEFgj3LqJyfB99MxWhj3O9BsJXLKPhx+gkXhRyvBt3UmteqqYAgrmrNoHmUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfBz//IE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a288a2c00so258056a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773409097; x=1774013897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iBQIcHuyR+UXN0mm2hfALE6vllGeSWGxCuyESQL8+Ac=;
        b=mfBz//IE/ApiHzbDM6YfE6M7jvIG3ci1jgU+QoKwvf3CE2u/jA7mAbQnBUxEebcjOw
         lCOJRfo1AM9TA7ebqX3DnqYrYHCXjepk6wjDAGAW4t5BgAmE/TCEVaOc2I7QmYQsrrce
         X9wmEuNft/zibj2K4HDryctuyRPm9o0BRBhbUyGqx0kQnPD5dzWaXSPNGuHWICQ/93H/
         sFVeCD0VfX0JRsK8nFXo/+s4XWS+xea5T+msvI+SUx0aJpzXfwyAbeVlfbvLMETInc9e
         b+7NHTarwaDb1nAC/0YIjKMwQn/Wx/4guODoZFcxH+ANMBc8jjX+5Mf4ypCXgX2wsPH4
         H2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409097; x=1774013897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBQIcHuyR+UXN0mm2hfALE6vllGeSWGxCuyESQL8+Ac=;
        b=i8R/9bks/gF0q9aJuRVlZBm/YYKF+ucBmXTwbt8MMBcZmmKzQz1P1e083ZeogMKb+3
         bUHNAF4qHcxix4UvASQioJk58BIKaMU06cwuNNRd3u5zLtAVO489rJeELgaydryOltR/
         2fVcW3lkl3+Ri1o2ATyfLQAeS+SUeghCuF2yX1w/ef9+z48xbZD3oV32mzXWRqpnDAbW
         4DYjiko787+BOMVcl4aBLTFOXaKjjQ0xR6+ebZ/q2U6o/Bg4Xp3oLI72hAKkWnq29hDt
         q6uUtUSTsjFMRfVsD+2GBIAC4rxDI9X8Q3mPn6rkGQ1mF2YIGDJJCpDMdCHvbCC5RmEl
         t8sA==
X-Gm-Message-State: AOJu0Yz/b1HVVLhPxXjVY9Qmga/AMyJBI3h5POIZrLVkdouiXtiHLXfy
	KZVz2THAiOftfvVPiJjmNpeAWcbonP2vCZHQa2mDlEmY8YL6B2K23At0
X-Gm-Gg: ATEYQzx1IL5tmmxMz1qG3Eo7zLbJLXQ2vcAyxz+3mEVJQKS1pbJU3kAkx1/wx4LtV8y
	MYhitAiGoo06cj0GR9Sx0iwb442b7M/9dd+iOpwIYdj+qTEt3on8MseGvEACyLPHHPgf2SoHAJO
	Ht9o9sJikpZfzBbyTwu/Ciw970FlWkezQeJ7a8V5KmoqfFJ6ESYz/kMvmPe/MFY7q0TiKJdYFSB
	UoswxAgIqSkzTmcKkOMN8OmsqgHh9U1OlxO38qEzmxSMunSVvBEdlncog7gBe90uhkO8jfxhMAP
	ngnrE5Ia2Z9DE+BvGALXEtYwD/JQUEvQb9bYLB7OLIRFgLPpGXtnQ99k53hC+kspPBOD6cQEkJ5
	VKiqXLIMdUVKwNUgqJiCoWjNA2bnfJh/8Jtnvk+LyZlxyDK0pPBB2SFyCGmDHLN/OvM7X/gkzU2
	PMcJlmQHNJCpUkqyn/
X-Received: by 2002:a17:90b:540d:b0:359:2d1c:9206 with SMTP id 98e67ed59e1d1-35a220bacbdmr2820823a91.33.1773409097210;
        Fri, 13 Mar 2026 06:38:17 -0700 (PDT)
Received: from mingi ([175.125.103.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e18e46sm8949360a91.4.2026.03.13.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:38:16 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:38:10 -0700
From: Mingi Cho <mgcho.minic@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, mincho@theori.io,
	victor@mojatatu.com
Subject: Re: [RFC Patch net-next 0/2] net_sched: Move GSO segmentation to
 root qdisc
Message-ID: <20260313133810.GA3431035@mingi>
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
 <20260312165757.GA3411905@mingi>
 <CAM0EoM=v6AuzmR+s4OAiKa3jXp_Hb+qgp_gh7FeeGrvMiztiQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=v6AuzmR+s4OAiKa3jXp_Hb+qgp_gh7FeeGrvMiztiQQ@mail.gmail.com>
X-Spamd-Result: default: False [12.84 / 15.00];
	MW_SURBL_MULTI(7.50)[test:email];
	ABUSE_SURBL(5.00)[test:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	TAGGED_FROM(0.00)[bounces-267459-lists,netdev=lfdr.de];
	CT_SURBL(0.00)[test:email];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	CRACKED_SURBL(0.00)[test:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DM_SURBL(0.00)[test:email];
	PH_SURBL_MULTI(0.00)[test:email];
	FROM_NEQ_ENVFROM(0.00)[mgchominic@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.000];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,test:email]
X-Rspamd-Queue-Id: 298542842CC
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Thu, Mar 12, 2026 at 04:21:07PM -0400, Jamal Hadi Salim wrote:
> On Thu, Mar 12, 2026 at 12:58 PM Mingi Cho <mgcho.minic@gmail.com> wrote:
> >
> > On Tue, Jul 01, 2025 at 04:29:13PM -0700, Cong Wang wrote:
> > > This patchset attempts to move the GSO segmentation in Qdisc layer from
> > > child qdisc up to root qdisc. It fixes the complex handling of GSO
> > > segmentation logic and unifies the code in a generic way. The end result
> > > is cleaner (see the patch stat) and hopefully keeps the original logic
> > > of handling GSO.
> > >
> > > This is an architectural change, hence I am sending it as an RFC. Please
> > > check each patch description for more details. Also note that although
> > > this patchset alone could fix the UAF reported by Mingi, the original
> > > UAF can also be fixed by Lion's patch [1], so this patchset is just an
> > > improvement for handling GSO segmentation.
> > >
> > > TODO: Add some selftests.
> > >
> > > 1. https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/
> > >
> > > ---
> > > Cong Wang (2):
> > >   net_sched: Move GSO segmentation to root qdisc
> > >   net_sched: Propagate per-qdisc max_segment_size for GSO segmentation
> > >
> > >  include/net/sch_generic.h |  4 +-
> > >  net/core/dev.c            | 52 +++++++++++++++++++---
> > >  net/sched/sch_api.c       | 14 ++++++
> > >  net/sched/sch_cake.c      | 93 +++++++++++++--------------------------
> > >  net/sched/sch_netem.c     | 32 +-------------
> > >  net/sched/sch_taprio.c    | 76 +++++++-------------------------
> > >  net/sched/sch_tbf.c       | 59 +++++--------------------
> > >  7 files changed, 123 insertions(+), 207 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Hi Cong,
> >
> > I tested the proposed patch and found that the reported bug was fixed. A qlen mismatch between Qdiscs can potentially cause UAF, so I believe this patch needs to be applied.
> >
> > When executing the PoC on the latest kernel without the patch applied, a warning message occurs in drr_dequeue() as shown below.
> >
> > Before applying the patch:
> >
> > root@test:~# ./poc
> > qdisc drr 1: dev lo root refcnt 2
> > qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> > qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> > [    7.588847] drr_dequeue: tbf qdisc 2: is non-work-conserving?
> >
> > Testing after applying the patch to the v6.17 kernel shows that the warning message has disappeared.
> >
> > After applying the patch:
> >
> > root@test:~# ./poc
> > qdisc drr 1: dev lo root refcnt 2
> > qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> > qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> 
> Please test against latest net-next kernel then report back on the UAF
> - not a "potential" but a real one.
> 
> cheers,
> jamal

As seen in a recent patch (https://lore.kernel.org/netdev/20260114160243.913069-3-jhs@mojatatu.com/), it was possible to trigger a UAF using the QFQ qdisc when qlen was handled incorrectly. I don't think this is the only way to trigger a UAF. Since it is obvious that qlen is also being handled incorrectly during the GSO segment processing, I believe it would be better to remove this potential risk.

Thanks,
Mingi

