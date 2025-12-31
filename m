Return-Path: <netdev+bounces-246406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348DCEB681
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 07:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91469303EB98
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1F311966;
	Wed, 31 Dec 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NXSYGWXs"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A37242D78;
	Wed, 31 Dec 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163945; cv=none; b=SpjoIIzQeRELkRyWNGduof029cmwewqSxqHU4VN/hGufcb7tcsRuRUsu0bRgonaNNG3L4kQqyy+JzGrZOryoE5wv5ui4BDy08HDvW694sAcnTj2h/RkrN61qSVmSkVYy8D9hoySdDGQ2eaMNVGvL9rxysN8PXSAroQMOt9wPZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163945; c=relaxed/simple;
	bh=DOndyKOPHC+XjWwo8IQmKVVgE+2YxR9PrmL7vaEb2Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTAuP6Gr21V9KTnH1weOQORnQwZSbosydTzZCJWySWFn74F9MrCpMCHMzIgFJd1Is+w8yFed5JZwUnlZLTXxcEPMmnTyFp6zqjDktTuDElmAkYcxxv/u8dDu1j7f88oblZMBhbXNSN3xVzc0fK7/3YKYXPnMMn63X/otXH7//G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NXSYGWXs; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vk
	5iutERJA27zH/tcNhHf5mNR2d/fQros4GcMViC0s4=; b=NXSYGWXswHbeC7loCt
	kJ2iA6Kjweahavq0YIsgKtRqihM5DtYtuOV1t2ap6j8MEUySaopfZh94eT6l/bT9
	SlyXqw4AKiU1hgomkbAuCP4b6fibRdUAaajEkVB4RG+0SDeGK/XvogyOJlHHqjkv
	eCzAt/anWtri+S7tifFGmOCNw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHpCPmx1Rp9FyCDg--.29927S3;
	Wed, 31 Dec 2025 14:51:32 +0800 (CST)
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
	linux-kernel@vger.kernel.org
Subject: [net-next v3 1/8] net: wwan: core: remove unused port_id field
Date: Wed, 31 Dec 2025 14:51:02 +0800
Message-Id: <20251231065109.43378-2-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231065109.43378-1-slark_xiao@163.com>
References: <20251231065109.43378-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpCPmx1Rp9FyCDg--.29927S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw15Jr48Kw1DZF1fKw17ZFb_yoWkGwbEkr
	nYvrZ5Z348CFyvvr42gF43ZFWFvF4IqF4kuwnaqrZ3AFWDXrWrW3Z8XFnrWrn8ur18ZrZr
	WrZrXFs2vr1fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8rnY7UUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6BSeA2lUx-QItQAA3S

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


