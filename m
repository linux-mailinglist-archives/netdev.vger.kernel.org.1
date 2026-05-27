Return-Path: <netdev+bounces-292398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIq4N40gF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:49:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956935E7FF2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB57C300E613
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A273C4B64;
	Wed, 27 May 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="UtTLEax/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B662EDD78
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900541; cv=pass; b=XswHB9pi3IjbJal7XPWZL/TyCTKRQ74z2zNUDQB8FCCTNuc3aUCjApA4+q53GTI0rsCItFK9AHCJgGfcANyyCAIkkGf9i7WkpJiyZJO3n8dSOf6ivoyr/LA+r7xRlPljT4yIe/R3z6sBytZpIBL8dPwtObdYEoJLCAZYurlZMtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900541; c=relaxed/simple;
	bh=zfWKrh9dHfoxdLNAJ4Qz/6r3Pt4m89vGvd7dYmffGdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyhW0La7R1BvWOm+ABwkrsrKr++sBJVPoUplTtBIkEmuKOi844lPo1HDxDZP0edK9rrSD2WB5CFn2+Eh/CxmLBdABdEyI7Nc/vDGHWdkurPS4+Tu1gwZf7+t8dE6F0cVEfxOMcgxOGrTjYfg9vTU+UINiKcDP9knttDhPBJHdN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=UtTLEax/; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-367c26471f5so7750529a91.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779900540; cv=none;
        d=google.com; s=arc-20240605;
        b=hrNXSD/IO/i4EpWjTuMf8RBuc/fh+JHeVsZyV5/JFlkoTem/Ax2WdAYZjDyEP8VlyT
         h6YDQl0VU8GfIrPtmRl1XUfSyb6ecyQsxlOuZAp3JIno8fmvv9npsl1LYsCWomYdPfuV
         LsFta65+6BOTu350j1NTDbHc7RZNs5Hriaf+5JHjsBW5PXll674xPjtJDuLPi9YauxXI
         KpWjpVx1wY381aU/bsNZLjijxs/KvrWSTLA75/Cbqh4YEAdpWhXs4kSNMRvSz8+xWxQz
         GrVzH2f1SHnT0+n8yljq38CM3lZHG53DJaI1num7to8K5NY04foSGmEQhNdx87RS9ncI
         69bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sPv2Y1e21vSP/MHJvRZfM0YnAJHl6x8Q2d/GJhgB1Gs=;
        fh=WmAJ/sskDM7/QZ+e+vXjLGJ0eID4Or2G64RuM5bOKN0=;
        b=ZODWBAtvFlu3G6H2Xve8P3mY0xl8zD8shvYW8DtDewsILrbP+EhKLO8jOEExfjKSHU
         nwWk21TF4+ex3M99Gx+AUkHo/vgcddw6xon4KRfI+8dkIz8DOuMLDQ9bYkh3FUmbg3c9
         pWtMgFfx5anyPwJP/T4xi3QOTtma8BCD1qkEfM9cJVgG8L2JTSMckw1zxMzVkQ4lXE0g
         qKcwGWBTMMZiKl+yWXI5PoDfxjdRXkBv6FREuUqmRLQBzbMf1PdiEahELdTU/HcZnwdm
         3VuLzjWEA/kidWvgodVA/1CCeOiLxUVccCVPJBxstN9TdAz8im+f1wwvaY2RRnXn/aCg
         C8zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779900540; x=1780505340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPv2Y1e21vSP/MHJvRZfM0YnAJHl6x8Q2d/GJhgB1Gs=;
        b=UtTLEax/NFpuB6BtVn45gdIKHOlgwTBxX10q13aG71g060JcfYl9VOxGX1tmG+FlZI
         tkGOTm8lHAeC41slVb9wQjzkDHSZ8mjGooSRZQ8KYyNHqbTx6+VgqusliZHa8peh6E3x
         anaIp8nrsY5FLISxy1V6U3SgKui+Ge1RouKFgK2KuetkY3J/PJDQtvNsaZYPjQYPRKi/
         V3WpGXggFPpX0mZFOOERCi7OYa7Z0S8+cRoFOJj/ztP/4MQcxfsbrp9Ovo8x7A2uC9+r
         3kq5qLyYwVDmYeGp0FjDJK04qnfw0RtTT/+gNKTGJei2l7dur81QL4Pw4wWOC/KwQTMM
         84VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900540; x=1780505340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sPv2Y1e21vSP/MHJvRZfM0YnAJHl6x8Q2d/GJhgB1Gs=;
        b=pzqXOsOpC6bQMjjknVtIXH/uxPHRZDbdpZfVG9Uz/qeQ2eJ9+Vmska9/gWRfSSAhau
         jGeGkiRe9CxCf5CN8hUFXHGitDoYT+r4kYpOkWBJwXP7gxMg9K1TdlGyOKYWhsDDB4hJ
         dFg9euG25TBEpoC8d39/9lMMgVuVZ4+yVlFfq8CgtRFjWOKs5pHKV+FiDV2kNahhAK/8
         6HqyLoxFaUxc1F4u3iiHHnv/G/gzp0wIPelhmzMZVwc3NBa+TJ5P9aO+gp6dX8ZiQSet
         NG3HkQ7yK3z9DxZl8Lqc9d18J7CpH7c78oQ5fJbL6aMJoJy+IoTZ9X1D+nfagpkUipd7
         CDHA==
