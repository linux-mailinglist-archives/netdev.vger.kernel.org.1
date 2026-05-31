Return-Path: <netdev+bounces-293462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEtCKyNvHGqONwkAu9opvQ
	(envelope-from <netdev+bounces-293462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 19:25:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B906617540
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 19:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 828863004918
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFC1390C9F;
	Sun, 31 May 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="LphmYzwr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D23233722
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780248351; cv=pass; b=M5CewakIuj8tAfjqKDUj2RKRDc/LivFgHMxQ70bwYjjSoOD/79a3O1tcmykuMOOHzNvaeZowtHAySX1OPpl83xdri2jZTz76+SFOfKPKBGR0vOcVqbPE6loEi959o3ETFzlRLFQG+WKAoBfXH+c92GrUdsXv6HS4AUZ09btwuhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780248351; c=relaxed/simple;
	bh=cWKWcMAVHkZMK+wn8rXMq1l+Fci10ZLyByFFOvA6fsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh4ckCT3CmmRU+7eGML3IPUWPBiJUxH6S3q3GgPdIASONjMjEMVaD/wjskucMPw2Uxjq02oUXjHGqNli+uinqfSGTkZV05QKSzSc/mO8AbTYP3dfq5v1jn2gYNtYJyb/mttsxYrugSvU1IVNioAuO1PhhKNygCOu4K83HvxxuG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=LphmYzwr; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so1500368a91.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 10:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780248349; cv=none;
        d=google.com; s=arc-20240605;
        b=X8wnGfngtp4V7CtY7QyNyx/9JE8F3g2+U0+VcyH43QMjYlpFNecDgWiSsZ5pyMqsln
         sAHBlN832NCAa1cPwzBiXXN3WWXNVXs6y8jU8d8diUtE5rz94ekV5xEw5mMgxsnk0lKK
         OHz8plH+ZdOYNLdVJZ3nxQhdjnQV7czwyVx+l9MN0IcuUWgyvuHStSiItdOppDeFyaSd
         oYuELNB/mHF/DPr2Fnjd50f5izPbXJUm1A5DrFTtAvhRUPcQSuPw+0AaOzeN+nyREN8r
         1ScoP2PUnTUHsmigo2XLYoqsHNFDDGE1wk6LlrEuUtMF5i2BNxGs8u68eW6Ge/FZgpK9
         D8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/VzCWUhr9B8FjEEge6B6+UTAPD13fgQZxYEqM6kq1Ys=;
        fh=lHH5UxlI6QpuRMa2e0O4FidJXT2wDgkl1d+ppxyp5IA=;
        b=WwS/OAw1jOYMlGySrCTNEJvNQDTa+PfbzS2z4jWAUcs5mF1cZAIeSI/kiSGHYHw9vM
         i/rV2zYoNJx/eNHPez61np15qNO+2Mk1GYtpq1teARRp0aLXIXQ2XpqxV2QRcqjNoSvN
         lKxJuUs9r1JTiDRhy3Go0QtoF5lVHRICh59hoox4/EiXkWUQNOeWqPLtgUjpw9vV88zG
         b1WIoP8wp9uu0UTRmllDGH4BGBR2mBbV6Z2i12uo8MBWjLdrGdy4fxNARIhlpElo+eiH
         5lQT3aEFUwZcfR34INIovFmwvPV9zZVo7jsTXIJ00i6tIECGn0uGAHM88Pw4a1v4kr0f
         EhKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780248349; x=1780853149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VzCWUhr9B8FjEEge6B6+UTAPD13fgQZxYEqM6kq1Ys=;
        b=LphmYzwrOu3e+ljHD6yQaMamvDmx3BituRcbDb06zcJeOpvfyEQI3LRtPTbA8xyC13
         LzEzwTpuW7gBztaA0F72Pl5qfyS/u2qasBvxC9Vnm9PSoJQl5hDSdBsXMfdlBSGy8JDL
         UyC+YpVWddbyI0InIYl+K0SWv/lH9yhYJDXkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780248349; x=1780853149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VzCWUhr9B8FjEEge6B6+UTAPD13fgQZxYEqM6kq1Ys=;
        b=IcZMkGrdUeWxI7u4k0FEWmBmfFMv3HNz8PlktHBTGhJkn1/CLn9ZGm3rbT4GN+ZjFS
         fv0tjZCyhSxJHl3kruQBMLaB4BX8gUN32nuqYZRz0cNg80ccJspW5NVKTkt8x2nhUhNl
         dODiuhz77GWXUhk10sWmkJ2rZ2tzMvEEoKp/hRYydNfcdz5mi5h6n9OT29LPQvqh9xkd
         dKl7kUQbldlZrXZKhN1TmcpCLm4k9+VqNE5oPeyV3Mhh5caNvr8K9OYBtSXVUVjBT1yF
         Gbhf3EO5RNeJuj+worzx5B9yCB4aASpxQapuR/RKQCZD7ZuKszRFWONoy8oMvgj9a2CQ
         qaEw==
X-Gm-Message-State: AOJu0YzIDKVRrltFGYBxdDSeAejFpAQ+IMPhbz1ZxOax4UI+o5vcsFd6
	sI59TuNUk8DNxsL7sEPfhm+i7zQXcDWFBb1rL0Ud2USIveidG3uMBrw2+8lpulyNcfSY/ydtvQx
	UhoH3/TNuDMEk0Vr/8lRNjJEPtsMjklC2T4HKMjOv
X-Gm-Gg: Acq92OH5SFl6sc7pvBqPnwdw5Zo0wuliUjnB/xG9UCuTUyOcXQfLNr/fqG5Annq3nfg
	CpdqnlA0v4R0ACbDLLWgeyVLLWii7d8yYED4IY54TmfhokUrXUVZcSEIhj4GGix4ombqP+r44am
	HVUT2XghT2sJ645Qv5VUFAH/zyebKIiAA1BpCbJxc+TnpEAHMu2y3EhoO3O18PZ5+Nc9EDd8Gzv
	VGHbzEVG/uPD0xcagQwvVBv2Tdx14VNWyfcMo/ZuO5KpnUqZvNcb2APVnykF2/EDllcb8IJUiX0
	e4JHtM2DRBF30y2hcUI=
X-Received: by 2002:a17:90b:2b86:b0:369:932a:2b8a with SMTP id
 98e67ed59e1d1-36c4ff24c37mr6820673a91.1.1780248348671; Sun, 31 May 2026
 10:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531123221.48732-1-jhs@mojatatu.com> <20260531171534.6aae381a@pumpkin>
In-Reply-To: <20260531171534.6aae381a@pumpkin>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 31 May 2026 13:25:36 -0400
X-Gm-Features: AVHnY4Jby-jOllSjmdxNaD5M40j-lG9W5Jpavharjw-GDZwC9xD5OuELWwpgelk
Message-ID: <CAM0EoMnKxEuexh43U7v8s3UwNfr5B=jXUQxw_fCw_tB-Li39cA@mail.gmail.com>
Subject: Re: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com, toke@redhat.com, 
	dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org, 
	stable@kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293462-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 0B906617540
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 12:15=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun, 31 May 2026 08:32:21 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> >
> > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > once before the key loop using tcfp_off_max_hint, but the hint does
> > not account for the runtime header offset added by typed keys. This
> > can leave part of the write region un-COW'd.
> >
> > Fix by moving skb_ensure_writable() inside the per-key loop where
> > the actual write offset is known, and add overflow checking on the
> > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > at ingress), use skb_cow() to COW the headroom instead. Guard
> > offset_valid() against INT_MIN, where negation is undefined.
>
> This code has all got out of hand somewhere.
> I've only been looking at offset_valid() code.
>
> > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is wr=
itable")
> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > Reported-by: Han Guidong <2045gemini@gmail.com>
> > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > Reviewed-by: Han Guidong <2045gemini@gmail.com>
> > Tested-by: Han Guidong <2045gemini@gmail.com>
> > Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> > Tested-by: Davide Caratti <dcaratti@redhat.com>
> > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > ---
> > v4->v5:
> >  1) Dead code removal obsoleted after removing tcfp_off_max_hint as ide=
ntified
> >     by sashiko-claude[1]. Remove dead code updating "cur".
> >  2) Addition of hoffset at tkey->at promotes hoffset to unsigned int,
> >     wraps on overflow. Claim made by both sashiko-claude[1] and sashiko=
-gemini[2]
> >     I think this is far fetched but possible. Cast tkey->at to int.
> >  3) Signedness mismatch in min() macro may potentially cause build issu=
es.
> >     Claim made by both sashiko-claude[1] and sashiko-gemini[2].
> >     Go back to min_t() for now. David L. can make a better proposal lat=
er..
> >
> > [1]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260530080643.1=
345521-1-jhs%40mojatatu.com
> > [2]https://sashiko.dev/#/patchset/20260530080643.1345521-1-jhs%40mojata=
tu.com
> > ---
> >  include/net/tc_act/tc_pedit.h |  1 -
> >  net/sched/act_pedit.c         | 77 +++++++++++++++++++----------------
> >  2 files changed, 41 insertions(+), 37 deletions(-)
> >
> > diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedi=
t.h
> > index f58ee15cd858..cb7b82f2cbc7 100644
> > --- a/include/net/tc_act/tc_pedit.h
> > +++ b/include/net/tc_act/tc_pedit.h
> > @@ -15,7 +15,6 @@ struct tcf_pedit_parms {
> >       struct tc_pedit_key     *tcfp_keys;
> >       struct tcf_pedit_key_ex *tcfp_keys_ex;
> >       int action;
> > -     u32 tcfp_off_max_hint;
> >       unsigned char tcfp_nkeys;
> >       unsigned char tcfp_flags;
> >       struct rcu_head rcu;
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index bc20f08a2789..bd3b1da3cd63 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/ip.h>
> >  #include <linux/ipv6.h>
> >  #include <linux/slab.h>
> > +#include <linux/overflow.h>
> > +#include <linux/unaligned.h>
> >  #include <net/ipv6.h>
> >  #include <net/netlink.h>
> >  #include <net/pkt_sched.h>
> > @@ -242,7 +244,6 @@ static int tcf_pedit_init(struct net *net, struct n=
lattr *nla,
> >               goto out_free_ex;
> >       }
> >
> > -     nparms->tcfp_off_max_hint =3D 0;
> >       nparms->tcfp_flags =3D parm->flags;
> >       nparms->tcfp_nkeys =3D parm->nkeys;
> >
> > @@ -268,14 +269,6 @@ static int tcf_pedit_init(struct net *net, struct =
nlattr *nla,
> >                                                  BITS_PER_TYPE(int) - 1=
,
> >                                                  nparms->tcfp_keys[i].s=
hift);
> >
> > -             /* The AT option can read a single byte, we can bound the=
 actual
> > -              * value with uchar max.
> > -              */
> > -             cur +=3D (0xff & offmask) >> nparms->tcfp_keys[i].shift;
> > -
> > -             /* Each key touches 4 bytes starting from the computed of=
fset */
> > -             nparms->tcfp_off_max_hint =3D
> > -                     max(nparms->tcfp_off_max_hint, cur + 4);
> >       }
> >
> >       p =3D to_pedit(*a);
> > @@ -318,15 +311,12 @@ static void tcf_pedit_cleanup(struct tc_action *a=
)
> >               call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
> >  }
> >
> > -static bool offset_valid(struct sk_buff *skb, int offset)
> > +static bool offset_valid(struct sk_buff *skb, int offset, int len)
> >  {
> > -     if (offset > 0 && offset > skb->len)
> > -             return false;
> > -
> > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > +     if (offset < -(int)skb_headroom(skb))
> >               return false;
> >
> > -     return true;
> > +     return offset <=3D (int)skb->len - len;
> >  }
> >
> >  static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, cons=
t int header_type)
> > @@ -393,18 +383,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >       struct tcf_pedit_key_ex *tkey_ex;
> >       struct tcf_pedit_parms *parms;
> >       struct tc_pedit_key *tkey;
> > -     u32 max_offset;
> >       int i;
> >
> >       parms =3D rcu_dereference_bh(p->parms);
> >
> > -     max_offset =3D (skb_transport_header_was_set(skb) ?
> > -                   skb_transport_offset(skb) :
> > -                   skb_network_offset(skb)) +
> > -                  parms->tcfp_off_max_hint;
> > -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > -             goto done;
> > -
> >       tcf_lastuse_update(&p->tcf_tm);
> >       tcf_action_update_bstats(&p->common, skb);
> >
> > @@ -412,10 +394,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >       tkey_ex =3D parms->tcfp_keys_ex;
> >
> >       for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > +             int write_offset, write_len;
> >               int offset =3D tkey->off;
> >               int hoffset =3D 0;
> > -             u32 *ptr, hdata;
> > -             u32 val;
> > +             u32 cur_val, val;
> > +             u32 *ptr;
> >               int rc;
> >
> >               if (tkey_ex) {
> > @@ -433,13 +416,15 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >
> >               if (tkey->offmask) {
> >                       u8 *d, _d;
> > +                     int at_offset;
> >
> > -                     if (!offset_valid(skb, hoffset + tkey->at)) {
> > +                     if (check_add_overflow(hoffset, (int)tkey->at, &a=
t_offset) ||
>
> There is no real reason for checking the add.
> All that matters is that offset_valid() and skb_header_pointer() are
> passed the same offset.
> Assigning it to a local would make that clearer.

You are technically correct - but earlier discussion was I believe
that signed integer overflow as undefined behavior and those checks
are there to avoid that and logic bypasses.

>
> > +                         !offset_valid(skb, at_offset, sizeof(_d))) {
> >                               pr_info_ratelimited("tc action pedit 'at'=
 offset %d out of bounds\n",
> >                                                   hoffset + tkey->at);
> >                               goto bad;
> >                       }
> > -                     d =3D skb_header_pointer(skb, hoffset + tkey->at,
> > +                     d =3D skb_header_pointer(skb, at_offset,
> >                                              sizeof(_d), &_d);
> >                       if (!d)
> >                               goto bad;
> > @@ -451,31 +436,51 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >                       }
> >               }
> >
> > -             if (!offset_valid(skb, hoffset + offset)) {
> > -                     pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n", hoffset + offset);
> > +             if (check_add_overflow(hoffset, offset, &write_offset)) {
> > +                     pr_info_ratelimited("tc action pedit offset overf=
low\n");
> >                       goto bad;
> >               }
> >
> > -             ptr =3D skb_header_pointer(skb, hoffset + offset,
> > -                                      sizeof(hdata), &hdata);
> > -             if (!ptr)
> > +             if (!offset_valid(skb, write_offset, sizeof(*ptr))) {
> > +                     pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n",
> > +                                         write_offset);
> >                       goto bad;
> > +             }
>
> Again all that matters is that the same value is passed to offset_valid()
> and skb_header_pointer().

Same comment as earlier.
Note: we replaced skb_header_pointer() with direct memory access "ptr
=3D (u32 *)(skb->data + write_offset)" further down.
so extra validation of write_offset is justifiable, no?


> > +
> > +             if (write_offset < 0) {
> > +                     if (skb_cow(skb, -write_offset))
> > +                             goto bad;
> > +                     if (write_offset + (int)sizeof(*ptr) > 0) {
> > +                             if (skb_ensure_writable(skb,
> > +                                                     min_t(int, skb->l=
en,
> > +                                                           write_offse=
t + (int)sizeof(*ptr))))
>
> That min isn't needed (same as below).

Ok - yes, i see that. Same with the min(). Why did we think we needed
min/min_t() before?

> > +                                     goto bad;
> > +                     }
> > +             } else {
> > +                     if (check_add_overflow(write_offset, (int)sizeof(=
*ptr),
> > +                                            &write_len))
>
> That can't fail because of the 'return offset <=3D (int)skb->len - len;' =
check.

True.

>
> > +                             goto bad;
> > +                     if (skb_ensure_writable(skb, min_t(int, skb->len,
> > +                                                        write_len)))
>
> Similarly that min_t() will return 'write_len'.
> But is that even correct?
> The code wants to write 4 bytes at skb->data + write_offset.
> I can't see where the offset is used.
> All the overflow tests have made the logic far too hard to follow.
>
> I think that whole lot can just be:
>         hoffset +=3D offset;
>         if (offset_valid(skb, hoffset, sizeof(hdata)))
>                 goto bad;
>
>         /* Ensure any needed headroom is writeable */
>         if (hoffset < 0 && skb_cow(skb, -hoffset)
>                 goto bad;
>         /* Ensure the skb is writeable to the end of the area to be writt=
en.
>          * The data is pulled into the skb header. */
>         if ((hoffset >=3D 0 || hoffset + (int)sizeof(hdata) > 0) &&
>             skb_ensure_writable(skb, hoffset + (int)sizeof(hdata))
>                 goto bad;
> The call to offset_valid() does all the other checks.
> (The hoffset >=3D 0 check is the inverse of the earlier check and will
> be optimised away - skipping the second second test which is then
> always true.)

Yes, that code is more readable.

> If you really want a warning message, put a generic one on 'bad;'.
>
> > +                             goto bad;
> > +             }
> > +
> > +             ptr =3D (u32 *)(skb->data + write_offset);
> > +             cur_val =3D get_unaligned(ptr);
>
> Given you are doing an unaligned read you could remove the check in the
> 'offmask' path that the final offset is a multiple of 4.
> Nothing checked that tkey->off is a multiple of 4, and I suspect that
> is user-specifiable?

The only reason i will keep that check is because we have always
checked for the 32b alignment from an API perspective. I am less
worried about than potentially breaking something in the hardware
offload path when a user passes unaligned offsets down given that
these code paths (towards hardware) have been well vetted.

I am trying to get this security fix in. Do you see anything in what
you stated as a show stopper? IOW introducing regression or plain
wrong?
If not, I will wait for the AI review or if someone finds an issue
which breaks something - and if it is worth going back then i will
consider your suggestions as part of the next update.
Does that sound reasonable?

cheers,
jamal

> I'm also not entirely that the mac_header is aligned.
>
> -- David
>
> >               /* just do it, baby */
> >               switch (cmd) {
> >               case TCA_PEDIT_KEY_EX_CMD_SET:
> >                       val =3D tkey->val;
> >                       break;
> >               case TCA_PEDIT_KEY_EX_CMD_ADD:
> > -                     val =3D (*ptr + tkey->val) & ~tkey->mask;
> > +                     val =3D (cur_val + tkey->val) & ~tkey->mask;
> >                       break;
> >               default:
> >                       pr_info_ratelimited("tc action pedit bad command =
(%d)\n", cmd);
> >                       goto bad;
> >               }
> >
> > -             *ptr =3D ((*ptr & tkey->mask) ^ val);
> > -             if (ptr =3D=3D &hdata)
> > -                     skb_store_bits(skb, hoffset + offset, ptr, 4);
> > +             put_unaligned((cur_val & tkey->mask) ^ val, ptr);
> >       }
> >
> >       goto done;
>

