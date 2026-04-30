Return-Path: <netdev+bounces-282969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEdUEXCd82lJ5QEAu9opvQ
	(envelope-from <netdev+bounces-282969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:20:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE4A4A6CE7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05EB43003733
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96353537FF;
	Thu, 30 Apr 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="oaUTZR7c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6326477E21
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573225; cv=pass; b=o0C2ACnIXJP1AAVhiqoUyJYmy/bQft0vJq7e/YwiKM8FpiKI0sOybZKe4q7ENLFw6hDXVAc+b08q35JjoSaQ5HBZSx5xu4aFfmTrQU+DxdqgZCUjr9PxqNBNRMVTvcKhR+kY8Girgmk39yIvRCwG9qzwA+TZtDG31fzl9/U8Tfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573225; c=relaxed/simple;
	bh=aYs83MNb594P2nkPKpIdQB6BP960WTyxNrB2OPYnSEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhczEJ1gn+Po6Hz63iDxweJlKXHo/5LTWXNeWKX+suGOK6sb+jc41b6nNQ4bLq/s5wmSk9gZJhWnfA453wIlnUp01FYzAPUMO9vc60s21vXzKGrm2Cm1ODptMMOZ2XptLWJcGNxQAOjw5E3l/AvdU2Wga6rCFq71NKneoyVWBRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=oaUTZR7c; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f8cebc935so631694b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777573223; cv=none;
        d=google.com; s=arc-20240605;
        b=D5XRdK8QnFftk7jtNuiRFZxcODlQ//+Z+nUPKXL27a1aQPdEe8oxeM5l1zLhzH1dz5
         LSWMDYcnJBR0EgmWx6RUbuEpivp2+aqknn+jX5ySf07hdOqD7zi/oX6WzefyGzT0t/Dj
         FsQnBhQraVTN7skiAf09WLppDt9kcxo7j+KLNiaZvyqdg0CCYP+tgkNPsa4C7rr15avK
         gXdDCL117DrNLu2qkMmVCKZoS9v/U0V2f2KqyuG9WQJXMYdZ9K7ER3lNkStpl56qlU54
         VX4s99x/OqcPURdCyoY84OrC/dPYvdQzoepeMUVR+APmynsAETlU7EsacbZX0wDx/Nym
         yzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cyDcGvL2bHr7kOuvT1ZyqRfNEGYWnlbp8jkYBRxyltA=;
        fh=mgx62reLjdDmfH+C9UY6r2mZ2Ow/mIuN9hnce0ox9Ys=;
        b=cvK/Cvk8EQHvmX9hzyRPGAoqQxBbwPHTZ2RscgxWGsK1G7Ziz6LYtAn1rRls7vo6CX
         1zLeBHGE+Gy2W/0Zx7arG/sqiF3he1DZGQ36kyo6kdYiMaQ8TvfabNlTuZbDCiDZ6ri0
         NDpcelVGk9iIVhJiy9ecez9VfwHFpw/eky8e/aEiNLVpYPFrdiy0iz7Iw+ShBz8uWFmX
         g8r7qVZiOvs8OqoH0TX8tS6n/APmBFX6ocCW3g31qX35kCnl9lbC7NUNOr1fxDM0AHPG
         wj/6reDDVfX2JPdON33zbNtDRQ2NiZ7eWnKlbe2+Wr5pB9W29/SvX4i/df+B5VDpyeJE
         /CYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777573223; x=1778178023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyDcGvL2bHr7kOuvT1ZyqRfNEGYWnlbp8jkYBRxyltA=;
        b=oaUTZR7ckcxOIqoZmFbKAMG2ShndAA0Ipgth58e0ThC0TmBznT290d0i/2RmkWA5S0
         5njky+68WlMNramJMEGWVvuLmj7gcopRWtZxfZoCR56wjLoMhLlXjBi5oIL/fvIQ9/tl
         JY8V2HoruqR85QHog3CfuHTYkyMIxShYsEIa/cPr/4mlaX5I6E/u76NbbwOjDf/vPjh6
         jsc2gi/y2EG/0jzSIBMD2rFIX5d6HMXXashuLnZrAt8dmMzeNZssqkwj4H+M7eHL6YPa
         J+/1IW4GAC2j3sTe9CZ6ilPBxaeqC3Efkdve2jzczi+2TfGvWJ+00W0SHUU9TpcdOu4i
         Jd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573223; x=1778178023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyDcGvL2bHr7kOuvT1ZyqRfNEGYWnlbp8jkYBRxyltA=;
        b=YVunkaFt0BRAzsEOUWxdJyjor1CdhBR3BVPxIfHP30sRFelXsNayrTDv9CG2jxTKpS
         3eVyhRSSo6wbgNnM/2D5Mx/0y5W3D028bdxuLSLK/Q6oQvSmALPavdiKcsL6/mOKj371
         DX/lANG+IWLCa1aSu+e6VBruqdYcyTB4FpNEsGVpSFZS1nSmMyq7RSCxOaHcUaWQs5rN
         ZJYjstHbXVv7xvptHp5Xc7unUU2hp+5oEy6tJUozpR3Nm8cX3ioVmQd8y1HInEbhv8IA
         roSNBt3qy97embrkKtkGicGuNfAEVouiM2RSA/zZC+V9h7+UIYcZGQeepjATw4LI2gF1
         +ssg==
X-Forwarded-Encrypted: i=1; AFNElJ/tzhlY5AwPjXj8prWC8MP+Iub12FAYmE9690/j7UeQq5/nVtOVex2T5epIj51g/mqBxBNkTq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwylMG9iQwWi3AwomnPTU55n8ytX2L1jB2vtq7yvfsH8U9bqWmJ
	S0KJq4ZCuJRvCDQ7neEloqWrax4g6ZCe3PnwjFoNMWeLIEwSaPbZGqQihTGSPCwKM5Ku+X9VjxY
	pRER4Iajp/g1uXuUpyh5eFCjng+LYdA+2Fgwekdtm
X-Gm-Gg: AeBDievsTumSpg2S8RMHooxJhmbiOEzCfg5KbemBct2sjAccsLZs+WIZBPjmtz6Nf6Z
	9UJzosMaaXtJ8ci+cCaVHE23wIAwOFXc21FRQmfzLD/Pbxbr/64mwWomppxwCPaROv9q3rDgv2M
	dH54bXRbDSO41ma2bsyoOhdtFYiW4pUGT5+TZfEC+xjo3Mgnhh9wry1oBOgrDEAuZ05BClH/vOx
	bTC398ANZdPlDqfelYQWwIedhbnNDTRs8mpcw90t3bl3kkd+y44/+n7KktJSSPCctsA77vub2kA
	Rc4T8n9bN1P7k08Nc2UTqFOGYkI5rQ==
X-Received: by 2002:a05:6a00:b46:b0:82f:390a:69df with SMTP id
 d2e1a72fcca58-834fdcb6501mr4909169b3a.35.1777573223160; Thu, 30 Apr 2026
 11:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428082851.3240821-1-edumazet@google.com> <18134b6e-8944-49f4-9bb0-2903aa00d28a@kernel.org>
In-Reply-To: <18134b6e-8944-49f4-9bb0-2903aa00d28a@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 30 Apr 2026 14:20:11 -0400
X-Gm-Features: AVHnY4KGahx8YtCnoCdvhzJ9VwRLn1CZx4OnFXhzWcX3YDEbJC1aoxRJlDv4ZZI
Message-ID: <CAM0EoMmHMMsAbORxETh72c0=CyyAY+PhXReXwP-woGp31YOkHw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc: use ll_init_map() only when needed
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4CE4A4A6CE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282969-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:email]

On Thu, Apr 30, 2026 at 11:36=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> Jamal: waiting for your review ...
>
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

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

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

