Return-Path: <netdev+bounces-302135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lY0JGGVMPmqgCwkAu9opvQ
	(envelope-from <netdev+bounces-302135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:54:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE636CBDC3
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:54:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=aLa9iGIm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302135-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302135-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859BF3022FA7
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F443E9C32;
	Fri, 26 Jun 2026 09:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AF3E51DB
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:54:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467676; cv=pass; b=QXrKmHg2Li2C+HUKaa9m6bAfA1GXknpF/fpxrTi3mZ3Z0xxoS+ZlPdDtPTFFIyZ1jA59hWZCGzUl/G8ZWVfavdnfwfnn63PIoywUZe/d+34iLs5l8ij6+da+vaSk337EJVJLOqqcVc0fHbeKa9/DceQ9FLnAgq/0zm7SxWnOgsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467676; c=relaxed/simple;
	bh=5Ujxexs7zgr7C40wCeMDjMeQCtjw6UIbG164MRDU/pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVAMtgFUMqe8k5F2ab/PMQUQEU7L2N/Eh6JlAgEi15Vq7v/IrogtijQpUm2Z1x6lxx6+M7Kmufv/Cxcgp3dcmh/dZQNRdFcFiMDwYeexNGQv1b3L9AKzwcf4MUFIrQ8g2ReJERsvS/m9fn5/mhoslXWsBxS3b2ES1vHc+ASW78Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=aLa9iGIm; arc=pass smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845385adf4cso304951b3a.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 02:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782467674; cv=none;
        d=google.com; s=arc-20260327;
        b=FY8uJkQDHscJA0xDcrfxgDCk6AEX0nKtTP9OqyrfH0R9ORo7m9WZ1XP3VfU+OpTZd9
         d1P/9e/JF39PznEo5c2nQag5mUVhVeD4goyUDq7cNPon/ztIg14+rFsvhM1QpHvudS0z
         dSco2YadJK8+217Yt1nDZN8WTTjCa3WS0oT+Api7luB/0VjECIh5GI5Vg4uO97wb1OHI
         dGc0hBKtglZIbKW765SPQN1guCqvkoYxja+IPb4xD8WswmkhKEo7BENUSsHHNZmw3dth
         VjZrQUawAU66DdYhap0BTyfvjcIbqo4yqcj0xjLaAmJHX54h4X3luwiUvN1zk1hflB1v
         1iNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tb6/kCYFWaOp2/+XL8Yus2t+0SvabVj6fTOT0ndFg+g=;
        fh=criikB2eCkSb0oe24NhTkWcMWM1DWj6st8k1kU5v+nc=;
        b=Yzl26Pw/ExHUx4P83bly4jWQYU0B0zPxkVKKXmD4AO9tp7VMZy3YMGMwT8/zTZo2Wq
         7uRGGmJclHudQmsWc/TuEwV7TPxMZNxf/YfLK55Wv90n0Mj7VwULNivjY5Jw7/udHlBv
         a8sw7nRygrW6syEQg8wv2R0GEXQo/smhx2L3CF//irnnMxvB5uNUYlBzDj+D7I7s2o7w
         l50B3wyzKKeAqHjRFSuVr2lm4Qh0oxqfH3W5oa/DkAQPA1WbSq+F1wdyhWkpu64ilk5j
         OH2JOoSr3EIJG+2eKXS2PH2n0a4nlr+O34xB06IoiR4i6oX/vXw8sJqsvohd41KTpw9N
         yQag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782467674; x=1783072474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb6/kCYFWaOp2/+XL8Yus2t+0SvabVj6fTOT0ndFg+g=;
        b=aLa9iGIm3ZSmgm+ndmH0moLTWmzv3qKfRDdhABwSMGJueGwiIDbuwnxxGG0I5KULCR
         mVtBA4en5w96Q7e9RPcl+PoqeGNbmKyh0RhcMpuT2uoPlipOw06Ps19DqMB1LlNF/QwV
         HGUW2zqlgldDN4TTwBBsZm0frD0QTmhF8v2Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782467674; x=1783072474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tb6/kCYFWaOp2/+XL8Yus2t+0SvabVj6fTOT0ndFg+g=;
        b=aksCRIUTeND7V412JHK0t9WFMZp8Bt/Q7JjfCEhpo+O/yekHGkwjKgK17GIODKcGXY
         RBIcSjoaj41eLe+91HQL+eTevWUq8XA/3nAas9AbL7FtQZ1Ly/ue3sN13SqpyL3aPawA
         M6iqkK1/okaa6W4EVPRrc+H11+1iF0IT0dnaMYnQh3wKcXqBac4phIK2p1YO0K3AH8MV
         sCSn/SQfoU6LBKmnzw3whFcI75l8e1tqg2qCQw0ZQegFNmyr++vRHEAD7ibbvUsGkRmQ
         fNMRj47G3NUawKV2Vtk72PzUYd3qLoy+zIYRQogxNMdljAqSL28b7KKjrWuuS6DOUyYk
         v1/A==
X-Gm-Message-State: AOJu0YyGFFp6DlEBLr7AZ7i2YQer/h+sja48gFpLpVvU35adM6mPwTTu
	t7Lfzt3hgNzfPPP5iwd5GR8H7U1GSZYpTbuqniDxtgIH6rVOqsPBfvueFKVjQ3xo9nWkRBZZ2vh
	8OQv9VexF+4ROg9YF0sCy+cpTlzwZQrjNla5FCxnz
X-Gm-Gg: AfdE7clYy16npSqKD1ZYX1bo2eEgevWnvL+cT+4D0tGlscKFLe0vLp/OpSb35uEXsxZ
	oNyy/Gtc6wVWvpncK6P9N4/AxaWor+sEq21nNvhIlW9w2nSbx1WP73X0EJqTgxaXU/FBJTiQzQR
	M1zZp1rLyd3gC562ZGrFRgZ9SYtrd07Lpy7lPiD5jpPNEomEzx55CCIVZK8I8e80b09VrScTzAQ
	F39LBXYtVwxkdm2Nr+oiWWexa1YVP1RUnC2mf6Zbj4kZKlj7NWMrO0A22CaLW1wdExcxtJMfw==
X-Received: by 2002:a05:6a00:1d14:b0:842:83d1:ee6d with SMTP id
 d2e1a72fcca58-845b3b09c68mr7082948b3a.45.1782467674607; Fri, 26 Jun 2026
 02:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
In-Reply-To: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Jun 2026 05:54:23 -0400
X-Gm-Features: AVVi8CesP5WdQnuL7V6DAuZuumuosjiasQ7RcpRqFUUrhtsG9gqIm1VOJLRxPNM
Message-ID: <CAM0EoM=FvNKemH4Z5dL_pFQZcGWxLb4c_AMahOePLY7s6Pkhcg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: sched: ets: avoid deficit wrap and bound
 empty dequeue rounds
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	petrm@mellanox.com, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:petrm@mellanox.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,mellanox.com,gmail.com,lzu.edu.cn,icloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DE636CBDC3

On Fri, Jun 26, 2026 at 4:32=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> ETS keeps each DRR-style deficit in a u32 and replenishes it with
> the configured quantum whenever the head packet is too large. Both
> the quantum and qdisc_pkt_len() are user-controlled inputs: a large
> quantum can wrap the deficit counter, while a tiny quantum combined
> with an inflated qdisc_pkt_len() can force billions of iterations in
> softirq context before any packet becomes eligible.
>
> Store the deficit in u64 so replenishment cannot wrap the counter.
> This keeps the existing dequeue logic unchanged while fixing the
> overflow condition.
>
> Bound one dequeue attempt to at most nbands * 2 ETS rotations, as
> suggested in review. This avoids the livelock without adding heavier
> logic to the fast path.
>
> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Note, you did not Cc many maintainers. Next time, or if you have to
resend this patch make sure you Cc the stakeholders (see
scripts/get_maintainers.pl)

cheers,
jamal

> ---
> changes in v2:
>   - Instead of doing a div() in the fast path, simply bound the loop per
>     dequeue
>   - v1 Link: https://lore.kernel.org/all/20260615103759.2404228-2-n05ec@l=
zu.edu.cn/
>
>
>  net/sched/sch_ets.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index cb8cf437ce87..12a156ccb0a6 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -40,7 +40,7 @@ struct ets_class {
>         struct list_head alist; /* In struct ets_sched.active. */
>         struct Qdisc *qdisc;
>         u32 quantum;
> -       u32 deficit;
> +       u64 deficit;
>         struct gnet_stats_basic_sync bstats;
>         struct gnet_stats_queue qstats;
>  };
> @@ -463,6 +463,8 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_bu=
ff *skb)
>  static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
>  {
>         struct ets_sched *q =3D qdisc_priv(sch);
> +       unsigned int max_loops =3D READ_ONCE(q->nbands) * 2;
> +       unsigned int loops =3D 0;
>         struct ets_class *cl;
>         struct sk_buff *skb;
>         unsigned int band;
> @@ -499,6 +501,8 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc=
 *sch)
>
>                 cl->deficit +=3D READ_ONCE(cl->quantum);
>                 list_move_tail(&cl->alist, &q->active);
> +               if (++loops > max_loops)
> +                       goto out;
>         }
>  out:
>         return NULL;
> --
> 2.47.3
>

