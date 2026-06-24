Return-Path: <netdev+bounces-301763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hJFrGrgmPGpJkggAu9opvQ
	(envelope-from <netdev+bounces-301763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:49:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710F6C0CC5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:49:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ory6o4KD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301763-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301763-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5203F30074EB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF52E22BD;
	Wed, 24 Jun 2026 18:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD01AAE17
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:49:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326962; cv=pass; b=W9vDEEEZdtKCDc4IqXfdskge8GJSFmvPHwgN0zbAiiJhb1aBFTZoTXG7VrWSFEtM2JwxDC20x3vSQ9ZAZVp0HwKIO7bjpqEAzda8scxsjIYh4tPayngf6dnYqCacCY1FnpcGkNkCLdnz5l4p3FOjqZozxppt0O+HZlNYrPZsuII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326962; c=relaxed/simple;
	bh=oD3gRk1qW6iU1+VbKUzzR6OF3bHP4V/ELUR7nNFHnzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWpfSXgWa+gIVScZ4kujv9/uwnUwMVb6gQWnvYqT/dbQwhNttRr3CoMGkWahuSHqLXxtU51MB0xHdqMaVJXs05dAxGD5n0UAm+ENSVxRFwsr1ncHkBqto+OOQCI9WDnkcXVIfPY2OiOLANGkQOzQhmvCm+ceAqUm/ISbMEcG9LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ory6o4KD; arc=pass smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-519f758bca6so9391641cf.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 11:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782326960; cv=none;
        d=google.com; s=arc-20240605;
        b=jV2EoJ9OMnA0VSDhlQN5RISQxtkQs4yWn31bbe9C+tltsKNsLbVhYEA7McpbCQUW1f
         NQusvnu6gld4BbwnrRWtyD/yT4QE9T7JT7aRX4pEFk1jWDUPQA/bqCSD0NsBc1loFTIi
         KX4LEoZRCVOGQzZdXgIerdPyT3Ba9KTXFMyZJxSa/QSa9jYgZO0/YnaxERQqjWpuhgmA
         pCTH2L5xb5hdMCCdYEdvLBUdiSuWRWIkfqdIfYD9qkwCSYEw4y0nkTUmx6VXbPekx/xT
         gXvS6zh/qC22u/+dqn0Xt5biyivVT7a2mKT9XmnJH5SSbD2OEnayaFCTYnSpUvXXeALN
         fLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5In/bor2ZVADOwD7Q09MjYvIBRr3mCSEr0x7UF2Z3I=;
        fh=7HzXczMsTuC5PgqXHECYz9SL4a8r5WWrCLW6NqX3HrM=;
        b=LsXdY0RDH+S8/SK6YdSBym1s1703rvn99qaTruWSG6+njFew/v5qAHYWWXjpt+/lzv
         vwbnnhjZjdGj1SmibUHU94CjfandJnLWpg/iIcNWZYnEyo+6T6nQF5v2iHVXbnyz2prA
         K5erYNnQfOlMyArxPLoz8jg+QAHB6dpTua/bPR+oZOgM0P9KTpl24Y4i1oOczvXRLmF7
         fUoi581O41lXjn9BE28EbG35K7sdmbwXzCD9vtWhJjxoQBJC/giwqEhSNJRPKozc0i8v
         0Z3D6z/sedbkdDZT+EvrFKzEpx8Mvwkflt/XbpNUHE8ARQsqLsE3TnZDRkDUFEn+Zn9y
         ps9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782326960; x=1782931760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5In/bor2ZVADOwD7Q09MjYvIBRr3mCSEr0x7UF2Z3I=;
        b=ory6o4KD0hHkbZCaZz54jk9fjAncxzLLt7McmeCr+Ihy3N94eYiu5PkO2zmHa7MH5M
         6qLi4kohShqBu+hJeYhsmnh72ez+4gVzcgQIpV25ZIj+C/muXD69Od0qde3BlO0Xr9Ft
         BinnDobyqc/UxSIEKSbOCO1xxBXWENVWz5dI3JDtBgf1Tt6o15rtWugDQexfvG+1zQi8
         DW2+tjYHvBCFd1kVmE5VK6OqEg2JWqdHKinWRvwcpVbZNdzPxCXSGc3ZzV9A7FZNCsj9
         bWqPL9b/v7mkkqJL7OA2TLgB/fPQVgRgUI8wMrB1IImRSAUzULWk3QG/7oGF7zGxrlqG
         LN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326960; x=1782931760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5In/bor2ZVADOwD7Q09MjYvIBRr3mCSEr0x7UF2Z3I=;
        b=sGRZaRPFvMA1JKbnlQBWVtm2Q6EnVXP5/2RAM7CoQvFxdZc3/QnBnPz0QRSm05XMQK
         t695tmqiadOtveUyZtsPq69nIYLO9Nl7zEr22QhFs5tBuEtMLQEDmX4r2Cs9zBmpzKXT
         fImCTmJyJFvZow3IbsF+QfypdnUQcnzZdPi3O5cQu5HkzQPbFYic8UQyHDTK/UJ8s1qI
         1y747WkfmHDB6F4iz8Oy1j1/50UBDc9p/CxdjLb7U+LyHi+x5wxKf6o+mfWhq430+RJU
         xWAydIlZNEpKHw8CjQ3IKxqOOkMi4yOXgg65lnc1J1hBV85v7rs0Pd+r4Hvg5xTfOVdq
         p39w==
X-Forwarded-Encrypted: i=1; AFNElJ8N54f9aDhRbFoeQ6LD2Be1Z4Cng2Ein+/ojj9WwV2Vt/KU57O+jCAUVpiRmYfSkVOBKmYJ4og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92LYzp/6Vlp21qbp7QrLXjRttm9Q6e7AK9ojRybhZoo1OGXWc
	POeZrAtyxS5S9VdqbYAWX54v+SEj9CJNwQbMxDbWXTaFyi0KcDn4IanArgHKkpEsthSo186hVC8
	ChrMHcbZKjCSy5Gob5fEcENoXvxnaTTLTOEZDUTQj
X-Gm-Gg: AfdE7cn6drQ/R7TXKqYBAJm/mZGPQxr9OapaguksZLo8qJTzXbxmYT/uIskF6r3U24P
	Q9YdH+S9hOj50AMLKGriDn4blG1fUw3dqRyzm39oygAZ4KwTduIx70UrbFrPlm4HY8CjivNCqMd
	l3/pmaGWWM3N/S1lZ+yL+4A5eZsYvZ+qOp5BN5AWMsCGnBrgNpY7I/IsccemwWCSTmlTuPjM/af
	dcV+gO8xDXWS9LM/FdP18dP6eCi+/DUQCdTRR1Zw0Yg6qP8F90XztXUiM3V4g4VOH8XKQ/ySJMT
	t+RQp1FsdMvlnpQc5NBxdrEO8poxKP3JHC4aeK/cAtAkqmdLTVaJQagoCWuyHYWSA9S7GKCfG8d
	iBrQCrkPw1OKUiJrzxa1M
X-Received: by 2002:ac8:5709:0:b0:516:df59:32cf with SMTP id
 d75a77b69052e-51a61d30e29mr67692301cf.7.1782326959534; Wed, 24 Jun 2026
 11:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623173030.2925059-1-edumazet@google.com> <20260623173030.2925059-2-edumazet@google.com>
 <CADvbK_cnZmZkzCUxGEi=uaBug3VcfUd4MiAzQp1OGUsnvau=xA@mail.gmail.com>
In-Reply-To: <CADvbK_cnZmZkzCUxGEi=uaBug3VcfUd4MiAzQp1OGUsnvau=xA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 11:49:08 -0700
X-Gm-Features: AVVi8CeWeRHoUbG7ZhiTtsvNvoVvDAWDR9erL7dgo0hjyCIgIVTmIrqrRmHTwQs
Message-ID: <CANn89iKeS7PzwXKL9aV3-EQQD-w8ZvoPcn0Ot7n5NyWcyWud7A@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] tipc: fix UAF in cleanup_bearer() due to
 premature dst_cache_destroy()
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Jon Maloy <jmaloy@redhat.com>, 
	tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301763-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lists.sourceforge.net,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5710F6C0CC5

