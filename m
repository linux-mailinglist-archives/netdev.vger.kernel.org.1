Return-Path: <netdev+bounces-152048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9129F27C1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 02:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CE316561B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 01:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3720CF9DA;
	Mon, 16 Dec 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Yi5iAljf"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816FE56A;
	Mon, 16 Dec 2024 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734312407; cv=none; b=Kc3wWb4W7rHMQcIvgffZyHfPvo8m2JoMF6RmFn3luwOFKjbQK7Phal/rngxqfNe7fkfvapQWrUADTlwWvhSBzAoFgmQbhh2vNy8wRdMUkC3QyMBJCPFOn58MEN3KlY0Q+g00SqT67P6NUNPeg4kb3KCL9oPDR7eIiaiDhJMaqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734312407; c=relaxed/simple;
	bh=hDsdqkjqR5C1PC+eX1OCSK4L0F7UjCPeuei1VlMplpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwkhgIBM36iHShTmV501GOnSJP5Pt2rLtU/tOfMkM0BTUBI1FtWd5XGPE5Su9HkReBgggR4Fldbxpe8WR+rtvTl2E04q27yoy9+FnjGzNEUbshKBv8DxXjPOkTxxhEQEwwT3NMn3fAwbUvu83MaCIyQtqgeIlzFyh1gpvzbi3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Yi5iAljf; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Ed70Ob2ebRAEalOLLlRfdmXMwXCLAiy2X1HhJXsXAHg=; b=Yi5iAljfykL2hBnN
	y28RTE/WCxJslH0QtwpiRK/l9do1KIrOHgDNHXs6TFxZYXE/wx2qgGv18k1fXDOCWDch+Fivo5SIn
	SDu1maS48i3OoaGRgy51De5iyM9Ly59JQBO26GJT9t83kjy0oTmJdGs1wSORMRpGojDhrzsOhKwAU
	H6Hj+IalvXExvKrC+WQGb861lV8h7e/EBlUjBv8JpXvV21V5FWzYCx1n433LyJQbJQzMy1+hBOMRv
	jcFCYQPqxx1s9/bMaVJmlK7Jnehj7kE6clYnTcPegEZ3wrCO7Wr1Zh4GaPotp0LmnP45b/aDxKtZ8
	90dOTGdjjR31WJt2Ug==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tMzsa-005W3X-38;
	Mon, 16 Dec 2024 01:26:37 +0000
From: linux@treblig.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] Bluetooth: hci: Remove deadcode
Date: Mon, 16 Dec 2024 01:26:36 +0000
Message-ID: <20241216012636.484775-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

hci_bdaddr_list_del_with_flags() was added in 2020's
commit 8baaa4038edb ("Bluetooth: Add bdaddr_list_with_flags for classic
whitelist")
but has remained unused.

hci_remove_ext_adv_instance() was added in 2020's
commit eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS
connections")
but has remained unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/bluetooth/hci_core.h |  2 --
 include/net/bluetooth/hci_sync.h |  1 -
 net/bluetooth/hci_core.c         | 20 --------------------
 net/bluetooth/hci_sync.c         | 24 ------------------------
 4 files changed, 47 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ca22ead85dbe..d122f6398879 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1759,8 +1759,6 @@ int hci_bdaddr_list_add_with_flags(struct list_head *list, bdaddr_t *bdaddr,
 int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type);
 int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 				 u8 type);
-int hci_bdaddr_list_del_with_flags(struct list_head *list, bdaddr_t *bdaddr,
-				   u8 type);
 void hci_bdaddr_list_clear(struct list_head *list);
 
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index f3052cb252ef..7e2cf0cca939 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -140,7 +140,6 @@ int hci_update_scan(struct hci_dev *hdev);
 int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le, u8 simul);
 int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 				     struct sock *sk);
-int hci_remove_ext_adv_instance(struct hci_dev *hdev, u8 instance);
 struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev, bool ext,
 					     struct sock *sk);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 18ab5628f85a..ba955447b359 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2181,26 +2181,6 @@ int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 	return 0;
 }
 
-int hci_bdaddr_list_del_with_flags(struct list_head *list, bdaddr_t *bdaddr,
-				   u8 type)
-{
-	struct bdaddr_list_with_flags *entry;
-
-	if (!bacmp(bdaddr, BDADDR_ANY)) {
-		hci_bdaddr_list_clear(list);
-		return 0;
-	}
-
-	entry = hci_bdaddr_list_lookup_with_flags(list, bdaddr, type);
-	if (!entry)
-		return -ENOENT;
-
-	list_del(&entry->list);
-	kfree(entry);
-
-	return 0;
-}
-
 /* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c86f4e42e69c..984b72d073d7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1785,30 +1785,6 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 					HCI_CMD_TIMEOUT, sk);
 }
 
-static int remove_ext_adv_sync(struct hci_dev *hdev, void *data)
-{
-	struct adv_info *adv = data;
-	u8 instance = 0;
-
-	if (adv)
-		instance = adv->instance;
-
-	return hci_remove_ext_adv_instance_sync(hdev, instance, NULL);
-}
-
-int hci_remove_ext_adv_instance(struct hci_dev *hdev, u8 instance)
-{
-	struct adv_info *adv = NULL;
-
-	if (instance) {
-		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv)
-			return -EINVAL;
-	}
-
-	return hci_cmd_sync_queue(hdev, remove_ext_adv_sync, adv, NULL);
-}
-
 int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 {
 	struct hci_cp_le_term_big cp;
-- 
2.47.1


