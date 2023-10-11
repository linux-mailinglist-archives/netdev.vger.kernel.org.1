Return-Path: <netdev+bounces-40152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295A7C5F94
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E083282534
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261663995B;
	Wed, 11 Oct 2023 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X34h2Y2P"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12261CF8E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:53:47 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF739E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:53:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso413945276.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697061225; x=1697666025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0mEh2eQbdOiMZkH+CgX68hk8AnM/JOc/WD0lj3h3vo=;
        b=X34h2Y2P+Q5oHS2+qlEu/nfKIp10yRHS09FNOvi88rGu7EqT8oo+vSeY+8nLAEikoj
         w3Hs1IuM/aATxMb5GxxI4jS9vGCLEdQwyz8wgCTVsvz8mKNJnE0IzRGcvAKk5Z+Ve6NJ
         kLolAGeqle0xrOHIEC0OYQNgtiy4syqDeq3d9RybMa7/dHc/uf4PKcRDYFSEVEC7EVGy
         VVuzW2DtKNhowJ80PlhTEfnNKNF9/QwW+EYyYM47e13lPreGMwMUvN1ahRZA9+e90F8Z
         CU1FRlvwPqXBPbAvLG1VhuPKSrh5Pyhc7RZbbv9RhBxfDmtqwr6kGKMP9jyvX3zotKTA
         G2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061225; x=1697666025;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0mEh2eQbdOiMZkH+CgX68hk8AnM/JOc/WD0lj3h3vo=;
        b=vp+VOgbBVNGZMv463k9JLYM/R9YBr40bkDmOydjMLOWIRBlKIUfVRhAjuaeac6TS7x
         Ta5jvZsh2ynA6JGG1HbxV1NGe+/nTuX0rwwJ0Ue9g/6OukSUcYGaKeA5spzpDKQKx7mz
         hZKZnJYkSj9Axi6zYnLZt+wY5kgYfqInvvoEEuq2skZi+lTkReLsom4hOY83AgsLY8po
         3EvI/JY6Wyyte3djJdlSU6PANrFANaDC6CRuQmm1jIQDzJ+9UyuN79n0XfC0lQUpyPKC
         NHabbqVM3gN5DxfOSCCklhpic9IGQ1RBNwXk7JlrrzzRMnywYZ3JQkeVe1G1Zx9yzxy6
         lYNQ==
X-Gm-Message-State: AOJu0YzHeMuHzRi46N3ngOd06XkqcGppH0i8FD3SkXnFHIV1DQfbDhWK
	byAyiQnk0PvpU3HjEJgLiB5dgTca44l/cuki1w==
X-Google-Smtp-Source: AGHT+IEXNxC5u7cyo6EzXWEZxvQryMMMVtV0GnYvMVdnh1TDPLsWmBI2chv/jJx3JlUicFWGPx//4VMX8BWxX8RTxw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:1f56:0:b0:d7e:7a8a:2159 with SMTP
 id f83-20020a251f56000000b00d7e7a8a2159mr373076ybf.5.1697061225382; Wed, 11
 Oct 2023 14:53:45 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:53:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGcZJ2UC/yWNSwrDMAwFrxK0rsByFv1cpZRibKXRooqRTGgJu
 XvddvOY2czbwNmEHS7DBsaruCzahQ4D5Dnpg1FKd4ghjhSI0Jtprm8sJiubo3JDbjPbFyqrJy0 L9ork/96fSRQzHsN5Ok3EaaQIPV+NJ3n9rq+3ff8AtMyfvYoAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697061224; l=1801;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=nMuSVOhysev7uUh/Sd/w6qnA6sjV53pd+anm3qSOdWM=; b=YIDWB6LpP36QEb79ACUN9X7xFlKvJc7IleF4p1QG5Yl7uybR9TYv1KHDJInStRLYBNOkkGYBj
 dIGBBHJSvRSBT/tC28YNnxzt1ZJI6cXmWHQHfQRcbejP0mHLDgv4Y5x
X-Mailer: b4 0.12.3
Message-ID: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
Subject: [PATCH] ionic: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

NUL-padding is not needed due to `ident` being memset'd to 0 just before
the copy.

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
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 1dc79cecc5cc..835577392178 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -554,8 +554,8 @@ int ionic_identify(struct ionic *ionic)
 	memset(ident, 0, sizeof(*ident));
 
 	ident->drv.os_type = cpu_to_le32(IONIC_OS_TYPE_LINUX);
-	strncpy(ident->drv.driver_ver_str, UTS_RELEASE,
-		sizeof(ident->drv.driver_ver_str) - 1);
+	strscpy(ident->drv.driver_ver_str, UTS_RELEASE,
+		sizeof(ident->drv.driver_ver_str));
 
 	mutex_lock(&ionic->dev_cmd_lock);
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-709f8f1ea312

Best regards,
--
Justin Stitt <justinstitt@google.com>


