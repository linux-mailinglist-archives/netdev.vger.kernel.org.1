Return-Path: <netdev+bounces-292573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCwPDMTuF2p8VwgAu9opvQ
	(envelope-from <netdev+bounces-292573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:29:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1055EDAC0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFEEB301D850
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84EB32ED58;
	Thu, 28 May 2026 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzvHAbOw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1B3290B7
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953342; cv=pass; b=OmPWa3wCWUoHTBBgdA2BQAR6pARvX7xTYRRA4bYPRiBqmHKygbz9wx08KJEZXf9tycK7aFwjWzItjsFu8RcgpWcEG3uPJYjRKdFQZCL9aaDLRsAvsO+m1naCOzEVpFq+p7TKkEIdmXUeQ+skvspP97QGVLHaY2+qVfjVSrnJoOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953342; c=relaxed/simple;
	bh=wqiOoisFzKOSbaN+8DC0Fww/n2SOXx8MsN67erOwx0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5yePGiJyxQnS4/tEFlE/Ev447T+ppLEJqVX/GXXo1OmRtWwBZUI/SAApKqIxWl+LEYF2QXvgx7oyZ+fpONUS8gJmy0/CH0uVkHSiJWvzyiP2VfKcjGPm2U8fOmAFk7M8bLIaH0T38qeerWz90A/dyMPbOdgEUPlScTEtGobQJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzvHAbOw; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so12995160a12.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779953339; cv=none;
        d=google.com; s=arc-20240605;
        b=FegoMs/nBTLdmBbMZCCi8xJfzgO+3tE1BWm8gFylbqBrJeZhUhExLilzveznAKU8nk
         qEM1Ma2L2hHpQ4vSCiY63wIdhWnr0gdX4cMh98ZuQ1A0gmfqySKYYOD92/eSPgJ4JBAC
         oqmQrdyyfNiMt9fsziFRWZ7PRGQWWQ5jAslM5Ft+3ThWodLGsv3C25x4xyJAhM/RiE85
         ltqY0/XRsU1h9SDXTiTM3yka5T9PDIkdNTVMvlc39VzwpmXkavUQ0LZrcaaNOgRx6HPs
         EHChX2MvZwvgo/f8tb6/cTDcvbenkiWXQSrC84K3+OV/M1xihDb88EuwDh8zsnDeHVEp
         uszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N3GD/+VsNhC16OwgV5QFJMhiq/0obH6gESZnNktdYnY=;
        fh=m+4o3C/duHhwSq2URKi36aJOqdtD7Uo0DvryBiWqpi0=;
        b=XOtqM/Lw722epZEFXiBWJJOLG2l7vsimj/jI6nwgn5oFH+CFMrvtOyeIM0clMyHURv
         PHEODzmBS25qr34WbJC90vOmhz10lHYY5iPZGdEXpEwywYLLQwdXgEX+8F1CUk6UxxpO
         JOcUVckRIUblkBblG3de3sHGxdmJzhEDpkgmJRd+UK5CjZ/MVbIb/e2teBDWICnMJ826
         EKE19RfmkEvH1g9XGMcv9pTmS8u3oGOfJUej2/woM+48jUj3go9bXlqRhfaLC44CQABL
         FSEFfiLzYqvQLVJeVV98zUPxfiG76IU4llSfuZUe5mXk14PIOsxY2QuYQgZvc+9R3YbK
         UNGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779953339; x=1780558139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3GD/+VsNhC16OwgV5QFJMhiq/0obH6gESZnNktdYnY=;
        b=EzvHAbOwmWJxSDUBuPNkU20W+KD7Y1r2Dfm10PwA4AaT0Ik8PdQmnjAn3hHzsGQ/R5
         Tbb/qTcpi52Jdt7h6RUaaqby5xCidMrFNPFzPDVASih0+bLdsEt48vg7k0YB5G5sjaJT
         I1jSLxj+lCR0dvZZSN7IaEWNEjc4iFFLwW6NOMPXiehzRBKyHKo6Gk7Afv5GxJ6DMAe+
         jYYxNGKVP6LUG9vT3snoI5I3850ntu+eXMzZzdHrS2dkhKbhrKnLK9NRn2lZjOj1ADgL
         /2NaZHdPjfANh2jaiLQ5Y1rmgs6ICMIN/Iu/g+Xxc62/9sc4vjUqW4XgsKHT9hV27rSc
         DTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779953339; x=1780558139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3GD/+VsNhC16OwgV5QFJMhiq/0obH6gESZnNktdYnY=;
        b=VszeRimSSjb14w07gLCa+tCHjCYzncgJt2w048Nud9Z86rLiF8IPDyaZ/VPqMHUYWx
         SbQ3ojalKfD+3QyPIWxZ7TFxDi/DBiBQ4LjYDJJv6QupxKIXgbazLSlHDqH0p5jBaXuX
         aIyn1Ktp5kojYbqmPzVFcnZySRyCW7YAZ97z8aCG5lvnvhrU0I9G3gs5Gp1of8G6bxf7
         pnCapzKIK20GLvzfgv9mmrW5ffLt2TOky3nYHT3sOiBejVAjbtxoBIb1UXkwECTimoL6
         /k9leDHMuAH1JqBv1lbJWbD9IcsnleZUN4p1EbqbGJpyTn8VEHcR7CtqwHTAkWjlgiIJ
         rgaw==
X-Gm-Message-State: AOJu0YzgZjY2DVAAnqOBdqaFkPKie2kqvRwnBWd1ULEvwrEdRatdhqIO
	MYcYYtNdEHuAfiX3jP//zkNde96Jt0w/8dmYU2XHts+dcUM/VWEJzSJGG/n10rNd4wVLRdkOFQr
	249fn5nI7ib74KmvW0WjHsUB8fMKOrHE=
X-Gm-Gg: Acq92OFm+zNHs8FNm79rp1i2TDNCLAkafEXEMT5uqwkH1/Lk7iRB56pgXrDbMoG2kbB
	xcz0wvy9IsOAyMO1Za3XcX0+M/4BbClhkrq6/2Kan30TGxA0j3LEV0WXiMM9fwYu6edydo+7ocC
	aa1PE1aYzRVNqrIJBTnVA9yFOrYIfbkesSLmIG6CSPnPIboLRxjtmOp3Dkca2lgnsDmlQHd0gPo
	iQd8RPXh0NYqQehIMB/HG2o4xu0+edyiLepndvemXRvyymQ9/ExwHMJ9Lvi6yfl0Xv3QS3jGh5r
	QN7rVinpjJYRePLinko=
X-Received: by 2002:a05:6402:1f47:b0:678:f8f4:a7f3 with SMTP id
 4fb4d7f45d1cf-6889c2b2e69mr14886065a12.0.1779953338957; Thu, 28 May 2026
 00:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527181731.1166373-1-jhs@mojatatu.com>
In-Reply-To: <20260527181731.1166373-1-jhs@mojatatu.com>
From: Han Guidong <2045gemini@gmail.com>
Date: Thu, 28 May 2026 15:28:28 +0800
X-Gm-Features: AVHnY4IdyClHLMBvKDRCQz7wPmxPiCFTAuKTKuQc0UWWbckNkXddxEvZSEObpa0
Message-ID: <CAOPYjvYAGvZp892=A8muRexPCPs50k-bPtwEKxibEMeJC3w4sQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, david.laight.linux@gmail.com, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, rollkingzzc@gmail.com, toke@redhat.com, 
	dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292573-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2045gemini@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,qualcomm.com:email,mojatatu.com:email]
