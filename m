Return-Path: <netdev+bounces-63432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F244B82CDC7
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C3A283E71
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702941865;
	Sat, 13 Jan 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aWKrjmel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4331FA1
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5955a4a9b23so4000204eaf.1
        for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705164909; x=1705769709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eznmaaz1qWTcAfMUBfsMkdpl8f0Cq0KheUm1c23Ti3w=;
        b=aWKrjmelFqVd2IPzcyRUdUYCWvKhhKSw+Hns8tCNxDPmAnGklJoOb/qR+6l39my6/l
         f/VlqBXKTWKwlH0fjzJQu7abaRg6FMlYCj1oEpqJQ2MORwXGerH+s5WrWIPyBi2r/EEl
         XljHJiZTcnw2/wB9Rz8GBfgV+IvWnvjAdXhqfkMosoo8FFiKAzroNkX3gbJaPG2ufSY9
         GMIgoxPF8TKGgvuKdJYxcrHjnIyXeLuXOAYmPm3gyvgGBr/tcgZYLICcT3jmAwIpnk/D
         MospbUpEyb9VPi6WqSXRkXvlwhGQKF03S1+ywjkXyPb/DQxQDVLEGGMeJXXzsIY1srzQ
         2YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705164909; x=1705769709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eznmaaz1qWTcAfMUBfsMkdpl8f0Cq0KheUm1c23Ti3w=;
        b=moVRZ+73m4JEXtbq7c9ulaodD0cSTtfSMTDdDQkkZH9U3AKsF3q3g+Km48oRZSuHsI
         529SZzC/hFAmGFd8rv2LvMEbQJxzW27/kKS+7zzOuXM0CPIprnnvIOOp5V2g4JFjg3jo
         ictSOptezhrD5UJ5qvM1oZEdxx0Q6yLsqQls5VFI28HEu6qKgWDuewqaznIAV+K4xAk1
         v1NLEhSls1WZrUeKE1F+/kFWsAOIEDRE6uyL7YH4FOU6vyBU2SUcmjDHdiSfbyMz4JaR
         /tqZgAC7UCuIKfFHtVwrAmM/HvPmz7IxFzoDCuF+aQo+TtKXkasktwrnoHkKnldnHKlU
         ZmOA==
X-Gm-Message-State: AOJu0YwDji7RbBglS0UFSp9JHUOUsDDhwNMW/PA6KP2tE84q2sPQmUqr
	QmTy60jy7mXhreTtwbvNy6yOuiSmrRihFNKabSYucOJ3XleCfw==
X-Google-Smtp-Source: AGHT+IEAFV6aMRkkjMof7pI6uhL8p9h97nsOGiIapA4Y4xpcC2jyOWOpd0/ObP0kuuUPtHKNn8HCsw==
X-Received: by 2002:a05:6870:4599:b0:203:73bc:69e3 with SMTP id y25-20020a056870459900b0020373bc69e3mr3997595oao.71.1705164909073;
        Sat, 13 Jan 2024 08:55:09 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id sv7-20020a17090b538700b0028bf0b91f6bsm8653232pjb.21.2024.01.13.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 08:55:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: Quentin Deslandes <qde@naccy.de>
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] Revert "ss: prevent "Process" column from being printed unless requested"
Date: Sat, 13 Jan 2024 08:54:10 -0800
Message-ID: <20240113165458.22935-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 1607bf531fd2f984438d227ea97312df80e7cf56.

This commit is being reverted because it breaks output of tcp info.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=218372
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 900fefa42015..c220a0758cb1 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -100,8 +100,8 @@ enum col_id {
 	COL_SERV,
 	COL_RADDR,
 	COL_RSERV,
-	COL_PROC,
 	COL_EXT,
+	COL_PROC,
 	COL_MAX
 };
 
@@ -5819,9 +5819,6 @@ int main(int argc, char *argv[])
 	if (ssfilter_parse(&current_filter.f, argc, argv, filter_fp))
 		usage();
 
-	if (!show_processes)
-		columns[COL_PROC].disabled = 1;
-
 	if (!(current_filter.dbs & (current_filter.dbs - 1)))
 		columns[COL_NETID].disabled = 1;
 
-- 
2.43.0


