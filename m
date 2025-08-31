Return-Path: <netdev+bounces-218547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE237B3D1C3
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 11:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C671887ACA
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC92B248F51;
	Sun, 31 Aug 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pczittn8"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C31A9FBA
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756634381; cv=none; b=uOa1yqf8b6A+8cB/6ZuQ9DB4sZLoI7kPvMynr9Z7z97vpKVFU6ha7hIJtyjcg+1yYtRxalxkAzljrWg84lYUJ7U72Zdko3+x8IvaHXdmy9o2j2g2djiW6f+XePqdqZ62elYoszWP3ERgLQw4Myia9uVlxEno9Q6feTqNWcZD7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756634381; c=relaxed/simple;
	bh=0KkjeJy5JVJeESV08AjM2dcetdJEMfhjNI6FtNSH/3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsUrdjZiauBykf50v5pFPDL0lxGhSD5mUCHC6bLmTkrmrLDobUC4RqE5BsRaufHptOeNz3Dxl4X/gZ6SLyLA/9/Voy2lNzpCe1dzoVN2mnm+avEAXRdo4w/5ka6qXMInxNkf1Mkja0I+/7Y6cmWS9VryemDpcPpfJIQHmFqFa0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pczittn8; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756634376;
	bh=Loz27QVYNzLeCVfjJCj4j3wpQlM+hqvyO/PA6Ks0kqQ=;
	h=From:Subject:Date:Message-ID;
	b=pczittn8x0tMgW3FVfYCZyNrvAuUl+W2UIEy6kaHkqESO3SuUzOjPK+4Ll9uX44oA
	 o7kZdLjh4Dg28f30migt4NJWes9yJIpi0FJMcMQnE3iSJ1gFKWZwiqsLTq0gM5YyDx
	 d4krA/NRXKET0z9QqyB2im+L9DKsTs6mmVV3Q0ZE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68B41CFD00007605; Sun, 31 Aug 2025 17:59:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 244656291923
X-SMAIL-UIID: 9199A7AECE71468597CE2A563C8960A6-20250831-175927-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [nfc?] WARNING in nfc_rfkill_set_block
Date: Sun, 31 Aug 2025 17:59:14 +0800
Message-ID: <20250831095915.6269-1-hdanton@sina.com>
In-Reply-To: <68b3f389.a00a0220.1337b0.002e.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sun, 31 Aug 2025 00:02:33 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1508ce34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11019a62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1308ce34580000

Test Kim's patch.

#syz test

--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1154,6 +1154,7 @@ EXPORT_SYMBOL(nfc_register_device);
 void nfc_unregister_device(struct nfc_dev *dev)
 {
 	int rc;
+	struct rfkill *rfk = NULL;
 
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
@@ -1163,14 +1164,18 @@ void nfc_unregister_device(struct nfc_dev *dev)
 			 "was removed\n", dev_name(&dev->dev));
 
 	device_lock(&dev->dev);
+	dev->shutting_down = true;
 	if (dev->rfkill) {
-		rfkill_unregister(dev->rfkill);
-		rfkill_destroy(dev->rfkill);
+		rfk = dev->rfkill;
 		dev->rfkill = NULL;
 	}
-	dev->shutting_down = true;
 	device_unlock(&dev->dev);
 
+	if (rfk) {
+		rfkill_unregister(rfk);
+		rfkill_destroy(rfk);
+	}
+
 	if (dev->ops->check_presence) {
 		timer_delete_sync(&dev->check_pres_timer);
 		cancel_work_sync(&dev->check_pres_work);
--- x/net/bluetooth/hci_core.c
+++ y/net/bluetooth/hci_core.c
@@ -1476,8 +1476,14 @@ static void hci_cmd_timeout(struct work_
 	if (hdev->reset)
 		hdev->reset(hdev);
 
+	rcu_read_lock();
+	if (hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
+		rcu_read_unlock();
+		return;
+	}
 	atomic_set(&hdev->cmd_cnt, 1);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
+	rcu_read_unlock();
 }
 
 /* HCI ncmd timer function */
--

