Return-Path: <netdev+bounces-254807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BnuDW5je2l2EQIAu9opvQ
	(envelope-from <netdev+bounces-254807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:41:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A853B07B3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70E003009B13
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587B2FE589;
	Thu, 29 Jan 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="e0N9p5G9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD013A1CD
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694059; cv=pass; b=cezl0xJt1LCc841BQMPTASGWJT8IPEp38sm40lT9M9sSj6VXzf6NGrRZ5EWcx7j/sTmt9tWsGSNJvFwzLXL4LjyM5Dr73sf4EQXiZmuI6VnC9SInmnsUZxJLn1RWLAW+r9TBaHHYaLgakqWuBXkdTm2tUOJeR7MhwfLESm+1rwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694059; c=relaxed/simple;
	bh=cxy/C3KRQETOzoquYG310XPbyEWR47iNu0tl2Hu0k9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4Gbz7eJr96WoCz+fNr7KAy513LCH432jDwg4rXLncJhVGBdDrHuv/XPsbtTUpFi9ozOFl+Nh+CWDTUj6fiG73eKDoeaLAxyG+CFSnldEUCZviYZQ4Ne3Ai5bMrb7BudiBUE7cOFOlmmCq0Q7D4ESjt++LJlO9K6W235ST1zmSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=e0N9p5G9; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35305538592so833171a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:40:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769694057; cv=none;
        d=google.com; s=arc-20240605;
        b=OvKIb+ykTNXpAs3MVLhixf7faaNuduoi7LYsGWqTw+acIhK0cxgUF8e8zQda0b5GDO
         3G9qL4h9HQ/hLO6ybom1fvLGDld/DGrI1UHAiHT5JNfQv/WmcBq2SRArZozzmIIYlglt
         WOV8cS2E57NbyE0ZtVl5TAPItavLYJgq7aHZTMgLI9G9tliNxUqvPKgqiRsW1vkZUX0Z
         m+17/ljWt8Ya5VTca1mPFZdOTjZ79j5PiPUSQCcGcoQhskYhAPVsc9kD3eARP2K7dpe0
         5nlSWX+NRUgQ+c27LA8UQSvFNcrYFycfQfr9dUf6VO80CAVmkZPyZPfYew5mQHkvb4Cg
         nAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SwVxhgEfp4NkQ02iRo++oBbmk6HNv1dTCeJJCrn+Zzc=;
        fh=zV6TDz8GdU/xZk7FJHWpBfySI6PFFo9KgRm9401XWqs=;
        b=XVk5wfRPjc1C7VoV8vtOE14Iaf6bHYRHWs9xb71dAWNUDTByC3+jCNHbpGUhB5sH2N
         LAVRwvFej2iho/da5M4Xv/yseWp+WZPFq+MrX88R6TVDy3MfdftuvKrbQGCPWcrWeYvt
         gJxTbibxxg230XyxSJa3ToGI95vRttA3kH41m8UhZziFZFQTCejlED3Pl4FBDecgn9+M
         wxploMewYDY9n0rfVu98vdTADG3Ky9c6ToxqwJDFvblKf4ZMRHmLnJXb/Vlh6W6pGv04
         tl7Yj0wAZWH7LCDBz2NynFlVDg220fgS4LzY7p0j3OKu3yoF4B+NK1F1ELhoeEmSyuqL
         PuLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769694057; x=1770298857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwVxhgEfp4NkQ02iRo++oBbmk6HNv1dTCeJJCrn+Zzc=;
        b=e0N9p5G96FRcDxOnsuoHcqGM2lPcxjL3S57DDXLYbq7smj/D3fHa1IAx5Fxwa2urnO
         oIdUqqgJpRseSZ5K2eP0gLO26dyFwMLjQJ0d6zNSJbY2O1c4gWlPQQwGyUgulDy3b9Wn
         bZsU/7wTOi76Y3BZ/2TxBZ7AspeiA7c2vFVtpE32Df9rGR6LL1X3xS+fRkp60ENa7lVY
         yB0IJBlVKfBPiXiw5HLbPwsjVBCmjlZMbweyBK7zK0GSHq1k7/X+/9ZRi1Hu9+0R7SQ0
         8UoenMN/nRC28YpApxdzCqNC7Uu5VkNs1G1b33bjtKJbR6j/sCkLQB292HlZ9VM/MQq7
         65mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769694057; x=1770298857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SwVxhgEfp4NkQ02iRo++oBbmk6HNv1dTCeJJCrn+Zzc=;
        b=siboLQAN3KaGTOUIRz7Yis0fql25KKoiEqMxAMRdc3XxtKsq+V9Xq1HWaN4HHP3xF7
         zdjxheCR2jal+DYdiW9iDgVcTnbIBCjn7NYzJStaTPz/iEAhXxPcsWrIsnue77gxfA8r
         c+74j6kzhTlR75nS/uyjSqLb0WByBFPhbIWKk91oO8DyoxzEraU1m4Ct4h8Qn9XzX87u
         Efty+EbC7KUuMeAqyph6W7M46u0bQstAne3QA8R5Fy3LJqARdvFl5QhPdA5+3ope1Qqd
         nnEXfbchCbHY/j2pBC6xAXDC5Th1mfIByH3Saa8dVHPzt62l6eXQKLNO5OwC81n1ya+Z
         2Qnw==
X-Forwarded-Encrypted: i=1; AJvYcCVZc+G7j29CUKA2z5iSOcOVx+GYclLQXjlhVS2C206En9J4vtVLurYiCmw8GGSrk2N72DHBgi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNu0ouu9sxcOyWUs4tyv3Pi9fcy0syCzAQVisu/l09MlwuXO7
	jWBG4bp7X7MrRXe/bttoMN7I3Bti3o1fCzJueVYa/eJ0BRe8I8/UpiOJ1ItfVbfpYz6vBKgKQin
	/Lu5zo+JsZWTtMouawshUgQlus/bwdEM6mAnddiM+
X-Gm-Gg: AZuq6aLbYpQgajzW8A9Ci2xKcEtdAZ4YsRet7jp0D9jXXm787TiaVMVoPy5q8S62s6k
	SdE6NRgU3Y6ItX4JJDBWkcTHFdU8T4qgFZCrQPZqR/lPqZLiMcKPTRFBAzSTVKqGInM6nJ1/rpe
	TZ3DPraVLnGDMkpPqZUPzFoZ/9r66CPJ8s6gwcFZgLG7ss0U07IC+XUHDzDiebEeA47wYQREbub
	TAjtVK738SWvJI6seMH6Rh9HPywNx1UVdp1t9HpeqGJgHUv2tfoNdCamKw4Bak8H/evakSJvxWQ
	y28=
X-Received: by 2002:a17:90a:ec87:b0:34c:2db6:578f with SMTP id
 98e67ed59e1d1-353fed5cc44mr8225981a91.19.1769694056937; Thu, 29 Jan 2026
 05:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirffTyUrB=MkXjw8N-gEA0Qvr42mbUndybG0+6wyFdGiajw@mail.gmail.com>
In-Reply-To: <CAGfirffTyUrB=MkXjw8N-gEA0Qvr42mbUndybG0+6wyFdGiajw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Jan 2026 08:40:45 -0500
X-Gm-Features: AZwV_QiE7dhJrJcOJU1nzth9ShTgmiPYxyvTyCkJ8bS9iI-Dau3x729OkwrLvoE
Message-ID: <CAM0EoMmVchdXPrmnFObON4kf3FOz2SbjFptRmqTev3GtkxWGvQ@mail.gmail.com>
Subject: Re: [BUG] divide error in tabledist
To: GangMin Kim <km.kim1503@gmail.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, jiri@resnulli.us, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254807-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,networkplumber.org,gmail.com,googlegroups.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7A853B07B3
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:20=E2=80=AFPM GangMin Kim <km.kim1503@gmail.com>=
 wrote:
>
> Dear Linux kernel developers and maintainers,
> Using a modified version of syzkaller, I identified a new bug and
> refined the PoC, and the bug-related information is attached
> below.Please let me know if you need any further information.
>

Thanks for the report. I will take a closer look later today.

cheers,
jamal

> Summary
> In netem, when jitter is set to 0x80000000, a divide error occurs when
> tabledist is processed during the subsequent netem_enqueue operation.
>
> Keywords
> - net/sched
>
> Kernel Info
> Version: (Output of /proc/version)
> - Linux version 6.19.0-rc7
> Commit: (Git hash if applicable)
> - 63804fed149a6750ffd28610c5c1c98cce6bd377
>
> Description(Root Cause)
> ```
> static int netem_change(struct Qdisc *sch, struct nlattr *opt,
> struct netlink_ext_ack *extack)
> {
> struct netem_sched_data *q =3D qdisc_priv(sch);
> struct nlattr *tb[TCA_NETEM_MAX + 1];
> struct disttable *delay_dist =3D NULL;
> struct disttable *slot_dist =3D NULL;
> struct tc_netem_qopt *qopt;
> struct clgstate old_clg;
> int old_loss_model =3D CLG_RANDOM;
> int ret;
>
> qopt =3D nla_data(opt);
> ...
> sch->limit =3D qopt->limit;
>
> q->latency =3D PSCHED_TICKS2NS(qopt->latency);
> q->jitter =3D PSCHED_TICKS2NS(qopt->jitter); // [1]
> q->limit =3D qopt->limit;
> q->gap =3D qopt->gap;
> q->counter =3D 0;
> q->loss =3D qopt->loss;
>
> ret =3D check_netem_in_tree(sch, qopt->duplicate, extack); // [2]
> if (ret)
> goto unlock;
> ...
> /* capping jitter to the range acceptable by tabledist() */
> q->jitter =3D min_t(s64, abs(q->jitter), INT_MAX); // [3]
> ...
> unlock:
> sch_tree_unlock(sch);
>
> table_free:
> dist_free(delay_dist);
> dist_free(slot_dist);
> return ret;
> }
> ```
> When qopt->jitter is 0x6e000000, at [1] q->jitter is set to
> 0x1b80000000. If netem is already configured and a change operation is
> attempted but fails at [2], the q values are modified but the process
> at [3] is not executed. Therefore, q->jitter can be set to a value
> exceeding INT_MAX.
>
> ```
> static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> struct sk_buff **to_free)
> {
> struct netem_sched_data *q =3D qdisc_priv(sch);
> /* We don't fill cb now as skb_unshare() may invalidate it */
> struct netem_skb_cb *cb;
> struct sk_buff *skb2 =3D NULL;
> struct sk_buff *segs =3D NULL;
> unsigned int prev_len =3D qdisc_pkt_len(skb);
> int count =3D 1;
> ...
> if (q->gap =3D=3D 0 || /* not doing reordering */
>     q->counter < q->gap - 1 || /* inside last reordering gap */
>     q->reorder < get_crandom(&q->reorder_cor, &q->prng)) {
> u64 now;
> s64 delay;
>
> delay =3D tabledist(q->latency, q->jitter, // [4]
>   &q->delay_cor, &q->prng, q->delay_dist);
>
> ...
> }
> ...
> return NET_XMIT_SUCCESS;
> }
>
> static s64 tabledist(s64 mu, s32 sigma,
>      struct crndstate *state,
>      struct prng *prng,
>      const struct disttable *dist)
> {
> s64 x;
> long t;
> u32 rnd;
>
> if (sigma =3D=3D 0)
> return mu;
>
> rnd =3D get_crandom(state, prng);
>
> /* default uniform distribution */
> if (dist =3D=3D NULL)
> return ((rnd % (2 * (u32)sigma)) + mu) - sigma; // [5]
> ...
> return  x / NETEM_DIST_SCALE + (sigma / NETEM_DIST_SCALE) * t + mu;
> }
> ```
> Subsequently, in netem_enqueue(), the previously set value is passed
> at [4], and in tabledist(), sigma is set to 0x80000000. This causes
> the calculation at [5] to become 2 * 0x80000000, which overflows to 0,
> resulting in a divide-by-zero error.
>
> Kasan Report
> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 332 Comm: test Not tainted 6.19.0-rc7 #8 PREEMPT(full)
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:tabledist.part.0+0x21e/0x290 net/sched/sch_netem.c:345
> Code: 4c 01 f0 48 c1 e8 20 41 89 45 00 41 89 c6 e8 49 d1 9a fd 48 85
> db 0f 85 78 fe ff ff e8 3b d1 9a fd 8d 4c 2d 00 44 89 f0 31 d2 <f7> f1
> 49 29 ec 49 01 d4 e9 2a ff ff ff e8 20 d1 9a fd 48 81 eb 00
> RSP: 0018:ffff88810f61f1f8 EFLAGS: 00010246
> RAX: 00000000aecf3ad7 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: ffff88810900da7c
> RBP: ffffffff80000000 R08: 0000000000000000 R09: ffffed10233895cc
> R10: ffff888119c4ae67 R11: 0000000000000000 R12: 0000000001000300
> R13: ffff88810900da3c R14: 00000000aecf3ad7 R15: ffff88810900da40
> FS:  00007f2531e11540(0000) GS:ffff88834ad89000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2531cfe1c0 CR3: 00000001215fe000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  tabledist net/sched/sch_netem.c:559 [inline]
>  netem_enqueue+0x4f4/0x3180 net/sched/sch_netem.c:559
>  qdisc_enqueue include/net/sch_generic.h:887 [inline]
>  qfq_enqueue+0x46f/0x13c0 net/sched/sch_qfq.c:1256
>  dev_qdisc_enqueue+0x45/0x160 net/core/dev.c:4147
>  __dev_xmit_skb net/core/dev.c:4262 [inline]
>  __dev_queue_xmit+0x1eea/0x3060 net/core/dev.c:4798
>  dev_queue_xmit include/linux/netdevice.h:3381 [inline]
>  neigh_hh_output include/net/neighbour.h:540 [inline]
>  neigh_output include/net/neighbour.h:554 [inline]
>  ip_finish_output2+0xdd2/0x1710 net/ipv4/ip_output.c:237
>  __ip_finish_output.part.0+0x182/0x2f0 net/ipv4/ip_output.c:315
>  __ip_finish_output net/ipv4/ip_output.c:444 [inline]
>  ip_finish_output net/ipv4/ip_output.c:325 [inline]
>  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
>  ip_output+0x288/0x510 net/ipv4/ip_output.c:438
>  dst_output include/net/dst.h:464 [inline]
>  ip_local_out net/ipv4/ip_output.c:131 [inline]
>  ip_send_skb+0x160/0x1b0 net/ipv4/ip_output.c:1508
>  udp_send_skb+0x6d6/0x1000 net/ipv4/udp.c:1195
>  udp_sendmsg+0x1463/0x1eb0 net/ipv4/udp.c:1484
>  inet_sendmsg+0xfa/0x140 net/ipv4/af_inet.c:859
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  sock_write_iter+0x493/0x5b0 net/socket.c:1195
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x657/0xd30 fs/read_write.c:686
>  ksys_write+0x1b2/0x200 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xa4/0x320 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2531d27513
> Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
> 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> RSP: 002b:00007ffe09e5d858 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2531d27513
> RDX: 0000000000000040 RSI: 00007ffe09e5d890 RDI: 0000000000000004
> RBP: 00007ffe09e5d8f0 R08: 0000000000000004 R09: 0000000000020000
> R10: 00007ffe09e5d87c R11: 0000000000000246 R12: 000055c28686a100
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:tabledist.part.0+0x21e/0x290 net/sched/sch_netem.c:345
> Code: 4c 01 f0 48 c1 e8 20 41 89 45 00 41 89 c6 e8 49 d1 9a fd 48 85
> db 0f 85 78 fe ff ff e8 3b d1 9a fd 8d 4c 2d 00 44 89 f0 31 d2 <f7> f1
> 49 29 ec 49 01 d4 e9 2a ff ff ff e8 20 d1 9a fd 48 81 eb 00
> RSP: 0018:ffff88810f61f1f8 EFLAGS: 00010246
> RAX: 00000000aecf3ad7 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: ffff88810900da7c
> RBP: ffffffff80000000 R08: 0000000000000000 R09: ffffed10233895cc
> R10: ffff888119c4ae67 R11: 0000000000000000 R12: 0000000001000300
> R13: ffff88810900da3c R14: 00000000aecf3ad7 R15: ffff88810900da40
> FS:  00007f2531e11540(0000) GS:ffff88834ad89000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2531cfe1c0 CR3: 00000001215fe000 CR4: 0000000000750ef0
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0: 4c 01 f0              add    %r14,%rax
>    3: 48 c1 e8 20          shr    $0x20,%rax
>    7: 41 89 45 00          mov    %eax,0x0(%r13)
>    b: 41 89 c6              mov    %eax,%r14d
>    e: e8 49 d1 9a fd        call   0xfd9ad15c
>   13: 48 85 db              test   %rbx,%rbx
>   16: 0f 85 78 fe ff ff    jne    0xfffffe94
>   1c: e8 3b d1 9a fd        call   0xfd9ad15c
>   21: 8d 4c 2d 00          lea    0x0(%rbp,%rbp,1),%ecx
>   25: 44 89 f0              mov    %r14d,%eax
>   28: 31 d2                xor    %edx,%edx
> * 2a: f7 f1                div    %ecx <-- trapping instruction
>   2c: 49 29 ec              sub    %rbp,%r12
>   2f: 49 01 d4              add    %rdx,%r12
>   32: e9 2a ff ff ff        jmp    0xffffff61
>   37: e8 20 d1 9a fd        call   0xfd9ad15c
>   3c: 48                    rex.W
>   3d: 81                    .byte 0x81
>   3e: eb 00                jmp    0x40

