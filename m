Return-Path: <netdev+bounces-107123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C1B919EEC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 07:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F87288944
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 05:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948DE1CA80;
	Thu, 27 Jun 2024 05:53:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509A0DF6C;
	Thu, 27 Jun 2024 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467636; cv=none; b=km/qTYlVbWfYnS78sHFDnP1DJJFdy9xpxd96zrR4LBxJgLBdlYq9minXiAuvDD2Ho9wVDrEFj5HQF+k3Kg3FIPQX3dGYsgYGCwu2+V5Mj/iHA+bfY6UnHQi78hzX/k6icS3TozNLgFtrRJfl6V6K8RvmGkQnpGyTtATJQmxU/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467636; c=relaxed/simple;
	bh=v/WfqwOYyq2ipsdhWA9LpnHqb7Jhjs1jMx/6Uf2sDMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WDL49AIyzDwxG3X0vG9sa8g6miJ1JXjjojQPZZRXjlzvSpze3vkMaOd+lu83/1LgC8Sv6NtTXrJYlvhmAinZSnhffFJLF8Wi7i0xnyf92lz9A3fSce/QztmARANNqp65+LZhRhwSyzlz1NHb6xZaE5EcHOV43hKXrqCnqMYRjuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b58f78c344911ef9305a59a3cc225df-20240627
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b6f8752e-fd46-4ff3-a961-6c2809699350,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:b6f8752e-fd46-4ff3-a961-6c2809699350,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:e92dccc28fea7de07e513df65bb1b16e,BulkI
	D:240627135344JB52DMCQ,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,UOG
X-CID-BAS: 1,UOG,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 9b58f78c344911ef9305a59a3cc225df-20240627
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 966187219; Thu, 27 Jun 2024 13:53:41 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 4B45CB803C9B;
	Thu, 27 Jun 2024 13:53:41 +0800 (CST)
X-ns-mid: postfix-667CFE65-9822431
Received: from localhost.localdomain (unknown [10.42.176.164])
	by node2.com.cn (NSMail) with ESMTPA id 0203EB803C9B;
	Thu, 27 Jun 2024 05:53:39 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: CPU stuck due to the taprio hrtimer
Date: Thu, 27 Jun 2024 13:53:38 +0800
Message-Id: <20240627055338.2186255-1-luyun@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

When I run a taprio test program on the latest kernel(v6.10-rc4), CPU stu=
ck
is detected immediately, and the stack shows that CPU is stuck on taprio
hrtimer.

The reproducer program link:
https://github.com/xyyluyun/taprio_test/blob/main/taprio_test.c
gcc taprio_test.c -static -o taprio_test

In this program, start the taprio hrtimer which clockid is set to REALTIM=
E, and
then adjust the system time by a significant value backwards. Thus, CPU w=
ill enter
an infinite loop in the__hrtimer_run_queues function, getting stuck and u=
nable to
exit or respond to any interrupts.

I have tried to avoid this problem by apllying the following patch, and i=
t does work.
But I am not sure if this can be the final solution?

Thanks.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 net/sched/sch_taprio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a0d54b422186..2ff8d34bdbac 100644
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
@@ -170,6 +171,19 @@ static ktime_t sched_base_time(const struct sched_ga=
te_list *sched)
 	return ns_to_ktime(sched->base_time);
 }
=20
+static ktime_t taprio_get_offset(const struct taprio_sched *q)
+{
+	enum tk_offsets tk_offset =3D READ_ONCE(q->tk_offset);
+	ktime_t time =3D ktime_get();
+
+	switch (tk_offset) {
+	case TK_OFFS_MAX:
+		return 0;
+	default:
+		return ktime_sub_ns(ktime_mono_to_any(time, tk_offset), time);
+	}
+}
+
 static ktime_t taprio_mono_to_any(const struct taprio_sched *q, ktime_t =
mono)
 {
 	/* This pairs with WRITE_ONCE() in taprio_parse_clockid() */
@@ -918,6 +932,7 @@ static enum hrtimer_restart advance_sched(struct hrti=
mer *timer)
 	int num_tc =3D netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch =3D q->root;
+	ktime_t now_offset =3D taprio_get_offset(q);
 	ktime_t end_time;
 	int tc;
=20
@@ -957,6 +972,14 @@ static enum hrtimer_restart advance_sched(struct hrt=
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
@@ -1210,6 +1233,7 @@ static int taprio_get_start_time(struct Qdisc *sch,
=20
 	base =3D sched_base_time(sched);
 	now =3D taprio_get_time(q);
+	q->offset =3D taprio_get_offset(q);
=20
 	if (ktime_after(base, now)) {
 		*start =3D base;
--=20
2.34.1


