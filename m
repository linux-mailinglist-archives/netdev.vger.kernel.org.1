Return-Path: <netdev+bounces-281149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MSVCA7w7WmYpAAAu9opvQ
	(envelope-from <netdev+bounces-281149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 12:59:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370046978D
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B496300C03B
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C041935028C;
	Sun, 26 Apr 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="B08oLEGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB612D781B
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201158; cv=pass; b=P761u7LWpubxJNpg2AneuX32Bo19zC+6PiOianeJzW/6WjiDJNc1fIA5kOcHeu2Qs6iwkQrZRW2S3IlUWex60jE8H88dVbQfJ1+87ECSAuq/8u+EztXba8l+W6bcFqe+WvqhajRc6vHQ3OIa488RliLb4pEfbLDu3o5sTkr8aP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201158; c=relaxed/simple;
	bh=QzJaR5J8RyQ1tSvYBbCR8p3++ETasbsBmRkAIgSzkcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rydun17x3UTv16KDtpNQIkIjEbtQUZVC9EHjOKyeTekjJz8UlfPD74dNjm4URiqWKspsrk3m6PahYm5uZlsCc8kqyxhVB/gxKZdWMGVGXWell7hyftz+Qwwr12jPRi3R5OLU8N7NjjomLcUtDUw4XSdCuheGdqt08gm5UnTiLfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=B08oLEGj; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824c9da9928so4514484b3a.3
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 03:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777201156; cv=none;
        d=google.com; s=arc-20240605;
        b=c6DRRVX9aGz6TYQCVUQMIKsxZb1t2BPRZG/cqBOLO1+F73iy6wPQTYVL5RIiZ97NgE
         llBElXDgutfdCRvJbE4OeeYQdmdCt5vRbCDmHGhh56TBTPoo8ziblmEuqp2q0oNMsbxZ
         eSuIJajHrf5JtyLZBeUIR8LWGT5bOV2AGGrUHrbRipK5A+l94MVGMg/f8WMBfk0UagdQ
         575FA/8LlKxorQgNpIM7ZIQVwl9UXAynzZ1aSlspVQOHO4Jsy5CQkEU7vkCLSNbzCYwW
         JQFPDeD8Ct6RlS5G0uoQB2HRU6uXGlCNXZl5o1VSo+O7Ahy+aWYo9I+Hp6gubPcweonG
         r7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z43G+siVNfTfqwol+9vvew4HXuMyxWOD6fgODyjOUvQ=;
        fh=EruPg5Y70NE1t78oFrq3qtkEKbniGc9twGTxhhTnna8=;
        b=Bdx6lgu27DA/Nu1WB99Fx1NymeN3rSA5aDpCnEJR89PrfMF30G/w4jMn3TvRLsGyMg
         rKWTzM8fCOQMkyrbucu1SUFpQm2MSKc8rWv00h9q6dqiBKsqXA+Jj//iBiEuzZZbo8L+
         ULPxlmKY3T3L5IEs/NLtnaPrZrb/2XfaIUwihs2fGwNASrTXSkA28C574USNnfiJx5v6
         AcJ1+MaQL4MGFjUX7mfinpsl6KM5wokkGBR+7iNPew+0Tr5AOkthtFU4REVwdhtK0DDy
         g+RW8BaJx3ya2sbGvfzfWBIAtCbq6pSUIxAGJK3FDZwLfulsUdVZ4WrSq293h4EQz49V
         +8ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777201156; x=1777805956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z43G+siVNfTfqwol+9vvew4HXuMyxWOD6fgODyjOUvQ=;
        b=B08oLEGj/zc12Ig6OaXkOTVYSJcqLydB+YVE9o1A6uO4L1/YnkefZaBQ6W8RNaoHcf
         vu6XB7WSzmX34fTDGkvo56i8YHnY8lqI15kH+NU5L2chPGStXtdS494PDFvZ3TNBAUju
         lKqWYgbnAR47FuWb0+nWmGLganAeIAXxYbBCSeFypb9onrsjjIsrOuLbIoNoDKp592DY
         jXMoCWfIuN5UPNEB6uvx+2opwUOZMwkvCY6wCvjXKzVbLwXSJu9R1lfURZvVigK9rmrU
         LdSOwGHrtwrlH7fzyjb6AgdJ7XdRh6TgbagRVpTHY8JQ4XvjGdPN/4MwaG0zNgK9ozss
         dhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201156; x=1777805956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z43G+siVNfTfqwol+9vvew4HXuMyxWOD6fgODyjOUvQ=;
        b=JN8Y2s9GYRBS/crp7VRTqw6u9A55TBdEf9fXhvfnnaNTxG9eEE/P3RkAPdGcIux27t
         m5d8Fpn9AIObrjkJvNo4kf0b/Bx9fjKjFl8xr5FmdZ6c5FjNxMwjFWbhwqnhypwFCz/q
         dFA7SZk/1jx8iz7AyKeTX+Tyu9tTMY4duceWwZtJnE707HuzhFFT4NhGXQ5UCKoDtjmE
         sIQfle5H+q6QD5yw9GK7cu9PVcOOgN6NXIcRJHAwYyrGUldwwyt3AiDfl2syUkx8anKq
         dqtn+m2HlHac4RYuhNdfNRtRwsmwa4kSXFr5+KlidrkCgnJZm7iOfcWmnyJtCCi6l8Sy
         lF9g==
X-Forwarded-Encrypted: i=1; AFNElJ/B894IZJJvxdKZr9ZThBma1aB2+WlFqN6TcQ09WlSBYRRZ6Io6bKY7sGF+K3HkiWA0wxkp7i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCA3Nn0RxXFrlORLEy0iNkMfsGMnbNRLq0Z0icOBUpPAJ+Ea+
	h9Chem2lsdDFUBDJut/X4wY0G+3F9GFwZl+8oiCksgUjmZi0ZpyMuiJ1//x5HB7hc3MnshvoT3k
	SoHVdYOgbx7DjQQon+bf8JsDZdM1AwJE5xr+WDOlQ
X-Gm-Gg: AeBDietlHNRzuXKqJjx/x61PURCJsinsZSaLdE2mj5OCar4jWgwEEqYxssIouBVBKz2
	Nk/R2AMoyAA2B3MA0H5TkYaytZ/UQbHrlhhMPzDUGHGFnt5dGZ4RCBByJOPtID0toAc0qzLaPQM
	9Vd+cxo+tvn92P43cUnOy0mkMubduWvPOOXJvxEJ7iMJiaSUrgOSjzRKLBhjm6dAJABMP+ssW3b
	yw2e4Hj4M7vqY0+MWBI6Yemsefkip95xzbWLtBxUwobE+RdesYGWCFwMpy16Vu4bYzBIQ8Vwcpp
	0D97NsbFDSYQkbE07iWmHEF/yojtUBDUINpNgiDW
X-Received: by 2002:a05:6a00:1bc6:b0:82f:1b1b:e166 with SMTP id
 d2e1a72fcca58-82f8c99159emr41296406b3a.33.1777201156605; Sun, 26 Apr 2026
 03:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422161958.2517539-2-bestswngs@gmail.com> <20260422161958.2517539-3-bestswngs@gmail.com>
In-Reply-To: <20260422161958.2517539-3-bestswngs@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 26 Apr 2026 06:59:05 -0400
X-Gm-Features: AQROBzDdlUOYkMaP9cdvY9lBi6RpAH3mvy83bOI6hcc8joAewAsu9FYK5nmnDUU
Message-ID: <CAM0EoMka18Lsu94wTFZU3ntXP9Z3vNy0Get+=THPdsCafcoPnw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] net/sched: taprio: fix NULL pointer
 dereference in class dump
