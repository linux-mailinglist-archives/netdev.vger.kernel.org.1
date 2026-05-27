Return-Path: <netdev+bounces-292421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPzpLKA3F2os9gcAu9opvQ
	(envelope-from <netdev+bounces-292421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:27:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E895E9011
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C773306BE90
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB48477E55;
	Wed, 27 May 2026 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="DzjZr6Wp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BA390986
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905869; cv=none; b=h9N/xWNXp2Ivj/l9oOQe1OKExp2IwmGlYFwJ21kxY97fjDVoHQOGDaxo7ajtjrSzVW7tDz/yWbSsut/BmLkB2cDRN2MMetiVt+YZwKecK6VDMF/8XOMb9TIJH+QEVABJ4ByxYp6Sh2Dcfk/Hhy3da8fF2kZGiD634CrmAQhLNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905869; c=relaxed/simple;
	bh=vOA4SCBrfVNOJ6I2IiPy9VxJLXSn+1QQW8326AXjBtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eZUTH+sMyiQy9hB3Pq6YYOX2vBuyDRr/2axArpvdxIDLKLH4XoaqkUc70+eybdO/e+eHX46W2Ipyvavv34x3O8Y7Qty+8eKTQipXmqj50FbE7C3imI0u9ahKYlVzeMFrwC88PiNnl1O+B1MfzB+W6EiJXAU5WRh+i5GX6gJfNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=DzjZr6Wp; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914ad42e617so689055785a.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779905867; x=1780510667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRp8lOATeymHgVcnK18CXFrSaMk7TrNuPURoW1D6fvY=;
        b=DzjZr6Wp8iIV/tDEVUToaXmLfDOsWhvEssxaV4lO8cF0dK3uxbir3UnKCoeSZIpqNS
         eP5c8XTxOTrPi0pXWoQxwAZ4O+NGH0NMf44PqvYgvyWSu1v0p3nIS4Gl+US/QwpZjKC7
         F1pcutLJM60pzTDoJlgCsMWwaa+xX8edhgpl99Nb+XpPIo2BrJyyMw3seXc7crTKlP6G
         3St+UKIJ7PDJQZ2GQrjQW6GAv3SPY2o2zyjEnQ+ocA0XabX4OGMaXbURGHDuxxF+GIY/
         XZ4PTrfSmk3jaM8tuuJ4ZIWdd9Pf5veYsu7n9erqRgzo9lB2bL8Wv+eGqeZ1tHX+RuXv
         xvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905867; x=1780510667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRp8lOATeymHgVcnK18CXFrSaMk7TrNuPURoW1D6fvY=;
        b=n9BkzeFCvnJYuQB4z3B15hTUI79Mp7syzajXjIE91mrCr8lksmBB1yzrDUW6lkOTWy
         po5p4JM/CqGJZ2a9khUPpaTmm/DtX8D4EgLAwSOGaD3WnypOYlxygwpcoofAquEu1Km9
         n+AlOM1y82gZTuFKmBpWLh4LGmY1qbp0oVvqdWMExM02l9NrAvVqqhKOa1R2+pWuRmL+
         snH1ReK94eM2SVqd99bR98FyIFuoQqvrMVYB7QnpOxE48NYB6VsCSzK2K82RtDTEyQzt
         4EzT3/0oxYAbRjKNgRYwdLlC0LlSjc7yd7Js6PhugC3aUO1QH+wRzDr0VhTxXd4nxdz9
         KpUQ==
X-Gm-Message-State: AOJu0YyrSBTK4eJi2unjDm57kWS2E/m76OWjnys8d88SIq+V4iO4eEwy
	diz44Wl5jeHlpjGyweSwKb9AYYh613FiOuYOfMF58BRTsTgBtrqjogU1h3fdcvY9YigAfQ7iiKx
	pEfjisg==
X-Gm-Gg: Acq92OHFj+5p24iyy9oaCsrmz+0ALTm67otwuUQQof911INsnVDMBompmdJScm+FZX9
	vXalwqrlfvlJG22F7rZ5IxQgT8lWMELJyk8McIDGDRcR/yLL4LNCq5lITfiTHRt1fk9klh11oLJ
	nA4Tu5kIf/CEM2n3uy4ujDOrHgC+Gv3Mtrg3zhfxjtazB/4gleUZyqGbBucs2+69xqlOs64nN2j
	1Dz1wSdOd97XyPomEBJZnXapBeA66xjxjCkSzYbVfHgH5RobUmJlRsNWgUg1Z4xeq7d3DfmS7v3
	BiN/NQzerdUysMOP0+BSbjhdRNgOauxhgPRIzF1Xg+NOH5w2qonE5O8lR820MUVfdMqtET6NzT+
	b2ZXEAbdbGmXY026P31WHpqdqWfuO+x++LWoxAJuupAWJQDdIKtZqZAyEoFFMaU6LoDqnsl41j+
	/SRWgFZSVm+8VQoYXypaIceNoq8cE=
X-Received: by 2002:a05:620a:2914:b0:914:c226:ecbb with SMTP id af79cd13be357-914c226f8d5mr2854794385a.23.1779905866932;
        Wed, 27 May 2026 11:17:46 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9150af8487dsm191688185a.3.2026.05.27.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:17:46 -0700 (PDT)
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
Subject: [PATCH net v3 1/1] net/sched: fix pedit partial COW leading to page cache corruption
Date: Wed, 27 May 2026 14:17:31 -0400
Message-Id: <20260527181731.1166373-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,vger.kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,mojatatu.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 50E895E9011
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

Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Reported-by: Han Guidong <2045gemini@gmail.com>
Reported-by: Zhang Cen <rollkingzzc@gmail.com>
Reviewed-by: Han Guidong <2045gemini@gmail.com>
Tested-by: Han Guidong <2045gemini@gmail.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
---
Changes v2->v3:
1) Fixup commit log not to talk about linearize
2) Add more optimal boundary checks (Toke & David L.)
3) Fixup if statement for readability (Toke)
---
 net/sched/act_pedit.c | 45 +++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2789..e01865af8ca0 100644
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
 
@@ -451,15 +445,34 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 			}
 		}
 
-		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
+		if (check_add_overflow(hoffset, offset, &write_offset)) {
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
+			if (write_offset + (int)sizeof(*ptr) > 0 &&
+			    skb_ensure_writable(skb, min(skb->len,
+							 write_offset + sizeof(*ptr))))
+				goto bad;
+		} else {
+			if (check_add_overflow(write_offset, (int)sizeof(*ptr),
+					       &write_len))
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
@@ -474,8 +487,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 		}
 
 		*ptr = ((*ptr & tkey->mask) ^ val);
-		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
 	}
 
 	goto done;
-- 
2.34.1


