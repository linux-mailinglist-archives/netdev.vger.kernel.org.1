Return-Path: <netdev+bounces-146471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6039D38E2
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655A11F25C4D
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538E1AA1CA;
	Wed, 20 Nov 2024 10:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835A19DF9A;
	Wed, 20 Nov 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100219; cv=none; b=DeOyc87H15cIIFCUtdtyme1GimlSzA+o5Uba/exoTUQI92vPXwYVn9csgbfYi8xx/XIzCEoa+BUelJZypXUJH00Rs5YYwzkvaSDBnDpepQmWCzPJU7a1SdcnUroAHOgVBVVZdAV3aR/mGIw6/UYzYJUjjsJXs8D9sU64xOoKWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100219; c=relaxed/simple;
	bh=5PlUofkhhB/suIxzL/Vvzk31qhjeljBpYdmU/UDmOSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0kABJzPaTueIZCc2C27v5/AVrep+a7NLLFsBeP8c/6jx3wxGddb2F3+EXo5BnTyaW2Dr8YDDEIKN2oQ1+RjqYNwy9IN/qemryhFo9Uh9nGlKSWdsE9/4tHS8xb4QGE5dHYh5sicn3MssEFG/2AuAWZCEPYLeM+RwWwXDWJcYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppgd_1732100208 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:48 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 20/21] motorcomm:yt6801: Add a yt6801.rst in the ethernet documentation folder
Date: Wed, 20 Nov 2024 18:56:24 +0800
Message-Id: <20241120105625.22508-21-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the yt6801.rst in ethernet/motorcomm folder

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801.rst             | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst

diff --git a/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst b/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
new file mode 100644
index 000000000..dd1e59c33
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================================================
+Linux Base Driver for Motorcomm(R) Gigabit PCI Express Adapters
+================================================================
+
+Motorcomm Gigabit Linux driver.
+Copyright (c) 2021 - 2024 Motor-comm Co., Ltd.
+
+
+Contents
+========
+
+- Support
+
+
+Support
+=======
+If you got any problem, contact Motorcomm support team via support@motor-comm.com
+and Cc: netdev.
-- 
2.34.1


