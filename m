Return-Path: <netdev+bounces-192561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354DAC0653
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FBF1BC0E5E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1E2522BB;
	Thu, 22 May 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SvxmRs1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEECE25229B;
	Thu, 22 May 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900531; cv=none; b=sIc74j10wJ+aaiDWZaPMb47dZNdMBltkxo61ZkMzIumtECoM/AIsMv6tOsQh9HZJ8i3oJ0Vk60qe8Qj+WC+VyARdPZgB+opoiFtmv+aKQ+u15Rcva2NpSWiQZvaNPycUIyi6JN1O/QlhUKdRRaegNTV4FXAqR+aTquS9qy4ZwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900531; c=relaxed/simple;
	bh=UDI+AESUPBR7QutXQUxFbFja672lstqJ0ZOao9SWPSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qs8IA3dNua2YVwTWKrg28A4Z7xoon7dQJ+FAsSE90vkQOgVNB6itmN80FLUqe4Lv7ri/XAHmz+yzT2NkLtpNDAANSqxPeEdPd+w8uw431BXIOy52suclIBBNeXjCIOauUzjEg9Z9uLvb1RyI33hUHwK3rrLK1u5/sdcMzBDo+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SvxmRs1Y; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 407271039728C;
	Thu, 22 May 2025 09:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747900527; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mNbhSqgvVY8RIDtEXtUrtyWJAPOLnVtjEBQ1v8BD3H0=;
	b=SvxmRs1YoOg2TGEP3KBjlH5R9ohnw4Kw4Wa9CeImTxDhMMh9zpmTNY/kFwtmKPqNM9cxO5
	mhV1nT01WaQ3rTERHhIdvrwsRtBGVjpXqlhnDEm1f64jseBaa+8K1ojISFQQkbh9JsLqkO
	EUu5r6KuzX4bqF8aJe843z8E7Os0dpXyDU+mJdg9EmivYhI91yqMlmyBsHVLykIjJq1DrD
	mhzrYzIxXlR8n4Ov+cqKNMp0dNxMD5G9eOx5tecBJ4bj36ChA6axrUu8MNE69WBMD08zkn
	D4cIMxC773M/2Reo+k2bS4u9cPaQLa0HW7/bkI6DjsIzNQGbRTM4AGBiliaXiw==
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
Subject: [net-next v12 5/7] ARM: mxs_defconfig: Enable CONFIG_NFS_FSCACHE
Date: Thu, 22 May 2025 09:54:53 +0200
Message-Id: <20250522075455.1723560-6-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250522075455.1723560-1-lukma@denx.de>
References: <20250522075455.1723560-1-lukma@denx.de>
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


