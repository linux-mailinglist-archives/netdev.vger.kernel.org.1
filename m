Return-Path: <netdev+bounces-202868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DADAEF78B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B87C162B44
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0A28032D;
	Tue,  1 Jul 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XdQavk9g"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746EB276038;
	Tue,  1 Jul 2025 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370647; cv=none; b=X3JyMX5CzZ22HE5Wnz6jPv7e8doSV03hImm0U+517dozHvczJvS1W1ZGL4ruERGFA0r2aqqpc2jeYG7Iwhfq/jWAV5QpYj14/2EsFB+Kin0m9rlu0H9cKh2vBgJljquOCrWvZugKSN87WauS89sy2J4J75c0QvMdQIBOebGNc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370647; c=relaxed/simple;
	bh=eghVlGdwLX7vJ4v3ZVYI5Piy8i4hNVTZcFFA0iOTXmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/alIylsuj0o2AFvt3WAsfuQES6R83SuZ3lONKDkda0GX9ZpcoFPcHYSYIMVEvtqG919eG72phUHO6wZfX80Cv2UqZq8pK828qm6HONcmjQncCOyZqPy6N/gVtIMEpeESfyglMGnPJ7yGfxeERgRWHwOIz9hB1xkDCLu3pUewzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XdQavk9g; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8095D103972AF;
	Tue,  1 Jul 2025 13:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751370643; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aEJ6xxqxwwmP9AljJ6R8T1tFe4ZJ93o2TY5GAy0p+7E=;
	b=XdQavk9gmLCWxbYounR+pBruaj38k1nLXzkI8I0MSyY4Q6eIy2pXeZZQbBbIxs6vSQ7WwF
	btmUVCQ2JTtmNq1/eIrjMXu3ImBpm6ES4JetoY0s27P9p/eN9W6QtnPPb0/2bkx46Gu86Y
	HeoHF3Q2CWTga6xrDLIeihWOf+NzwZO6eYJsEv84JlCc1ar53zKW2R1ZmNmuPKQMm5Zi5J
	xLplUZCpgZZwqOCWRYxRX3gTZ5qdXZVdGHp6MOxY4vvh8L/ydQE9FMbWc4MDA379sKPHe1
	jCjv72VxcRXFn6sPbvXFlhtKOil52KBFRWMbFRDg2bBS1LvkXEu7jsUyinndUg==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v14 10/12] ARM: mxs_defconfig: Enable CONFIG_NFS_FSCACHE
Date: Tue,  1 Jul 2025 13:49:55 +0200
Message-Id: <20250701114957.2492486-11-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701114957.2492486-1-lukma@denx.de>
References: <20250701114957.2492486-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

It is not possible to enable by user the CONFIG_NETFS_SUPPORT anymore and
hence it depends on CONFIG_NFS_FSCACHE being enabled.

This patch fixes potential performance regression for NFS on the mxs
devices.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Suggested-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v6:
- New patch

Changes for v7:
- None

Changes for v8:
- None

Changes for v9:
- None

Changes for v10:
- None

Changes for v11:
- None

Changes for v12:
- None

Changes for v13:
- None

Changes for v14:
- None
---
 arch/arm/configs/mxs_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index c76d66135abb..22f7639f61fe 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -138,8 +138,6 @@ CONFIG_PWM_MXS=y
 CONFIG_NVMEM_MXS_OCOTP=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
-CONFIG_NETFS_SUPPORT=m
-CONFIG_FSCACHE=y
 CONFIG_FSCACHE_STATS=y
 CONFIG_CACHEFILES=m
 CONFIG_VFAT_FS=y
@@ -155,6 +153,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_NFS_FSCACHE=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
-- 
2.39.5


