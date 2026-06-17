Return-Path: <netdev+bounces-300119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I/wpJ1F2Mmpo0QUAu9opvQ
	(envelope-from <netdev+bounces-300119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:26:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED34698762
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:26:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=Ckgaye1w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300119-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300119-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B770A311BA63
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4228F39A04B;
	Wed, 17 Jun 2026 10:24:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622A3B7B97
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:24:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691848; cv=pass; b=AfuHGBEBE9+L4ekCvvr3yul/JS1azS64Nzg2IYEJF3iIFxUmGqUI3WDwBIjm7zhu1meAN+OVP3qAd8aPzkcs+iybhhkpHSk2iIRfQnNJhwN/I48VVMQRL2Wjqqrh1EiRj9fE7o18rKtDXgzN5ykjE4K1SGgBMtsfpBV/H58l1uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691848; c=relaxed/simple;
	bh=jVl8Kk+7N2+3A7OUo265p8WkCedRSfj20KGk2VYd3wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3E6EMUFRZYcUujVjs3JjmzLG49e9XEN+KNJNn1TvkWuHVUOH0p0H4CBu/z1HMBER56ZM7m1YSJmigLbj4IdgIpEM8h9VDoQPWJbOmO6vSzuk14DWBr0YM5geIFe3V6ZeY0PrICiOZ9jAZcPsNPlo1PO2uz3u2ipKIqnjmtRbXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ckgaye1w; arc=pass smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso4123158a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781691844; cv=none;
        d=google.com; s=arc-20240605;
        b=GgPJuWzG2ha14Y/pC8DedEy75jG362oCEy07AkZ95nqkA3cJSeK82XYz8CBZ25eb7w
         f/BEmP4g6BPsUETnsDQi1yE0K8oo6zzch0bwbLTadWKEfUFWfh1przbYoSTdOmpQY/Dw
         vxgqFCt0AT8jXi1wPDPjPInuhZKHOs8NtWVZt75qrI5NtQOgSffLwrDTqOVPsVq7fLLG
         nmQddInfphSwXn+EKvldjEgiGqONHTZIndNCMU1tRYES6VTky2hqxjhLOl/DmyhishNv
         at+1+U5qdzJ/y4De/tUXusMO75YLiZ8i7XgAXcshe+l3dWYFjKTCO0mFqryu9XmIonyS
         oL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SvAKPeBK/UEH+3cfnxX1t7rghGjDy5VtNAsb2Ilfjs0=;
        fh=rK9cgqV1BrCz3thbqOuUPM7G0xzghUport36JKT6PgM=;
        b=ANQbE9G/U/16SWsfmVV9asAQTAaZN4lfIdteqONxgorBjzTXgnGEq2Eej/jsOd4hK5
         IuN6tlwBB4leYp5R/OXhuOSyNxOYiX3jOg1jq6DJzdEoz5+oJ7igiRUq8ARleptAkb7H
         tD8mse7m3d6jIedX+fecSvRmPRRBFbJWzSDH21jaVeVLBKLilRG4ACqwjrqYr3SRj9S/
         JI88uSCqnW9lpy41xpeIn4XEYvhx4+ZmGaYVIUnMVGXAGnKUm4Z6B96V2ng5jKCXusEQ
         /383+DsZjdmKFJ9P32d+eNIqPPKDGQbwTNeZS5YV5Koystgg3od7cxWfkANe4KF1x4xo
         ryUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781691844; x=1782296644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvAKPeBK/UEH+3cfnxX1t7rghGjDy5VtNAsb2Ilfjs0=;
        b=Ckgaye1wLaYX/urugE+uW14hp7U6OGHLUfwKg8P24uiPhWjx38Ita2Vur/liQJA9gm
         EAp05bD9KaNW2HAsXjTBRjumMfRB+GPHDzpBbZ6FxI0UpnYP+cL0gHO/r0kNAW+Xe2rn
         mrATZdVm3h47tpigxClktdtNAI4Hu0GJqfWqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691844; x=1782296644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SvAKPeBK/UEH+3cfnxX1t7rghGjDy5VtNAsb2Ilfjs0=;
        b=clGtpIbJauzvWDV3ACQKJu1Pm6tm7UIMObDIQeLO9xu12bgQLH8XBVTuLAri0IFiUb
         oB4s+uwYQETI/AodyfJj439Kwx9fsSBTlEkVFiTM0OEuYRZHrKWkK7fnekfMdqvCYkUP
         RlqbqceUScP8fRma/dG4cot/HVm4lgbpy3TAJTKxQsZnBmr+610Ks9hv2WHZey64yUZH
         +lFQTw5HjNyxz1otWB1o/nATGQnbfI4cSYYT/dkvyYl3tZVbjf97wDod6rAFvoZxdcoC
         TbcB6muC8g8HmovlKoImuzsj5vDu/5OCNuZaRkTOwqgCkXNqAyDMZhu7wZccvItaYCIQ
         G1cw==
X-Gm-Message-State: AOJu0Yya0pYEsONQP896GiV7HgJiEN/B8NJJZGr+irGSRfj77DtvQSmr
	dWdiVRCQY+4UH+8sMRWO1Ihc7yl2FJBtIdumCOHgeU5j4x0Zi5GJJwWoNAd8558hNWLxbx0NXGT
	CzKpOlazbKljn0dO7pusSFZZQuh26BCTg42AR2C18ChH2Mg5WuLK7Yg==
X-Gm-Gg: AfdE7ck7bDpNLK6OnyokCVa8QrAzNC9Iscmi0maZvLAT3noblgAay0pU2NP32J2KKxw
	TQJDzhsZgP0CQfT1WYzG/d+5xAu4oFhkcOkNH8GPSVOOQQ7qf5gQYlgku/mOTZBX248UavKcoyu
	1U0M7Pd03n7HCU/idZP+ja8xrWtul40GPJMAIIIcgnCW4VPCIYod2RqFQ74+P02aERB6F3PrXW0
	JLlQ9bmGNW3XQOefBkkDmQ/S5Z4z1+vXiWbKUS3E3gaBSaDxBZTKRivSY9uNzoke5RYXe2dNw==
X-Received: by 2002:a05:6a00:138f:b0:842:77ab:35df with SMTP id
 d2e1a72fcca58-8452447d39dmr3419556b3a.11.1781691843947; Wed, 17 Jun 2026
 03:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616220303.31552-1-b1n@b1n.io>
In-Reply-To: <20260616220303.31552-1-b1n@b1n.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 17 Jun 2026 06:23:52 -0400
X-Gm-Features: AVVi8CcKfbarbJZ-bMsU6UB3-GhuhotwMtHzB7f6SaXLLmOIiEdwKWrsO43hrhY
Message-ID: <CAM0EoM=o+kBQNND8ViMe8bZQmFAtATav+CFMmtp1udzu+tpTzA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:b1n@b1n.io,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:stable@vger.kernel.org,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300119-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4ED34698762

On Tue, Jun 16, 2026 at 6:03=E2=80=AFPM Xingquan Liu <b1n@b1n.io> wrote:
>
> When DualPI2 splits a GSO skb into N segments, it propagates N
> additional packets to its parent before returning NET_XMIT_SUCCESS.
> The parent then accounts for the original skb once more, leaving its
> qlen one larger than the number of packets actually queued.
>
> With QFQ as the parent, after all real packets are dequeued, QFQ still
> has a non-zero qlen while its in-service aggregate has no active
> classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
> the result to qfq_peek_skb(), causing a NULL pointer dereference.
>
> Count only successfully queued segments and propagate the difference
> between the original skb and those segments. Return success whenever
> at least one segment was queued.
>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xingquan Liu <b1n@b1n.io>
> ---
>  net/sched/sch_dualpi2.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index dfec3c99eb45..37d6a8960310 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb,=
 struct Qdisc *sch,
>                 if (IS_ERR_OR_NULL(nskb))
>                         return qdisc_drop(skb, sch, to_free);
>
> -               cnt =3D 1;
> +               cnt =3D 0;
>                 byte_len =3D 0;
>                 orig_len =3D qdisc_pkt_len(skb);
>                 skb_list_walk_safe(nskb, nskb, next) {
> @@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *sk=
b, struct Qdisc *sch,
>                                 byte_len +=3D nskb->len;
>                         }
>                 }
> -               if (cnt > 1) {
> +               if (cnt > 0) {
>                         /* The caller will add the original skb stats to =
its
>                          * backlog, compensate this if any nskb is enqueu=
ed.
>                          */
> -                       --cnt;
> -                       byte_len -=3D orig_len;
> +                       qdisc_tree_reduce_backlog(sch, 1 - cnt,
> +                                                 orig_len - byte_len);
>                 }
> -               qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
>                 consume_skb(skb);
> -               return err;
> +               return cnt > 0 ? NET_XMIT_SUCCESS : err;
>         }

This looks like a behavior change?
Ex: If the last segment failed you will return XMIT_SUCCESS whereas
before it could be with __NET_XMIT_BYPASS, NET_XMIT_CN,  etc.
I am not sure what the best answer is and maybe it doesnt matter. Did
you look at what other qdiscs do? I dont have time right now but will
later - or you can before i get to it.
Also, you didnt add the owner of this qdisc on your to:  - maybe he
has some thoughts..

cheers,
jamal


>         return dualpi2_enqueue_skb(skb, sch, to_free);
>  }
>
> base-commit: fbc6a80cb5d3fd4ac4b56e8c9d791dd17be890c4
> --
> Xingquan Liu
>

