Return-Path: <netdev+bounces-272968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5F+GHPVzyWmxyAUAu9opvQ
	(envelope-from <netdev+bounces-272968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:48:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9E353A58
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8246C3013262
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB6837D10D;
	Sun, 29 Mar 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vL4XsAZE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034982D0605
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774809542; cv=pass; b=CKEmRXmClszhTYW5RvEekoLnYvSp6gClLsyvPt6Yu1LjoYmZFSOPlxkvjxwA5JZy6LZnMUNiBRx9WG/du2xFKLE6mG41RArNQ+0x+83bEi3JFHCVyBfCJwd0zLkGQGawmxufkMy8E+wXGloqRws8uI0XTNXM5tQfz1Y7oTNHjl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774809542; c=relaxed/simple;
	bh=xe5/Vtoag7mgfun/0o5FWuv4f3z1Q1L1K1Gn6U+vpMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HO29QgmWWYkL6iLRFh6m9vGqfoJtuXBJnU1jThbGu1QTMEMsaz+J1v/1X6/qzuj7vYtlEg8txAMc5HAglp4xQveqSWblJPRwe7PN0evqiyXCYzYNT7SKW49y1zLj/atzviETzfJEJ0osjUl2t0kDI1hEaTR2bgkuGEJL3eyrCxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=vL4XsAZE; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829781b2b01so1883479b3a.2
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774809540; cv=none;
        d=google.com; s=arc-20240605;
        b=DHAV7Jq3ROPVXI0cDZqnUf6ClnYCG8ce8Anotz0zEtjw7DlFp4XomtdnthZ9uTBJvM
         PxiKt6yBqysjEXFHjzIPCbHdvO6ioLQ4y4Da5Pv75sZJcC4y2QkzoH37CQ3DzbIP/XEQ
         B0VKoOnGIqlNyaW7aF/qgjiLet9pzfUJZE7/E9FWX9klGXoBTNGbQ5J0gZn1AVPlP2eL
         tPNkac79weaCRpacK3aa9OlT35FrX87olcfDLzczuf1H/on/aeePrgnLbthqbPqAMGqt
         RUQFhFOpUri+bNT5hga9zVCTPMMjK1we8cGh/ezRaZDFiSHFbNjUhsTyfC5YTlxU+luk
         Wa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/kM/klYNxQTa/jKkVxX6iEYp4a5igRkkUKILujaDgs=;
        fh=+rE2DrVikgLBcW3NtnLZAqqCjcRTzemWzdbKuUivOrM=;
        b=CyldSbgiowZIZHEDRgq9S9pHgj2PdEhEyPObA7EMR2ran12J86NYMD95RpQlEvDuVn
         vJmm7kV+yaxpgOc1dEjXuQ6llszWvgexsz7ZZLFfMrd4NeAD3wbe6X4LFL3vOlt00fFu
         6DPlAsSby5e7gmFZr0W8Yyi4mxCLKagaYcGH5T8arJ6UsHd1LeMBOJJQvKMlFWB9Rvnm
         CBGnZT3Bp3q2ZYZzjNTjwBC9xVv75SQ6d4NpRq85sEY0G4W2cZXW3hYJfmXZGxSLoPbE
         94T2NGUOjxTsvKq6OEI0+UAQkS/WDKHQRFRQhl+N1b5Jjy7MdpfDCCPZ0tkWMU/RFiou
         98sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774809540; x=1775414340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/kM/klYNxQTa/jKkVxX6iEYp4a5igRkkUKILujaDgs=;
        b=vL4XsAZEowwobUSWGad+42OY3fvyGYuM22iUAQvNxVxEcY/BbJrOj0kwPqKHXHmV+k
         0XJ3Qm2kXwrTM/Ja2WoQOHAl4j5fm5WYU6BWZuYDZ00/LwbV55mhywAkEoKE+eO7rD0n
         LWchWOkvjKRR48ozvrgvtD7woZz5JDmL3HAr72Vh6l25RSgN3W5LR04c7JGoXcvoDiAA
         CkrhtyppV5M8TJ61B4AkfLATJrbSJoMpT5XJu0OP4EHdCGUWR1UnyH05PerzMNm08LF5
         oYD+TLRGUT7zcIvDYkABPVqOBiCS++0bWW35Cov3hqRxgAcWuhzJb0EwDxjAO3xEh422
         TTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774809540; x=1775414340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/kM/klYNxQTa/jKkVxX6iEYp4a5igRkkUKILujaDgs=;
        b=jl6mn2u4g/RaWb6YVUWUssDCgn9STSkN694flxTbtGDFOaYObn/Us+SprdteBTgL4y
         21177DGsVyb0O7Z8WeKQjaabJVVeQFkZhu2ua/FAjWP6aVG2FryjkbZRoZ6mC0qCCyrW
         pjYMf70ixFUCkxNKtptipuVWF4Y+XRWo/C5pW+AcJf7LcUOYe5PEP3bV64ABHT7fT5WM
         1jrAGpQgpRmtbBBl4wRh2SV6LxJ3lBFWkzLXidVVl/YRX+B85Nbt3r902VWcISyXFwk3
         fbTx/CA+6mYykgX+dRjg1NxPQcMSyaQYyVIAkZDtn9uRGw7Y/6jaFOoYho4D2D2xak5j
         Qw5w==
X-Gm-Message-State: AOJu0YzqOT8EYdsRM0hMQiHoCx+C6DSOKAu5wAQ7SIHz/XXu29yVIbOJ
	nxqFW6b7SX3JYay1SbftmfhiEPt3HSqARdh+R6b2OrCR+SY1QHdTswEEAPVMcktAgikLlFXbUPy
	/EeUgRzAlfVfhbnjlVDsmDzzxhp8GfyqcX0J0gssS
X-Gm-Gg: ATEYQzxc7ohOL1gVi3BhZ4uT0oxN2eiSKe+Nm4gYHAyTAv/cwaTMDVUTB0lANUaupBw
	ySS6rO9KcgV31va91KGujxHt14WCE3NNkqh7BTXzpn0bEymvqPKNp5i1R0/FGI4uKV2RU+IDcn9
	+KTlZzNHo1qRkyAe6EI2ZU4rlq2PGwTCTlh1VwiiRPohcNNUPj1YppEuJKAlr/bDLHgbJeRwEWL
	zXU+KGWpeBAxF4qI6D8+LrSUGFaGdkSerC+Bq20PTE00SVSvgSQYif5IswTX4mV84mQfTmCIb9S
	ezQqJG8rk9BzPoS/Xl0=
X-Received: by 2002:a05:6a00:c82:b0:823:1d05:1660 with SMTP id
 d2e1a72fcca58-82c9602f5d4mr9842503b3a.52.1774809540202; Sun, 29 Mar 2026
 11:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
 <20260312165757.GA3411905@mingi> <CAM0EoM=v6AuzmR+s4OAiKa3jXp_Hb+qgp_gh7FeeGrvMiztiQQ@mail.gmail.com>
 <20260313133810.GA3431035@mingi> <CAM0EoMmKnARRQxNNaEKO5Vg5vZBUgUmsximAgGfA9W-MO2iFJw@mail.gmail.com>
 <20260326102938.GA73145@mingi>
In-Reply-To: <20260326102938.GA73145@mingi>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 29 Mar 2026 14:38:49 -0400
X-Gm-Features: AQROBzCO5dPDkU9wETYGzZNw6fX1Zp56dktBovvlm4rQ9OfjDEuv6BVr4V-2vBU
Message-ID: <CAM0EoMnFkRm5sKXoCkOOBOWcUwReEpR90bbD657qwK-nNLsoGA@mail.gmail.com>
Subject: Re: [RFC Patch net-next 0/2] net_sched: Move GSO segmentation to root qdisc
To: Mingi Cho <mgcho.minic@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [13.84 / 15.00];
	DBL_SPAM(6.50)[test:email];
	MW_SURBL_MULTI(6.00)[test:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	RCVD_COUNT_THREE(0.00)[4];
	CT_SURBL(0.00)[test:email];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	CRACKED_SURBL(0.00)[test:email];
	TO_DN_SOME(0.00)[];
	ABUSE_SURBL(0.00)[test:email];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DM_SURBL(0.00)[test:email];
	TAGGED_RCPT(0.00)[netdev];
	PH_SURBL_MULTI(0.00)[test:email];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-272968-lists,netdev=lfdr.de];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADB9E353A58
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Thu, Mar 26, 2026 at 6:29=E2=80=AFAM Mingi Cho <mgcho.minic@gmail.com> w=
rote:
>
> Hi,
>
> On Fri, Mar 13, 2026 at 03:23:42PM -0400, Jamal Hadi Salim wrote:
> > Hi,
> >
> > On Fri, Mar 13, 2026 at 9:38=E2=80=AFAM Mingi Cho <mgcho.minic@gmail.co=
m> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 04:21:07PM -0400, Jamal Hadi Salim wrote:
> > > > On Thu, Mar 12, 2026 at 12:58=E2=80=AFPM Mingi Cho <mgcho.minic@gma=
il.com> wrote:
> > > > >
> > > > > On Tue, Jul 01, 2025 at 04:29:13PM -0700, Cong Wang wrote:
> > > > > > This patchset attempts to move the GSO segmentation in Qdisc la=
yer from
> > > > > > child qdisc up to root qdisc. It fixes the complex handling of =
GSO
> > > > > > segmentation logic and unifies the code in a generic way. The e=
nd result
> > > > > > is cleaner (see the patch stat) and hopefully keeps the origina=
l logic
> > > > > > of handling GSO.
> > > > > >
> > > > > > This is an architectural change, hence I am sending it as an RF=
C. Please
> > > > > > check each patch description for more details. Also note that a=
lthough
> > > > > > this patchset alone could fix the UAF reported by Mingi, the or=
iginal
> > > > > > UAF can also be fixed by Lion's patch [1], so this patchset is =
just an
> > > > > > improvement for handling GSO segmentation.
> > > > > >
> > > > > > TODO: Add some selftests.
> > > > > >
> > > > > > 1. https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525be=
e8bbb6a@gmail.com/
> > > > > >
> > > > > > ---
> > > > > > Cong Wang (2):
> > > > > >   net_sched: Move GSO segmentation to root qdisc
> > > > > >   net_sched: Propagate per-qdisc max_segment_size for GSO segme=
ntation
> > > > > >
> > > > > >  include/net/sch_generic.h |  4 +-
> > > > > >  net/core/dev.c            | 52 +++++++++++++++++++---
> > > > > >  net/sched/sch_api.c       | 14 ++++++
> > > > > >  net/sched/sch_cake.c      | 93 +++++++++++++------------------=
--------
> > > > > >  net/sched/sch_netem.c     | 32 +-------------
> > > > > >  net/sched/sch_taprio.c    | 76 +++++++------------------------=
-
> > > > > >  net/sched/sch_tbf.c       | 59 +++++--------------------
> > > > > >  7 files changed, 123 insertions(+), 207 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > >
> > > > > Hi Cong,
> > > > >
> > > > > I tested the proposed patch and found that the reported bug was f=
ixed. A qlen mismatch between Qdiscs can potentially cause UAF, so I believ=
e this patch needs to be applied.
> > > > >
> > > > > When executing the PoC on the latest kernel without the patch app=
lied, a warning message occurs in drr_dequeue() as shown below.
> > > > >
> > > > > Before applying the patch:
> > > > >
> > > > > root@test:~# ./poc
> > > > > qdisc drr 1: dev lo root refcnt 2
> > > > > qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> > > > > qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> > > > > [    7.588847] drr_dequeue: tbf qdisc 2: is non-work-conserving?
> > > > >
> > > > > Testing after applying the patch to the v6.17 kernel shows that t=
he warning message has disappeared.
> > > > >
> > > > > After applying the patch:
> > > > >
> > > > > root@test:~# ./poc
> > > > > qdisc drr 1: dev lo root refcnt 2
> > > > > qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> > > > > qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> > > >
> > > > Please test against latest net-next kernel then report back on the =
UAF
> > > > - not a "potential" but a real one.
> > > >
> > > > cheers,
> > > > jamal
> > >
> > > As seen in a recent patch (https://lore.kernel.org/netdev/20260114160=
243.913069-3-jhs@mojatatu.com/), it was possible to trigger a UAF using the=
 QFQ qdisc when qlen was handled incorrectly. I don't think this is the onl=
y way to trigger a UAF. Since it is obvious that qlen is also being handled=
 incorrectly during the GSO segment processing, I believe it would be bette=
r to remove this potential risk.
> > >
> >
> > I may not be remembering the sequence of events correctly, and i am
> > not sure if after all this time if that potential UAF hasnt been
> > resolved. Your repro was fixed by:
> > https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gma=
il.com/
> >
> > Typically, a message like "is non-work-conserving?" means you have
> > some bogus hierarchy. Find a way to create what you suggested is a
> > potential UAF, and I will be more than happy to invest time.
> >
> > cheers,
> > jamal
>
> I don't see any points in the current version of kernel that could lead t=
o a
> UAF, and I don't have time to analyze it further. A detailed analysis of =
this
> bug is provided below.
>


I have spent time analyzing your report - and yes, I can see the
potential for the problem.
The only challenge i have is cant keep up with these AI analyzed
reviews (apologies if you actually looked at code and came up with
this).
The issue does not seem to be restricted to just the use case you
showed here with choke i.e other qdisc arrangements are possible.
Again it is always some bogus arrangement of qdiscs set up to cause
the fault; by bogus i mean there's no practical value for such a qdisc
graph and i am not interested in doing "one more hack" to get it
working for this setup.
You will get me highly motivated to spend more time if you can produce
a UAF. Have you tried something like:
tc qdisc add dev eth0 root handle 1: drr
tc class add dev eth0 parent 1: classid 1:1 drr
// note: 'mtu' to 1500 should help to ensure that any GSO packet
larger than 1500 bytes ends up in the tbf segmentation area
tc qdisc add dev eth0 parent 1:1 handle 10: tbf rate 10mbit burst 2000
latency 50ms mtu 1500
// low 'min' and 'max' thresholds to force CHOKE to start dropping early
tc qdisc add dev eth0 parent 10: handle 20: choke limit 100 min 1 max
2 avpkt 1000

Sorry - dont have much time to invest in this; create the UAF then we
can talk some more...


cheers,
jamal

> static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
>                struct sk_buff **to_free)
> {
>     struct tbf_sched_data *q =3D qdisc_priv(sch);
>     struct sk_buff *segs, *nskb;
>     netdev_features_t features =3D netif_skb_features(skb);
>     unsigned int len =3D 0, prev_len =3D qdisc_pkt_len(skb), seg_len;
>     int ret, nb;
>
>     segs =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
>
>     if (IS_ERR_OR_NULL(segs))
>         return qdisc_drop(skb, sch, to_free);
>
>     nb =3D 0;
>     skb_list_walk_safe(segs, segs, nskb) {
>         skb_mark_not_on_list(segs);
>         seg_len =3D segs->len;
>         qdisc_skb_cb(segs)->pkt_len =3D seg_len;
>         qdisc_skb_cb(segs)->pkt_segs =3D 1;
>         ret =3D qdisc_enqueue(segs, q->qdisc, to_free);   // [1]
>         if (ret !=3D NET_XMIT_SUCCESS) {
>             if (net_xmit_drop_count(ret))
>                 qdisc_qstats_drop(sch);
>         } else {
>             nb++;
>             len +=3D seg_len;
>         }
>     }
>     ...
> }
>
> When a GSO packet is enqueued into the TBF, it is processed by the tbf_se=
gment.
> GSO packets are split into GSO segments and then enqueued into the child =
qdiscs
> of the TBF [1]. A problem occurs when the child qdisc of TBF enqueues one=
 or
