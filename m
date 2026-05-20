Return-Path: <netdev+bounces-289854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CAyMqt+DWqGyQUAu9opvQ
	(envelope-from <netdev+bounces-289854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:28:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C5F58AC6F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58BD430D9541
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9343C13E9;
	Wed, 20 May 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="X4JSt5z7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E563BF660
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269055; cv=pass; b=DuWoW+H7PBOuPLXnf00VDUosrNKeROuNlH2BCuGQeqpR5qDI2QDWPemEOutnWfilkeRchfsu4WnjVivAYG4nUrPSsQfpDcrxO3+yiWL5R4aWh+5TySgGCMSeXR7ImM6TxO0iaID1yNE/7K0nBJW8BwXczdOA/Kr7xmsbjKw5h7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269055; c=relaxed/simple;
	bh=5V+8nueqBp12BA6wqGLsqDhJxfdsPO6v1tkp1eu3RnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABGFjm/1K98NyYOG1vQeoCY8oDNkoToZWY7BstHZbN+U4OS9e7IYJ0CIs9f534CchN1gzrAnzS426ASGGTZ/2ED/Xi+7x+3pbmPK4XmR0HHfTzO0dHrGq7+AKKf+TcBJnJvn4vjwCHeQ8xUpBcFtQ00bZ/lE9wR8orEV5F48MI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=X4JSt5z7; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso2195622b3a.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779269049; cv=none;
        d=google.com; s=arc-20240605;
        b=UriSItzoas5wiH57nipNuIlg+ni8KSJtSEUOQAfYsK/MOiu+2NQCKNlnnykPn5AM1g
         8YCsXjzMAAl2sjmg295xCiZFtdX5Zx2exkDcG2W6m9Q46WDXUfkGqyjaSYb5MErm9DEb
         3ZXBsSaHPMX5xc6JrMhSUd7vQvMmstYx8X13da9ZUKrPhW9WIRZ1VBsMqPUytWzxNkhx
         V6ILx2ytlRdoNG7KofTugrSLKJ7+lXalahYbJb+92+wa1x7+yzpCecsarMJlGuIBcPB9
         TxzHsHFzu7Z7O0Pi1qAURMMVQEsPLFzL2lgOTaHU8plrQ32tbj/ytwwWLpzp82LsVFOe
         /2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=soEtYSQLYGukz/5WvImXiuacrIUFKz6AyM15bXgFpWM=;
        fh=9OV2Fj+jq0UvwwDq3/PSsLPxDD9s9tw3U/HVq1Z658k=;
        b=Yj9KbFWpEEKEXSFYt+RUTqKY0DrSG668O/PNA8i7e0y/rRjM1PehPTDSbgXPGQey4m
         Jxr+hQL/GZwztufH1v0Ai5PbnlrvTxzaGaeZHrTE+d6SKgLzWqdR2I0rXak8fruR8tLQ
         7JyAhNBVtn3j0BnIp+TmfMVzeDfy54zXtHFWZ8QyYj95Fqqie/iwBAI7YH4ChHhMPT28
         eFlKurc3hIBljqTFra5wx0JKHKfTYAT1TjNASR84osSEgvz2ebYQqZedKyKdwCqETCHP
         5OfaHGTAdPvU5DcKvALiBjw176UA4jUHGeQ2kK9pk2mvLSWeHCZdguGuYWqKD5oL7aYY
         wz6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779269049; x=1779873849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soEtYSQLYGukz/5WvImXiuacrIUFKz6AyM15bXgFpWM=;
        b=X4JSt5z76Xk5NMl5UibIYDsGgnddfaqrnbNw9R2LIJHgztieRFYd7H57TG7C381jTl
         qJTuElYtTerUVk7tXmwkkQGiJvOp3zUgboRJMrFHO7UM9PTu0bwYNzfmxGIi450wT2L7
         Kok+zNU+PFrSuR30b1lINaOWVmfDN5nFKQQQZ3gFFtJzv7Dz8ry6cHKDxHFIgEuKVSeB
         lEGpbh66KXAh/U5Xz6geQJYKEIJvrLJLuDrTSNb7d/P9coAxjvrutQcDEnN6WNL7XzO2
         Q1ldLahhD7PNOp54ghJpNDcyBpauhQYv/aJiF5z4FZsrCtEtzIFTi4so8tVNy/7fYX2K
         DYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779269049; x=1779873849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=soEtYSQLYGukz/5WvImXiuacrIUFKz6AyM15bXgFpWM=;
        b=dsHq6Zjj9PFkZWIH4p0LHhRP148O38JWwzjFsG35RwwI4CMGiW4xAmxk8OtOsdV5xf
         eH2zS2v4NLIAzfWvgQXryaMlVNrgGfphhYmSjlS4XgazVHZjgYVGWRre6f9rgkUL54yH
         i3Ts7SIkM+fndMaFkPZ47qV652xxhsACLyMG0S5juuk/dqQrKlWJc7utcU1Lknqoo2cM
         REgOb0jxa0xKGl67+ZkAvURk+ij0clFiW2R4FA4EaJnh3PChkaJE3BWp952OcTTu+1Lr
         dMs+hhdruSPHD+H9Xverb726vbEARSCtn4oh5IRF9tsFU0bfHPIg3QWQ6662qEDWqxUu
         qKgg==
X-Gm-Message-State: AOJu0YxqPvRA3d/FFnkMZi+G5w9Do4go653RO6xwYLdzXUPZ2pPIyEks
	lhne/A5bTy4w6xrB4S+8pS9dKJRW66KkvmLc7wdeRrGYVFlKhpRZ+yOwOtlNSXQW9zA+2wnolkD
	3I60oF82DrrPknwImrE+Ep5bn9dRdjxo/ZSmFs/0k
X-Gm-Gg: Acq92OF17hm8MRfar9eSKytM1sUw0nuNmjroGKZxIRqJ+/2+u3sKcdb/uu53mUCJ+SC
	rYuCEUH/6Pm56pYI43Es9OYHZgONjiGm477wq51KZsTaJgIi4nZaCItHSyS4yHPsLBD5KK4B/iG
	4qm7KDteba3sLIIK8I84TfF5YI6Q/AXNm3pPu+Kjdh6+ZPtHcaiJ8HNkLm4QGBPBMg5tXipJvXh
	VKAqsadv4ZwpCSI/8iVKrN+6ldXqAXF12wkB/ybBqJWL6+gML93jCfARXoXEYx/vCgzlB6yc1JN
	FQJrr6vqyBoYc9YU0vk=
X-Received: by 2002:a05:6a00:1815:b0:829:b08f:7353 with SMTP id
 d2e1a72fcca58-83f33b23b69mr19046314b3a.7.1779269049232; Wed, 20 May 2026
 02:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
In-Reply-To: <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 May 2026 05:23:58 -0400
X-Gm-Features: AVHnY4KtqHf8YtXRdWiDsHrbDjEBdujcQq04s4HSWKj9Xscxt7pXNnewo0iKEh8
Message-ID: <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com, 
	rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289854-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Queue-Id: 12C5F58AC6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:42=E2=80=AFPM Rajat Gupta
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

Sashiko makes the claim that:
"
....
.....
If the payload part extending past offset 0 resides in a shared
fragment for a cloned skb, wouldn't skb_store_bits() write the
positive offset  portion directly into the shared page, causing a data
corruption regression?
"

It missed the earlier code (before the quoted code is hit) which is
very well documented!
/*
 * If the skb has shared frags the user is likely using zero-copy
 * (e.g. sendfile).  Those page frags may point to page-cache pages;
 * writing into them would silently corrupt the page cache.
 * Linearize so pedit operates on a private copy.
 * TL;DR: if you want zero-copy, don't use pedit.
 */
 if (skb_has_shared_frag(skb)) {
        if (__skb_linearize(skb))
             goto bad;
 }

TLDR:
If the  skb  has shared frags, it is linearized upfront using
__skb_linearize() which means any risk of modifying a shared fragment
is non-existent.

cheers,
jamal

> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writ=
able")
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

