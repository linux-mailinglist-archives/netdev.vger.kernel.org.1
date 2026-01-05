Return-Path: <netdev+bounces-246970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B0CF2F56
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE5430155F9
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301A314B69;
	Mon,  5 Jan 2026 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pd1EQ1e4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D2314D03;
	Mon,  5 Jan 2026 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608490; cv=none; b=OMipyaWWOfu4Y5nBBFj9+OzDmIKc/9x/S0Yyrj3Yt4SLLx7SrTD8ZE9qYKkOiqBtK3NoD9fcMgZzN3zstqjd7d9I3VyaqUIebPiiBjO2G7VfNgy5RltQjG07MjgJdeMnYiKy6SidUyjIXPjZZATDllVP2kwao7S506LZu6W0t0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608490; c=relaxed/simple;
	bh=DOndyKOPHC+XjWwo8IQmKVVgE+2YxR9PrmL7vaEb2Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aHAZ19nr9eqAfm4fiDT2Idp0L7b0Jz2+VdQSKLl+3ikodkeNTfRp3CDBSeHSG5ej+Iv6jdhgXLJhmP3zJANaDtHkp0XofnnEj3UM7pURFWRmu5TBjqQj/lnWvI9b0gbtevrL/hK0gffWq2TR7SKU920CxDe85jWYsUQpaAnbtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pd1EQ1e4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vk
	5iutERJA27zH/tcNhHf5mNR2d/fQros4GcMViC0s4=; b=Pd1EQ1e43tMdvbAX/3
	Fvwz+0MdYBHpIHyM+xydY1i7PuA+Zqw2GWmOOwKZX1Hb5B46cToa7Z5GjQAQ96d1
	bbR8SDl3T97HFib8hkxHYxSkkdkegB7qJL3GBq4z5wT7kJrPa+j8pffu/4Z2daU+
	GrD0RFlLiPADUZzUVPb9BZIeA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrxNrkFtpVWA8KQ--.198S3;
	Mon, 05 Jan 2026 18:20:36 +0800 (CST)
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
Subject: [net-next v4 1/8] net: wwan: core: remove unused port_id field
Date: Mon,  5 Jan 2026 18:20:11 +0800
Message-Id: <20260105102018.62731-2-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260105102018.62731-1-slark_xiao@163.com>
References: <20260105102018.62731-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrxNrkFtpVWA8KQ--.198S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw15Jr48Kw1DZF1fKw17ZFb_yoWkGwbEkr
	nYvrZ5Z348CFyvvr42gF43ZFWFvF4IqF4kuwnaqrZ3AFWDXrWrW3Z8XFnrWrn8ur18ZrZr
	WrZrXFs2vr1fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1eMNUUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvxRy1mlbkHS2zAAA3j

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


