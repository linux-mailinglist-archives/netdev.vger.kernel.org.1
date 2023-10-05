Return-Path: <netdev+bounces-38424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807037BADC7
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 239911C20904
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299042BE4;
	Thu,  5 Oct 2023 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yih8VVQV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BA41E59
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 21:41:05 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588CADB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:41:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f67676065so21254897b3.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696542061; x=1697146861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUNTafqkYZ7pS8TSpllde2onzuaLMD5Rpj1fQvAjFxs=;
        b=yih8VVQVbfsOJD+xe9G7VSjmr3gkSrWedv7OE+hc/NKhaEz52vDlJjfpANDyNCOo++
         ZuJQ5KRjVDHPo3XqJ+3Fi9+WyvUDWIRT2JMMe2m9BamJcMN7BXvENbovA9X18peyHhY2
         CYe/EFiW+eEqOOFmJ5qGoW1QFRdrwmx9o5Wz9wYT0cygBGmU9GdUgKjmziDI6554PGNM
         JvREF67MTmmfgu2+KTBQHUZREQ6k1YrkV2Gcg3M/myhyUZHmt/Rpdrf4bbKJQLymPb8O
         Uw1RfHbJr41a9wxTeNqTy0PQ3+o1lK3YxuX58TOExUz0iXqBa9QSwaTUsM8yVwnyifNg
         jEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696542061; x=1697146861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUNTafqkYZ7pS8TSpllde2onzuaLMD5Rpj1fQvAjFxs=;
        b=b1yL/jqkBHjsQpznd0WczUgNKI9s0M6ttIXmV8PAZCWOAqydZfqh1KCDXLxM05DaLY
         3ab1HvD8I4LxfS0hbBccAZYMGzt3dfc0c5fUi94SXELd1H+t9D1cshxKc0zbl9HeCPww
         iMSei0KE6v+LPeKJST7jl7No5U9Qp1k3NmKPj5+SEGZHlqtUkfSrkQfo4kwnHPaJb6y+
         qZ/dlGnKpfoltWKBGM7MBd6dOGBR7y+sjiEaKSeYNdsjA+7tgJkOyeWQntu2m+4S/acG
         EDNV3Ud5I1CpTiiU5+F9/oqabX6DqAJHlKCzZR2fHYojj34Xit/wA9otROdvl0abMfbh
         WQOA==
X-Gm-Message-State: AOJu0YzQhTyXKVoX1vZWLmfcRc8C9PPv8t6PskR1xRGVzhv2RbFO5u1C
	ZgxRfLNdhwYEm7Uhx06ujDdH6CjFz8HUfvjsmQ==
X-Google-Smtp-Source: AGHT+IHIj5z+jvjYSjnBQF7WCdI7cYn9+zHtt+lT2Tek1tSQxg8/n/kE/wh2oRCpNDC0LT+wVxbd/NvsJuSfkIjCmg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:bd08:0:b0:59b:c811:a702 with SMTP
 id b8-20020a81bd08000000b0059bc811a702mr115088ywi.6.1696542061583; Thu, 05
 Oct 2023 14:41:01 -0700 (PDT)
Date: Thu, 05 Oct 2023 21:41:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGwtH2UC/x2NQQ7CIBAAv9Ls2U2gDWj8ijEGYWs3sVAXSjRN/
 y56m7nMbJBJmDKcuw2EKmdOsYk+dOAnFx+EHJpDr/pBK2UwF4l++WAQriQZIxWkMpH8wLvK64x Pfq0cODVIt9lxRI93ZcbjyVptBwOtvgiN/P6fL9d9/wIUVboaiQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696542060; l=1918;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=yhFq2y5Pvep99s3JFnDeKpoF+G2I2fKxp4dpMs9PGrs=; b=IYKSrXCoOucrIGOtUWa4qysZwdksei5CHi15EgsgQOrR/qCXqCUliEBjohbluw3vTmot+IDW9
 T5berNGOdbtBJlSvm1r9BfJbMiOaF5ISWKSrN++2bykFZjoprZKmXdg
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-v1-1-663e3f1d8f99@google.com>
Subject: [PATCH] net: liquidio: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Derek Chickles <dchickles@marvell.com>, Satanand Burla <sburla@marvell.com>, 
	Felix Manlunas <fmanlunas@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We know `fw_type` must be NUL-terminated based on use here:
|       static bool fw_type_is_auto(void)
|       {
|       	return strncmp(fw_type, LIO_FW_NAME_TYPE_AUTO,
|       		       sizeof(LIO_FW_NAME_TYPE_AUTO)) == 0;
|       }
...and here
|       module_param_string(fw_type, fw_type, sizeof(fw_type), 0444);

Let's opt to NUL-pad the destination buffer as well so that we maintain
the same exact behavior that `strncpy` provided here.

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees both NUL-termination and NUL-padding on the destination
buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 100daadbea2a..34f02a8ec2ca 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -1689,7 +1689,7 @@ static int load_firmware(struct octeon_device *oct)
 
 	if (fw_type_is_auto()) {
 		tmp_fw_type = LIO_FW_NAME_TYPE_NIC;
-		strncpy(fw_type, tmp_fw_type, sizeof(fw_type));
+		strscpy_pad(fw_type, tmp_fw_type, sizeof(fw_type));
 	} else {
 		tmp_fw_type = fw_type;
 	}

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-b05f78661635

Best regards,
--
Justin Stitt <justinstitt@google.com>


