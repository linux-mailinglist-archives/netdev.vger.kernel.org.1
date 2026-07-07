Return-Path: <netdev+bounces-305387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KntKAsTJTGoupwEAu9opvQ
	(envelope-from <netdev+bounces-305387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:41:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA1719E7C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:41:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kjExUrcD;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305387-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305387-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0007E3002500
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863F3B1017;
	Tue,  7 Jul 2026 09:41:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12072C0299
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:41:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417278; cv=none; b=oLcgvno0o8BQS1qM56k+WkrPxrFqLoQ0R+83v1gYpRwgkVax1Pgx+xR1UOMIYYHurXNOiEJe/a7qzzrJ9OovF3wABSjDTwVjFvPxS+7DcHdRIogk2gVVMBZFGfth30ryBiC9tDyIWw7OBOIU8P2ZLdmmcsU4xrkRH01ijAzEBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417278; c=relaxed/simple;
	bh=GPdHdqWRNzRZZchJQ9wPXni8dJdU+/hQXmvi8Itk7Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4znpBhpFjOkpF5TofGGTRZW0PH7ubtnfuw2NKhuc5gTpbnUnWxTmNjVKBZDq7YZJmUZs6ao1OyCIsVVfIEUXDMLnNVpVqITNvZOekpsxFOklsoL8EiCbcgXuwL6DcAZLKjQ9JpzK0VM0VaDY1Gr+m9Qt1Rl6bHb6e8B8USR+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjExUrcD; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so25661005e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783417275; x=1784022075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZUJruZyrJKIs3f2D7Ek0uWfUfy3QKwkxgMqXzof9SI=;
        b=kjExUrcDAU5ADPZsKh7NEJYJULtzAEkgablAbNoWYvKBMeRW4x0BXt4AppaLnTtVFT
         vYSGrinF2AbF1w2ppuMdQuMvEMgSd5ha9D53CBOAwpo3iAOE0bJ1iMNlXNE6IG/tafmj
         vRdvwdL0m/iR8a2ssEne4b5/7pWSrYhlKgopkIHrawI6Lk9l/V2trA03GNmsAHMWKrkT
         uK37MIYq2mWDYRA6Mvej71W5IrgEb9Sv/Zj/UIItah2HP4GZ2WpIfMCflUCY5WrX4mVJ
         Q61UIvdV3fedtsMOhVK2+4BbRdJHOw5Z4eO+S6g2RXydNn9dyxjXlVvoYeLVVlOzgiK9
         gAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417275; x=1784022075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZUJruZyrJKIs3f2D7Ek0uWfUfy3QKwkxgMqXzof9SI=;
        b=dHXfxT8MnvrZ3kbuNP8+Xo5MCD4sMseVP3js2AP0+QurC/JimA/9BZJ8hFXMyQGrC9
         9AM8LRAOyZ9ohizOXbDWxFy+tphuy+Y008b8a/oboG3fmwWcf7aozIKhDY8pQlLOFtBb
         5JWwJSs4N4hBiwxbqnZZ2YpuO4pYMgzwxUEtbRZaBs6tVA4fLaj+E7EO6xrwEEr2XY88
         eGaNuE+CNlLbwBhqfbaljTsbfNsRX3suoXPY0zRNOj56zxyxHTNCLklfCoZDnYOcjn6h
         pANzZtpQFghNlVoKSJMsfypDyTpcFohWw3QBe5EQkbQKlMEOekT7KZ36TcbMWEJtgOft
         TOSw==
X-Forwarded-Encrypted: i=1; AHgh+Rqdu87UvMmKChw0fHCcRPvGBD5p0k/CgK8midjKXXrwTFHIfUWSVB8s0aF8JciiJYqlyZNBe3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFT8hhVeBoOT0f0gPSKBxvl9YWz/LlGpa4Erg5uaz+QziI4O7a
	+ijvPeAbbEjjrAyXzL/V2nRP6ILAjLCizZSjEPjsSAn2fh8rbs0scbc8
X-Gm-Gg: AfdE7ck+IVus1VWg2vnX1i14uZp2NAYLcSOoP5DlssNQfxt2C/QDrijzvrxwsZd17Fp
	QWKXrDd7BQxaj8Pc00a3vOezgrt+kxk3IDx9Pufz6PVSFeo7LzvbV3wlvYmtcTwmb3pjz7hCpb1
	5I6EMfx+IzQonKUKBBdE/SSFaIWCZNbLLAw3myrHlJYBvTJ2uBlifNyZtuU2dxUXqNOVjr2msR/
	CfbVA4joUevsVoO+HZ3Rf9xINO4KC6e04vzHuqBvzUfEdwFfrvfBWA98RQSpPPiDSOlUrvqEmsZ
	G6y0BHQLUhUNRoUbgWM+XjsRqyklUT3WTNLj11yswHhvJBolnKJZ5vEr3AlN5oGvYIoZRLJpzg3
	On6b9G6ZlbvhcQ4J8nBZaweD7XarMYHyARZbIFkpwqoUBRrlQ7D3CoJU6fHX2PqYsAoHEOf8TQZ
	jTkjTg+nq7vOCxY/7gAtDNYYs4/FHShTT7yqVjSx9cUzxX
X-Received: by 2002:a05:600c:4585:b0:493:bc4a:fb55 with SMTP id 5b1f17b1804b1-493df09e3cbmr47373745e9.38.1783417274421;
        Tue, 07 Jul 2026 02:41:14 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm49184435e9.7.2026.07.07.02.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:41:13 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:41:12 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: sdf.kernel@gmail.com, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com,
	john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com,
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	song@kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akzJt4jua55mpUgA@gmail.com>
References: <akwTnnSGJpki9hAn@devvm7509.cco0.facebook.com>
 <20260706225047.1684039-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706225047.1684039-1-kuniyu@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305387-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:song@kernel.org,m:sdfkernel@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,meta.com,linux.dev,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFAA1719E7C

On Mon, Jul 06, 2026 at 10:50:33PM +0000, Kuniyuki Iwashima wrote:
> From: Stanislav Fomichev <sdf.kernel@gmail.com>
> Date: Mon, 6 Jul 2026 14:02:39 -0700
> > On 07/06, Mahe Tardy wrote:
> > > On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> > > > On 07/06, Mahe Tardy wrote:
> > > > > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > > > > sending data. This provides a mechanism for BPF programs to emit
> > > > > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > > > > socket types with IPPROTO_UDP protocol but could be easily extended to
> > > > > SOCK_STREAM and IPPROTO_TCP in the future.
> > > > > 
> > > > > The API consists of six kfuncs:
> > > > > 
> > > > >   bpf_ksock_create()   - Create a socket (sleepable)
> > > > 
> > > > [..]
> > > > 
> > > > >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> > > > >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> > > > 
> > > > Since you're doing only UDP for now, maybe you don't need bind/connect? The
> > > > kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).
> > > 
> > > Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
> > > and mostly added the args checks. Another thing is that send is simpler
> > > since only used on connected sockets, so you just pass the struct
> > > bpf_ksock and data. So on one side it would simplify the current
> > > UDP-only API for now by removing the kfuncs but we might need a more
> > > complex send kfunc (something like sendto).
> > 
> > Since you were targeting bpf_netpoll_send_udp originally, maybe sendto
> > is a better fit? You get the payload and the destination and you
> > bpf_sendto() it? We can later move to stateful bind/connect if needed.
> > 
> > (mostly coming from the pow of minimizing api exposure initially, but
> > not a strong preference)
> 
> +1, small start would be better.

