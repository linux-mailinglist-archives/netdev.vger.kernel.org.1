Return-Path: <netdev+bounces-258555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM8qOUCdjmkODQEAu9opvQ
	(envelope-from <netdev+bounces-258555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:40:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D82132B30
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90204303C31B
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C97E24BD03;
	Fri, 13 Feb 2026 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cODQNXsr"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D548323BCFD
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 03:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770954043; cv=none; b=LbugbJgyioPOQdKfriERYm1DZtLKqkS/FTrj3v+h+v2sFB9qXgpHssIzJDspNPuwfQE3K+c2ItJ94wA9fx9Q4SO7GtjFP5BbT6BvztZ460zH+D8Tv1xvV3i0I+1AV9bpPS3IX89XvmhVnFlFiO36eXuZFUxVn4n1HAVaCtSFy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770954043; c=relaxed/simple;
	bh=x3qRMK3LifLhrUce7mcq9Nw+Vwsuseg5ZC16FEnoYm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3YyuDAmazVGfDV4Yp3hOzVtVQP4hrfOdfacPV5UKXTnImEtfEZP7NmKnly8fjqY3Y7MtnQHkVjKBB0/wRDbhwsD9zyvfeqMD1CD83cax4/yD1HGlSBgZzp0trs8LaeCBQ27e4bZctKmrAFQt2qDKLQrvl0EQ1AlgUkyZfMduJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cODQNXsr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770954029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vteMQwlPg3yz1XZoaZjroxzl26QSeu9hoh9la6RqM0o=;
	b=cODQNXsrMmBTbqv4k9S/IykhGAu9JUOdHK/YDfqJa1igVv/bOvN5WN2INGoFF8TgAeTmdU
	BYsNR7ano3AZdwROhg5XzaCDw2uIPtqmkoNLJY4W9AVBywcqs+Ppwdvy2SGrlcM+m1v5dI
	/EmrYdDcURTv0vcRGqkeRYq0Kyzqs6E=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xxx@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf v3 0/2] bpf: cpumap/devmap: fix per-CPU bulk queue races on PREEMPT_RT
Date: Fri, 13 Feb 2026 11:40:13 +0800
Message-ID: <20260213034018.284146-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-258555-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 87D82132B30
X-Rspamd-Action: no action

On PREEMPT_RT kernels, local_bh_disable() only calls migrate_disable()
(when PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
preemption. This means CFS scheduling can preempt a task inside the
per-CPU bulk queue (bq) operations in cpumap and devmap, allowing
another task on the same CPU to concurrently access the same bq,
leading to use-after-free, list corruption, and kernel panics.

Patch 1 fixes the cpumap race in bq_flush_to_queue(), originally
reported by syzbot [1].

Patch 2 fixes the same class of race in devmap's bq_xmit_all(),
identified by code inspection after Sebastian Andrzej Siewior pointed
out that devmap has the same per-CPU bulk queue pattern [2].

Both patches use local_lock_nested_bh() to serialize access to the
per-CPU bq. On non-RT this is a pure lockdep annotation with no
overhead; on PREEMPT_RT it provides a per-CPU sleeping lock.

[1] https://lore.kernel.org/all/69369331.a70a0220.38f243.009d.GAE@google.com/T/
[2] https://lore.kernel.org/bpf/20260212023634.366343-1-jiayuan.chen@linux.dev/

---
v2 -> v3: https://lore.kernel.org/bpf/20260212023634.366343-1-jiayuan.chen@linux.dev/
- Fix commit message: remove incorrect "spin_lock() becomes rt_mutex"
claim, the per-CPU bq has no spin_lock at all. (Sebastian Andrzej Siewior)
- Fix commit message: accurately describe local_lock_nested_bh()
behavior instead of referencing local_lock(). (Sebastian Andrzej Siewior)
- Remove incomplete discussion of snapshot alternative.
(Sebastian Andrzej Siewior)
- Remove panic trace from commit message. (Sebastian Andrzej Siewior)
- Add patch 2/2 for devmap, same race pattern. (Sebastian Andrzej Siewior)

v1 -> v2: https://lore.kernel.org/bpf/20260211064417.196401-1-jiayuan.chen@linux.dev/
- Use local_lock_nested_bh()/local_unlock_nested_bh() instead of
local_lock()/local_unlock(), since these paths already run under
local_bh_disable(). (Sebastian Andrzej Siewior)
- Replace "Caller must hold bq->bq_lock" comment with
lockdep_assert_held() in bq_flush_to_queue(). (Sebastian Andrzej Siewior)
- Fix Fixes tag to 3253cb49cbad ("softirq: Allow to drop the
softirq-BKL lock on PREEMPT_RT") which is the actual commit that
makes the race possible. (Sebastian Andrzej Siewior)

Jiayuan Chen (2):
  bpf: cpumap: fix race in bq_flush_to_queue on PREEMPT_RT
  bpf: devmap: fix race in bq_xmit_all on PREEMPT_RT

 kernel/bpf/cpumap.c | 17 +++++++++++++++--
 kernel/bpf/devmap.c | 25 +++++++++++++++++++++----
 2 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.43.0


