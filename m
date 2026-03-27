Return-Path: <netdev+bounces-272393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBYRCiMtxmmNHQUAu9opvQ
	(envelope-from <netdev+bounces-272393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:09:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 925DA34035A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9A4B30C7293
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0F3C3C1E;
	Fri, 27 Mar 2026 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="QWY80Y1x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3513C454C
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594853; cv=none; b=ACxO9FG13j1Ve4H1CvAbGV6YEzrbREg1rJ4y92ea1nnyCYJcAcpk00sfIWLsluZvCKxw/vUBZLhSkPiyXtEF9ZL0jDAkGwBaKd/ZeqhzfJJMNDmNPQuyjkCZbuwnMTVamHHErQV5J64IxCTb1ZkMjJQpc+s6HEuWcsi/+tnq7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594853; c=relaxed/simple;
	bh=iZpPLPhnG+WL8IFSEZ2RsP1IRsxY0Otl7kuZB75f6K8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/Uc6q6lKzcaDHN1LHkeqKX01U5RkC0s+kL9+dg4uSKGJZuzCbn0bqWeh5wnPfPZTdlu9gsBDBGtQbjmI7pE5uKnehEKjEX8rM25tf/lN/XzlX9JuA+OzPUg8kiBLBse2/oG52bw2QBFK5/wPW/1udiTEIIGSxV3q2IcIZ4tB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=QWY80Y1x; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail3; t=1774594828; x=1774854028;
	bh=RqFAwwHXCq5QHHJwYrWbvjP+wvgfLAHeNklW8eod/YE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QWY80Y1xbdpYALcavtbnj3dltrvNL0GgwURMC+n2xbWS/oxkt7wghpqx8js+Br73H
	 ++Yl2asErZ3A/4dATuX2TmVLUgQ+G7/RAb9QjJlof3f4zgBtUcGR5bIXT0VEFlDAyz
	 7Gj0yp9lu+hmmGP8+27yR37lIx1w/apzcHnDnSOB0tFhWdHZGjK6BYPK8zRy77HdFq
	 3nAsvskZPOz1Dffa3O6hkjs7QVf1t7kzkewSJmx1oe/wizo9x8NB/g4jlCpSb0+0Dw
	 Zx0TZtmifRE20xOLwEhSPAQirQnuCgfof9u/bS8L/xvedkfH53UZlXwtq6drKTyn/4
	 uFMv42Q9VRaGQ==
Date: Fri, 27 Mar 2026 07:00:25 +0000
To: Stephen Hemminger <stephen@networkplumber.org>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Savino Dicanosa <savy@syst3mfailure.io>, Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] net/sched: fix packet loop on netem when duplicate is on
Message-ID: <HPVPuSe3pORacfqRIDROAEbDFMXFtv21uXO2yWRscO9Rc6COzB9muXRwhkN-Y9Rc34maCNnoVWrHdwFOd0G08e-T21126fEzb2TMDCj5F-c=@willsroot.io>
In-Reply-To: <20260326181701.308275-5-stephen@networkplumber.org>
References: <20260326181701.308275-1-stephen@networkplumber.org> <20260326181701.308275-5-stephen@networkplumber.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 3308c582f0b790d071faf19032b8c241f563c9b2
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[willsroot.io:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272393-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[willsroot.io:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@willsroot.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,willsroot.io:dkim,willsroot.io:email,willsroot.io:mid,syst3mfailure.io:email,networkplumber.org:email]
X-Rspamd-Queue-Id: 925DA34035A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: William Liu <will@willsroot.io>

On Thursday, March 26th, 2026 at 6:17 PM, Stephen Hemminger <stephen@networ=
kplumber.org> wrote:

> From: Jamal Hadi Salim <jhs@mojatatu.com>
>=20
> When netem duplicates a packet it re-enqueues the copy at the root qdisc.
> If another netem sits in the tree the copy can be duplicated
> again, recursing until the stack or memory is exhausted.
>=20
> The original duplication guard temporarily zeroed q->duplicate around
> the re-enqueue, but that does not cover all cases because it is
> per-qdisc state shared across all concurrent enqueue paths
> and is not safe without additional locking.
>=20
> Use the skb tc_depth field introduced in an earlier patch:
>  - increment it on the duplicate before re-enqueue
>  - skip duplication for any skb whose tc_depth is already non-zero.
>=20
> This marks the packet itself rather than mutating qdisc state,
> therefore it is safe regardless of tree topology or concurrency.
>=20
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Closes: https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc=
1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=
=3D@willsroot.io/
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  net/sched/sch_netem.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 0ccf74a9cb82..6086700eb1e7 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>  =09skb->prev =3D NULL;
>=20
>  =09/* Random duplication */
> -=09if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->pr=
ng))
> +=09if (q->duplicate && skb->tc_depth =3D=3D 0 &&
> +=09    q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
>  =09=09++count;
>=20
>  =09/* Drop packet? */
> @@ -539,11 +540,9 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  =09 */
>  =09if (skb2) {
>  =09=09struct Qdisc *rootq =3D qdisc_root_bh(sch);
> -=09=09u32 dupsave =3D q->duplicate; /* prevent duplicating a dup... */
>=20
> -=09=09q->duplicate =3D 0;
> +=09=09skb2->tc_depth++; /* prevent duplicating a dup... */
>  =09=09rootq->enqueue(skb2, rootq, to_free);
> -=09=09q->duplicate =3D dupsave;
>  =09=09skb2 =3D NULL;
>  =09}
>=20
> --
> 2.53.0
>=20
> 

