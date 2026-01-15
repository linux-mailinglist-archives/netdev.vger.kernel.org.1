Return-Path: <netdev+bounces-250143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E9D24506
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54AE83012CDB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B65393DC8;
	Thu, 15 Jan 2026 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="enbuSupH"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230EE3806B7;
	Thu, 15 Jan 2026 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477652; cv=none; b=nFZj+GfVMQIAQlXkYDpZp0/oEdxODTNlOHjBaF0YFV95wb/cCAntei4FzLekqoQN3OsHXHELMLcdepHpwLXGIHTR6TVqJ5AgxafRwIvux6KcX9XqeMvTYIeL5AXOx7bvNCPN5wxLcGAigkKesklP8zczQPl0+0rkF1fXUFfcZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477652; c=relaxed/simple;
	bh=DOndyKOPHC+XjWwo8IQmKVVgE+2YxR9PrmL7vaEb2Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqEUV2BwSwNYn3TXapOk6dPoNeGWFh6qnzD+Dm+3O90aoC2gVS9oEcjG8uSlI6hAe3r1QIfv5W/9Qf2+OeUKA2KXdgu7Oyfv3muL/QaV+A01WF7j6HPC90E6fVk7KyoN64FAEsk1Wh3sIogxtQxCEw//ebGi/bY4FFWXmULBcVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=enbuSupH; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vk
	5iutERJA27zH/tcNhHf5mNR2d/fQros4GcMViC0s4=; b=enbuSupH6cvbsQ4bAc
	/V6ixb+Da5H8ipj4dbgwgcgWOZJpUWxHifAuEwlIpfsPl6UG0YlgPOtszovA47Gf
	55HpHPygrnsibnh/MLgJDHFg7LGVXLCW4VZdWicXIrLJs6X3fmH/uSqu323dBixs
	SW58fAGEUuEIZFtKNPeuvqY60=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHLGiX02hpr2PzGQ--.4331S3;
	Thu, 15 Jan 2026 19:46:37 +0800 (CST)
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
Subject: [net-next v7 1/8] net: wwan: core: remove unused port_id field
Date: Thu, 15 Jan 2026 19:46:18 +0800
Message-Id: <20260115114625.46991-2-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115114625.46991-1-slark_xiao@163.com>
References: <20260115114625.46991-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHLGiX02hpr2PzGQ--.4331S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw15Jr48Kw1DZF1fKw17ZFb_yoWkGwbEkr
	nYvrZ5Z348CFyvvr42gF43ZFWFvF4IqF4kuwnaqrZ3AFWDXrWrW3Z8XFnrWrn8ur18ZrZr
	WrZrXFs2vr1fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_a9aJUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5x2Q9Glo0538PwAA3S

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