X-Rspamd-Queue-Id: 3B1055EDAC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 2:17=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
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
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Reviewed-by: Han Guidong <2045gemini@gmail.com>
> Tested-by: Han Guidong <2045gemini@gmail.com>
> Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> Tested-by: Davide Caratti <dcaratti@redhat.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> ---
> Changes v2->v3:
> 1) Fixup commit log not to talk about linearize
> 2) Add more optimal boundary checks (Toke & David L.)
> 3) Fixup if statement for readability (Toke)

Retested this with various debug options enabled, and everything still
looks good here.

Thanks.

> ---
>  net/sched/act_pedit.c | 45 +++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2789..e01865af8ca0 100644
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
> @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, int off=
set)
>         if (offset > 0 && offset > skb->len)
>                 return false;
>
> -       if  (offset < 0 && -offset > skb_headroom(skb))
> +       if (offset < 0 && offset < -(int)skb_headroom(skb))
>                 return false;
>
>         return true;
> @@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
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
> -
>         tcf_lastuse_update(&p->tcf_tm);
>         tcf_action_update_bstats(&p->common, skb);
>
> @@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *=
skb,
>         tkey_ex =3D parms->tcfp_keys_ex;
>
>         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> +               int write_offset, write_len;
>                 int offset =3D tkey->off;
>                 int hoffset =3D 0;
> -               u32 *ptr, hdata;
> +               u32 *ptr;
>                 u32 val;
>                 int rc;
>
> @@ -451,15 +445,34 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>                         }
>                 }
>
> -               if (!offset_valid(skb, hoffset + offset)) {
> -                       pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n", hoffset + offset);
> +               if (check_add_overflow(hoffset, offset, &write_offset)) {
> +                       pr_info_ratelimited("tc action pedit offset overf=
low\n");
>                         goto bad;
>                 }
>
> -               ptr =3D skb_header_pointer(skb, hoffset + offset,
> -                                        sizeof(hdata), &hdata);
> -               if (!ptr)
> +               if (!offset_valid(skb, write_offset)) {
> +                       pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n",
> +                                           write_offset);
>                         goto bad;
> +               }
> +
> +               if (write_offset < 0) {
> +                       if (skb_cow(skb, -write_offset))
> +                               goto bad;
> +                       if (write_offset + (int)sizeof(*ptr) > 0 &&
> +                           skb_ensure_writable(skb, min(skb->len,
> +                                                        write_offset + s=
izeof(*ptr))))
> +                               goto bad;
> +               } else {
> +                       if (check_add_overflow(write_offset, (int)sizeof(=
*ptr),
> +                                              &write_len))
> +                               goto bad;
> +                       if (skb_ensure_writable(skb, min_t(int, skb->len,
> +                                                          write_len)))
> +                               goto bad;
> +               }
> +
> +               ptr =3D (u32 *)(skb->data + write_offset);
>                 /* just do it, baby */
>                 switch (cmd) {
>                 case TCA_PEDIT_KEY_EX_CMD_SET:
> @@ -474,8 +487,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>                 }
>
>                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> -               if (ptr =3D=3D &hdata)
> -                       skb_store_bits(skb, hoffset + offset, ptr, 4);
>         }
>
>         goto done;
> --
> 2.34.1
>