On Wed, Jun 24, 2026 at 11:37=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> > diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> > index 988b8a7f953ad..66f3cb87a0aaa 100644
> > --- a/net/tipc/udp_media.c
> > +++ b/net/tipc/udp_media.c
> > @@ -803,6 +803,14 @@ static int tipc_udp_enable(struct net *net, struct=
 tipc_bearer *b,
> > return err;
> > }
> >
> > +static void rcast_free_rcu(struct rcu_head *rcu)
> > +{
> > + struct udp_replicast *rcast =3D container_of(rcu, struct udp_replicas=
t, rcu);
> > +
> > + dst_cache_destroy(&rcast->dst_cache);
> > + kfree(rcast);
> > +}
> > +
> Since this adds a module-specific callback rcast_free_rcu registered with=
 RCU
> via call_rcu_hurry(), is an rcu_barrier() needed in the TIPC module exit
> function?

There is one already, this was one of my feedback for this patch:

commit 1579342d71133da7f00daa02c75cebec7372097b
Author: Weiming Shi <bestswngs@gmail.com>
Date:   Wed Jun 17 21:57:45 2026 +0800

    tipc: fix use-after-free of the discoverer in tipc_disc_rcv()



> If the module is unloaded, the RCU grace period might expire after the mo=
dule
> memory is freed.
> net/tipc/core.c:tipc_exit() {
> tipc_netlink_compat_stop();
> ...
> pr_info("Deactivated\n");
> }
> Could this result in a kernel panic when RCU attempts to execute the unlo=
aded
> rcast_free_rcu function?
>
> This sashiko report looks legit.
>
> I think synchronize_net() doesn't guarantee rcast_free_rcu() to be done.