To: Weiming Shi <bestswngs@gmail.com>
Cc: vinicius.gomes@intel.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vladimir.oltean@nxp.com, shuah@kernel.org, xmei5@asu.edu, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4370046978D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281149-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.787];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,asu.edu:email]

On Wed, Apr 22, 2026 at 12:20=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> =
wrote:
>
> When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
> is called with new =3D=3D NULL and stores NULL into q->qdiscs[cl - 1].
> Subsequent RTM_GETTCLASS dump operations walk all classes via
> taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
> returning the NULL pointer, then dereferences it to read child->handle,
> causing a kernel NULL pointer dereference.
>
> The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
> with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
> namespaces enabled, an unprivileged local user can trigger a kernel
> panic by creating a taprio qdisc inside a new network namespace,
> grafting an explicit child qdisc, deleting it, and requesting a class
> dump. The RTM_GETTCLASS dump itself requires no capability.
>
>  Oops: general protection fault, probably for non-canonical address 0xdff=
ffc0000000007: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
>  RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2478)
>  Call Trace:
>   <TASK>
>   tc_fill_tclass (net/sched/sch_api.c:1966)
>   qdisc_class_dump (net/sched/sch_api.c:2326)
>   taprio_walk (net/sched/sch_taprio.c:2514)
>   tc_dump_tclass_qdisc (net/sched/sch_api.c:2352)
>   tc_dump_tclass_root (net/sched/sch_api.c:2370)
>   tc_dump_tclass (net/sched/sch_api.c:2431)
>   rtnl_dumpit (net/core/rtnetlink.c:6864)
>   netlink_dump (net/netlink/af_netlink.c:2325)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6959)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   </TASK>
>
> Fix this by substituting &noop_qdisc when new is NULL in
> taprio_graft(), a common pattern used by other qdiscs (e.g.,
> multiq_graft()) to ensure the q->qdiscs[] slots are never NULL.
> This makes control-plane dump paths safe without requiring individual
> NULL checks.
>
> Since the data-plane paths (taprio_enqueue and taprio_dequeue_from_txq)
> previously had explicit NULL guards that would drop/skip the packet
> cleanly, update those checks to test for &noop_qdisc instead. Without
> this, packets would reach taprio_enqueue_one() which increments the root
> qdisc's qlen and backlog before calling the child's enqueue; noop_qdisc
> drops the packet but those counters are never rolled back, permanently
> inflating the root qdisc's statistics.
>
> After this change *old can be a valid qdisc, NULL, or &noop_qdisc.
> Only call qdisc_put(*old) in the first case to avoid decreasing
> noop_qdisc's refcount, which was never increased.
>
> Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual =
q->qdiscs[]")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-6

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Please add Tested-by: if you tested it with the tdc patch in 2/2