> more GSO segments and returns a success, but then drops all packets from =
the
> child qdisc while enqueuing another GSO segment.
>
> The following shows the changes in the qlen values of each qdisc as the G=
SO
> segment is processed when the provided PoC is executed. A total of four
> segments are processed, and we can see that a mismatch in the qlen values
> occurs between the parent and child segments.
>
>        DRR    TBF    CHOKE
> seg1    0      0       1
> seg2    0      0       2
> seg3   -1     -1       1
> seg4   -2     -2       0
>
> When seg3 is enqueued into CHOKE, the average queue length exceeds qth_mi=
n,
> entering the probabilistic drop region. Since all GSO segments originate =
from
> the same UDP socket, choke_match_random() matches seg3 against an existin=
g
> packet (seg1) in the queue. choke_drop_by_idx() then drops seg1, which ca=
lls
> qdisc_tree_reduce_backlog() =E2=80=94 decrementing both TBF and DRR qlens=
 by 1. The
> incoming seg3 is also dropped via congestion_drop. The same occurs for se=
g4,
> which matches and drops seg2.
>
> static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
>                struct sk_buff **to_free)
> {
>     ...
>
>     sch->q.qlen +=3D nb;                  // TBF: qlen =3D -2 + 2 =3D 0
>     sch->qstats.backlog +=3D len;
>     if (nb > 0) {
>         qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
>                                         // DRR: qlen =3D -2 - (1-2) =3D -=
1
>         consume_skb(skb);
>         return NET_XMIT_SUCCESS;        // [2]
>     }
>
>     kfree_skb(skb);
>     return NET_XMIT_DROP;
> }
>
> As a result of the GSO processing, tbf_segment returns NET_XMIT_SUCCESS e=
ven
> though qlen is 0 [2].
>
> static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>                struct sk_buff **to_free)
> {
>     ...
>
>     err =3D qdisc_enqueue(skb, cl->qdisc, to_free);
>     if (unlikely(err !=3D NET_XMIT_SUCCESS)) {
>         if (net_xmit_drop_count(err)) {
>             cl->qstats.drops++;
>             qdisc_qstats_drop(sch);
>         }
>         return err;
>     }
>
>     if (!cl_is_active(cl)) {
>         list_add_tail(&cl->alist, &q->active);  // [3] cl->qdisc->q.qlen =
=3D 0,
>         cl->deficit =3D cl->quantum;               //     DRR: qlen =3D -=
1
>     }
>
>     sch->qstats.backlog +=3D len;
>     sch->q.qlen++;      // DRR: qlen -1 -> 0, no actual packets exist
>     return err;
> }
>
> Since the TBF qdisc returned NET_XMIT_SUCCESS, drr_enqueue adds the class=
 to
