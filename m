Return-Path: <netdev+bounces-275669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wONaENTt02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:31:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0543A5B51
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6106301DBB1
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11719390980;
	Mon,  6 Apr 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="FiXoI6nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF1390222
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496439; cv=none; b=mBbLAr2rYRZNxAzxO8E2yTwvcilS6T7hVNH9uGjge/abYQwRDeSLDn3DkrZ7dJBMaCDVZdgg+/6AZ0Vlts8YvRWvrutIaoMyBXx3siLIiOy7duYPBKGoBXPVxgA9e3FmdrFdipf/M7VQVonGy5nh4ErpBqpkzXQbfzGxqBi7RWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496439; c=relaxed/simple;
	bh=UMQJelaESrnRDZL8PO4QRgAZzcPl/5e48Jg6H+CQ59w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnV2w3DSKTTXwolz+x4jzrN5XiVN/8tT1u77CW5GceEnkCDorhKTmVRTTbuBAt2zGobMvaVsNGAR1YHOSUC+q2V0IwqK6azh7nQRLvcwQ5hrOeCAMf/Ebci2/zK2Fx/T0NE1CacROkW2BBuZGRPMSSHoi4JS6K1AaUXPdi1jLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=FiXoI6nn; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1199452a12.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496437; x=1776101237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWolUof2Pu6ZTaPL7Za7frQru9ToMhBGz4ztPq2c1y4=;
        b=FiXoI6nnzDtf0BoLzjLHIZi/NHG4ip2pIO6e1dGAnMj5//kIpITsBgtMavg5Jwaj89
         aBfvPd473HCLC63hwHHq4jlCRO0YXxr9ZpJ6UOfZXN66wPqbepK4zHG8WSUXKfKJtJCk
         fEwsA6RXpNyj1zdAW/wgmYEy4WmjFebcOY2vx6NcvXNXyOAKQMZ5F6ynTFGrWZubJyTv
         QwUHYW3dEIvociSiy0T9jxJJgMwBEG9N6++DJqJ4DNHkm8WNbHaGjHtdcSvV0zhDXP8H
         aV3lBXfeDhMvOK/YwFblDl5dUx6SLN5dg8uEx5zWsNV8d3njrRmpNxjjUsudvOsAGosv
         Yg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496437; x=1776101237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWolUof2Pu6ZTaPL7Za7frQru9ToMhBGz4ztPq2c1y4=;
        b=CLI+aypqhf2mocx4b6cduzx18VR3D5JU3wnp47yC6n4NQvO/HfNXHYVJT+BtaUUhhM
         QKH5GjbhwXRtOkCW+LZrK8vddqADFZ5EQwm0HNgpmyySXGXbzUDJdr65WafZmZ1d7w8t
         Z2uNvjGBiQldfVJKHwCJlPaEf8a64LShBGtXMCrrd8Mhzqiqskx88/xqu9UWkIYl7+Vt
         UWljgkzRpGS6kXa8e47S9x8RAWu4E/vcpqLH2embx8h9oz1rP0uVtMFumn228xBJJvE7
         qlAMk2RZgCbHR6BzP0zWyefVKjroQadBjfkygOQWv6bCpGE6zwJjCHGNlloXybgTrl7S
         5xBg==
X-Gm-Message-State: AOJu0Yx8lrXUdqIK/STxeBbmzlj1Itxmlh5wBucPiRlzmM0zEQCJ8ALk
	mbsAgkHLNeDuV/jnh/2I1LbQ/BSEJ+LRIRtAg36peCbnF8SeJOKYTaXLo+iHsxsIJBXKM3lsYRX
	41R4M
X-Gm-Gg: AeBDiesTOp8SgQRZ+6mOE5fmG8QMnYLopqZtSZ+jjmlfsTsEuWArbkhM8tdSePbB3lc
	HULWubxRCTfTzuRGDSEZmVrx44Pf8OsJxELWdXkYNZ/MIYYXkwNvd5nMQlUuVItgaEyWKvjcw1d
	eSFFqaSRjPT2ppao8Y2yFCNP5E/XDCzFAyWPAD+dURoLQoscmns+h/0y7AKth/uN9RnIG+zJGHv
	U9064YbcDcu06RD0l1wTa/dALuvwpTxCSAz9MOApK5xOkaCkl2HXSF2XrZ2tDKHhBUEK49vGGe3
	7MsO+ufSqISQu8jcI+dE7IBoR1rByFGS/PZAZMDysm5hfGMmNYcE/hfwfr4BSF7IrNglVnvziUt
	ZNxttBZcS9OABIxetntDBy/fpe+PQwH5Pg49Hh9Y9kbUTziLkg0OasHBr1NYdvS+vP4JHG83w/B
	2K9Vw71Qyawf1x0XRwbcSc1uik45WT0GRQRdEwSZ2XSwA=
X-Received: by 2002:a17:902:e790:b0:2ae:606b:bd98 with SMTP id d9443c01a7336-2b28176a77cmr145265855ad.26.1775496437219;
        Mon, 06 Apr 2026 10:27:17 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:27:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yousuk Seung <ysseung@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 7/8] net/sched: netem: check for invalid slot range
Date: Mon,  6 Apr 2026 10:25:15 -0700
Message-ID: <20260406172627.210894-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-1-stephen@networkplumber.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-275669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9C0543A5B51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject slot configuration where min_delay exceeds max_delay.
The delay range computation in get_slot_next() underflows in
this case, producing bogus results.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e405bf862163..c82f76af41aa 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -883,6 +883,18 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 	return 0;
 }
 
+static int validate_slot(const struct nlattr *attr,
+			 struct netlink_ext_ack *extack)
+{
+	const struct tc_netem_slot *c = nla_data(attr);
+
+	if (c->min_delay > c->max_delay) {
+		NL_SET_ERR_MSG(extack, "slot min delay greater than max delay");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static void get_slot(struct netem_sched_data *q, const struct nlattr *attr)
 {
 	const struct tc_netem_slot *c = nla_data(attr);
@@ -1096,6 +1108,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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


