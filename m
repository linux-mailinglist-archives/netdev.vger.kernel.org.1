Return-Path: <netdev+bounces-282925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DPOOYF682mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4734A5244
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34717305FFF2
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50AD359A6C;
	Thu, 30 Apr 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="QGEpwya3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD537351C07
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563971; cv=pass; b=LvuSjHLlx+IT5e+rAAK8iGm95rfMx9gqWph5kUnWyRoytfhD35vEbadL9Ah2cJBtlliZ7DDR9vdx1SZGj4WbGsrABO6MGzoeObx3VjbYi6ikhUKNXQSWP9TxGV06UMBWa3N0KSeeGHiprBvgpDGd0VZXOay3VgqiT9gqJlqTphw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563971; c=relaxed/simple;
	bh=7haGA0Cmpz3rciaomjCQyZGKxFid6gvKmvDHOSIWR00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCXS8Pps+ktJBbQTYRtaRLW+Ct94f25EVcK2Rkk1iMTfwPU8IEKkGm0buPsisOmj24gwGHuk1SfS7z7D4WH0pjjDD8FgczOA3eeblZQ+lljbXNLayW9Xp42JUaXYQDzTT4ICRdJkkQ8m6MOd61FA8cY64ABRq2Y6q6AOxJ6bLo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=QGEpwya3; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd5c582c6cso5444397b3.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563966; cv=none;
        d=google.com; s=arc-20240605;
        b=a0qAjhRRcosWcQQIWvPcOhj9/G7RvStFK/m1RYZHBJJ+uvXX5R5jkgs3QfAdENnpkF
         sxCIRaxvcFT7LHDAShf152tLPyFdqgFaHElvHypywRWTlRmrZIbGk76ckc0mGVSpkWmC
         3YCfDojnBd3Ml82HAUQggI28OCsmFgbp3nm91pb1OF0zJH/LidTUIgT2ZIDwPvFUp89g
         x9dFmBafR635D4Y7GMwmXwRWhn0eR8JhF0yicoR1+V/j/u1ISNx7krq6D3woNCv81PIO
         xv00xgnGzWvAGq/GrdIASSrohjdAudectOzYwzpHD6BMpX+UzUeChgsisO3hllBBi8MT
         4NIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HrvAokJscQ8nUXAYywqyvUiBsVl9BDqi6SeIaa6RaNc=;
        fh=KqAMUBre+gbEPG3eo2pT5r3MhL3kFfXxaNCMx3oAjJg=;
        b=lZNG8kNvejLEXcbEpiBRYHLeu7d4dfZTSvTZqQB930Kdexnc494jom8W7Fx/51WTxD
         D4esp7B8YDWGlCbukh0gqCAUZuTQ3nc8GARCBYPoYEdeUCgNlc19VAmYqPlHe4ty4qdo
         dnMxbwf5LpUzRJ3nnbuYWWHb8T+ESA9vJdeokODcwA6oUrufBn6NkS+y2kokOshhgi6w
         h1/awznvWjbMlHW27KHJM26qITUwiLqyD6DMvuAxtJUQhdOaYTRE1l7PpYblAlfgREUP
         GYsq6zGTCNNNrmV7OiJBgPDVy/bZJTTbqrd5W2zymmlGsgdtcTih3G1TaHmvmG3CoNZf
         MF5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777563966; x=1778168766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrvAokJscQ8nUXAYywqyvUiBsVl9BDqi6SeIaa6RaNc=;
        b=QGEpwya3OP0OFtDOS8YGPs6vbaZ8BpNRqVA85lIKjyPp3SGhLWo8OYZ51m9/v+LSVU
         5W6dgOyc7YcOukLAoUyJxJfF3Sh5u7s1Rflcz7kuiW7cPjkq7RLrJW8RL/j9s7gkU+l1
         74mOT2173ifGAO/3IMhIz2NV0arCaCaHpl+vEq3MTowvR3MqlCC5erNoOve4lQxgFMSC
         RNsLJ9tD7ABhxQnroXDO+5y6GpC/scfxhAwAOUIAMaOcsCw18YGG9hkKIp4jRSNj00Ty
         9kOab7axwwxv2i5VmEVL8rQdgJh8UhJrfz2tBi+8XzRmDvQJ3vgTjo2ouK30Iy2sWng3
         r6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563966; x=1778168766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HrvAokJscQ8nUXAYywqyvUiBsVl9BDqi6SeIaa6RaNc=;
        b=l3Y4GYplJknHK+rriNgajLWskaBu6jSi2MRYxy/yPwB2gpHDRvMhRfRWtvS/i5lf4C
         VwaynHbLGeux1i5iAoU4F79MInc5yVDVP0EDvsExwd8/RwRoWN0on1MaMSb7lKU7s6r5
         AAsCMnjZLGAPPfjttGq3oYUc+LyaxbKwEBVtUT04g6c4kwEU2dps0SHawnP5Gb2KzoUz
         ilCMPGD2SsWLBCJEGvnV/BCY3Uq7v4tik6hFN/2jKbIOqxMSE8AvG2A+e9ubbHo47nZT
         +8vLa7m+BHb6gDzmlm2DUZparYWJyK7a0BMzG5NM6B58pqB4yYxlQSS5avjV6dOrhtJu
         etGw==
