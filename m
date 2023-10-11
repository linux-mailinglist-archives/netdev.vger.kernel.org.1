Return-Path: <netdev+bounces-40141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386497C5EDD
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339DC282512
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACB01C2A8;
	Wed, 11 Oct 2023 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTRnspRK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237E15AC2
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:04:42 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7711593
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:04:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f61a639b9so4251787b3.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697058278; x=1697663078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BxaWGDSeY2dIkY2twK1W0ApQNsW9w47t9mTViMZ06zU=;
        b=pTRnspRKfDoJ3DiY2sGbABeR0vRBs5KytRvmTbcy4qcz8mCnaD0IYssPeKUbiiHpet
         3OKQFgagX6LnyqJvGsspp6CmB1ev/hyu70aR9Bg7E4iy76wnfgiQMTyR+zr3M68bdgaB
         OZLQGZYPp9LgUn7FlK5ZhhXyso8TtDFDi8JE077S1FM1ZpBvhQHIcUOReZ7swkbcrw/F
         f+vM/4grWm0UNcGJ8BGaIOtuJ2daMqvGjm4pnFCYc5/76L54TyiLe0uw1i/Rq0ygVWah
         35FfXP2T51hzFniuT/KAJbhXuFwXVhp5QNhQMmkDELd1TLjqPQV4VB4dbyJHD2E4Xrm2
         /qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058278; x=1697663078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxaWGDSeY2dIkY2twK1W0ApQNsW9w47t9mTViMZ06zU=;
        b=poEDZWs9qMRyZDNOi8tgSnPpxqpwLOFdfU7pre7UYUpLI34Wp7dnDmAJ5aAYxvafR8
         ysJCd4xaLQSgf3CvdQtzkO2+P8kVSq14484k53ICHNx4NyZw5w76kZudVhmubsGBZW7c
         Bx1cqe6LuA1V3UpwN6Czpf5J+X8gnAbZHUsVs0Huj8MsgQaNDWm/v+6ewMDCrgmFK+lP
         qa0jjyRf/prUoHqPG/sKjPixmhek0w218b34g6GbMobxwkkuOW8JZqxaMkZw0fGiMDnb
         hRbUAF/hU1Qmj3L0La7myz9ELXAnlCcs/STmvnrDrvBKv9U8z6UAl4HT+h4FrG2I0HHA
         Zaew==
X-Gm-Message-State: AOJu0YznXi4xBrj8QrcuRbKqqGQXSoJ1Z64BrK2lhtajQtzN6Ge99nPd
	0J8q1j9Zy6qJu/099k1MkvTXakINk71PFkOeGg==
X-Google-Smtp-Source: AGHT+IEwQ2LwAmN3p2AyQxhcz2QzPlunl9q2EyaOioXCheByednY9g118PcUomxF897RqpVZ2rL7NqiTzxx+BrIMzg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:a909:0:b0:59b:e97e:f7e3 with SMTP
 id g9-20020a81a909000000b0059be97ef7e3mr403659ywh.2.1697058278584; Wed, 11
 Oct 2023 14:04:38 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:04:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOUNJ2UC/x2NQQ6CMBAAv0L27CYtiopfIR6adpFNykK2DdYQ/
 m71NnOZ2SGRMiV4NDsobZx4kSr21ICfnLwIOVSH1rRna6zFlFX8+sGgvJEmFMpIeSL9wUwxOlk KzrFccHyjx+vtbvqu60OwDmp1VRq5/I/D8zi+U+4EDIEAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697058277; l=1896;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=iM4RgTWWhWZP4eA/MAnbDxA0QWNmel85KFAk0bSECCw=; b=Mi1kOWdyu5N3mq/FWAZBWweOspZuCsbEWolDFFAMzhwq3MN2xlS5N+hX0SBc+sEuxPp+FXaxs
 S1P44k6m1RVCBibuSe6W6nXbwXsKcpeyoPtF3ALMhXIAUT5jMNiVGKY
X-Mailer: b4 0.12.3
Message-ID: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
Subject: [PATCH] net/mlx4_core: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
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

We expect `dst` to be NUL-terminated based on its use with format
strings:
|       mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);

Moreover, NUL-padding is not required.

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
 drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
index fe48d20d6118..0005d9e2c2d6 100644
--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -1967,7 +1967,7 @@ int mlx4_INIT_HCA(struct mlx4_dev *dev, struct mlx4_init_hca_param *param)
 	if (dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_DRIVER_VERSION_TO_FW) {
 		u8 *dst = (u8 *)(inbox + INIT_HCA_DRIVER_VERSION_OFFSET / 4);
 
-		strncpy(dst, DRV_NAME_FOR_FW, INIT_HCA_DRIVER_VERSION_SZ - 1);
+		strscpy(dst, DRV_NAME_FOR_FW, INIT_HCA_DRIVER_VERSION_SZ);
 		mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);
 	}
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-67809559dd1a

Best regards,
--
Justin Stitt <justinstitt@google.com>


