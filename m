Return-Path: <netdev+bounces-119736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592B956C76
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EE3283980
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E91B16C6BF;
	Mon, 19 Aug 2024 13:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AD1BDCF;
	Mon, 19 Aug 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075695; cv=none; b=EMjmeFvzTCYoYjlq1iJKHX/6utOHpVu3sKqufyWm74QDpH5o6eB3sNczeNPcv8RegxE5iOOlc5uJbSxWuYC0ZaaUN1d2+2KkHlevKIdjJFoJhFCwDtYUw4rytQEvvvvZ4VRmdCetzvYQH8QwweARfc7rwBHarSVkaroY4fysBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075695; c=relaxed/simple;
	bh=RHxnf6k9s/tFDKpedjE8L9WdY/mrk5eOGdGwgpjZBrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4sADfQG/eNmQfDq7pQZvaR7F/oHSRtNZ/DTwSllr004NQ/VGx3MX9eg8cnStnAPBsXtSFqs7F/jYIyMXXzibzm5c1dIY/zVbS4PFR4AgRLPBLmgZd3QZ4UabTA64uwt6Nroy8FLpJ+PHQYqpINXRFzsWsbBu958k2XDiABwZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WnYt31krhz1HGmt;
	Mon, 19 Aug 2024 21:51:39 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 41FD614022E;
	Mon, 19 Aug 2024 21:54:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 21:54:48 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] Bluetooth: L2CAP: Remove unused declarations
Date: Mon, 19 Aug 2024 21:52:11 +0800
Message-ID: <20240819135211.119827-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit e7b02296fb40 ("Bluetooth: Remove BT_HS") removed the implementations
but leave declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/bluetooth/l2cap.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5cfdc813491a..313d0b972e06 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -968,10 +968,6 @@ void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 		     void *data);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
-void l2cap_move_start(struct l2cap_chan *chan);
-void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
-		       u8 status);
-void __l2cap_physical_cfm(struct l2cap_chan *chan, int result);
 
 struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn);
 void l2cap_conn_put(struct l2cap_conn *conn);
-- 
2.34.1