X-Forwarded-Encrypted: i=1; AFNElJ+5Vi2rDHFX2XQgmVcu8HEwHFNPfmv9kfciXbP+/TczUhnEXZ0DJTKMv9SapWTAr0KF8z/EUlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyerRKWAt3eYEkLXQyUeKUNvu2MGmaEnDMu5KIjdMEJFk0xkKGb
	QKbcsEjjAjaD7Lllw5HMZizKq18tZlRBHWJuPSDb5+nAKcX2M7SFawvwZrzpxZIpKacO2CGVzJR
	eGEMLbg+4O8KAWZlLq2DfxJ2qz3MHPPS3HHZ+oRP+
X-Gm-Gg: AeBDietjHcnj4q911J3UHbzV49V6dWMFJ7jHQws+48xBJlE7urDZYuQa4xIlvmDitD7
	+EuLNvmKVVyouQk02Y/E1Qr+5zX9081XaqwZBuLD7xGa/fT5gJB1h9jcgTrwyiabK0KDXoYDVQe
	WUtlePq6jntGppvywLOemsdOKOChKsFgueMvNcmhmd2KNcX7FkR16SVs0cEfjNEWFxK39gs1azw
	I7pY6BEsMfY4EBIOl8REBhQSOOw/1zAbTYTxsVdpdn5T20mZG3oyTZFmdU9Ni5MR7P0oSKjTQSZ
	CKrLhQ1r51Sk04Sn8niRBor2Be5xdA==
X-Received: by 2002:a05:690c:c664:b0:79f:cadb:d0ba with SMTP id
 00721157ae682-7bd52846f4emr29165927b3.20.1777563965824; Thu, 30 Apr 2026
 08:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428082851.3240821-1-edumazet@google.com> <18134b6e-8944-49f4-9bb0-2903aa00d28a@kernel.org>
In-Reply-To: <18134b6e-8944-49f4-9bb0-2903aa00d28a@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 30 Apr 2026 11:45:54 -0400
X-Gm-Features: AVHnY4L4jTo3f8CHVtGASzPYwZL3Xx4K0XNUOEPiJ-oX2IvhZPB0YD6m6JcRKb4
Message-ID: <CAM0EoMn4_MKeSRTM=g4i8nFPJVAFNW3WcRxzuQQRu5WMtGBKTg@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc: use ll_init_map() only when needed
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4C4734A5244
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282925-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,networkplumber.org,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 11:36=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> Jamal: waiting for your review ...
>

Looks good - running tdc on it to make sure nothing breaks...

