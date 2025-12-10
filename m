Return-Path: <netdev+bounces-244271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F27CB3782
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 17:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB9C301E5BA
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF325743D;
	Wed, 10 Dec 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KgVz8yHM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9E28489B
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383796; cv=none; b=oTV3qCePdfRU406ya+0MGlyG5GxhnlBF/0bTVnardosYrqFrVp/G8YlCB4c1cmuJrArSQiarGJG1zMKA7FROo5I3r/PXh4+3VDSFTxkz66AiGjJwY1hwhk+lpNGUu8R30qzdO5XQ2aZ62JDNaOxK2gqAnKtnlXN/B57CdbOYHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383796; c=relaxed/simple;
	bh=TVYQlSswgyT4Y2yQXOMvxVwiBQeT6+KriqVo8PC2u5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+XAO4iH8Qj4euhhf9P6JQd5DH8ZGhW4sKnU4GxDyvuJwGMl/L/ZhuhzgIu5WM4rMlZx4BTwiPknQLDQsT/zjscAiwVCUyEU01K7JZ56P6Jj7wwVUpKY+bscHCve2PhmGmTIW/ZxGqHItAqGPfKL7nRHUDIqM3Eu0+UOuavcP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KgVz8yHM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88057f5d041so31846d6.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 08:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765383792; x=1765988592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qaPQJgbEoeIPjFplI6qRjEqdrC6eBo7pPR0ANH2lMU=;
        b=KgVz8yHMD3kvS7khrmusmvoEkEPy82XdNEoCSHqaIQTsbMus6XU4w3zyCr7HTBdgSe
         sdkr7FrYzqzBKmf1Tz7znzfZvXyfJS+bjsdwjUpC7upTO33IZDEKN/zSog0JWvFOO7SW
         ktXokz/Qhy8eFDPgTMnx60lXpLOJOHpIHB3f6/iwTVkVMSS3abgHF082/+b2LvsA6axj
         vd+TrfISfMEuIp5muLFdpueoYeFoergq/x/vznb9yc8i3M6JsBr0cppvxVZYM+kQ4tdV
         wqJV2C1wqePwqAkFzEGvmaj6fwQSc1UIAShNNcoHfsgO0TD+MzSWzJlK6o1PDKhmFCca
         clSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765383792; x=1765988592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qaPQJgbEoeIPjFplI6qRjEqdrC6eBo7pPR0ANH2lMU=;
        b=p1Rmz0fFNQ2GouzySRVB/RNafsFs2tOEnswduPr91zwHriSs/NFCQyA3Y1PCJaf8D0
         HZCWiZS8xUR3h3xFYcNaI/hoDhz3AevzqHzbJDwj2ADTK9uw/eEedY6g6EqE8pPpiYzn
         PUuh5SMj2f46/UF+fbVLkhHCcxl9tWubKMPS/R3Woy2DP76eKrb0MqIpEKd9+OGwcHN/
         8Z1VCK1Ze3py/VJCck5IPDP6Jn0vbtHsIAyfhrd7eWGYRz3CpLOKrS5QSXma/M5ZIqHv
         eXxrg8npeGBq+kwetQsFeKeSMfVoge7IRfmfjBIIZHDlV3gFfEls564CcvcIS/HxVh+a
         O9AA==
X-Gm-Message-State: AOJu0YyhxsVX1ZVMA7pgVxroc6O8ZDfKqRmGhwgTjPbxIBBCFpdj775J
	T5RoQMDLlp13kynkg1L3u/quWr2FDS+rXdLiwqVGOpPS44yyIrcv6EmAEDcYVVCOSA==
X-Gm-Gg: AY/fxX6tPoYeS6+aPmdEgOwXjqXrulRXYusuxdr/tbig/a/CjmPbsgwmjQ7ILgdhhdX
	lQBIOU4PpeLFBHOaQmAJ9SQbQ0+p6OV37BR+MWZaATkM94gFqjMZ/RvDA7B4FFjJdBu5jYDKXo/
	9kvi2D3o5aC9St8O3hYr/ttfHoCyNEG3tyPVLV2h4tjOrIC6CRJa//ske0why7LiilfrcZ25UEH
	/er3vlJWF62RSbP+OEDKZF7CaT1kAqZbMlUuhxyC6jyT6pb3kX1XkizXsLUQKOUlKmgkMmP2qTV
	1nNI3IP1iXZPoj6NsqHOFy3u3ZONI4ZcQH7X/Lgu7kQG75sTvTvKSfz1d3hQdKnrgFUxWpfTE/u
	Vx5L3FVLZk8g62CPstyqPQm2v69l45r9dPjXkgy9T7m72qtEMgqcEKTxt8Tu8E8NTQFuQ1co4h6
	Oxgv0M/bFb10k=
