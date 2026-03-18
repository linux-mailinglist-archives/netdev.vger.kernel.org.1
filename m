Return-Path: <netdev+bounces-269056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE0RJeLCumkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:21:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9745E2BE15E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E5B7302541D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA73DB623;
	Wed, 18 Mar 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FE+/HoIa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF743DBD71
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845907; cv=pass; b=aOiGwEc9+WUIwnWQ9hREdyK4xemfVybE0TcTtj15XZ5nXkoGAfJZ/mvUC9Juk+0M3OlYR2/iKMCqo/G51A2Z5K+jd3F8bcyFXG8ZcFkZeLNUghXPCTkEujq4SD1X9YaUJ/QVOd3b4hy1fRwTJV2vQ/qqtaoCsholLGmzaGPDGPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845907; c=relaxed/simple;
	bh=N1NXpkaQAjN2dHwsSJVS4d7YXJxzt2UyIFGHIrbpYCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqFplrrfESOeq+bKZG2C2xCyC7u49jGWHnaibkoHnl9mxj28W9keMiGVgUG3tGa1dn4uDOvyLbx1fPT+bgW7KYfDChYo6axsBFgD5A3EHPL0vgkd2PF9yqEM7MLKz0Gordg4HkK6EOO5kwj0RgrNhUzyLnLVqVWWb8XkKGYcgvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FE+/HoIa; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b9b190easo5124921f8f.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845904; cv=none;
        d=google.com; s=arc-20240605;
        b=LNFRln2ayUj5FwfV9CmqPzyFc3A2btZuHYFX9TYoDrvSilj9wutennwthJ0xzQEg0V
         t5xS9xx44i/1RUhDJJdH99SVrl78ecqQz2edHRqG0crE8PNxo5LWqCbFdGtDitXFWN8z
         W8n0gv/ixxEfo2FsDKhnRDrDo7JmDEqKG5XHB1vnZ9dmLu0ypx2uBBgP5uhTP9OlG3fT
         uTh5quqqusPX06XL300H8gFcRtlWn/RQkpb5Xs+x336YJbNyCQ8dQAnYAsPy/LYtP+1A
         8JtPWRRg3p+f0pjHsfcghL+61agBfaDzghueYX4ewUJv+Gl43owpJBRRYQwbM8cKDK+3
         hHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=67Lxa4BGXjz9Zo1vWHQleC/2O1UPzPcZCuH/+UGL6f4=;
        fh=Z1DPD8R28Lnu1LRjSBCOzFoP5MuHosyfv0RHTrKYgT4=;
        b=LZPzT722n8bSLk8jIOP+wf5uKGUDdCOXD0RVumhIfP8/7AtA5la9wwQ6QAq+p66OtB
         372mhnuL5hIm65rHWW5NMoF/vxckf5BsIkmD5XK9pAj64qbZvOgr0PbgSGEXhotAANfb
         nl+11yW2GxeMqKrYbWV8YC0Brw+MPMwkWuk8IUF4il6+kBcIQOJvtAk7qNk9a7eM+blR
         rZuWxR/53kdvUtaq6FNbErrFI4JCz3kg2gljnmD2bcLEclWdE4tnzv+RTgxSVkAhAwbr
         rqn4Rk1ZLIeUFNkdlah8Ff6nKemqU8pG//NWzLP0ZMJEuyifIZGMrhlldjc6AGBTjXgY
         FVbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773845904; x=1774450704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=67Lxa4BGXjz9Zo1vWHQleC/2O1UPzPcZCuH/+UGL6f4=;
        b=FE+/HoIaz0n8YqKaR1TFc9Ec4AcS9y3kNBSuGIn2SBQqphHB1CDu3bXW2g+v9ZAXV/
         ppcjtg94BeHzfM37u3hBFiIX6JauVqJ7LM/MkvE03pzO+H/H63Uw1BcufqBP7Vjtb0rw
         DjVeTqR97MJdNxNWeowQXj3aK+XiCYmaMPOXJWjq/GzfbG1Uek6NzizDRO9LDOqV44tI
         yccvzalFQ57nuc3I6AXEjTD+DOgSE/w/EBnP7wyIsliz/UcosrRJ0AFWTK8Tf/CDMfPX
         BaDjTtG6IuijBjyCFinDuULKKIH8ZCOG8tO0DNQ5bSNcmIg9zXuj0Zt6s7GRfy3fdN7D
         vlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845904; x=1774450704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67Lxa4BGXjz9Zo1vWHQleC/2O1UPzPcZCuH/+UGL6f4=;
        b=GKWXw8fujzJhhdQmVVGJGjUh5Q4zygv1G6DLSNT8s7Sqzwtga0D/e0UUixW6vGP9LL
         Sj/lSUXyL+YorOyXHdUTPfUMEehU2IK1Yy/0HaLF0c/hDzsoOji2DSe6D0zSNb2LLSFy
         4QsImfVy7oi6ICFYSgvZfoZQwHbvkSB8B+zaNWMVTkeCypIuFrmnW80wFLH0eFI0lfP0
         Jw2rSYHKnEI9z6teIAa15WUgEkQJ2EbbvNZUXQsndHbaU6Sn68/TTB6RmQ476JJQW10q
         kk9iX9isHhOavldVNYB5TFyppKE3LtJ5LMmjZyq0ot+UoBmMB1BMDYeWIXT9aiBqRTdg
         N7ow==
