Return-Path: <netdev+bounces-291780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCbQEazEFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:05:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AAF5D946D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29C31300380D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A039C01E;
	Tue, 26 May 2026 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="xE8UlafW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A33998BE
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811162; cv=none; b=kWiYe9eD7XxSfAlnke48Wea2veqKYkoJ7p+DqBCouubHNaf6KdW6GAKMHy07sBBGAigsYV3Ik664PNF/CVvNJ+R+UdbmObJ4Ym1MWxL/6cqw2qJpMdVZss0aY4E4P+VhTBftcYRwzJ4YpmWQbEvXGpZDufoi9DLbM68k7JFjHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811162; c=relaxed/simple;
	bh=Dluq2Rs+5vVeLTQfXUj3g/gwAUzCpuoB4+dwHvPmJTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+sDqRf54bDR6sel9facmqbjRy1rzSstOzNOtH1E/LKVd9epeh7DhFFi1G2xIlsLnObOvDe1djf2x3GgCXvZV1ixj562lqYqXU8/8y7oFsk978Vi2zIZOtdaFccwzF+sHyF/ghAsttLffIm9hHoIMSZVDO7Hfph2+Hx2k28s5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=xE8UlafW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516d634956fso50796861cf.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779811159; x=1780415959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32IHWahZEAP3hoiT+rYy+Q30taja0WRr+TrxoxUOOZc=;
        b=xE8UlafWbe3gIUwaCIhzy+NcvuLwF1mqQgLSzKELON4jMUHCNvk1KXQgVyyA1241i+
         CtJZpGklFd+nLtsV2WX7cQqHE03Ji58rAU27mO8w4EExjUlnaIf+PtN0z54ON025zLE+
         sIDHpapv9VsE2wlp4jmDhEh7NmnZskkOyV89w0W+SXk8w3KKPCWbX+xqCRDOF62+3Q5T
         9O0RBo7uQ0npoZlSqOaH5q2/5IxlW9N2t9w/zUK57DSGcqZpOYVRuyuYLtdQWom53lmE
         BcFAH3OCeAj9ybYkxdlceWRe8XVRwMOOwysnQhh5fbcKdpqBBL/GdlDVqBbwMzS8av3P
         VR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779811159; x=1780415959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32IHWahZEAP3hoiT+rYy+Q30taja0WRr+TrxoxUOOZc=;
        b=YeO+HLjiN3lGd3cGAKb2Mv03mx8a74k21Hxtt4U+h9SNo+6SH8uNC/W78LP5HfWDb5
         qupQ17b51Xv08UtEvR/Y7qidjdcLsFI6czgApzcFBcTUUlZ8Vxa38L50XtunssVJNDYi
         S25sJC3ko3nH+9Hgg1ECl+V6m2C0/qHTyYzrHXpBF2f2FgJtVcfPftOTqJpi7zE0qHC6
         CyaYXgo65arpd8OJdw4CAZfzBhPGE0GQeCtw49EwJEO+3kcgf90CPtGVIeBznR/YA0oD
         gwhA6Ds+spguNBRVqISYvi4Rte2y+IhkzimmsV4BLYZADYJpQaBr0CSZFOPrs2/Hjojv
         UeoQ==
X-Gm-Message-State: AOJu0YxPShQoYbhZuv2JEMVR3CenLg1Wdfwwz6YzeO5uCIaIrqC202bQ
	2sajM2B39T5uhPcMCAxunnEUdMJ9rVPxm24/NHw4i4omI48gSH5NAndIZtmPnCt2YINpLsNhbOJ
	MPDk39g==
X-Gm-Gg: Acq92OEuAdFeD605MuTcv5ZinQgbzHqSfdz07mZv7NFBkm1Y5z7tGYam3DSY4gdU3Ef
	L6M7735lKDpE3/mqe8vJ3WzQyEwkvDbDQWxlI/Vw3uQ76U6IbcPZscV0p1xSZI2/IcYgPr5uL3+
	UoGIpcKzTYWAgGayrIARpo/v7YO1ObFc2snabu2acLthe9LSlvHh1pdmrliHwsyV78jX3jMGAD2
	8zNG4A1MSvenXMt3KhOVkMyOmGSU4fJv4sPUCTBifJ14rQwWkuzlE+wX9Ubmf+IKh+S5ZGXEzdH
	Ow9FCvjFVhdGdjBgDzDXEmJbao9wC0BpSkWo4gN/vO+QFveBowUReUDTFBlSQcNVFJtPCIYi7tj
	vzESS5d4YTgTg0+AoKWfcLTJZsaHhPgmQDwcxzhTe5xk8mp6mYNCYUe6ST9tLayZSgSfFSt5GrM
	4m0rt9NLFnpMGw8uIFPAqTZFRQs+2UpWOza3RxIOug4TcrDhH3lWZJEy3BN7wP7DnDNuLNboByH
	9QoggFgNkapF/7tDyUw
