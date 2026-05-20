Return-Path: <netdev+bounces-289868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aANgEc2IDWpdygUAu9opvQ
	(envelope-from <netdev+bounces-289868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:11:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B151C58B70C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79A8030B25D0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E93C4576;
	Wed, 20 May 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj2aQomv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDD3D3339
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271530; cv=pass; b=YgpYnb1g9enynL9AOBX7/ruRm90z2CZpupujinXVtsFoqt2k4yRsCcKZVNguEVOOF+qUxbZKu1z6W47cajeRMn22gZu4Lw/T1ozadJYwNBKkyuhoaRkxelUXtbkgA8IQWtgElLjK6ZJcngmQGuWa7LBeH9WHygbxO9/aNfOMr0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271530; c=relaxed/simple;
	bh=SvBlrVzB2PNF8WSmusRhHLIUi/0AQrtxs9FN+toznKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW812dOARMeyBZo1uQYWhCvb3z66g2qyJPqZXdQwH65xbaLBhGrTjVsMzYi5IxTn/m75bFcf4tsXYA7u7c8x2Uf907my+p3WBJHhxM8KdGsTVJU2Lh46ZnaRi4VO5FSQhRnND4EWMjsXPbpkFw5VwDGRwHdwloWLEgDyGXQDH+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj2aQomv; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd5047a2a4cso750345766b.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779271526; cv=none;
        d=google.com; s=arc-20240605;
        b=Nc+p530Yz2LsJ0t5UCvV0hQ+ye9v7uobL7OHMr+TfDF+mEvM0ud9yZdrF158YfvA6s
         qbA2bbkLGifMQcmsJg2bnNcrACZim88pr0136CBxAaHtCySlhMJ/MoQy9IJXZtBeqjO8
         eDhELSsj5Y32JtdUNH/WzZcnQIoo+/A/lVl6w84tgZhHxoTkz2tCSXxZPeqrdGr+HpIp
         tEeo/ZHUMubiBWISsV/S6dM0ds/l+kKkjvEuVpK0UV5abgnt2nDgZDucoidAdlGKc50m
         C/OjDKW1MXBYYObb0D11B7grmY5Hs1Ab+T4IpQVJoGJ86ZvpUgtUSB7iVhsDxzFKhxWe
         mqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xOuv9gIDFk2AV1ir59DHFt0RruUAZh5T/FINapyvQlk=;
        fh=wl3RA01w3iFmMNKIruF+Wc/DHn7XEm69JcSa9rAG8Gk=;
        b=fCYabX4H6NN4CYkNjyd+PD2R1MWlkh6XBxbsrodhjFo3K9hGnY7702x4MzulC8fNyw
         GGs97nrk908ztuqXRPoDam49/lHTzOxGlydESWFBgEluCHVeszly2OQpEzfFUCs6jjy2
         VFFI/f4ybSqSIDlGOvyES9DGSW6CEQGWWw9IT9mi4wecdR9eULyVd0xiD2gQqzKOMn8V
         QRB05RQsoU0TJ+7nev5qF7qvmD+xeroqFa3gRidih0+hD1r8AvDt0i1R7MVNIsD+Pvvt
         uQ9IAxA+7xyAXKlr6Xq1tjrn65i1n/1IT7/TFTQldOYloOS2xs/Vlyq3REgzin4Yk1P3
         8kNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779271526; x=1779876326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOuv9gIDFk2AV1ir59DHFt0RruUAZh5T/FINapyvQlk=;
        b=Gj2aQomvqooPSM5DfkCKzLnd2iUndJ2fYdPoPz3i+ye2Hxl6FAqnvG+JC/CqPprdv5
         VW88aJxiE/yUdhDwzhe2vHmtZr6VnRKFrGHd+nr1Ta4JcKlF846J+uAgHp3o2QB4wevb
         JFVQ8nph+2YiL2g6gyJDLn8+iMn0ehWiRICinx//h8OHlPPS/GLyRTh9hI/8JySHZffy
         V5g4Xw47iGPRUZhmTEg/VRhSGdV9v6T4nPyxX8j/6DprHb5kMnI5eqsvdAnxENgMjPJy
         /My4cq/5uO/ezHx2UJJMUlRCx3HPtxX8Zw+FJetkHPk7/Xyre6uMWuytTNtN58hUBS4M
         Ae5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271526; x=1779876326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xOuv9gIDFk2AV1ir59DHFt0RruUAZh5T/FINapyvQlk=;
        b=sXi6KPBtLDLNi955a02aOcLZQocgc1NdVu2Ko6XN/2+KnGtXVJqg5qdePjNnuRxHd1
         c2wQLf8byCYGimpqoTh6meF4xprxhJZHvTKFHv/wSrSNNXg6LI0EQ0d0pSwG71gTazNw
         Gi7ULQZ0Dm8kSIhUlOm1txdEersIOvfSTqKP1Wzl4i3U8haReeXB+j3SzdBnje2p0Z1B
         5ft0wq7+P8KmlVEl/1JRq9eXtloCemS+1N/GhIXsw6ONhwAgIMizg7S87Y23cdudNFr6
         7rmlD1hWGeSyO6hQUAq8wdU/7DfyA/Kj1HeSYuW++oaXOuPHIkeZjK8tmisv2NYL9ppJ
         PDaw==
X-Forwarded-Encrypted: i=1; AFNElJ8gBDqtRzT55X9/+SuZsIQBt7uE6fgPb55n8Aa9aQCE087LupebMPb/VrNg8/ikxmVT9AULV2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7llYiVghu67EDog9prVSR+ZgVM0Gk2oUXhWiagkK9PFCaNqa
	2smb61sowUHv4wtHmeLB137TjdEfAmRQ2tgBwft6pyWC1kNWUmqZ3ODAsY1JjZbeCx3F/PwtgLK
	LJ8sXneV2xhyWQWGB9douxBX8HwEpwyA=
X-Gm-Gg: Acq92OG03v8HibORSzFfQmOmAr5b7u+xepqgPh5jJFyHwdJRZWHFd1v9loouTmVM+8E
	2y49gbyrhSl/FRWFUgB0YPPCGwWPSr5+6x70H0FQjll6aDHhPtC2HDoiR5ts+mP1L+nJrwPKACh
	cc7gMFwRW4O4jsEO13+tnCUqqewhGKNNpswD4cI3fE/nCMhsrlqNqxgBkKPzkrlFeW+rf0Zxzwz
	4I4dMgd9zecB1Ulg8//bwkhpz+TdTHluzAw0m4XbubXU6xa8c5WX6C4lcUXKiZmigec9kj0xplH
	bwmuxNw=
X-Received: by 2002:a17:907:8748:b0:b9d:1673:9994 with SMTP id
 a640c23a62f3a-bd51793014amr1434740266b.39.1779271526127; Wed, 20 May 2026
 03:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAOPYjvb8d61sappVT6VxBd9rLsK0q3wHaiMsYp5cFXty0NOU5w@mail.gmail.com>
 <CAM0EoMkaFabdr11nfiabpEjO_0iB7uKAd9_nFWX=yj-O=8YF0Q@mail.gmail.com>
In-Reply-To: <CAM0EoMkaFabdr11nfiabpEjO_0iB7uKAd9_nFWX=yj-O=8YF0Q@mail.gmail.com>
From: Han Guidong <2045gemini@gmail.com>
Date: Wed, 20 May 2026 18:04:49 +0800
X-Gm-Features: AVHnY4In8owKQ9yaJHl2lpB7vB734uUFcd3OAsEcqe_M-s7lFJuc3I1NUbOgxNM
Message-ID: <CAOPYjvYKJTiEGmugAqsuQhBd1LCuggepNGQh4kdhc0w3kdqnAg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2045gemini@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: B151C58B70C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:12=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, May 19, 2026 at 11:11=E2=80=AFAM Han Guidong <2045gemini@gmail.co=
m> wrote:
> >
> > On Tue, May 19, 2026 at 11:42=E2=80=AFAM Rajat Gupta
> > <rajat.gupta@oss.qualcomm.com> wrote:
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
> > >
> > > Additionally, linearize skbs with shared frags upfront to prevent
> > > silent data corruption when pedit operates on zero-copy pages
> > > (e.g. from sendfile).
> > >
> > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is =
writable")
> >
> > Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offs=
et")
> > Cc: stable@vger.kernel.org
> >
> > I took a closer look at the code, and this patch is really addressing
> > two issues.
> >
> > The negative-offset write into shared head/headroom appears to be from
> > 8b796475fd78, while the shared-frag write, and thus possible
> > page-cache corruption, appears to be the later regression from
> > 6c02568fd1ae. So it may be worth adding an additional Fixes tag for
> > 6c02568fd1ae,
>
> Pushing it a little - but sure we should also point to that commit.
>
> > and I think an explicit Cc: stable@vger.kernel.org would also make sens=
e here.
>
> Please study the rules.

I will review the rules. Sorry for the noise.

>
> > > Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > > Reported-by: Han Guidong <2045gemini@gmail.com>
> > > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > > Tested-by: Han Guidong <2045gemini@gmail.com>
> > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > ---
> > >  net/sched/act_pedit.c | 54 ++++++++++++++++++++++++++++++++---------=
--
> > >  1 file changed, 41 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > index bc20f08a2..79921b8d8 100644
> > > --- a/net/sched/act_pedit.c
> > > +++ b/net/sched/act_pedit.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/ip.h>
> > >  #include <linux/ipv6.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/overflow.h>
> > >  #include <net/ipv6.h>
> > >  #include <net/netlink.h>
> > >  #include <net/pkt_sched.h>
> > > @@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, in=
t offset)
> > >         if (offset > 0 && offset > skb->len)
> > >                 return false;
> > >
> > > -       if  (offset < 0 && -offset > skb_headroom(skb))
> > > -               return false;
> > > +       if (offset < 0) {
> > > +               if (offset =3D=3D INT_MIN || -offset > skb_headroom(s=
kb))
> > > +                       return false;
> > > +       }
> > >
> > >         return true;
> > >  }
> > > @@ -393,17 +396,21 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >         struct tcf_pedit_key_ex *tkey_ex;
> > >         struct tcf_pedit_parms *parms;
> > >         struct tc_pedit_key *tkey;
> > > -       u32 max_offset;
> > >         int i;
> > >
> > >         parms =3D rcu_dereference_bh(p->parms);
> > >
> > > -       max_offset =3D (skb_transport_header_was_set(skb) ?
> > > -                     skb_transport_offset(skb) :
> > > -                     skb_network_offset(skb)) +
> > > -                    parms->tcfp_off_max_hint;
> > > -       if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > > -               goto done;
> > > +       /*
> > > +        * If the skb has shared frags the user is likely using zero-=
copy
> > > +        * (e.g. sendfile).  Those page frags may point to page-cache=
 pages;
> > > +        * writing into them would silently corrupt the page cache.
> > > +        * Linearize so pedit operates on a private copy.
> > > +        * TL;DR: if you want zero-copy, don't use pedit.
> > > +        */
> > > +       if (skb_has_shared_frag(skb)) {
> > > +               if (__skb_linearize(skb))
> > > +                       goto bad;
> > > +       }
> > >
> > >         tcf_lastuse_update(&p->tcf_tm);
> > >         tcf_action_update_bstats(&p->common, skb);
> > > @@ -412,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> > >         tkey_ex =3D parms->tcfp_keys_ex;
> > >
> > >         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > > +               int write_offset, write_len;
> > >                 int offset =3D tkey->off;
> > >                 int hoffset =3D 0;
> > >                 u32 *ptr, hdata;
> > > @@ -451,12 +459,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >                         }
> > >                 }
> > >
> > > -               if (!offset_valid(skb, hoffset + offset)) {
> > > -                       pr_info_ratelimited("tc action pedit offset %=
d out of bounds\n", hoffset + offset);
> > > +               if (unlikely(check_add_overflow(hoffset, offset,
> > > +                                               &write_offset))) {
> >
> > I also noticed two remaining unchecked additions, e.g. hoffset +
> > tkey->at and offset +=3D (*d & offmask) >> shift. These look more like
> > wrap/type-semantics cleanup than a practical signed-overflow/UB issue
> > to me, so I am OK with this patch as-is.
>
> Did you get this from some AI?
> None of these are possible. Both additions you mention are safe in
> practice because any potential wrap around or overflow is caught
> _before any memory access occurs_. Example see:
> offset_valid() which implictly casts hoffset + key to signed int.

Not AI-generated. I was looking at the code and noticed that
tc_pedit_key fields are unsigned, but the results are stored in int
offset and int hoffset. I was just thinking about odd edge cases where
an unsigned-to-signed conversion results in a negative number. I agree
with you that offset_valid() catches this anyway, so it causes no
actual harm.

>
> > > +                       pr_info_ratelimited("tc action pedit offset o=
verflow\n");
> > > +                       goto bad;
> > > +               }
> > > +
> > > +               if (!offset_valid(skb, write_offset)) {
> > > +                       pr_info_ratelimited("tc action pedit offset %=
d out of bounds\n",
> > > +                                           write_offset);
> > >                         goto bad;
> > >                 }
> > >
> > > -               ptr =3D skb_header_pointer(skb, hoffset + offset,
> > > +               if (write_offset < 0) {
> >
> > There is also a small negative-offset 4-byte-write corner case, e.g.
> > an ETH-relative edit with hoffset=3D-14 and offset=3D12, giving a final
> > write_offset=3D-2; if the linear head after skb->data is only 1 byte,
> > that store spans -2..1. That seems unlikely in practice; fixing it
> > would be nice, but I would not hold this patch for it.
> >
>
> Again smells AI generated. I spent a lot of time trying to determine
> the practicality and validity of this (and your previous claim), only
> to find that this whole claim is based on  a view that a headroom of 1
> byte is a valid scenario in practice. Is it theoretically possible
> from the math? yes. Practically, I don't see how it makes any sense.
> Can you describe a scenario where this would happen in practise?

As I mentioned in the previous mail, I agree it is unlikely in
practice. For context, this was an edge case brought up by sashiko
regarding our patch. I wrote a test kernel module and verified that if
an skb is artificially constructed with exactly 1 byte of headroom,
skb_cow() is indeed insufficient. However, I also checked real-world
packets and the headroom is always plenty, so I agree it doesn't
happen in the real world.

>
> > Reviewed-by: Han Guidong <2045gemini@gmail.com>
>
> More like reviewed by my AI who goes by the name foobar.

I will work on improving my review quality going forward. Sorry again
for the noise.

Thanks.

>
> cheers,
> jamal
>
> >
> >
> > > +                       if (skb_cow(skb, -write_offset))
> > > +                               goto bad;
> > > +               } else {
> > > +                       if (unlikely(check_add_overflow(write_offset,
> > > +                                                       (int)sizeof(h=
data),
> > > +                                                       &write_len)))
> > > +                               goto bad;
> > > +                       if (skb_ensure_writable(skb, min_t(int, skb->=
len,
> > > +                                                          write_len)=
))
> > > +                               goto bad;
> > > +               }
> > > +
> > > +               ptr =3D skb_header_pointer(skb, write_offset,
> > >                                          sizeof(hdata), &hdata);
> > >                 if (!ptr)
> > >                         goto bad;
> > > @@ -475,7 +503,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> > >
> > >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> > >                 if (ptr =3D=3D &hdata)
> > > -                       skb_store_bits(skb, hoffset + offset, ptr, 4)=
;
> > > +                       skb_store_bits(skb, write_offset, ptr, sizeof=
(hdata));
> > >         }
> > >
> > >         goto done;
> > > --
> > > 2.51.2.windows.1
> > >

