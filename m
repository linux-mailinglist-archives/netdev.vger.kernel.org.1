Return-Path: <netdev+bounces-258319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNdjMp23jGnlsQAAu9opvQ
	(envelope-from <netdev+bounces-258319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:08:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7801266F7
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D70303CE85
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA1314A74;
	Wed, 11 Feb 2026 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="E6d1TGcA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE8346782
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829655; cv=none; b=dHu60YQEDm29ZBnnsIj8LkLPABP1/LOyZI+0oDhfSHx3of9lxkXsuRfqiySfruLUM/eMOWvLNYAo0Fbab9VsfGF9bWPGCy9zr3mFM2Vwdhf5DHV26FmtbqgTz3XEc/aN8ajjUpC2hKC1SQ4FiUCVRt7LtFY+RQkaWZOl2fDLoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829655; c=relaxed/simple;
	bh=j1CkXQAycIuHsNN7eqTbwe1JQLFv9G3viH56doXuSm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiTqYifK34lvhPbphn2sUvPwDd3ZPfM1s/tVv+0dB74Dqp9I36UxBLluiLR1/zCZ1860pScZH3QlDC8fCsOGbaC0UUX8aZsNsUg3TIEKdNAAxo11vwZoLFbRoaPK65fF3eZ396qb1UYvJ8rsjXpFQr+oQcMdc2uDn3XTnOZLqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=E6d1TGcA; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso230877eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770829653; x=1771434453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86Si39HUUpntcAQZvyt7HiYTEw/F0f9tVlrgdGD3dms=;
        b=E6d1TGcADXZPUVnL+Gr3OvL+hA47WfB4DZ9EyrDuxJ7KFERSKJwIbg2Ff1BrOyxT2b
         DJouJn/RG26+1P7ISN43QQSHJb/j0vEkBYIhse9WHbAPtZXXVDoCBzCBZA2W0jygbMDE
         Jta+xWFcKvLfLOfHyy8ka5F+Hv8QBixQDvf3B/HpFVky2VXiSuSnSju0HEuUm/CmhJcT
         iccfDho7D3bxh4U4OBqjDEAz+SCCOaWZgVQtmH7ujUegdrCF5QMWsyQXZAYr2zVXkVPc
         lAXC7MjSwiDT+yu7iffor4xiypLv7kuTssg1CVo4rW5qaRwa/IYkhqYKffPZ+dtzJPyW
         cR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770829653; x=1771434453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86Si39HUUpntcAQZvyt7HiYTEw/F0f9tVlrgdGD3dms=;
        b=frAkobpZGttu0o63UIxLrGFAPYg9gzkFmLkTvgK+Gnr6DSNY7eJE753oYB2cZ8qzQw
         aVkQD08cuxJqql7juuYkD+eFwEWGyw7OMlupdUM00I4vjZp6YwNZ0zs54aIdEExclnha
         kLeL5G46ndifxw4teXclCLqTobjGuUO5/idOrhpz1RSzxw7COaBK7eWW9ytQQ+3U+SpT
         Np6fqazeD1BevCD2BSOpZtfS5HQcAIyq2qzyo2M8MJIVqAMYTqI0psRFBJiuzDJm6kQP
         yjGif9ZNLRBZrG9kUuSHWE8wmSQNzdrehFDkAOTHoXVMNNrd4z/ms87fWLLOROUWGcpD
         0/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuCNQVAlezuAMsqsSm5YADt94tRg5UyEgZQhDsMsgFQVTqXdYeKuKVydw6eZuSqoRXSKlHP+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7FOC9j0eNpr+YVYaXOommhX3Y0q/yunPp/sF02++Eo724Hg1
	6KUGIWX3BRyXcl37RTninjm+cgbc9MzC2T6a7HdKZi5JeHyPxWFkfFyAt2XHyJNSCw==
X-Gm-Gg: AZuq6aKxFG7lzX3TFToKcqEXKpoCjsB1yiGWMZwM5OFU/bvsrm18ubZ0pgodnISLCVL
	5Yi9f3fPpwNvvct/hwuEIGTausmnMbE8CmONsWcqspIE4pPLev/5tEMwR15Xa3OipWNp9sDGVRE
	xEf0aNUQM6s81rIFJmZsdHFJeEPCVf/Yau9lAWJYKhkWFTS/zU9YDiARsyCkXYcJn0eQDM0oE37
	n+5D3voyzg7PgkR07UgESbY6rJG1iC2dHh480NNjD7iWY3U3Y+UpIdKnrNV2buP5hBebw8cIwMo
	63HpHjK0AfC7NX4BMmVdkG8XT6b1JvnPrFEvrXVI+zvUfXdjnyZnZWmUfCrlVsaS1XqYXYFJV/0
	slXAoRpg15G0mGwueAImgUcvjyE4SiImp0fSUpDSG/J9ltrLeqXSMQTPamdHW+8/613lJwYAnyC
	0ufKZvuLlE6jm7NZCcHAs/qGpWCkblPA==
X-Received: by 2002:a05:7301:2e85:b0:2b8:1d16:9736 with SMTP id 5a478bee46e88-2ba8a846647mr2853395eec.23.1770829653049;
        Wed, 11 Feb 2026 09:07:33 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dd00ae7sm1649496eec.31.2026.02.11.09.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:07:32 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: dsahern@kernel.org,
	stephen@networkplumber.org
Cc: jhs@mojatatu.com,
	deren.teo@outlook.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 1/3] tc: Add JSON output support to HFSC
