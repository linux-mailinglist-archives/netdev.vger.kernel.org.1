Return-Path: <netdev+bounces-289072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMcGG8MUC2o5/wQAu9opvQ
	(envelope-from <netdev+bounces-289072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:31:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDA56DA88
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A0D93014247
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90248165A;
	Mon, 18 May 2026 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="DmnwpBBP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B823FF1B4
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111101; cv=pass; b=h7J7XmK7/Ph9OgAwR20W5zba2qR+8g2NLJENnnafRpe02Rtvy3p08jmNdl2JBuRho6BvOHzMsCMKS6FB7yCusOXfcSqYfw0JXcfw7UWdXmbbZUcVthy/hL6BQIdtzC8Of3MILSpQ43TZoHwxk9Xi4aHIx25Sft0HDaq/ZZ3erfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111101; c=relaxed/simple;
	bh=8vdQYbypFU/Fm/YA1yZ1wbfMnZtXiHKtGwVu/vwvKn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFJgf+TNysASoqUqHwzXFFCJHiG3Mya+DvThtuoqD7moEHf7faF2cOLzlPUyTZZyJPpw2ZRqgS5jF4/iD8U+GgBts9TSaatU4moLXBecEOWdTmI4VcG1THGG7TTWlCT7XHbnRwf/jJvJFPRLbqpuORBiQ+r23E5TX0Buv5hfMJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=DmnwpBBP; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83f674f978fso458865b3a.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779111098; cv=none;
        d=google.com; s=arc-20240605;
        b=AScd5t63lqnsj2T6f0jPUe61gjeYFdzSXezy4fDDDU5hTHSekPjXKulp/pyBUbAau6
         RtZaTLSV1eR+HylLvONAdxA78sKUb7WVjksEmJzX+M5bRIsNxSvktQN0SPBIGI5y2VsI
         PXdD4ahZAxJ11azExXwn5hFXRg9LFjtfVCfR/gxDtI5979FHOS8Qybx0J5IHW4S3SNhx
         mfChWahF2cnQlLP1WSnkKjD3VLlh0fzSOrdW9WY3pKv58P0Ri2riOIaaRvBXTlhrr2Gw
         0uFTs2Qv1kdE2407tQL1NwvEDQVOndNzIJM8Nkntf+CCl1/g8msOp/cfxZ3en0ma6EBe
         XdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/z3QUZe2JF9qkEmRJ4aB8llWQEEic9OdM251PG/1Wrc=;
        fh=ZiGF0kojHi7uY74treO0LsBzYkbeU8fs4p0Kbeh2qpM=;
        b=fpVJ4A+1OPXN3+D3gaHiDbiQvkfLrxZL170NooCvsvQP6aYaV1BUrLLDpCFRtdbgGC
         +Hn+sf2HxPwdujB1lvTa93EMlWTcHLlqr5CSXjAPsDGwmobi6mjdxnkffI7815XSJsgF
         AWaHF9Nf0QA0pYtgLEM7FPnGzOxZ5rqhoCaBPJkqsyHGVC7h+nTZBBtyn7dZhO3bzmVi
         kmdDsjY7/Ixs5CSOkfNl+nf7BZ5OwgZmocTOwQyZ0tPqfjRcqlXTSd43TUqmdoquqzzl
         +dXQtqfeaMNqjKFHEf+f/RagHFkuHHJzz3NWAKUVxzoF04rBtY28sVG9MXXbhVSs9Teh
         WjEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779111098; x=1779715898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z3QUZe2JF9qkEmRJ4aB8llWQEEic9OdM251PG/1Wrc=;
        b=DmnwpBBPDo2dz2/he65gHhnPk65rfV95YXJlX/tTcFzJerKpenMfxMwkbX0q3op+ey
         Tav8aC7V2m0utGHTd5LS2f9JqJ3fiBd+C3iy9iLlI9Y5SHy3VjhHIirYmfRsjCTNLUrQ
         VobV7RQU+/4QsPEY8CsusL9NaUUvw6//COBwv0oYV+hliVDqpUMjaQ74tBLm0FzLVfJM
         XMGEAR02oB71TXLI+KDsAPlswFVhziSJCJNYMtFwgM+Bxt3j5K+V6mYJOI4HWCiL/C0E
         z8UNr40EVIOm/60haB2Kfp3cRTiiNpNlRCrrAQxpm95QX/L+aJlx/7DMpVQ0Grk6S+Jh
         HU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111098; x=1779715898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/z3QUZe2JF9qkEmRJ4aB8llWQEEic9OdM251PG/1Wrc=;
        b=oTgxQjGVPoFpKtkZHaZXQAkxK/aE+b6L9ynYFsUOVmL1yX/xglxovmYtAlfNG8EoTY
         9GuU0tncChKjZVXiSAm9bSTTejhTgJCqFea4ac28LcSHcnHh6d7mp0Yh9xmDsUh/k6iT
         6k/ycdJYPDHxQpPK3KALT6vBLQHdXk8CyTFGsQa0yK0ybhhVLYk0HQcSrCGQpV/pspEa
         URCxrCz9WheuhTK0I60n8+jq4Jk89mk8ax/IGeDjwb2jHgvtJMLWmxS7dAGq8e3ea50X
         DoomKChaeZvMcnOMEq6ylqiytlUKXu1YheBBvHv44W+wKuXJmT7VuvbJftFmw4XED5cZ
         627Q==
X-Gm-Message-State: AOJu0YyeEKNTRFpdslHyuc1QLTEwpgEnFEe11tQuuC/FHN0zcQWY/QGo
	XDLjBPk4o0DlAchU7Sp77suFE6zUoP0JSZsZ6BALfWiBcHYppSkyvgarNNLJG04E8ZtQxLAlO2j
	BhoUkZQo8+Y4QXx+YSk5FLAtifsrzCtl2ZINCL7xx
X-Gm-Gg: Acq92OF4+ulJfvGR0i1q5cOIwiNxfUcd1iFof2wDUrsXTmD6pZtgFJ2BXg9FKei8F/6
	QT/0aH46+YY63laKe3X3gC5qniD9WtZRDJvZjG4Fz6UYncqKj+ux1R7E8TJv7WLrCcelRIj9JmK
	ZrIGHQx+IQTclEm2y7JSUETPPnSgWbZGOWa2r3y09wLblZhv9vB/LLyc+OIfdNtInIZjyl5Dodi
	OEzF5LVsD2lFqrZ7uOSc/lSHacwUTe3Dnm1CkrAu5bst6IFDnLd5k+RySlQHzgoaHVj/cQSJbB1
	ZB1mT+cC78UGJ38CMTA=
X-Received: by 2002:a05:6a00:808d:b0:82c:e1a3:986f with SMTP id
 d2e1a72fcca58-83f33d1519amr13902387b3a.43.1779111098406; Mon, 18 May 2026
 06:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <604ca54c-a94e-4ca4-83e7-4486d7392d71@oss.qualcomm.com>
In-Reply-To: <604ca54c-a94e-4ca4-83e7-4486d7392d71@oss.qualcomm.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 18 May 2026 09:31:27 -0400
X-Gm-Features: AVHnY4IHwjHucsOu26eYK4CBL05Ft0ypktp8MX2EbyoMgT4t9vRkVzGAnaqJSR0
Message-ID: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page cache
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E4EDA56DA88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-289072-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,mojatatu.com:email]
X-Rspamd-Action: no action

