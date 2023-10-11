Return-Path: <netdev+bounces-40144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E07C5F1F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902E61C20C24
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84619208AB;
	Wed, 11 Oct 2023 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nq7uSgZg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D573A278
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:30:00 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD4B6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:29:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so339240276.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697059797; x=1697664597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m3pTpYqn2463yxqFt3mIFAjuaB6ZhS9Rkhs7QnUkljw=;
        b=Nq7uSgZg0s1stmYMn6ZzSakIy/plW3bDKlrSQIprCvdcoMowghQ3C2GG+pqav8ZMij
         iFxE+b+c/pqU1LSOSMeDbVzbrJxBcQNqkxSN5+8NvmofmQ3RNTNXoFteHlXQeissIHjZ
         RcSPcJ02aCYEw3a7pK7a2j7NgAupJZTV/m1kBXDfPX0+Xy9HTUwjFEdkETepOyfiSsCg
         n3n9PsQNbZR1vm98HHuV2XJmTpFRffMDry6+L3x+M+9mLjdRB+ElplXUEGrdfMGj67Ka
         oOhJe2zmogwnSU4qfy8BA9ZCiYl0ayjpPt4ET2fTQIcqaF5vRf4KHb/zvgotMugxa9is
         qSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059797; x=1697664597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3pTpYqn2463yxqFt3mIFAjuaB6ZhS9Rkhs7QnUkljw=;
        b=L7UEhWVnFvamWvNULSVpapUxouQVigKbZlMC1iSFf0PrJktRAz88kAOaIUA0Dyiaip
         JOfZ/9CA3MspsG8MpbbW36jDhrf1fnjtqlDH7oSdBdWUl8zvsyCrnYZl2xBI3Sqrl1OS
         IyEX2uaOQVJTPolJiW9FXe44vCKDskUKOYZ0HwmfStsac5zhY30jEZhdyvBaC7cXhIX/
         wzn5SIATk0oiWSrs4eqn0cnHGADL3mm0BKoPNqVIcFFAFwN9wpBtZbIuuDqak4Bd03je
         hbXUruDMmCwXGcptP7e5SLyzV/RnkBbgLUfPlSxjVFZYy5JUlVM2PTKzOtDcGUAHfzC1
         SMqQ==
X-Gm-Message-State: AOJu0YxNGwD6wPVPyRj9EvlthSzUYm36jsMKJpvkM/wwPZbycUKSgemn
	rlkFIzuX5dJDzFhON8Jv9wmyGKgp7rnIIEC52A==
X-Google-Smtp-Source: AGHT+IFzh11O2xXhTMZejnqEuXav2mfhp3aDFwJLnzB7+Nt/FhAkhc5xn+9+x59VZRntczfgh2jwR2IMVZ3LVuZyww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:52d:b0:d13:856b:c10a with
 SMTP id y13-20020a056902052d00b00d13856bc10amr387725ybs.3.1697059797461; Wed,
 11 Oct 2023 14:29:57 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:29:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANQTJ2UC/x2NQQrDIBAAvxL23AU19NB+pfQgumkWdA2rBEPI3
 2t7m7nMnFBJmSo8pxOUdq5cZIi9TRBWLx9CjsPBGTdbYy3WphK2A6PyTlpRqCG1lfQHmVLyUjr m1O8YihJmz4IBXYwPPy/eOTIw4pvSwv0/fr2v6wtZvHP6iAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697059796; l=2667;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=usepiRchsBWre9GwPIWtzyZBsxT9tg3v/Wn5P+lFJXo=; b=mFh0xX/ALc4XkRYsUlu0sqE+8WUIH0DgX2syBIUwocnImlvC26efKkQIraF5PVPGcpvC0ArXs
 uOKWtTvR0P8CTm/inIvAVzS2Y/WzNweabRpteNbBdiyh+QIkfzd5LLl
X-Mailer: b4 0.12.3
Message-ID: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-v1-1-90fa39998bb2@google.com>
Subject: [PATCH] net/mlx5: simplify mlx5_set_driver_version string assignments
From: Justin Stitt <justinstitt@google.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In total, just assigning this version string takes:
(1) strncpy()'s
(5) strlen()'s
(3) strncat()'s
(1) snprintf()'s
(4) max_t()'s

Moreover, `strncpy` is deprecated [1] and `strncat` really shouldn't be
used either [2]. With this in mind, let's simply use a single
`snprintf`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://elixir.bootlin.com/linux/v6.6-rc5/source/include/linux/fortify-string.h#L448 [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 15561965d2af..0c829b6d2b49 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -218,7 +218,6 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 	int driver_ver_sz = MLX5_FLD_SZ_BYTES(set_driver_version_in,
 					      driver_version);
 	u8 in[MLX5_ST_SZ_BYTES(set_driver_version_in)] = {};
-	int remaining_size = driver_ver_sz;
 	char *string;
 
 	if (!MLX5_CAP_GEN(dev, driver_version))
@@ -226,22 +225,9 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 
 	string = MLX5_ADDR_OF(set_driver_version_in, in, driver_version);
 
-	strncpy(string, "Linux", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, ",", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, KBUILD_MODNAME, remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, ",", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-
-	snprintf(string + strlen(string), remaining_size, "%u.%u.%u",
-		LINUX_VERSION_MAJOR, LINUX_VERSION_PATCHLEVEL,
-		LINUX_VERSION_SUBLEVEL);
+	snprintf(string, driver_ver_sz, "Linux,%s,%u.%u.%u",
+		 KBUILD_MODNAME, LINUX_VERSION_MAJOR,
+		 LINUX_VERSION_PATCHLEVEL, LINUX_VERSION_SUBLEVEL);
 
 	/*Send the command*/
 	MLX5_SET(set_driver_version_in, in, opcode,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-2dd9a3fa22e0

Best regards,
--
Justin Stitt <justinstitt@google.com>


