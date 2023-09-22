Return-Path: <netdev+bounces-35791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3847AB129
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2417B1C20927
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27217200AA;
	Fri, 22 Sep 2023 11:49:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6E1F930
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:49:22 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA5FB
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:49:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7fd4c23315so2530474276.2
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695383361; x=1695988161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZXyxGhzRige3UrB4+p+4v9PuPDCzdTgmyjbIDA5ZLsI=;
        b=OHfFpdVsqTbk1xz2ltjUuf82IirAGWVU6a0u5Vgr21Kn+p8XJRTIfJEsRLm2XwJKbB
         lkdEQX+AwDUtZZEQkp6YlQ9dBspKJ1XbrKyWZiasCwsCi1MmKzsVOmfpX771aiorKCBE
         M7Q9+OusHbrTtosDsw73g8IIR2CaKm03GUkCZWbneGiVCt/NkcehxyHmoxCkguuOK7nD
         qFIORvX26lrL3EYToac+HS6knwKgC9omN/9ee/gHPQq7FJBZiNhH5RfLAKP0wttnswMO
         CQKNRMv+qqOszeX3E5kRsn4sjxPwvU3rB6szVwqdkS1J89BFhLAwMfABfKFg7vyqcBtq
         FJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695383361; x=1695988161;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXyxGhzRige3UrB4+p+4v9PuPDCzdTgmyjbIDA5ZLsI=;
        b=gr4ananUO6hIkLk782Lzpdjotnxm36oPYPZ7CYmWe+giM7IeEtdsIIHFplmW9SWjY0
         au/3Y4Dg2SAMlT1ldmEmFhxiUH8pZxpNj9qzTsCb/CutC8vSSRZp/jCkCeH+Za9ls3St
         9XEG5oZZhw0pUT64F8hW8lGd+dEXwBJDB4cEafQ9XdrL/jAUDzzLthW0eLqNG0fITZaQ
         o+JYNXbh0/65BPsLtPf1rRoGisjIixUXTtyb37C20QgJYbGXePWVtMshI00q0vbFWCV3
         DWuCuq+xBxKlzu7Zma7m7jgQ2ZAYpsGPqX/ngk3lJWqHEHgRKBElClok0KOvIINpAPgu
         2B+Q==
X-Gm-Message-State: AOJu0Yxnwr3IN8XQdH6eD2VUbrc6geYcTCeFxvHnMBr2NKAHZKJ6sI6K
	pkTgWbRNE/h3ryAEHDjLuww1iXeyTf8z9KglaA==
X-Google-Smtp-Source: AGHT+IElfQgQT6wbMncjFiA2exW2yO6eLXVY/tVVnaY3Q2kjEceLwN/PBhRPZKSywO8cyHS5x88dUl2JI+F/ZL/jrQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:7c5:0:b0:d7f:f3e:74ab with SMTP id
 t5-20020a5b07c5000000b00d7f0f3e74abmr127533ybq.1.1695383360879; Fri, 22 Sep
 2023 04:49:20 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:49:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADl/DWUC/x2NQQqDMBAAvyJ77oKJxmq/UjxIsmmXQgy7RRTx7
 4ZcBuYyc4KSMCm8mhOENlZeUxHzaMB/l/Qh5FAcbGu7drIW9S/J5wOD8EaiyBoS+iUz/io9OjN E84xuGsYeSicLRd7r4z1f1w2gXhc0cwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695383359; l=2302;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=xmrjKIrKcccHwiQZLHhc+QD8XbzmyrFL8mHFb+Gfs4A=; b=qG0dzg9B6wVI/G86xbbk5dMi4zCmbwp8XMwL+vzCUiOwXjupj59HG/9MKVk0SHfEhICTweQTX
 Yx6PC25TXp1CgXLQZCRqikxujURFcztXUoBCmjwhvdV8dS45F85qshL
X-Mailer: b4 0.12.3
Message-ID: <20230922-strncpy-drivers-isdn-capi-kcapi-c-v1-1-55fcf8b075fb@google.com>
Subject: [PATCH] isdn: kcapi: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Karsten Keil <isdn@linux-pingi.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`buf` is used in this context as a data buffer with 64 bytes of memory
to be occupied by capi_manufakturer.

We see the caller capi20_get_manufacturer() passes data.manufacturer as
its `buf` argument which is then later passed over to user space. Due to
this, let's keep the NUL-padding that strncpy provided by using
strscpy_pad so as to not leak any stack data.
| 	cdev->errcode = capi20_get_manufacturer(data.contr, data.manufacturer);
| 	if (cdev->errcode)
| 		return -EIO;
|
| 	if (copy_to_user(argp, data.manufacturer,
| 			 sizeof(data.manufacturer)))
| 		return -EFAULT;

Perhaps this would also be a good instance to use `strtomem_pad` for but
in my testing the compiler was not able to determine the size of `buf`
-- even with all the hints.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/isdn/capi/kcapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/capi/kcapi.c b/drivers/isdn/capi/kcapi.c
index ae24848af233..136ba9fe55e0 100644
--- a/drivers/isdn/capi/kcapi.c
+++ b/drivers/isdn/capi/kcapi.c
@@ -732,7 +732,7 @@ u16 capi20_get_manufacturer(u32 contr, u8 buf[CAPI_MANUFACTURER_LEN])
 	u16 ret;
 
 	if (contr == 0) {
-		strncpy(buf, capi_manufakturer, CAPI_MANUFACTURER_LEN);
+		strscpy_pad(buf, capi_manufakturer, CAPI_MANUFACTURER_LEN);
 		return CAPI_NOERROR;
 	}
 
@@ -740,7 +740,7 @@ u16 capi20_get_manufacturer(u32 contr, u8 buf[CAPI_MANUFACTURER_LEN])
 
 	ctr = get_capi_ctr_by_nr(contr);
 	if (ctr && ctr->state == CAPI_CTR_RUNNING) {
-		strncpy(buf, ctr->manu, CAPI_MANUFACTURER_LEN);
+		strscpy_pad(buf, ctr->manu, CAPI_MANUFACTURER_LEN);
 		ret = CAPI_NOERROR;
 	} else
 		ret = CAPI_REGNOTINSTALLED;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230922-strncpy-drivers-isdn-capi-kcapi-c-516f17f59684

Best regards,
--
Justin Stitt <justinstitt@google.com>


