Return-Path: <netdev+bounces-175193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC97A6439C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A062718935AB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1FD21ABB8;
	Mon, 17 Mar 2025 07:29:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D0214A8F;
	Mon, 17 Mar 2025 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196591; cv=none; b=F3aL8JPJkYN/Tl1PNC/wDA9pzYQW9EDc6EIaf7Va/SsvxLHq7I0RfMxl8gWJZaDWNcAYUHdYw5Tn40HQmdr6ljBUw9QFHx0FnSqbeCjKSSuHIPLzjS0QUTgCcuE4wKPFf8HyzoQJkkxRhlk03VwnK22o2R7Yujt6kfDK+uChfE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196591; c=relaxed/simple;
	bh=71xyelr37/P1vqoVyhq2nM/jAhPFe2onPN0Cv7H5xkY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=tQ1pJCNPfw1P3lVMKsnmLbzNdCuynT8BDbhfY9pHcuFkDprgkX9AyBrZegKPYcOp71q0pFUrKPoZlMJauuDVEH+zBW1qbbHcBe6WH6FT3Po4o9oUfg+YKNvfX9yyoiBAyiI+e0+cbV7dzDV3ZvWFy48s+emxYJalNvTNuDw1nnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGRSV3C9gz5B1K0;
	Mon, 17 Mar 2025 15:29:46 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52H7TVCK098170;
	Mon, 17 Mar 2025 15:29:31 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:29:33 +0800 (CST)
Date: Mon, 17 Mar 2025 15:29:33 +0800 (CST)
X-Zmail-TransId: 2afb67d7cf5d0f9-ef56e
X-Mailer: Zmail v1.0
Message-ID: <20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <davem@davemloft.net>
Cc: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <xie.ludan@zte.com.cn>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?wqBbUEFUQ0ggbGludXgtbmV4dF0gbmV0OiBhdG06IHVzZSBzeXNmc19lbWl0KCkvc3lzZnNfZW1pdF9hdCgpIGluc3RlYWQgb2Ygc2NucHJpbnRmKCku?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H7TVCK098170
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7CF6A.001/4ZGRSV3C9gz5B1K0

From: XieLudan <xie.ludan@zte.com.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
---
 net/atm/atm_sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
index 54e7fb1a4ee5..ae0d921157c5 100644
--- a/net/atm/atm_sysfs.c
+++ b/net/atm/atm_sysfs.c
@@ -16,7 +16,7 @@ static ssize_t type_show(struct device *cdev,
 {
 	struct atm_dev *adev = to_atm_dev(cdev);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", adev->type);
+	return sysfs_emit(buf, "%s\n", adev->type);
 }

 static ssize_t address_show(struct device *cdev,
@@ -24,7 +24,7 @@ static ssize_t address_show(struct device *cdev,
 {
 	struct atm_dev *adev = to_atm_dev(cdev);

-	return scnprintf(buf, PAGE_SIZE, "%pM\n", adev->esi);
+	return sysfs_emit(buf, "%pM\n", adev->esi);
 }

 static ssize_t atmaddress_show(struct device *cdev,
@@ -37,7 +37,7 @@ static ssize_t atmaddress_show(struct device *cdev,

 	spin_lock_irqsave(&adev->lock, flags);
 	list_for_each_entry(aaddr, &adev->local, entry) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
+		count += sysfs_emit_at(buf, count,
 				   "%1phN.%2phN.%10phN.%6phN.%1phN\n",
 				   &aaddr->addr.sas_addr.prv[0],
 				   &aaddr->addr.sas_addr.prv[1],
@@ -55,7 +55,7 @@ static ssize_t atmindex_show(struct device *cdev,
 {
 	struct atm_dev *adev = to_atm_dev(cdev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", adev->number);
+	return sysfs_emit(buf, "%d\n", adev->number);
 }

 static ssize_t carrier_show(struct device *cdev,
@@ -63,7 +63,7 @@ static ssize_t carrier_show(struct device *cdev,
 {
 	struct atm_dev *adev = to_atm_dev(cdev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			 adev->signal == ATM_PHY_SIG_LOST ? 0 : 1);
 }

@@ -87,7 +87,7 @@ static ssize_t link_rate_show(struct device *cdev,
 	default:
 		link_rate = adev->link_rate * 8 * 53;
 	}
-	return scnprintf(buf, PAGE_SIZE, "%d\n", link_rate);
+	return sysfs_emit(buf, "%d\n", link_rate);
 }

 static DEVICE_ATTR_RO(address);
-- 
2.25.1

