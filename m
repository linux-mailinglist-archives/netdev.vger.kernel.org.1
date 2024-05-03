Return-Path: <netdev+bounces-93208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050618BA944
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01CB281D30
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D703514A0B6;
	Fri,  3 May 2024 08:53:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F43542078
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726432; cv=none; b=Imob0EHVxM+AuOXzzgKcwYrk+OfJWzsj/gH2Kx11oSOAyfIYcDvmne9/O/h665tBZL4oTOVLqczIcWWD/n66iileKAKYzboK/VHFu1Ewe8JDBE2RXUe9VIkpc1LWfm676dREXeceKdlH6lM3lQDdcqGStWmFo15VLEyB6Acusho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726432; c=relaxed/simple;
	bh=aWcTH8w7Ua/ruvKaPbFeXrhXrFK3SkXeSBI8mH2aaCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EEsf3REIzy/B2i0P4Ahe0Aj4PzxwcoH7ItHDx8cOUdvd+s5fTiwLTGY+4sklYfDakZsubN8EHGC0+WpJtI9P1UhdgmR92mzzxK8PxyrxRSX8W5vola6VfHeJupkUKyWj071Frwe4192lbdderGg5SvwZaGGojs6FsmNqrtmmDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a14075fc092a11ef9305a59a3cc225df-20240503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:79fd8960-f8b2-495e-a136-6beb83aa3464,IP:10,
	URL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-25
X-CID-INFO: VERSION:1.1.37,REQID:79fd8960-f8b2-495e-a136-6beb83aa3464,IP:10,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:d897c53c4a1cd7e3864497c0ac5ae354,BulkI
	D:240503162725OC46H9BR,BulkQuantity:2,Recheck:0,SF:72|19|44|66|24|102,TC:n
	il,Content:0,EDM:1,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS
X-UUID: a14075fc092a11ef9305a59a3cc225df-20240503
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 524097701; Fri, 03 May 2024 16:53:37 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id CFA71B80758A;
	Fri,  3 May 2024 16:53:36 +0800 (CST)
X-ns-mid: postfix-6634A610-6559921
Received: from localhost.localdomain (unknown [10.42.176.164])
	by node2.com.cn (NSMail) with ESMTPA id 46F9DB80758A;
	Fri,  3 May 2024 08:53:36 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	netdev@vger.kernel.org
Subject: [PATCH] net/sched: taprio: fix CPU stuck due to the taprio hrtimer
Date: Fri,  3 May 2024 16:53:35 +0800
Message-Id: <20240503085335.1160006-1-luyun@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000022a23c061604edb3@google.com>
References: <00000000000022a23c061604edb3@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Syzbot reported the issues which rcu_preempt detected stalls on CPUs, and
the Call Trace shows that CPU is stuck on taprio hrtimer [1] [2].

 rcu_lock_release include/linux/rcupdate.h:308 [inline]
 rcu_read_unlock include/linux/rcupdate.h:783 [inline]
 advance_sched+0xb37/0xca0 net/sched/sch_taprio.c:987
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x597/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x109/0x3a0 arch/x86/kernel/apic/apic.c:10=
49
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inli=
ne]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:702
 ......

Assuming the clockid of hrtimer is set to REALTIME and hrtimer is started=
,
the system time is then adjusted by a significant value backwards, and th=
is
adjustment is not taken into account in the advance_sched function, which
still calculating the hrtimer expires based on the previous end_time.

This will result in the hrtimer expires being much smaller than the curre=
nt
system time. Consequently, this hrtimer keeps getting inserted as the fir=
st
node in the timerqueue, causing the CPU to enter an infinite loop in the
__hrtimer_run_queues function, getting stuck and unable to exit or respon=
d
to any interrupts.

To address this, when calculating the start time of the hrtimer, retain a
record of the offset between the current time corresponding to clockid an=
d
the monotonic time. Subsequently, when setting the hrtimer expires, check
if this offset has changed. If it has, the hrtimer expires should be
adjusted accordingly by adding this difference offset value.

[1] https://lore.kernel.org/all/00000000000022a23c061604edb3@google.com/
[2] https://lore.kernel.org/all/000000000000d929dd0614a8ba8c@google.com/

Signed-off-by: Yun Lu <luyun@kylinos.cn>
Reported-by: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com
---
 net/sched/sch_taprio.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a0d54b422186..360778f65d9e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -104,6 +104,7 @@ struct taprio_sched {
 	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
 	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
 	u32 txtime_delay;
+	ktime_t offset;
 };
=20
 struct __tc_taprio_qopt_offload {
@@ -170,6 +171,13 @@ static ktime_t sched_base_time(const struct sched_ga=
te_list *sched)
 	return ns_to_ktime(sched->base_time);
 }
=20
+static ktime_t taprio_get_offset(enum tk_offsets tk_offset)
+{
+	ktime_t time =3D ktime_get();
+
+	return ktime_sub_ns(ktime_mono_to_any(time, tk_offset), time);
+}
+
 static ktime_t taprio_mono_to_any(const struct taprio_sched *q, ktime_t =
mono)
 {
 	/* This pairs with WRITE_ONCE() in taprio_parse_clockid() */
@@ -918,6 +926,8 @@ static enum hrtimer_restart advance_sched(struct hrti=
mer *timer)
 	int num_tc =3D netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch =3D q->root;
+	enum tk_offsets tk_offset =3D READ_ONCE(q->tk_offset);
+	ktime_t now_offset =3D taprio_get_offset(tk_offset);
 	ktime_t end_time;
 	int tc;
=20
@@ -957,6 +967,14 @@ static enum hrtimer_restart advance_sched(struct hrt=
imer *timer)
 	end_time =3D ktime_add_ns(entry->end_time, next->interval);
 	end_time =3D min_t(ktime_t, end_time, oper->cycle_end_time);
=20
+	if (q->offset !=3D now_offset) {
+		ktime_t diff =3D ktime_sub_ns(now_offset, q->offset);
+
+		end_time =3D ktime_add_ns(end_time, diff);
+		oper->cycle_end_time =3D ktime_add_ns(oper->cycle_end_time, diff);
+		q->offset =3D now_offset;
+	}
+
 	for (tc =3D 0; tc < num_tc; tc++) {
 		if (next->gate_duration[tc] =3D=3D oper->cycle_time)
 			next->gate_close_time[tc] =3D KTIME_MAX;
@@ -1205,11 +1223,13 @@ static int taprio_get_start_time(struct Qdisc *sc=
h,
 				 ktime_t *start)
 {
 	struct taprio_sched *q =3D qdisc_priv(sch);
+	enum tk_offsets tk_offset =3D READ_ONCE(q->tk_offset);
 	ktime_t now, base, cycle;
 	s64 n;
=20
 	base =3D sched_base_time(sched);
 	now =3D taprio_get_time(q);
+	q->offset =3D taprio_get_offset(tk_offset);
=20
 	if (ktime_after(base, now)) {
 		*start =3D base;
--=20
2.34.1


