Return-Path: <netdev+bounces-293463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3rpyJNBvHGquNwkAu9opvQ
	(envelope-from <netdev+bounces-293463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 19:28:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F2617550
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 19:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EB93014C3E
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903503921FA;
	Sun, 31 May 2026 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="o1OiDWtV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460033932E9
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780248524; cv=pass; b=PpzWpkFGWWLjXUu27xz1Y2jF1w5uSG0Y55QvQ4KMSMXfxbECUTrRApsWsQNnelRjp+WDxiEzdJbMsoqqpOUJss+V/BRGWNTiXmvCXP073dem6xDXGMwap6J8GnbicK/4LrVzKnUg6StrO2yW2KIPkMFA5uOnHt+prOMXj39CQLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780248524; c=relaxed/simple;
	bh=chrsUEDV28bUKVEwT8KTGG/NFLQ0vU3GR9GvVB2Qy1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2Cl9GQIv7c9+r2PXBsWVX+ZlN7owvyyuoCOfEcE/oy6bApsdx1wQlMlRH2A0Z4sTlVGtOQNtmovT/6wnPwXs6vK+VjPFrU9NryCPLtdLQ+giYZvuYgADf5M4MmTwmuPTBUEuFMRT1b+CyvXIfVEA8TQZZCzLWuNfVmtjb/enWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=o1OiDWtV; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c858cc9870aso325044a12.0
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 10:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780248520; cv=none;
        d=google.com; s=arc-20240605;
        b=iUwfcLqstXVsItTNT2m+jRr4qE4wUnY3nStcLv1gUUyIi0Ow4hh+UpMMcHTHZBkO04
         26HRXQpI65LBepwv5Esq5IaMTfkpkKDeGlMlBb5FlCqfgmggXTfDDEUxSKM/RJEALgWN
         YAccFo5zmIkK0FuBC4v9aLztqZGgvCP7aisLFwiwyA1PvKN9hT0JPrCXpq42DOXl2nCT
         GnK4hOLXF4kjuA5Ng+/XnDmgXa5CTAAkEyhqLK6Pp8/Tv2xCjONrzPrnIfwukIJ7ZZJC
         l/fprj9Yj8Vf3JndrDvXnXAg0RMXJyPobpK2wDWtWdlsCxE1m02eBc6E3gkx0wqyB7PN
         MOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ltPqzaJr4fZnmWw1AiPh9QI/hx4NTJRQ9v+FFW3fWek=;
        fh=lHH5UxlI6QpuRMa2e0O4FidJXT2wDgkl1d+ppxyp5IA=;
        b=b+8FpdUNCKPKSnav46gVcNoN/Y2Ld1LrYHqtc0yd+hLaFMiUhY+uhqUFxjtVxEh97B
         JRhWP3BCl+d9TPcNlSuiGVuHeL0U7PWvTV6kEAebMa0SMr6JFCKH6Q9u55Omktvf8KJl
         DveV04d1nuajGdwlIm7PVwp+fa8DyEFgJZ8ZLDulAEoidX/xXk/u4WdiiIQwwUNCRBGo
         PWjt88SyU1MStTaNympazAPR9CuDk2Cf7+RWsgG26dsfFtWqub2JIWqledKT1WhUiHR/
         Wl34P8Lf3w8VtXwjHmHp9qVij8rY0yWmN1/clNxvGFM9lpga5Ro2ZPFn0FPtrxAgLB5v
         MGaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780248520; x=1780853320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ltPqzaJr4fZnmWw1AiPh9QI/hx4NTJRQ9v+FFW3fWek=;
        b=o1OiDWtVTuLKF83x5i5jhW+1O3xrRx2zxEMB6K7Q+dcwmoc1ybTha39UtCYPGcjSyb
         r/NzRCAl3tkPDSPhqku6f9OqDV3DInxSgNpFhCXV39KV+NxzYnRKht3+wQKBx4LrWXIU
         ropZ6dzBY6xs6aPLEi5upS4pSikpv93zIKvs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780248520; x=1780853320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltPqzaJr4fZnmWw1AiPh9QI/hx4NTJRQ9v+FFW3fWek=;
        b=AcHMRn8NMHCExuidvzsDAOKVP/wU11HUZVLDAFNFusgnLt0H2iAppjh4kj6fAG3wQY
         lxE9VW1D88xVnRxPOm4xxoqmr0gONKPVXt9zMOIoyndb5rkx6bvJxcyb6GmrXvNZsxHq
         x4uzK28Rwse+vmgYrady4+rib+m1EKp2A/AgEyzEWCmSCsqP02hSOLzq678m4IykN6SX
         Vpi6Vi1kRgRJ8A1XHUc/nnz9qaWaZHKb2Y9yTTdstsEvBMHNsk9lUpnuRqpMLfkO/8qa
         aulCUGauG4aBb14nC6YroIxza/S+IscvOzZ3NtQ+OLoYXZGXZ9y4sTOgorzUSABX1p9X
         VdPg==
X-Gm-Message-State: AOJu0YwH+48bEJtAUnsH6I/P27S0kR7wqQVK7eLleF1343Yeouy3UheH
	nvzx3vxnPr6F3CkGWpNZIaT1BX3VGqAQudDCjX3WimeK2vbYV9j0H5KhB4MiCCJPEknBJgempWK
	GVJ4JfA5Q+AXlmaYKVg4/wtZYcwfHoPHexx05ShdY
X-Gm-Gg: Acq92OGpGCddLsuLUha+dPnJNoCT1HnxfjQ38ufo2Qp3dkV2ikMfaOKERKoMUL6lEW9
	gsQABZpiEp0FqjR3DmnKdqs+AooHTo6xVwK+duvhDFThQwCeUu7Iyb4R1oa+Bc3adeYZd++HG7k
	D+0C/led5FjMHArWDmzkqevTsmeTlwQYPcrN1MLAfWXsCuEPtvYmfrCW3SLzajE1Yp/ANZ20DJo
	9aZ8c1ZKjHpkfYYwKx8PxLS/cavzp28cbamtA5KtvZzSPXQYiWvehNZbtDTZN6zoUOxN/GkT19R
	ffN28gHVb8xGPdua5D4=
X-Received: by 2002:a05:6a21:b82:b0:39f:2af3:e8ee with SMTP id
 adf61e73a8af0-3b426a7456amr6472229637.13.1780248520408; Sun, 31 May 2026
 10:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531123221.48732-1-jhs@mojatatu.com> <20260531171534.6aae381a@pumpkin>
 <CAM0EoMnKxEuexh43U7v8s3UwNfr5B=jXUQxw_fCw_tB-Li39cA@mail.gmail.com>
In-Reply-To: <CAM0EoMnKxEuexh43U7v8s3UwNfr5B=jXUQxw_fCw_tB-Li39cA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 31 May 2026 13:28:28 -0400
X-Gm-Features: AVHnY4LxkRfrH7oQK1Whf2ToOGEwqpaHhy6P2gUTQyhvimRyNUSrBmNRoIB-Fbo
Message-ID: <CAM0EoM=0HRqQvnrTaJEdxK0fetwxHfhPtRd_n3mtWTmBjpJBFg@mail.gmail.com>
Subject: Re: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com, toke@redhat.com, 
	dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org, 
	stable@kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: multipart/mixed; boundary="000000000000abf40306532068c4"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293463-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,qualcomm.com:email,mojatatu.com:email,mojatatu.com:dkim,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Queue-Id: DB1F2617550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000abf40306532068c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 1:25=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, May 31, 2026 at 12:15=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun, 31 May 2026 08:32:21 -0400
> > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > >
> > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > not account for the runtime header offset added by typed keys. This
> > > can leave part of the write region un-COW'd.
> > >
> > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > the actual write offset is known, and add overflow checking on the
> > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > offset_valid() against INT_MIN, where negation is undefined.
> >
> > This code has all got out of hand somewhere.
> > I've only been looking at offset_valid() code.
> >
> > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is =
writable")
> > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > > Reported-by: Han Guidong <2045gemini@gmail.com>
> > > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > > Reviewed-by: Han Guidong <2045gemini@gmail.com>
> > > Tested-by: Han Guidong <2045gemini@gmail.com>
> > > Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> > > Tested-by: Davide Caratti <dcaratti@redhat.com>
> > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > ---
> > > v4->v5:
> > >  1) Dead code removal obsoleted after removing tcfp_off_max_hint as i=
dentified
> > >     by sashiko-claude[1]. Remove dead code updating "cur".
> > >  2) Addition of hoffset at tkey->at promotes hoffset to unsigned int,
> > >     wraps on overflow. Claim made by both sashiko-claude[1] and sashi=
ko-gemini[2]
> > >     I think this is far fetched but possible. Cast tkey->at to int.
> > >  3) Signedness mismatch in min() macro may potentially cause build is=
sues.
> > >     Claim made by both sashiko-claude[1] and sashiko-gemini[2].
> > >     Go back to min_t() for now. David L. can make a better proposal l=
ater..
> > >
> > > [1]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260530080643=
.1345521-1-jhs%40mojatatu.com
> > > [2]https://sashiko.dev/#/patchset/20260530080643.1345521-1-jhs%40moja=
tatu.com
> > > ---
> > >  include/net/tc_act/tc_pedit.h |  1 -
> > >  net/sched/act_pedit.c         | 77 +++++++++++++++++++--------------=
--
> > >  2 files changed, 41 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pe=
dit.h
> > > index f58ee15cd858..cb7b82f2cbc7 100644
> > > --- a/include/net/tc_act/tc_pedit.h
> > > +++ b/include/net/tc_act/tc_pedit.h
> > > @@ -15,7 +15,6 @@ struct tcf_pedit_parms {
> > >       struct tc_pedit_key     *tcfp_keys;
> > >       struct tcf_pedit_key_ex *tcfp_keys_ex;
> > >       int action;
> > > -     u32 tcfp_off_max_hint;
> > >       unsigned char tcfp_nkeys;
> > >       unsigned char tcfp_flags;
> > >       struct rcu_head rcu;
> > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > index bc20f08a2789..bd3b1da3cd63 100644
> > > --- a/net/sched/act_pedit.c
> > > +++ b/net/sched/act_pedit.c
> > > @@ -16,6 +16,8 @@
> > >  #include <linux/ip.h>
> > >  #include <linux/ipv6.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/overflow.h>
> > > +#include <linux/unaligned.h>
> > >  #include <net/ipv6.h>
> > >  #include <net/netlink.h>
> > >  #include <net/pkt_sched.h>
> > > @@ -242,7 +244,6 @@ static int tcf_pedit_init(struct net *net, struct=
 nlattr *nla,
> > >               goto out_free_ex;
> > >       }
> > >
> > > -     nparms->tcfp_off_max_hint =3D 0;
> > >       nparms->tcfp_flags =3D parm->flags;
> > >       nparms->tcfp_nkeys =3D parm->nkeys;
> > >
> > > @@ -268,14 +269,6 @@ static int tcf_pedit_init(struct net *net, struc=
t nlattr *nla,
> > >                                                  BITS_PER_TYPE(int) -=
 1,
> > >                                                  nparms->tcfp_keys[i]=
.shift);
> > >
> > > -             /* The AT option can read a single byte, we can bound t=
he actual
> > > -              * value with uchar max.
> > > -              */
> > > -             cur +=3D (0xff & offmask) >> nparms->tcfp_keys[i].shift=
;
> > > -
> > > -             /* Each key touches 4 bytes starting from the computed =
offset */
> > > -             nparms->tcfp_off_max_hint =3D
> > > -                     max(nparms->tcfp_off_max_hint, cur + 4);
> > >       }
> > >
> > >       p =3D to_pedit(*a);
> > > @@ -318,15 +311,12 @@ static void tcf_pedit_cleanup(struct tc_action =
*a)
> > >               call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
> > >  }
> > >
> > > -static bool offset_valid(struct sk_buff *skb, int offset)
> > > +static bool offset_valid(struct sk_buff *skb, int offset, int len)
> > >  {
> > > -     if (offset > 0 && offset > skb->len)
> > > -             return false;
> > > -
> > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > +     if (offset < -(int)skb_headroom(skb))
> > >               return false;
> > >
> > > -     return true;
> > > +     return offset <=3D (int)skb->len - len;
> > >  }
> > >
> > >  static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, co=
nst int header_type)
> > > @@ -393,18 +383,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >       struct tcf_pedit_key_ex *tkey_ex;
> > >       struct tcf_pedit_parms *parms;
> > >       struct tc_pedit_key *tkey;
> > > -     u32 max_offset;
> > >       int i;
> > >
> > >       parms =3D rcu_dereference_bh(p->parms);
> > >
> > > -     max_offset =3D (skb_transport_header_was_set(skb) ?
> > > -                   skb_transport_offset(skb) :
> > > -                   skb_network_offset(skb)) +
> > > -                  parms->tcfp_off_max_hint;
> > > -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > > -             goto done;
> > > -
> > >       tcf_lastuse_update(&p->tcf_tm);
> > >       tcf_action_update_bstats(&p->common, skb);
> > >
> > > @@ -412,10 +394,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >       tkey_ex =3D parms->tcfp_keys_ex;
> > >
> > >       for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > > +             int write_offset, write_len;
> > >               int offset =3D tkey->off;
> > >               int hoffset =3D 0;
> > > -             u32 *ptr, hdata;
> > > -             u32 val;
> > > +             u32 cur_val, val;
> > > +             u32 *ptr;
> > >               int rc;
> > >
> > >               if (tkey_ex) {
> > > @@ -433,13 +416,15 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >
> > >               if (tkey->offmask) {
> > >                       u8 *d, _d;
> > > +                     int at_offset;
> > >
> > > -                     if (!offset_valid(skb, hoffset + tkey->at)) {
> > > +                     if (check_add_overflow(hoffset, (int)tkey->at, =
&at_offset) ||
> >
> > There is no real reason for checking the add.
> > All that matters is that offset_valid() and skb_header_pointer() are
> > passed the same offset.
> > Assigning it to a local would make that clearer.
>
> You are technically correct - but earlier discussion was I believe
> that signed integer overflow as undefined behavior and those checks
> are there to avoid that and logic bypasses.
>
> >
> > > +                         !offset_valid(skb, at_offset, sizeof(_d))) =
{
> > >                               pr_info_ratelimited("tc action pedit 'a=
t' offset %d out of bounds\n",
> > >                                                   hoffset + tkey->at)=
;
> > >                               goto bad;
> > >                       }
> > > -                     d =3D skb_header_pointer(skb, hoffset + tkey->a=
t,
> > > +                     d =3D skb_header_pointer(skb, at_offset,
> > >                                              sizeof(_d), &_d);
> > >                       if (!d)
> > >                               goto bad;
> > > @@ -451,31 +436,51 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >                       }
> > >               }
> > >
> > > -             if (!offset_valid(skb, hoffset + offset)) {
> > > -                     pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n", hoffset + offset);
> > > +             if (check_add_overflow(hoffset, offset, &write_offset))=
 {
> > > +                     pr_info_ratelimited("tc action pedit offset ove=
rflow\n");
> > >                       goto bad;
> > >               }
> > >
> > > -             ptr =3D skb_header_pointer(skb, hoffset + offset,
> > > -                                      sizeof(hdata), &hdata);
> > > -             if (!ptr)
> > > +             if (!offset_valid(skb, write_offset, sizeof(*ptr))) {
> > > +                     pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n",
> > > +                                         write_offset);
> > >                       goto bad;
> > > +             }
> >
> > Again all that matters is that the same value is passed to offset_valid=
()
> > and skb_header_pointer().
>
> Same comment as earlier.
> Note: we replaced skb_header_pointer() with direct memory access "ptr
> =3D (u32 *)(skb->data + write_offset)" further down.
> so extra validation of write_offset is justifiable, no?
>
>
> > > +
> > > +             if (write_offset < 0) {
> > > +                     if (skb_cow(skb, -write_offset))
> > > +                             goto bad;
> > > +                     if (write_offset + (int)sizeof(*ptr) > 0) {
> > > +                             if (skb_ensure_writable(skb,
> > > +                                                     min_t(int, skb-=
>len,
> > > +                                                           write_off=
set + (int)sizeof(*ptr))))
> >
> > That min isn't needed (same as below).
>
> Ok - yes, i see that. Same with the min(). Why did we think we needed
> min/min_t() before?
>
> > > +                                     goto bad;
> > > +                     }
> > > +             } else {
> > > +                     if (check_add_overflow(write_offset, (int)sizeo=
f(*ptr),
> > > +                                            &write_len))
> >
> > That can't fail because of the 'return offset <=3D (int)skb->len - len;=
' check.
>
> True.
>
> >
> > > +                             goto bad;
> > > +                     if (skb_ensure_writable(skb, min_t(int, skb->le=
n,
> > > +                                                        write_len)))
> >
> > Similarly that min_t() will return 'write_len'.
> > But is that even correct?
> > The code wants to write 4 bytes at skb->data + write_offset.
> > I can't see where the offset is used.
> > All the overflow tests have made the logic far too hard to follow.
> >
> > I think that whole lot can just be:
> >         hoffset +=3D offset;
> >         if (offset_valid(skb, hoffset, sizeof(hdata)))
> >                 goto bad;
> >
> >         /* Ensure any needed headroom is writeable */
> >         if (hoffset < 0 && skb_cow(skb, -hoffset)
> >                 goto bad;
> >         /* Ensure the skb is writeable to the end of the area to be wri=
tten.
> >          * The data is pulled into the skb header. */
> >         if ((hoffset >=3D 0 || hoffset + (int)sizeof(hdata) > 0) &&
> >             skb_ensure_writable(skb, hoffset + (int)sizeof(hdata))
> >                 goto bad;
> > The call to offset_valid() does all the other checks.
> > (The hoffset >=3D 0 check is the inverse of the earlier check and will
> > be optimised away - skipping the second second test which is then
> > always true.)
>
> Yes, that code is more readable.
>
> > If you really want a warning message, put a generic one on 'bad;'.
> >
> > > +                             goto bad;
> > > +             }
> > > +
> > > +             ptr =3D (u32 *)(skb->data + write_offset);
> > > +             cur_val =3D get_unaligned(ptr);
> >
> > Given you are doing an unaligned read you could remove the check in the
> > 'offmask' path that the final offset is a multiple of 4.
> > Nothing checked that tkey->off is a multiple of 4, and I suspect that
> > is user-specifiable?
>
> The only reason i will keep that check is because we have always
> checked for the 32b alignment from an API perspective. I am less
> worried about than potentially breaking something in the hardware
> offload path when a user passes unaligned offsets down given that
> these code paths (towards hardware) have been well vetted.
>
> I am trying to get this security fix in. Do you see anything in what
> you stated as a show stopper? IOW introducing regression or plain
> wrong?
> If not, I will wait for the AI review or if someone finds an issue
> which breaks something - and if it is worth going back then i will
> consider your suggestions as part of the next update.
> Does that sound reasonable?
>

Something like attached (not compile tested) basically if i didnt miss
what else you suggested.

cheers,
jamal

> cheers,
> jamal
>
> > I'm also not entirely that the mac_header is aligned.
> >
> > -- David
> >
> > >               /* just do it, baby */
> > >               switch (cmd) {
> > >               case TCA_PEDIT_KEY_EX_CMD_SET:
> > >                       val =3D tkey->val;
> > >                       break;
> > >               case TCA_PEDIT_KEY_EX_CMD_ADD:
> > > -                     val =3D (*ptr + tkey->val) & ~tkey->mask;
> > > +                     val =3D (cur_val + tkey->val) & ~tkey->mask;
> > >                       break;
> > >               default:
> > >                       pr_info_ratelimited("tc action pedit bad comman=
d (%d)\n", cmd);
> > >                       goto bad;
> > >               }
> > >
> > > -             *ptr =3D ((*ptr & tkey->mask) ^ val);
> > > -             if (ptr =3D=3D &hdata)
> > > -                     skb_store_bits(skb, hoffset + offset, ptr, 4);
> > > +             put_unaligned((cur_val & tkey->mask) ^ val, ptr);
> > >       }
> > >
> > >       goto done;
> >

--000000000000abf40306532068c4
Content-Type: application/octet-stream; name="patchlet-david.laight"
Content-Disposition: attachment; filename="patchlet-david.laight"
Content-Transfer-Encoding: base64
Content-ID: <f_mpu1zugx0>
X-Attachment-Id: f_mpu1zugx0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9hY3RfcGVkaXQuYyBiL25ldC9zY2hlZC9hY3RfcGVkaXQu
YwppbmRleCBiZDNiMWRhM2NkNjMuLmU3ZGEwMTgwNDg5MSAxMDA2NDQKLS0tIGEvbmV0L3NjaGVk
L2FjdF9wZWRpdC5jCisrKyBiL25ldC9zY2hlZC9hY3RfcGVkaXQuYwpAQCAtMzk0LDcgKzM5NCw3
IEBAIFRDX0lORElSRUNUX1NDT1BFIGludCB0Y2ZfcGVkaXRfYWN0KHN0cnVjdCBza19idWZmICpz
a2IsCiAJdGtleV9leCA9IHBhcm1zLT50Y2ZwX2tleXNfZXg7CiAKIAlmb3IgKGkgPSBwYXJtcy0+
dGNmcF9ua2V5czsgaSA+IDA7IGktLSwgdGtleSsrKSB7Ci0JCWludCB3cml0ZV9vZmZzZXQsIHdy
aXRlX2xlbjsKKwkJaW50IHdyaXRlX29mZnNldDsKIAkJaW50IG9mZnNldCA9IHRrZXktPm9mZjsK
IAkJaW50IGhvZmZzZXQgPSAwOwogCQl1MzIgY3VyX3ZhbCwgdmFsOwpAQCAtNDQ3LDIzICs0NDcs
MTIgQEAgVENfSU5ESVJFQ1RfU0NPUEUgaW50IHRjZl9wZWRpdF9hY3Qoc3RydWN0IHNrX2J1ZmYg
KnNrYiwKIAkJCWdvdG8gYmFkOwogCQl9CiAKLQkJaWYgKHdyaXRlX29mZnNldCA8IDApIHsKLQkJ
CWlmIChza2JfY293KHNrYiwgLXdyaXRlX29mZnNldCkpCi0JCQkJZ290byBiYWQ7Ci0JCQlpZiAo
d3JpdGVfb2Zmc2V0ICsgKGludClzaXplb2YoKnB0cikgPiAwKSB7Ci0JCQkJaWYgKHNrYl9lbnN1
cmVfd3JpdGFibGUoc2tiLAotCQkJCQkJCW1pbl90KGludCwgc2tiLT5sZW4sCi0JCQkJCQkJICAg
ICAgd3JpdGVfb2Zmc2V0ICsgKGludClzaXplb2YoKnB0cikpKSkKLQkJCQkJZ290byBiYWQ7Ci0J
CQl9Ci0JCX0gZWxzZSB7Ci0JCQlpZiAoY2hlY2tfYWRkX292ZXJmbG93KHdyaXRlX29mZnNldCwg
KGludClzaXplb2YoKnB0ciksCi0JCQkJCSAgICAgICAmd3JpdGVfbGVuKSkKLQkJCQlnb3RvIGJh
ZDsKLQkJCWlmIChza2JfZW5zdXJlX3dyaXRhYmxlKHNrYiwgbWluX3QoaW50LCBza2ItPmxlbiwK
LQkJCQkJCQkgICB3cml0ZV9sZW4pKSkKLQkJCQlnb3RvIGJhZDsKLQkJfQorCQlpZiAod3JpdGVf
b2Zmc2V0IDwgMCAmJiBza2JfY293KHNrYiwgLXdyaXRlX29mZnNldCkpCisJCQlnb3RvIGJhZDsK
KworCQlpZiAoKHdyaXRlX29mZnNldCA+PSAwIHx8IHdyaXRlX29mZnNldCArIChpbnQpc2l6ZW9m
KCpwdHIpID4gMCkgJiYKKwkJICAgIHNrYl9lbnN1cmVfd3JpdGFibGUoc2tiLCB3cml0ZV9vZmZz
ZXQgKyAoaW50KXNpemVvZigqcHRyKSkpCisJCQlnb3RvIGJhZDsKIAogCQlwdHIgPSAodTMyICop
KHNrYi0+ZGF0YSArIHdyaXRlX29mZnNldCk7CiAJCWN1cl92YWwgPSBnZXRfdW5hbGlnbmVkKHB0
cik7Cg==
--000000000000abf40306532068c4--

