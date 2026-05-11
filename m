Return-Path: <netdev+bounces-286826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMT3K5pBAmp9pgEAu9opvQ
	(envelope-from <netdev+bounces-286826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:52:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE5516056
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE7F83008CA9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354773B52FE;
	Mon, 11 May 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNL95gjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FB3B388B
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532756; cv=pass; b=dfuwB3q7GiszGjT3tGa0bRgs1d5+C2LIFU8XFeDHdZXosq0EjbejLYvi1BdCrFcMrKVRwlSdars6je9rhs5CriUB8mVIAHCnFFSoJQJD/JbjsEYZ1TAc4KGQAOnipfLLbM+yxI52EidIiRvXVTt7xg6eoUYA7mS16KI5vj3rYLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532756; c=relaxed/simple;
	bh=DiHWs1sOoiu2X3GZePgpXCTnujQDkMBn+jXMmT4E3Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANRfcrQ6WoE0b7AGhFKl4gAIFF0PjpxPpPs481vxXdM/jDcRiUA0JnnQ2p/YDTL/IjcDm2nvYCQueSve3mN7CZNYSp2FnSf1ArGhW766/kIXkhTbWZ+S62qnelQ3nD/VTXIuE/VVZzIAS+YW0+YJQG9WCE0ss0J/BLh3MvexMdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNL95gjv; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83d31ac4017so1614560b3a.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778532754; cv=none;
        d=google.com; s=arc-20240605;
        b=OdhVUa2PzdPjji3vNnHPq2S+0zeQo+iFRL8cJ5EsPwaVJjPLsnevakLO0+gCOKhEr0
         3NTjvyGjuyX2UeSUB1iJoIUdOnKSkLKPDlDxKmaO7NY2bG3LtBEMYjYwS3HL6l1UUDSN
         UQIIlDqv5kpeJy/SrKYqtiys1/Sbd8Yzztftmk2zlW/4wKg4/kiMxGprdL8N36h8gRpM
         Ih37AnDEYoF1eXl7WP68/mJIscs5szo36o+7d9gCp0CE9XjQqwnSO6ojdsFIM5pt44sa
         mx/KgrU/FFD625qZGHWhCC+oavdEpHq5NmiTGDYveQVd5tx2ZWW6id2mZUNfo65kdOze
         vlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        fh=l83zQuicL9+fKI005cJKIXCK14jvsyh+9kHYRD+hg1Q=;
        b=JaBJG4RGuLT4jaayNabbmhrg1L/Cxe6IHo4ynOx2RVXpM8gkXhJzfJBr6FzsxETdP1
         EB+aSHJcUNo5iHDeL4GIBSwGXFNbYWTmKHdBBpIbEZiV0rR36VwXphgKu9/rxhLl64aA
         hgkiZq+n+ryOFXQfoSQauS1kXDWJtD/+GMmLZj3Ok7r8KdTQK1HVeut7sYARlk5PlLM+
         nI+zJCf9nsf78m9He8G3kv/lCwlDMbVuocOqx7krlSy2vv3iDk31H4UTMytr45ga5VRe
         YXuWBCmNGxxKhbE+npglFQn7tDO5bHJ6LjX7Dwt32VPaBHoU4JKUKOXWO1/IykrytUUF
         /8/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778532754; x=1779137554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        b=KNL95gjvbWQXoawbUCz0Gg17P/zErBroamUNEtu6ucAMcF6gXWEzMI4S4HvYKbMD3C
         apml2UkN5+zj2Ld2qje12S7sXOjZ+h4j71Ou+M8aQ2Nyr7Kd0uU/zCt1ViL0jDNDYR3M
         QmNYjkvu0JUlHXvJ00w3/HjCMo2ou/Ia8+dNmAs82qVSyI1wXd3a/CRMryd1GtoXhpSE
         4hZabtcnSE3sG+G4lcuLorg3wrEb12Xk/l40QaTrI9/amqf9ilHLL6uu9hKPdFR9y9wf
         TqMG3uJUqo+GhNihyFhpWnfEFmXOcrKNNowkVdKOwRe6wpn+M0AfK2iy7dVWZqADjle1
         ExMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778532754; x=1779137554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        b=CLQJG4t3MRex1zb0zPNoqa92BBHLMxQPYjqO8JgTI3SEHtGR8O+vgRnyoYv7QE8YDy
         snoRsx/6M2cC4WMoguw2NEqoktvEqDBMe9kJnf0DYJpk/99jycHyjK1SDh3TapHXrC/L
         IpbAMNQL4JbGZU/KMSjI5tXB9ibwygzFdYm0BN67EsbSslwrkBQ1xNWbAnWNxZQ83Wpb
         h3oHKs1yoDXE0VIxasQWYYKqFWEgb5fjsU4q8DuJO04tfkeP4qkdzN856Sa/T3yipxpa
         a5ZPVKMC6PYKwOrteZB4TMEAmbrBVWu2s+N5ncuFCy/c56maHbQdpDsCX9f8haBID6oB
         jJ7g==
X-Forwarded-Encrypted: i=1; AFNElJ9ewmysjMSldH4j2/pDgneJ829lC/AdxMbQG612rY0FGRH8W371EFCtQQXYuHYpv+6Az4S/EjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVM0iC6HmNkiVSYtoHWeUbWdQUxhUOGPnn3/7HckB55Kw0e5u
	kgZ0DAslEXjt9YgaykWdLBSxwZu4hOcTz4gYBRklcQp/ztREXYNlQ5C3cOjL1yRkDxjeuLZ9BYw
	A38GZiDHsIABmdBT1uyLZoHV6QCJm4P0=
X-Gm-Gg: Acq92OEkyL04MJiU7dxXBqGQ8aXCitBHJWXEPn7RAvT5ty+QI3/dyVGZQhY0L869Flg
	7HbtpluAIZd25ugv1+5h3YIxZ7G4IYB5aVSlAUzb8Si++Gujrc3kqCegzLrkhZck1TTI4mM9D+w
	TI6t0HsdCTS/+6/Idee1onhIYz41QqPAI7llsdnZsp6FbIysii8vSaPH4PbaKruyl+H2IrSZnw2
	TGKgiqfDOkYE0QVnCDPcuJtPK9N1gbEby94eylImmQlDOz5l2O9AbNx63oMlN2dNDwY3GaVXpTG
	zIv+ZrMC1UVPODCkPVD79Sl/h7bj4IxXqR5Zimph9s41vKCeXGoJYQa8JBFuAYrE6whHDR/+Vv3
	s1XOBF5inPJ0TkLip0oKUMnnIzYrbmeHUI7Iur5dW
X-Received: by 2002:a05:6a00:1bc9:b0:82c:d7c4:4c5c with SMTP id
 d2e1a72fcca58-83a5bae02b6mr23896094b3a.20.1778532754053; Mon, 11 May 2026
 13:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508001455.3137-1-joycathacker@gmail.com> <CADvbK_fOduqbZSx7xefbDhDi+=eLmgN8k=Bm+J0tRDrFj6ZYmQ@mail.gmail.com>
 <20260508182044.55b567c1@kernel.org>
In-Reply-To: <20260508182044.55b567c1@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 11 May 2026 16:52:21 -0400
X-Gm-Features: AVHnY4K-4oufZ5Bh_ouYXMsrGsz6Jdk671TfT3bU5bBuK9XkaMlt9GEU6bPpSL8
Message-ID: <CADvbK_f0hTB5rsjNO7Mkg69KqTF2QmCKHNH__JCwS5LtfPgRLg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: revalidate list cursor after
 sctp_sendmsg_to_asoc() in SCTP_SENDALL
To: Jakub Kicinski <kuba@kernel.org>
Cc: joycathacker@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Ben Morris <bmorris@anthropic.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B3FE5516056
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286826-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,anthropic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,anthropic.com:email,sashiko.dev:url]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 9:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 8 May 2026 16:35:21 -0400 Xin Long wrote:
> > On Thu, May 7, 2026 at 8:15=E2=80=AFPM <joycathacker@gmail.com> wrote:
> > >
> > > From: Ben Morris <bmorris@anthropic.com>
> > >
> > > The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
> > > list_for_each_entry_safe(), which caches the next entry in @tmp befor=
e
> > > the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
> > > drop the socket lock inside sctp_wait_for_sndbuf().
> > >
> > > While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF th=
e
> > > association cached in @tmp, migrating it to a new endpoint via
> > > sctp_sock_migrate() (list_del_init() + list_add_tail() to
> > > newep->asocs), and optionally close the new socket which frees the
> > > association via kfree_rcu().  The cached @tmp can also be freed by a
> > > network ABORT for that association, processed in softirq while the
> > > lock is dropped.
> > >
> > > sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lo=
ck
> > > via the "sk !=3D asoc->base.sk" and "asoc->base.dead" checks, but not=
hing
> > > revalidates @tmp.  After a successful return, the iterator advances t=
o
> > > the stale @tmp, yielding either a use-after-free (if the peeled socke=
t
> > > was closed) or a list-walk onto the new endpoint's list head (type
> > > confusion of &newep->asocs as a struct sctp_association *).
> > >
> > > Both are reachable from CapEff=3D0; the type-confusion path gives
> > > controlled indirect call via the outqueue.sched->init_sid pointer.
> > >
> > > Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
> > > returns.  @asoc is known to still be on ep->asocs at that point: the
> > > only callers that list_del an association from ep->asocs are
> > > sctp_association_free() (which sets asoc->base.dead) and
> > > sctp_assoc_migrate() (which changes asoc->base.sk), and
> > > sctp_wait_for_sndbuf() checks both under the lock before any
> > > successful return; a tripped check propagates as err < 0 and the loop
> > > bails before the re-derive.
> > >
> > > The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
> > > loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
> > > the @tmp cached by list_for_each_entry_safe() still covers the
> > > lock-held free that ba59fb027307 ("sctp: walk the list of asoc
> > > safely") was added for.
> > >
> > > Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL pro=
cess in sendmsg")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: claude:mythos
> > > Signed-off-by: Ben Morris <bmorris@anthropic.com>
> >
> > Acked-by: Xin Long <lucien.xin@gmail.com>
>
> FWIW sashiko says there's more?
>
> https://sashiko.dev/#/patchset/20260508001455.3137-1-joycathacker%40gmail=
.com

I will try to verify this and submit a fix if it could be reproduced.

Thanks.

