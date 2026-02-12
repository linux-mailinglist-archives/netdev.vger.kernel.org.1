Return-Path: <netdev+bounces-258460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHuNO9XkjWms8QAAu9opvQ
	(envelope-from <netdev+bounces-258460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:33:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580712E442
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 675EB304CCC1
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8C28469E;
	Thu, 12 Feb 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XmAk7+iV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/t8vhQs0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F533B19F;
	Thu, 12 Feb 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906832; cv=none; b=Coxr0xaTU1/+6sqJOeZQ3bfirqMXfc0MV3LMQrtIfrlCWIvtpeIYWHQ5SnoSwSSPZxyTqIZtEkz/zzj8eTzZerx/N/HhrLXl0ov3XSoPT3X6AfSm4EKaWcxsDkLrW0Mt2QBGTdpEpTa+YLrK83ASgQb1xOneKcIL1x+5W+ViNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906832; c=relaxed/simple;
	bh=BOd9tptsSrILqPWba+ZA9LlIF7z1U2Dbv3Pg0BdbkUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsdCut3OVzZJCOxo77Znc+MXYvL5VaOabNwYmailnR3swMW9Lo+CMvmT6K0cBNRYNWOdxq155K41VlmmF32ShjQ4Vo+2w7+Apl/iikesWZOetsfGLegwgjI1YiGhBP7hNPl2vMYxzXL+nuPFUTVfvcAtI4L8/RTj4HxWFNLWFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XmAk7+iV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/t8vhQs0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Feb 2026 15:33:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770906825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VT/QAGKpA0eGfq3n4vYtlNCzR1t+pjOs1HP6qzTDpF8=;
	b=XmAk7+iVVCpV0AAXIB42e3QUvOS8B6oT8yayjODByhCyXUpCydJ5f5tLjC2rcYnurRhGmc
	gYxWChnhNOLKQMGB6Pp48745iyNOt87RAOBPZboD5PTCLXBtAIrIgovj6FxXODgGWrCP77
	7kr8PoDWeWxsFWfZ8Uqlj0HiYOUt5cb8c03cMG4UnDVEs7AmYn4jdSUMcq617YjMcHt0N7
	74tE4qsGg+LkvLaRjIyy5v0aUcyAGPtAIigdUaHvcpkV4gPcenCRKdZFIjFGHyuuZD52c0
	6myCnJ6UAIbKAgcoyD/H0H+w3iZ33YwPFbcuTGeioF1ro37ROgmgjzXZL4MK4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770906825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VT/QAGKpA0eGfq3n4vYtlNCzR1t+pjOs1HP6qzTDpF8=;
	b=/t8vhQs0Y8FSE+hEPcEz24ihUcORz/ocwJ7Pd19fZNCKoSk1opq+nxxdo5NqFYP4cK+2OP
	VieJN509dKCCrvDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: xxx@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
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
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v2] bpf: cpumap: fix race in bq_flush_to_queue on
 PREEMPT_RT
Message-ID: <20260212143344.j3_GaCuV@linutronix.de>
References: <20260212023634.366343-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260212023634.366343-1-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258460-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2580712E442
X-Rspamd-Action: no action

On 2026-02-12 10:36:33 [+0800], Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>=20
=E2=80=A6
> local_bh_disable() only calls migrate_disable() and does not disable
> preemption. spin_lock() also becomes a sleeping rt_mutex. Together,
There is no spin_lock() otherwise there would be no problem.

=E2=80=A6
> Fix this by adding a local_lock_t to xdp_bulk_queue and acquiring it
> in bq_enqueue() and __cpu_map_flush(). On non-RT kernels, local_lock
> maps to preempt_disable/enable with zero additional overhead. On
> PREEMPT_RT, it provides a per-CPU sleeping lock that serializes
> access to the bq. Use local_lock_nested_bh() since these paths already
> run under local_bh_disable().

So you use local_lock_nested_bh() and not local_lock() but you mention
local_lock. The difference is that the former does not add any
preempt_disable() on !RT. At this point I am curious how much of this
was written by you and how much is auto generated.=20

> An alternative approach of snapshotting bq->count and bq->q[] before
> releasing the producer_lock was considered, but it requires copying
> the entire bq->q[] array on every flush, adding unnecessary overhead.

But you still have list_head which is not protected.

> To reproduce, insert an mdelay(100) between spin_unlock() and
> __list_del_clearprev() in bq_flush_to_queue(), then run reproducer
> provided by syzkaller.
>=20
> Panic:
> =3D=3D=3D
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0002 [#1] SMP PTI
>  CPU: 0 UID: 0 PID: 377 Comm: a.out Not tainted 6.19.0+ #21 PREEMPT_RT
>  RIP: 0010:bq_flush_to_queue+0x145/0x200
>  Call Trace:
>   <TASK>
>   __cpu_map_flush+0x2c/0x70
>   xdp_do_flush+0x64/0x1b0
>   xdp_test_run_batch.constprop.0+0x4d4/0x6d0
>   bpf_test_run_xdp_live+0x24b/0x3e0
>   bpf_prog_test_run_xdp+0x4a1/0x6e0
>   __sys_bpf+0x44a/0x2760
>   __x64_sys_bpf+0x1a/0x30
>   x64_sys_call+0x146c/0x26e0
>   do_syscall_64+0xd5/0x5a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>

This could be omitted. It is obvious once you see it. I somehow missed
this alloc_percpu instance while looking for this kind of bugs.
Another one is hiding in devmap.c. Mind to take a look? I think I
skip this entire folder=E2=80=A6

> Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREE=
MPT_RT")
> Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69369331.a70a0220.38f243.009d.GAE@goo=
gle.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v1 -> v2: https://lore.kernel.org/bpf/20260211064417.196401-1-jiayuan.che=
n@linux.dev/
> - Use local_lock_nested_bh()/local_unlock_nested_bh() instead of
>   local_lock()/local_unlock(), since these paths already run under
>   local_bh_disable(). (Sebastian Andrzej Siewior)
> - Replace "Caller must hold bq->bq_lock" comment with
>   lockdep_assert_held() in bq_flush_to_queue(). (Sebastian Andrzej Siewio=
r)
> - Fix Fixes tag to 3253cb49cbad ("softirq: Allow to drop the
>   softirq-BKL lock on PREEMPT_RT") which is the actual commit that
>   makes the race possible. (Sebastian Andrzej Siewior)
> ---
>  kernel/bpf/cpumap.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

The changes below look good.

Sebastian

