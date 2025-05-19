Return-Path: <netdev+bounces-191381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF06ABB53C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5483B3867
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 06:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5EE1DDC2A;
	Mon, 19 May 2025 06:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8DA136358
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747636526; cv=none; b=BHUaBuGqR5xyKFeKwZhqg1fB7hz4IDxn5b5e0zI0v5NnoL9CjHDugEnLHgqQAWiB7Hn+d0usbE5uJgjL8rGRVXdD2OuwtXdf23F2YfNt80spjPXoQEp8iw+12X2ENdBEQfL+ycd9LvoCiv9ixgn8nv1Aw2OY/8B84JYxd7IilH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747636526; c=relaxed/simple;
	bh=whSVd2GPtXSBPn8+unr3UzXeBt4T9TxLWM47BQKwnJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlCSHxFGIvuilfuR3N4TR3pEgNLZbeDkzfZT0UMsyRR3wBPmb1T5qWYshGTscouaMaetdkIwVcIcwc4N8HTvfbspO4nN5fD9yXSdoVe2gLjBVxCMiSft6s2dXw2mEANJQtjY4yc9sULWUVwod8WfJRMD5znXabDUipPZLbz011Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1747636450t72b2ecec
X-QQ-Originating-IP: A2xmDCZ27vMM8DZ/IMgZuvquzCxsg0WvAmJqjCRQfjY=
Received: from w-MS-7E16.trustnetic.com ( [125.119.67.87])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 14:34:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11827701625567042168
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: libwx: Fix log level
Date: Mon, 19 May 2025 14:33:57 +0800
Message-ID: <67409DB57B87E2F0+20250519063357.21164-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MKP/ykXjBfbuyv0H1luUbEsKUR+mKt6OMfKA2qRfcRez+Mz9dfkbFGca
	vOoWXlFl5QjPXyFHgPKtMvNXyFQZ8yfbDQHbyrmEl7l9f6n/XrLr78q1O2nI2yEfoqrtWo1
	QI34cHZeyVePjt5i1yr1bhIEPaCwwNSAw0Ju/SS1pksuITbrRrTpcBSUebWnP1GP/aYfIQ/
	GLd2DlPAalAM5/9CEs3dXgeUdDfYqI0SwJOtda+FKXYMc5wdgWVRbVs8HOmnwqghXiVsuQX
	/G+KoromnXeTkAtBlN/yK3y7LF0tb9bqx+ExeSVs42kzW8oLgN9lczmXZUt58dRmVbvHEmJ
	ffgpTqwrg7YPfD6RG7Cx6P6AI1KNZs+LkBBmuT7dx3beI4xUa4as8b5oCom2mTw8GSah9+c
	EAwBjSAExDmZWq1f6osKed4VJ5I+GOgiYlfjc4n836ooxdRjgQ3KN2jdwdX3XF2wWgJUWk6
	OSROatlK/IHnudLyIYN0pqrl/zykbjGxtxlXJXX4dcVK4cp15R0ZTfAF9wIUOABWE+oAZmM
	OaWoSHHiylY9i7RgSmQgowLoXYxFMQ7MMCbGMWLZNh0xn3XMLn6pO/f9mGJgF5QeQjYWK54
	MHxgN1XXlTatdqmPOLuqCIfRymisrFMYfOjl9Mwu+wj37Xqb/dz0VwwLxe07pl1emFAqLHR
	hBY/yVYPzWFHhvRXk7DRunH+7Jf9/MkRxdW0Bws4OxrbCE0ECHbE7gScOp7v0bWT4w/pZ0e
	tj38UXKgMyAaLqXtKkXRLVYvtxg7B9dB+tRoGhYIkpqOQVZUeCY2qsrePvo1l3MaMmTu3ew
	uu6oGkuv4zY/6XT0HX8EqFVFLYVaMcIvaAluqNJtqABqnf21xnmWiRDx/11MGBKM2+pMZTr
	Lu14zYzro0TG+u7lVvuam2gigFqisN27qya4aVan3VT0HAPbFiRqOu/LMudGxGCmT27B6VM
	6GuCeGhm/ETUG/CAUCqn+5jHfAuhINjB5ma6Cy/JXOwRzeELU+aYzkbzawBlMc/ZFULCojQ
	nYnPymMSkgrIw/77HB
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

There is a log should be printed as info level, not error level.

Fixes: 9bfd65980f8d ("net: libwx: Add sriov api for wangxun nics")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 52e6a6faf715..195f64baedab 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -76,7 +76,7 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
 	u32 value = 0;
 
 	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
-	wx_err(wx, "SR-IOV enabled with %d VFs\n", num_vfs);
+	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
 
 	/* Enable VMDq flag so device will be set in VM mode */
 	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
-- 
2.48.1


