Return-Path: <netdev+bounces-263197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMneGdfdpmnRXwAAu9opvQ
	(envelope-from <netdev+bounces-263197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:10:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB35F1EFF43
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C5F30BC83F
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE442317B;
	Tue,  3 Mar 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3PpLR0KE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44671425CF7
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543270; cv=none; b=sK7ZbruBplyu+402hhlt/gbxnPf4qvzIsuYsK//wy1ysw0j0Goq6Wvh69+efo1tYBk0CpqsC+4lrUCdtJjzc4cxSHjrf+H9IbkVE8HH8gq6y+RbiZEog7alkfl1RVorTFWHf4ILPjVTu6cfM74OJnGdQlvRT5IpaoTHi1FSRKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543270; c=relaxed/simple;
	bh=+F4xfdKmKpQa4gN9aNb8dBRHfR5XY/pQ7MlecX/OXDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBz9vZoDfF9eLXwyFQwatTjP4d+EWIe/MOXAhni8mjqt0WGdZIDvd8tMbFdob5JBG1hAnnjUmCmeiQB1P1ESvf3hWfjNSTnAdFnjVI9c7G486VXTBPMkMRLeZZz70IqyR6/iWZmu4MNbDYouoBnqJy9bEtXl5H7SnfpooS3h4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3PpLR0KE; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso3142991241.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 05:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772543268; x=1773148068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4z60UqzYywzIo2HMFRhTu7/TZhTfwqd1aMPSCsv1Uk=;
        b=3PpLR0KEI7/9aqBIpoM9qzQDnwQWCIt0h877edBYXT6z81z22P53JZN8op0KCJiDk1
         YjomIiAlVl1YVku+eVlvTrpcZ86UYHuQm9T3VJWFGkCVCSHCDWAwffs6BE50Zs6tpE2V
         wes6yTj5hQHXhsey/qmTGx53/QyxhDCbttB9IWR+2zBZU1GHQ5S7d8APgDN/vAWDQB3d
         h1Guii6cEQOdu+m+qJYGnXNWShIaMto2iDOtSAHezDhHQoEqPuZSXQc8YjDmw2hth+MU
         kbGXNK0OlvK/X0ffzDxE1lMgP8AePHt/XITMNEuV2E+HRvhmSJ5KymYys04dhN7PxcWd
         Lqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772543268; x=1773148068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4z60UqzYywzIo2HMFRhTu7/TZhTfwqd1aMPSCsv1Uk=;
        b=eO9plmzDc5uKiC7+9lHDxLu594x9R3O4wgRcMgEOtpZT0/VpSm84ow5R4WVDetONcW
         VFMAQctlEgbG7AxGrm7dqaFvM+v8ujqqO/wwX4Ns8z8UTxK89ePv8ilU+XLJbua7KgyR
         dEl5AFhCOUMmqOj3XW761rQW8n8GV7P5k9sR28W+HRUAOMYo6h/zgmWL/a5QSlyi0tWa
         22p8nCBBpSII4WXDYYYVyx5n+7WWmWcchnT6/NAC4n2bNBqKuk9MDggN8+ghVFFu0by1
         hXPOsA+ci649YLqmekPnSi4I6YFghZkVnyBTfDKHyK01wYsoA0Be3zF7U8Vgl9ZgLP21
         DDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVn0UrFIDtFuh6X3aYkXV9tiT9r5l8pkhp2uZMxPzqmGRRpzi6pCwhfEyG1W8KOrreD7ucK/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZXV2GPMk/AfS8Grw31HHqqFXuTm0+ag7lpKbpnqZCO+KeL15
	nV1/FEu9DMfT/A0RYaMe+oeKEZxgjTP1FtJC2azwxxd2o9E1GVEuZcU8SjTlKOG4HBTGEdoMZr1
	iFbo=
X-Gm-Gg: ATEYQzz/4Y8g3qefM7SWnPMdGjnj5MLvDskDnhi2ZTnoxPTQrnTUfDl28fsrJqyB9LI
	i9TidQi85/xCASzu+gxv9QWCJ+zjfdh7ibQGnJJ0ixJwq8eyU+ERNCOVggNKBr54dzHCMvT0541
	AwkSKm89+7EYIG7osXU5wLnWSFzL5F1PtgAjgNbZgPBFCyCy5GMoPGvPvJptF96E8C/BYLc6Xo6
	dt5CVLrRrl35PTC2rj/zY/RLuE6f6g5GjFUuaX5NNb9/v0w7qM++DHontssecM4aF0wFbmaBuT8
	0MChWgov2EUO0GDVT5+LYLQh0XLg5B97SRtlN/hv4+FlHcX27QOXHULgL0aPyhsUryLpuJ8ENfx
	HtClKUPotedixS3b3WCurqo7oYNUQwJ2b2iMrsPrZEt/tY92O0XsY2NdFYcaewmhevUY9weHPIA
	EOIbykK0Y=
X-Received: by 2002:a05:6102:2ad5:b0:5f5:5c2e:59ba with SMTP id ada2fe7eead31-5ff32515061mr9039296137.33.1772543267806;
        Tue, 03 Mar 2026 05:07:47 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e80818dsm16583894137.5.2026.03.03.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:07:46 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: jhs@mojatatu.com,
	deren.teo@outlook.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 v2 1/3] tc: Add JSON output support to HFSC
Date: Tue,  3 Mar 2026 10:07:31 -0300
Message-ID: <20260303130733.540278-2-victor@mojatatu.com>
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
X-Rspamd-Queue-Id: BB35F1EFF43
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
	TAGGED_FROM(0.00)[bounces-263197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,outlook.com,lunn.ch,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email,outlook.com:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Since qdisc core already assumes all qdiscs are able to output JSON,
add JSON output support to HFSC.

Fixes: c91d262f414d ("tc: jsonify qdisc core")
Reported-by: Deren Teo <deren.teo@outlook.com>
Closes: https://lore.kernel.org/netdev/SI2PPF4F82E9256898C9826AF17C3AE8AD9F467A@SI2PPF4F82E9256.apcprd04.prod.outlook.com/
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tc/q_hfsc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tc/q_hfsc.c b/tc/q_hfsc.c
index aed7130c..f68e8351 100644
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
+	print_uint(PRINT_ANY, "level", " level %u ", st->level);
+	print_string(PRINT_FP, NULL, "%s", _SL_);
 
 	return 0;
 }
@@ -211,12 +214,16 @@ hfsc_parse_class_opt(const struct qdisc_util *qu, int argc, char **argv,
 static void
 hfsc_print_sc(FILE *f, char *name, struct tc_service_curve *sc)
 {
+	unsigned int d_time = tc_core_ktime2time(sc->d);
 	SPRINT_BUF(b1);
 
-	fprintf(f, "%s ", name);
-	tc_print_rate(PRINT_FP, NULL, "m1 %s ", sc->m1);
-	fprintf(f, "d %s ", sprint_time(tc_core_ktime2time(sc->d), b1));
-	tc_print_rate(PRINT_FP, NULL, "m2 %s ", sc->m2);
+	open_json_object(name);
+	print_string(PRINT_FP, NULL, "%s ", name);
+	tc_print_rate(PRINT_ANY, "m1", "m1 %s ", sc->m1);
+	print_string(PRINT_FP, NULL, "d %s ", sprint_time(d_time, b1));
+	print_uint(PRINT_JSON, "d", NULL, d_time);
+	tc_print_rate(PRINT_ANY, "m2", "m2 %s ", sc->m2);
+	close_json_object();
 }
 
 static int
-- 
2.53.0


