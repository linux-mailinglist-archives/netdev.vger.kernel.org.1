Return-Path: <netdev+bounces-46207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855E7E26D4
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 15:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A11B20DFC
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F943179B2;
	Mon,  6 Nov 2023 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hQjOfAsB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49828DAA
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:31:35 +0000 (UTC)
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF11991;
	Mon,  6 Nov 2023 06:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699281091; bh=cDDdtF+lljV7pn/L6PPw2wWs1zIAvruOvia18LhrCpQ=;
	h=From:To:Cc:Subject:Date;
	b=hQjOfAsBTotsZFzrFc0MVDlKIfCXsokqvGfkEPb0gMWPe/uqNkn+k5F3ndlIY7ZsY
	 BvLa60EEfFAX2CSuTvD70nH55vTXZQYkuYHRRllt/5VXfkYquQm/qDZL269fRCHr7z
	 ul/fdPAM/ST5PrujyS7OWRLjbY23cG1donKuXAOE=
Received: from pek-lxu-l1.wrs.com ([2408:8409:2460:1c13:549b:dd5b:edb5:dcb3])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id 7DB81248; Mon, 06 Nov 2023 22:31:27 +0800
X-QQ-mid: xmsmtpt1699281087tyid3y0xm
Message-ID: <tencent_AD33049E711B744BDD1B3225A1BA3DBB9A08@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9R6IjZziZUreQPA1vys8SvE8JpWOYngLh3gdo5fEPOMl4fwPue4
	 StEvymumnyh5k8sgKgPeKzgPkS+idQku8AomUo2Xe5lZxVm+W3+XHtRuvjYf03m8IwYP7ckjm9JC
	 j+8U3El2vm+qPmJ8RzhwlKSL+V3KYuLua8Jx/8gg0tgzrMcB8tb/O6znS6fW8m+oCGciQKnEc0ae
	 +wR+rmLHfkJ4atMCLK8K9pi7K8aFnmTk7IwMb04fuStILwSnCZyhCcWuU1I+6OWKUg2MZns0qtNR
	 LwqBMeOS2PJPiyTDHBcibnoth7/v+6k9IVQeLzYV9nNIZZh1OA4Q45Xh0Yxj8tFIF0D61RpV2EFD
	 gwBW0GMCjPeXp3rqsFz/qQ14gTIuTDxR9aQr2VKZQwe7WGhfKbcdFfu5Hj0zSx9QfijwxQLBtRWa
	 gdilVlDK7IY2BuP03Jd08T6xZuivBC4oj10guIjD+M2/3U7DSTDrBkt60uzdoUw24n6b+0jy5iZw
	 r4HTwdJ6BVua/ixIOWTI+ncnbRX7wmhdjhFu7Mw0uMqLbmCOO90VbLT53ZocA89HdN1iyuXtY9wl
	 o2hawiXT8687R+jTL0Gol75f/KaiJc7Lpo0xnARChmMWtAnfUKH7644/hAMOC4Yi2yotgNGPV28N
	 /OwQVrNuQBN0hLDtllcLmKtEr13YAtDjJ16teqicPMbrlUMNIkHYNd/IS+WrYGxlftwabIy2tZ5o
	 7iphGMhDfkK2814GTT4cl//Lx541cfdRJBqV5kJO0VybMlnrSsbXcmzpuO46aUfV1AKOqOsmrV7s
	 atYyf+f4yE5KFVK1q4gZecTqP8ACQUo4qgLfbFnYgUDOaieP+Pc/42hBfrv9a5SnEzyfY6g3D3/P
	 4WFQZPbenk8aP9h7UlqmiKLjjNb3hEjtCrPvN1PpH3jK7ILsS78op71QN3nN1ojqdeRm3PGgLCIC
	 5ZcNyq0/UE14XB1ZkPpIYVBYS/N9cuVsMZKzcuj9i62tYlK9WjIWI2teHG3admj+hxf3e8CtfWXn
	 H87b9EywTglRtH6ol/
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	habetsm.xilinx@gmail.com,
	jeremy@jcline.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: [PATCH net-next V8 1/2] ptp: ptp_read should not release queue
Date: Mon,  6 Nov 2023 22:31:27 +0800
X-OQ-MSGID: <20231106143127.3936908-3-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firstly, queue is not the memory allocated in ptp_read;
Secondly, other processes may block at ptp_read and wait for conditions to be
met to perform read operations.

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/ptp/ptp_chardev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 473b6d992507..3f7a74788802 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -588,7 +588,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
-- 
2.25.1


