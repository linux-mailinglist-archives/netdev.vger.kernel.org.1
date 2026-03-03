Return-Path: <netdev+bounces-263111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH1OKtiypmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:07:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7841EC5DA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C6EE302D960
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E768E39183D;
	Tue,  3 Mar 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6cYQLfx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056539183A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532371; cv=pass; b=ZzMjmZbvc/Le3J1kR2Si7mjZ3eG/Gv6AHQUV95S5izq6VHgT4cXrFwC7Fn1vkvF9j+Z434BVCC2HHk4qHujx+9EVjg66j1b9UH+Nio84rdCLE4F/2zaWJosOWuFJMuwuP4zYnU6yGjNOQEZyDWAJvf110YbzUDabN2O4FNJ9QEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532371; c=relaxed/simple;
	bh=TXD8wBl1/tiz5zuR+euDkTwwYMCtcVIXuwRmmebmx58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO8xLe6u0+p6pgSpZxbQkL6zcWaoa4siJxfNOu33zVTjebfP18RSiaaiJKffmVBnOc1F6DF5POsEp/lc3DMhM7ZpLGR51W62pmVZJTRV+Oa+ps642UuCcKOdoSSNADywkA/N3U4h+y8k72MWUDD3GKuaydk7u9FzNoIebX2++Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6cYQLfx; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5069b3e0c66so89774991cf.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 02:06:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532366; cv=none;
        d=google.com; s=arc-20240605;
        b=YkY+AkW65MtuWULQuSYWr2NC+MWpjsEr9QKwyddplNfYuyClrtFiRDGun1v75U8x8V
         5Zm56VVHZ3f5eVKs/xPKsiipcMraGKFH2JizT372E9L/HMD4Glxj2lhPV2RqdNOcWDQe
         YhqqUlJT7AAV5RmQhAZt62lpwRzrupun4ohwVKTycSwt33zTufGzi58DurUBqdVGV5q2
         G3MbqzA4JqBVBEXvbOR8aDDPBEANYc9fuNAtE+y/fsAkXaoTo3xNSchkcvxY2cLQ/0vv
         1uUjDSXNQsLre6WnE8eWkYOKEEZwtTgUvt7OwhT/gEpxk2u0XtnudN9ssYJNXjiFm4dL
         EmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nlvygqEMtuXFAuDGVERGyY/ZdvJKHhCbqSV8pxxsLq0=;
        fh=HHuoHCrJiH4PdsQPjeklSaWB3GsbSeB/RINBiq+hWdM=;
        b=Mgn14mDbH7P3a+k1qbUwQ8fonJaBEyW7a5JJtrmqwAJKzE3K4cLw04b8sxzuFEGgaD
         eITn8xHhLIKJilPWetwfOvRfIhxfMx1zHpnVGzJJJoVq7rEgTIRDXY2hHpOBdnAOakFk
         DcnXYyttdvFWsTBOPD87dxKn43YMGVIRKBbVs/YpFiBJbLVdrS5gJbZmAqAdvKOxsG8X
         RZIoEFVvP5RTBsD4UbBhQMK8rciAVxMwLdmqfnWQhGCMIL5AEj5dNNJU/zrJHQ8RsIft
         9vraxH3304quRr/UsDSNFv8q77hAvUERysCsLzX6n3nq/GA4QPQOfjLHnRcREFW/9hru
         UaVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772532366; x=1773137166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlvygqEMtuXFAuDGVERGyY/ZdvJKHhCbqSV8pxxsLq0=;
        b=p6cYQLfx5NOpIb1F6ZrIebEXH1hKRRURAE2MGthKBAvP0ZAcj2cZ366i2BGpwDpjVF
         fNOPseq+3QC7Ao1a5UYsO3gWGC9OSYFKl3K1VJ7lN+0+QK3M9o9gSTkJf5Ym5rsX+5Ge
         sikAqhAlVgnTgkLMYyElqm5vPB9ApqWs07yJIkhRLObCYsIAQsOpthOS0a+4ftZnY4aP
         uYMzRzjIRNXrA+25vcgdajPhOhYlZ7L8BRHnhuMwgBsZt88KppEPlOtYk+IGr5KKopsG
         NEINPg0KItjW/eyi5USV0Mfea4dyyKHzqHjTCaDkMsb1Exm4w6XNp6axyTQ1zqDpUA88
         uxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532366; x=1773137166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlvygqEMtuXFAuDGVERGyY/ZdvJKHhCbqSV8pxxsLq0=;
        b=jJDBTTl3eXYnshHPJ71RyHWAd7KrDw5V3h37kRfta9n+lNTRTbCQ4anhJWjQEfK8yW
         JSG4DuXyZ05N0kBsgzpiaMDAt0IJ4A4eoJeJVbQAg6taaumjb7jvkh3IKWQO/WXzz5gH
         naQj0r/7f/rXan31o3asoqPXuJaj0PKIetC31w5M5irrSo/yWrp9MphqBvxLvBYLaQUM
         2YmzayFL0kNDQPsJQIMTOf69RfmiHgrriYek2cvCVW6P5dKJDN8fqDNo0VxnD6qUorom
         pVL163CSnVmqE9KzG0WDSaNR5uwMijHm8c61DcBVipl+D7S0NQd6BBDI5vUAWAr7p/7M
         VSSA==