X-Forwarded-Encrypted: i=1; AFNElJ9QNwgRVrleMUSzzdijUwdJdFxuBWPbHAWiAQSFfLRhIY22cpSbvkJUsx4U1XbX/JZ8c/+l3YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiAMTO93HZfDSIV7oQCVB41uSy29FM4BtNaMRWiah3kpYc5Pu
	0ppvD1R9noOKORQbc5/y1RtSB7QgWuJCqfykEXkLK0dY1YS7NS01cZgj4BD/mqUbIysFwTQaZ26
	FfyxNv4w8G5di42BvV8tuRHOosRzQgPM/Pkcq/jEhJfF3AYdKb2N0fnfk
X-Gm-Gg: Acq92OGvEd9Q/qflh+Rss5liMiUnukatRUl9oeMYsBfLP+N7RIvbxAJndQi4KqQ5EZy
	D8g6CITFhA1uSgLyfbnjY8JoZwEn9P9ZZKFsS3l4BMd656hgSuNIfou61H7sSH6u117iOmDgTXW
	S4/40hUIIp14w7jKcCHBG7Inv8o6Wg6w6zoGt2Ld+Bxu5Tevu19fJ2lMu3CRB+n8WreaJ4XpzHo
	hsAQiSh+gP1/C/aVnWZQUXFJY6a1Bd8lhJTnXDqTH5yUqYHDE7Vr1lsf9h/NLeFSW6LA8hE9EQy
	5DyUnyz87hmERiRaZUKKHQBtrNYUIQ==
X-Received: by 2002:a17:90b:360b:b0:36a:88b3:cd5f with SMTP id
 98e67ed59e1d1-36a88b3cfd4mr13284029a91.19.1779900539760; Wed, 27 May 2026
 09:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526155913.1060694-1-jhs@mojatatu.com> <87wlwq2cxf.fsf@toke.dk>
 <CAM0EoMm_FcS0xSNmCjdXaRMfZh12jU71xM92Z50eVE8uk7tKFQ@mail.gmail.com> <20260527171310.0d5ed340@pumpkin>
In-Reply-To: <20260527171310.0d5ed340@pumpkin>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 May 2026 12:48:48 -0400
X-Gm-Features: AVHnY4Le0aA4R0ZntRn16KmPY2C2ko3c2EvEMvd2a_ofCje5aDU4UJOTj8Ck4nI
Message-ID: <CAM0EoMkwoiJ_LODqv_taoDTLvfrAYwPyRv2oGyP5P=q1b+1+OQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: David Laight <david.laight.linux@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com, dcaratti@redhat.com, 
	security@kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292398-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 956935E7FF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:13=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 27 May 2026 10:56:57 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> >  &&
> >
> > On Tue, May 26, 2026 at 3:22=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> > >
> > > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> > >
> > > > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > >
> > > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > > not account for the runtime header offset added by typed keys. This
> > > > can leave part of the write region un-COW'd.
> > > >
> > > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > > the actual write offset is known, and add overflow checking on the
> > > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > > offset_valid() against INT_MIN, where negation is undefined.
> > > >
> > > > Additionally, linearize skbs with shared frags upfront to prevent
> > > > silent data corruption when pedit operates on zero-copy pages
> > > > (e.g. from sendfile).
> > > >
> > > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb i=
s writable")
> > > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > > > Reported-by: Han Guidong <2045gemini@gmail.com>
> > > > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > >
> > > Re-ran the tests, and everything looks good, so:
> > >
> > > Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > >
> > > Also looked at the code, and I have a few nits below, but I'm really
> > > nitpicking here, so whether you end up fixing those or not:
> > >
> > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > >
> > >
> > > [...]
> > >
> > > > @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, i=
nt offset)
> > > >       if (offset > 0 && offset > skb->len)
> > > >               return false;
> > > >
> > > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > > +     if (offset < 0 && offset < -(int)skb_headroom(skb))
> > > >               return false;
> > >
> > > This change makes it really obvious that this is really just:
> > >
> > >         if (offset < -(int)skb_headroom(skb))
> > >                 return false;
> > >
> > > so, well, that would be clearer, IMO.
> > >
> > > But then I guess the same could be said of the positive case, so:
> > >
> > > static bool offset_valid(struct sk_buff *skb, int offset)
> > > {
> > >         if (offset > skb->len || offset < -(int)skb_headroom(skb))
> > >                 return false;
> > >
> > >         return true;
> > > }
> > >
> >
> > Yes, that improves readability. If i understood the discussion between
> > you and David L. something like this one liner would be reasonable?
> >
> > if (offset > (int)skb->len || offset < -(int)skb_headroom(skb))
>
> I doubt it will be measurable whatever you pick.
>
> Thinks, can 'we' get away with the much more readable:
>         offset + (int)skb_headroom(skb) < 0
> No need to worry about the '+' wrapping,

