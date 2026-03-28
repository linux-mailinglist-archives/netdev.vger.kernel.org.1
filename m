Return-Path: <netdev+bounces-272798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN8yHJodyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:27:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B434F922
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6CA5300CA01
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9FA3A7589;
	Sat, 28 Mar 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hxueME8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A23A6B7C
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722431; cv=none; b=NwUJnd9GDsTE4zpSSOzLfyH6F3y9SEp0Pgp2g+9SqnVcGBoKK+QX30CqpzZmFqUoCNLBWCjjRu+54aPhc5+tZtzePjaG1cwJd3ZeR6tZb5GVw94s5erlO+aEtfKfeMyFbacTR5WOjVjONNklZc/vaT/42UMhG722bHIZ5IlDJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722431; c=relaxed/simple;
	bh=IMlgHod5XNtzqRgvamgEbgBmHZXu09+o3dzVC2caZS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A88m1hFIKDeYTGottscFuJrr1kTORaEfYR3Ee7ReH7pNYOZJSUzcPfgESYRFjjsV7lM0lZkHEimaWdbdxCtpHZTouT6CmPWxivBFiXRQV0Zw1zKsB15AHxURe8qhYs73jkkYfIXXDpgzllbgMnb7HfLTc9hbiVu+MeKXK50kkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hxueME8h; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4b77adso4474524c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722430; x=1775327230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW5wDrj91rUi5skYQJuZdC2c3AtpzF2Z2lldlpB4yjY=;
        b=hxueME8hlwan9x59H/a4uhfg+Kv9nLFmvmeDVSqCW7DKJQ8e25uOQQPCU/Qb1t1f4P
         6im8sPsQQ0LXNeOKhJlwEFMUhEMKToipOyh3JTXmEWbG+hMLByij85WMjgRhySGrThJn
         wGj3/0cnyVKe8M5crgNTK8U1NxjDHozKkYgVKibrjNY2/F7E2laa2TbF28YdZH/1zerc
         FUOhET1XUVq4praauxvRvuTGZeSmY8ycz8wuSyhOlbCdrfZ7ORuLToIuSoA98W0FdKYu
         eL4mwkkdYI/lQt+FrGLaUU8x217vQJTXWD66PZHjhu+fx1SyeHysvpy0SJBfXdJvJ4or
         gLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722430; x=1775327230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VW5wDrj91rUi5skYQJuZdC2c3AtpzF2Z2lldlpB4yjY=;
        b=WCeDziBpB3zdCkjT+vC0q/DaMhsh5gfkGfZOF/whxWrQcxHWnQaaacjyN+JiA9DwzB
         SPilYNrttUCT0/+2PEMp+xptMqvGrtMLcaPIN7atYjUN6cjN9tXymp2YJlXBEJpHhDaU
         YOndtkc7aMtxMaTxmQ6dMOwU7lOVeA89/P+nmh3zUyDGN17aXRkQIuDWOutugFIyDdL3
         4dCWMkMhwfJh9pIkp1foIYNc1scGH3cZwvlseHKVcs7oCVmls1+1J0uq+VcqFqX3hOOB
         QzN6s3EeHcukixmv7VY8WmCZRaKlthwQvkSscPJ1zpwFHWdwk1Uycw4N2SrgF7FwKwmT
         OTwA==
X-Gm-Message-State: AOJu0YzKNDV1xXzUZN7/8Eh6ymkUe+eg8pWuU6r1V/8Lg1UHcTBUBtrx
	TOPeG/6nCXdhMdcECvGWX8Jxn+M3icDKdd8T7KK1iwerK2eA0vxXByDGg8yGN8QbFEiJK3HrMZh
	UL2DQ
X-Gm-Gg: ATEYQzz4IXE2ZCJe/s/1rWkZkFyPMjDqBI17O44S6aJhT8aUjN9YDsvxxz1WwoGbRch
	ViNoLKpLgj4xbLnaJl/bAisqMVeFqYS1chvV4SSr7nRpTulIFq/QavhgUDSCLZ7vWKaFofNpB6e
	CGBimPR6uwJXQFIFSxPwPyg6X/ZztDckFjhnMZTi5gK6U51Vweu7GxsCCkn7Ntcq9flTz1ygPXC
	tIDAmQERrGrY74L0R39Wx67PqREQ11Cll87hTZYNO79LsL/6smNLzfiOjI+u07odNZ9fDvtu/JY
	TL4B+6aVMw+b5t4x7efxBZ68OIx49AoBa9sTgCB364Vq4AeBZOKc1DedqasE0smljCkGfoUs5jJ
	dqzKmo6bs4JKBAXt6cW+oOVnISP2t3/p1kgsgiW47gKbN6yohharlXyfi3JeDXHaNtdfQxWGh7W
	f0MG7Nu+UUpslKr51vPfZ+2oMuS01NHCBKC/j523hks9M=
X-Received: by 2002:a05:7022:4393:b0:128:d396:f2e2 with SMTP id a92af1059eb24-12ab2857b2emr3346045c88.8.1774722429611;
        Sat, 28 Mar 2026 11:27:09 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm3909263c88.3.2026.03.28.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:27:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Yousuk Seung <ysseung@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/6] net/sched: netem: check for invalid slot range
Date: Sat, 28 Mar 2026 11:26:03 -0700
Message-ID: <20260328182704.456993-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182704.456993-1-stephen@networkplumber.org>
References: <20260328182704.456993-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272798-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 171B434F922
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject slot configuration where min_delay exceeds max_delay.
The delay range computation in get_slot_next() underflows in
this case, producing bogus results.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 73d0e85eeadc..de22d754cb79 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -831,6 +831,17 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr,
 	return 0;
 }
 
+static int validate_slot(const struct nlattr *attr, struct netlink_ext_ack *extack)
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
@@ -1045,6 +1056,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt, struct netlink_ex
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


