Return-Path: <netdev+bounces-239463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCCEC6887B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 717BF2A4A6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6ED304BB3;
	Tue, 18 Nov 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OU/NVRXp"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823429ACD1;
	Tue, 18 Nov 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458156; cv=none; b=R0TNfVL/v5Yl0gnShsLuT7xWGESRxa85Bhu7lLBM3wl0dBccMaxyOQ2Ihtqv1yrMXgD/U1Y2hHhV5zfYaQo9vChol04V6RRxc5o6QGezRD5SkCwZiaXHVVwGbfRFJPvMJJq+7Tqk+lrXhRK7AOyq3bQhpBYm1j/BaMkCJ+MRxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458156; c=relaxed/simple;
	bh=VMyziYopC51vLit+yiZ1JbgUGXdaz28/EKqO+fXIUIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P7cfb8EjRZMSAuS2/4fy+45dwgHa1t3IuXOH876EXBkfhlua5pV9Nn2rX65U2pmzUvg4WWbQbpcBo6APV2vOdeaGI85atumqSe47aGsmMGvRUhw5P8cp+BCGIYRNI0ECI4ghXZ7nb/Kw9iKVnuCzH+4D8VOI3et3BCFLYbWRhiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OU/NVRXp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I1
	Br/UxaHiZ9gkbv6/uwDcyf0l1F+Ad5ILOMdUfz/sg=; b=OU/NVRXpMDQMQtolQ4
	07TzCQjLuanHRjGcWGftEN0Yhu1l1XPB2Z1jhpHwRqrNXQIxWNVQ90cGryFZ9dXr
	iwRCQZX38zCCXr64AKzDgh6umy6fkqdd1pgeJiYt+X/u6LAMCmU/q2PbaiSKvQiF
	/WhZkSm5nwwJ5uXtmOWvZMyVs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3H+JNPBxpth0NBA--.1772S2;
	Tue, 18 Nov 2025 17:28:46 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 1/2] Bluetooth: Remove unused hcon->remote_id
Date: Tue, 18 Nov 2025 17:28:43 +0800
Message-Id: <20251118092844.210978-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H+JNPBxpth0NBA--.1772S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1fWF4rXr1UJFykAFyDGFg_yoW3AwcEvw
	1IvrWfur4UJry7Ar12qFWjyw4Fqwn3GFn2kFs3XrWYqa4DursxtryxZr1qqr1fW3srZr17
	AayDXFWDXw1FyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnIApUUUUUU==
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXAEKumkcONVibQAAs6

From: Gongwei Li <ligongwei@kylinos.cn>

hcon->remote_id last use was removed in 2024 by
commit e7b02296fb40 ("Bluetooth: Remove BT_HS").

Remove it.

Fixes: e7b02296fb40 ("Bluetooth: Remove BT_HS")
Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v1->v2: Add Fixes tags
v2->v3: No modifications
 include/net/bluetooth/hci_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 18396e369..9efdefed3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -750,7 +750,6 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
-	__u8		remote_id;
 
 	unsigned int	sent;
 
-- 
2.25.1