By that you mean if offset was _very large_ then things will overflow
and wrap around to a negative number?

> the first test will fail.
> Large -ve offset are going to stay negative.
> So it does look all right.
>

To use Toke's code golfing analogy, maybe let's just stay with the
last optimization I posted i.e " (offset > (int)skb->len || offset <
-(int)skb_headroom(skb))"  ?

cheers,
jamal

> >
> >
> > > > @@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk=
_buff *skb,
> > > >       struct tcf_pedit_key_ex *tkey_ex;
> > > >       struct tcf_pedit_parms *parms;
> > > >       struct tc_pedit_key *tkey;
> > > > -     u32 max_offset;
> > > >       int i;
> > > >
> > > >       parms =3D rcu_dereference_bh(p->parms);
> > > >
> > > > -     max_offset =3D (skb_transport_header_was_set(skb) ?
> > > > -                   skb_transport_offset(skb) :
> > > > -                   skb_network_offset(skb)) +
> > > > -                  parms->tcfp_off_max_hint;
> > > > -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > > > -             goto done;
> > > > -
> > > >       tcf_lastuse_update(&p->tcf_tm);
> > > >       tcf_action_update_bstats(&p->common, skb);
> > > >
> > > > @@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_=
buff *skb,
> > > >       tkey_ex =3D parms->tcfp_keys_ex;
> > > >
> > > >       for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > > > +             int write_offset, write_len;
> > > >               int offset =3D tkey->off;
> > > >               int hoffset =3D 0;
> > > > -             u32 *ptr, hdata;
> > > > +             u32 *ptr;
> > > >               u32 val;
> > > >               int rc;
> > > >
> > > > @@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk=
_buff *skb,
> > > >                       }
> > > >               }
> > > >
> > > > -             if (!offset_valid(skb, hoffset + offset)) {
> > > > -                     pr_info_ratelimited("tc action pedit offset %=
d out of bounds\n", hoffset + offset);
> > > > +             if (unlikely(check_add_overflow(hoffset, offset,
> > >
> > > It's a bit weird that this has the unlikely(), but the offset_valid()
> > > check doesn't?
> > >
> >
> > I focused on the bigger solution and worried more about timeliness to
> > get this patch in - but it seems the distros had already picked up the
> > first posted patch, so hakuna matata (Still, I should have caught
> > these unlikelies ;->). Yes on the second one you pointed out.
> > Will remove them.
> >
> > > > +                                             &write_offset))) {
> > > > +                     pr_info_ratelimited("tc action pedit offset o=
verflow\n");
> > > >                       goto bad;
> > > >               }
> > > >
> > > > -             ptr =3D skb_header_pointer(skb, hoffset + offset,
> > > > -                                      sizeof(hdata), &hdata);
> > > > -             if (!ptr)
> > > > +             if (!offset_valid(skb, write_offset)) {
> > > > +                     pr_info_ratelimited("tc action pedit offset %=
d out of bounds\n",
> > > > +                                         write_offset);
> > > >                       goto bad;
> > > > +             }
> > > > +
> > > > +             if (write_offset < 0) {
> > > > +                     if (skb_cow(skb, -write_offset))
> > > > +                             goto bad;
> > > > +                     if (write_offset + (int)sizeof(*ptr) > 0) {
> > > > +                             if (skb_ensure_writable(skb,
> > > > +                                                     min(skb->len,
> > > > +                                                         write_off=
set + sizeof(*ptr))))
> > >
> > > Combining these with && instead of the double indentation would be mo=
re
> > > readable IMO (shorter lines, aligning the 'goto bad' labels).
> >
> > hrm. So:
> > if ((write_offset < 0 && ((skb_cow(skb, -write_offset)) &&
> > (write_offset + (int)sizeof(*ptr) > 0) &&
> > (skb_ensure_writable(skb,min(skb->len,write_offset + sizeof(*ptr)))) {
> >             goto bad;
> > else {
> >   ...
> > }
> >
> > Not sure which is more readable.
>
> I think he meant just the last two 'if'.
>
> -- David
>
> >
> > cheers,
> > jamal
> > >
> > > > +                                     goto bad;
> > > > +                     }
> > > > +             } else {
> > > > +                     if (unlikely(check_add_overflow(write_offset,
> > > > +                                                     (int)sizeof(*=
ptr),
> > > > +                                                     &write_len)))
> > >
> > > Same comment wrt unlikely()
> > >
>

