Return-Path: <netdev+bounces-38423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA87BADA4
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 52810281E9F
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E26741E5B;
	Thu,  5 Oct 2023 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7WfL1/G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484934CF8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 21:33:23 +0000 (UTC)
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471FE8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:33:20 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-57b63eba015so1755077eaf.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696541600; x=1697146400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DBeGsTEWaeHMVhG88NcKDZwFuePbfbjL4RyYq3i7W/U=;
        b=w7WfL1/G6/y1GScimOJYHT+87Q8GMHJNBFsijTmekIyEQMcgZEcTh815QBNPe8vhUD
         J83dm8TvK7umU+fVBL7mDSyWfYlZX3OVkCvu4a58MXdRkFIqi1lT4IBq3rbbS3LZHg+4
         /9Ya1TbRfR5EFgoDapnJDipaTzGaAXv474aJj71A9jt4qC9kOvD2v4LbVGjkKY2PuPIF
         bSQKwZK/0FrFQs+5Tyids8wKoaVVe8lGJY52MpD8/qcp5TGX4sydFZxaUMBEfH1Mab3G
         QQEkNkrZFWymaSuqfShJc2qjAUF4S+ZeJn7bFvEQfQAawSTa6ENKyH+j6pMd1LEcsPvL
         EVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541600; x=1697146400;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBeGsTEWaeHMVhG88NcKDZwFuePbfbjL4RyYq3i7W/U=;
        b=dMoXoX+b33XMNCRrWCKrEzNiuO2oEw2KJU1Ksn0k0XAUO1CrgCcHi0a9Hf+JjL1lzN
         W4YIUc6x3l41og9xi9ROIioAB2ffGSHFAYiJHQ7kx2PBgPZJfTH948uTD/0xxiGNlrrf
         9Xfdmr4hflWe+9dvxMU5F0SMN9hOoAK9mCeeY3r8CJ3PrXNYHTHz5Mgby4pHRQvc6Uzd
         2Zqi9AZwIYsEohToQDKzPvi+tIXG+zzZh8edOvoT2uLBWDYMubbqjyo77q9V1xlwaEWg
         s7Hk0Otm1VnD+OaEoH5CoDY1IAPfQ0XkbB08VSUBkPNWk3k6/w3+QyDrqF1JvoIVoPvb
         H6eA==
X-Gm-Message-State: AOJu0YylQvSJ4UO0HmhMZQQsID/BU/4bydYjo674sm+RhJ/N1Iq3DJWX
	GRdJmwijPigDGmbvG6p7bIS83eI/ZCJwN/IRWQ==
X-Google-Smtp-Source: AGHT+IERmtuCbXgTxMb6GCIs82t5NHgtdhXCBck4p3yQOXrj8TSuyBNg0Kjon0YrX+XoIVuXYQ74AU/tz2JVombgFA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:4f42:0:b0:57b:3840:4c85 with SMTP
 id c63-20020a4a4f42000000b0057b38404c85mr2335028oob.1.1696541600124; Thu, 05
 Oct 2023 14:33:20 -0700 (PDT)
Date: Thu, 05 Oct 2023 21:33:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ4rH2UC/x2NQQrCMBAAv1L27EKSoqhfEZGabOxCTepuGpTSv
 xu9zTCHWUFJmBTO3QpClZVzamJ3HfhxSA9CDs3BGddbY/aoRZKfPxiEK4liooJURpIf+KHy8sS JXwsHzg3yrcWS84Qe74dT77yJRxMttMEsFPn9n1+u2/YFMCiAn4wAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696541598; l=2730;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=PKPsb45o8cJUMR1NbV9bY/ZXdX56wnhP8PdDKS7CtXE=; b=V1BHnD4OOJXpH/xgsaKnRxTqiT9ViCdlfEibIwEOSbm+ZYxyvmHL5E4Z4Ng26ZmlHpUNgDba/
 +ghPh0uvDd3Cp21R6QwP2QMeWaE/vV57KKgtRZYIt+iUrL/D/xjBytE
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-v1-1-ab565ab4d197@google.com>
Subject: [PATCH] liquidio: replace deprecated strncpy/strcpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Derek Chickles <dchickles@marvell.com>, Satanand Burla <sburla@marvell.com>, 
	Felix Manlunas <fmanlunas@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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

NUL-padding is not required as drvinfo is memset to 0:
|	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index 9d56181a301f..d3e07b6ed5e1 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -442,10 +442,11 @@ lio_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 	oct = lio->oct_dev;
 
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
-	strcpy(drvinfo->driver, "liquidio");
-	strncpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
-		ETHTOOL_FWVERS_LEN);
-	strncpy(drvinfo->bus_info, pci_name(oct->pci_dev), 32);
+	strscpy(drvinfo->driver, "liquidio", sizeof(drvinfo->driver));
+	strscpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
+		sizeof(drvinfo->fw_version));
+	strscpy(drvinfo->bus_info, pci_name(oct->pci_dev),
+		sizeof(drvinfo->bus_info));
 }
 
 static void
@@ -458,10 +459,11 @@ lio_get_vf_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 	oct = lio->oct_dev;
 
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
-	strcpy(drvinfo->driver, "liquidio_vf");
-	strncpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
-		ETHTOOL_FWVERS_LEN);
-	strncpy(drvinfo->bus_info, pci_name(oct->pci_dev), 32);
+	strscpy(drvinfo->driver, "liquidio_vf", sizeof(drvinfo->driver));
+	strscpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
+		sizeof(drvinfo->fw_version));
+	strscpy(drvinfo->bus_info, pci_name(oct->pci_dev),
+		sizeof(drvinfo->bus_info));
 }
 
 static int

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-b6932c0f80f1

Best regards,
--
Justin Stitt <justinstitt@google.com>