cheers,
jamal
> On 4/28/26 2:28 AM, Eric Dumazet wrote:
> > Some setups can have thousands of devices.
> >
> > ll_init_map() is rather expensive for them.
> >
> > Only call ll_init_map() in the following cases:
> >
> > 1) tc runs in batch mode.
> > 2) tc runs in monitor mode.
> > 3) tc dumps qdiscs/classes/filters for all netdev.
> >
> > This greatly reduces RTNL pressure on common operations.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  tc/f_route.c   |  1 -
> >  tc/m_mirred.c  |  2 --
> >  tc/tc.c        |  1 +
> >  tc/tc_class.c  |  6 ++----
> >  tc/tc_filter.c | 32 ++++++++++++++++----------------
> >  tc/tc_qdisc.c  |  5 ++---
> >  6 files changed, 21 insertions(+), 26 deletions(-)
> >
> > diff --git a/tc/f_route.c b/tc/f_route.c
> > index 96b99b06be179c90dfb0d24d9577b5206dd98ef1..c234ddf0cb9309556844c85=
047d0f9ef53a2fd7b 100644
> > --- a/tc/f_route.c
> > +++ b/tc/f_route.c
> > @@ -76,7 +76,6 @@ static int route_parse_opt(const struct filter_util *=
qu, char *handle, int argc,
> >                       __u32 id;
> >
> >                       NEXT_ARG();
> > -                     ll_init_map(&rth);
> >                       if ((id =3D ll_name_to_index(*argv)) <=3D 0) {
> >                               fprintf(stderr, "Illegal \"fromif\"\n");
> >                               return -1;
> > diff --git a/tc/m_mirred.c b/tc/m_mirred.c
> > index f4da3c76284460d7f4bb73c7c3c172732f054632..e9ae5199432e828026f15ce=
226c5f5f84998c660 100644
> > --- a/tc/m_mirred.c
> > +++ b/tc/m_mirred.c
> > @@ -213,8 +213,6 @@ parse_direction(const struct action_util *a, int *a=
rgc_p, char ***argv_p,
> >       if (d[0])  {
> >               int idx;
> >
> > -             ll_init_map(&rth);
> > -
> >               idx =3D ll_name_to_index(d);
> >               if (!idx)
> >                       return nodev(d);
> > diff --git a/tc/tc.c b/tc/tc.c
> > index 0fc658c881f0f553f1f1f8d87b46943d4d0eed8f..7d69e4d533a98b9c071cb95=
4443a049a52252f2c 100644
> > --- a/tc/tc.c
> > +++ b/tc/tc.c
> > @@ -243,6 +243,7 @@ static int batch(const char *name)
> >               return -1;
> >       }
> >
> > +     ll_init_map(&rth);
> >       ret =3D do_batch(name, force, tc_batch_cmd, NULL);
> >
> >       rtnl_close(&rth);
> > diff --git a/tc/tc_class.c b/tc/tc_class.c
> > index 6d707d8c924f4b5e90201d4de8e9779f82ce17f3..9aace019e6c8b96fb51edb4=
fe89bea5b7469beed 100644
> > --- a/tc/tc_class.c
> > +++ b/tc/tc_class.c
> > @@ -136,11 +136,11 @@ static int tc_class_modify(int cmd, unsigned int =
flags, int argc, char **argv)
> >       }
> >
> >       if (d[0])  {
> > -             ll_init_map(&rth);
> > -
> >               req.t.tcm_ifindex =3D ll_name_to_index(d);
> >               if (!req.t.tcm_ifindex)
> >                       return -nodev(d);
> > +     } else {
> > +             ll_init_map(&rth);
> >       }
> >
> >       if (rtnl_talk(&rth, &req.n, NULL) < 0)
> > @@ -437,8 +437,6 @@ static int tc_class_list(int argc, char **argv)
> >               argc--; argv++;
> >       }
> >
> > -     ll_init_map(&rth);
> > -
> >       if (d[0]) {
> >               t.tcm_ifindex =3D ll_name_to_index(d);
> >               if (!t.tcm_ifindex)
> > diff --git a/tc/tc_filter.c b/tc/tc_filter.c
> > index 7db850bda11a3408ec66b457c9fc590f3a734f65..be70e360849e5058192640d=
a0f061810a99e2ea8 100644
> > --- a/tc/tc_filter.c
> > +++ b/tc/tc_filter.c
> > @@ -188,16 +188,17 @@ static int tc_filter_modify(int cmd, unsigned int=
 flags, int argc, char **argv)
> >               addattr_l(&req.n, sizeof(req), TCA_KIND, k, strlen(k)+1);
> >
> >       if (d[0])  {
> > -             ll_init_map(&rth);
> > -
> >               req.t.tcm_ifindex =3D ll_name_to_index(d);
> >               if (req.t.tcm_ifindex =3D=3D 0) {
> >                       fprintf(stderr, "Cannot find device \"%s\"\n", d)=
;
> >                       return 1;
> >               }
> > -     } else if (block_index) {
> > -             req.t.tcm_ifindex =3D TCM_IFINDEX_MAGIC_BLOCK;
> > -             req.t.tcm_block_index =3D block_index;
> > +     } else {
> > +             ll_init_map(&rth);
> > +             if (block_index) {
> > +                     req.t.tcm_ifindex =3D TCM_IFINDEX_MAGIC_BLOCK;
> > +                     req.t.tcm_block_index =3D block_index;
> > +             }
> >       }
> >
> >       if (q) {
> > @@ -539,8 +540,6 @@ static int tc_filter_get(int cmd, unsigned int flag=
s, int argc, char **argv)
> >       }
> >
> >       if (d[0])  {
> > -             ll_init_map(&rth);
> > -
> >               req.t.tcm_ifindex =3D ll_name_to_index(d);
> >               if (!req.t.tcm_ifindex)
> >                       return -nodev(d);
> > @@ -704,21 +703,22 @@ static int tc_filter_list(int cmd, int argc, char=
 **argv)
> >
> >       req.t.tcm_info =3D TC_H_MAKE(prio<<16, protocol);
> >
> > -     ll_init_map(&rth);
> > -
> >       if (d[0]) {
> >               req.t.tcm_ifindex =3D ll_name_to_index(d);
> >               if (!req.t.tcm_ifindex)
> >                       return -nodev(d);
> >               filter_ifindex =3D req.t.tcm_ifindex;
> > -     } else if (block_index) {
> > -             if (!tc_qdisc_block_exists(block_index)) {
> > -                     fprintf(stderr, "Cannot find block \"%u\"\n", blo=
ck_index);
> > -                     return 1;
> > +     } else {
> > +             ll_init_map(&rth);
> > +             if (block_index) {
> > +                     if (!tc_qdisc_block_exists(block_index)) {
> > +                             fprintf(stderr, "Cannot find block \"%u\"=
\n", block_index);
> > +                             return 1;
> > +                     }
> > +                     req.t.tcm_ifindex =3D TCM_IFINDEX_MAGIC_BLOCK;
> > +                     req.t.tcm_block_index =3D block_index;
> > +                     filter_block_index =3D block_index;
> >               }
> > -             req.t.tcm_ifindex =3D TCM_IFINDEX_MAGIC_BLOCK;
> > -             req.t.tcm_block_index =3D block_index;
> > -             filter_block_index =3D block_index;
> >       }
> >
> >       if (filter_chain_index_set)
> > diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
> > index 7eb9a31baa31fb91a8141c9eca1135e76a52fa8b..252ea861f249a5a71cf7823=
89776e68c3e48c6cc 100644
> > --- a/tc/tc_qdisc.c
> > +++ b/tc/tc_qdisc.c
> > @@ -193,8 +193,6 @@ static int tc_qdisc_modify(int cmd, unsigned int fl=
ags, int argc, char **argv)
> >       if (d[0])  {
> >               int idx;
> >
> > -             ll_init_map(&rth);
> > -
> >               idx =3D ll_name_to_index(d);
> >               if (!idx)
> >                       return -nodev(d);
> > @@ -411,13 +409,14 @@ static int tc_qdisc_list(int argc, char **argv)
> >               argc--; argv++;
> >       }
> >
> > -     ll_init_map(&rth);
> >
> >       if (d[0]) {
> >               req.t.tcm_ifindex =3D ll_name_to_index(d);
> >               if (!req.t.tcm_ifindex)
> >                       return -nodev(d);
> >               filter_ifindex =3D req.t.tcm_ifindex;
> > +     } else {
> > +             ll_init_map(&rth);
> >       }
> >
> >       if (dump_invisible) {
>

