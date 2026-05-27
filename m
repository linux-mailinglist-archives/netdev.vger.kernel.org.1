Return-Path: <netdev+bounces-292339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN/8LUQIF2oo1wcAu9opvQ
	(envelope-from <netdev+bounces-292339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AE5E6867
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 800BA3054940
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1DC428494;
	Wed, 27 May 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="So7AqZ1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18C426ECD
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893831; cv=pass; b=nr/aO/+6A2XsLZx20vY69hnSNweRM4TZL4MPIx/pqh63c3H1LsY2rL/3GVLoInZlYPuYVlfvAqDh4Ae5dpmmnaYYG893keWCQEHXT7r6WfXLjfHpb0ZdF0K9RkXUXTqTDHuezVXyAR2b9nYRvPzXeNuM8u8CnZZceFrprRzbPtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893831; c=relaxed/simple;
	bh=hwoqZc2AKzwdmZcPuSzAxit3E6zcPm0fULrMD/w+r4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1C7dD5uq2p+axZbXUbNY0fl6hbpmy8RJzThZY4rxJE+YW6BH9inAjbMhANYyMwO357HDV3LSmoIabCFEtBQ5f7w5xx1VlmpyjrM71XOQ+WWieCalbtKtfY/r7jzapeJUIqW1Et95inMkFJc1iJXyEAgH1WyKJRJuKku/+IEsqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=So7AqZ1O; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8028fa6039so7811766a12.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779893828; cv=none;
        d=google.com; s=arc-20240605;
        b=BGfJ8+PsBaWTiUny+4BpY5hEWhHFE1/SRk2PLCANAamh+/Tj0LEm5E6ofnZFrr8JQN
         iNhDx6hlwzD2Vd3skTwHMWbL7S+hHJ6rSqnYAJfQWqROaGiQ1925aXofVRg+o5u/p27H
         Wwq6C0Axzq7cyB6YHKz2FH+WkYSYDOdrsylrjm98U2LhsJyLvaf1vP1i5YrOhnQJIrFi
         9tG7eC2OlH1P+pd6GiWWYlPoyfE8+djkSSuj85OMBGiLMu2wdGJmDbJkUlhL5ffD12WO
         evL9aFT+4Bkb8JwamTgbZ4q8C5rkUrVnlZLXFnf00p7rb8BVe7tAYF0deSvQ6z79NQJJ
         mHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ObUxv+elo6/EW0B+lOnCH3PUJbU89bSTY/ufi05kpO4=;
        fh=CZlqreM5+7+5mMHP6qPd1TfrehY9udzjmsxD3tzPdVA=;
        b=e0Vsv+Vak/tzIyNyO53/9XYtuMPNrSIgJk37yy8Dq7/0pLhANyWUk0KdtPaEdV/JS8
         0sG2FvVkyhaDk/i5snsdAsYgfn3gBZA6EkoLgoSy5DkN6UDFjLf3QXuWfW9qD+cAFVnD
         7qM9bFPvXFFnUQ45IPebW5FLcfrf+7jKWfk4+yFrejBw1IgyFhCUlrf6D2OyTxu81K7U
         kj3hvjX5a8LdJW5bIRK0VktC/mGCPDN1mwKQ/y3TgEdmaaaEeGo6iLzEg5qfkMqqn5W5
         9VRLaKGN4PczkGjyAKuunxwtdyAKD9rwWeznSB4jdOdCY9oHgg81F78m8iG3j6jPo9Y5
         ws3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779893828; x=1780498628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObUxv+elo6/EW0B+lOnCH3PUJbU89bSTY/ufi05kpO4=;
        b=So7AqZ1OEU1yd9npA8faEu60/UESUawZn+SHmNKrJB2rTK5XrKz/8e6nLyiCPuyUCi
         axUhLUjdRrf8HfDEeELBFoRj9Dvoq+QlBeDjTiQyDX7v0Df8dDIzn9G//ZHQSjt1jvN+
         SSk/LyMpZ7uPZTDLSiOkLBlHPntbZdUtzECl17jNDdItBE3XehG6WNJVED1JMYiKWNMb
         F2z3LtiyAtGYHW4PM+Nsw6Svrr6Q0QJ3LqQ74IHcHrlVwC0YMpScFyLZ6cT8A/Bkr20Y
         1V/MEBB21oFs+JOn4IUNjYF+ITJRE3f+/SkF1Z1WeFjFdWtDCuivbXTGuGVonaJqo3Rq
         lkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893828; x=1780498628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ObUxv+elo6/EW0B+lOnCH3PUJbU89bSTY/ufi05kpO4=;
        b=eUxz36GXX+FOWYslbFyXzu9WyxAyhnungWKaJtTM3HTPLlrTr5jzaD92gAc6OD2eSd
         ba8ztD9YqmfKcZdTMaN4imt7vKm0EfD7Zpf+SNxjEHmHIcsa6ojWnRn5JgExTaB4o78Y
         uEkrhHfW+451dQMGVR9UOv9xWcGtEBLNkVa/3wQ0IP14xDFx14cmCvuTBx+TJUHarBvt
         E17y3Pw0C0/d+9CU4Wi3xWmLmIJUOup3cln4pjif3z3SbAjaBbkEqkClo1RFP0rP0rZY
         0eUNk/2cSDFnJG4EaY1b0DuGCWZd21EXSstvgQFeoN7ZXbn7a/5CCMPxFNnifEWimQyC
         h6Sw==
X-Gm-Message-State: AOJu0YzOeXgmUDiDVU2h8Jab5dDIDWylCa2QveZcgHtoGD7LOtDYUfom
	fjj3PJa2D0wovy9xrr/qBBNn+Xg3iesj6drmM8uN6S0Rwyk3Ji6V0mMCpngBoJ8xzAD0ThprR04
	iyXKzRyoCRVnkL1MF37sny+CD29m0J4WqHuybc87L2jxuqcE+tKUDELaA
X-Gm-Gg: Acq92OGadnwZRYfTcmddRavfkBXVhLMdZdIp53EqWJ4adNcToIVQfswZL83v5WlGdgs
	9rbelRpDJ9x8oPyYN9OczrZGTKctPfiXpuXgN+S6+IaPbFu7hSkn9XFAu8FiGWrl9oJ5P0W/XtI
	BR+jkAIW68PhCs56LBtX0xGnZnt/UK+WKQ1idynoskzbFbfZmlKQZxQdvZBYZQ6iF4Y3xxdMuR1
	L7NimhxfuDuvpJApKvM9N5avlJdNtuGdpwhwBO77wW/LDia/nGi6lylFsDAb6sCAe0sh1p63vw4
	zQLKccKDrcF06/bPv7A=
X-Received: by 2002:a05:6a21:684:b0:39f:3ca8:a331 with SMTP id
 adf61e73a8af0-3b328d06f11mr25257461637.16.1779893828337; Wed, 27 May 2026
 07:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526155913.1060694-1-jhs@mojatatu.com> <87wlwq2cxf.fsf@toke.dk>
In-Reply-To: <87wlwq2cxf.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 May 2026 10:56:57 -0400
X-Gm-Features: AVHnY4LvtPlkjDU3OEO3CZy-Gu13w6wRyy1zRr567DrPatH0dKnKbVY3QoUHZlw
Message-ID: <CAM0EoMm_FcS0xSNmCjdXaRMfZh12jU71xM92Z50eVE8uk7tKFQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292339-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: AE6AE5E6867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 &&

On Tue, May 26, 2026 at 3:22=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
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
> >
> > Additionally, linearize skbs with shared frags upfront to prevent
> > silent data corruption when pedit operates on zero-copy pages
> > (e.g. from sendfile).
> >
> > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is wr=
itable")
> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > Reported-by: Han Guidong <2045gemini@gmail.com>
> > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>
> Re-ran the tests, and everything looks good, so:
>
> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Also looked at the code, and I have a few nits below, but I'm really
> nitpicking here, so whether you end up fixing those or not:
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
>
> [...]
>
> > @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, int o=
ffset)
> >       if (offset > 0 && offset > skb->len)
> >               return false;
> >
> > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > +     if (offset < 0 && offset < -(int)skb_headroom(skb))
> >               return false;
>
> This change makes it really obvious that this is really just:
>
>         if (offset < -(int)skb_headroom(skb))
>                 return false;
>
> so, well, that would be clearer, IMO.
>
> But then I guess the same could be said of the positive case, so:
>
> static bool offset_valid(struct sk_buff *skb, int offset)
> {
>         if (offset > skb->len || offset < -(int)skb_headroom(skb))
>                 return false;
>
>         return true;
> }
>

