Return-Path: <netdev+bounces-289058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EaZBFQOC2pN/gQAu9opvQ
	(envelope-from <netdev+bounces-289058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:04:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC2B56D3E4
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78D3D30832DF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F2A4534A2;
	Mon, 18 May 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5/kLxKv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DF4657E5
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108956; cv=pass; b=I8Tsnq4l7JWBFS2V2oE4Qp0Z7697v1kGsUp6VYuI93AHzqMh7EfPF4Z3MZlm7LaCr0VcIt6Jc5woQgH3kjOSL99TaY7JDJ45Z4hVL1gJizFRxIUfmslTuSe0BoLDJ7zsRPS7CrA6M75HCC5dh1McSD/f/ZT7iibaTDBwOyCy0uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108956; c=relaxed/simple;
	bh=IbYsED3ggW3i68ioVsxqOCeV20sGQo3k5sLQNuEHLXU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=au4oLR2j9dFs4sW9x+4Ltr90TrmovRRcFO/RMsG9kqG4ZTAIXphEKcTN0qshkf4AP4gbIudwZKadFvN5ppFDHS9L7eG2lbB8n9m5P48DsCtBAAz7aujSeAgDMpUrdmlF0YL+xrwAVGNUWbJa5KmRgXkV1fx5TwWiKzog7oMrX64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5/kLxKv; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so4225975a12.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779108952; cv=none;
        d=google.com; s=arc-20240605;
        b=L2oxep5E0FhKlxuKn0KEtr/GmjvRFHN61GQ3CfbkMOMn4IDcCjVcstLx5yWci33f8I
         xw7VKcYkeBqXjvN1Y5T3/qdrYsJzfqk3DYPY1rVxhn5ilj1yZGuALHmMAvOQ++K5Gs2t
         BBJsQRvXYQL2YSqe3qrIptZ1fXqsc9p0kDY8BT7wOFb33ctZK5dPOy13kraxWFn5+bvT
         uAO+OFHlEnr/pxgOimQb3o5M/GLFxvo4hcqOABuBm9rOlZO55vMHODZYVqXnPyKFsr5e
         BWuY+H9yg2QUeJ+JqFG6RosvoTHNg4uM/h3NH8NFODxCO+CEKPlkv5vWqiHPAb5H2+tr
         UlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RRBA1bjLaRTrqfDVwLVGY4F3YG4XaVOyIv2Oni0buVE=;
        fh=2Pqv1I2SlEqIwUkTGg5BuxYIFX6QR4XW/vcSiqN0y0s=;
        b=WssTjWlELVmFIW86r/N271oHhuyDMUrX2KC1q6dx+sQPjo/J3v0fTltxJ5eS6GdHXY
         LdV0RXuOiuNNGhAAqmohCpDFrw8c8Ce3X/IjLaY9SAdGDTUzP4jYRJJ9gdGLdkUR7txq
         d25ukt4NkXq85pFAzoxJ3T6ek9UNu6RNV7UvpjGd1gx/lAjHMGB4c8v+joKZN0nKU9po
         e8dGPj/fn0WHuin1G0YFpJjW8gXMCr1frfboFinQdSrtzdutOz/fn1xMQZf55lNYGPXI
         kezexocf7GkR0s7ntJvZ+9tIVp9iWZC8ZYdeh16DDkFS2NFiGmjbZY5nids0+6c8IJYu
         vh2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779108952; x=1779713752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRBA1bjLaRTrqfDVwLVGY4F3YG4XaVOyIv2Oni0buVE=;
        b=G5/kLxKv+u4c7Jg718caRdQ3SSwrVd/+gOWPELcK5u3bTrco35kOoBOyhu6RL8/KkN
         p/amzvsripLSZERRJ3Em3gEtz1WECTFqxRr7r4e2T4LN2ydHsYINfkzpyM/A9/CnSv+F
         b4fppVchTr+oExm2Zc5H1/J66U6b549LzU67Zm4dJ70VaeNIqvE2NbIZ1hCJS5fhxu2w
         2/+xhcR+JIXiLVY0nEuTX2zcX0HppuvPdkr5TTCtQTnxXbsCrTz5jhw2SshR7UjrWLgr
         YXpGa6ds+W7BIKkW11xvhRGEe0LF6wbU/YdYGLe1zXdlxzRtkLZ++9fEO42b2OurgBzO
         qDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108952; x=1779713752;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRBA1bjLaRTrqfDVwLVGY4F3YG4XaVOyIv2Oni0buVE=;
        b=HxlP2PnI/TbmWsQLC55D49wTfhBK3at7NJjECgUk+NGAUj0/pVzZJzfX2JKr6thShT
         QDoZ/nfgP73I4UvQUWxTIeXsOqS2C6L6xwCpCrDWgD+Z3jpzdsmaaSZ5OvO56H/zjIce
         gCkb3A0a7sQsI1dpWjG1cMtNIiOv7QVow2Xa45RHFcQHvdt+t4/rsPVqAFb/Bt1HGMMX
         zY+smpFxUvQKg6+GHIJI7Tyh/WeWnQy/SMO4nQ6hQkpdM8vQYtEcPv9gbM2k6bR+Seow
         DGZUgUozZgfoPoU93dx7gC1rorFo/tktvO+zX3JjY8YXBHVuE4CzYyFKC8/xaeMWTo2N
         8hng==
X-Forwarded-Encrypted: i=1; AFNElJ+VZEEB30UgYxhebSmNQ7B96A5v5ZuUPuXWaGgb6+DMCm2oU86DAUQ8dG76PGrQGKOv8mlwEOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ayHPS9GI8xjI0gItbp9myBHNmXRr6s445zgk5IYcyFYBDoq8
	qGLvbJ6DV0LAnB6UovO2OXzDcGz4BDyiQdU6+oIge14Tdxq/mpjse0WHouxah/ebAYkOzPfnk6g
	MA59SxEFZl8CYUsTF9+kaOm7O8HlfZ7Q=
X-Gm-Gg: Acq92OFwq/8BDYkpgpa5YtI4BriixlHU84HnRk8zWO5CmIgLVKaA4X45wGCPqvtjYA0
	fQa+1L/D4+GQjdErMGMu/sCZiyUgiDQCcVLqQ7RmjF8PPFf19KdsFGkQGxMRgkj+583i4+FDHaI
	jDXiDLVu1nxV0o87FcMoSIn8AkFNj2zKZpyXvqH8n66VA1hp/7gJ2zLpSHrMdvYROw4FVjBqLZH
	ZGppGeWPXjpFLomA65uN0YgRqIKQNVc/e6dL9COg2lg06z4mNH7w6Pg2OO90TPSy34314f6TNPp
	7GO7a9ovgWKriFq3Vjo=
X-Received: by 2002:aa7:c4e7:0:b0:670:8b38:5717 with SMTP id
 4fb4d7f45d1cf-683bd581a49mr5250120a12.24.1779108951442; Mon, 18 May 2026
 05:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Guidong <2045gemini@gmail.com>
Date: Mon, 18 May 2026 20:55:12 +0800
X-Gm-Features: AVHnY4IsOsCp9pu84iEKvglA66jm0h0jvjEOm61m4Ez5PYLqvDnZDnoxFAoNNVo
Message-ID: <CAOPYjvaf7o=C5UA+_GuXtRTM99r-wx8eQNh2by2n4Y4hjMj82Q@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page cache
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CFC2B56D3E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289058-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2045gemini@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 06:30:31PM -0700, Rajat Gupta wrote:
> >From f12ea6484dbb75d1c13495e921d0595532317f2a Mon Sep 17 00:00:00 2001
> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Date: Sun, 17 May 2026 10:11:44 -0700
> Subject: [PATCH net] net/sched: fix pedit partial COW leading to page cache
>  corruption
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
> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

Solid fix. Linearizing shared frags and dynamic COW checks completely
resolve the offset drift and page cache corruption. Verified locally.

Tested-by: Han Guidong <2045gemini@gmail.com>
Reviewed-by: Han Guidong <2045gemini@gmail.com>

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
> @@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, int offset)
>       if (offset > 0 && offset > skb->len)
>               return false;
>
> -     if  (offset < 0 && -offset > skb_headroom(skb))
> -             return false;
> +     if (offset < 0) {
> +             if (offset == INT_MIN || -offset > skb_headroom(skb))
> +                     return false;
> +     }
>
>       return true;
>  }
> @@ -393,17 +396,19 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>       struct tcf_pedit_key_ex *tkey_ex;
>       struct tcf_pedit_parms *parms;
>       struct tc_pedit_key *tkey;
> -     u32 max_offset;
>       int i;
>
>       parms = rcu_dereference_bh(p->parms);
>
> -     max_offset = (skb_transport_header_was_set(skb) ?
> -                   skb_transport_offset(skb) :
> -                   skb_network_offset(skb)) +
> -                  parms->tcfp_off_max_hint;
> -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> -             goto done;
> +     /* If the skb has shared frags the user is likely using zero-copy
> +      * (e.g. sendfile).  Those page frags may point to page-cache pages;
> +      * writing into them would silently corrupt the page cache.
> +      * Linearize so pedit operates on a private copy.
> +      * If you want zero-copy, don't use pedit.
> +       TL;DR if you want to use ZC, don't use pedit*/
> +     if (skb_has_shared_frag(skb)) {
> +             if (__skb_linearize(skb))
> +                     goto bad;
> +     }
>
>       tcf_lastuse_update(&p->tcf_tm);
>       tcf_action_update_bstats(&p->common, skb);
> @@ -414,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>       for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
>               int offset = tkey->off;
>               int hoffset = 0;
> +             int write_offset, write_len;
>               u32 *ptr, hdata;
>               u32 val;
>               int rc;
> @@ -451,12 +457,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>                       }
>               }
>
> -             if (!offset_valid(skb, hoffset + offset)) {
> -                     pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
> +             if (unlikely(check_add_overflow(hoffset, offset,
> +                                             &write_offset))) {
> +                     pr_info_ratelimited("tc action pedit offset overflow\n");
> +                     goto bad;
> +             }
> +
> +             if (!offset_valid(skb, write_offset)) {
> +                     pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
> +                                         write_offset);
>                       goto bad;
>               }
>
> -             ptr = skb_header_pointer(skb, hoffset + offset,
> +             if (write_offset < 0) {
> +                     if (skb_cow(skb, -write_offset))
> +                             goto bad;
> +             } else {
> +                     if (unlikely(check_add_overflow(write_offset,
> +                                                     (int)sizeof(hdata),
> +                                                     &write_len)))
> +                             goto bad;
> +                     if (skb_ensure_writable(skb, min_t(int, skb->len,
> +                                                        write_len)))
> +                             goto bad;
> +             }
> +
> +             ptr = skb_header_pointer(skb, write_offset,
>                                        sizeof(hdata), &hdata);
>               if (!ptr)
>                       goto bad;
> @@ -475,7 +501,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>
>               *ptr = ((*ptr & tkey->mask) ^ val);
>               if (ptr == &hdata)
> -                     skb_store_bits(skb, hoffset + offset, ptr, 4);
> +                     skb_store_bits(skb, write_offset, ptr, sizeof(hdata));
>       }
>
>       goto done;
> --
> 2.51.2.windows.1
>
> Thank you,
> Rajat