X-Forwarded-Encrypted: i=1; AJvYcCXB9WXqG45hJdoDtf1ENzfojt24O5QwBohfVRthulOpVXhqdq+5JVFWCR4abi7S1g3CVcHA37A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8BEfQuhMw/objuFQMjDiT0fXzcHPA0Oo6hKc0nGeAfKxcjvi
	qJVlMa0lJisBJ9sxHGeb90feCmAukVgqoxAadfMbgxsK+MabGgoSN9qbT6BV2zYKq+WdlijdxdH
	7NzZ6KbYiADo1UzEmo3macG7FvTIHqXznb3+gkXwBlA==
X-Gm-Gg: ATEYQzxjNb9+xRF+l19IXionxyLqS98pKf+4GwHVPeLvP4sdDzx8r3PI8ztVZzw5Mhq
	Ay0H8H77vyiFx+3rGGlof7JYEPJV2MFX7hAbg1p7OUo6RhjJZM2ooWJC0EcL44Mz0+Krr7s+7jI
	8TjKrcM4qVzqDCJM3bpKaKHZKA7KQK2h0cj/QgOXGhpiP28UBhi9R6JGvJ6USkmqAe0dJ3wFVZC
	AFEfnPTtelZic6r6Pz3dOfAVyUrl2As6oXS63mZNO2JwWVMpnBaGakobxhj2+laQ0pEYj0jg45g
	xqWNgsNwJQPfo1dAfxyH0dVnUDgly6L8my9GtiktmQDaaQOak5u6Y1OyeZjMFvYePE8YjL9KNGe
	Hzwkr
X-Received: by 2002:a05:6000:2207:b0:43b:4212:2ee8 with SMTP id
 ffacd0b85a97d-43b527ad12cmr6672969f8f.24.1773845903651; Wed, 18 Mar 2026
 07:58:23 -0700 (PDT)
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
Date: Wed, 18 Mar 2026 15:58:12 +0100
X-Gm-Features: AaiRm53t-9KWev7fdqpI90WAqJrBtJ0EukL_N5dFdMvYQ9imwz4FysyBvwXfPUM
Message-ID: <CAPjX3Fe3J1_JgON6iJBN1KXWUr2cPkEQbdTBp5vQt2zMMsf0MQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de];
	TAGGED_FROM(0.00)[bounces-269056-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 9745E2BE15E
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
> >
> > Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
> > It's pointless to even store it. Shall we care?
>
> For PREEMPT_RT the xmit_lock_owner member is only stored and not used
> otherwise. It could be removed as in ifdef-ed away but I do not care
> enough to sprinkle it and the gain is little (proof me wrong). So I am
> happy as-is.

Right. Sorry for bothering then. I missed the merged commit.

--nX

> As for the check itself as we have now, we detect the deadlock before it
> happens and this is nice to have. The alternative (in case of a
> deadlock) would be the deadlock detection in rtmutex code which would
> freeze the thread.
>
> > --nX
> >
> Sebastian

