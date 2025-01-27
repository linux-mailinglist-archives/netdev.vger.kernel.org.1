Return-Path: <netdev+bounces-161200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDF5A1FFF9
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E7E3A5052
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41151D8A0D;
	Mon, 27 Jan 2025 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="H/MX8uMX"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AD1D7E47;
	Mon, 27 Jan 2025 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013846; cv=none; b=cIo/5OmmQgEaE1/cmRenZLTGImuLx+ZMKIoJ0WCH7nNxXf10eeq54ID3J3fCa5Ols9+DXkYc46V2DbpLvOURySVtEsPatW3KaVIXoY3wl2V8sa8zGCD3Y58dFHboFydXlRt3LiAKtIRF+D72BUBvRSBNyUSJ64fph3BgpXxAZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013846; c=relaxed/simple;
	bh=ud1EoghHPONQvTg+/ZBFUPpQ5VF+GOAO6G9iW/s/QIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc5Rahxpdv9VvNz8MjzqJH38F8lLgzirFVWAu8yw8fufZ49/6JNoshb7glFYsNzP5Z2bdfwx5zUXC4t9YHysshM3+4nNKY5pBAI7fSgJOsxqABUZdukeiVv94Pz14uh6eXu8A8dJ+DbXMPOLjP+3wWF0NaZteXkFWXLxwalYOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=H/MX8uMX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=t1/PWq3W3jycJ6pu6roZnq585fZAq85K5WbfAwoVbGE=; b=H/MX8uMXQK+EDcW4
	cE1EE+KR4ZNX7KVuiXqjVQxy0E3U1iUxtN+W+HLd+dpyhtm5stpb8uNQuZlyjKPV3ktEC44A1TJPf
	Ayga9Gtw9jvElhvnV1/gUwohvEL3n5fBPRvGe7+4VnnqsRWefsbV4NUvGFEA9qvg66caqttnfssqX
	Ek98DC40KIXrJfnMTtxMB0WdxVA/fuQWcX1nk8M0eogkTXY6xFwE8qYcYr5kv5KQXmRzjMgyb55s0
	Lte3lq8I8BQ1jb6g/MwIeK3Mcw59lMHVSfXuLH+FsiT7EGzgSRcNbN+BN/YfdWc6dammKkumKlm3S
	RLikH14GhcobtdZJGQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tcWnG-00CMm7-1E;
	Mon, 27 Jan 2025 21:37:18 +0000
From: linux@treblig.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/2] Bluetooth: MGMT: Remove unused mgmt_*_discovery_complete
Date: Mon, 27 Jan 2025 21:37:16 +0000
Message-ID: <20250127213716.232551-3-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127213716.232551-1-linux@treblig.org>
References: <20250127213716.232551-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

mgmt_start_discovery_complete() and mgmt_stop_discovery_complete() last
uses were removed in 2022 by
commit ec2904c259c5 ("Bluetooth: Remove dead code from hci_request.c")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/bluetooth/hci_core.h |  2 --
 net/bluetooth/mgmt.c             | 40 --------------------------------
 2 files changed, 42 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f756fac95488..05919848ea95 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2386,8 +2386,6 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
-void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status);
-void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f53304cb09db..e8533167aa88 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5743,29 +5743,6 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	bt_dev_dbg(hdev, "status %u", status);
-
-	hci_dev_lock(hdev);
-
-	cmd = pending_find(MGMT_OP_START_DISCOVERY, hdev);
-	if (!cmd)
-		cmd = pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev);
-
-	if (!cmd)
-		cmd = pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev);
-
-	if (cmd) {
-		cmd->cmd_complete(cmd, mgmt_status(status));
-		mgmt_pending_remove(cmd);
-	}
-
-	hci_dev_unlock(hdev);
-}
-
 static bool discovery_type_is_valid(struct hci_dev *hdev, uint8_t type,
 				    uint8_t *mgmt_status)
 {
@@ -6018,23 +5995,6 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	bt_dev_dbg(hdev, "status %u", status);
-
-	hci_dev_lock(hdev);
-
-	cmd = pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
-	if (cmd) {
-		cmd->cmd_complete(cmd, mgmt_status(status));
-		mgmt_pending_remove(cmd);
-	}
-
-	hci_dev_unlock(hdev);
-}
-
 static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
-- 
2.48.1


