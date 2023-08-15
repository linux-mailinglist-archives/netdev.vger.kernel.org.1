Return-Path: <netdev+bounces-27809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A52D77D436
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B3828164C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC517ACA;
	Tue, 15 Aug 2023 20:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36415AD7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 20:36:25 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9134B1FFE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 13:36:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589ee10d363so25739257b3.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 13:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692131760; x=1692736560;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dfs5Y3DHJ7npzzREtgFG2ClBmMfGqulqQ90vEMqFSl0=;
        b=OOTIDsNjwfRz3NfN2DsEPxkwUAtHn0BarheHqRBXArWxQtuawd0kUtOUNtMZett7Et
         nu21cLxYGNeXCEMGOyH8+vILYoVWUOS33hq+dNQny2L3Tm47juap+Fn7UL4GhqT3uzxP
         p6nzcrP4XDULAogIGhkjhl0Z422c2c9y3ItO59eDjnC16+LuBuUBOIwi3AxnIsPo6Ty5
         YID+gKz746bp161B+mQoC5QEpd8VNHVAp3vI7lVsaMh46Ir1jXvcm5ehHGZ0esxRXl6Y
         I87ObfOJ35XkghzSmJBbvGPoAXduYhYrDDCEn5LzpqTZ7ywM2OOaCU2T87gx2dOsih/k
         yyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131760; x=1692736560;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dfs5Y3DHJ7npzzREtgFG2ClBmMfGqulqQ90vEMqFSl0=;
        b=Z3bFDouocmcWYPbff6rSH1nxCP00OYfsiq5Z04QKNXzsfUe3kHlgLg8jN+RhIwO9kc
         XCElSxOi8ZSDycVi5qttGsboGSjW+7FmIosjEl8sH24gFZ5KTkyvENV77Zpsim6tOjMw
         FZMAftnvqakIFtLD41ZOq5hiAIDkRPgdVU1frJHD5Y+SySxRepPdZDCMBovuUb3gMMj8
         msShLiBHe/C0p9h2A2ioVCozTyohaQLQeTgPNelFABE0TU2cHlwLC++eTgl+4N4qL8uT
         5BFjou0+dbz6mbEl49DCze3nQB8LPhZEUWWzcrTTcL0XMLtoCMHjd+r8qTttgyq6s4E1
         NUHA==
X-Gm-Message-State: AOJu0Yxr8T7maAgzc2IZNQ37rElhPDheTsqWmgMAyhb8f3NcHJ5Mfs6X
	Mw8qmRJp8N5m6PZxnoFn52rGzPbSFfqug0jTpQ==
X-Google-Smtp-Source: AGHT+IHPT/nbbZXrf0e7v8EA8ROm8f0nGl7AjZVFslemOXzRPn2pjnYb4CswnMsxjZnzqsoOnywqYiXEmqVC7Dv8EQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:af27:0:b0:569:e04a:238f with SMTP
 id n39-20020a81af27000000b00569e04a238fmr174069ywh.4.1692131760684; Tue, 15
 Aug 2023 13:36:00 -0700 (PDT)
Date: Tue, 15 Aug 2023 20:35:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK7h22QC/yWNwQqDMBAFf0X27IK6CsVfKT0Y82r30EQ2EgLiv
 xvay8BcZk5KMEWiuTnJkDVpDFX6tqH1s4QNrL46Dd0g3aOfOEf17E0zLHHAwV+v8Y+yIYAxOXH jIjKKo5rZDW8tv8XzdV032dJlBXIAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692131759; l=1654;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rsuFH00o6hWgcfF4qhM/BCATheGTTTAlBcUvOm4elss=; b=fEjv5LRK1oRhxMJzmP1RlgzuD977ZksP8znSE/vd2EP5ncIcgC80vChuM2QOMrGrdKbtA/JFK
 7CLsxE+qDBeAwopuo1KxIaWMk1+bzD04MTqeHguP5oxI0t/8Scdlg7t
X-Mailer: b4 0.12.3
Message-ID: <20230815-void-drivers-net-mdio-mdio-xgene-v1-1-5304342e0659@google.com>
Subject: [PATCH] net: mdio: fix -Wvoid-pointer-to-enum-cast warning
From: Justin Stitt <justinstitt@google.com>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When building with clang 18 I see the following warning:
|       drivers/net/mdio/mdio-xgene.c:338:13: warning: cast to smaller integer
|               type 'enum xgene_mdio_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|         338 |                 mdio_id = (enum xgene_mdio_id)of_id->data;

This is due to the fact that `of_id->data` is a void* while `enum
xgene_mdio_id` has the size of an int. This leads to truncation and
possible data loss.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: `xgene_mdio_id` has only two fields enumerated from 1 which means
this is no data loss happening here. Either way, this patch helps the
goal of eventually enabling this warning for more builds by reducing
noise.
---
 drivers/net/mdio/mdio-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 7aafc221b5cf..7119eb11c00d 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -335,7 +335,7 @@ static int xgene_mdio_probe(struct platform_device *pdev)
 
 	of_id = of_match_device(xgene_mdio_of_match, &pdev->dev);
 	if (of_id) {
-		mdio_id = (enum xgene_mdio_id)of_id->data;
+		mdio_id = (uintptr_t)of_id->data;
 	} else {
 #ifdef CONFIG_ACPI
 		const struct acpi_device_id *acpi_id;

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230815-void-drivers-net-mdio-mdio-xgene-e5b3b4a3343b

Best regards,
--
Justin Stitt <justinstitt@google.com>