Yes, that improves readability. If i understood the discussion between
you and David L. something like this one liner would be reasonable?

if (offset > (int)skb->len || offset < -(int)skb_headroom(skb))


> > @@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
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
> > @@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff=
 *skb,
> >       tkey_ex =3D parms->tcfp_keys_ex;
> >
> >       for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > +             int write_offset, write_len;
> >               int offset =3D tkey->off;
> >               int hoffset =3D 0;
> > -             u32 *ptr, hdata;
> > +             u32 *ptr;
> >               u32 val;
> >               int rc;
> >
> > @@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >                       }
> >               }
> >
> > -             if (!offset_valid(skb, hoffset + offset)) {
> > -                     pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n", hoffset + offset);
> > +             if (unlikely(check_add_overflow(hoffset, offset,
>
> It's a bit weird that this has the unlikely(), but the offset_valid()
> check doesn't?
>

I focused on the bigger solution and worried more about timeliness to
get this patch in - but it seems the distros had already picked up the
first posted patch, so hakuna matata (Still, I should have caught
these unlikelies ;->). Yes on the second one you pointed out.
Will remove them.

> > +                                             &write_offset))) {
> > +                     pr_info_ratelimited("tc action pedit offset overf=
low\n");
> >                       goto bad;
> >               }
> >
> > -             ptr =3D skb_header_pointer(skb, hoffset + offset,
> > -                                      sizeof(hdata), &hdata);
> > -             if (!ptr)
> > +             if (!offset_valid(skb, write_offset)) {
> > +                     pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n",
> > +                                         write_offset);
> >                       goto bad;
> > +             }
> > +
> > +             if (write_offset < 0) {
> > +                     if (skb_cow(skb, -write_offset))
> > +                             goto bad;
> > +                     if (write_offset + (int)sizeof(*ptr) > 0) {
> > +                             if (skb_ensure_writable(skb,
> > +                                                     min(skb->len,
> > +                                                         write_offset =
+ sizeof(*ptr))))
>
> Combining these with && instead of the double indentation would be more
> readable IMO (shorter lines, aligning the 'goto bad' labels).

hrm. So:
if ((write_offset < 0 && ((skb_cow(skb, -write_offset)) &&
(write_offset + (int)sizeof(*ptr) > 0) &&
(skb_ensure_writable(skb,min(skb->len,write_offset + sizeof(*ptr)))) {
            goto bad;
else {
  ...
}

Not sure which is more readable.

cheers,
jamal
>
> > +                                     goto bad;
> > +                     }
> > +             } else {
> > +                     if (unlikely(check_add_overflow(write_offset,
> > +                                                     (int)sizeof(*ptr)=
,
> > +                                                     &write_len)))
>
> Same comment wrt unlikely()
>

