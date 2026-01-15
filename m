Return-Path: <netdev+bounces-250086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C61D23C3A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DB1C30BB849
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61B3612E7;
	Thu, 15 Jan 2026 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bSE2Um8L"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAA35F8DE;
	Thu, 15 Jan 2026 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470936; cv=none; b=KTfCBYyR+8Y/vcomT0fAN8HrSOl+k8nzBClLS70aHaOHjsG0X6Ahgv/mbA76Sg0xSsaMqyHB4P1c2cv4MPURl1uCAbTRUOzOeHhGb9QJCv2DVeQ8SGZMRU6G4R6fjEMK6Irk8CL3fi5QdT/rrzVYJPVEwZbwQYdEWgHdnuQMrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470936; c=relaxed/simple;
	bh=DOndyKOPHC+XjWwo8IQmKVVgE+2YxR9PrmL7vaEb2Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQ3sNve7uy9gi/lMKWpbAWzF++7A50+RisK4w2/8WZpI/HCV9bouAjY3wY1RTqHiqiYuHoBm4YcACOqZRdBGXBmXbvA5d9C2TRayvhi1eTemQf5RA824OhGqJqKJCLYi5PCJ/zO9P9F856a4p83ttrptJP1PT86wOuCKpHAUOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bSE2Um8L; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vk
	5iutERJA27zH/tcNhHf5mNR2d/fQros4GcMViC0s4=; b=bSE2Um8LHUJaYSQPbx
	jsIqWlRe10zlhvYh9qygYtJrYCfFVJLrGHAQ4umzj92XJbiNLxyf0X9YyHKLeonj
	t783IFtQCFaumh+yviB2EMmguVA0kgVdi1Lv/4U99JnAsR3imPK3iSdy06vA/HoS
	FPNwJesfi7L94A4/ALvu/c+30=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAH3axTuWhpe3IgLg--.97S3;
	Thu, 15 Jan 2026 17:54:36 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slark_xiao@163.com
Subject: [net-next v6 1/8] net: wwan: core: remove unused port_id field
Date: Thu, 15 Jan 2026 17:54:10 +0800
Message-Id: <20260115095417.36975-2-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115095417.36975-1-slark_xiao@163.com>
References: <20260115095417.36975-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAH3axTuWhpe3IgLg--.97S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw15Jr48Kw1DZF1fKw17ZFb_yoWkGwbEkr
	nYvrZ5Z348CFyvvr42gF43ZFWFvF4IqF4kuwnaqrZ3AFWDXrWrW3Z8XFnrWrn8ur18ZrZr
	WrZrXFs2vr1fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_iSdDUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwBz5XmlouVws1QAA3m

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

It was used initially for a port id allocation, then removed, and then
accidently introduced again, but it is still unused. Drop it again to
keep code clean.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wwan/wwan_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 63a47d420bc5..ade8bbffc93e 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -43,7 +43,6 @@ static struct dentry *wwan_debugfs_dir;
  *
  * @id: WWAN device unique ID.
  * @dev: Underlying device.
- * @port_id: Current available port ID to pick.
  * @ops: wwan device ops
  * @ops_ctxt: context to pass to ops
  * @debugfs_dir:  WWAN device debugfs dir
@@ -51,7 +50,6 @@ static struct dentry *wwan_debugfs_dir;
 struct wwan_device {
 	unsigned int id;
 	struct device dev;
-	atomic_t port_id;
 	const struct wwan_ops *ops;
 	void *ops_ctxt;
 #ifdef CONFIG_WWAN_DEBUGFS
-- 
2.25.1