X-Google-Smtp-Source: AGHT+IE9FgOF78UmkUi/0wvK5chRQHDx92pyi3DS+Y8/IP5gRkMAP18yqVI1DoWfHKpt8VSZ+bx6nQ==
X-Received: by 2002:a05:6214:b22:b0:888:6ea5:a90b with SMTP id 6a1803df08f44-8886ea5ac52mr2453086d6.0.1765383792272;
        Wed, 10 Dec 2025 08:23:12 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886eb1d624sm1044506d6.0.2025.12.10.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:23:11 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/2] net/sched: act_mirred: fix loop detection
Date: Wed, 10 Dec 2025 11:22:54 -0500
Message-Id: <20251210162255.1057663-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a loop scenario of ethx:egress->ethx:egress

Example setup to reproduce:
tc qdisc add dev ethx root handle 1: drr
tc filter add dev ethx parent 1: protocol ip prio 1 matchall \
         action mirred egress redirect dev ethx

Now ping out of ethx and you get a deadlock:

[  116.892898][  T307] ============================================
[  116.893182][  T307] WARNING: possible recursive locking detected
[  116.893418][  T307] 6.18.0-rc6-01205-ge05021a829b8-dirty #204 Not tainted
[  116.893682][  T307] --------------------------------------------
[  116.893926][  T307] ping/307 is trying to acquire lock:
[  116.894133][  T307] ffff88800c122908 (&sch->root_lock_key){+...}-{3:3}, at: __dev_queue_xmit+0x2210/0x3b50
[  116.894517][  T307]
[  116.894517][  T307] but task is already holding lock:
[  116.894836][  T307] ffff88800c122908 (&sch->root_lock_key){+...}-{3:3}, at: __dev_queue_xmit+0x2210/0x3b50
[  116.895252][  T307]
[  116.895252][  T307] other info that might help us debug this:
[  116.895608][  T307]  Possible unsafe locking scenario:
[  116.895608][  T307]
[  116.895901][  T307]        CPU0
[  116.896057][  T307]        ----
[  116.896200][  T307]   lock(&sch->root_lock_key);
[  116.896392][  T307]   lock(&sch->root_lock_key);
[  116.896605][  T307]
[  116.896605][  T307]  *** DEADLOCK ***
[  116.896605][  T307]
[  116.896864][  T307]  May be due to missing lock nesting notation
[  116.896864][  T307]
[  116.897123][  T307] 6 locks held by ping/307:
[  116.897302][  T307]  #0: ffff88800b4b0250 (sk_lock-AF_INET){+.+.}-{0:0}, at: raw_sendmsg+0xb20/0x2cf0
[  116.897808][  T307]  #1: ffffffff88c839c0 (rcu_read_lock){....}-{1:3}, at: ip_output+0xa9/0x600
[  116.898138][  T307]  #2: ffffffff88c839c0 (rcu_read_lock){....}-{1:3}, at: ip_finish_output2+0x2c6/0x1ee0
[  116.898459][  T307]  #3: ffffffff88c83960 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x200/0x3b50
[  116.898782][  T307]  #4: ffff88800c122908 (&sch->root_lock_key){+...}-{3:3}, at: __dev_queue_xmit+0x2210/0x3b50
[  116.899132][  T307]  #5: ffffffff88c83960 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x200/0x3b50
[  116.899442][  T307]
[  116.899442][  T307] stack backtrace:
[  116.899667][  T307] CPU: 2 UID: 0 PID: 307 Comm: ping Not tainted 6.18.0-rc6-01205-ge05021a829b8-dirty #204 PREEMPT(voluntary)
[  116.899672][  T307] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  116.899675][  T307] Call Trace:
[  116.899678][  T307]  <TASK>
[  116.899680][  T307]  dump_stack_lvl+0x6f/0xb0
[  116.899688][  T307]  print_deadlock_bug.cold+0xc0/0xdc
[  116.899695][  T307]  __lock_acquire+0x11f7/0x1be0
[  116.899704][  T307]  lock_acquire+0x162/0x300
[  116.899707][  T307]  ? __dev_queue_xmit+0x2210/0x3b50
[  116.899713][  T307]  ? srso_alias_return_thunk+0x5/0xfbef5
[  116.899717][  T307]  ? stack_trace_save+0x93/0xd0
[  116.899723][  T307]  _raw_spin_lock+0x30/0x40
[  116.899728][  T307]  ? __dev_queue_xmit+0x2210/0x3b50
[  116.899731][  T307]  __dev_queue_xmit+0x2210/0x3b50

Fixes: 178ca30889a1 ("Revert "net/sched: Fix mirred deadlock on device recursion"")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index f27b583def78..91c96cc625bd 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -281,6 +281,15 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 
 	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
 
+	if (dev == skb->dev && want_ingress == at_ingress) {
+		pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
+			       netdev_name(skb->dev),
+			       at_ingress ? "ingress" : "egress",
+			       netdev_name(dev),
+			       want_ingress ? "ingress" : "egress");
+		goto err_cant_do;
+	}
+
 	/* All mirred/redirected skbs should clear previous ct info */
 	nf_reset_ct(skb_to_send);
 	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
-- 
2.34.1


