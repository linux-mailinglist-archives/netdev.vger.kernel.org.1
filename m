Return-Path: <netdev+bounces-262402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD7SAj9JpGmMcgUAu9opvQ
	(envelope-from <netdev+bounces-262402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3A1D0254
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4DD300D447
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB7F30B514;
	Sun,  1 Mar 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzY0szCM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B252C187
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772374332; cv=none; b=PPOhTni6JQQPbQcN9rgPYpJSrA2QfTTn1/e/lKccQvIqGXwdFGwUqpf8uoWzs3bF0bRcuIc7N9N3cKMCXmYCoAXsBUlGszLbyfiz3rJJSPYsY5tuQJ8DQKek1hlSbSSzlcof+RI8TgYmTJ+cDOSyolhEYPkXOmHCHLVdNI7UuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772374332; c=relaxed/simple;
	bh=bkviW5cwaYYwGtqIb8+7k7kfIT6A7C7Ov8jsHwmZPPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uy6Q0IfQhVq3/EhdJO4Rbr76GL/H8tu4ubxabSYcJEIxR8lK6aIuH8/o3R/8QYITRFc5qd66eBW8Rq/BDFh3tdiZ5pGUMpmCfT9mib+7+UX3T2H1ktf2cFXSDoeKNS6P+/RHZDyIpJjA9x0dSqJhew0AH0vOE6Abl6vThNPns+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzY0szCM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so42362245e9.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 06:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772374329; x=1772979129; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy2vXLFT4vhYfhaL3jLwpKRJG6UA1T9I2JoveemaeAM=;
        b=dzY0szCMPdVNTgZ+bvMHapbiLe0LYTAwxkQ8lMBfF7AI+WFYKRQ6624ExEbL0UDeDu
         DFYnbN3s7y+RjUqcIO6/tH+VDZHD+WPHfAC2EVPnFl+y9+GH2I38vlNb5I0CuohkRCHt
         9QLUWC/5DzIxPsztHiSE9EZ1MX63btCfxDX2BJPYY/rWPUrYWcpjgXF2Hzo8gSzvjHp5
         b2zUX1ocO5/7TptcLPU6U1NE1YuB4wHumUe3x8EBBUpfQVuJtDGBKH5DVktu5/eiZ8m1
         Dj9VurX17sVIZxKR9jWFZh5EyU9HHoBX5pFFR5ntgdGr0UZXsRuwvSy2z+vZllIkqzmU
         5Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772374329; x=1772979129;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy2vXLFT4vhYfhaL3jLwpKRJG6UA1T9I2JoveemaeAM=;
        b=bcQqizonCKM5iVmktncCymLEv356r00JVmqAAuysGnLIoUrQJyh0UbKs48fzy7s2Rm
         YOaOgBeRmQsmr9ldFqC3YhT+5eixQ5vei9l7VAeI5/Mnh3zsCBcfYrYSV7akSWOkqhK7
         Z2+IHW4PYDhnUd56kZQvspKMo9av5T0QP0pR+9UWy60qJ21EtjIv6AWM31VJ4HhTWfCd
         Kgm5QiLKoTuz+yTirnURvD6R3dO1K/WFwt5yTiqeL0UXb5SzA0eHTqcfPYyAGDbAKN7E
         Bpen+lsPPasYN3tNUnwR6LXPZZtoW5ghrSsTEafZrtkBnjFq217foyeFckBOkl4zUr8i
         dPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ99MKjGTnrgXJjwHFgxHofmfrn5yfIrl0s1Q+dnO+VPIphaHwgO/ZMfwwb1oddqGffog/3aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLGor072+xyOYzzMxKW9qSs9nto894aSXN9sOeyqf2iIusEzi
	cIbslmoUbvaab48gZMtu2VhJyQzVDy0xum8SD3GvaKgfbFsGKBY974yk
X-Gm-Gg: ATEYQzw0NEY3XZrxvqjEwksyLw6KtuXTVXkmZ5PxzdXneo+gcbFavY418FTjqBBm2EJ
	gREUEZf8EU+po/GMXkpezsb8A/dHZwhzBaFrq6ghrBOkj2aqfu9fFfcxH2QuYLDlQBF4cRFU3YN
	3xWfwfkn9oXcfBAZAL5Y9Rumi4SZem1v+mUvubDJI3zrtjlnOurnSAniqXW9nDRyaqwl0EKv2Bq
	EI5vGxyLNBa7YB5WAvuST7yJaZcWgZGf4Gmv1cVfEbKR0gITtc5OYAXG945bbgkn6+jCgtvIIXy
	F6ueMARM7y9SGQze9E8M1dGXxlevUnuw+/BSkC4R5sKGX/zeLak3ArOp6A4PjuHdFvzlbB8gWvt
	gT4qX7NVXOdkSlUj9VZyD7Y+OX2GAA+NvM2lojq2eG/m5hwWcwayqXWhwIAtw00pyRuiuou0GTm
	OltUDoFQLTUinoZnbSXZrIOQh8i2mwAJFaXcIyKs3p4Tb7fCNBkAAwAtuF+XnAcPg=
X-Received: by 2002:a05:600c:3108:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-483c9c1d177mr155968005e9.29.1772374329138;
        Sun, 01 Mar 2026 06:12:09 -0800 (PST)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il. [89.139.129.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm278129275e9.4.2026.03.01.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 06:12:08 -0800 (PST)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Sun, 01 Mar 2026 16:12:03 +0200
Subject: [PATCH] ip: Make 'ip stats help' exit with -1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-ip-stats-exit-code-v1-1-2b59f0704f2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBvQ/qSuEi3MppqNhSMhhHdPW
 n6L914QCkwCU/VCoIeFL1+g6wrcaf1ByFsxNKoZVKs08o0SbRSkxBHdtRE66rTpzbi6dYAS3oF
 2Tv90XnL+AAI05YtkAAAA
X-Change-ID: 20260301-ip-stats-exit-code-ce417579bcb6
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, 
 Yedaya Katsman <yedaya.ka@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772374327; l=2300;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=bkviW5cwaYYwGtqIb8+7k7kfIT6A7C7Ov8jsHwmZPPo=;
 b=RMfLUCoWKqwNroCnkUzEpnL+Vnx8M++oRcRrt84U+67f8Bc31qJCQINvWJGkfSUJzW4Sn4PGI
 EMyvMAT3K8QDhVrqixtJEBOoDTUKFr76ufD2/rzMaVc57kDUvmZvaPU
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yedayaka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64E3A1D0254
X-Rspamd-Action: no action

ip <subcommand> help exits with -1 for all commands except for stats, make
it match.
This removes a goto err, which is redundant since "enabled" gets
allocated only if we find a level, but we enter do_help only if we didn't.

Fixes: df0b2c6d0098 ("ipstats: Add a shell of "show" command")
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/ipstats.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index f0f8dcdcbd2a9e1c83eed6ca54df28b91c058d9c..812a11dacb2f5851ea5d16644b82e8a7a0428e5a 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -1085,7 +1085,9 @@ static int ipstats_enable_check(struct ipstats_sel *sel,
 	return err;
 }
 
-static int do_help(void)
+static void do_help(void) __attribute__((noreturn));
+
+static void do_help(void)
 {
 	const struct ipstats_stat_desc *toplev = &ipstats_stat_desc_toplev_group;
 	int i;
@@ -1135,8 +1137,7 @@ static int do_help(void)
 		if (opened)
 			fprintf(stderr, " }\n");
 	}
-
-	return 0;
+	exit(-1);
 }
 
 static int ipstats_select(struct ipstats_sel *old_sel,
@@ -1190,7 +1191,6 @@ static int ipstats_show(int argc, char **argv)
 			dev = *argv;
 		} else if (strcmp(*argv, "help") == 0) {
 			do_help();
-			return 0;
 		} else {
 			bool found_level = false;
 
@@ -1209,8 +1209,6 @@ static int ipstats_show(int argc, char **argv)
 			if (!found_level) {
 				fprintf(stderr, "What is \"%s\"?\n", *argv);
 				do_help();
-				err = -EINVAL;
-				goto err;
 			}
 		}
 
@@ -1286,11 +1284,9 @@ static int ipstats_set(int argc, char **argv)
 				return err;
 		} else if (strcmp(*argv, "help") == 0) {
 			do_help();
-			return 0;
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
 			do_help();
-			return -EINVAL;
 		}
 
 		NEXT_ARG_FWD();
@@ -1321,7 +1317,6 @@ int do_ipstats(int argc, char **argv)
 		rc = ipstats_show(0, NULL);
 	} else if (strcmp(*argv, "help") == 0) {
 		do_help();
-		rc = 0;
 	} else if (strcmp(*argv, "show") == 0) {
 		/* Invoking "stats show" implies one -s. Passing -d adds one
 		 * more -s.

---
base-commit: 218757a8b8bb431b382d7a104edb6ed4336d3b43
change-id: 20260301-ip-stats-exit-code-ce417579bcb6

Best regards,
-- 
Yedaya Katsman <yedaya.ka@gmail.com>


