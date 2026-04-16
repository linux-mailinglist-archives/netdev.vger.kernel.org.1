Return-Path: <netdev+bounces-279087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCP4CXYF4WkuogAAu9opvQ
	(envelope-from <netdev+bounces-279087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:51:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B94984113CE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF7F630090B9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D585283FEA;
	Thu, 16 Apr 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="nlB1ociA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE43279DC9
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354674; cv=pass; b=Dsm2FFy5phvBo4UCEk0jnI+zTsvG1ac7SsEdG4YKBRI0X8Pfj2FOatvsrbuIbmEEUr+CvMk2oh/+EzHcihdxbVbD7i7HYnkY2hAhyybhkFoIs0N9ySZaH3poNbD/uMAVsgJDEVF1VW8iIMPPjJK3yVDKEB/ZwvWGv5DItG59PAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354674; c=relaxed/simple;
	bh=ovxA1rVcop/GRtoVBlh76k7GZ/E7Xml0GbSQXq+DETE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDSO+qp9Lan54h9rYab3UTJc5eTjANZj6kZoZKynrNaJpuz0Ck+JDL/8bZairuVmS9NjddnNZTjmkB5VoHpmVn2cXkJdVQwSvklLutEs2q1rb6Cqgfv/XzvKd3sT3krsUhMF+sFgEldnFM53TFdaVJ28OfEnfFQUi0GG1MvP4T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=nlB1ociA; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so912592b3a.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776354672; cv=none;
        d=google.com; s=arc-20240605;
        b=f+kTqOKt64q8+5i0vk8NBFwCm73QDhB40i3q6ZhzRNT8Xhi/Tma1HgxtfKyzvPtmyo
         hsMjd4nTqZcSbXlaeZotd5Xlu4NfkEj3rmUGSkYuOg9x3nMRISN+yEylELrCVxE8vnEJ
         2+SsrgGNoft9VvS7Hgs8LUiH1SAjrqDBPr9j3kQ4iquGPNYE6AfdJqSwSWpfP3nGxLKm
         bZ0VDEy4Mtky7hGC6G1sksWVlBrHKoQdJKux9t8tgQOtCFkVt8Ymth85zUBlp762Q6i4
         Rn0zlCfFHjLXaehBvwSNM4dPpKDIHLycR0tvGR5kCD9I99Mdm5KhxSXqJdOw0KhCCwL8
         oKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wy1Hhpc0YL/d0ByAj1ppH0lzg/JZtQK5U+740uHRgDU=;
        fh=PuqcUxu4msIZB5zgoBNGY23mGpwhvshcgpDg+WFITPc=;
        b=Jl2CheLq0yjsMwaDF51KQoqIy3TkeUb0fe7E2+7JR4uZKNQ6R88XzYHWI+WXZXBixK
         eYGbrBBQ9pD2CWGQFAgQw54Fav48Frw4TYgdnFmGIgF6Vd83Kh0d9cFm9vdCi+eCpEFp
         ELGXVhPDVtOpOwwuSPaGjPn141Coj4/0CunylSCNKHxKUMq6jakvMlTPoZG3evbBNePs
         moTAfv+4Vxrn/quUAWNNg1EAcMw9qCyonsCfoVV60pyRK47hBmpjsdr4y8j9BzFS6ij7
         28XIJuMJGsYPLbjLedf37en+QsHuA9dZfReUqXt/m9F67tZIqm39yceRcYRZlVW4KgC6
         /FMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1776354672; x=1776959472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy1Hhpc0YL/d0ByAj1ppH0lzg/JZtQK5U+740uHRgDU=;
        b=nlB1ociAulMCczDXmQejg+ZGGT1rRgaHpV2on+q+5CJcR7jDogsZjVUPMO3++bsVHR
         n+nuixIBxrHsmYyBPDcO7DDDRxF32ZCiCR1zwKTqlSyRywj21P4u3fqs4xaEtRh82/h+
         XzZb/0SCxo6LB/FCYceIpn5tbYOiFN+/HbMJmDua3XyBomLiDSUhZfZtpFEe6bS0O824
         GBC+NSqdboiGD8RT2gb6y+7MAlgW+1FIzq1gclgd/fxR4JEdC5rl1rn5vnwAcaGRSeq8
         p4L3JNCwrnGms65xp251WPFkD5TfwjLS2FpM/AaGWwZFShicP6+ZlSpIVpm4oO4wT7uE
         y95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354672; x=1776959472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wy1Hhpc0YL/d0ByAj1ppH0lzg/JZtQK5U+740uHRgDU=;
        b=VShlZ1Tgxw9ECBPMb1FBC8ZKwylk9oX5ibS1dFgEOK1MKec0CV2U0n1lLP/Tsiakmd
         AKqzYEWo0uJFO8uBbYFjVM7e0q6PBJWQFs0kKIFfy8vkzU9wKLV+UVNJBNLZqy1E0bn2
         qAMrvUCzr7Zl2Z4/5AQHwTXO5MHedOjpIvOXAhpe1pnYjmzy/PcxNApXEwY5b77BmdOR
         QfbGMOBbfZyRqJNGHMXWK9LwrKCw6xNLCAKYOBQ4saA5uh0V8eRr4frriOqjDmuuZkv0
         hmEJ/+9C5RIqrCX7cq9MsUi7Igzs/Zm9Pux9VeUIe6M1rkMdHiAojz1AhZLyn0kcc9VI
         LjnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ey1W20mcoz/vaatRkKitGohC9s+0cWJAOPtm122+0qtqUyzdil9RxN3eNULmCuJo1ALLBwPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwWV1YiNpnw6g8AJ7ZOVG4hPjCK0pMrCF7jEOvvsPBhO/pICH
	o7xmDII10Quaq1r0LAgYKAHLRWmxnM20kqxIC0ZErvlmR7MBH2uIzoos/KNMb6XLDMbtOdWVWnG
	QN53B4+ib56km0GL8+51hbTlkAgJOLm6J7EF5at9u
X-Gm-Gg: AeBDievzmXM9mX8dG/osvEvSKySn0ReEw+xnVwckeneZtRheikm/VAHVgf/UPOM03U8
	twcNsogYE5ZGqOjJd0+HXWuLAPVFT+gVAIMprixCAdCpatuCF/9VVkVbnA0igGBzEl/kH6iMmTi
	rCdOjWmiJ34ec5IXjJZQ+v9ZKkc0WAclZkPnxV+M8FTYmD35emrfFz7CcRoADw/dBMnOi2jnVQa
	cCn8dsrpoc+F6WphdReB4ybMb6jzvbyUV47W1I/A5+MCvsanqrvLGX6kf/ZPxgnQAX2DSaHVfTn
	zt2FYWC+uAhup9y1q0A=
X-Received: by 2002:a05:6a00:a223:b0:82f:6e7:1527 with SMTP id
 d2e1a72fcca58-82f0c18957amr25140160b3a.23.1776354672068; Thu, 16 Apr 2026
 08:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414104311.74115-2-bestswngs@gmail.com>
In-Reply-To: <20260414104311.74115-2-bestswngs@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 16 Apr 2026 11:50:59 -0400
X-Gm-Features: AQROBzDcU-DVMz_WOs436MakWGqUVeoQ3VHNAhpniKVTj-2GyAjCl4-ulhbi7s4
Message-ID: <CAM0EoMnhH+7NA6A-mg3rvQJLwN0Wvhd6tYeOYa_YMMdYkMPZHQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net/sched: taprio: fix NULL pointer dereference in
 class dump
To: Weiming Shi <bestswngs@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279087-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.379];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B94984113CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 6:43=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
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

