Return-Path: <netdev+bounces-292395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNcsAY0gF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:49:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577AE5E7FEB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4526E30075EC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF143DA2E;
	Wed, 27 May 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="iqWSosU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8CC421A02
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900304; cv=pass; b=e5pGBDYSfw5K2HXihR6htmP8BpaoCGP0KWHut32Fe8MtpBgkFLgLOF+rOtZMxcoZMEYIT0wonAbf9OCNf+g19s4u8vVFBYCcA+Gc4FkB8fEQI0vFYWpZWXFN6BtXfNQts3bh03LtUm7EYkFjk94MXwC8Hm9+yUasXxjPXOAb5hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900304; c=relaxed/simple;
	bh=xmy+I/fVKg2wX+d9wfqDh/3RJc/yt3BxVW22uCGE5IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djnlSXlZTgGbHa4VC6KyXRojVdAttB9JxVlpOVqIMo3sRsOTnc+H3+g75O3CD24D+GnN1QbvK/gG+eibL2VpG+OP2o0DDoh7xEC3xS/lg0K9K+TKIRfGk/CHDhMSfEqR2BdRYpsKenWuDwshMQxh7mRgY2rubBnhFjdpK1s5i38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=iqWSosU3; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-835386ff122so12064400b3a.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779900302; cv=none;
        d=google.com; s=arc-20240605;
        b=aLjTgCNCsnzM63+dSvUWnuE6sk2wxVZS20JhvQzyE6ezktjPANVTlaXIsbG5Te7AVI
         gOLYhyhWKLGPYu3U7/RWu5kB+v60+jnjPcpAEngM2ImXA+LCYNJsmK7M5zzwAOwZVEcf
         w3eiXAGfvC31kegTcQPUg16xDp7GES59ip33PKs8cZLjuxT4bRuCN0WK0xE1ocVOtR2A
         PRARiI5mGEAXDQdkjNIyHatcVsedwyhxLSV/A3YGA02NsaonU/1A/RDn+Evu+iQRxp/q
         EjV5zdAxZB48yd3l3XVb6ct2FvMzXFFxIdot77kwtye7JjHY/ss6iVx7gB7CAPHWXbnw
         X31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tnzny3j8ro2L6nkmulfOjofdsoJgv2vbqJfIgFAteTY=;
        fh=CZlqreM5+7+5mMHP6qPd1TfrehY9udzjmsxD3tzPdVA=;
        b=YG7h93JifiXQu8SNdkZ0r/1E90iJxkl2NCdf6DGD/ctEWMZt+xIEkP38qjKUSkylJN
         eRNVfZxEViwCMp/cEFoGGNckZvwvAWN6q5qI4B801+jbLPqH47kKyu7A1shOUmDa/Z9J
         bM66JFNqlCHaifh+Eu1h5vNYlr4d1ldjF0FkqB/IbLSUImGukxhZfi7rg5Qq0wc3mlFh
         Fi9u1XpZtGgkQO/nP8KJyCEofL7RxLEBe2jAj7TRTiUaunfCU+GJTrzHC0bmKRqg2yi6
         qopOXKhXxTjjpgCO3KaFqlOI9fbRGa4P2HoeXX3iHLV9+asnwJDMllw7n5iCvCW67gVx
         P37g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779900302; x=1780505102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tnzny3j8ro2L6nkmulfOjofdsoJgv2vbqJfIgFAteTY=;
        b=iqWSosU37O2P3DHZIDkfCW4Ap9xObtQqKHK1cISkbCV0/B49NenbfNq2UMp+2n+Btt
         Q2D34XQYq7ADG2iW9MbGlHk9pM7wlk7Q/9LRXk6XzHgZJT6e78jWfl4PBUFP/hcxsc9d
         /eXRjGRJXFUjWDFxEUkI/1HKIGcYiWfj8Mw0DH9U4iUxPjqtyClDHcE/dE+0c8BRTX02
         GHoUwCIBNakDqKIv1d4mqTFfB5E8m84W6D0/oXcCWjPE9JsBnJ6BOhlHdf/MzXkLiLz5
         kQAjDESgGWYLBtFbpbWwWeR6Feyba9bcAQ6B+2fHqV7P2VoYLH21F+2ow+b18LSoreNM
         jGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900302; x=1780505102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tnzny3j8ro2L6nkmulfOjofdsoJgv2vbqJfIgFAteTY=;
        b=tKjMg/Nt8+PqrCeJ5GwGSkicoc6y979ehumh9Lz7KF34mPM/EBZolLBtw0VhZNoP5i
         QT5WGOUK2jnlebhbED5nm5cdxY2SdLhoL9Hyp3bwxNrJzDgbVp4wRYk0yUgMR6Jb/1Zz
         KXXN7PrHI+Swf7uAP/NTrW0607kN18WKwi3W1iRLjLtGdrhT2URk2hLUSVHLQJYT/N6w
         gmEtYpxgCuNnadF+6nifKPo6gLZQ4MZX+t+BrxNllEqgoMT9P95hcPq6qcwnQRdIZtTS
         nFSZKb8hjeWJ1QKegcS/JF/kl9srkiuoqeWnMwNB+Y3/rDs8q3g2AN1BMfhb9s0UjVpc
         CV7w==