Okay I feel at least we can confidently remove bind for now. Indeed for
netpoll it was kinda obvious that it was going to be sendto-style but
now with the sockets I'm unsure what's best:

As Amery Hung wrote in a parallel thread:

> [...] but connect() + send() make sense to me. In the stated use case,
> the dst addr probably doesn't change often and I think avoiding route
> lookup everytime should be a good thing.

Looks like there's benefit to both approaches, I'll experiment.

> > > > >   bpf_ksock_send()     - Send data through the socket (sleepable)
> > > > >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> > > > >   bpf_ksock_release()  - Release a reference (cleanup via
> > > > >                          queue_rcu_work since sock_release sleeps)
> > > > > 
> > > > [..]
> > > > 
> > > > > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > > > > kernel sockets that may exist in each network namespace. Out of
> > > > > simplicity for now, the settings is host wide but the counters are per
> > > > > network namespace.
> > > > 
> > > > What is this guarding against? Rogue bpf programs creating too many sockets?
> > > 
> > > Yes. AI review raised this because users are prevented from creating too
> > > many sockets by bumping against the max number of fd and this would
> > > allow them to create way more sockets. I kind of agreed that having "a
> > > limit" on resource creation would make sense but maybe it doesn't and we
> > > can simplify this!
> > 
> > I believe even the kernel sockets go via lsm layer, so this enforcement
> > can be done in an lsm bpf program. Seems like that should be enough?
> 
> Right, I don't think the per-netns limit is useful for CAP_BPF users.

Ok, agree, let's remove all this then for the next version.


