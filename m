Return-Path: <netdev+bounces-265184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIJNFNSWrGnsqwEAu9opvQ
	(envelope-from <netdev+bounces-265184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:21:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DF622DAD0
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B173301F1BE
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E64345CAB;
	Sat,  7 Mar 2026 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QthoMLcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADA2F0C62
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918478; cv=none; b=Yzm8R/HoiUzShKP6IlIUmiS/+AFlsEbt4NV5Tp1XBblBVDll1fwodXu+csbiqfh34hkvBlnM2G+0Juf25I0Gz8dsHJQIqvwwXlpiDyYaxrDrXkXMGfg6G6ddqiwBqcB4RkGZKmr7SY5XJrX1vkCBMAPz7/V8GtTc1Mva5RoyJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918478; c=relaxed/simple;
	bh=GcPtsHdivMxjb0zIr1pknXC3G3P/Thz+GN4x9xvstZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uItcDvITWZsd4SCRLWxbiyHyyooesLyUWtizEaSgUq+GpU+fHHC2miEEZ8wJC6aSDAPXSA1j2zA26IhuxLii86Ss5i4WhQIfgWVxeChGB0s3HhGjpLRiMiSTYlbp52WX12ANAqnZ1BcMBQ2PirEGnn4oOBH8oPHugaNt3Jqv11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QthoMLcV; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb38e6d164so1353992885a.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772918475; x=1773523275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyB+pkSm8sExMr4KliyVJaS5lBIwdySIBs7wmJw7xbI=;
        b=QthoMLcVJuJvV6/YqM/b0h2r+Nxj/Ql2mZmjQQkRwsiSjcXu/eZ2c8LhZK8VgIze3V
         Xq1cddrnuqeKfZjTo1UHq4wBXdP0D5BYIbK3gMqHnRa7CEw1O+xtiV5KxrPTZWErqs9n
         k+gJpLcSpn4ymHVcJRPNAFWgN54doQsqTMYWysAFwIjh77YzMsLzhGPhB8IvzdtkmbfG
         WdY6MKboZFHhLVG5d6SHpUt7DC8KX6xaR3INe6utdCtKfGpPVznH6cLOPX+KOLaecy4F
         qyGNnIHLrOesqgdjUMW6XXXZ/sn1iVZzbOp1DMpqsuNKGvLx7rkpzIkhofw7WZxa/5d9
         DZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772918475; x=1773523275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyB+pkSm8sExMr4KliyVJaS5lBIwdySIBs7wmJw7xbI=;
        b=KXqwIOMdH0rRAIQkfeC1LQFJhhBBeGpGpvsJ8qULcDH2ROSI/+cV5NMt+mWl45PRln
         FkKWFGBmHJPIejyF5ZB/cc1WdtEzCkT2R++WP0bkEcM6u1SJzidbZgGOik7Xe78V38Rj
         i3B90MhG6+CJzcixvYKACo9+w1g3S/zPMumm9HzGe+EqzC8AdNVElQcZ8DBIOczmSZu3
         uXBFMPGBItVjNFXbhYPKxozKYMsSAtRW1lEis+XGgH/9Cm4JkyXezLYRrHsf3aLJ6B0L
         HzwOilZ/NYGqSDQulR//ePZv401taAI1/BOErC8eI89+YsQM9qOappJ6lS81fUiKu+zK
         WTrA==
X-Gm-Message-State: AOJu0Yy+aprmr+Lu84JnIkauya7VKWtH+gLsr3fag2KLPK2LJvDOSMbz
	pgahlsynuFlBBt1PoigJo2ge9JbbbgNMhww4mCv45rUr9nctoDWwAT0TMFp/qdfUmaRjfUUbX98
	RP6s=
X-Gm-Gg: ATEYQzzmOS+JIVeKjMphBrrCewWVtNTuYqsRBLJXBlL0rg1maJzlEkQyu6QAdFOFq8W
	XeurP7izX85CUNbl3cKveK2URRMyxr5o95bM3ecLfrBBcN4D0x01yvqQGQWNgNZiADPjr0wgcUv
	hoT6FrvGsIQwO3BTZ84xd8ESIIzRTPcgM8alJDtLREbWE95DEdsUIFBv0sg2tjQvFL/bZFy9q+s
	DKmd+Z6+yEjsV+C0FvS396l1VghaoahkwjxB5J6RxwWhaoJg05Ln+EHmLy84K5pNcFQMRrHGEKK
	DoHjnBbXwT/4vVaVMeDwEqut0zihBXZxbyjvmcW0YYwhFFlt2Ig7tW0Viv1Dl9fmAUaNbDTevkx
	OKezGs7naNJMvQHiDpEI1hJ3eNYaVcWN3I5afB3DRd2UXxtkHk5rKIPwBQwzQFRvTOHZyg0ZGYx
	E1PmiNa2AmnrKRfwMGaZHUl8caRiWRxjTmDQ==
X-Received: by 2002:a05:620a:4095:b0:8cd:825c:c940 with SMTP id af79cd13be357-8cd825cd08cmr20523585a.71.1772918474411;
        Sat, 07 Mar 2026 13:21:14 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd772f9f9bsm209568585a.24.2026.03.07.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 13:21:13 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	toke@toke.dk,
	vinicius.gomes@intel.com,
	stephen@networkplumber.org,
	vladbu@nvidia.com,
	cake@lists.bufferbloat.net,
	bpf@vger.kernel.org,
	ghandatmanas@gmail.com,
	km.kim1503@gmail.com,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
Date: Sat,  7 Mar 2026 16:20:58 -0500
Message-Id: <20260307212058.169511-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9DF622DAD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-265184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,vger.kernel.org,gmail.com,mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

In tc_new_tfilter, __tcf_qdisc_find is always called without the
rtnl_lock. This causes a bug in the following scenario.

- The user attaches a multiqueue qdisc to root with handle ffff0000
- The user attaches a child multiqueue qdisc to ffff0002 with handle
  0x10000

After that parallel threads execute the following:

time x: On cpux: "qdisc del" enters for root qdisc, holding rtnl
(example refcnt = 1), see tc_get_qdisc()
time x+1: On cpuy: "filter add" enters increments refcnt to 2 after
finding the root qdisc (see __tcf_qdisc_find)
time x+2: On cpux: "qdisc del" calls qdisc_put, decrements refcnt to 1
and doesnt delete qdisc because refcnt is not 0;  "qdisc del" exits
time x+3: On cpuz: "qdisc add" enters for htb, using handle ffff0000 (the
deleted root qdisc's handle), and adds as parent 0x10001 (which is the
major of the delete root qdiscs's child) whilst "filter add" is still
executing.
time x+4: On cpuz: "qdisc_add" calls qdisc_tree_reduce_backlog.
Before calling  qdisc_tree_reduce_backlog, the newly created qdisc is added
to the qdisc hashtable. Since its parent is 0x10001,
qdisc_tree_reduce_backlog will find the previous child qdisc (which had as
parent 0xffff0002). So when qdisc_tree_reduce_backlog looks up 0x10000's
parent, it will find the newly created qdisc (from step x + 3). This will
result in calling the notify callback for the newly created qdisc.
Since the class it passes as a parameter (0xffff0002) to the notify
callback isn't a child of the newly created qdisc, this will cause a
segfault (in time x+4):

[   89.555574][  T337] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000035: 0000 [#1] SMP KASAN NOPTI
[   89.556410][  T337] KASAN: null-ptr-deref in range [0x00000000000001a8-0x00000000000001af]
[   89.556737][  T337] CPU: 5 UID: 0 PID: 337 Comm: poc_manas_null_ Not tainted 7.0.0-rc1-00147-g9439a661c2e8 #604 PREEMPT(full)
...
[   89.557404][  T337] RIP: 0010:htb_qlen_notify (net/sched/sch_htb.c:613 net/sched/sch_htb.c:1490)
[   89.557614][  T337] Code: 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8d 96 a8 01 00 00 48 89 f9 48 83 ec 18 48 b8 00 00 00 00 00 fc ff df 48 89 d7 48 c1 ef 03 <0f> b6 04 07 84 c0 74 04 3c 03 7e 61 8b 86 a8 01 00 00 85 c0 75 09
[   89.558291][  T337] RSP: 0018:ffff8880200df308 EFLAGS: 00010216
[   89.558530][  T337] RAX: dffffc0000000000 RBX: ffff888004484000 RCX: ffff888004484000
[   89.558818][  T337] RDX: 00000000000001a8 RSI: 0000000000000000 RDI: 0000000000000035
[   89.559096][  T337] RBP: dffffc0000000000 R08: 1ffff11000890850 R09: 00000000a1c8e417
[   89.559374][  T337] R10: 0000000000000001 R11: 00000000d51664f0 R12: 0000000000000000
[   89.559657][  T337] R13: 0000000000000000 R14: 00000000ffff0002 R15: ffffffff9e5c6cc0
[   89.559942][  T337] FS:  00007ff004df66c0(0000) GS:ffff88809543b000(0000) knlGS:0000000000000000
[   89.560273][  T337] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.560507][  T337] CR2: 000055ce40d39158 CR3: 0000000016275000 CR4: 0000000000750ef0
[   89.560797][  T337] PKRU: 55555554
[   80.405129] Call Trace:
[   80.405430]  <TASK>
[   89.561184][  T337]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   89.561382][  T337]  ? __pfx_htb_qlen_notify (net/sched/sch_htb.c:1487)
[   89.561570][  T337]  qdisc_tree_reduce_backlog (net/sched/sch_api.c:806)
[   89.561770][  T337]  multiq_graft (./include/net/sch_generic.h:1007 ./include/net/sch_generic.h:1283 net/sched/sch_multiq.c:289)
[   89.561959][  T337]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   89.562140][  T337]  ? __pfx_multiq_graft (net/sched/sch_multiq.c:282)
[   89.562294][  T337]  ? qdisc_alloc (./include/linux/refcount.h:134 net/sched/sch_generic.c:984)
[   89.562461][  T337]  ? qdisc_create (net/sched/sch_api.c:1263)
[   89.562613][  T337]  ? __pfx_htb_init (net/sched/sch_htb.c:1052)
[   89.562786][  T337]  ? netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
[   89.562941][  T337]  qdisc_graft (net/sched/sch_api.c:1197)
[   89.563098][  T337]  ? __pfx_qdisc_graft (net/sched/sch_api.c:1091)
[   89.563293][  T337]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   89.563459][  T337]  ? qdisc_hash_add (net/sched/sch_api.c:285 (discriminator 2) net/sched/sch_api.c:282 (discriminator 2))
[   89.563618][  T337]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   89.563780][  T337]  ? qdisc_create (./include/trace/events/qdisc.h:127 (discriminator 33) net/sched/sch_api.c:1344 (discriminator 33))
[   89.563950][  T337]  tc_modify_qdisc (net/sched/sch_api.c:1762 net/sched/sch_api.c:1817)

