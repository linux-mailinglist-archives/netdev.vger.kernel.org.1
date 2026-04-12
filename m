Return-Path: <netdev+bounces-277817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CArKCs2522keFwkAu9opvQ
	(envelope-from <netdev+bounces-277817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:27:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934D3E479A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC50300DF62
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C0738238F;
	Sun, 12 Apr 2026 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="AWbaLvgx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B55382F21
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007483; cv=none; b=ta8Vwyjd9nPmmMlyg4YJTcE4OZwqjZ/RHraS8KStcJiOv4yKbeu9BMq5/Fo1BAK+3vNQO0yfnzZ2TmjEK3rmqN+Jqi0i32KZ2nXglY36qZq+wxhRE2vHoT1JytY3FCUwftVU8wPCK6EtHdUfaSLW92ACt58MLVcYZBtHOfkxstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007483; c=relaxed/simple;
	bh=I09+T99cRHxHXCfO6vMWl5KaObArwL5OPn+xV2JmRVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBNDakqiapQfPNzdnd3UV3h9mszILOD7sT88TrQRT6gRKj7YT2B246z50FVsxT0ZZ1/dTrIp5oZR22UmGB3LQByTIJYXZdlahb7lyb5+Q15ogwsM4uBHFHB1tW2zczZVikiP8quv+KA9RyBbKP6t3PvN6GMVCApWMfPCM1m6QDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=AWbaLvgx; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47952228f05so129974b6e.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776007481; x=1776612281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WINlmEl8Y50KfKycZZYh2811Z7NSDaIahrEzQUkOfs=;
        b=AWbaLvgxi+cJX/SpKsZQOEDoqnLcLwrxGIQ274O9PrHY5wL7aRoDjkIRXveXugDBKP
         KSa2Mywz9x6gbHHRxiNnHTtMSHROoIuNU19Tc0aedBJ6pdS09Qn0iEx+cGhL+RBRhk1l
         gjTh3niMEJMjTKuuPJ4/uF1/WC+SffflVZY2aSSwJW/9UPnZO1hI8M+GpzkAtf73lhsH
         BhBrB+/++9hxEIO2xvTmdO9wRvnp5AM0eugHs1eoc7RUGB6EBkK5++4bMY9uz/ZUxZGc
         cFahiA/uRStgdvGiaw8WRZVstjB4CKwVHsyszcDID9Ml3PDYBqwC+0tGbw8BPhy0BhY3
         n9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007481; x=1776612281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9WINlmEl8Y50KfKycZZYh2811Z7NSDaIahrEzQUkOfs=;
        b=EZPFfGtvOK14tU9pihkeI2sAUT8/Nrr8PbT5zufGW08acHzT6a0OV3cVwfBxG0N1j6
         I32kWoND87zxX083PtcWKkSqudtpRr76+TJ4A67Err49Mo0QBzmpah9iIhGReVOuB3r7
         ogekEF5H3/xouvfOdY1jkV1JLhon/f0lpO3A7rBgXlAqYQfpQpXT6iE7Q8S3OvqYhuFr
         OdykeMq5HFLrh20gbrJB2kENh+hYmmkokiHQnvg1cedjY+4ffU499aKfVSXtcIU2z81P
         Hd9Zc7afiJ0B9KnJ7IbB96nAIYbySmiVuowfyQzZkT63O+NoCWxDdyaEwTNm9rwe7DEd
         i35w==
X-Gm-Message-State: AOJu0YzemV62YOrJNKCCQauG/g21NJ8y8X9ejkuj85RCpaYmLPSOi18n
	DDsQEG9hgzTsjzOn5/RBiGHGh+XYcC3UYW6dHqihrv82MBFVqoBowTjeLhqqT8q00MgT3CKfiuI
	vsHF1
X-Gm-Gg: AeBDieuXZ3S/fiIb+N4vnvU62ZDXfGg62pkVHJKehRE45BrMcKU6NmiB2jROR/K1Vx2
	CE2/7BpX98cfE1blKznS/Lbai7NeCPgFhHnOo/NEbW+/40OEXyyMeOX/iRv2DB8aqQT1XpVZPfv
	ruvPkITThI/cdheyhbuYYs+VA30rN3ZfAH5/SSSWKez8UYUtTz8UgY7EkoC6tLmp41C1D4iqS0B
	DKd2DkXRBQ9oOwd3ClNAFKeSBn52G/RV2LjhSoyUlViBKeQher4LkyIXZt1V2/i2+Ejr8ifJb52
	NFBN2WpcR1o/Q8A0ja3i0BUw/+ol4RzuxtSSWkOoh4ojGQSKitCmmIXHcQp9MARb642r0mIKz+d
	sseNwNPPq2rPadF51ngDA9ymL0LqUTcIwtACXjvNz5Ss+vH+9kXrGhIXhXf+f/N5GFJO0Qxcc3D
	m3mAP4eLIdOxbMIrRcyggv1A7UOwqtpceb
X-Received: by 2002:a05:6808:1495:b0:45e:f888:695e with SMTP id 5614622812f47-478b70a7648mr5449396b6e.11.1776007480943;
        Sun, 12 Apr 2026 08:24:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a2f557b5sm4911726b6e.11.2026.04.12.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:24:40 -0700 (PDT)
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
Subject: [PATTCH net v6 4/5] net/sched: netem: check for invalid slot range
Date: Sun, 12 Apr 2026 08:23:54 -0700
Message-ID: <20260412152429.143474-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412152429.143474-1-stephen@networkplumber.org>
References: <20260412152429.143474-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277817-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7934D3E479A
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
index 556f9747f0e7..16368948bde9 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -827,6 +827,18 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
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
@@ -1040,6 +1052,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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