X-Gm-Message-State: AOJu0Yy+u6CrZsNAgnIVcO3Qd4+Cck14/urJ8UeM/Q57agU+xlbvUP1a
	amCVPV1spEZFwwBc94zNppeXnJXqyKK9xO2GocitOuOCs934meVV3+YgCuXBfBl8fGEaDUkU3Wg
	62juFy/u+KxUKejkrcfuUd6YmrJUKX4MYMYmsvxVIMVlppVCA0B2Beg==
X-Gm-Gg: Acq92OFuCCu4BZMw0NCS5zYRJ7Rgz1scFdzcpDzP3K8VDyU4J3Bse4eAiNnZSAqQ1B0
	yD0L/KoEv1WjNqeLleucF/C2qCVBKZ3Q2dJ1fFP0fddLKTjJITGHYHKzewt1QU5LchUqkAE3Qno
	rWkkq/YjNA49B+Etabk0cWy3i8oXJOm+47Bb6U2yx+vDQBNitvnm2VGVGuvioO1VIEMD2U5OV7Y
	d4CDFSWL+SZQqR1dsYSPE0MyhnvVSc0zLANJCp6OtR3UIpBuRbdvj8K/kKPtUgiQyb6QXoROnGI
	1GjIS44OBAhdz+nh+xc=
X-Received: by 2002:a05:6a00:2da4:b0:82a:6ef8:cb43 with SMTP id
 d2e1a72fcca58-8415f53dbe4mr22299624b3a.19.1779900302358; Wed, 27 May 2026
 09:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526155913.1060694-1-jhs@mojatatu.com> <87wlwq2cxf.fsf@toke.dk>
 <CAM0EoMm_FcS0xSNmCjdXaRMfZh12jU71xM92Z50eVE8uk7tKFQ@mail.gmail.com> <87o6i03n09.fsf@toke.dk>
In-Reply-To: <87o6i03n09.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 May 2026 12:44:51 -0400
X-Gm-Features: AVHnY4KJhfYXZmj1PUtVB7ctWwkdvznJdSwQuxcSIb1W0CNoGC20-Dic3Tz7ryE
Message-ID: <CAM0EoMn2NdnU9-xfwP3BdzQfm=uyZH1vUvTkNw6CYpFvQtSO7g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, david.laight.linux@gmail.com, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com, 
	dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292395-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 577AE5E7FEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 11:12=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> >  &&
> >
> > On Tue, May 26, 2026 at 3:22=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>
> >> Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >>
> >> > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> >> >
> >> > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> >> > once before the key loop using tcfp_off_max_hint, but the hint does
> >> > not account for the runtime header offset added by typed keys. This
> >> > can leave part of the write region un-COW'd.
> >> >
> >> > Fix by moving skb_ensure_writable() inside the per-key loop where
> >> > the actual write offset is known, and add overflow checking on the
> >> > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> >> > at ingress), use skb_cow() to COW the headroom instead. Guard
> >> > offset_valid() against INT_MIN, where negation is undefined.
> >> >
> >> > Additionally, linearize skbs with shared frags upfront to prevent
> >> > silent data corruption when pedit operates on zero-copy pages
> >> > (e.g. from sendfile).
> >> >
> >> > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is=
 writable")
