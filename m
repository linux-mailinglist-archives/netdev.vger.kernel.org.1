Return-Path: <netdev+bounces-300816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QZ9nGgaYNmpaBgcAu9opvQ
	(envelope-from <netdev+bounces-300816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:39:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 708D56A8F43
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:39:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=bOFvcPQr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300816-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300816-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 214D63022F8E
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323D3911AF;
	Sat, 20 Jun 2026 13:39:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAB367282
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:39:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962755; cv=pass; b=Yxa0GwlOZhnhmYeF38mMaJsBOqfSmXB63umZHhHk9EftQn6aaXVON4fgkHGE/ucNWjI2eWFuoSZlJOk+ntVfiD6VIGls8MgOoqbDT9hbgk0pbrBBwMDzcGFrB59nBJi6Xwsy5zhidm6UjhmN2KdInEDei0wP9qH/gbX7IYUaU7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962755; c=relaxed/simple;
	bh=d/2Xphxb/NI8SXff8epqBhW9BadwTw3kZPh26Vr8TxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaRnz1i8VCXtDrqol8xyy094FwDT6hFyQEdNbdhu8vOdTgnMuaoSuAW8IPuWHZbyUHZ7aHySssIOFI4jgyPUrjE68t2KlI8MQrHj4VRH8VikV3TqxoMgqqGfa3LNmIySARhpPhyf1tpgQ0Cju9QUtETy3nspZg0M6agV/Jyiwno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bOFvcPQr; arc=pass smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6607e80a846so3149827d50.2
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 06:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781962753; cv=none;
        d=google.com; s=arc-20240605;
        b=hNYvvK2xJAXRd2ZorzekGyRwHLGVjvhlNYhfREB28uHWlPEkZ5UESn6eP17h61a6uV
         R/pPBcM7Rb2VJ4I6zUEmhGEFtuU1YaOiIXNPS91riEJ46uQyNKNfQ8eMUnnH2ZphsOHi
         GbzIiwSg6JRuly58Gz4vNnzP3rH4/RtUK1AHANISHgc2JyraFc+COmjfObPbkxgbrDro
         9silu5CNcUUdUpRB7Uzm82zvc4anwK8CGqmbojviPKCtzsLPS8L1cB3mJC7vkmAA5f31
         g/CR/zchJKH99mh+NIvKSFBBDQIb5K0GzhWC3EOEN0YJIZRtiPxCgX6unsLA9s/kO1bs
         WXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvXJJoRTCi60JChXHq7XeN8L9UaXun9JAUDhzWqhDrg=;
        fh=OaO+3kx0/721xRtdNa7POUbCKMzRu6bcovlF8EZJpek=;
        b=UW6KJeTSryl1kjvDmuci/ZOUehgApjL27H8qmb6E38Ixk+eEVddSFPOxcWlihSznvF
         g7nblJ+wNP3z7kjmJn67RmBPur1Xu1GivWaJBA8DQ8sR31ORMIQr57dSNz401mZkeQLB
         Iq28XzbZScZ7JnYMLBpnffCsz0uYYVsN6r62nYHVHzAF61rIfDaBmxGj0CSQIdoPaYmO
         Yazcp4uwhpbpq8uOlvuNkhUULFcTv9KojnZP90PrBQaALWcU3RJfJkrt/Y1yKpDO0cRI
         7GNonCcXtL7GbEd/pvEtkptN3r0TWTneWsnIDfcFobBuk5ZvYkchH2F5cZcACGkwnB36
         hBHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781962753; x=1782567553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvXJJoRTCi60JChXHq7XeN8L9UaXun9JAUDhzWqhDrg=;
        b=bOFvcPQrVxthXOvC7Jm31Cj8l7hm+sQ6sQlv08piCTiTzZhEhAzOUqDqjOtmqgzcYk
         xPXHoaJpNOvgRdaw89x3wvmbWCG/cz8Cg6LruFj8hZIBT4+AABPMqsyOqnWrBeJKd6xT
         kxuo+3VnPNj+6pYSoUGBRjQoHdy2e+z0pQctc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962753; x=1782567553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvXJJoRTCi60JChXHq7XeN8L9UaXun9JAUDhzWqhDrg=;
        b=Jm2fXr+3bd426H8qX9O6CjeixI3mnuV5DDhswiRsD48RbuxOskT6n5a9rpTai4c2y/
         vMmwPFFdOBf44idf7/0V+u8QJw8LivafhlVakCnrsX4OOKktklGv3tvF1dii2LRZ/2tm
         fVTXW1UkBRQhhx1+V54bVgkArXjKXt2v4C/kf17aq2N0p3yOyZyROX4BpL/gw49LvzpY
         Fjvs+rAuT10Kp7F5ijSdGue2eldtQc7JVzgnpMuYGOgDkYDPBIDz7aOeGuWrd1w1rEkM
         VjWw06PG14O4ys82FwGeRk4VXztBlKE/9YHEutTKY1VX8LkI1wdzw4UcVBnFdAaCmXMv
         /DrQ==
X-Gm-Message-State: AOJu0YzIkpxdD66tsc/g2rRW+zO7uxjQEMzKYyClrs9tQxUTsEDH7Q9h
	C+/p9Q9+fl+XTBHUSYcB6ZkM6+FMhhm0mI5WWRacVRsGuTgJrNQ0kDE6ZSWlqPqfWxAFuN2AsSK
	r6f65v75VbmUqYhyQBYYGAbmvnilMZ8Gx62+H+l2t
X-Gm-Gg: AfdE7cmpGzSGlIrIBVnibyBd0oltsaCq4J+YC8on9rJEC6z/ZjY/89o3JCV19IWRvG7
	AyuCeOSUFBAREaKkCP0ClotV5IOMSJAFX1e8HWH9o2LmODT+37Zo2+X1FUoWR74exFfB1z2qPYm
	yvmm4fPmIQOi/pu+ACr0Zb8qWbpimVH743Y02InqmElPoBnQ38o6xbz/kZIlAIOikP0MlYX81ph
	ZuWC+p2DThuxI/4yhpGpPQ6iVFHjOLs/2DRQjShR2W5kt7bPz+m99c7v8Ic8/A7z64hyA==
X-Received: by 2002:a53:b009:0:b0:65e:48cd:7fd2 with SMTP id
 956f58d0204a3-662fcb97f1cmr6274557d50.54.1781962753338; Sat, 20 Jun 2026
 06:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-1-b1n@b1n.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 20 Jun 2026 09:39:01 -0400
X-Gm-Features: AVVi8CeG_uNdG2Eo3vidjrDC2ro61mWJTdFhQ08AjfXtcR5BUcwg6QZpXpOAysw
Message-ID: <CAM0EoMk74Q5W7OFP8OM7YBT6MKPmdeXXo=XQZs8vUMv3eH1rVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:b1n@b1n.io,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:chia-yu.chang@nokia-bell-labs.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300816-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:dkim,mojatatu.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,tdc_gso.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 708D56A8F43

On Fri, Jun 19, 2026 at 11:15=E2=80=AFAM Xingquan Liu <b1n@b1n.io> wrote:
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
> Follow the same pattern used by tbf_segment() and taprio: count only
> successfully queued segments, propagate the difference between the
> original skb and those segments, and return NET_XMIT_SUCCESS whenever
> at least one segment was queued.
>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xingquan Liu <b1n@b1n.io>

BTW, in the future make sure you wait at least 24 hours before you
send an updated version.
You didnt do that here..

cheers,
jamal
> ---
> v3:
> - Move the UDP GSO sender into tdc_gso.py.
>
> v2:
> - Change patch commit message.
> - Add tdc test.
>
>  net/sched/sch_dualpi2.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index d7c3254ef800..5434df6ca8ef 100644
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
>         return dualpi2_enqueue_skb(skb, sch, to_free);
>  }
>
> base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
> --
> Xingquan Liu
>

