Return-Path: <netdev+bounces-279456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AoGMy754mneAwEAu9opvQ
	(envelope-from <netdev+bounces-279456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34241FD68
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A2930C4FF3
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907062882B4;
	Sat, 18 Apr 2026 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="UM7UZ+1J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7E31A07B
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776482442; cv=none; b=K9d6p29OAoqFGGNyUKFeOCKATIK8Dh7e1r2yPB91UA6F0lmLOiN+90kmrr1dV/V+Blko1GX0u38ClavodWZZmPoDfFNhoUv+ehCP9GtdVAQ8++VA+QzG2/M3WaPHHrHdRRKs0KHoRSeuajdk3/IaRVUZTbbEdFTbccAHhPKsbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776482442; c=relaxed/simple;
	bh=L4IBni/J1iajRAIevL395+KxOmd1e362KmQQYLHRdHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtdHsaV62bA3EOifFOu8hZjuhfgohGXRVl3CiD2SVMcg0qr6Te3czq2iieCwkenFv8Vse03MJZ8cDlBlFXyAon7TH3s2/DyxT6T9o4NR8f254rPcvn69Y3V2IfLYZChgSPihJSCV/HiNbd4kY44SRcSD5L9sedUOCdLKu2Ob5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=UM7UZ+1J; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbf23885dfso868271a34.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776482438; x=1777087238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALXfeG2ZYmCvF5Bsh1WPSjdngqxQrMfwjxGPrrqyViw=;
        b=UM7UZ+1Jvkv9iqdpSazAVqB64pkldmw9w50eJx91auvTMMtsmSlEGPLLtllS6EROzu
         dngOkWUCSHxAJgcNAapXm+JTpBCZJ2LCjk59D754gHjhmLqtiCqGzG108Qa3RADcbzmY
         qBV6Zf8thLxLMK7Kbw4Csixtc9On3AxDALSF0ggd4o3IwceXitIPLVnl7/0SpRer+4t7
         kVkyogq6b5veFiClv9btDOOEM5YDNPCnz7mZFCC6q2vqDJPY5G5zyHJyOnUv4Fjmi+Wn
         J69va+j4Se5+i2mcodV6ikVDkpAmvVw8ZkowH/8GjjsmtlDxh7LVg2mMPtcEV2vKXg6b
         e3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776482438; x=1777087238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALXfeG2ZYmCvF5Bsh1WPSjdngqxQrMfwjxGPrrqyViw=;
        b=n30iVil9bS5b0838Xijnf6U7qztv0QtzijtH/0zRyavITbTmox3mkpijm+6SYHG85v
         x7ToNGy3CXjzsLB2sIurAiYPd4hP1grpPwlXWlQdPnL69KaLWphoFUit3G0t1Pc7tJ4Z
         W7bjlrFpn7LxdPzxvDx/FHjeQeOe/xFpzAoF+Iv03QhpZ8VQVx/tiDZ9AW3PWhSIAQ2O
         s/snmCAgqRCrgZJHR+DEhr3FBuMWMVuv0TINbvCf2TLa6HdQqIqatfzbkeuQYXP6Agpb
         +homlu0G1NvOh1JxMJES5ubJAg28ZLsGx+5GAlvsFeIgYn6upIn5F9M330XjSFkjFv8f
         Icow==
X-Gm-Message-State: AOJu0YxaNI87A6GL5OmlKuz/inKjYPX8u71e3uXnYbcRFo27RJtqxBsM
	XD1TpH318pLeNu5MbjlGb/vPxvFYyaoW156becN12qGmTiZ5BEMCmp+meevuGn9jzrWo/17H8Gk
	aTgg6
X-Gm-Gg: AeBDietD0qJxcX/nCPH9VkPG3Z+tluh/j6LViAZu68+6AH4dqN/JOJTzthOvOxCd+4X
	XXLxOgpZkq0KI/483kPKB78KSdlGwb2PU1XIBOYaqFuiF2Ni/Iut+oFLE4GLgJa4hmmqWirZnS5
	V56dJaW38SRoKwu4QtrcRHQKO/NhFFMaa3Fsx4P32m/G9qOcVTOGb53tehlZH0LwZxzitHraA2F
	7/3Wbco4G3oXJTlCJM6s2GvutvV1p+KNACjkTjoeMIB7XBetNl7KwMXCRNIKLG0THXjicUKe3qI
	eWLyEYKlVX+S0zGlMq/AKdywZPqPf943iFS6CH6VA8csL40e+NxGCklM5sn1rD5c3f3/JsBmrv+
	WWu0rH4yoLmNK0X71lBOcyHcNzEyqJocTErL4tLYLoJbm8WEbEZ0plM67I8UipBHEuMt05Mc+hj
	6mcJXM9Ah4UCRg+klmqv9bRGm6dLfI0t/Z89e42IaqurY=
X-Received: by 2002:a05:6830:730e:b0:7d7:fac4:e359 with SMTP id 46e09a7af769-7dc95271248mr3595182a34.27.1776482438240;
        Fri, 17 Apr 2026 20:20:38 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dca7b6b5bdsm276902a34.5.2026.04.17.20.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 20:20:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	horms@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dave Taht <dave.taht@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v8 4/6] net/sched: netem: validate slot configuration
Date: Fri, 17 Apr 2026 20:19:42 -0700
Message-ID: <20260418032027.900913-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418032027.900913-1-stephen@networkplumber.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279456-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,mojatatu.com,kernel.org,networkplumber.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: DE34241FD68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject slot configurations that have no defensible meaning:

  - negative min_delay or max_delay
  - min_delay greater than max_delay
  - negative dist_delay or dist_jitter
  - negative max_packets or max_bytes

Negative or out-of-order delays underflow in get_slot_next(),
producing garbage intervals. Negative limits trip the per-slot
accounting (packets_left/bytes_left <= 0) on the first packet of
every slot, defeating the rate-limiting half of the slot feature.

Note that dist_jitter has been silently coerced to its absolute
value by get_slot() since the feature was introduced; rejecting
negatives here converts that silent coercion into -EINVAL. The
abs() can be removed in a follow-up.

Fixes: 836af83b54e3 ("netem: support delivering packets in delayed time slots")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 556f9747f0e7..640b51be807a 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -827,6 +827,29 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 	return 0;
 }
 
+static int validate_slot(const struct nlattr *attr, struct netlink_ext_ack *extack)
+{
+	const struct tc_netem_slot *c = nla_data(attr);
+
+	if (c->min_delay < 0 || c->max_delay < 0) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "negative slot delay");
+		return -EINVAL;
+	}
+	if (c->min_delay > c->max_delay) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "slot min delay greater than max delay");
+		return -EINVAL;
+	}
+	if (c->dist_delay < 0 || c->dist_jitter < 0) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "negative dist delay");
+		return -EINVAL;
+	}
+	if (c->max_packets < 0 || c->max_bytes < 0) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "negative slot limit");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static void get_slot(struct netem_sched_data *q, const struct nlattr *attr)
 {
 	const struct tc_netem_slot *c = nla_data(attr);
@@ -1040,6 +1063,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			goto table_free;
 	}
 
+	if (tb[TCA_NETEM_SLOT]) {
+		ret = validate_slot(tb[TCA_NETEM_SLOT], extack);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
-- 
2.53.0


