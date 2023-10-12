Return-Path: <netdev+bounces-40460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2507C7721
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1301C20EDB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DFB3B2A9;
	Thu, 12 Oct 2023 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/AYuzut"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415E3B28F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:44:32 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD15BBB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:44:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7ed6903a6so20123827b3.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697139870; x=1697744670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gO2z9DnfSYshDLNqAk2r4T0HlFVlTX7Xeh7UwOdq+BM=;
        b=R/AYuzutXtUjoUkdxoAx8QJdrc9aRdPIJvFERHD7l4vVyDvDfERXNN8VfpJ+5DjQ7F
         UHoT5HdBK+nq8Cw2Wr512lSf9sNgb8pWbb9hS7lRAXKrs5LTUJ12n8kiE3jhswe5F1Jk
         5GjWHxvr5S8fQof7lqkvRYuiGLw8pA5ELFWAhj6+7Ujr6ATh8z4hPxY6Wo6i5vXANXTO
         HJxYY8P2jLgPi9u58Ie9tq4fZPXd6ctAOkMxZD0u3fP5ZPx9jn030mTvDlZW7RZf74hc
         ApwOho+GA+nqQSAgc7FalIEJ0lC1Ehf+jwxDSfnYBPVgUeAB7r1CA5VEEWxEAzBHjj+1
         7VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139870; x=1697744670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gO2z9DnfSYshDLNqAk2r4T0HlFVlTX7Xeh7UwOdq+BM=;
        b=rseNkOsIIQsSqBWabtszSepRI6fHPRbDsR/Nw6/OKOm7NucQ4b6oIG7ET+H5uaTDCV
         vonbAaM9Q4urMPzF1da/zP9AqmngaBo2rUbatUdvqmkkFMUkozCGvOLo8iKOZMTkhcaQ
         oEhiSEngpKN0+tyXxj+nmMnSsfIyypVknms52nPzO2Q3wxXS1viLgSu+hvFkurAzsPYf
         rkcgei4DT7CdhgU5mD4hOl7DhdVwllsIkiua0R0dNTwHoHmmu3cpMHiWb/T4Lj9psXMs
         ASOeKuuQBhdhyc5z7B+cahwbw7XUNwOXqds7lfU040sMxLaXzAGDdw3eQUjKztPFm/8a
         03lw==
X-Gm-Message-State: AOJu0YyYJkCBiP3QHM3I15pVpT67zxzd0bA6EHOuOFJAXLNGxbdTkDDd
	l5nRU/oQwbxNY114Y7O6+U98niWS8DhI62lUww==
X-Google-Smtp-Source: AGHT+IGyfg21hVr8igdIoXcOnC430Id//VWBpXn5PdstSuNO+cttRxHwUZ+TFBGZxwosqolDJUdk8fOXLxUkTfkrMQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:a809:0:b0:59b:ebe0:9fce with SMTP
 id f9-20020a81a809000000b0059bebe09fcemr492781ywh.5.1697139869946; Thu, 12
 Oct 2023 12:44:29 -0700 (PDT)
Date: Thu, 12 Oct 2023 19:44:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJxMKGUC/z2NywrCMBAAf6Xk7EIeFKO/IlJks7YLsq2bUFJK/
 93owdPMnGY3mZQpm2u3G6WVM8/Swp06g9NDRgJOrY23PjjrPOSigssGSXklzSBUgMpE+pX3ax4 ZG1D+GGKodWDhAgjn2EfrLgn7GEx7LEpPrr//7X4cH8jRxmSPAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697139868; l=2934;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=4JcrK7XeBYAz1euC/1Q21LAERMS6P47z2WrDNBYfH9c=; b=EX0OyQuonYdat5F4Jyoc9PfPN/G+udgIrHp7L1KCUE0syRXqblPmt6c1biQlaTBz/d5CrChHJ
 EkaTcjlNhGrDXu98mTeZac2q96he3ivIEiEBuiM9L0b0wgJaU73KDxX
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
Subject: [PATCH] qlcnic: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	GR-Linux-NIC-Dev@marvell.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect fw_info->fw_file_name to be NUL-terminated based on its use
within _request_firmware_prepare() wherein `name` refers to it:
|       if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
|               dev_dbg(device, "using built-in %s\n", name);
|               return 0; /* assigned */
|       }
... and with firmware_request_builtin() also via `name`:
|       if (strcmp(name, b_fw->name) == 0) {

There is no evidence that NUL-padding is required.

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
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index c95d56e56c59..b733374b4dc5 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -2092,8 +2092,8 @@ static int qlcnic_83xx_run_post(struct qlcnic_adapter *adapter)
 		return -EINVAL;
 	}
 
-	strncpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
-		QLC_FW_FILE_NAME_LEN);
+	strscpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
+		sizeof(fw_info->fw_file_name));
 
 	ret = request_firmware(&fw_info->fw, fw_info->fw_file_name, dev);
 	if (ret) {
@@ -2396,12 +2396,12 @@ static int qlcnic_83xx_get_fw_info(struct qlcnic_adapter *adapter)
 		switch (pdev->device) {
 		case PCI_DEVICE_ID_QLOGIC_QLE834X:
 		case PCI_DEVICE_ID_QLOGIC_QLE8830:
-			strncpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_NAME,
-				QLC_FW_FILE_NAME_LEN);
+			strscpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_NAME,
+				sizeof(fw_info->fw_file_name));
 			break;
 		case PCI_DEVICE_ID_QLOGIC_QLE844X:
-			strncpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_NAME,
-				QLC_FW_FILE_NAME_LEN);
+			strscpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_NAME,
+				sizeof(fw_info->fw_file_name));
 			break;
 		default:
 			dev_err(&pdev->dev, "%s: Invalid device id\n",

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-7858019dc583

Best regards,
--
Justin Stitt <justinstitt@google.com>