X-Received: by 2002:a05:622a:11:b0:516:e569:d3f5 with SMTP id d75a77b69052e-516e569d943mr172627881cf.15.1779811158459;
        Tue, 26 May 2026 08:59:18 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b081c7sm21645681cf.28.2026.05.26.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:59:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	david.laight.linux@gmail.com,
	yimingqian591@gmail.com,
	keenanat2000@gmail.com,
	2045gemini@gmail.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	dcaratti@redhat.com,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to page cache corruption
Date: Tue, 26 May 2026 11:59:13 -0400
Message-Id: <20260526155913.1060694-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-291780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,vger.kernel.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: C3AAF5D946D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

tcf_pedit_act() computes the COW range for skb_ensure_writable()
once before the key loop using tcfp_off_max_hint, but the hint does
not account for the runtime header offset added by typed keys. This
can leave part of the write region un-COW'd.

Fix by moving skb_ensure_writable() inside the per-key loop where
the actual write offset is known, and add overflow checking on the
offset arithmetic. For negative offsets (e.g. Ethernet header edits
at ingress), use skb_cow() to COW the headroom instead. Guard
offset_valid() against INT_MIN, where negation is undefined.

Additionally, linearize skbs with shared frags upfront to prevent
silent data corruption when pedit operates on zero-copy pages
(e.g. from sendfile).

Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Reported-by: Han Guidong <2045gemini@gmail.com>
Reported-by: Zhang Cen <rollkingzzc@gmail.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
---
Changes v1->v2:
 1. Do better boundary analysis to cover cloned skbs with frags. Pointed
    out by sashiko-nipa:
    https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519033950.2037-1-rajat.gupta%40oss.qualcomm.com
 2. As a result of fix #1 remove the skb_has_shared_frag() check, unnecessary.
    Also Jakub has plans where the shared frags is not going to be a "thing"
 3. Make small adjustments everywhere for integer checks, suggested by D. Laight
 4. Remove all reviewers and testers since this is a large enough change.
    Please retest and re-review.
 5. Remove Rajat as reporter since he is the author (which implies he is a reporter)
---
 net/sched/act_pedit.c | 49 ++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2789..719bee335e1f 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -16,6 +16,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
@@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, int offset)
 	if (offset > 0 && offset > skb->len)
 		return false;
 
-	if  (offset < 0 && -offset > skb_headroom(skb))
+	if (offset < 0 && offset < -(int)skb_headroom(skb))
 		return false;
 
 	return true;
@@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
 	struct tc_pedit_key *tkey;
-	u32 max_offset;
 	int i;
 
 	parms = rcu_dereference_bh(p->parms);
 
-	max_offset = (skb_transport_header_was_set(skb) ?
-		      skb_transport_offset(skb) :
-		      skb_network_offset(skb)) +
-		     parms->tcfp_off_max_hint;
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
-		goto done;
-
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
@@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	tkey_ex = parms->tcfp_keys_ex;
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int write_offset, write_len;
 		int offset = tkey->off;
 		int hoffset = 0;
-		u32 *ptr, hdata;
+		u32 *ptr;
 		u32 val;
 		int rc;
 
@@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 			}
 		}
 
-		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
+		if (unlikely(check_add_overflow(hoffset, offset,
+						&write_offset))) {
+			pr_info_ratelimited("tc action pedit offset overflow\n");
 			goto bad;
 		}
 
-		ptr = skb_header_pointer(skb, hoffset + offset,
-					 sizeof(hdata), &hdata);
-		if (!ptr)
+		if (!offset_valid(skb, write_offset)) {
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
+					    write_offset);
 			goto bad;
+		}
+
+		if (write_offset < 0) {
+			if (skb_cow(skb, -write_offset))
+				goto bad;
+			if (write_offset + (int)sizeof(*ptr) > 0) {
+				if (skb_ensure_writable(skb,
+							min(skb->len,
+							    write_offset + sizeof(*ptr))))
+					goto bad;
+			}
+		} else {
+			if (unlikely(check_add_overflow(write_offset,
+							(int)sizeof(*ptr),
+							&write_len)))
+				goto bad;
+			if (skb_ensure_writable(skb, min_t(int, skb->len,
+							   write_len)))
+				goto bad;
+		}
+
+		ptr = (u32 *)(skb->data + write_offset);
 		/* just do it, baby */
 		switch (cmd) {
 		case TCA_PEDIT_KEY_EX_CMD_SET:
@@ -474,8 +491,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 		}
 
 		*ptr = ((*ptr & tkey->mask) ^ val);
-		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
 	}
 
 	goto done;
-- 
2.34.1


