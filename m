Return-Path: <netdev+bounces-175198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D10A64456
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780991675C8
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F73219A63;
	Mon, 17 Mar 2025 07:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2D145B3F;
	Mon, 17 Mar 2025 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197881; cv=none; b=SVqrd96nPal8uXaLZvtJhT9m/gURKctGSbR4x+cxHRvfZ25zPzyThhjO564304TgN9pDL5faKhfGYL7jJ0Q8T2HTfDXOJzx6KINZZJWe8RZUUpG6YbBYJ2dGkzeif9bfab+i8R1qGEivelfl22SzTdWVP+R1T+RkQLiBbA72DyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197881; c=relaxed/simple;
	bh=F0hTaMgLVM15/Ktu0T1omVNrLBE5Owg1sxOiHJ/dQhM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=qZbvDv7rGwjEIg4c8ZkaEfonZr6EWFMf4XD6gne2pMR1US9IBwainmcafHNcrEwi8NXAlwDE1XQRzK/UbqrT2cW110TcsekbLPVNZ+JoEe+hV28+lDhOsNmRQ26jXuQaG7srvj7Vhm39p8NiixyXKTD6w9PTzO7fKM6yEo0o1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGRxF5Ryfz501gR;
	Mon, 17 Mar 2025 15:51:13 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52H7p07k031691;
	Mon, 17 Mar 2025 15:51:00 +0800 (+08)
	(envelope-from tang.dongxing@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:51:02 +0800 (CST)
Date: Mon, 17 Mar 2025 15:51:02 +0800 (CST)
X-Zmail-TransId: 2af967d7d466ffffffffa84-93e56
X-Mailer: Zmail v1.0
Message-ID: <20250317155102808MZdMkiovw52X0oY7n47wI@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <tang.dongxing@zte.com.cn>
To: <davem@davemloft.net>
Cc: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <tang.dongxing@zte.com.cn>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.guang5@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <ye.xingchen@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQ6IGF0bTogdXNlIHN5c2ZzX2VtaXRfYXQoKSBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H7p07k031691
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7D471.005/4ZGRxF5Ryfz501gR

From: TangDongxing <tang.dongxing@zte.com.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: TangDongxing <tang.dongxing@zte.com.cn>
---
 net/atm/atm_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
index 54e7fb1a4ee5..d06ffadc5139 100644
--- a/net/atm/atm_sysfs.c
+++ b/net/atm/atm_sysfs.c
@@ -37,7 +37,7 @@ static ssize_t atmaddress_show(struct device *cdev,

 	spin_lock_irqsave(&adev->lock, flags);
 	list_for_each_entry(aaddr, &adev->local, entry) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
+		count += sysfs_emit_at(buf, count,
 				   "%1phN.%2phN.%10phN.%6phN.%1phN\n",
 				   &aaddr->addr.sas_addr.prv[0],
 				   &aaddr->addr.sas_addr.prv[1],
-- 
2.25.1

