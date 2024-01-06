Return-Path: <netdev+bounces-62182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB782826130
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E26282ED5
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22CFDDD6;
	Sat,  6 Jan 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0PvbBYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C3DDCE
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd053d5683so5934891fa.2
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704567893; x=1705172693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fj3t20cSfB3/2FQ3jgJRP5M9ra6I+FVwViTGXGeot4=;
        b=d0PvbBYMr1ijwB9lRF4W4A4H+oDn/6sg2E3UqO6qrIwIKCXdK4vTjZK+bjRwqDEldh
         zs+UAQefj/yfQ8yfwjOIXmfYku7iBNHmqY0U9Wxn5uhti3VvnC74wFqrZ3uka2UXoHOe
         2WIJqZN9u10PaXJDWiy5S56Orr6fX9GCJKC3iVNlvfLqegi6X3sAspYkVMgqje7eN1Jf
         qyXzaQPw7NzZRylrG31cbUxNpnT9X33+DMFj7XpsObBWJuB/4/v7V+ZZe2bFqRQlrNgW
         BpUQib0t6eL08DwNWEu42/OV0BDdvd/50x3/nvozhCXtiCSR2+MT5xhe2N2nPyKE3MhB
         +ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704567893; x=1705172693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fj3t20cSfB3/2FQ3jgJRP5M9ra6I+FVwViTGXGeot4=;
        b=PPg1InQM+vkHp+UKM/z/mBs9Mk0SLtbc0jN0pQrIeUTslghPNlYH1/+/iZlSkLKcf/
         uBa7mt9uPqp2AUMhOVZRJi80UFGtIvJrOZGWvsYG03l72qCiykX3x2dJmbhkKczCT3os
         zUmKv16n0fs9kltZodOaxzrtw4JyGkGH5wS0SYu/AznKNQJjvlfqD7O0eCLuB7kiIwo+
         D8WBlxlpahyRODq04grbs6s+s3hirjp0ZvrFsn03e5K9TWhu7i6U9BlntpuGwHQXGhLH
         Ki2Kk3AM/c958+XrB1C0SApkHN4t0Uh9IYpeM+05Xy9Ba6C3CJfAMHw3XrVI7uqezwxe
         1naA==
X-Gm-Message-State: AOJu0YzYtjXj8dtZnU7REVKOuUFhilxZU4C9+q360Q4A2/NrA/vaD62l
	/Zr7PzeKT7V2ZlzekwkRZzskhuWAFtBaYA==
X-Google-Smtp-Source: AGHT+IE9oBdlbLBc4cz1obocTceQzT1G2obdLp/tYHpJZ3iKznUjRA9xA4vaPXMy3AHVysU2ehv2Jg==
X-Received: by 2002:a2e:8057:0:b0:2cd:10aa:7628 with SMTP id p23-20020a2e8057000000b002cd10aa7628mr526358ljg.8.1704567893113;
        Sat, 06 Jan 2024 11:04:53 -0800 (PST)
Received: from localhost.localdomain (89-109-48-156.dynamic.mts-nn.ru. [89.109.48.156])
        by smtp.gmail.com with ESMTPSA id a8-20020a2eb548000000b002cb2380239dsm743110ljn.20.2024.01.06.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 11:04:52 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] lnstat: Fix deref of null in print_json() function
Date: Sat,  6 Jan 2024 22:04:23 +0300
Message-Id: <20240106190423.25385-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now pointer `jw` is being checked for NULL before using
in function `jsonw_start_object`.
Added exit from function when `jw==NULL`.

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 misc/lnstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc/lnstat.c b/misc/lnstat.c
index c3f2999c..f802a0f3 100644
--- a/misc/lnstat.c
+++ b/misc/lnstat.c
@@ -112,6 +112,10 @@ static void print_json(FILE *of, const struct lnstat_file *lnstat_files,
 	json_writer_t *jw = jsonw_new(of);
 	int i;
 
+	if (jw == NULL) {
+		fprintf(stderr, "Failed to create JSON writer\n");
+		exit(1);
+	}
 	jsonw_start_object(jw);
 	for (i = 0; i < fp->num; i++) {
 		const struct lnstat_field *lf = fp->params[i].lf;
-- 
2.34.1


