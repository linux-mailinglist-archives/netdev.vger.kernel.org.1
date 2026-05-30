Return-Path: <netdev+bounces-293316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACVnFLuaGmpA6AgAu9opvQ
	(envelope-from <netdev+bounces-293316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:07:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3289360BA6F
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 203D13026055
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A64337B97;
	Sat, 30 May 2026 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="D86K4oyo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1831E82F
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780128436; cv=none; b=jkXZjuh6N6O8xZazha+e1f+9wtbCcz0LyX47MVoulBQSOcKAwEljgH42k6VdiRmx7x5rQ85lCVfZu3TLoiL2qrhwd/qhYutnyClPl/Xy81Vnwmaqsm0Yvn1W8T6t+zCE4N/Og5e12BDcNkBlTJhF47PkB9Qy5E+3r1MkoCCI6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780128436; c=relaxed/simple;
	bh=2qE5SfjtudluT+vJSczPk8VNkRkjjDOplUDlxMAvwoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G3W/W0/Qu2KnVTCM8Y5DkZQqDVp3N3jtp+xSWJG4WjXjgIYJ604Jal0mjh20zMW/KYxVBkecdK6kUmZ1d7fF4F4jzAYZU5N8oT8kQHfrV/+l+x7Z02fXVCDtMpe1uHSLnBpZsr9Ty+BrfEmXGmIq2t/sowkNdEmW/MGpxZ2cZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=D86K4oyo; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccd2c0fa7aso29615586d6.0
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 01:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1780128434; x=1780733234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpTW9X8MQbPpzmAHbwM7ux5cK+dT6R9QeG3LgUlv7ro=;
        b=D86K4oyo5D/Evs7PKyOM9bYCqJfRqIupuoj834Jx3Aa8SY7I8Ryy4fXWdxsJ1DMrP6
         uQH0nRb5PnpnMA5c1tA4cee9HXVCaMRG2xSXHUjUBrQi4V+EDXsjDxIe1vaKf/GpjyDS
         fx0iRYeBFKyuALcbpd82Qf8z93yHEw//pEYBoWFAAZJNvfAcnXfYPjzg4IMAfGlM/vsb
         ugBzTCGpxwqQkkqCFV4w5nwgTfuftys7hlQ/QfKdwUsQ8a9rKDymk8cdWsfekOVEv1E7
         uY7zp0lYC+X3nRoyFOIzTlBwWc9f8smMt/RSvPpatA0YBLU1M/C2tOI/LLbO9mBXdoqc
         al0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780128434; x=1780733234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpTW9X8MQbPpzmAHbwM7ux5cK+dT6R9QeG3LgUlv7ro=;
        b=FhdM36uNM7uA0Fej18eMBqt0Lbo5XBUL4MmMspkGw71/DTX4sGa5yevyKwR9AfTiyj
         gm56+ig5IGRSSnOctqBWpXNNKkyvcgDu1GIjpsNTrKKixExACsXeHnQJmg9LzsDU70zq
         JqQLcQB/RDa/gKI1sYfF9dhtbSF8WprORqkeoRzLQA/r3vV5QBIomWh7xOjO6hnvtdug
         9QAXvkgR4cDXoaVnmc88k09DHTOJexw+pM4JwySvTHCtR95F/JaxinpDm5zCG7qaLB/3
         lf0vyQt72FL+PPRKSMLwol6uzal7Xwo7pMIizZZyA/R5fd61zi8yalffsJRSlkWmAGXp
         mKxA==
X-Gm-Message-State: AOJu0Yw1sXFyvZFVcKoC/vXcviFuccidD2SZ0lhRpoqqpCHlqaV+HVlF
	zF1T0w5OA2aHXP4bBQXVucfuHhij7yGniVs2O/oluRTyw2Y1swGsN43Vsftc0GzQ8PLKyJFahAq
	+YBrErg==
X-Gm-Gg: Acq92OGmbKcQ/o06I2MW/mT+ohdx6DBHi8nnDq1QzJFJ5MFxPDgC//2kSzqqWi/qp1h
	SZwlqcvambPpdcr/+FWzQPWybunsvaXzkdwr0WcytAC1p0oOGEoYgxVortNPCUksJLlbWyF/uvS
	wBArdUnWpRMLvbeaJJIYqZPlJqeHmq8NETCB82x0hJAJX1RxRETeD4EO23o/e7LkEix29+6swB6
	t+GivYdXjrpWlp8/uE944M+6IJWY0dsvNZfFZx8wrsLOX50A5XdhYUZ7MTBIS41TO6zHDzrvV0v
	cmSlf7AsEgYyVeF7yv1tzHCI2lYPvd94oo9PpG12flRzIrd+rq7YpVvkRqxdgD9n2XG+eYZTK7C
	KUxyzztUrwMyD4Rhdq4K3/6B4pmnidFZYov/h7hHX+MW1H4VkwE/kj2B4iGISkLwufByYM/02ln
	dyPPBA9bFoBtaptVqaCuzlR+SbNQU=
X-Received: by 2002:ad4:5c47:0:b0:8ca:25d3:bf41 with SMTP id 6a1803df08f44-8ccefd3391dmr51042066d6.8.1780128433667;
        Sat, 30 May 2026 01:07:13 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea231e12sm39696276d6.41.2026.05.30.01.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 01:07:12 -0700 (PDT)
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
Subject: [PATCH net v4 1/1] net/sched: fix pedit partial COW leading to page cache corruption
Date: Sat, 30 May 2026 04:06:43 -0400
Message-Id: <20260530080643.1345521-1-jhs@mojatatu.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293316-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:url,mojatatu.com:mid,mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3289360BA6F
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

Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
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
v3->v4
1) Restore the Fixes tag which was accidentally deleted in v3
2) Remove tcfp_off_max_hint as pointed by sashiko [1]
3) Fix a boundary condition identified by sashiko [1]
4) Add unaligned access support to safely access ptr support to compensate for
   removal of skb_header_pointer() / skb_store_bits() which handled it fine

