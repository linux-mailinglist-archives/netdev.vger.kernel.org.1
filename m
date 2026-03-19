Return-Path: <netdev+bounces-269243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBEiNIxMu2kOigIAu9opvQ
	(envelope-from <netdev+bounces-269243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:08:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EF42C4472
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9433092085
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B72701C4;
	Thu, 19 Mar 2026 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="vn2GADrR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8512CDBE
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882505; cv=none; b=qOJ/oqPP6MetCnLmwPXY8ZrZC5awqkZCUMQrOIIQa5lNjyuzsx0owoFWWmERu/A0eS4cSGLBYt+kwo+x6IUqbj7DU7wpL8deosOZuCSPdsRwGljpdM/g9x7PMwSwTTi5E3HTxivYzvWdACyuye+she0G7VkWHN1w1ZGHDEshuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882505; c=relaxed/simple;
	bh=daaO09sCQE6lxwxfD/SD2ckwEzRVornUyv8HrMxdbTw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbRgIWWw8lxfp9spd+jyyJhkaPutTtzssWWQHmIIK/AIQPme7pf34oa7D3boTF+cFoegDq2mnCRhvq7doc/JBNZMvUMYyN9VNVCtvMDNdr2lzAchrJuI9YTtHcqbJxQth5axUtEu7kUYHyRwyrcNnb30V6ObX5/qKnnp0qyHPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=vn2GADrR; arc=none smtp.client-ip=109.224.244.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail3; t=1773882494; x=1774141694;
	bh=daaO09sCQE6lxwxfD/SD2ckwEzRVornUyv8HrMxdbTw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vn2GADrRMeYoxtET2Z4Mmm2lonPa/H2EEe+eYecI//hwnTll876uvl7g34Fv2ZGVC
	 0wTLDFpx2iyCVVXOf/9ikaqT9xzg1iRkfwli0BIT/hEdQvfmTH0qvUhFi10Wa2JOgs
	 eznkO3pP4DKEvIB66sKr1cfpLXoQl05A1OAC5qKM9eDh1cMlJSXw/vEYNQspKFuZCd
	 NdATgqERs4yAvR303KkVKZxG0RLjN85rkMbyzPNTb/0cBeObVDvpAIlqwINC6hVNMY
	 Mc3dqo0RJJfZsb0Hxqq/JkCBl/RwR71U9107fKPdQvswAPyQFq3xxWjJeOiowcLBZh
	 qc5E3lgLX97og==
Date: Thu, 19 Mar 2026 01:08:09 +0000
To: Stephen Hemminger <stephen@networkplumber.org>
From: William Liu <will@willsroot.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, horms@kernel.org, Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, xmei5@asu.edu, Pedro Tammela <pctammela@mojatatu.com>, Savino Dicanosa <savy@syst3mfailure.io>, kuniyu@google.com, willemdebruijnkernel@gmail.com, "toke@toke.dk" <toke@toke.dk>
Subject: Re: [PATCH net v2 0/6] net/sched: Fix packet loops in mirred and netem
Message-ID: <nVeJx3lkqagLnJx-KhLkE1taalQfRE-fcMwdIqwp3f_17TNQWu8iBQuRgPmFpzrdoELP0jlZ2E0gAsQwU9jVQOhnif34OWrT25P63S4Qy-g=@willsroot.io>
In-Reply-To: <CAOaVG17Jp8QB_=r3-eWM6bvrLAixFuj+wYB_zv5+OZfiY0LyYA@mail.gmail.com>
References: <20260316211052.332383-1-jhs@mojatatu.com> <20260317163633.0c69db62@stephen-xps.local> <CAM0EoM=3W7OMiBgGBiGKWxqtC1dKWJ4_Jb6cLq9KwamwR5aQ-A@mail.gmail.com> <CAOaVG17Jp8QB_=r3-eWM6bvrLAixFuj+wYB_zv5+OZfiY0LyYA@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 16d3fc8e9826b109149685092d74e0fec86ac848
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[willsroot.io,quarantine];
	R_DKIM_ALLOW(-0.20)[willsroot.io:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,asu.edu,syst3mfailure.io,gmail.com,toke.dk];
	TAGGED_FROM(0.00)[bounces-269243-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[willsroot.io:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@willsroot.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,willsroot.io:dkim,willsroot.io:mid]
X-Rspamd-Queue-Id: 22EF42C4472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I am of the same opinion as Jamal here. If the root cause is addressed, the=
n I don't think there is a need to add additional restrictions because of a=
 past bug.

On Wednesday, March 18th, 2026 at 11:16 PM, Stephen Hemminger <stephen@netw=
orkplumber.org> wrote:

> Only want to block duplicate flag, all other usage is fine
>
> On Wed, Mar 18, 2026, 12:41 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > On Tue, Mar 17, 2026 at 7:36=E2=80=AFPM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On Mon, 16 Mar 2026 17:10:46 -0400
> > > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > >
> > > > We introduce a 2-bit global skb->ttl counter. Patch #1 describes ho=
w we put
> > > > together those bits. Patches #2 and patch #5 use these bits.
> > > > I added Fixes tags to patch #1 in case it is useful for backporting=
.
> > > > Patch #3 and #4 revert William's earlier netem commits. Patch #6 in=
troduces
> > > > tdc test cases.
> > > >
> > > > Changes in v2:
> > > > Do not reuse skb->from_ingress (which was move skb->cb)
> > > >
> > > > Jamal Hadi Salim (5):
> > > > net: Introduce skb ttl field to track packet loops
> > > > net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred l=
oop
> > > > Revert "net/sched: Restrict conditions for adding duplicating netem=
s
> > > > to qdisc tree"
> > > > Revert "selftests/tc-testing: Add tests for restrictions on netem
> > > > duplication"
> > > > net/sched: fix packet loop on netem when duplicate is on
> > > >
> > > > Victor Nogueira (1):
> > > > selftests/tc-testing: Add netem/mirred test cases exercising loops
> > > >
> > > > include/linux/skbuff.h | 2 +
> > > > net/sched/act_mirred.c | 45 +-
> > > > net/sched/sch_netem.c | 47 +-
> > > > .../tc-testing/tc-tests/actions/mirred.json | 616 +++++++++++++++++=
-
> > > > .../tc-testing/tc-tests/infra/qdiscs.json | 5 +-
> > > > .../tc-testing/tc-tests/qdiscs/netem.json | 96 +--
> > > > 6 files changed, 674 insertions(+), 137 deletions(-)
> > > >
> > >
> > > I would also like to add additional guard rails here for netem, and y=
ou
> > > might consider the same for mirred.
> > >
> > > 1. Do not allow duplicate option outside of root namespace.
> > > 2. Cap the duplicate fraction at some rationale lower bound like 25%
> >
> > I never understood that logic: don't allow root because it might cause
> > a security bug?
> > here's a different view:
> > See: https://lore.kernel.org/netdev/20251201162524.18c919fd@kernel.org/=
#t
> >
> > cheers,
> > jamal

