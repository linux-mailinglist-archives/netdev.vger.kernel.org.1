Return-Path: <netdev+bounces-93212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B38BA9BA
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 11:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D63B22526
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144AA152DFB;
	Fri,  3 May 2024 09:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB6152175
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727937; cv=none; b=Z7WkX0BFC6UGYGKXctWWW8Im5UTOzVHmgVDBMLQbTq5PUwX38kqsGlyVanuAXlqjuI8kYCDRJ8y/fbQQ6WMay4VgTeTKZgYGAbjl5flgq69GXBU8YNe1qEtl3c4PV4VCdecjitH1ZJK1eyViJI1qOS/n+HuXh3rNs9EILgQnzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727937; c=relaxed/simple;
	bh=NUQCTK+AxitbuKh2s7vUHAmLQzAy4UrLIfMKnkDcABE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtzA4lAMp/9fzOyq7woFxb4rI3J6M6+DKZ2XFc7lFTl8n/p9wEz0VfLUjHEDj1VgoOBBI0LumrMsv6i8mYMhg68G0LnneJeZ4sbgJa/yZlaGm+MLiHig9RqnmDzv87llNHMdx8XB11+GtSxipnKhkpgHt/sgi8F3pFUM2T+ztyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 252ae570092e11ef9305a59a3cc225df-20240503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6003c919-79eb-4dee-a35e-5df9c675fbcf,IP:20,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-20
X-CID-INFO: VERSION:1.1.37,REQID:6003c919-79eb-4dee-a35e-5df9c675fbcf,IP:20,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-20
X-CID-META: VersionHash:6f543d0,CLOUDID:e7fb3c7dd4f2472030e31159135a0219,BulkI
	D:240503162725OC46H9BR,BulkQuantity:4,Recheck:0,SF:66|24|17|19|44|102,TC:n
	il,Content:0,EDM:1,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,
	TF_CID_SPAM_SNR
X-UUID: 252ae570092e11ef9305a59a3cc225df-20240503
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1712965895; Fri, 03 May 2024 17:18:46 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id A039CB80758A;
	Fri,  3 May 2024 17:18:45 +0800 (CST)
X-ns-mid: postfix-6634ABF5-4728235
Received: from localhost.localdomain (unknown [10.42.176.164])
	by node2.com.cn (NSMail) with ESMTPA id 4EDCCB80758A;
	Fri,  3 May 2024 09:18:45 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	netdev@vger.kernel.org
Subject: [PATCH] net/sched: taprio: fix CPU stuck due to the taprio hrtimer
Date: Fri,  3 May 2024 17:18:44 +0800
Message-Id: <20240503091844.1161175-1-luyun@kylinos.cn>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git  master

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


