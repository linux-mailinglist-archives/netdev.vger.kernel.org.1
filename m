Return-Path: <netdev+bounces-281186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DcmIlZj7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:11:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA246ADE7
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DB603026ABB
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7837C0F0;
	Sun, 26 Apr 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="UPBDDlV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304BC37C90D
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230575; cv=none; b=Piz+X8E0FLduljzJOGD/QpK6ENJp2bkTqJ/If6sgZPphjdGuWa1Tl4XKePvAZm+kdvjxA538V0eMkR48iMijdBrpjFx0w+RHnXPYGVJPxkxtjSqPsKeeY+NDrlqT9gRodfwGiBnD0ZkEUCm9pcbqyEkF1pydolEVGwwjxd01y3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230575; c=relaxed/simple;
	bh=risRwGODlwPwRxtbS2k8XKBSTI1LAfyCvlm4nAI7HOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKxT/NygPWjk2VZsYsQCzuQIuPx5dJuoW/rlU6/CCMxtXYuOhS/uyv9TeNKeW6goeSk3arRtTbeiPE9b6IialQkByUXENbhdff6O2sgHNeVuLU5U3sCByXAsWY5QpkT6ucTL+2EDlpqK4HeYU68ncuo9QFzymeUDpiJIdP9Ys6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=UPBDDlV+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a068db9989so98310266d6.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230572; x=1777835372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQT3Tn3DwJs5X0uJ/zSX0U88QCXnUZLQtXZBp9F7dpY=;
        b=UPBDDlV+cUWxGXf08MOk43sv7xabkGS4mkto55IUQiYE4eHUC9TtGicPZXcyyYryIf
         ux45/Bvhqp5SEoywpoBQXiKpm9y5BzwCLBcE23WbdIJuzZu+bvEN3otcYugMDPD2OHPS
         dOJs2F2a5yZmXVac9vYS65U47064HRqIlchb3ac55kbeXP6eIWLtcwP+c/svf3yeAusY
         itk+yJo8mo4JtX37OsWSJJW/TtzHaWcoj6Hqi01XOin1pjBKyPr28UChF/2gwQFQDoKh
         DdtacrV+RSjzjtPlJSJXGH8x0JRCRUyxSm7VA6pBKpP4IFfmZYUzhiAjtZgfFZQqEpbT
         IwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230572; x=1777835372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQT3Tn3DwJs5X0uJ/zSX0U88QCXnUZLQtXZBp9F7dpY=;
        b=heC9FIu+5vQcXnuJaPut/pP690TV26dHpxeh/S64WnQA10T+rZclIfDRFtCHrFE7sX
         H4qB92ewsMkPghlvft9NhmlDF51bdlsvQBx9olvQv5eG23MC0cEucmQ2gSQGhgNitZEO
         RgwJhmVfI/gMdde0UVkW+Ofp4LKuJS1IgAAHsPeZu5l6k+SdyPKdTqqGHm7RmkL8EU3G
         jPlJ8ILBTFOPI18xkifz2+9rZJ67MwVALR0AOuS2rXPcmvj5mfGSvOjGR1MF+fiHS0fH
         DCpM/JzKlZQwYrgpmaEfbYippLyv/IMTAzLpUwlmXcyAAtleoq0HuhC/CPDaLGo3L3ZC
         OHRA==
X-Gm-Message-State: AOJu0YwVMTCz+6km/Eii1j3szepRQfk3uJNL0nbbsL9O4bhqGoB6qHMw
	LFtq8p22ZIKoDqdUIoR1iMpc6Ir8pJKkbo6NG30p2KgpDYGW3GQEbO4UN9H/xxisV6kqMyW8cAU
	4a70=
X-Gm-Gg: AeBDievD1qLWW/eU3GLMjUa3HoPceNpuKtx6j0PK3twP9+NFll8N9Xy+ZxqCDDy07m2
	JViKfgiZgeVaX2eeZIbUvVvMs7C3mApkr7AlAx4mXhbVCPXJnkgYBhBGr6cBieqCL2c82ZTX8fm
	S8Osdrvmn+na1Jo0Hnu49q8TFru0vqsGgyS1mqrX931EMRdPJ8AIn+Z+O4oAi5qnOSKMGeSiu8e
	AHSSS71DcFPD/tzcyPD3d3N+f+LAUkC7fTJN/qKdr5d9ECRWfJYbsJWhl+L2isqR2gooNFxj/bO
	0N+4Ey5laq3VRE//vWwrB3cnFG3UX5LUMShjUREshH6bgE2oa4iJ8tWSPIMq+krgK/8QMahXGXM
	Xdsc+WcbyqzN9+bZc6wkLP8O72IWT3F9CrFmvoUnDApj2jk80S2ag8+smC1jEr0HErPR/M9YmIS
	sc1Dam+UTh0WCTRbXE0mU3qWvr2OyA1YUYFyd/wcYwT8W20hU+jBBe8RQXHnPIkJVdkTO7JSfny
	6znCHaH9XLsS1vhQuqRL3iztmFSbmw=
X-Received: by 2002:ad4:4ee9:0:b0:89c:8a3c:e34f with SMTP id 6a1803df08f44-8b0286f9e44mr510419606d6.12.1777230572518;
        Sun, 26 Apr 2026 12:09:32 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:31 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 6/9] net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow
Date: Sun, 26 Apr 2026 15:09:13 -0400
Message-Id: <20260426190916.128489-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426190916.128489-1-jhs@mojatatu.com>
References: <20260426190916.128489-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3EA246ADE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281186-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim]

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
Tested-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/sched/act_mirred.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index dd5e7ea7ef26..ea64faf7f469 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -453,8 +453,12 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	tcf_action_update_bstats(&m->common, skb);
 
 	blockid = READ_ONCE(m->tcfm_blockid);
-	if (blockid)
-		return tcf_blockcast(skb, m, blockid, res, retval);
+	if (blockid) {
+		xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = NULL;
+		retval = tcf_blockcast(skb, m, blockid, res, retval);
+		xmit->sched_mirred_nest--;
+		return retval;
+	}
 
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
-- 
2.34.1


