Return-Path: <netdev+bounces-274196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIfnNapOzWkWbwYAu9opvQ
	(envelope-from <netdev+bounces-274196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:58:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F137E492
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4450B3061E32
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607E47B413;
	Wed,  1 Apr 2026 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W9amduMA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47547A0BE
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062558; cv=pass; b=uPmr1CMnli4PI8auQGHWB6IpHrsN9vqx8gZ+U0ckYRjKJCeKVLGdXJbEdQUPyG0g8ASx1+7btOP/efsZ9xd4uZx878AfrFaNkyRAM7EhAYN30gmS5zvQ5rSogB45ExQDzupfH7GGiuGLCywfg9NHPZqgghG5v3ynyoI5Wwakd+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062558; c=relaxed/simple;
	bh=eO/Aj+ZtlXpxdIHMKMSgcDj7n5rRQmBw8M490hgHXi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9nnz95nUinz6kLYWLmvcnvafYRdk+bvPNjiDfLxms5G/3rIunhEMe1D7UQe8WB75QmC0LygP6WJqSWC0NXyD2Q2Wq6wJzSVHBQczmXw9RccPXpayKCfUcG+moze7nSEtOgkZfZ6fHMDhvXyrxNIAckQs207bpm5IR182a0/Iwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W9amduMA; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d029f346eso2643442f8f.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775062554; cv=none;
        d=google.com; s=arc-20240605;
        b=JC53aaVULxXtl0s/8xCFjkR1kz1tZ29TqCgjJwps9Qlgf8MVvVqPr5ajPjh+ja08Fb
         463ylWS0TvqM7NVt25r4JwRQwgMxHhocnw367+NcDKrePxID73+8KF5Djaq212Y8HTvZ
         IpsDh9pdHGa/Ii0FH3dCvCUkhBl7M9paXQlrDdXQs7Q2hJy0fKPf7oiGWLQwrtKbsTTf
         e4DXx7rcJuPxvzArPhBe/DbP9QHhrRCd3gFixrTYyszPo5HatSLqyvpUs73zexXH4ocQ
         3cnI+x5xxslZt4K5IQMKuD03AQxGNaa2Fc00UkOH1WQnLbN5RMZZVNPLV+VlnVyQGQdC
         WWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1xx4YVdOSk31B8m52xPv3EMBRuAXgAy60np1RaxKVjE=;
        fh=kqhjXIqTkYBcur4RVVE//dNJ5+Zo70J6CWsy425OAtw=;
        b=gSW643OOEb4HBaDYzuxskNRPb7sA0zn0fm5hCt7sRTRKWM6vezSN01VTQCnmui1j3t
         l76xqkRI4C5hBkFhdRpq4+B32k7sB/da918cqkOM9OD3bEUEkGJkBRMHhVG2nTb3Mzmv
         VyLKnCtFsxzscisH9LAMLOJqhklFsmXpeAJB32st56rHPhqmSH/BPpXc0KZxwySIm8bA
         Z8voD6A/boFIzo+oeChtIf9Twj/tMZb5Ncud6Jm2HC9misj1k65JwsRFIpzqC7kO8FFw
         2o83YSgfO4msQfS7ZZWs5y1G5/pnALXQDlClTzr3askEVXdzTtVwUaL+TrmnuC1gbeA+
         Bqfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775062554; x=1775667354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1xx4YVdOSk31B8m52xPv3EMBRuAXgAy60np1RaxKVjE=;
        b=W9amduMAZBgtkSZoKKwHg6JGvGTJpLQITjCs5521xt4shBY3kqm/5zJnO4+/EgyvX5
         +CaGzkX9ZIfZlalbHBIFNNNpE62gJvFM8aUp5GAXkGFmXy/rKqjLppN58zLcDHMONQ25
         kBEBbEAPHK+QGagjS3Q6TqqOJ7g1dgusB9AkICQEWW1HZ/IQrIHmRY3V8dmEmYFIcbV0
         8JzA6JJ0r0K3vM0/lv3TGBBAQkTh52apoq4k+HrOKLxoYeBDGzEYTUkQn3TdazrRaoNx
         H+9TE4EQo4e93tILpBZ5SYqf3qiNgNCb2Dyq3HY0r80zZ/Qg1q/s8EIVfHAEFhOv3fBW
         32vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775062554; x=1775667354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xx4YVdOSk31B8m52xPv3EMBRuAXgAy60np1RaxKVjE=;
        b=O2kmKVHbjmlvhXxBH77FdeMEnpK01SAN7YHqjcIu5s8xG2mnfuh8B/GTKof6qc+iow
         fPPJdFoJQg40pIjyf8h/nNfzLAbz/pXcCdxQUeJvHRLBz3wR2RFeSXmlwAs09RLylwtS
         HsbjjKSUEpb7pFabbTeLscR1xJ9gB79tyGG0LzTSdBKSAbMPN7YLmQl2g0zyuzFoVSWR
         dN1GzdpSMBw4d8Z5iB/bhISwM+Vw4mzwlOc7gK8mp3IKipJgyVYJN/600+AhRApnj/H9
         2bRwgoX0AL712bLOBxEoiI42GsN93hPCJ3LxLp2TTJnbek2c7KhBJ8TeMMX2NZQn+/3Z
         7yhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+/f9w9qZdOqLdRx3xWEosfJBjPF72i2tIKPhygK3bJKHW3MS3b/kWKjYnG0N2U3rY988fHjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2Jw4UaZjXzDtw0C9KAW6XHaIlSkzB1WiFvgxo4FhJ/XtCgOm
	w1ySbwthZGhbE7VcF4Y/5L8A/TVxkSegyfpji8qkVL9WsZfEh0P7TkEmq0o58WgIfrL3tALouxb
	vLQ8/cVABntGP4c2R2P4Cw0dx+kAuDZFQAi57o3PXdg==
X-Gm-Gg: ATEYQzzvjqtnHvrXCN5L6Mmv233/n7OkZwbxSsSUMIZgVJHAVqJazfiAasiudK01xN0
	98GCTrRqAeeAV9bjOshcSQQpJ/vuvRA6suM+elAmPlBEPc/f1lpAIF8S8sf3tDAI/cE+7+mLyQn
	qKN3Vxjb+MapzKLkqyG4c/l9siE+t+jO3Zv7uG4VpQJKh9t/vt1tP+4yx/upf637eFsUV3AJ9i1
	NWr9bg4iPvEnfVb1SW3ozjQoyKs4K47JH+j3aOp6C3HAhAa7MeOH4XA5u0XtH6HOFAVxWozp9Lc
	qxYBCWtUr76Q41xnFFCOMo5rp2q9dd7afie3rNIISslYjmxAuw94dBCjpDyjLBFL3k0Bv9fTDY5
	Okk3c
X-Received: by 2002:a05:6000:601:b0:43b:3d44:6624 with SMTP id
 ffacd0b85a97d-43d1f1c03femr79938f8f.2.1775062554435; Wed, 01 Apr 2026
 09:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de> <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de> <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de> <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com> <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com> <20260318145101._iaDDpbE@linutronix.de>
In-Reply-To: <20260318145101._iaDDpbE@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 1 Apr 2026 18:55:43 +0200
X-Gm-Features: AQROBzCCROIdCe9kvHP9iYGHGkzUiotwHvSMgwQTbWweollZ6Da-pHq3fXh3bLE
Message-ID: <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de];
	TAGGED_FROM(0.00)[bounces-274196-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linutronix.de:email,suse.com:dkim]
