Return-Path: <netdev+bounces-263199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC4nJgbepmnRXwAAu9opvQ
	(envelope-from <netdev+bounces-263199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:11:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1C31EFF92
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDABC30CFC12
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C7342C93;
	Tue,  3 Mar 2026 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gX8txM/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F512421A11
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543275; cv=none; b=rydnFYKwVvxFXz2WybhtCsr3owwIejG99OSXRtcglwSoco3Zob4VrWpkV7u7zHD/6Vr1Lan2iZyc7h6A3+JV8JigMlZzfprTx0UIK8ftWoi+gJhXv2BNUF9E1GDyaAgDEZe+2XSVrB1IUcrpm6w4ZLhsNQweCwimGYy6r3MTg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543275; c=relaxed/simple;
	bh=0frEQdps/VBu2WyCrjWQP3xfuORe5FTT9toqUnmAdUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFD+tXAMr6PEG+e528oTP9/G8l7wU9fG2D3wq0veUSIab/d54GzR6EwvRzzf1ONYEH56068UPRy0tj8WKJ1V0cWkq8M1d8taqUCxXjqbzZ1RqeoXlefzOQNhA4ZqXtiZIVsly02fh52fb1wD6E8ZrhAUE1Utm7deH3emPLl5RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gX8txM/I; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso3143037241.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 05:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772543273; x=1773148073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTr6hP7Ztu+YPdu1Cxohdg3//GGLycjl8Gc06J+hcas=;
        b=gX8txM/IF0E0/D16Ypnq6gx9vLDOwMUHezXPtjdNVf/pFg3lDZK8q2fcGEL9Zytr8o
         OBrzoxWceVer/jyfgNp8d+QX6LUeWKninJEJXUrCpNdvj2CjSfG0MmIGUgkEkAjR2sLB
         ErRykbKigh+fn5pe7g7mV7nNx29DVnk6DPGfVHGsxnhHQHRxosCkhX8Qx0HDpNS8LPSV
         ZcUf/xDT8VqWAV9ngTW6J2h2nA0zuvKcxSfFyDutHNAMuRsqWbx2SAaHEi+79EUuW7ub
         EgwjWtEmXM+36lnX5DfhbI/5WrjJKbXRZuET2EhO08K+f4pmP7vc5irUrbRy9p0FXYRs
         IC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772543273; x=1773148073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTr6hP7Ztu+YPdu1Cxohdg3//GGLycjl8Gc06J+hcas=;
        b=ShTZGNJ9YBz65tuLX7vuam2Rs9ElBzN3wx9QPbyoTxcjlmv7FqgzGC7RR3mUIqYm7I
         Y5DRGWrl4NKzJcuI9P7sQ4cc/XzA9meDOmuDAmVq0vRMv3Cql8h+2Wk7ym4aQ+hx6HhA
         ufpdRtPfGKIvobISTwYSS331Clfqf/OQg4ZLxXSYLLLq2qRe0EaXVS+vR65uYeLdqQ+/
         dw09brQl6z9ZFwez3rQ1Zk8aPM8Wbq+rlk01f/A05UY8xzn2EweWhOLO6RJDWlIVc9WE
         Ms0yYG/q8173rNu/TxfNT1r4GCCv2ppc9Hxq7K+aYrXHp8gWGXokJJZ0PPlRwJDNeHrM
         aDPg==
X-Forwarded-Encrypted: i=1; AJvYcCVjgVKsJvQFJQBVkiV1IS3HeaNYBF1azo8DvD7ms3RtWblf7FgwzWp6NoZw9Oy2ww3dA7qOeVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6DZKf1QkbVr5t4pMPPHCah9xt0Q9OLyaZVS3tzGucd53m3c1N
	/76b80ox4DAcpSjl2o/v4P3qQ7EnZ2kIiGd2QRvDliWHETULRgqbYgBfxQ3mD6Lq340tHf79KB4
	XlNE=
X-Gm-Gg: ATEYQzyH+fjXqsmiCNk7jp1n0ptteg+0IXqgiGfIJpeTePWSe+YyZr8xGAGZE3zqzI1
	Ksm5H6DsQ1QZ+JE6QOy/HQc1C7ybH7apZrLoaY5HS7JyfoMhboIvOj8L4jBMEgUzpEhK8lT24lk
	fJqNuP9dWygLEcIN9/8dT6acAzTGhcxwT8VMAK04iRwtwlh1xaGVRLoph9BGZUIhNP3Y5QYvDhP
	0RACXNnZjk4OLuEIjLPHmvGO3Li/VQgw8MVz0c2W/pTmVM3xyXjbdyUA1Gf4iEcVCMd3yInDWab
	NS4iK2mUPAapbyQ3NnSoiqUjynaCLKxuJfYNM9F50VDGDgCb+QD+v6YibYXyaKUXK3SuKH2QQQh
	IeOulmSJwdg34dM6RfAgXAsl1rSeDIsZB/OvfklzhWzIZRufqSNlOffu91zlXtpWlwBxheczHHS
	Jn9EXT6mE=
X-Received: by 2002:a05:6102:6ce:b0:5f5:3835:4796 with SMTP id ada2fe7eead31-5ff32311c31mr8432186137.15.1772543273300;
        Tue, 03 Mar 2026 05:07:53 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e80818dsm16583894137.5.2026.03.03.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:07:52 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: jhs@mojatatu.com,
	deren.teo@outlook.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 v2 3/3] tc: Add JSON output support to multiq
Date: Tue,  3 Mar 2026 10:07:33 -0300
Message-ID: <20260303130733.540278-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303130733.540278-1-victor@mojatatu.com>
References: <20260303130733.540278-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE1C31EFF92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,outlook.com,lunn.ch,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email]
X-Rspamd-Action: no action

Since qdisc core already assumes all qdiscs are able to output JSON,
add JSON output support to multiq.

Fixes: c91d262f414d ("tc: jsonify qdisc core")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tc/q_multiq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tc/q_multiq.c b/tc/q_multiq.c
index 63fffed4..0e8e2f9e 100644
--- a/tc/q_multiq.c
+++ b/tc/q_multiq.c
@@ -51,6 +51,7 @@ static int multiq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 static int multiq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct tc_multiq_qopt *qopt;
+	SPRINT_BUF(b1);
 
 	if (opt == NULL)
 		return 0;
@@ -59,7 +60,10 @@ static int multiq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr
 
 	qopt = RTA_DATA(opt);
 
-	fprintf(f, "bands %u/%u ", qopt->bands, qopt->max_bands);
+	snprintf(b1, SPRINT_BSIZE, "%u/%u", qopt->bands, qopt->max_bands);
+	print_string(PRINT_FP, NULL, "bands %s ", b1);
+	print_uint(PRINT_JSON, "bands", NULL, qopt->bands);
+	print_uint(PRINT_JSON, "max_bands", NULL, qopt->max_bands);
 
 	return 0;
 }
-- 
2.53.0


