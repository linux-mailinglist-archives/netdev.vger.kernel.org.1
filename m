Return-Path: <netdev+bounces-291312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDelAiFAFGo3LQcAu9opvQ
	(envelope-from <netdev+bounces-291312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1475CA789
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55DFE3006D47
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ACB38229F;
	Mon, 25 May 2026 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="gvoYNmHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA939382F12
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711982; cv=none; b=hT3DeujdNL3tA6pTcJzNcq93rjuD4W3kfJggZH1r4zCoWtApZj1AQS1YjGJkgPYgeA+H1TRyfC+SFM+oZrB66qmCpOl+wDsZtiXi7IPrQynFFX3eTO/V45R/JI8M+eSDa8iTs7J3xhO8wKicEjpSFKFXsXYTO3HET8dNlloprZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711982; c=relaxed/simple;
	bh=MzWTOojJnUdTjVlKXk4sNXBNf4Gat89xYqzWrd+nElg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AO5hBKw2J+bCOQbr32a39VF44CNc05MJBcvmSWYlwygn874Gzn1vGK20kKT6l5KWeNEU8l4mZpoc4QIzuPgjmPlO31I2DMBln/rgL5qE7+AyFb1ln4tXSZ8kU29paiwBch7A5eBDfLbpFcdX4+u1IZsiHbuGgcqf/3IOPaFYmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=gvoYNmHy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516c96d0cdeso35155881cf.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711980; x=1780316780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztudx56UaHqfcYM2EjbGSFGNalZdWLRZ8QxWugcBnS8=;
        b=gvoYNmHyySg+TRiz/nZLxOmctdsW4F0Wl8XeZmO1N2bNszElhH8+PCvAoaKmPFnMZ6
         EZnxpqEFprMiKt8IOQwqmsu3yyxLvjyaeEXRpndbcmSPNDPJsgnAX0cHAgnvlvseNaA4
         vKIDJvlhfrXkl0JPFvMcfZIpQvofHLwc69DDxolJMMYAozF3KlgDM8qQiEzd5PIK38+c
         EoiwF9CRKMqRipe1Ybh+1soHVOd1pmAahjQbOuIbqUSESX+qOE4zaIB1INs0rz0tNvts
         TTr/0VzOVAbJOKNmFYY0j6wfjeZYiq71eSXa7hYZajbWt1NZ64NmvxC2SamV4hVwUW4k
         O3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711980; x=1780316780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztudx56UaHqfcYM2EjbGSFGNalZdWLRZ8QxWugcBnS8=;
        b=W+m4t1R2oBPrOzkT4WQOdbo9GAQzw65jOpgkixtb6l+OS0n9/xntM/Y/QrYaH4RXgP
         2qt9hFxi1v1nAyHW4XlPJcTOl9LL1eh7DqwdlYURDtHDpRzTzda7+CTaKIDS7d+8wGDp
         zgCdSjlU/kNCTKxSiWRFGEqlzAMUmVFrKqJpmQ/+qdvJEyT01BTQoRBO5y1vi1tyC0kU
         XQp2pHdo8xddzw7DZNJGr1n1+npLMvj0kxxEATDTTm4fpLsn6QNpYZFSg8kMybvIgcKl
         pYLt4ClZuVD1cZcBhHY8GTX7BAVzm1h6H1Z4rlMxYsOD2E4rfLFHkK9ivwcrL2+3nJsv
         Q0/w==
X-Gm-Message-State: AOJu0YwessAouGesZ0qIBtPwG5hsAcCCQ4t+5A8Nm92LWEm6uRugBRjH
	iAV1onTIPD3ySww/u98D+EGLtE9qSwi35USoRNiBeDUmsX0Pcc9GkzX5jjib2XcsvMkqw8T2SST
	PYRcrDw==
X-Gm-Gg: Acq92OE9KsBFs87zCNeRi7yqLTGHTRn3OzfWmWE+h7wdewCNEWOashYywp0Po51dZeM
	gRyKAkxTKOLCZ5Yr062Prmb0l8m0PrhzwE7Z1NBLd0OtZCwbSH1CeOxFOPtSRhvimDFotYVd40Y
	Yg/AZ8lTCiwM0kINO9gw/dopR1BQv2h8UIdwCJKe7y0glzhlJNnbbJVKlKxeQrI1IxoGmQ5i5Rv
	umO8N4Lo0yJpkjFkX5yGKpK2XZ+s7dwWDBL34k9UOrEIk3CjHhloqJtiWMJVmxEKi/tiZQLuYI1
	8RnDqJoFVB6p2mK2+VecY5UP28vgFXNxmmHftUgzeZDtUN3Vu4Om2lcp94L0c0Wg6y0FguR60T0
	sTELdWq6Mjdg/NR9dpeHWXphRdVD6FbU0unsr+DfT4LzjDrO7VwnNiqMfHUqY3ibCbo+LQyvX6e
	RYK0OgD6RAl1FPZuFxvEptqmW4dvO//pSTqkhslg==
X-Received: by 2002:a05:622a:203:b0:516:e1d4:5540 with SMTP id d75a77b69052e-516e1d4585fmr122034551cf.30.1779711979764;
        Mon, 25 May 2026 05:26:19 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:18 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	will@willsroot.io,
	hxzene@gmail.com,
	victor@mojatatu.com
Subject: [PATCH net v6 6/9] net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow
Date: Mon, 25 May 2026 08:25:53 -0400
Message-Id: <20260525122556.973584-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525122556.973584-1-jhs@mojatatu.com>
References: <20260525122556.973584-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291312-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0D1475CA789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Kito Xu (veritas501)" <hxzene@gmail.com>

tcf_mirred_act() checks sched_mirred_nest against MIRRED_NEST_LIMIT (4)
to prevent deep recursion.  However, when the action uses blockcast
(tcfm_blockid != 0), the function returns at the tcf_blockcast() call
BEFORE reaching the counter increment.  As a result, the recursion
counter never advances and the limit check is entirely bypassed.

When two devices share a TC egress block with a mirred blockcast rule,
a packet egressing on device A is mirrored to device B via blockcast;
device B's egress TC re-enters tcf_mirred_act() via blockcast and
mirrors back to A, creating an unbounded recursion loop:

  tcf_mirred_act -> tcf_blockcast -> tcf_mirred_to_dev -> dev_queue_xmit
  -> sch_handle_egress -> tcf_classify -> tcf_mirred_act -> (repeat)

This recursion continues until the kernel stack overflows.

The bug is reachable from an unprivileged user via
unshare(CLONE_NEWUSER | CLONE_NEWNET): user namespaces grant
CAP_NET_ADMIN in the new network namespace, which is sufficient to
create dummy devices, attach clsact qdiscs with shared blocks, and
install mirred blockcast filters.

 BUG: TASK stack guard page was hit at ffffc90000b7fff8
 Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
 CPU: 2 UID: 1000 PID: 169 Comm: poc Not tainted 7.0.0-rc7-next-20260410
 RIP: 0010:xas_find+0x17/0x480
 Call Trace:
  xa_find+0x17b/0x1d0
  tcf_mirred_act+0x640/0x1060
  tcf_action_exec+0x400/0x530
  basic_classify+0x128/0x1d0
  tcf_classify+0xd83/0x1150
  tc_run+0x328/0x620
  __dev_queue_xmit+0x797/0x3100
  tcf_mirred_to_dev+0x7b1/0xf70
  tcf_mirred_act+0x68a/0x1060
  [repeating ~30+ times until stack overflow]
 Kernel panic - not syncing: Fatal exception in interrupt

Fix this by incrementing sched_mirred_nest before calling
tcf_blockcast() and decrementing it on return, mirroring the
non-blockcast path.  This ensures subsequent recursive entries see the
updated counter and are correctly limited by MIRRED_NEST_LIMIT.

Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/sched/act_mirred.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index dd5e7ea7ef26..dbe4a4ff3e08 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -396,14 +396,12 @@ static int tcf_blockcast_mirror(struct sk_buff *skb, struct tcf_mirred *m,
 
 static int tcf_blockcast(struct sk_buff *skb, struct tcf_mirred *m,
 			 const u32 blockid, struct tcf_result *res,
-			 int retval)
+			 int m_eaction, int retval)
 {
 	const u32 exception_ifindex = skb->dev->ifindex;
 	struct tcf_block *block;
 	bool is_redirect;
-	int m_eaction;
 
-	m_eaction = READ_ONCE(m->tcfm_eaction);
 	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 
 	/* we are already under rcu protection, so can call block lookup
@@ -453,8 +451,16 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	tcf_action_update_bstats(&m->common, skb);
 
 	blockid = READ_ONCE(m->tcfm_blockid);
-	if (blockid)
-		return tcf_blockcast(skb, m, blockid, res, retval);
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+	if (blockid) {
+		if (!want_ingress)
+			xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = NULL;
+		retval = tcf_blockcast(skb, m, blockid, res, m_eaction, retval);
+		if (!want_ingress)
+			xmit->sched_mirred_nest--;
+		return retval;
+	}
 
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
@@ -463,8 +469,6 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		return retval;
 	}
 
-	m_eaction = READ_ONCE(m->tcfm_eaction);
-	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
 	if (!want_ingress) {
 		for (i = 0; i < xmit->sched_mirred_nest; i++) {
 			if (xmit->sched_mirred_dev[i] != dev)
-- 
2.54.0