cheers,
jamal
> ---
>  net/sched/sch_taprio.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 8e37528119506..a7daf34593e07 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -634,7 +634,7 @@ static int taprio_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>         queue =3D skb_get_queue_mapping(skb);
>
>         child =3D q->qdiscs[queue];
> -       if (unlikely(!child))
> +       if (unlikely(child =3D=3D &noop_qdisc))
>                 return qdisc_drop(skb, sch, to_free);
>
>         if (taprio_skb_exceeds_queue_max_sdu(sch, skb)) {
> @@ -717,7 +717,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct=
 Qdisc *sch, int txq,
>         int len;
>         u8 tc;
>
> -       if (unlikely(!child))
> +       if (unlikely(child =3D=3D &noop_qdisc))
>                 return NULL;
>
>         if (TXTIME_ASSIST_IS_ENABLED(q->flags))
> @@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned=
 long cl,
>         if (!dev_queue)
>                 return -EINVAL;
>
> +       if (!new)
> +               new =3D &noop_qdisc;
> +
>         if (dev->flags & IFF_UP)
>                 dev_deactivate(dev, false);
>
> @@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsign=
ed long cl,
>         *old =3D q->qdiscs[cl - 1];
>         if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
>                 WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) !=3D *old);
> -               if (new)
> +               if (new !=3D &noop_qdisc)
>                         qdisc_refcount_inc(new);
> -               if (*old)
> +               if (*old && *old !=3D &noop_qdisc)
>                         qdisc_put(*old);
>         }
>
>         q->qdiscs[cl - 1] =3D new;
> -       if (new)
> +       if (new !=3D &noop_qdisc)
>                 new->flags |=3D TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
>
>         if (dev->flags & IFF_UP)
> --
> 2.43.0
>