Date: Wed, 11 Feb 2026 14:07:23 -0300
Message-ID: <20260211170725.1514427-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211170725.1514427-1-victor@mojatatu.com>
References: <20260211170725.1514427-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258319-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,outlook.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 2D7801266F7
X-Rspamd-Action: no action

Since qdisc core already assumes all qdiscs are able to output JSON,
add JSON output support to HFSC.

Fixes: c91d262f414d ("tc: jsonify qdisc core")
Reported-by: Deren Teo <deren.teo@outlook.com>
Closes: https://lore.kernel.org/netdev/SI2PPF4F82E9256898C9826AF17C3AE8AD9F467A@SI2PPF4F82E9256.apcprd04.prod.outlook.com/
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tc/q_hfsc.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tc/q_hfsc.c b/tc/q_hfsc.c
index aed7130c..7340f607 100644
--- a/tc/q_hfsc.c
+++ b/tc/q_hfsc.c
@@ -108,7 +108,8 @@ hfsc_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	qopt = RTA_DATA(opt);
 
 	if (qopt->defcls != 0)
-		fprintf(f, "default %x ", qopt->defcls);
+		print_0xhex(PRINT_ANY, "default", " default %#llx ",
+			    qopt->defcls);
 
 	return 0;
 }
@@ -124,13 +125,15 @@ hfsc_print_xstats(const struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
 		return -1;
 	st = RTA_DATA(xstats);
 
-	fprintf(f, " period %u ", st->period);
+	print_uint(PRINT_ANY, "period", " period %u ", st->period);
 	if (st->work != 0)
-		fprintf(f, "work %llu bytes ", (unsigned long long) st->work);
+		print_lluint(PRINT_ANY, "work", "work %llu bytes ",
+			     (unsigned long long)st->work);
 	if (st->rtwork != 0)
-		fprintf(f, "rtwork %llu bytes ", (unsigned long long) st->rtwork);
-	fprintf(f, "level %u ", st->level);
-	fprintf(f, "\n");
+		print_lluint(PRINT_ANY, "rtwork", "rtwork %llu bytes ",
+			     (unsigned long long)st->rtwork);
+	print_uint(PRINT_ANY, "level", " level %u ", st->period);
+	print_string(PRINT_FP, NULL, "%s", _SL_);
 
 	return 0;
 }
@@ -212,11 +215,16 @@ static void
 hfsc_print_sc(FILE *f, char *name, struct tc_service_curve *sc)
 {
 	SPRINT_BUF(b1);
-
-	fprintf(f, "%s ", name);
-	tc_print_rate(PRINT_FP, NULL, "m1 %s ", sc->m1);
-	fprintf(f, "d %s ", sprint_time(tc_core_ktime2time(sc->d), b1));
-	tc_print_rate(PRINT_FP, NULL, "m2 %s ", sc->m2);
+	SPRINT_BUF(b2);
+
+	print_string(PRINT_FP, NULL, "%s ", name);
+	sprintf(b1, "%s m1", name);
+	tc_print_rate(PRINT_ANY, b1, "m1 %s ", sc->m1);
+	sprintf(b1, "%s d", name);
+	print_string(PRINT_ANY, b1, "d %s ",
+		     sprint_time(tc_core_ktime2time(sc->d), b2));
+	sprintf(b1, "%s m2", name);
+	tc_print_rate(PRINT_ANY, b1, "m2 %s ", sc->m2);
 }
 
 static int
-- 
2.52.0


