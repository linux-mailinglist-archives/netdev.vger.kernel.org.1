Return-Path: <netdev+bounces-263198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHSkGfPdpmnRXwAAu9opvQ
	(envelope-from <netdev+bounces-263198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:11:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB27E1EFF82
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3355A30C6925
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAFE342C93;
	Tue,  3 Mar 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PUGyF6SY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC8423A83
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543273; cv=none; b=NUxeYTZxY0D1CFvPjS20MBHIz61ezmznRGnCnF1nBumjGT8ZHOM3hDZ7r/tVyzhM1jeWwEnMFRZGm6W6k3joxQR2dKyF4HJFbNQ5GPl+zJa1n8/7+IqlDDtOjmaDuK6tECEi3DqZv0vS6spkZ3VBJyT/RZakSFXl8b0Bo/IeCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543273; c=relaxed/simple;
	bh=lV+sI/DdZUGkZvsXZ2FJvkJphIAH4AsOiVG+d1LzWg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L97wP0OEiEHDH12mf93tyyIoL80e6ZRf95Jq3d4MHJ8yibCCcJPuRRH5rVZ+jn1Q2doMGEtdzFDyYd34+LAuibppcU59WXnuXrPc9gVkiJ/7CPOJ95qKmkX8wlBXhZUot3AqSfLkdxc+/Qn3tV3Xe9nm1nYEizBvS1m72NeEhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PUGyF6SY; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94dd2d71231so1607189241.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772543271; x=1773148071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdkQGmQ2LASjWNJ94Ee5kjqYhnJQt1MmHQlbpxdWWWo=;
        b=PUGyF6SYUCYZ5RDclMinckj2Q7V9+szKI9wYW/r7+lSWGdEoKdXWVaO6Q+a3ehmeAQ
         KKXe6V1tR1p1g4sETdJaCdvcuZ7EXRhRMtd3q1zAy2jVUTCCfOV/DhLC7XOerA0FzDMo
         Ntgl1j6ZxVIdC7t2uUVIF2U3hlO6ls13SW7u32vKPH4F1PZ6HhPiToalckqyPKpbChfl
         3MwVOqRrn8f1Va3QOd5NxleNSt8prT0HdCWbfXB5nLJLyHdJDE71VP37RAuXK9yTjz0L
         h2s/vjiss9oTLAZyNLxfFvhviwkDT0orPRidZXbOb3yorelQuAdFpOAKSr620Irh2BSY
         gYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772543271; x=1773148071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdkQGmQ2LASjWNJ94Ee5kjqYhnJQt1MmHQlbpxdWWWo=;
        b=oqI1kfnuo9USWeJ2JGEBnGzrJAdRmdzF6vDtzjBEGSQGjyif3PgYm2KgfZIhGDEhfP
         hPnl5i4dB24A6t30WI8Fn+e1VGCmToi81qAIIy+cMHsL0QoT0gj77WBox5CZvU7+60wu
         tNsj4akZw06oYQh8jUSHwCnd1VQPJId0PAE40+ndkRnIEgTRFq+2lBaUM//J1WAFRZmb
         Qy2ztZytog+TfSQTegKbN4Q4+BKsgjJShH0XOp4wQbUPA/anpn8n1os7nTF591Y4qNwu
         T0nzYPxF/Yifi/FLwMYaHyTCBaJ/PJdPJWv9uisvKsp9R3whZSgZs440KLJL0EtheaaI
         SgWg==
X-Forwarded-Encrypted: i=1; AJvYcCUGiLi+p1Mi8Z0cbRuAdv1edEUM1qrN6lYObkIbmHoHZR6eR9OTPriMvHj9pk6NCAFl83KY6nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxInPKM9vPRe2Mpi/OdjEUetwwq3NOkuWUnWZwnqQh2gzHJqyin
	rAimuIHAQ2NlNeVR1vp4r013C0S79T+uSuCcQNbOKx+JjHl59ZAlRDbXVzIo1o/zXg==
X-Gm-Gg: ATEYQzyoyoeE2DW2EVwMUsc8KN40lSQEEUVTRVMvXFbW6MIWCG15bkdvq97lVJ2BW1e
	qO3l+05GC7I9vHxRy9fTCeiItm2Qx/uBdql4n5HOf5qoVVzXWwA/a6QBBtx+pkDD5itFW5sfknY
	cB0kG41tADNpTfhsluxkFgxXW4hFIlV+J9HXCUU/EBXkHkQ90eEN3sHzEMTYDnHAQjgcfQC3vwB
	MiO8v8nmqfgcw7JiGMicil4czLzx2602lcUP1PKltemw/QAsfSpChX7rtmRc2lrWb0zhbMTwiip
	flQJ6IgS9Q/Qvts0vdkvbKp8ICeRkdfCIrpkldjjQKtiRkkQj5hcx5PHoIR09190kBsC73KaUv2
	G3Nyt1J0zNgdR12FDthyyCfXWVM6d50fXxhBcyZK3Ok5t63ccWdud4bEfl8z5QrviWKl+aq0MwW
	AK1Oh3+pk=
X-Received: by 2002:a05:6102:54a5:b0:5ef:a346:a020 with SMTP id ada2fe7eead31-5ff3237e881mr5036955137.17.1772543270555;
        Tue, 03 Mar 2026 05:07:50 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e80818dsm16583894137.5.2026.03.03.05.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:07:50 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: jhs@mojatatu.com,
	deren.teo@outlook.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 v2 2/3] tc: Add JSON output support to QFQ
Date: Tue,  3 Mar 2026 10:07:32 -0300
Message-ID: <20260303130733.540278-3-victor@mojatatu.com>
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
X-Rspamd-Queue-Id: BB27E1EFF82
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
	TAGGED_FROM(0.00)[bounces-263198-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email]
X-Rspamd-Action: no action

Since qdisc core already assumes all qdiscs are able to output JSON,
add JSON output support to QFQ.

Fixes: c91d262f414d ("tc: jsonify qdisc core")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tc/q_qfq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tc/q_qfq.c b/tc/q_qfq.c
index d4c0a591..04061fcc 100644
--- a/tc/q_qfq.c
+++ b/tc/q_qfq.c
@@ -90,13 +90,13 @@ static int qfq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *op
 	parse_rtattr_nested(tb, TCA_QFQ_MAX, opt);
 
 	if (tb[TCA_QFQ_WEIGHT]) {
-		fprintf(f, "weight %u ",
-			rta_getattr_u32(tb[TCA_QFQ_WEIGHT]));
+		print_uint(PRINT_ANY, "weight", "weight %u ",
+			   rta_getattr_u32(tb[TCA_QFQ_WEIGHT]));
 	}
 
 	if (tb[TCA_QFQ_LMAX]) {
-		fprintf(f, "maxpkt %u ",
-			rta_getattr_u32(tb[TCA_QFQ_LMAX]));
+		print_uint(PRINT_ANY, "maxpkt", "maxpkt %u ",
+			   rta_getattr_u32(tb[TCA_QFQ_LMAX]));
 	}
 
 	return 0;
-- 
2.53.0


