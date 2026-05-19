Return-Path: <netdev+bounces-289493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLZ9OaB+DGoSiQUAu9opvQ
	(envelope-from <netdev+bounces-289493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 877015813BA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF0EA3077638
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315E3AFD1B;
	Tue, 19 May 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtA0z3rX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0231A7E2
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203469; cv=pass; b=iLTJDo2dZ6/pXuQvCMwkme3n2F8kmee/kDQcH8+5lucjivm3B/PtsEUXuhp6iz50ts/uEuZR6gxv+09PBD0N3PAGIuqVVYgNnTIKCxy5ZNLddj3tDx3zIxn5tDadveDEna/E+Rtj0p1S/UkReRsju5EhhASG+2q+Re84QeRFVcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203469; c=relaxed/simple;
	bh=LZkmEfpq6nK+OHKxL6qToUn4opI9DzEI+XdE0WUPkS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcvq9ap49u/DPIvOHQhkdub4UWRX39hPLPxrT/ix43SCRzxOgG0yQoVTzRvxMo2kSTxO6fovM21ryin78jgiuBgPC8J8iDHxrHU9BO+FFyGq6G8Nz7c3mxE3Q19CF5/FBhyNrFKUXfrBQTrEWUcd6/IryGsln0t4kdM1KIhYC0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtA0z3rX; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9d9971d059so527367266b.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779203463; cv=none;
        d=google.com; s=arc-20240605;
        b=aqj3++FVrUB6vgf0CPxxLpbzyUyZMl15Ayx5U3+afJK1lkbOpT2lMGKNHkWOm04TfX
         3Yt2BDlQFK95egKnWvN0iYpTC6eq/hfJQrCK64LrPTO0DLtzs3xAmSt10i1CTy6H9QN5
         xi9W/fz8P99AQR2Jf9oQOTpYaxwm653i/kSDytf8VHZ9OSzsikgHLMjgR50g6H7/g4kQ
         XgFXDRjGg0jeyAXIUGNvQXMIR5y38Zxf25wypLn3koW/IYLZVpVUs3SaLdc2Ia0qVv3A
         90hV8+RwWfsGMZbg46vTS7Ev70OkHOOlCLQQ2XcKnfahX7rnJBpj173Gl8j9EUXEaMEv
         9eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ODFbPjwfXnx8UlHZ+SCJuOAtgmCOuGtWzZtTiafJ/HY=;
        fh=TwC58kvpStB14/SJY548iMup/jVPehmJ9x4wDExLvvc=;
        b=LJPrzEX8mPzvzIaqClin5vF3tuI9zCUpVIZRxXWUnq7IIiPzgFkoSye6Y6tondMlkF
         PtEsiVzD8km39PGG7JCBw8xSrjQzFgHQdojT1e+aqBq+/nMY+hJiEzk+fmzWRPRqE16q
         0PJtHH0qiCCo6ijD/UyMTg8i1Pq1vfj2fOZvgXj4mwVyZMFMHIdfOvp9rGFmIB9/ApJ5
         jo1srCJO7fvzF9cuRkIKkqSUdm1vOnXNK4aNw/Be/pf1TFbIwUzXOb8vCGyJIrnJMjQT
         NQiq76tECTUzEthXjr1G0eUUbB+GjH8JED9XiOFyEuv5r/GdD2ipd1Mv4bcThvJdcyZN
         Q/sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779203463; x=1779808263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODFbPjwfXnx8UlHZ+SCJuOAtgmCOuGtWzZtTiafJ/HY=;
        b=MtA0z3rXXDYNRNtx+/jkMMeNcAvCbAor0YHjCYJP66Awp7kwmHnh7gYBDr03S20nBu
         ADDjtRb8GhLt8snm01DAyJ34Mn3in/uOqoQYETwTdothkruj7eS4QY26QGw56ylqf0yC
         nezHvFj6M6UpznVANx0avdR1Ha5RilBiHSrztoTJOKSep4mT0m0GhYvTb88yB27wpwEb
         o8hXgKHiuUB6CWMjjfwiPyvKtZm3ej4V+R1zIpddDQaB/XSib/1YbR8wZFok76v9r1SF
         6yDiO7R83MAcOkXMqvLrq+miXonVw6tXRdej5rGHExzH5S2tc9u1bnCdci5/Z1sbrNdH
         Nl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203463; x=1779808263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODFbPjwfXnx8UlHZ+SCJuOAtgmCOuGtWzZtTiafJ/HY=;
        b=RuxVXc80/lTvqDgl2O4kJyxA9xox5q1TvBfh9+uRJJVbrXuwGRJU2nzniSkOpibXht
         luUKziCLNa9IwCh09xjpgHyWA1KVZPKGwP3gCIvF4HOfuyHo4nRWgOCzIRyehtcHUIg+
         958GI9UbbSt007Z9mwr6sgPPFGJWEINERPwk+dWmRCEY3vEKojM+tvL/375pirW46UG6
         RF/oGZhs0D640X3w5y/4Kpjuts6U3hrb69SoZDKR6908QS4whoi4vCOeaUJ3LUDiiMOG
         jscx0ywanp+dtAdyCcm2VACT2Rjnuw6rELeNeAyzG/mOAECXzkH3vWWw2r55GC5UKAZL
         uqkg==
X-Gm-Message-State: AOJu0YwZVtM3sy9Ic2aCnA0pW3WwlenpvJUWpP3BhofbbQ2QX7FM8TNO
	B4JAxveApwyw9GeRaaiPzcsIW7wTlOFocOanTSTqUaCANH+jR3eInsZ3EP0Kc+h1G/FuqlhaG9D
	FaBA5CTYiJjqFzlVKH6dAuMrcWnpv6Bc=
X-Gm-Gg: Acq92OGuakvKu3DyPSlwx0NxftslqWRCDj82p9Fu7RC1t5i6OEfwWgYmpJo5NkUt85e
	FtTWySYJ9xbwp5xaB6nHw+dCzTIIk0pmieTR/X0lOUCvfVyCKd6W+TOW8YtYmsURt5PdIkQvzjz
	wcpkzx26AgVNTxRUVs3Ve7PkzGUcxB3Ohukoz9Y83v14ccGwpYrNayWVqmy5f37lyaLIGBb2ev/
	9mEQ3+XW+F5lFJiu98P06tnIuOn+kb/ec4o59mK/JR6Oi+WAfAKWNlsPeY3Eav3eHHHKtJajl2K
	UTxqKi8=
X-Received: by 2002:a17:906:7946:b0:bd5:18e8:1ac1 with SMTP id
 a640c23a62f3a-bd518e822d4mr1016132466b.5.1779203463019; Tue, 19 May 2026
 08:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
In-Reply-To: <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
From: Han Guidong <2045gemini@gmail.com>
Date: Tue, 19 May 2026 23:10:26 +0800
X-Gm-Features: AVHnY4I6TbBVWYO3ClJ5sgSUvgI-ysDSG8OvbuyqYdTsxX0dv6PJ5ihTLVSzoqI
Message-ID: <CAOPYjvb8d61sappVT6VxBd9rLsK0q3wHaiMsYp5cFXty0NOU5w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, 
	jiri@resnulli.us, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289493-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2045gemini@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 877015813BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:42=E2=80=AFAM Rajat Gupta
<rajat.gupta@oss.qualcomm.com> wrote:
>
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
>
> Fix by moving skb_ensure_writable() inside the per-key loop where
> the actual write offset is known, and add overflow checking on the
> offset arithmetic. For negative offsets (e.g. Ethernet header edits
> at ingress), use skb_cow() to COW the headroom instead. Guard
> offset_valid() against INT_MIN, where negation is undefined.
>
> Additionally, linearize skbs with shared frags upfront to prevent
> silent data corruption when pedit operates on zero-copy pages
> (e.g. from sendfile).
>
> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writ=
able")

Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offset")
Cc: stable@vger.kernel.org

I took a closer look at the code, and this patch is really addressing
two issues.

The negative-offset write into shared head/headroom appears to be from
8b796475fd78, while the shared-frag write, and thus possible
page-cache corruption, appears to be the later regression from
6c02568fd1ae. So it may be worth adding an additional Fixes tag for
6c02568fd1ae, and I think an explicit Cc: stable@vger.kernel.org would
also make sense here.

> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Tested-by: Han Guidong <2045gemini@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> ---
>  net/sched/act_pedit.c | 54 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2..79921b8d8 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -16,6 +16,7 @@
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
>  #include <linux/slab.h>
> +#include <linux/overflow.h>
>  #include <net/ipv6.h>
>  #include <net/netlink.h>
>  #include <net/pkt_sched.h>
> @@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, int of=
fset)
>         if (offset > 0 && offset > skb->len)
>                 return false;
>
> -       if  (offset < 0 && -offset > skb_headroom(skb))
> -               return false;
> +       if (offset < 0) {
> +               if (offset =3D=3D INT_MIN || -offset > skb_headroom(skb))
> +                       return false;
> +       }
>
>         return true;
>  }
> @@ -393,17 +396,21 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>         struct tcf_pedit_key_ex *tkey_ex;
>         struct tcf_pedit_parms *parms;
>         struct tc_pedit_key *tkey;
> -       u32 max_offset;
>         int i;
>
>         parms =3D rcu_dereference_bh(p->parms);
>
> -       max_offset =3D (skb_transport_header_was_set(skb) ?
> -                     skb_transport_offset(skb) :
> -                     skb_network_offset(skb)) +
> -                    parms->tcfp_off_max_hint;
> -       if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> -               goto done;
> +       /*
> +        * If the skb has shared frags the user is likely using zero-copy
> +        * (e.g. sendfile).  Those page frags may point to page-cache pag=
es;
> +        * writing into them would silently corrupt the page cache.
> +        * Linearize so pedit operates on a private copy.
> +        * TL;DR: if you want zero-copy, don't use pedit.
> +        */
> +       if (skb_has_shared_frag(skb)) {
> +               if (__skb_linearize(skb))
> +                       goto bad;
> +       }
>
>         tcf_lastuse_update(&p->tcf_tm);
>         tcf_action_update_bstats(&p->common, skb);
> @@ -412,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>         tkey_ex =3D parms->tcfp_keys_ex;
>
>         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> +               int write_offset, write_len;
>                 int offset =3D tkey->off;
>                 int hoffset =3D 0;
>                 u32 *ptr, hdata;
> @@ -451,12 +459,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>                         }
>                 }
>
> -               if (!offset_valid(skb, hoffset + offset)) {
> -                       pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n", hoffset + offset);
> +               if (unlikely(check_add_overflow(hoffset, offset,
> +                                               &write_offset))) {

I also noticed two remaining unchecked additions, e.g. hoffset +
tkey->at and offset +=3D (*d & offmask) >> shift. These look more like
wrap/type-semantics cleanup than a practical signed-overflow/UB issue
to me, so I am OK with this patch as-is.

> +                       pr_info_ratelimited("tc action pedit offset overf=
low\n");
> +                       goto bad;
> +               }
> +
> +               if (!offset_valid(skb, write_offset)) {
> +                       pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n",
> +                                           write_offset);
>                         goto bad;
>                 }
>
> -               ptr =3D skb_header_pointer(skb, hoffset + offset,
> +               if (write_offset < 0) {

There is also a small negative-offset 4-byte-write corner case, e.g.
an ETH-relative edit with hoffset=3D-14 and offset=3D12, giving a final
write_offset=3D-2; if the linear head after skb->data is only 1 byte,
that store spans -2..1. That seems unlikely in practice; fixing it
would be nice, but I would not hold this patch for it.

Reviewed-by: Han Guidong <2045gemini@gmail.com>


> +                       if (skb_cow(skb, -write_offset))
> +                               goto bad;
> +               } else {
> +                       if (unlikely(check_add_overflow(write_offset,
> +                                                       (int)sizeof(hdata=
),
> +                                                       &write_len)))
> +                               goto bad;
> +                       if (skb_ensure_writable(skb, min_t(int, skb->len,
> +                                                          write_len)))
> +                               goto bad;
> +               }
> +
> +               ptr =3D skb_header_pointer(skb, write_offset,
>                                          sizeof(hdata), &hdata);
>                 if (!ptr)
>                         goto bad;
> @@ -475,7 +503,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>
>                 *ptr =3D ((*ptr & tkey->mask) ^ val);
>                 if (ptr =3D=3D &hdata)
> -                       skb_store_bits(skb, hoffset + offset, ptr, 4);
> +                       skb_store_bits(skb, write_offset, ptr, sizeof(hda=
ta));
>         }
>
>         goto done;
> --
> 2.51.2.windows.1
>