> >> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> >> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> >> > Reported-by: Han Guidong <2045gemini@gmail.com>
> >> > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> >> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> >> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> >>
> >> Re-ran the tests, and everything looks good, so:
> >>
> >> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >>
> >> Also looked at the code, and I have a few nits below, but I'm really
> >> nitpicking here, so whether you end up fixing those or not:
> >>
> >> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >>
> >>
> >> [...]
> >>
> >> > @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, in=
t offset)
> >> >       if (offset > 0 && offset > skb->len)
> >> >               return false;
> >> >
> >> > -     if  (offset < 0 && -offset > skb_headroom(skb))
> >> > +     if (offset < 0 && offset < -(int)skb_headroom(skb))
> >> >               return false;
> >>
> >> This change makes it really obvious that this is really just:
> >>
> >>         if (offset < -(int)skb_headroom(skb))
> >>                 return false;
> >>
> >> so, well, that would be clearer, IMO.
> >>
> >> But then I guess the same could be said of the positive case, so:
> >>
> >> static bool offset_valid(struct sk_buff *skb, int offset)
> >> {
> >>         if (offset > skb->len || offset < -(int)skb_headroom(skb))
> >>                 return false;
> >>
> >>         return true;
> >> }
> >>
> >
> > Yes, that improves readability. If i understood the discussion between
> > you and David L. something like this one liner would be reasonable?
> >
> > if (offset > (int)skb->len || offset < -(int)skb_headroom(skb))
>
> Yes, I believe that one is correct wrt the integer conversion rules.
>
> >> > @@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_=
buff *skb,
> >> >       struct tcf_pedit_key_ex *tkey_ex;
> >> >       struct tcf_pedit_parms *parms;
> >> >       struct tc_pedit_key *tkey;
> >> > -     u32 max_offset;
> >> >       int i;
> >> >
> >> >       parms =3D rcu_dereference_bh(p->parms);
> >> >
> >> > -     max_offset =3D (skb_transport_header_was_set(skb) ?
> >> > -                   skb_transport_offset(skb) :
> >> > -                   skb_network_offset(skb)) +
> >> > -                  parms->tcfp_off_max_hint;
> >> > -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> >> > -             goto done;
> >> > -
> >> >       tcf_lastuse_update(&p->tcf_tm);
> >> >       tcf_action_update_bstats(&p->common, skb);
> >> >
> >> > @@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> >> >       tkey_ex =3D parms->tcfp_keys_ex;
> >> >
> >> >       for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> >> > +             int write_offset, write_len;
> >> >               int offset =3D tkey->off;
> >> >               int hoffset =3D 0;
> >> > -             u32 *ptr, hdata;
> >> > +             u32 *ptr;
> >> >               u32 val;
> >> >               int rc;
> >> >
> >> > @@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_=
buff *skb,
> >> >                       }
> >> >               }
> >> >
> >> > -             if (!offset_valid(skb, hoffset + offset)) {
> >> > -                     pr_info_ratelimited("tc action pedit offset %d=
 out of bounds\n", hoffset + offset);
> >> > +             if (unlikely(check_add_overflow(hoffset, offset,
> >>
> >> It's a bit weird that this has the unlikely(), but the offset_valid()
> >> check doesn't?
> >>
> >
> > I focused on the bigger solution and worried more about timeliness to
> > get this patch in - but it seems the distros had already picked up the
> > first posted patch, so hakuna matata (Still, I should have caught
> > these unlikelies ;->). Yes on the second one you pointed out.
> > Will remove them.
>
> Cool.
>
> >> > +                                             &write_offset))) {
> >> > +                     pr_info_ratelimited("tc action pedit offset ov=
erflow\n");
> >> >                       goto bad;
> >> >               }
> >> >
> >> > -             ptr =3D skb_header_pointer(skb, hoffset + offset,
> >> > -                                      sizeof(hdata), &hdata);
> >> > -             if (!ptr)
> >> > +             if (!offset_valid(skb, write_offset)) {
> >> > +                     pr_info_ratelimited("tc action pedit offset %d=
 out of bounds\n",
> >> > +                                         write_offset);
> >> >                       goto bad;
> >> > +             }
> >> > +
> >> > +             if (write_offset < 0) {
> >> > +                     if (skb_cow(skb, -write_offset))
> >> > +                             goto bad;
> >> > +                     if (write_offset + (int)sizeof(*ptr) > 0) {
> >> > +                             if (skb_ensure_writable(skb,
> >> > +                                                     min(skb->len,
> >> > +                                                         write_offs=
et + sizeof(*ptr))))
> >>
> >> Combining these with && instead of the double indentation would be mor=
e
> >> readable IMO (shorter lines, aligning the 'goto bad' labels).
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
> No, I meant just collapsing the two inner levels - this, on top of your
> patch:
>
> diff --git i/net/sched/act_pedit.c w/net/sched/act_pedit.c
> index 719bee335e1f..eb61d73730c4 100644
> --- i/net/sched/act_pedit.c
> +++ w/net/sched/act_pedit.c
> @@ -460,12 +460,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>                 if (write_offset < 0) {
>                         if (skb_cow(skb, -write_offset))
>                                 goto bad;
> -                       if (write_offset + (int)sizeof(*ptr) > 0) {
> -                               if (skb_ensure_writable(skb,
> -                                                       min(skb->len,
> -                                                           write_offset =
+ sizeof(*ptr))))
> -                                       goto bad;
> -                       }
> +                       if (write_offset + (int)sizeof(*ptr) > 0 &&
> +                           skb_ensure_writable(skb,
> +                                               min(skb->len,
> +                                                   write_offset + sizeof=
(*ptr))))
> +                               goto bad;
>                 } else {
>                         if (unlikely(check_add_overflow(write_offset,
>                                                         (int)sizeof(*ptr)=
,
>
> (You could do the other thing you suggested, but as you point out that
> quickly becomes a too dense soup of && :)
>

What you shared is better. Will use that one.

cheers,
jamal
> -Toke
>