> the active list even though cl->qdisc.qlen is 0. This is nonsensical beca=
use
> the class is added to the active list even though it is not active.
>
> static struct sk_buff *drr_dequeue(struct Qdisc *sch)
> {
>     struct drr_sched *q =3D qdisc_priv(sch);
>     struct drr_class *cl;
>     struct sk_buff *skb;
>     unsigned int len;
>
>     if (list_empty(&q->active))
>         goto out;
>     while (1) {
>         cl =3D list_first_entry(&q->active, struct drr_class, alist);    =
 // [4]
>         skb =3D cl->qdisc->ops->peek(cl->qdisc);      // cl->qdisc.qlen =
=3D 0
>         if (skb =3D=3D NULL) {
>             qdisc_warn_nonwc(__func__, cl->qdisc);
>             goto out;
>         }
>
>     ...
> }
>
> Finally, in `drr_dequeue`, attempting to peek into an empty qdisc trigger=
s a
> warning message and causes unnecessary code to execute [4].
>
> Recently, there have been many cases where incorrect handling of the qlen
> value caused not only UAFs but also kernel panics; however, thanks to var=
ious
> patches, it appears that even if qlen is handled incorrectly, issues such=
 as
> panics no longer occur. Nevertheless, the bug clearly exists, so I am won=
dering
> if there are plans to patch it.
>
> Thanks,
> Mingi
>