Hi Rajat,

On Sun, May 17, 2026 at 9:30=E2=80=AFPM Rajat Gupta
<rajat.gupta@oss.qualcomm.com> wrote:
>
> From f12ea6484dbb75d1c13495e921d0595532317f2a Mon Sep 17 00:00:00 2001
> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Date: Sun, 17 May 2026 10:11:44 -0700
> Subject: [PATCH net] net/sched: fix pedit partial COW leading to page cac=
he
>  corruption
>
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
>

git am on this:
https://patchwork.kernel.org/project/netdevbpf/patch/604ca54c-a94e-4ca4-83e=
7-4486d7392d71@oss.qualcomm.com/

Errors out.
----
Applying: net/sched: fix pedit partial COW leading to page cache corruption
.git/rebase-apply/patch:49: trailing whitespace.
         * If you want zero-copy, don't use pedit.
error: corrupt patch at .git/rebase-apply/patch:58
Patch failed at 0001 net/sched: fix pedit partial COW leading to page
cache corruption
----

Those comments dont look clean - follow netdev rules.
You should send v1. The rule is you wait 24 hours after the previous
one before doing so (you can add whoever tests etc on v1)

Also make sure this applies on net tree not net-next

cheers,
jamal

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
> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> ---
>  net/sched/act_pedit.c | 52 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2..e077a2e82 100644
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
> @@ -393,17 +396,19 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
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
> +       /* If the skb has shared frags the user is likely using zero-copy
> +        * (e.g. sendfile).  Those page frags may point to page-cache pag=
es;
> +        * writing into them would silently corrupt the page cache.
> +        * Linearize so pedit operates on a private copy.
> +        * If you want zero-copy, don't use pedit.
> +         TL;DR if you want to use ZC, don't use pedit*/
> +       if (skb_has_shared_frag(skb)) {
> +               if (__skb_linearize(skb))
> +                       goto bad;
> +       }
>
>         tcf_lastuse_update(&p->tcf_tm);
>         tcf_action_update_bstats(&p->common, skb);
> @@ -414,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
>                 int offset =3D tkey->off;
>                 int hoffset =3D 0;
> +               int write_offset, write_len;
>                 u32 *ptr, hdata;
>                 u32 val;
>                 int rc;
> @@ -451,12 +457,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
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
> @@ -475,7 +501,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
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
> Thank you,
> Rajat