X-Rspamd-Queue-Id: 7D9F137E492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 at 15:51, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-03-18 15:43:52 [+0100], Daniel Vacek wrote:
> > On Wed, 18 Mar 2026 at 12:18, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > > > >             /* Other cpus might concurrently change txq->xmit_lock_owner
> > > > >              * to -1 or to their cpu id, but not to our id.
> > > > >              */
> > > > > -           if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > > > > +           if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> > > >
> > > > Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> > > > which has already locked the queue (and hence the same CPU) evaluating this condition,
> > > > the condition was skipped, which is no longer the case with this change.
> > >
> > > The above was me thinking and does not even compile for !RT. Commit
> > > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > > netdev_queue::_xmit_lock") is what was merged in the end.

Thinking about it again, wouldn't it be better to have one generic
solution rather then special-casing for PREEMPT_RT vs. !PREEMPT_RT?

--nX

> >
> > Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
> > It's pointless to even store it. Shall we care?
>
> For PREEMPT_RT the xmit_lock_owner member is only stored and not used
> otherwise. It could be removed as in ifdef-ed away but I do not care
> enough to sprinkle it and the gain is little (proof me wrong). So I am
> happy as-is.
>
> As for the check itself as we have now, we detect the deadlock before it
> happens and this is nice to have. The alternative (in case of a
> deadlock) would be the deadlock detection in rtmutex code which would
> freeze the thread.
>
> > --nX
> >
> Sebastian

On Wed, 18 Mar 2026 at 15:51, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-03-18 15:43:52 [+0100], Daniel Vacek wrote:
> > On Wed, 18 Mar 2026 at 12:18, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > > > >             /* Other cpus might concurrently change txq->xmit_lock_owner
> > > > >              * to -1 or to their cpu id, but not to our id.
> > > > >              */
> > > > > -           if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > > > > +           if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> > > >
> > > > Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> > > > which has already locked the queue (and hence the same CPU) evaluating this condition,
> > > > the condition was skipped, which is no longer the case with this change.
> > >
> > > The above was me thinking and does not even compile for !RT. Commit
> > > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > > netdev_queue::_xmit_lock") is what was merged in the end.
> >
> > Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
> > It's pointless to even store it. Shall we care?
>
> For PREEMPT_RT the xmit_lock_owner member is only stored and not used
> otherwise. It could be removed as in ifdef-ed away but I do not care
> enough to sprinkle it and the gain is little (proof me wrong). So I am
> happy as-is.
>
> As for the check itself as we have now, we detect the deadlock before it
> happens and this is nice to have. The alternative (in case of a
> deadlock) would be the deadlock detection in rtmutex code which would
> freeze the thread.
>
> > --nX
> >
> Sebastian

