Return-Path: <netdev+bounces-289852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O6+AKiADWosyAUAu9opvQ
	(envelope-from <netdev+bounces-289852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:36:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A758AE19
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D14303D32E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F53A759D;
	Wed, 20 May 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="luEEpQSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CC3BA244
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268362; cv=pass; b=m56g0x5T8KeCe+iBtzH/Inx71SjLYFyzAY3czSbArUSyhl01AUleWh0eWSaGeLHzp53vz4AvLvqNhztpsaPcfRZ32pyC5FvkRFGJCg3HUhMeOGW2CIlNNotu0Wjve00EZsPG8X1PbkjyxEIG0SA1wGX63kg7eE6OFG8Hc9OlPmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268362; c=relaxed/simple;
	bh=ikBsW6G/6CgOHrqRDx4yuppWYW09fjEtmX6ksKNNZkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+V/9frA1GpkkVcTYp/s9MmxOFtdhlpnbrbLQ6svjY8cX8jvvRtTdicYb7822nP4orA6Klpm/fsoZBg+70HE2H3cBeM8Zl2y/oWudvTZxGJ1FFijAItaXv/V/WOAbYX16M9ABM13/0F7uG35UjVMEzfRrCX0ER6R1OXHgoeopOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=luEEpQSE; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so2043567b3a.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779268360; cv=none;
        d=google.com; s=arc-20240605;
        b=N5jgsmm4HDprLzrdYnFoDi/AW++SkWL2TUMBg88ctbfhS9DmySCw4bMq7Fe9vhK79b
         bkzm/3S+JukFtikI26f2Y/n50uPKC9ST88yPeVFx1eb2baTtdk8cz7NXli0h9FnQ0Myl
         AEDzCO7xUfeJ+LM9nyTgrcaiQELPI1+VoZUhZw3Zxx7KK+zBgqx8EZlQRJ+1AytC0x4j
         L6/p7Iy6tVHGbJdh2Iki2MTXZNMBjRIYWvF06UhK6lCpKto9qKOO5PIBLfSOJkb+WW7Z
         Q2NHYAEwr+tr4kWoAYZHqAyJNwNLgYj5VPG03dG9OXoQPuPJLUvINPCbomviktNlsbLT
         4tEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dO8RqaFSEbMVg8IK2D60HRDuSUczChIN5tONS0/svBU=;
        fh=8wHmie2oYSiExAqw5O1u6O6m24kZ6swVUYxBJvYHELA=;
        b=kS0PqylRWIaGANETUuEpfCCpTdpWH+pv9r0eWEXkdK4dLc27msM0NypJ4/QDVH67y5
         WD5+PYNcWOETrTtNibp0XwVTZplfPnPx4q4Nr8dTYSKDlYhb/CSRqQtRH5IHN72WJ1vi
         9pddJTmj4UjD0iiT+Q146HIo0kolaqBEc+UVDcd5oefdVYBomE0kwMwGpWTRwxSx1P3y
         eYdJWBWNOC/UZYGdJtSRf42uiv0fGIBy6IVvlAi/lTN1U1ZIJ9gBUTCO/5tESDhpoAW9
         ZkqxWheCRBEeYX5B6erYVAX+oRjmuByx9bCUvAwm4KHVyVihj4Y51ZAQHLQtbRK5iQAL
         P9mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779268360; x=1779873160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO8RqaFSEbMVg8IK2D60HRDuSUczChIN5tONS0/svBU=;
        b=luEEpQSEiHjPC4etnxc5/h4WoMyvebStsoRL44rrtI7UMW8/m71LSnSl+Kb9TtyxnI
         PZU8lL2C4/66+GKz0cjxM7QTYqCD/X1WGUcSK/NdjG1FH4bFm9tIXiRxlM2SWwPeAYCJ
         kWNtsoLGXNdrmI3SZZG862V72SFrDSWkK0uozaOfqNqver35jo3iANUH5Jss+W69bTJm
         Ly5QxyzmFX4Pwm5sU682ftktvOgaA7ffEd2JNeWJEJMQNgOlvNCPG/JhjikBi3eGcn1S
         V8WSk9BxkgBUL7cXakEjLR74/eEXpwuAcJjYEAchOqSFGWWqIkkPu/294wYEapA8WGj3
         PzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268360; x=1779873160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dO8RqaFSEbMVg8IK2D60HRDuSUczChIN5tONS0/svBU=;
        b=fF98qZTLHrA5sbBJ5MnvpcvfzL/+vG5tyfLNBoq+g5Gi0kpqgqZqJy5N9c6Qcq6TGc
         qIGQGj6hXV3iTZSEDm68XPrntVlwNMv5+bgtR+gUC42jZswygF4PiC2kBsGzJywz6kYE
         Zo8mggtpIGpucgo6tCH8Yg/s0ysv9UWRhdFOggCQBN/ezyaa2AXcsktiPF7+4hII/8O3
         ssWfC99RSu6GjU+hz2Pv2EKidz8YeyZwhb5mHF/OvLV2j8eecStlRhpOIIUO/Zq9K2Ik
         BFX7xb78r4REyvTsTEsq2VUnrA91lPpgPNJEBXOv3b3fi6JPtI/P43mnl0NAAuHrEAgH
         P7kQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CMj0pD8soIY1iYbqJPu0YOPs7hTxx980ThChu1B4AaWaRlpNxPjIl9Y+8CvVMLmBc6mCh+IU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lukqysBQzqqjSRncDkZyUFJ3rrasDNlW+BmvwKLGnJtEpt+G
	KmMzTiu0x+UO9R7IlHIJJPLDXzWh7N/m7QLUYYVbcjpbYNjHHDEeRDoSzo69RJwRroMN6/GwOpQ
	u0D5xaXS+KHhvQ1poI6wUIpWd869loowghvnR0a32
X-Gm-Gg: Acq92OHDBrroFgNqduwpNA78iEZBMosGycg9O/SPgTslSaYhIT/s7ATu7xggmh6szAo
	WzIXpSpZDSm/1WTSUwuxkOtSxYNO8YwD2yml6/BIOS53OggwygaOtFvJxqFFof6s2kQ7X5lsQJH
	08v6TKyAem3ujpCLfZsTKyn8ojLuPTjEfom0hhOWuOwWe9hPNdQROvfQB7SotsXpqQ1ThNfzjL+
	exMYiBuglBswMKv5YX2Psn4XklGavZxNIFXFgfsfCwdjKKTyuMF83SA0bX4sBmDUaegs6SirWQ2
	eTQ1lxU03gBB+sKOEXU=
X-Received: by 2002:a05:6a00:a586:b0:82f:5a77:10e8 with SMTP id
 d2e1a72fcca58-83f33c2ec80mr24327087b3a.20.1779268359697; Wed, 20 May 2026
 02:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAOPYjvb8d61sappVT6VxBd9rLsK0q3wHaiMsYp5cFXty0NOU5w@mail.gmail.com>
In-Reply-To: <CAOPYjvb8d61sappVT6VxBd9rLsK0q3wHaiMsYp5cFXty0NOU5w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 May 2026 05:12:28 -0400
X-Gm-Features: AVHnY4I4nuWIQ0xqM5G2b8tYHray-89lV1iwhwOtr8xD9xYZdXZXn4aIhnh71WM
Message-ID: <CAM0EoMkaFabdr11nfiabpEjO_0iB7uKAd9_nFWX=yj-O=8YF0Q@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Han Guidong <2045gemini@gmail.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289852-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: 4F1A758AE19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:11=E2=80=AFAM Han Guidong <2045gemini@gmail.com>=
 wrote:
>
> On Tue, May 19, 2026 at 11:42=E2=80=AFAM Rajat Gupta
> <rajat.gupta@oss.qualcomm.com> wrote:
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
> >
> > Additionally, linearize skbs with shared frags upfront to prevent
> > silent data corruption when pedit operates on zero-copy pages
> > (e.g. from sendfile).
> >
> > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is wr=
itable")
>
> Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offset=
")
> Cc: stable@vger.kernel.org
>
> I took a closer look at the code, and this patch is really addressing
> two issues.
>
> The negative-offset write into shared head/headroom appears to be from
> 8b796475fd78, while the shared-frag write, and thus possible
> page-cache corruption, appears to be the later regression from
> 6c02568fd1ae. So it may be worth adding an additional Fixes tag for
> 6c02568fd1ae,

Pushing it a little - but sure we should also point to that commit.

> and I think an explicit Cc: stable@vger.kernel.org would also make sense =
here.

Please study the rules.

> > Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > Reported-by: Han Guidong <2045gemini@gmail.com>
> > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > Tested-by: Han Guidong <2045gemini@gmail.com>
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > ---
> >  net/sched/act_pedit.c | 54 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 41 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index bc20f08a2..79921b8d8 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/ip.h>
> >  #include <linux/ipv6.h>
> >  #include <linux/slab.h>
> > +#include <linux/overflow.h>
> >  #include <net/ipv6.h>
> >  #include <net/netlink.h>
> >  #include <net/pkt_sched.h>
> > @@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, int =
offset)
> >         if (offset > 0 && offset > skb->len)
> >                 return false;
> >
> > -       if  (offset < 0 && -offset > skb_headroom(skb))
> > -               return false;
> > +       if (offset < 0) {
> > +               if (offset =3D=3D INT_MIN || -offset > skb_headroom(skb=
))
> > +                       return false;
> > +       }
> >
> >         return true;
> >  }
> > @@ -393,17 +396,21 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >         struct tcf_pedit_key_ex *tkey_ex;
> >         struct tcf_pedit_parms *parms;
> >         struct tc_pedit_key *tkey;
> > -       u32 max_offset;
> >         int i;
> >
> >         parms =3D rcu_dereference_bh(p->parms);
> >
> > -       max_offset =3D (skb_transport_header_was_set(skb) ?
> > -                     skb_transport_offset(skb) :
> > -                     skb_network_offset(skb)) +
> > -                    parms->tcfp_off_max_hint;
> > -       if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > -               goto done;
> > +       /*
> > +        * If the skb has shared frags the user is likely using zero-co=
py
> > +        * (e.g. sendfile).  Those page frags may point to page-cache p=
ages;
> > +        * writing into them would silently corrupt the page cache.
> > +        * Linearize so pedit operates on a private copy.
> > +        * TL;DR: if you want zero-copy, don't use pedit.
> > +        */
> > +       if (skb_has_shared_frag(skb)) {
> > +               if (__skb_linearize(skb))
> > +                       goto bad;
> > +       }
> >
> >         tcf_lastuse_update(&p->tcf_tm);
> >         tcf_action_update_bstats(&p->common, skb);
> > @@ -412,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
> >         tkey_ex =3D parms->tcfp_keys_ex;
> >
> >         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > +               int write_offset, write_len;
> >                 int offset =3D tkey->off;
> >                 int hoffset =3D 0;
> >                 u32 *ptr, hdata;
> > @@ -451,12 +459,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >                         }
> >                 }
> >
> > -               if (!offset_valid(skb, hoffset + offset)) {
> > -                       pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n", hoffset + offset);
> > +               if (unlikely(check_add_overflow(hoffset, offset,
> > +                                               &write_offset))) {
>
> I also noticed two remaining unchecked additions, e.g. hoffset +
> tkey->at and offset +=3D (*d & offmask) >> shift. These look more like
> wrap/type-semantics cleanup than a practical signed-overflow/UB issue
> to me, so I am OK with this patch as-is.

Did you get this from some AI?
None of these are possible. Both additions you mention are safe in
practice because any potential wrap around or overflow is caught
_before any memory access occurs_. Example see:
offset_valid() which implictly casts hoffset + key to signed int.

> > +                       pr_info_ratelimited("tc action pedit offset ove=
rflow\n");
> > +                       goto bad;
> > +               }
> > +
> > +               if (!offset_valid(skb, write_offset)) {
> > +                       pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n",
> > +                                           write_offset);
> >                         goto bad;
> >                 }
> >
> > -               ptr =3D skb_header_pointer(skb, hoffset + offset,
> > +               if (write_offset < 0) {
>
> There is also a small negative-offset 4-byte-write corner case, e.g.
> an ETH-relative edit with hoffset=3D-14 and offset=3D12, giving a final
> write_offset=3D-2; if the linear head after skb->data is only 1 byte,
> that store spans -2..1. That seems unlikely in practice; fixing it
> would be nice, but I would not hold this patch for it.
>

Again smells AI generated. I spent a lot of time trying to determine
the practicality and validity of this (and your previous claim), only
to find that this whole claim is based on  a view that a headroom of 1
byte is a valid scenario in practice. Is it theoretically possible
from the math? yes. Practically, I don't see how it makes any sense.
Can you describe a scenario where this would happen in practise?

> Reviewed-by: Han Guidong <2045gemini@gmail.com>

More like reviewed by my AI who goes by the name foobar.

cheers,
jamal

>
>
> > +                       if (skb_cow(skb, -write_offset))
> > +                               goto bad;
> > +               } else {
> > +                       if (unlikely(check_add_overflow(write_offset,
> > +                                                       (int)sizeof(hda=
ta),
> > +                                                       &write_len)))
> > +                               goto bad;
> > +                       if (skb_ensure_writable(skb, min_t(int, skb->le=
n,
> > +                                                          write_len)))
> > +                               goto bad;
> > +               }
> > +
> > +               ptr =3D skb_header_pointer(skb, write_offset,
> >                                          sizeof(hdata), &hdata);
> >                 if (!ptr)
> >                         goto bad;
> > @@ -475,7 +503,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
> >
> >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> >                 if (ptr =3D=3D &hdata)
> > -                       skb_store_bits(skb, hoffset + offset, ptr, 4);
> > +                       skb_store_bits(skb, write_offset, ptr, sizeof(h=
data));
> >         }
> >
> >         goto done;
> > --
> > 2.51.2.windows.1
> >

