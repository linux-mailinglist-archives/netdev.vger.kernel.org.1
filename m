Return-Path: <netdev+bounces-177277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A7A6E851
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 03:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9321750D3
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 02:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47D16A395;
	Tue, 25 Mar 2025 02:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330E2F5B;
	Tue, 25 Mar 2025 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742869704; cv=none; b=N0oX1FXT2St6A0CUEfoc1En+T2/HNwyf2TFKa8LIWYJd49d1p8RBOXTjqwi/ulZshaOZFeG5DF/gVtnCQ62CyvDt5MfvjIneGDI+0r581lZhvHAlVaQ9HUMltllTKTvjR1kbQRmbVE9fiE4o/a63vAz4caQQ1sPFMg4A3bhoQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742869704; c=relaxed/simple;
	bh=V+mB+ZstiqbnQk8AMFoZznwHHZnep1iV2IOn3HfkR6E=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=TRuaMHbbFY0vl7L3gdgbDTLopz6Thn+YgVdiv1v+/KhENqqKquTaz+frP8gbZkCPKCFRM9d8aHDvKNxWA0w9fGKgvTYQ5rZKft+WB2KpnJR6RtSGXEl6raXNNaRWpJzKYXXc4JMntYWX5e1DPQslTV96i+2l8PGe1FwVwwya6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZMDNq0nF6z8R03x;
	Tue, 25 Mar 2025 10:28:11 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 52P2S3kJ030932;
	Tue, 25 Mar 2025 10:28:03 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 25 Mar 2025 10:28:05 +0800 (CST)
Date: Tue, 25 Mar 2025 10:28:05 +0800 (CST)
X-Zmail-TransId: 2afb67e214b534d-625f7
X-Mailer: Zmail v1.0
Message-ID: <20250325102805210eUc7-ji7GineR0TUNA9Nn@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <davem@davemloft.net>, <gerhard@engleder-embedded.com>
Cc: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <xie.ludan@zte.com.cn>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIG5ldDogYXRtOiB1c2Ugc3lzZnNfZW1pdCgpL3N5c2ZzX2VtaXRfYXQoKSBpbnN0ZWFkIG9mIHNjbnByaW50ZigpLg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52P2S3kJ030932
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67E214BB.000/4ZMDNq0nF6z8R03x

From: XieLudan <xie.ludan@zte.com.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
---
v2:
    - adapting the alignment of argument lines
 net/atm/atm_sysfs.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
index 54e7fb1a4ee5..726398fa848e 100644
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
@@ -37,13 +37,12 @@ static ssize_t atmaddress_show(struct device *cdev,

 	spin_lock_irqsave(&adev->lock, flags);
 	list_for_each_entry(aaddr, &adev->local, entry) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "%1phN.%2phN.%10phN.%6phN.%1phN\n",
-				   &aaddr->addr.sas_addr.prv[0],
-				   &aaddr->addr.sas_addr.prv[1],
-				   &aaddr->addr.sas_addr.prv[3],
-				   &aaddr->addr.sas_addr.prv[13],
-				   &aaddr->addr.sas_addr.prv[19]);
+		count += sysfs_emit_at(buf, count, "%1phN.%2phN.%10phN.%6phN.%1phN\n",
+				       &aaddr->addr.sas_addr.prv[0],
+				       &aaddr->addr.sas_addr.prv[1],
+				       &aaddr->addr.sas_addr.prv[3],
+				       &aaddr->addr.sas_addr.prv[13],
+				       &aaddr->addr.sas_addr.prv[19]);
 	}
 	spin_unlock_irqrestore(&adev->lock, flags);

@@ -55,7 +54,7 @@ static ssize_t atmindex_show(struct device *cdev,
 {
 	struct atm_dev *adev = to_atm_dev(cdev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", adev->number);
+	return sysfs_emit(buf, "%d\n", adev->number);
 }

 static ssize_t carrier_show(struct device *cdev,
@@ -63,8 +62,7 @@ static ssize_t carrier_show(struct device *cdev,
 {
 	struct atm_dev *adev = to_atm_dev(cdev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 adev->signal == ATM_PHY_SIG_LOST ? 0 : 1);
+	return sysfs_emit(buf, "%d\n", adev->signal == ATM_PHY_SIG_LOST ? 0 : 1);
 }

 static ssize_t link_rate_show(struct device *cdev,
@@ -87,7 +85,7 @@ static ssize_t link_rate_show(struct device *cdev,
 	default:
 		link_rate = adev->link_rate * 8 * 53;
 	}
-	return scnprintf(buf, PAGE_SIZE, "%d\n", link_rate);
+	return sysfs_emit(buf, "%d\n", link_rate);
 }

 static DEVICE_ATTR_RO(address);
-- 
2.25.1