[1]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260527181731.1166373-1-jhs%40mojatatu.com
---
 include/net/tc_act/tc_pedit.h |  1 -
 net/sched/act_pedit.c         | 72 ++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index f58ee15cd858..cb7b82f2cbc7 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -15,7 +15,6 @@ struct tcf_pedit_parms {
 	struct tc_pedit_key	*tcfp_keys;
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
 	int action;
-	u32 tcfp_off_max_hint;
 	unsigned char tcfp_nkeys;
 	unsigned char tcfp_flags;
 	struct rcu_head rcu;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2789..4e60793d184a 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -16,6 +16,8 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
+#include <linux/unaligned.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
@@ -242,7 +244,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		goto out_free_ex;
 	}
 
-	nparms->tcfp_off_max_hint = 0;
 	nparms->tcfp_flags = parm->flags;
 	nparms->tcfp_nkeys = parm->nkeys;
 
@@ -273,9 +274,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		 */
 		cur += (0xff & offmask) >> nparms->tcfp_keys[i].shift;
 
-		/* Each key touches 4 bytes starting from the computed offset */
-		nparms->tcfp_off_max_hint =
-			max(nparms->tcfp_off_max_hint, cur + 4);
 	}
 
 	p = to_pedit(*a);
@@ -318,15 +316,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)
 		call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
 }
 
-static bool offset_valid(struct sk_buff *skb, int offset)
+static bool offset_valid(struct sk_buff *skb, int offset, int len)
 {
-	if (offset > 0 && offset > skb->len)
+	if (offset < -(int)skb_headroom(skb))
 		return false;
 
-	if  (offset < 0 && -offset > skb_headroom(skb))
-		return false;
-
-	return true;
+	return offset <= (int)skb->len - len;
 }
 
 static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int header_type)
@@ -393,18 +388,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
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
 
@@ -412,10 +399,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	tkey_ex = parms->tcfp_keys_ex;
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int write_offset, write_len;
 		int offset = tkey->off;
 		int hoffset = 0;
-		u32 *ptr, hdata;
-		u32 val;
+		u32 cur_val, val;
+		u32 *ptr;
 		int rc;
 
 		if (tkey_ex) {
@@ -433,13 +421,15 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 
 		if (tkey->offmask) {
 			u8 *d, _d;
+			int at_offset;
 
-			if (!offset_valid(skb, hoffset + tkey->at)) {
+			if (check_add_overflow(hoffset, tkey->at, &at_offset) ||
+			    !offset_valid(skb, at_offset, sizeof(_d))) {
 				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
 						    hoffset + tkey->at);
 				goto bad;
 			}
-			d = skb_header_pointer(skb, hoffset + tkey->at,
+			d = skb_header_pointer(skb, at_offset,
 					       sizeof(_d), &_d);
 			if (!d)
 				goto bad;
@@ -451,31 +441,51 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
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
+		if (!offset_valid(skb, write_offset, sizeof(*ptr))) {
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
+							    write_offset + (int)sizeof(*ptr))))
+					goto bad;
+			}
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
+		cur_val = get_unaligned(ptr);
 		/* just do it, baby */
 		switch (cmd) {
 		case TCA_PEDIT_KEY_EX_CMD_SET:
 			val = tkey->val;
 			break;
 		case TCA_PEDIT_KEY_EX_CMD_ADD:
-			val = (*ptr + tkey->val) & ~tkey->mask;
+			val = (cur_val + tkey->val) & ~tkey->mask;
 			break;
 		default:
 			pr_info_ratelimited("tc action pedit bad command (%d)\n", cmd);
 			goto bad;
 		}
 
-		*ptr = ((*ptr & tkey->mask) ^ val);
-		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
+		put_unaligned((cur_val & tkey->mask) ^ val, ptr);
 	}
 
 	goto done;
-- 
2.34.1


