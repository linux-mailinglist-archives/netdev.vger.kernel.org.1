Return-Path: <netdev+bounces-258264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL+lOptrjGktngAAu9opvQ
	(envelope-from <netdev+bounces-258264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:44:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C5123EFC
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B947301D322
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498434BA21;
	Wed, 11 Feb 2026 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="izANsgZm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1cNDnr7T"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734442F2910;
	Wed, 11 Feb 2026 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810263; cv=none; b=TOJjFE65l3vHfJMIPwYCb8g9Q6kcPirn1u4Mnfm6NbJ02iTFIgc4jEvUc+GyQqXhOY1RzDwaWvruF5l86zUya9GlxSIUv4Bs/a2ZRMuiBeaDfdJgGS55KLRiSGdyEPDAE34M0QVU9ClBQoh7o8IVRdWNzejEVn9oiaNcGVsh1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810263; c=relaxed/simple;
	bh=sI0b1ba2m0bkVc1AtBlmVUWPv66R8ZmLBV3MDW6SRHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXuMLje1QT0Hn5mxuBRZ8hui0lsgviQrNfun+xd4INlExQERm/ZyQcqr7Ry88Zjr3ItEdidGbjmO+NWCBWYc1DCAkmnYO5FlkDpOspf8wpwriodOAPOsx+llkl+q1p8XdiDP/GAw1ngDrN5DL8x8QeAXi4SFYfzRjQVvbJMyukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=izANsgZm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1cNDnr7T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Feb 2026 12:44:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770810260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwcCNO4iuM7dYsnfRuUULJMBsV4MSD/w5EOIcRiS9Hw=;
	b=izANsgZmmYk6yRGCXEehqtKfCp7Hc3L2ggot9l/K8nF9h7H5kK4GupAp8bWkGQxNb8J++4
	2qQgxKKZnXiuL9NihReHFy7g1uL4u31Tj+XVTXUzAq8izkOd8Ousniy6894+qA0/ZH9TGw
	8YrhjuQWoik+sTX/WibudCMoR+JJrOzR6rCaMxdU7CL0YT+3Rm2/VvKQPAUpdcQo6efdIV
	12HRjGcMq8000IGpNlzi4U09NJdYNGhdYCNaMHWt/sRl6i8XlhZVskH31i/zoPn32zOIzp
	hXSQLP2MPl+9wzdc2tg8bLNqqI7FtJqW3c7JHDnfEduj8FPih4S0g5IMhRI9xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770810260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwcCNO4iuM7dYsnfRuUULJMBsV4MSD/w5EOIcRiS9Hw=;
	b=1cNDnr7TpeKAHPcC2odibxF9E841oApY60B68Vzxxg99OuOIluCt9noMJGajETUxi23Zhg
	VJZnBEy5HcJypqDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v1] bpf: cpumap: fix race in bq_flush_to_queue on
 PREEMPT_RT
Message-ID: <20260211114418.xnfx8M-t@linutronix.de>
References: <20260211064417.196401-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260211064417.196401-1-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim,appspotmail.com:email,shopee.com:email]
X-Rspamd-Queue-Id: 229C5123EFC
X-Rspamd-Action: no action

On 2026-02-11 14:44:16 [+0800], Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>=20
> On PREEMPT_RT kernels, the per-CPU xdp_bulk_queue (bq) can be accessed
> concurrently by multiple preemptible tasks on the same CPU.
>=20
> The original code assumes bq_enqueue() and __cpu_map_flush() run
> atomically with respect to each other on the same CPU, relying on
> local_bh_disable() to prevent preemption. However, on PREEMPT_RT,
> local_bh_disable() only calls migrate_disable() and does not disable
> preemption. spin_lock() also becomes a sleeping rt_mutex. Together,
> this allows CFS scheduling to preempt a task during bq_flush_to_queue(),
> enabling another task on the same CPU to enter bq_enqueue() and operate
> on the same per-CPU bq concurrently.
=E2=80=A6
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

Can you reproduce this? It should not trigger with the commit above.
It should trigger starting with
   3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_R=
T")

> Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69369331.a70a0220.38f243.009d.GAE@goo=
gle.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/bpf/cpumap.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 04171fbc39cb..7fda8421ec40 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -714,6 +717,7 @@ const struct bpf_map_ops cpu_map_ops =3D {
>  	.map_redirect		=3D cpu_map_redirect,
>  };
> =20
> +/* Caller must hold bq->bq_lock */

If this information is important please use lockdep_assert_held() in the
function below. This can be used by lockdep and is understood by humans
while the comment is only visible to humans.

>  static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
>  {
>  	struct bpf_cpu_map_entry *rcpu =3D bq->obj;
> @@ -750,10 +754,16 @@ static void bq_flush_to_queue(struct xdp_bulk_queue=
 *bq)
> =20
>  /* Runs under RCU-read-side, plus in softirq under NAPI protection.
>   * Thus, safe percpu variable access.

+ PREEMPT_RT relies on local_lock_nested_bh().

> + *
> + * On PREEMPT_RT, local_bh_disable() does not disable preemption,
> + * so we use local_lock to serialize access to the per-CPU bq.
>   */
>  static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame =
*xdpf)
>  {
> -	struct xdp_bulk_queue *bq =3D this_cpu_ptr(rcpu->bulkq);
> +	struct xdp_bulk_queue *bq;
> +
> +	local_lock(&rcpu->bulkq->bq_lock);

local_lock_nested_bh() & the matching unlock here and in the other
places, please.

Sebastian

