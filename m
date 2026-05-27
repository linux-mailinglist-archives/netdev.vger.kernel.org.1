Return-Path: <netdev+bounces-292070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDkqH+BYFmo9lgcAu9opvQ
	(envelope-from <netdev+bounces-292070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:37:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547A5DE9CC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C978D300AD7D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4779296BCD;
	Wed, 27 May 2026 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KediXw3w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDBF275848
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849434; cv=pass; b=UiTkizKJvg4p5fcMzO98OlDxsUVZgXt9I4HWKJJgyXZpz0hy0Ws5Jr1ERUYo9kyk7Z9+umQQhsN2kk6ILRATEi2+054O70uaT1KAszG/jxRDSxAecQQRDJ27nMuIdNR6jC9K48DNTdP0yR+lohfAATTFuUiWrxCpIg725CouowI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849434; c=relaxed/simple;
	bh=VrnJzUz7/udbrilxRMMf4HqsQppmzLkpVXZa6Ui31dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xwweu0juExTtLpjAxTkpa7gZlHP6/1vcXNEpVqWx4N1OlZNNYdjw4cDXt7Ha54UjKUNRXi3BpulY4OmGESPZrjP8erc0tUslWlOj1Rza/3cusZ6dq59GjIhR1O+JNacBfwaGMQU8E9uNx5eeLHVpF24RMTF4b2SfM8ys9frUWxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KediXw3w; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6870f904c6bso12637251a12.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 19:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779849431; cv=none;
        d=google.com; s=arc-20240605;
        b=E06drKwuxTCjkOidj8E1pHQCgWsy5TcwgOyWVYg/seEJvboHKjcs0H0uxFeQjeADf3
         kSF7Xvykq5KAT3RzEVPTOu6+PmuYgQfdkjt783MjJJYTvjPItyRLk4RpHusglxx6vq+v
         wLKYRlg8X6qvyzQ4G6QGM5QuQT9eLA/v/PkhCERv+IGnk7UiFe1GmXHYieX5ySDGUexy
         LPfXIZlxaCUMy1jQqm70ss9/rJPnXGTZjILC9QcCJg5yyByldzKcUVQQwf8O108lxH3K
         g03SkgYy8c/71nU6jo6erBG7mF2n73zQSACQDExAF50nXYrbeVlbIUSof87gasFVUod9
         GYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DnqCu1kPxi6IgPEGeTMUFjJBw9FTps/DRBfm2R3MhX0=;
        fh=m+4o3C/duHhwSq2URKi36aJOqdtD7Uo0DvryBiWqpi0=;
        b=ZTrVNRf0bOjNbynC3IVopqsBrTx+fuwgw56fB61sEMv0dWSlX6VtEHgc6Ll2DoLDfI
         wzftxfHZyFLDavQCESjDcrpVbnRUSaH6B8lkeWvgTek/cOi5PVVSrsoM6i4MkJjSfytv
         gbUOLdeKzR2pkfl93P6/RaAsD1pjWEAAlLh3M91W8lfe/tplbkoqJSluSER90g+Kr/Di
         +vGf+SMoV+erY5qvpjzJ4vtufOJdG+IcNq5tuPEtiMX2PI7uotzKDzkIq2x5MQaLLQgv
         yxQzGYoT6myHX2Tp78nS2gqIpv8RM/EytWOQybN6s3SQT+ekKzJ+u3HAqVDMfz7Wf1RR
         ymTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779849431; x=1780454231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnqCu1kPxi6IgPEGeTMUFjJBw9FTps/DRBfm2R3MhX0=;
        b=KediXw3wAfkkft9BYHMwSeVAZekfxnMe1REiX7TR8T3W7BgFSSylatqhDypldS18sz
         yyPfXEUR3B5tEAHztggitE+rUJ/+mX8HHZ9/Hx1ZQzgg5/qC2CHi4QmuSvC46pkykcZa
         Vel1bq/CKHxJx5lClCr0aoR4i86jT/XTYYATaQRdLvTvNMw0rOcuIB8rvgoV9oBaXyBr
         7EARGM77sJoKVYaNV7sfCK0FLSLwPkveNVvsP3LzbMMeZOnL4xI5zuNCoLX5XWBeDpne
         3A5YVr8rLOU6c6TSrQpRDan45znF8PX4R0l0jyKOtXbX2BmA/stNVh5qQQsiqLikjL/I
         ZnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779849431; x=1780454231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnqCu1kPxi6IgPEGeTMUFjJBw9FTps/DRBfm2R3MhX0=;
        b=IWgqMc7KEWBSiizXsl0pho2R2pFN6oS0VtulAzpUZt9iHpbYaFfRmv64HDq2HiMZsa
         f+lFP3rsv7LLIQSyZV9fJ/8eydr+UrvrHYZ7pJHUTHthCz3V6/g+vGv3SO49PUNtaqT0
         ZHEOWqug/YTWa+dLDpGVEswj48FvL/Q9/FcHwN1UJqxzP64IPRKG6cWrpI34k76sWw8x
         VBC/6AWlqa4VOfbYpx6BhUxXLgszsYA+RIjBTocVyfm4POkSBR8M5zNp/urKtjvuVgH1
         sv5BhHrqpuhtFUbt0XXOCKhkC9xkcwGs2t8g/TVdaprzulnJlBJhJRA0mhE7PCZ4N52J
         QU4g==
X-Gm-Message-State: AOJu0YxaYeBx2h9kb9/4w5hR3sjn0c2eshJbQMMhm3ajNS6pJWdPjW8j
	9Co//5zagPBhIZVMY8iDA/EDN+kwGLi4oOvWT939YSCq8OVAVkIQgxhkVD0ACr3tGgZWr/Ox3lf
	AX5/nwruBjJBAy0AyI8pBvnc6wuvjUOs=
X-Gm-Gg: Acq92OGpTuWvnWJf4OOri4zh5NIMiImxq+kLh6HaKiaX4tMvFothkJ01W4BKzByCxUB
	Mj34xPFMEExO3Gbre6cOwAIQrem/HWRGmYCoYx/N8nyZ76g+kzLfF32J6EUQNujfrjdRaRr37Gt
	m+SYvew9wXZz42cwWER35jQNE7d1IvnwXEhtPfqnHySRb9XPSCYSJ/sVO3OmCa8Etf0xBCDn3no
	oEXLUejwP2AGyQu+0qyV1OM0KQQedDX/7R8sfal6xtjY2H74dbU0fCd18tdrJNt2YXQeqSmdc/3
	F0jPjWlZ
X-Received: by 2002:a50:8d8c:0:b0:689:c099:ef99 with SMTP id
 4fb4d7f45d1cf-689c099f172mr3713415a12.22.1779849431187; Tue, 26 May 2026
 19:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526155913.1060694-1-jhs@mojatatu.com>
In-Reply-To: <20260526155913.1060694-1-jhs@mojatatu.com>
From: Han Guidong <2045gemini@gmail.com>
Date: Wed, 27 May 2026 10:36:37 +0800
X-Gm-Features: AVHnY4KcsToQWtypXah1w1zevW3OTyagc1X011Xpgu5qY4e6DkoMGjJLq0IgjJQ
Message-ID: <CAOPYjvb5LgRKRwxDbpxOjKLGJXq-_kRm5BtMHZJnX-_uuY183w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292070-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: 7547A5DE9CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
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
> Additionally, linearize skbs with shared frags upfront to prevent
> silent data corruption when pedit operates on zero-copy pages
> (e.g. from sendfile).
>
> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writ=
able")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

Reviewed-and-tested-by: Han Guidong <2045gemini@gmail.com>

I tested this v2 both with the PoC and with the module-based corner
case we discussed earlier, and both look good to me.

Thanks for the careful and thorough rework here.

> ---
> Changes v1->v2:
>  1. Do better boundary analysis to cover cloned skbs with frags. Pointed
>     out by sashiko-nipa:
>     https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519033950.20=
37-1-rajat.gupta%40oss.qualcomm.com
>  2. As a result of fix #1 remove the skb_has_shared_frag() check, unneces=
sary.
>     Also Jakub has plans where the shared frags is not going to be a "thi=
ng"
>  3. Make small adjustments everywhere for integer checks, suggested by D.=
 Laight
>  4. Remove all reviewers and testers since this is a large enough change.
>     Please retest and re-review.
>  5. Remove Rajat as reporter since he is the author (which implies he is =
a reporter)
> ---
>  net/sched/act_pedit.c | 49 ++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2789..719bee335e1f 100644
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
> @@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>                         }
>                 }
>
> -               if (!offset_valid(skb, hoffset + offset)) {
> -                       pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n", hoffset + offset);
> +               if (unlikely(check_add_overflow(hoffset, offset,
> +                                               &write_offset))) {
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
> +                       if (write_offset + (int)sizeof(*ptr) > 0) {
> +                               if (skb_ensure_writable(skb,
> +                                                       min(skb->len,
> +                                                           write_offset =
+ sizeof(*ptr))))
> +                                       goto bad;
> +                       }
> +               } else {
> +                       if (unlikely(check_add_overflow(write_offset,
> +                                                       (int)sizeof(*ptr)=
,
> +                                                       &write_len)))
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
> @@ -474,8 +491,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
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

