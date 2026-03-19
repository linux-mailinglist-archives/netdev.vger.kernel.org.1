Return-Path: <netdev+bounces-269249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GChnOrtQu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:26:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5C2C466A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A406A3004C94
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD602727EB;
	Thu, 19 Mar 2026 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="urzHkL5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0BC28E0F
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883572; cv=none; b=s/WiJOHWFaQtN81pRyNG5Km+UGnyUZL484uhh1Na0QEJlp5kmB11oc8cP+gbgBANOe2Dj0sNiupUT+JQWaWllq6LxDxnfeDGul6kFdYWRFouw1jx0cQHv9nbZkQzX/00YngGhOSKEendnYxeLhL4+IXVl0FOzna7yxiJ4Y+Rpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883572; c=relaxed/simple;
	bh=ez+bM0XPMd241yMUfBgOsj0aOUZktRDgV8k/4Yz9J+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8XKsxyYDSVXhTMoJn6OKXfoMx5DVNiyOyUk1DdIvf5ZiADwRVIBREF4ujphdJS4e29fGLeoj3jzah8ELef73aGkfJV3XZBxfbpZtQ50zLNEV5Ure9+XGAkRv41dO5A4ijvd6OA97bYT8TuzQg3NokFTAQMaW1wCagVkdfMzT8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=urzHkL5X; arc=none smtp.client-ip=109.224.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail3; t=1773883563; x=1774142763;
	bh=XJ8kz5dAluCxs5y+zIv8gXsvYHyGqruSUQITcq/K6mI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=urzHkL5Xhu2HZSga1cd7cUKfGLAQpDLBM5ETRIl8f9muEoMmnozaFdU8Bf6qVc8KS
	 EfsVwSPLafGVu+AmwcYVJdrUhlXSX7sAjmbrrxpyfoWi7zCrackuTwSDwNRa1+cyhx
	 h53sW/qrHwrc8nfVrZkhVtYq92/S3LiA9NTUhcfxuw8Xbw887itQMGzH4zbzB5JXw3
	 +0yRTODyaxNj8+vLjpCY/oFwjwNt5mnjqBpDf6nC/WPWQLgDqunVOhc3zI9ehxdoLV
	 DpwBHgUteeG2hQlbOGq/TbVQOhEwW4za56DxjaYmp/fG3GO2Z+kGP+UpMDd8KXFsEV
	 81X4j7rFkXfEA==
Date: Thu, 19 Mar 2026 01:25:59 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com, xmei5@asu.edu, pctammela@mojatatu.com, savy@syst3mfailure.io, kuniyu@google.com, toke@toke.dk, willemdebruijnkernel@gmail.com
Subject: Re: [PATCH net v2 5/6] net/sched: fix packet loop on netem when duplicate is on
Message-ID: <EsDe28RrNQr1KI6OSdjyA2kOYQnj2CqzSDd3lga9Epk_wzttTU6-pIzhVrZSFdqZqWZvIU_Z83b05OwNrKMhUlyrSlNoV3YaKYY1azzHph0=@willsroot.io>
In-Reply-To: <CAM0EoMmso3BeWwBd_6tWPhPqTiZ=4ZywNuMeWxuvgZADXd1OUw@mail.gmail.com>
References: <20260316211052.332383-1-jhs@mojatatu.com> <20260316211052.332383-6-jhs@mojatatu.com> <20260316175705.2ef5004e@stephen-xps.local> <CAM0EoMmso3BeWwBd_6tWPhPqTiZ=4ZywNuMeWxuvgZADXd1OUw@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: bccd3c7487583e548e5b7d08fcafb93c3622fd19
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[willsroot.io:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269249-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[networkplumber.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@willsroot.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[willsroot.io:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[willsroot.io:dkim,willsroot.io:mid,networkplumber.org:email]
X-Rspamd-Queue-Id: F2D5C2C466A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wednesday, March 18th, 2026 at 7:34 PM, Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:

> On Mon, Mar 16, 2026 at 8:57=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Mon, 16 Mar 2026 17:10:51 -0400
> > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > > --- a/net/sched/sch_netem.c
> > > +++ b/net/sched/sch_netem.c
> > > @@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, str=
uct Qdisc *sch,
> > >       skb->prev =3D NULL;
> > >
> > >       /* Random duplication */
> > > -     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, =
&q->prng))
> > > +     if (q->duplicate && !skb->ttl &&
> > > +         q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
> > >               ++count;
> > >
> >
> > Would prefer that if ttl is exhausted packet was dropped.
> > Rather than silently not duplicating.

I think silently not duplicating better matches the semantics of preventing=
 duplication of duplicates, which is the goal of the fix.

> so return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>=20
> Note, this is a change of behavior, no?
> Actually - when i was looking the first time the bug got reported in
> my view the bigger issue is when
> skb_clone() fails (which happens nastily when you have that repro from
> William). Unfortunately, the surgery was too big so i gave up.
>=20

If the GFP_ATOMIC allocation is failing, we are in a serious edge case and =
the kernel is in trouble anyways so the current approach of null checking s=
eems reasonable enough.

> cheers,
> jamal
>=20

Best,
Will