Fix this by putting the qdisc in a intermediate state whenever qdisc_graft
cannot delete it because it's being accessed in parallel by a classifier.
We accomplish this by creating a new qdisc op (mark_for_del), which will
set the TCQ_F_MARK_FOR_DEL flag for the qdisc and all of its descendents in
the tree. This op is mandatory for all qdiscs that perform grafting.
When the qdisc is in this intermediate state, whenever it is looked up,
ERR_PTR(-EBUSY) will be returned.

A similar issue was fixed for ingress side in
https://lore.kernel.org/netdev/c1f67078dc8a3fd7b3c8ed65896c726d1e9b261e.1686355297.git.peilin.ye@bytedance.com/

Note: We tried a couple of different approaches that had smaller code
footprint but were a bit fugly. The first approach was to use recursion
on the qdisc hash table to iterate the descendants of the qdisc; however,
the challenge here is if the graph depth is "high" - we may overflow the
stack. The second approach was to use a breadth first search to achieve
the same goal; the challenge here was it was a quadratic algorithm.

Fixes: 470502de5bdb ("net: sched: unlock rules update API")
Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: GangMin Kim <km.kim1503@gmail.com>
Closes: https://lore.kernel.org/netdev/CAGfirffHzSjmjNGx1ZU+JNLmrUYWEukrPAP5nTbJdemn6MZGyQ@mail.gmail.com/
Closes: https://lore.kernel.org/netdev/CAGfirfcsAFODycGarmqY8v6HSiHVaBgyKSUucV0DvPDjVX0U8Q@mail.gmail.com/
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/sch_generic.h | 14 ++++++-
 include/net/sch_priv.h    |  1 +
 net/sched/bpf_qdisc.c     |  5 +++
 net/sched/cls_api.c       | 11 ++++--
 net/sched/sch_api.c       | 79 +++++++++++++++++++++++++++++++++++----
 net/sched/sch_cake.c      |  1 +
 net/sched/sch_cbs.c       |  8 ++++
 net/sched/sch_drr.c       | 15 ++++++++
 net/sched/sch_ets.c       | 10 +++++
 net/sched/sch_hfsc.c      | 14 +++++++
 net/sched/sch_htb.c       | 22 +++++++++++
 net/sched/sch_mq.c        | 14 +++++++
 net/sched/sch_mqprio.c    | 15 ++++++++
 net/sched/sch_multiq.c    | 11 ++++++
 net/sched/sch_netem.c     |  8 ++++
 net/sched/sch_prio.c      | 11 ++++++
 net/sched/sch_qfq.c       | 14 +++++++
 net/sched/sch_red.c       |  8 ++++
 net/sched/sch_sfb.c       |  8 ++++
 net/sched/sch_taprio.c    | 12 ++++++
 net/sched/sch_tbf.c       |  8 ++++
 21 files changed, 277 insertions(+), 12 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d5d55cb21686..5f0ec8e02d2b 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -89,6 +89,7 @@ struct Qdisc {
 #define TCQ_F_NOLOCK		0x100 /* qdisc does not require locking */
 #define TCQ_F_OFFLOADED		0x200 /* qdisc is offloaded to HW */
 #define TCQ_F_DEQUEUE_DROPS	0x400 /* ->dequeue() can drop packets in q->to_free */
+#define TCQ_F_MARK_FOR_DEL	0x800 /* Is marked for deletion */
 
 	u32			limit;
 	const struct Qdisc_ops	*ops;
@@ -328,7 +329,7 @@ struct Qdisc_ops {
 
 	int			(*dump)(struct Qdisc *, struct sk_buff *);
 	int			(*dump_stats)(struct Qdisc *, struct gnet_dump *);
-
+	void			(*mark_for_del)(struct Qdisc *sch);
 	void			(*ingress_block_set)(struct Qdisc *sch,
 						     u32 block_index);
 	void			(*egress_block_set)(struct Qdisc *sch,
@@ -740,6 +741,17 @@ qdisc_offload_graft_helper(struct net_device *dev, struct Qdisc *sch,
 {
 }
 #endif
+
+static inline void qdisc_mark_for_del(struct Qdisc *sch)
+{
+	if (!sch)
+		return;
+
+	sch->flags |= TCQ_F_MARK_FOR_DEL;
+	if (sch->ops->mark_for_del)
+		sch->ops->mark_for_del(sch);
+}
+
 void qdisc_offload_query_caps(struct net_device *dev,
 			      enum tc_setup_type type,
 			      void *caps, size_t caps_len);
diff --git a/include/net/sch_priv.h b/include/net/sch_priv.h
index 4789f668ae87..4c874d1d5e7c 100644
--- a/include/net/sch_priv.h
+++ b/include/net/sch_priv.h
@@ -12,6 +12,7 @@ int mq_init_common(struct Qdisc *sch, struct nlattr *opt,
 		   struct netlink_ext_ack *extack,
 		   const struct Qdisc_ops *qdisc_ops);
 void mq_destroy_common(struct Qdisc *sch);
+void mq_mark_for_del_common(struct Qdisc *sch);
 void mq_attach(struct Qdisc *sch);
 void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb);
 struct netdev_queue *mq_select_queue(struct Qdisc *sch,
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89..e40d84ddf4a8 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -246,6 +246,11 @@ __bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
 		 * has not been added to qdisc_hash yet.
 		 */
 		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
+		if (IS_ERR(p)) {
+			NL_SET_ERR_MSG(extack,
+				       "BPF Qdisc is being deleted in parallel");
+			return PTR_ERR(p);
+		}
 		if (p && !(p->flags & TCQ_F_MQROOT)) {
 			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
 			return -EINVAL;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4829c27446e3..fc0c0d94d7ac 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1203,6 +1203,12 @@ static int __tcf_qdisc_find(struct net *net, struct Qdisc **q,
 		*parent = (*q)->handle;
 	} else {
 		*q = qdisc_lookup_rcu(dev, TC_H_MAJ(*parent));
+		if (IS_ERR(*q)) {
+			NL_SET_ERR_MSG(extack,
+				       "Parent Qdisc is being deleted in parallel");
+			err = PTR_ERR(*q);
+			goto errout_rcu;
+		}
 		if (!*q) {
 			NL_SET_ERR_MSG(extack, "Parent Qdisc doesn't exists");
 			err = -EINVAL;
@@ -2895,7 +2901,7 @@ static int tc_dump_tfilter(struct sk_buff *skb, struct netlink_callback *cb)
 			q = rtnl_dereference(dev->qdisc);
 		else
 			q = qdisc_lookup(dev, TC_H_MAJ(tcm->tcm_parent));
-		if (!q)
+		if (IS_ERR_OR_NULL(q))
 			goto out;
 		cops = q->ops->cl_ops;
 		if (!cops)
@@ -3278,8 +3284,7 @@ static int tc_dump_chain(struct sk_buff *skb, struct netlink_callback *cb)
 			q = rtnl_dereference(dev->qdisc);
 		else
 			q = qdisc_lookup(dev, TC_H_MAJ(tcm->tcm_parent));
-
-		if (!q)
+		if (IS_ERR_OR_NULL(q))
 			goto out;
 		cops = q->ops->cl_ops;
 		if (!cops)
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cc43e3f7574f..fa126309c06b 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -159,6 +159,12 @@ int register_qdisc(struct Qdisc_ops *qops)
 
 		if (cops->tcf_block && !(cops->bind_tcf && cops->unbind_tcf))
 			goto out_einval;
+
+		/* If a qdisc can have children, it might need to mark them
+		 * in case there are parallel classifier ops
+		 */
+		if (cops->graft && !(qops->mark_for_del))
+			goto out_einval;
 	}
 
 	qops->next = NULL;
@@ -264,17 +270,30 @@ static struct Qdisc *qdisc_match_from_root(struct Qdisc *root, u32 handle)
 {
 	struct Qdisc *q;
 
-	if (!qdisc_dev(root))
-		return (root->handle == handle ? root : NULL);
+	if (!qdisc_dev(root)) {
+		if (root->handle == handle) {
+			if (root->flags & TCQ_F_MARK_FOR_DEL)
+				return ERR_PTR(-EBUSY);
+			return root;
+		}
+		return NULL;
+	}
 
 	if (!(root->flags & TCQ_F_BUILTIN) &&
-	    root->handle == handle)
+	    root->handle == handle) {
+		if (root->flags & TCQ_F_MARK_FOR_DEL)
+			return ERR_PTR(-EBUSY);
+
 		return root;
+	}
 
 	hash_for_each_possible_rcu(qdisc_dev(root)->qdisc_hash, q, hash, handle,
 				   lockdep_rtnl_is_held()) {
-		if (q->handle == handle)
+		if (q->handle == handle) {
+			if (q->flags & TCQ_F_MARK_FOR_DEL)
+				return ERR_PTR(-EBUSY);
 			return q;
+		}
 	}
 	return NULL;
 }
@@ -793,8 +812,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 		notify = !sch->q.qlen;
 		/* TODO: perform the search on a per txq basis */
 		sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
-		if (sch == NULL) {
-			WARN_ON_ONCE(parentid != TC_H_ROOT);
+		if (sch == NULL || IS_ERR(sch)) {
+			WARN_ON_ONCE(parentid != TC_H_ROOT && sch == NULL);
 			break;
 		}
 		cops = sch->ops->cl_ops;
@@ -985,6 +1004,8 @@ static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
 		return true;
 	if ((q->flags & TCQ_F_INVISIBLE) && !dump_invisible)
 		return true;
+	if ((q->flags & TCQ_F_MARK_FOR_DEL))
+		return true;
 
 	return false;
 }
@@ -1050,6 +1071,17 @@ static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 	return -EINVAL;
 }
 
+static void qdisc_put_mark_for_del(struct Qdisc *sch)
+{
+	if (sch->flags & TCQ_F_BUILTIN)
+		return;
+
+	if (refcount_dec_and_test(&sch->refcnt))
+		qdisc_destroy(sch);
+	else
+		qdisc_mark_for_del(sch);
+}
+
 static void notify_and_destroy(struct net *net, struct sk_buff *skb,
 			       struct nlmsghdr *n, u32 clid,
 			       struct Qdisc *old, struct Qdisc *new,
@@ -1059,7 +1091,7 @@ static void notify_and_destroy(struct net *net, struct sk_buff *skb,
 		qdisc_notify(net, skb, n, clid, old, new, extack);
 
 	if (old)
-		qdisc_put(old);
+		qdisc_put_mark_for_del(old);
 }
 
 static void qdisc_clear_nolock(struct Qdisc *sch)
@@ -1157,7 +1189,6 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 			rcu_assign_pointer(dev->qdisc, new ? : &noop_qdisc);
 
 			notify_and_destroy(net, skb, n, classid, old, new, extack);
-
 			if (new && new->ops->attach)
 				new->ops->attach(new);
 		}
@@ -1481,6 +1512,11 @@ static int __tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		if (clid != TC_H_ROOT) {
 			if (TC_H_MAJ(clid) != TC_H_MAJ(TC_H_INGRESS)) {
 				p = qdisc_lookup(dev, TC_H_MAJ(clid));
+				if (IS_ERR(p)) {
+					NL_SET_ERR_MSG(extack,
+						       "Qdisc is being deleted in parallel");
+					return PTR_ERR(p);
+				}
 				if (!p) {
 					NL_SET_ERR_MSG(extack, "Failed to find qdisc with specified classid");
 					return -ENOENT;
@@ -1505,6 +1541,11 @@ static int __tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		}
 	} else {
 		q = qdisc_lookup(dev, tcm->tcm_handle);
+		if (IS_ERR(q)) {
+			NL_SET_ERR_MSG(extack,
+				       "Qdisc is being deleted in parallel");
+			return PTR_ERR(q);
+		}
 		if (!q) {
 			NL_SET_ERR_MSG(extack, "Failed to find qdisc with specified handle");
 			return -ENOENT;
@@ -1595,6 +1636,11 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		if (clid != TC_H_ROOT) {
 			if (clid != TC_H_INGRESS) {
 				p = qdisc_lookup(dev, TC_H_MAJ(clid));
+				if (IS_ERR(p)) {
+					NL_SET_ERR_MSG(extack,
+						       "Qdisc is being deleted in parallel");
+					return PTR_ERR(p);
+				}
 				if (!p) {
 					NL_SET_ERR_MSG(extack, "Failed to find specified qdisc");
 					return -ENOENT;
@@ -1629,6 +1675,11 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					return -EINVAL;
 				}
 				q = qdisc_lookup(dev, tcm->tcm_handle);
+				if (IS_ERR(q)) {
+					NL_SET_ERR_MSG(extack,
+						       "Qdisc is being deleted in parallel");
+					return PTR_ERR(q);
+				}
 				if (!q)
 					goto create_n_graft;
 				if (q->parent != tcm->tcm_parent) {
@@ -1705,6 +1756,11 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			return -EINVAL;
 		}
 		q = qdisc_lookup(dev, tcm->tcm_handle);
+		if (IS_ERR(q)) {
+			NL_SET_ERR_MSG(extack,
+				       "Qdisc is being deleted in parallel");
+			return PTR_ERR(q);
+		}
 	}
 
 	/* Change qdisc parameters */
@@ -2218,6 +2274,11 @@ static int __tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 
 	/* OK. Locate qdisc */
 	q = qdisc_lookup(dev, qid);
+	if (IS_ERR(q)) {
+		NL_SET_ERR_MSG(extack,
+			       "Qdisc is being deleted in parallel");
+		return PTR_ERR(q);
+	}
 	if (!q)
 		return -ENOENT;
 
@@ -2375,6 +2436,8 @@ static int tc_dump_tclass_root(struct Qdisc *root, struct sk_buff *skb,
 
 	if (tcm->tcm_parent) {
 		q = qdisc_match_from_root(root, TC_H_MAJ(tcm->tcm_parent));
+		if (IS_ERR(q))
+			return 0;
 		if (q && q != root &&
 		    tc_dump_tclass_qdisc(q, skb, tcm, cb, t_p, s_t) < 0)
 			return -1;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9efe23f8371b..a92ce78c733f 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3341,6 +3341,7 @@ static struct Qdisc_ops cake_mq_qdisc_ops __read_mostly = {
 	.change		=	cake_mq_change,
 	.change_real_num_tx = mq_change_real_num_tx,
 	.dump		=	cake_mq_dump,
+	.mark_for_del	=	mq_mark_for_del_common,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("cake_mq");
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 8c9a0400c862..23edb020a0de 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -449,6 +449,13 @@ static void cbs_destroy(struct Qdisc *sch)
 	qdisc_put(q->qdisc);
 }
 
+static void cbs_mark_for_del(struct Qdisc *sch)
+{
+	struct cbs_sched_data *q = qdisc_priv(sch);
+
+	qdisc_mark_for_del(q->qdisc);
+}
+
 static int cbs_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct cbs_sched_data *q = qdisc_priv(sch);
@@ -544,6 +551,7 @@ static struct Qdisc_ops cbs_qdisc_ops __read_mostly = {
 	.destroy	=	cbs_destroy,
 	.change		=	cbs_change,
 	.dump		=	cbs_dump,
+	.mark_for_del	=	cbs_mark_for_del,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("cbs");
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 01335a49e091..8d261d2c6548 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -458,6 +458,20 @@ static void drr_destroy_qdisc(struct Qdisc *sch)
 	qdisc_class_hash_destroy(&q->clhash);
 }
 
+static void drr_mark_qdisc_for_del(struct Qdisc *sch)
+{
+	struct drr_sched *q = qdisc_priv(sch);
+	struct hlist_node *next;
+	struct drr_class *cl;
+	int i;
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[i],
+					  common.hnode)
+			qdisc_mark_for_del(cl->qdisc);
+	}
+}
+
 static const struct Qdisc_class_ops drr_class_ops = {
 	.change		= drr_change_class,
 	.delete		= drr_delete_class,
@@ -483,6 +497,7 @@ static struct Qdisc_ops drr_qdisc_ops __read_mostly = {
 	.init		= drr_init_qdisc,
 	.reset		= drr_reset_qdisc,
 	.destroy	= drr_destroy_qdisc,
+	.mark_for_del	= drr_mark_qdisc_for_del,
 	.owner		= THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("drr");
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index a4b07b661b77..93a88e181ffb 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -742,6 +742,15 @@ static void ets_qdisc_destroy(struct Qdisc *sch)
 		qdisc_put(q->classes[band].qdisc);
 }
 
+static void ets_qdisc_mark_for_del(struct Qdisc *sch)
+{
+	struct ets_sched *q = qdisc_priv(sch);
+	int band;
+
+	for (band = 0; band < q->nbands; band++)
+		qdisc_mark_for_del(q->classes[band].qdisc);
+}
+
 static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct ets_sched *q = qdisc_priv(sch);
@@ -827,6 +836,7 @@ static struct Qdisc_ops ets_qdisc_ops __read_mostly = {
 	.reset		= ets_qdisc_reset,
 	.destroy	= ets_qdisc_destroy,
 	.dump		= ets_qdisc_dump,
+	.mark_for_del	= ets_qdisc_mark_for_del,
 	.owner		= THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("ets");
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index b5657ffbbf84..a008c8db532c 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1517,6 +1517,19 @@ hfsc_destroy_qdisc(struct Qdisc *sch)
 	qdisc_watchdog_cancel(&q->watchdog);
 }
 
+static void
+hfsc_mark_qdisc_for_del(struct Qdisc *sch)
+{
+	struct hfsc_sched *q = qdisc_priv(sch);
+	struct hfsc_class *cl;
+	unsigned int i;
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry(cl, &q->clhash.hash[i], cl_common.hnode)
+			qdisc_mark_for_del(cl->qdisc);
+	}
+}
+
 static int
 hfsc_dump_qdisc(struct Qdisc *sch, struct sk_buff *skb)
 {
@@ -1681,6 +1694,7 @@ static struct Qdisc_ops hfsc_qdisc_ops __read_mostly = {
 	.dequeue	= hfsc_dequeue,
 	.peek		= qdisc_peek_dequeued,
 	.cl_ops		= &hfsc_class_ops,
+	.mark_for_del	= hfsc_mark_qdisc_for_del,
 	.priv_size	= sizeof(struct hfsc_sched),
 	.owner		= THIS_MODULE
 };
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index cf6cd4ccfa20..6f740c82721e 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1689,6 +1689,27 @@ static void htb_destroy(struct Qdisc *sch)
 	kfree(q->direct_qdiscs);
 }
 
+static void htb_mark_for_del(struct Qdisc *sch)
+{
+	struct htb_sched *q = qdisc_priv(sch);
+	struct hlist_node *next;
+	struct htb_class *cl;
+	unsigned int i;
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[i],
+					  common.hnode)
+			if (!cl->level)
+				qdisc_mark_for_del(cl->leaf.q);
+	}
+
+	if (q->direct_qdiscs) {
+		for (i = 0; i < q->num_direct_qdiscs && q->direct_qdiscs[i];
+		     i++)
+			qdisc_mark_for_del(q->direct_qdiscs[i]);
+	}
+}
+
 static int htb_delete(struct Qdisc *sch, unsigned long arg,
 		      struct netlink_ext_ack *extack)
 {
@@ -2148,6 +2169,7 @@ static struct Qdisc_ops htb_qdisc_ops __read_mostly = {
 	.reset		=	htb_reset,
 	.destroy	=	htb_destroy,
 	.dump		=	htb_dump,
+	.mark_for_del	=	htb_mark_for_del,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("htb");
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index 0ed199fa18f0..1f9369ebc1dc 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -59,6 +59,19 @@ void mq_destroy_common(struct Qdisc *sch)
 }
 EXPORT_SYMBOL_NS_GPL(mq_destroy_common, "NET_SCHED_INTERNAL");
 
+void mq_mark_for_del_common(struct Qdisc *sch)
+{
+	struct mq_sched *priv = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	unsigned int ntx;
+
+	if (!priv->qdiscs)
+		return;
+	for (ntx = 0; ntx < dev->num_tx_queues && priv->qdiscs[ntx]; ntx++)
+		qdisc_mark_for_del(priv->qdiscs[ntx]);
+}
+EXPORT_SYMBOL_NS_GPL(mq_mark_for_del_common, "NET_SCHED_INTERNAL");
+
 static void mq_destroy(struct Qdisc *sch)
 {
 	mq_offload(sch, TC_MQ_DESTROY);
@@ -297,5 +310,6 @@ struct Qdisc_ops mq_qdisc_ops __read_mostly = {
 	.attach		= mq_attach,
 	.change_real_num_tx = mq_change_real_num_tx,
 	.dump		= mq_dump,
+	.mark_for_del	= mq_mark_for_del_common,
 	.owner		= THIS_MODULE,
 };
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index b83276409416..0566e854e156 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -112,6 +112,20 @@ static void mqprio_destroy(struct Qdisc *sch)
 		netdev_set_num_tc(dev, 0);
 }
 
+static void mqprio_mark_for_del(struct Qdisc *sch)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	struct mqprio_sched *priv = qdisc_priv(sch);
+	unsigned int ntx;
+
+	if (priv->qdiscs) {
+		for (ntx = 0;
+		     ntx < dev->num_tx_queues && priv->qdiscs[ntx];
+		     ntx++)
+			qdisc_mark_for_del(priv->qdiscs[ntx]);
+	}
+}
+
 static int mqprio_parse_opt(struct net_device *dev, struct tc_mqprio_qopt *qopt,
 			    const struct tc_mqprio_caps *caps,
 			    struct netlink_ext_ack *extack)
@@ -769,6 +783,7 @@ static struct Qdisc_ops mqprio_qdisc_ops __read_mostly = {
 	.attach		= mqprio_attach,
 	.change_real_num_tx = mq_change_real_num_tx,
 	.dump		= mqprio_dump,
+	.mark_for_del	= mqprio_mark_for_del,
 	.owner		= THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("mqprio");
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 9f822fee113d..edc60ddc0b12 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -168,6 +168,16 @@ multiq_destroy(struct Qdisc *sch)
 	kfree(q->queues);
 }
 
+static void
+multiq_mark_for_del(struct Qdisc *sch)
+{
+	struct multiq_sched_data *q = qdisc_priv(sch);
+	int band;
+
+	for (band = 0; band < q->bands; band++)
+		qdisc_mark_for_del(q->queues[band]);
+}
+
 static int multiq_tune(struct Qdisc *sch, struct nlattr *opt,
 		       struct netlink_ext_ack *extack)
 {
@@ -393,6 +403,7 @@ static struct Qdisc_ops multiq_qdisc_ops __read_mostly = {
 	.destroy	=	multiq_destroy,
 	.change		=	multiq_tune,
 	.dump		=	multiq_dump,
+	.mark_for_del	=	multiq_mark_for_del,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("multiq");
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 5de1c932944a..134716ec507f 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1155,6 +1155,13 @@ static void netem_destroy(struct Qdisc *sch)
 	dist_free(q->slot_dist);
 }
 
+static void netem_mark_for_del(struct Qdisc *sch)
+{
+	struct netem_sched_data *q = qdisc_priv(sch);
+
+	qdisc_mark_for_del(q->qdisc);
+}
+
 static int dump_loss_model(const struct netem_sched_data *q,
 			   struct sk_buff *skb)
 {
@@ -1353,6 +1360,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.mark_for_del	=	netem_mark_for_del,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 9e2b9a490db2..3a8cc47cd6a4 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -173,6 +173,16 @@ prio_destroy(struct Qdisc *sch)
 		qdisc_put(q->queues[prio]);
 }
 
+static void
+prio_mark_for_del(struct Qdisc *sch)
+{
+	struct prio_sched_data *q = qdisc_priv(sch);
+	int prio;
+
+	for (prio = 0; prio < q->bands; prio++)
+		qdisc_mark_for_del(q->queues[prio]);
+}
+
 static int prio_tune(struct Qdisc *sch, struct nlattr *opt,
 		     struct netlink_ext_ack *extack)
 {
@@ -416,6 +426,7 @@ static struct Qdisc_ops prio_qdisc_ops __read_mostly = {
 	.destroy	=	prio_destroy,
 	.change		=	prio_tune,
 	.dump		=	prio_dump,
+	.mark_for_del	=	prio_mark_for_del,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("prio");
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 699e45873f86..6b72a626dc74 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1510,6 +1510,19 @@ static void qfq_destroy_qdisc(struct Qdisc *sch)
 	qdisc_class_hash_destroy(&q->clhash);
 }
 
+static void qfq_mark_qdisc_for_del(struct Qdisc *sch)
+{
+	struct qfq_sched *q = qdisc_priv(sch);
+	struct qfq_class *cl;
+	unsigned int i;
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry(cl, &q->clhash.hash[i],
+				     common.hnode)
+			qdisc_mark_for_del(cl->qdisc);
+	}
+}
+
 static const struct Qdisc_class_ops qfq_class_ops = {
 	.change		= qfq_change_class,
 	.delete		= qfq_delete_class,
@@ -1535,6 +1548,7 @@ static struct Qdisc_ops qfq_qdisc_ops __read_mostly = {
 	.init		= qfq_init_qdisc,
 	.reset		= qfq_reset_qdisc,
 	.destroy	= qfq_destroy_qdisc,
+	.mark_for_del	= qfq_mark_qdisc_for_del,
 	.owner		= THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("qfq");
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 479c42d11083..e5df29ca5f7c 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -223,6 +223,13 @@ static void red_destroy(struct Qdisc *sch)
 	qdisc_put(q->qdisc);
 }
 
+static void red_mark_for_del(struct Qdisc *sch)
+{
+	struct red_sched_data *q = qdisc_priv(sch);
+
+	qdisc_mark_for_del(q->qdisc);
+}
+
 static const struct nla_policy red_policy[TCA_RED_MAX + 1] = {
 	[TCA_RED_UNSPEC] = { .strict_start_type = TCA_RED_FLAGS },
 	[TCA_RED_PARMS]	= { .len = sizeof(struct tc_red_qopt) },
@@ -548,6 +555,7 @@ static struct Qdisc_ops red_qdisc_ops __read_mostly = {
 	.change		=	red_change,
 	.dump		=	red_dump,
 	.dump_stats	=	red_dump_stats,
+	.mark_for_del	=	red_mark_for_del,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("red");
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index d2835f1168e1..e4151e39a92f 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -473,6 +473,13 @@ static void sfb_destroy(struct Qdisc *sch)
 	qdisc_put(q->qdisc);
 }
 
+static void sfb_mark_for_del(struct Qdisc *sch)
+{
+	struct sfb_sched_data *q = qdisc_priv(sch);
+
+	qdisc_mark_for_del(q->qdisc);
+}
+
 static const struct nla_policy sfb_policy[TCA_SFB_MAX + 1] = {
 	[TCA_SFB_PARMS]	= { .len = sizeof(struct tc_sfb_qopt) },
 };
@@ -709,6 +716,7 @@ static struct Qdisc_ops sfb_qdisc_ops __read_mostly = {
 	.change		=	sfb_change,
 	.dump		=	sfb_dump,
 	.dump_stats	=	sfb_dump_stats,
+	.mark_for_del	=	sfb_mark_for_del,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("sfb");
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f721c03514f6..54bb5814f1e9 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2059,6 +2059,17 @@ static void taprio_destroy(struct Qdisc *sch)
 	taprio_cleanup_broken_mqprio(q);
 }
 
+static void taprio_mark_for_del(struct Qdisc *sch)
+{
+	struct taprio_sched *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	unsigned int i;
+
+	if (q->qdiscs)
+		for (i = 0; i < dev->num_tx_queues; i++)
+			qdisc_mark_for_del(q->qdiscs[i]);
+}
+
 static int taprio_init(struct Qdisc *sch, struct nlattr *opt,
 		       struct netlink_ext_ack *extack)
 {
@@ -2542,6 +2553,7 @@ static struct Qdisc_ops taprio_qdisc_ops __read_mostly = {
 	.enqueue	= taprio_enqueue,
 	.dump		= taprio_dump,
 	.dump_stats	= taprio_dump_stats,
+	.mark_for_del	= taprio_mark_for_del,
 	.owner		= THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("taprio");
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index f2340164f579..ef378d5dc636 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -507,6 +507,13 @@ static void tbf_destroy(struct Qdisc *sch)
 	qdisc_put(q->qdisc);
 }
 
+static void tbf_mark_for_del(struct Qdisc *sch)
+{
+	struct tbf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_mark_for_del(q->qdisc);
+}
+
 static int tbf_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct tbf_sched_data *q = qdisc_priv(sch);
@@ -613,6 +620,7 @@ static struct Qdisc_ops tbf_qdisc_ops __read_mostly = {
 	.destroy	=	tbf_destroy,
 	.change		=	tbf_change,
 	.dump		=	tbf_dump,
+	.mark_for_del	=	tbf_mark_for_del,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("tbf");
-- 
2.34.1


