Return-Path: <netdev+bounces-43631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D93987D405E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E12CB20C7C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3F224F0;
	Mon, 23 Oct 2023 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZLrZw0Y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149D224D3
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:39:47 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2FD10D
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:39:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7aa816c5bso50879257b3.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698089984; x=1698694784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9EIZiW1HwjzgzPQnsdOlRK+mgWuyYzh91PBmK2SZvQ=;
        b=pZLrZw0YfuDygzr91zxC7gJYE5umiWM/sbZ6RQSoXdcm0v/A/oninyLNitxrTWpnNZ
         hWqqH2CFK2iaunA47NRngSe5yJ/mAiJpq7Zs7enmDKe3QN1xJIU4+oLQDdPsY+j/ulXi
         Q5SJuGfNjNG8XJmmG3lj0iFlN+w0kUT2Nweq2oBcpRUccS4kc13c2eKDATqTJs6wCMGg
         LMmedRNCfNa1gsdPmIIcKd3opb+pSU+y8uyUSjHmMiC8LBZX1UfDlLVGmBGJOzdsb+VA
         h6osO4rORHD5Tw8W3biqAIB3MvPFGEXP6U17OWakeWiuWhesz2aXd8ZcvT7YR/fE18Wf
         dKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089984; x=1698694784;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9EIZiW1HwjzgzPQnsdOlRK+mgWuyYzh91PBmK2SZvQ=;
        b=mVTRLYv/ZuaUuZ9Ea0cMUk/D6a/NxNsDsVmbqeKZ1eq0FUKB/m7tXNuEJyVcXLtgGq
         e9VKCFUYWL3i7e1XBSvqn/iCL01h97lUyKgi9ZV93moX1pdPq4DV3LPFFkBkCKRXT+Yp
         GR5G8m6oPQUNTJBAt5b5XTeOJZpGZfngbTWO/V8kYemK8H98KLsTNVuzst2lkv6RhXS1
         j/KehnWofkYZMUaJY/h/ilY3AlHuP21qqerSbnSyWg3ZMYf/K+P7L6+DyRnbT9lNeEZO
         psJomEPfvfS1+dUQeF6e1goOlq5cIS1C4CaOQAKgxVW7gueyO43cka+s0W/dCgfCV2GQ
         /JJw==
X-Gm-Message-State: AOJu0Yxgn4zu4FBKX8jFL9QTg0jta8wi3RCpRCyPjIdhjtnyHfjxVElg
	hi1ZpLOxD/MYqHYJIHatl0o2Vw1dgIi7VdJgiA==
X-Google-Smtp-Source: AGHT+IGK4A3kzKHMuI1vfQcGREADhmi6Xw83SP8yDuQv0J3EKfsflMNbU94U/eagV1Cxkz8W4vwLPtTNxoEOQ4RlHg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:524f:0:b0:59b:f3a2:cd79 with SMTP
 id g76-20020a81524f000000b0059bf3a2cd79mr209796ywb.8.1698089984390; Mon, 23
 Oct 2023 12:39:44 -0700 (PDT)
Date: Mon, 23 Oct 2023 19:39:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPrLNmUC/x2NwQ6CQAwFf4X0bJOyJKL+ijEEl6f04ILthkAI/
 +7GwxzmMrOTwxROt2onw6KuUypSnyqKY5/eYB2KU5DQ1AX2bCnOGw+mC8zZm6twQuYv8tjFydB 9ek0cWZ4CyOXcBkQqvdnw0vX/uj+O4wfaSOZzewAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698089983; l=2072;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=M5RJKmWPvcJapRTNGdtENHYtsTUHGQvR0yt/b2ASDXM=; b=ZhkAnJlpERSNbPEUqrn6noB5gdUU1Q+eak5GCE3RG37c9uzSozI+Cq7MPmxpD2XXjuYIF4rjZ
 ZcOVJ3phr4bD4D9lgbRI2UQc3Ts2rIWms6GJlebnY2kx5Na3GN7KOpl
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
Subject: [PATCH] s390/qeth: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Alexandra Winter <wintera@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect new_entry->dbf_name to be NUL-terminated based on its use with
strcmp():
|       if (strcmp(entry->dbf_name, name) == 0) {

Moreover, NUL-padding is not required as new_entry is kzalloc'd just
before this assignment:
|       new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);

... rendering any future NUL-byte assignments (like the ones strncpy()
does) redundant.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cd783290bde5..6af2511e070c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6226,7 +6226,7 @@ static int qeth_add_dbf_entry(struct qeth_card *card, char *name)
 	new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);
 	if (!new_entry)
 		goto err_dbg;
-	strncpy(new_entry->dbf_name, name, DBF_NAME_LEN);
+	strscpy(new_entry->dbf_name, name, sizeof(new_entry->dbf_name));
 	new_entry->dbf_info = card->debug;
 	mutex_lock(&qeth_dbf_list_mutex);
 	list_add(&new_entry->dbf_list, &qeth_dbf_list);

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-s390-net-qeth_core_main-c-0b0ee08672ec

Best regards,
--
Justin Stitt <justinstitt@google.com>


