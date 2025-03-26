Return-Path: <netdev+bounces-177670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E344A7114E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297033BACCC
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A319AD8C;
	Wed, 26 Mar 2025 07:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA76199938;
	Wed, 26 Mar 2025 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973802; cv=none; b=Om1gluZaGeUaD2HHXc4Mm/egwuYhVhatPFveZgrJbOvxgAAC2HsTsgZhGNyhHxEGWhGuVrGvo5dX0s2Udso3zSu/5MevId3xWdKbtZSxcKt4LR9vLcYK21QdThwbWz7EJR6E1IcrXB08MABbZJF/GVk2N0TgCVyScVNwL+feAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973802; c=relaxed/simple;
	bh=GA8ThzYUBI9F96U1+AKgbnlvRrC+E6gr96wL8Jnjar0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=PBlyDC5jYt+WRodiq5ioH7oNXOtBhN9c3VtSa70cIyVV0ebHiyIbzeGFGJZspWCN6PKrRGkcI8RVruqxcfCicQRjLdukgmZ4e8oZDdYs1BH07eoSh+Bg3DKXxayUOisXtJBjnA8VWp2hlp4SbsUlCORofsdj26X9BZCzC4PLz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZMytm6ZnLz8R045;
	Wed, 26 Mar 2025 15:23:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 52Q7Mskl062561;
	Wed, 26 Mar 2025 15:22:54 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Mar 2025 15:22:57 +0800 (CST)
Date: Wed, 26 Mar 2025 15:22:57 +0800 (CST)
X-Zmail-TransId: 2afa67e3ab51745-aa1af
X-Mailer: Zmail v1.0
Message-ID: <202503261522574184L3W31Wv9IlTfjF1W9Eh8@zte.com.cn>
In-Reply-To: <20250325102805210eUc7-ji7GineR0TUNA9Nn@zte.com.cn>
References: 20250325102805210eUc7-ji7GineR0TUNA9Nn@zte.com.cn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <xie.ludan@zte.com.cn>, <davem@davemloft.net>, <horms@kernel.org>
Cc: <gerhard@engleder-embedded.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <xie.ludan@zte.com.cn>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IHYyXSBuZXQ6IGF0bTogdXNlIHN5c2ZzX2VtaXQoKS9zeXNmc19lbWl0X2F0KCkgaW5zdGVhZCBvZiBzY25wcmludGYoKS4=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52Q7Mskl062561
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67E3AB60.003/4ZMytm6ZnLz8R045

>From: XieLudan <xie.ludan@zte.com.cn>
>
>Follow the advice in Documentation/filesystems/sysfs.rst:
>show() should only use sysfs_emit() or sysfs_emit_at() when formatting
>the value to be returned to user space.
>
>Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
>---
>v2:
>    - adapting the alignment of argument lines
> net/atm/atm_sysfs.c | 24 +++++++++++-------------
> 1 file changed, 11 insertions(+), 13 deletions(-)
>
>diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
>index 54e7fb1a4ee5..726398fa848e 100644
>--- a/net/atm/atm_sysfs.c
>+++ b/net/atm/atm_sysfs.c
>@@ -16,7 +16,7 @@ static ssize_t type_show(struct device *cdev,
> {
> 	struct atm_dev *adev = to_atm_dev(cdev);
>
>-	return scnprintf(buf, PAGE_SIZE, "%s\n", adev->type);
>+	return sysfs_emit(buf, "%s\n", adev->type);
> }
>

Generally LGTM. Thanks.

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

> static ssize_t address_show(struct device *cdev,
>@@ -24,7 +24,7 @@ static ssize_t address_show(struct device *cdev,
> {
> 	struct atm_dev *adev = to_atm_dev(cdev);
>
>-	return scnprintf(buf, PAGE_SIZE, "%pM\n", adev->esi);
>+	return sysfs_emit(buf, "%pM\n", adev->esi);
> }
>
> static ssize_t atmaddress_show(struct device *cdev,
>@@ -37,13 +37,12 @@ static ssize_t atmaddress_show(struct device *cdev,
>
> 	spin_lock_irqsave(&adev->lock, flags);
> 	list_for_each_entry(aaddr, &adev->local, entry) {
>-		count += scnprintf(buf + count, PAGE_SIZE - count,
>-				   "%1phN.%2phN.%10phN.%6phN.%1phN\n",
>-				   &aaddr->addr.sas_addr.prv[0],
>-				   &aaddr->addr.sas_addr.prv[1],
>-				   &aaddr->addr.sas_addr.prv[3],
>-				   &aaddr->addr.sas_addr.prv[13],
>-				   &aaddr->addr.sas_addr.prv[19]);
>+		count += sysfs_emit_at(buf, count, "%1phN.%2phN.%10phN.%6phN.%1phN\n",
>+				       &aaddr->addr.sas_addr.prv[0],
>+				       &aaddr->addr.sas_addr.prv[1],
>+				       &aaddr->addr.sas_addr.prv[3],
>+				       &aaddr->addr.sas_addr.prv[13],
>+				       &aaddr->addr.sas_addr.prv[19]);
> 	}
> 	spin_unlock_irqrestore(&adev->lock, flags);
>
>@@ -55,7 +54,7 @@ static ssize_t atmindex_show(struct device *cdev,
> {
> 	struct atm_dev *adev = to_atm_dev(cdev);
>
>-	return scnprintf(buf, PAGE_SIZE, "%d\n", adev->number);
>+	return sysfs_emit(buf, "%d\n", adev->number);
> }
>
> static ssize_t carrier_show(struct device *cdev,
>@@ -63,8 +62,7 @@ static ssize_t carrier_show(struct device *cdev,
> {
> 	struct atm_dev *adev = to_atm_dev(cdev);
>
>-	return scnprintf(buf, PAGE_SIZE, "%d\n",
>-			 adev->signal == ATM_PHY_SIG_LOST ? 0 : 1);
>+	return sysfs_emit(buf, "%d\n", adev->signal == ATM_PHY_SIG_LOST ? 0 : 1);
> }
>
> static ssize_t link_rate_show(struct device *cdev,
>@@ -87,7 +85,7 @@ static ssize_t link_rate_show(struct device *cdev,
> 	default:
> 		link_rate = adev->link_rate * 8 * 53;
> 	}
>-	return scnprintf(buf, PAGE_SIZE, "%d\n", link_rate);
>+	return sysfs_emit(buf, "%d\n", link_rate);
> }
>
> static DEVICE_ATTR_RO(address);
>-- 
>2.25.1