X-Forwarded-Encrypted: i=1; AJvYcCXoczu4ogzXuk75LTMQQM6YZ2x7N3HrFIa7jh8ukclBQGEX9Cnkj1e2VtcYU2RVENMk5rQJLAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXitftyxaDD+8rr8WMgJ5oUOCR2cBf3uRMnvgWu0JwCv6T8Jn
	a6KFhqSol3Aimog0WWLGptKnFCI2cKUZFRgj/9COjYElgDWa8D5hWYEn6F2kyS4Q1nC8pKr69/i
	8F0VTFAxqrThN0WnWamK4f88hRW+w+NaHvLSgKJPR
X-Gm-Gg: ATEYQzx+PFlMITe6cI5IzZhYu/b6eVh4voqFw27MSgOLPwCS1NUHPqggPKNa7y3TapZ
	qFcHmBZFYfWVmb3Ebos9p0eliPsVllQaROr79+f1m9MHjVjV1z41wXP1Go5UIbUIuJIUsawsb/v
	PiPeBHu8GAgGZrwtT0vpyHmqb95JsMCafH9UmvLG8aTSnPQ7Y68ZHlJgNt67NdvI/ETFB3ZEyq/
	NAJEXGqYn58wILUGV6zcXHpgt5RIuOchYHmjsA7BXixUF0w+f4ZbLGIClZvy15Tt6B49qZkpUGT
	HZPTL9w=
X-Received: by 2002:a05:622a:58c:b0:4f7:a06d:c4df with SMTP id
 d75a77b69052e-508ceaf5444mr16857991cf.33.1772532366094; Tue, 03 Mar 2026
 02:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303022947.3061602-2-bestswngs@gmail.com> <CANn89i+mK-CqGPeW65RBeOe2R-YjqjxU9W9AGbvV1Ef+HS4DtA@mail.gmail.com>
 <aaatKuzRBaR_cSL2@SLSGDTSWING002>
In-Reply-To: <aaatKuzRBaR_cSL2@SLSGDTSWING002>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 11:05:55 +0100
X-Gm-Features: AaiRm53mMVRKeyL-ymVeWdySkSk5OAn-hxZsGfsCffTqxvK0AEiY4PuEilCFcLU
Message-ID: <CANn89iJ0dvwjA0925YaY5tL-CHxxPPBUSSw1GF8-bkz8e41fRw@mail.gmail.com>
Subject: Re: [PATCH net] net/core: add xmit recursion limit to qdisc transmit path
To: Weiming Shi <bestswngs@gmail.com>
Cc: security@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0A7841EC5DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263111-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 10:43=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> On 26-03-03 05:30, Eric Dumazet wrote:
> > On Tue, Mar 3, 2026 at 3:37=E2=80=AFAM <bestswngs@gmail.com> wrote:
> > >
> > > From: Weiming Shi <bestswngs@gmail.com>
> > >
> > > __dev_queue_xmit() has two transmit code paths depending on whether t=
he
> > > device has a qdisc attached:
> > >
> > >   1. Qdisc path (q->enqueue): calls __dev_xmit_skb()
> > >   2. No-qdisc path: calls dev_hard_start_xmit() directly
> > >
> > > Commit 745e20f1b626 ("net: add a recursion limit in xmit path") added
> > > recursion protection to the no-qdisc path via dev_xmit_recursion()
> > > check and dev_xmit_recursion_inc()/dec() tracking. However, the qdisc
> > > path performs no recursion depth checking at all.
> > >
> > > This allows unbounded recursion through qdisc-attached devices. For
> > > example, a bond interface in broadcast mode with gretap slaves whose
> > > remote endpoints route back through the bond creates an infinite
> > > transmit loop that exhausts the kernel stack:
> >
> > Non lltx drivers would deadlock in HARD_TX_LOCK().
> >
> > I would prefer we try to fix this issue at configuration time instead
> > of adding yet another expensive operations in the fast path.
> >
> > Can you provide a test ?
> >
> > Thanks.
>
> Thanks for the review. I have two follow-up questions:
>
> 1. For the configuration-time approach: the loop in this case is
>  formed through the routing layer (gretap remote endpoint routes
>  back through the bond), not through direct upper/lower device
>  links. Since routes can change dynamically after enslave, would
>  this require adding checks in all of bond_enslave(), route change,
>  and address change paths to be complete? I want to make sure I
>  understand the scope before going down that path.
>
> 2. As an alternative, would it be acceptable to move the recursion
>  check into the bonding driver itself (e.g., bond_start_xmit() or
>  bond_xmit_broadcast())? This would avoid touching the generic fast
>  path entirely, and since bond is LLTX, there is no HARD_TX_LOCK()
>  deadlock concern. It would narrowly target the driver that causes
>  the fan-out recursion.
>
> Happy to respin in either direction, or explore other approaches
>  you have in mind.

I would add the recursion check in tunnels drivers doing a route lookup,
since the packet can be sent to an arbitrary device tree.

bonding in itself is fine, we already limit the depth :

include/linux/netdevice.h:99:#define MAX_NEST_DEV 8

