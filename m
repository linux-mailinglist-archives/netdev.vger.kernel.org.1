Return-Path: <netdev+bounces-222900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE901B56EA5
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7CD162B4E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C312222A1;
	Mon, 15 Sep 2025 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ChtIPv2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222122127E
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905551; cv=none; b=jn/pkuA8g3FLEyjFTkYYgklxG0yZwdrWtSLPttp06QDByr4gjTKrAe1tu7MwKuB5jA8eHRwHK9boDPoaSc50HMsHJbLLuj4fhm3Qd78FAWEMDmQi13+TsaPLT/iAkdfKv4bkZUtAY/UduCV5tVuF6G9/k4ry0N/dg0SagC1s6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905551; c=relaxed/simple;
	bh=TToluwHCrfTwpX5mQWuinfD7ZokaMr4zyoLpwyUcyuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiLQ/v4VuDb8A6gD68f5F1C+ypky8BkrmGb3+RfJ+XgMihHae0yJQ1i5hpkHeCsePB4hH8QyFKqGEW8i74+cF5ojORpc+XJfmvFLr+20SKwfTS3wXag0k2Z8yLOzr06JhKKC+Hw6noCNhx+LaM451BWsYpkeSNnBURmQt8H5HL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ChtIPv2x; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-417661ecbb1so44872655ab.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905549; x=1758510349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENvoq6D0bSsCLw2JyT+2h/DguSJdooWHKXVKPHfJIzE=;
        b=ml+xwQ9QqFBQwDjP9RK1gGGAkJcwKR7hY39bOOD+kP0rbMP5VAUNyLy4JZBXtTUucL
         gkOeLchMAaU7WMn3YhP9Yc6dwBklibCYdkRtk0a137i+SFWOegtOlkMIYfXFufUCxETZ
         3DRpT+xXCS+XdbKhDgO28zdtmtREJ5sRxmi2hjuAvC8bpSI85MxkoZySVn7j9lmUh6DH
         mkPY75xHQwzxNrFRvCJKCDE5QpPLr+xMKlJoTl9sVB7kuOfKIAFJCGXLm5EIR76zaZgz
         LRAR5M8Z/nSAToxVX6c4FRS23Yykh4Vs1Pjf4/NO3n4Dun6vxeRwvcbh27x7Gb2AdlnZ
         iebA==
X-Gm-Message-State: AOJu0YzaqjQo+XOKQVpph+GEmoViyFnrDSBlpZZYLL28BY4xA0HFpsyI
	GmgUYJYdN15oEzkqxptvdHAK+JNfPb1XdLoni2+4NVCAuhObAaNI6W9xnAhvkAJorqZsbz8nAQA
	t9u8OYVuubztLJonZOl6ZmujJdXNPtjvNZakUlGjLiDAQw8c032PSEa9h28n09IsHGPk0V4FuMJ
	kMADX0qkRkdtp2S1da6DwYAu/G2bDoovpsNvp23lv2xnbrj7g/xZmImCkUTI/kqG7cCdMm+JI/I
	lzVvsQluZQ=
X-Gm-Gg: ASbGnctrjyvzGEwFQGbNqDOUhN/lK+lfgYKy7FX8eJ4HefhhB+YBQFGrTWz0QYDPD6L
	xzIroPcFLCorfAs1GH1PtMjmK2sZwEsEuKJyWWSH7MHPpS/12gFBLk652aqYscSIqghgPNC2u6S
	IzhsX41Uo/QfvpOb1XdNi6KxW57SwU4hGHHFl0KiEAnd3Ze18Qjlps+F4JVnsPoY03C0rLLDm2J
	o8iHIMco0vyYJ3J2Lmo6l6JUxaF4eFCDFlMhOpv/cSgbi/8dxAobb2hX4MoQy0sOr3LLcy/aGgK
	12bJx3r2z9CKGKhYu8OXzGeAINeAu+vFIZ0kZSFc0ETJWIGlbnw9592OUM57QnX1jpegy7mrvdQ
	FXnw2fzCYPw91kIlrJMDC7hqvnCBDdvaYzFIUxJE1Kii2uB/pqLCsCoVtgj5V1FOPSFSKPw3jgG
	o=
X-Google-Smtp-Source: AGHT+IFcIlZIaJD2S5NCa70rImlfGaA+hPZxBNlBYoEVz8bg+f1G03m8agYGr0YOCxNZfzpZV+sfzsuX9jhO
X-Received: by 2002:a05:6e02:154e:b0:402:c7f3:6d73 with SMTP id e9e14a558f8ab-4209d9c941cmr128039765ab.4.1757905548968;
        Sun, 14 Sep 2025 20:05:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4213b843ffbsm8431195ab.46.2025.09.14.20.05.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:05:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c72281674so2588329a12.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905547; x=1758510347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENvoq6D0bSsCLw2JyT+2h/DguSJdooWHKXVKPHfJIzE=;
        b=ChtIPv2xtnFQLTU8drtWfw+AN9KCOKkNSmu6wf7MEj/CMsdURhrF/HpA08bX7KExzL
         Lc3Lzq2sslEG/Cjli84lPwdv7fLdX8i3SJP5CTlX9Mjt198VooKOOAq7KJV4zIpn5N4+
         //rFIsIrYr0MmsQj7uh+v1vxw5KVrjJhlxYBw=
X-Received: by 2002:a17:902:dac4:b0:265:5a25:4b0a with SMTP id d9443c01a7336-2655a254c11mr48249055ad.18.1757905547443;
        Sun, 14 Sep 2025 20:05:47 -0700 (PDT)
X-Received: by 2002:a17:902:dac4:b0:265:5a25:4b0a with SMTP id d9443c01a7336-2655a254c11mr48248735ad.18.1757905547025;
        Sun, 14 Sep 2025 20:05:47 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:46 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 00/11] bnxt_en: Updates for net-next
Date: Sun, 14 Sep 2025 20:04:54 -0700
Message-ID: <20250915030505.1803478-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series includes some code clean-ups and optimizations.  New features
include 2 new backing store memory types to collect FW logs for core
dumps, dynamic SRIOV resource allocations for RoCE, and ethtool tunable
for PFC watchdog.

Anantha Prabhu (1):
  bnxt_en: Support for RoCE resources dynamically shared within VFs.

Kalesh AP (4):
  bnxt_en: Drop redundant if block in bnxt_dl_flash_update()
  bnxt_en: Remove unnecessary VF check in bnxt_hwrm_nvm_req()
  bnxt_en: Optimize bnxt_sriov_disable()
  bnxt_en: Use VLAN_ETH_HLEN when possible

Kashyap Desai (1):
  bnxt_en: Add err_qpc backing store handling

Michael Chan (4):
  bnxt_en: Improve bnxt_hwrm_func_backing_store_cfg_v2()
  bnxt_en: Improve bnxt_backing_store_cfg_v2()
  bnxt_en: Implement ethtool .get_tunable() for
    ETHTOOL_PFC_PREVENTION_TOUT
  bnxt_en: Implement ethtool .set_tunable() for
    ETHTOOL_PFC_PREVENTION_TOUT

Shruti Parab (1):
  bnxt_en: Add fw log trace support for 5731X/5741X chips

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 65 ++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  9 ++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    |  4 +-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  2 +
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 13 ----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 45 ++++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 21 +++++-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.h   |  2 +-
 include/linux/bnxt/hsi.h                      | 61 +++++++++++++++++
 9 files changed, 184 insertions(+), 38 deletions(-)

-- 
2.51.0


