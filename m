Return-Path: <netdev+bounces-282904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHzoLbB182mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:30:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2E84A4CFF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDA730347A5
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D0B31AABF;
	Thu, 30 Apr 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="VoTJV8Su"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0429B228
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563035; cv=none; b=b7zf0Fk/giwd7qv3piFRl1vOA75mHBQcYHe6tO2YU6Ea99j/7XkW/jiNCXL8pNJbxMzQOo2NBCjqOU0856avS7P37SYT0aUi3ut7QhgsQzP6BLsEVIFH/6Og013DuOqKu8EveT4OB+V8x4VYSXEjLfUSAHJFqINxXtu6liHKTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563035; c=relaxed/simple;
	bh=puCq/E/yL5qdxJSo1cn1HQv/mNIc6n0OINY/Wa4qinQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNjrScd8bnBsB4V9nYRWxR/jTLfk4ePXQBnwt2OZvq6SBRImVuSrsxkNQ4C0QULCcZzBHw+oV+HbKN8Lf447MRVOj3bxYZw2AFvRelgYEONm4lx+t200NGwblNCAu4tveJIM1/+hKsPRcJDFlv/vZE4cK7e1P6ngVROTJ/b2Ep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=VoTJV8Su; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e97863425so9508631cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777563032; x=1778167832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgFd9g2P7BVL3whbUa+ZHTFb4PctDl6068RwKx7qP1A=;
        b=VoTJV8SuBXu9xG5jXItPgNqIwxFx49B6zkGgM/aEIir5Qv7c44x5JP/siLDspCshBj
         +i1O0W8IPE8FxWbsPCg6TXTo2XsWdZkkGfd1Jje4RKphczv3NJi2NiQZbIjpGQZ/XAVo
         leFPl9rsio4OmjvNzAcYzJNsizbp9PGWZwMWAtGvtbtVn5M/vvsFGrCEUmGyBHv40kwg
         zyJeYcO5T+DEg1W7H7/I6d0B2Ju0/b1xDL1oN34UGbIGA0NrbqLg3jcVM83pgCc4GQOv
         ZX+gR11nvuCAM8yGBC8VqN39OxknbjgtBOx3ISQ7wDsTC2XkuamqIfblftZll+iEROtm
         lzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563032; x=1778167832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgFd9g2P7BVL3whbUa+ZHTFb4PctDl6068RwKx7qP1A=;
        b=ABMarnY1v4Gg6VHatYCkiAsE039KKb4sBjShVaSCiaAHEX0HQXmIX2kG8af5+G3pF3
         +sWu+rmwmRNJEH+hV6LoRtDO5vcDiZvsVmDp8aI/VVgxF+mN82YVum5v5innJ9N23FNt
         80SZyD7oBvHfHpv2i0rxVX2vSCxs2Wj5XSEIhe76jLI/y6/WoKNA2Yee6CoJa4gaWhHq
         v+jWtVxfWc0r+wGPUlCQCTT07vuQwzGlzwU03FShULcIiKvrtz6s+o9LfedLBOHX00cg
         NU4xj5v5xmE/swTntJXzm/blNGcmnXob3CUTFkRN+UrYUelPBhEk2NF0ArdzwV9PabWe
         wYmQ==
X-Gm-Message-State: AOJu0Yzn5XrR4Xpmw/ORIsAdXg3ln8BBDaU2L49VK4gmyaO6dLO+5T1y
	ebTyVlcW6fPxP+Y+7h+4acPY/m27NWGG56zrll6SqCgdaQBFlTtbgavbN6TrzagvVAJJQz6tjjt
	CsPs=
X-Gm-Gg: AeBDieuoS3eDMxGmH9S7j5GfoGcHhkd4i4FnIuj4/Ca4N0Yte6/fBnHpGrRp0MOmXUH
	3iwfRixMmp/XZcCyTTvQDDxBvpw/x+rEVOARnodzd+87jiLBH1+oCbYrAhl4wSJcEeTGGlasjVs
	8k6vGIBhnuX8BlZV/Pn5gd9fy3bhvnihHsPC0arJNL5F/Xvdbo7q1Q7nABYYaRgk0WX804ybACd
	noUO2x4/nWzZNuqOTwW9cfnAI4BR6peEPk49wvwBT3gA1H0Y6n7RNi/GOFIsPhvSVaFCGxN/1ku
	YdSe1hE5CZFhcK5hdFTPmo9ZoBQGHfD1jt4pAtCjxd8pmxf3/7rpDeDPAwnwRJ99RsW7/y9EaKA
	NAyouwLH5NExIJiMhjXRSAUClSjpwi5U/bs3FXfkb2g4H3wIqkpGomCB5IzxnQqQTaehXdNR656
	pHUTHMgfXo++s/aI5kUbAAHww=
