Return-Path: <netdev+bounces-215716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CEAB2FFD2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9578717A47B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A527A92B;
	Thu, 21 Aug 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gfIEbxyK"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B4285CB6;
	Thu, 21 Aug 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792880; cv=none; b=J4emsELgzJdM2J3olxYz3s/O/jxTG9WKOFM1WBRG/RP33UiGyspmkYXeZ7ZB7Pd2lhy0e9GbWgdWYXKr/KYy46+EJDKXdw28Qn+EfTYeEk1Y5g6kZ2+cny+ayzlVE8rBp4GcZatsVu5MltjJbr/E4bZsBby2iTmJh2kHchqtmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792880; c=relaxed/simple;
	bh=bZiwXTpwcqNwm9g4f0YuLhxRtNXA5I/Zd4XNEgKoyxo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1afO4GZCNDvHZbsdwmoMHxAWa7uYmt/BYQVkkfzhLOUr/3DI7f1zLRbdOewc6QvtY1AYLWs52QVsIvcwfIu9N/dB5NTSew6Z+ZuHZLv6fEMWLlY5PtevBEeKDs7w2NYHNpE0Mi1wMlP9ttsWlDmM+M8TZmQsRk712VwISWG/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gfIEbxyK; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id A2B8A240006;
	Thu, 21 Aug 2025 19:08:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru A2B8A240006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1755792514;
	bh=ghlDS7gss6+NjsK++AcAfUV0LXrKhx7Crx9UHunrNXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gfIEbxyKyrSMvEQdQR0POGTgG7QbSgqsiZc3MmkbuvYbp7CcDOwGMCIu0dzTycwfR
	 WbkV2VF38f8ljdpbD89pdwwUY0AQ1YfKybdwDR6bOCsnQSzGOSUiuZp1HNrhQzGMe4
	 tqp+EBP9zRzZHFlD9RXMAYg3t1VTO02lZTxOXkHBCKb8Broy0ju8ZOMnXEVkYvPpvu
	 LGCHO/IQZYzk1F38H4ngPvEgxF6tf1EiIqPwmJwwSXRPKwrSLJkgR5TPwsIRTfmkhW
	 AC+h9jWbF91A0bNI8a9XIHKFUw2refm6vmzQt6kLugeL5uYwV+9mjAWythLZ1EwDiU
	 xJSOrDQmVS47Q==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R11" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 19:08:33 +0300 (MSK)
From: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <brian.gix@intel.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, Pavel Shpakovskiy
	<pashpakovskii@salutedevices.com>
Subject: [PATCH v1] Bluetooth: hci_sync: fix set_local_name race condition
Date: Thu, 21 Aug 2025 19:07:47 +0300
Message-ID: <20250821160747.1423191-1-pashpakovskii@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pashpakovskii@sberdevices.ru
X-KSMG-AntiSpam-Info: LuaCore: 64 0.3.64 96c1edcdaeab4cf6c1fd6858be74d3893179d628, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, FromAlignment: n
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 195702 [Aug 21 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/08/21 14:56:00 #27681497
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Function set_name_sync() uses hdev->dev_name field to send
HCI_OP_WRITE_LOCAL_NAME command, but copying from data to
hdev->dev_name is called after mgmt cmd was queued, so it
is possible when function set_name_sync() will read old name
value.

This change adds name as a parameter for function
hci_update_name_sync() to avoid race condition.

Fixes: 6f6ff38a1e14 ("Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME")
Signed-off-by: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
---
 include/net/bluetooth/hci_sync.h | 2 +-
 net/bluetooth/hci_sync.c         | 6 +++---
 net/bluetooth/mgmt.c             | 5 ++++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 72558c826aa1b..eef12830eaec9 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -93,7 +93,7 @@ int hci_update_class_sync(struct hci_dev *hdev);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
-int hci_update_name_sync(struct hci_dev *hdev);
+int hci_update_name_sync(struct hci_dev *hdev, const u8 *name);
 int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode);
 
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e56b1cbedab90..c2a6469e81cdf 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3412,13 +3412,13 @@ int hci_update_scan_sync(struct hci_dev *hdev)
 	return hci_write_scan_enable_sync(hdev, scan);
 }
 
-int hci_update_name_sync(struct hci_dev *hdev)
+int hci_update_name_sync(struct hci_dev *hdev, const u8 *name)
 {
 	struct hci_cp_write_local_name cp;
 
 	memset(&cp, 0, sizeof(cp));
 
-	memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
+	memcpy(cp.name, name, sizeof(cp.name));
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_LOCAL_NAME,
 					    sizeof(cp), &cp,
@@ -3471,7 +3471,7 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 			hci_write_fast_connectable_sync(hdev, false);
 		hci_update_scan_sync(hdev);
 		hci_update_class_sync(hdev);
-		hci_update_name_sync(hdev);
+		hci_update_name_sync(hdev, hdev->dev_name);
 		hci_update_eir_sync(hdev);
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 46b22708dfbd2..da662e1823ae5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3876,8 +3876,11 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 
 static int set_name_sync(struct hci_dev *hdev, void *data)
 {
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_set_local_name *cp = cmd->param;
+
 	if (lmp_bredr_capable(hdev)) {
-		hci_update_name_sync(hdev);
+		hci_update_name_sync(hdev, cp->name);
 		hci_update_eir_sync(hdev);
 	}
 
-- 
2.34.1


