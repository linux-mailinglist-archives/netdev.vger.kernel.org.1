Return-Path: <netdev+bounces-39349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE73F7BEE70
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E696C2818F3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9E18B1F;
	Mon,  9 Oct 2023 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DmPAehzv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8FB1173D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 22:47:40 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0379F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:47:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f7d109926so77245937b3.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696891657; x=1697496457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2JxJfBT4mqTTWnkuNgqYZhhygki461FFicbWyOS8kMU=;
        b=DmPAehzvoTwkKdspLj51IBwSEzAFLp6fjnm20o3YJ/KuILkutjMKDgPEHiJ2qpCrAh
         wO7ncqUy8274bSTlhusCsAnGQ70FtjMznmruxDj7lWKaQBbMnSOkaKXO/pl44IiqAhsP
         XsvIcI+2d1uLlLLrUqdoQ4Gqdx5bTe3xL4ZcLCLaVVWTITDVqXgUouLG0vopNvSBhc8a
         kDWUynDXQamaethdZsg5I592cMmLhEu6FHLe9QFCuljCYHlp7jB0aJ31DP4OqTfbhgxa
         tgMLcDS4V/luRjx7R8pfkZ5/gw1TfmkqVO+e/5hSKGDeZxeTQ9f1x0y/PjDIwH9C6xOh
         Mtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891657; x=1697496457;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JxJfBT4mqTTWnkuNgqYZhhygki461FFicbWyOS8kMU=;
        b=hs2aib5f5PYobpjoE2MhXMTy85jlhV/pYBJWlFsJRIr8mE+mxptKIz21otwsyowN0X
         uhsdWJpaNFKgYEMS+FiSl56xnk76aRQm5+y2fFCiQ8rJ9KKM0C7f/RaucaWKN1ZWIVJO
         wqGUleGEAPE8s0Ou5CVl9IsJZse/V7SwHSgi4BGi17cEKPooB3GUvTk+fOLyHSUTGnCY
         UjrGZoyeAiMwrU6v1Q4XldMgh1KlFwqcBNq059tXIcEXOKzTuWPK/erWGIGT1p2mh7JJ
         HEJ7GKRk+TCLF7gnrizcJ/M8kNEfHygBr0bLaiq3ZgI108YUJC/Xc8dHw6A64y4EekIh
         2XKA==
X-Gm-Message-State: AOJu0Yzqm6gXA4vj0589wN9AMNTeRS8+BEy9bu9X24RmZQD5XmJQkVlM
	eF9QaW1ImtINpYFYzHXzZXYzN+JMqbwcYC9ObA==
X-Google-Smtp-Source: AGHT+IElN9GkpT3U2xvrH7+kjhlHlG+bmfY+dBqb/0nsReSoHqtmIJ/Qqs5nM/0N4BjpBVaPpbPj2pXTmOviCVtSrQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:2a0f:b0:5a7:aa51:c08e with
 SMTP id ei15-20020a05690c2a0f00b005a7aa51c08emr38184ywb.1.1696891657694; Mon,
 09 Oct 2023 15:47:37 -0700 (PDT)
Date: Mon, 09 Oct 2023 22:47:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAiDJGUC/x3NQQrCQAxA0auUrA2kLQ7qVcTFkKQaLNOSDEUpv
 buDy7f5f4dQNw24dTu4bha2lIb+1AG/cnkqmjTDQMPYE10xqhdevyhum3pg0YoSGV3zXPWNXuf LmBLy4oqMiTJNJMJnZmjR1XWyz394fxzHDzHi6qqAAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696891656; l=1743;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wtw1m2N4k6i9bXVmmrVL0qb6WJmJ01VqahgGi3xl8qU=; b=KSLRqEm2ZqeXXCS1E3PZL8ukrOE9+X+1GQ0FA+gBqwC/r+hSaMsJlHCmEWNAH5+mcSDLOMho1
 qP2UVgg2jHxC9Qn+PsWDNqkGJi73jv5FRKqRIWkKFdYvO/bGMOrfOqe
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
Subject: [PATCH] net: dsa: realtek: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
	"=?utf-8?q?Alvin_=C5=A0ipraga?=" <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/dsa/realtek/rtl8366-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366-core.c b/drivers/net/dsa/realtek/rtl8366-core.c
index dc5f75be3017..b13766a3acbb 100644
--- a/drivers/net/dsa/realtek/rtl8366-core.c
+++ b/drivers/net/dsa/realtek/rtl8366-core.c
@@ -395,16 +395,13 @@ void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 			 uint8_t *data)
 {
 	struct realtek_priv *priv = ds->priv;
-	struct rtl8366_mib_counter *mib;
 	int i;
 
 	if (port >= priv->num_ports)
 		return;
 
 	for (i = 0; i < priv->num_mib_counters; i++) {
-		mib = &priv->mib_counters[i];
-		strncpy(data + i * ETH_GSTRING_LEN,
-			mib->name, ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", priv->mib_counters[i].name);
 	}
 }
 EXPORT_SYMBOL_GPL(rtl8366_get_strings);

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-60a0f0ddc5cc

Best regards,
--
Justin Stitt <justinstitt@google.com>