X-Received: by 2002:a05:622a:4819:b0:50d:e1c8:5ed with SMTP id d75a77b69052e-5102ae41eb7mr49567061cf.52.1777563032083;
        Thu, 30 Apr 2026 08:30:32 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b398312sm876591cf.10.2026.04.30.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:30:31 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Victor Nogueria <victor@mojatatu.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	pctammela@mojatatu.com,
	ghandatmanas@gmail.com,
	rakshitawasthi17@gmail.com,
	security@kernel.org
Subject: [PATCH net 2/3] net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Thu, 30 Apr 2026 11:29:56 -0400
Message-Id: <20260430152957.194015-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430152957.194015-1-jhs@mojatatu.com>
References: <20260430152957.194015-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F2E84A4CFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282904-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,davemloft.net,kernel.org,google.com,redhat.com,resnulli.us,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Victor Nogueria <victor@mojatatu.com>

When sfb has children (eg qfq qdisc) whose peek() callback is
qdisc_peek_dequeued(), we could get a kernel panic. When the parent of such
qdiscs (eg illustrated in patch #3 as tbf) wants to retrieve an skb from
its child (sfb in this case), it will do the following:
 1a. do a peek() - and when sensing there's an skb the child can offer, then
     - the child in this case(sfb) calls its child's (qfq) peek.
        qfq does the right thing and will return the gso_skb queue packet.
        Note: if there wasnt a gso_skb entry then qfq will store it there.
 1b. invoke a dequeue() on the child (sfb). And herein lies the problem.
     - sfb will call the child's dequeue() which will essentially just
       try to grab something of qfq's queue.

[  127.594489][  T453] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[  127.594741][  T453] CPU: 2 UID: 0 PID: 453 Comm: ping Not tainted 7.1.0-rc1-00035-gac961974495b-dirty #793 PREEMPT(full)
[  127.595059][  T453] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  127.595254][  T453] RIP: 0010:qfq_dequeue+0x35c/0x1650 [sch_qfq]
[  127.595461][  T453] Code: 00 fc ff df 80 3c 02 00 0f 85 17 0e 00 00 4c 8d 73 48 48 89 9d b8 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 76 0c 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
[  127.596081][  T453] RSP: 0018:ffff88810e5af440 EFLAGS: 00010216
[  127.596337][  T453] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
[  127.596623][  T453] RDX: 0000000000000009 RSI: 0000001880000000 RDI: ffff888104fd82b0
[  127.596917][  T453] RBP: ffff888104fd8000 R08: ffff888104fd8280 R09: 1ffff110211893a3
[  127.597165][  T453] R10: 1ffff110211893a6 R11: 1ffff110211893a7 R12: 0000001880000000
[  127.597404][  T453] R13: ffff888104fd82b8 R14: 0000000000000048 R15: 0000000040000000
[  127.597644][  T453] FS:  00007fc380cbfc40(0000) GS:ffff88816f2a8000(0000) knlGS:0000000000000000
[  127.597956][  T453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  127.598160][  T453] CR2: 00005610aa9890a8 CR3: 000000010369e000 CR4: 0000000000750ef0
[  127.598390][  T453] PKRU: 55555554
[  127.598509][  T453] Call Trace:
[  127.598629][  T453]  <TASK>
[  127.598718][  T453]  ? mark_held_locks+0x40/0x70
[  127.598890][  T453]  ? srso_alias_return_thunk+0x5/0xfbef5
[  127.599053][  T453]  sfb_dequeue+0x88/0x4d0
[  127.599174][  T453]  ? ktime_get+0x137/0x230
[  127.599328][  T453]  ? srso_alias_return_thunk+0x5/0xfbef5
[  127.599480][  T453]  ? qdisc_peek_dequeued+0x7b/0x350 [sch_qfq]
[  127.599670][  T453]  ? srso_alias_return_thunk+0x5/0xfbef5
[  127.599831][  T453]  tbf_dequeue+0x6b1/0x1098 [sch_tbf]
[  127.599988][  T453]  __qdisc_run+0x169/0x1900

The right thing to do in #1b is to grab the skb off gso_skb queue.
This patchset fixes that issue by changing #1b to use qdisc_dequeue_peeked()
method instead.

Fixes: e13e02a3c68d ("net_sched: SFB flow scheduler")
Signed-off-by: Victor Nogueria <victor@mojatatu.com>
---
 net/sched/sch_sfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index bd5ef561030f..d3ee8e5479b3 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -441,7 +441,7 @@ static struct sk_buff *sfb_dequeue(struct Qdisc *sch)
 	struct Qdisc *child = q->qdisc;
 	struct sk_buff *skb;
 
-	skb = child->dequeue(q->qdisc);
+	skb = qdisc_dequeue_peeked(child);
 
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
-- 
2.34.1