While i would say this looks good to me, I hate to sound like a broken
record but:

Do you have a reproducer?
And it would be nice to get a tdc test from you.

Also, please use assisted-by: or even suggested-by if this patch was
suggested by AI.

cheers,
jamal


>  Oops: general protection fault, probably for non-canonical address 0xdff=
ffc0000000007: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
>  RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
>  Call Trace:
>   <TASK>
>   tc_fill_tclass (net/sched/sch_api.c:1966)
>   qdisc_class_dump (net/sched/sch_api.c:2329)
>   taprio_walk (net/sched/sch_taprio.c:2510)
>   tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
>   tc_dump_tclass_root (net/sched/sch_api.c:2370)
>   tc_dump_tclass (net/sched/sch_api.c:2431)
>   rtnl_dumpit (net/core/rtnetlink.c:6827)
>   netlink_dump (net/netlink/af_netlink.c:2325)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   </TASK>
>
> Fix this by substituting &noop_qdisc when new is NULL in
> taprio_graft(), following the same pattern used by multiq_graft() and
> prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
> control-plane dump paths safe without requiring individual NULL checks.
>
> Since the data-plane paths (taprio_enqueue and taprio_dequeue_from_txq)
> previously had explicit NULL guards that would drop/skip the packet
> cleanly, update those checks to test for &noop_qdisc instead. Without
> this, packets would reach taprio_enqueue_one() which increments the root
> qdisc's qlen and backlog before calling the child's enqueue; noop_qdisc
> drops the packet but those counters are never rolled back, permanently
> inflating the root qdisc's statistics.
>
> Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual =
q->qdiscs[]")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v3: fix broken patch
> v2: Also update NULL guards in taprio_enqueue() and
>     taprio_dequeue_from_txq() to avoid qlen/backlog inflation (Paolo).
> ---
>  net/sched/sch_taprio.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index f721c03514f60..07723b156c5b3 100644
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
>                 dev_deactivate(dev);
>
> @@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsign=
ed long cl,
>         *old =3D q->qdiscs[cl - 1];
>         if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
>                 WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) !=3D *old);
> -               if (new)
> +               if (new !=3D &noop_qdisc)
>                         qdisc_refcount_inc(new);
>                 if (*old)
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

