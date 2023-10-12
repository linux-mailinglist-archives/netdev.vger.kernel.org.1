Return-Path: <netdev+bounces-40502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971517C78A7
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548BA2820F5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B523F4A5;
	Thu, 12 Oct 2023 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3CIIv3g"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198F3AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:33:36 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA4DD
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:33:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d99ec34829aso1989476276.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697146413; x=1697751213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYSTVrCouVWE319gwaD4mDagDCplKYTMAl9k6NN6p0U=;
        b=j3CIIv3gCVmU9R0l2dslE+oPVXaVD1Wa12FQFQirrDPseN8A6dyuCjQkG4CehA7t1K
         zIKzQ/jnbO72wkULosOjGE3p2+FlOAojLHQt6Yhpgen1kY01ui21t7uupxt9dbDP7NBW
         Xsl7U0Ceuwcax1UQPZSnQ4gZzAz5K+Q20nqi2u7o2OnxBs0I4R91gOBp4hg0G4OTFwzC
         M/yTkOKiVBVDy/udMkd/tg9/nBLXJZ8WYkmYMYiW3RKBbYU40THgrA0nEhjEpn4veDd7
         SL55rM0LcZY4zrw+T2zRKByaW6gfhT1IBAhRWlYd7QkxJM1KA4s40A2t6S0cvivV35Gg
         IlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146413; x=1697751213;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYSTVrCouVWE319gwaD4mDagDCplKYTMAl9k6NN6p0U=;
        b=jVBIWp45zVum0Uu63QFGOzCQslqWbN0+qepfGzLyKGOERGV+5TDdyJ5xNCZxLKntwh
         +LtJGrpgzeOLOFMchjSHDp3//Wm246E0TlhldWN+nuBTc+YWX5CpB9s2cjnRgHtSJ8UZ
         7IF6WmPQuL9z/xqpPVX3TkiJx4AEPiwfQevLn7nvGJv4HLfk3jnYDWbfwOeQTkzt/4cr
         tXc+cZS0aj9pN21CPL6d9uB1B32zMB7ffYJmgI1x86CJCyPVteID/AWc0bJPsr0b3k8P
         6byVxBIchhrem7uW+W8Fb0rqer/+h3y5fKHSiwgY/BHi7uZ4vig1x5u+pm+ceGLa41ty
         z3zg==
X-Gm-Message-State: AOJu0YwVOa3v76qOHNrxxU4R9ANJfT7roQXabdue+zkv6ft9f5c9bh9R
	AbUh1/ewCtxAEesHDv0Z2RcF3BQJIu9ouZGlrA==
X-Google-Smtp-Source: AGHT+IHLXU+q2owngkTbSiNtMR5BADqKtueGDHMDZYEex8Po8KdOypDGg++9ce6J7+BSWDwmTy9Wy7uJXqIZ+5F3rA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:361e:0:b0:d9a:6b49:433d with SMTP
 id d30-20020a25361e000000b00d9a6b49433dmr164492yba.6.1697146413504; Thu, 12
 Oct 2023 14:33:33 -0700 (PDT)
Date: Thu, 12 Oct 2023 21:33:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACxmKGUC/x3NwQqDMAyA4VeRnBcwVcbcq4wxahpnDrYlFZmI7
 27Z8bv8/wFFTKXAsznAZNOiKVbQrQGeffwKaqgG17qOWnJYVoucdwymm1jBKCvOfjEfNOHod07 LR3JGxrsQ8dA/unGYoPayyaS//+v1Ps8LZduKZXsAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697146412; l=2666;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=GEipWyiXVMyF4NttCT1RNho91xfYNJdcMAw0nEmg9aU=; b=x7E6v7q0m/O/QprpRqxWPblE89KJH/8AAzMt116g3gzow9M2f7BwcEy/LlgWAsSKhgaWC4jk0
 9TdRQ3QWP87CvCdaWXAAGHMw7Gj12xOELpNOijQRm8halo5ZaaCR6zx
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
Subject: [PATCH] hamradio: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Thomas Sailer <t.sailer@alumni.ethz.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
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

We expect both hi.data.modename and hi.data.drivername to be
NUL-terminated but not necessarily NUL-padded which is evident by its
usage with sprintf:
|       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
|               bc->cfg.intclk ? "int" : "ext",
|               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
|               bc->cfg.loopback ? ",loopback" : "");

Note that this data is copied out to userspace with:
|       if (copy_to_user(data, &hi, sizeof(hi)))
... however, the data was also copied FROM the user here:
|       if (copy_from_user(&hi, data, sizeof(hi)))

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

Also, there are 33 instances of trailing whitespace in this file alone.
I've opted to not remove them in this patch.
---
 drivers/net/hamradio/baycom_epp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index 83ff882f5d97..30a0fbb12b9c 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -1074,7 +1074,7 @@ static int baycom_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		return 0;
 
 	case HDLCDRVCTL_DRIVERNAME:
-		strncpy(hi.data.drivername, "baycom_epp", sizeof(hi.data.drivername));
+		strscpy(hi.data.drivername, "baycom_epp", sizeof(hi.data.drivername));
 		break;
 		
 	case HDLCDRVCTL_GETMODE:
@@ -1091,7 +1091,7 @@ static int baycom_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		return baycom_setmode(bc, hi.data.modename);
 
 	case HDLCDRVCTL_MODELIST:
-		strncpy(hi.data.modename, "intclk,extclk,intmodem,extmodem,divider=x",
+		strscpy(hi.data.modename, "intclk,extclk,intmodem,extmodem,divider=x",
 			sizeof(hi.data.modename));
 		break;
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-hamradio-baycom_epp-c-6e11c9483b9f

Best regards,
--
Justin Stitt <justinstitt@google.com>


