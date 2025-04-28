Return-Path: <netdev+bounces-186410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5525A9F035
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3694C179296
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF225D531;
	Mon, 28 Apr 2025 12:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94601DED76;
	Mon, 28 Apr 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841916; cv=none; b=cgxvo3qdjsSKIrIRidt+bPCYcN9JTLL6CkLOBADZO5qsLxVkyxH17ibobMffMFdVUBl2XvC64D15hCCWBRoY6EIotNg9z1zpcwAWVOUUdUg+SfCeA9CTT6mLzmJZiGnvQNIMRc5srHOF/qdFLNwQO/F5YkpbAX3pTsgp1h4jt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841916; c=relaxed/simple;
	bh=RfOJdD5BUi+nJI7xbgDTOcxoqOR1Kt/VacUpy+9m/iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Un40ZCxMdha4UYSdyqDtxQrtHfmBIS5Mnwi40VxKhANrCn209dDQheWex1dn7DyVw4kWCIFNAmz07z2Qi6VQg/m51wBRmXC5oy+6XCatIrG7zbgEJ9THvk7w0irKnTNF5RZ1TiQheh4e6s28JDSeQ2L77w6uXt2+o1E4E6eKqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=none smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpsz9t1745841839t32dc210c
X-QQ-Originating-IP: +fiLpNgiFyCq9nH67qUypFlkxKVTxU7uVycUNFqDSOI=
Received: from localhost.localdomain ( [175.9.43.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 28 Apr 2025 20:03:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9940238249024063661
EX-QQ-RecipientCnt: 9
From: Zhou Bowen <zhoubowen@kylinsec.com.cn>
To: horms@kernel.org
Cc: Shyam-sundar.S-k@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	zhoubowen@kylinsec.com.cn
Subject: [PATCH v1] amd-xgbe: Add device IDs for Hygon 10Gb ethernet controller
Date: Mon, 28 Apr 2025 20:02:34 +0800
Message-Id: <20250428120234.2473239-1-zhoubowen@kylinsec.com.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250416185218.GY395307@horms.kernel.org>
References: <20250416185218.GY395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M8TtDEU6z3sY061kYGe9fzlAnb0heBOrytg0uFI94QhQsMNpCSifkU6w
	wpZfk5PgYd4qY+8/ub47/A0eJFPs4Qa5xNvrM3xCTLGlQlsPi47XhLwejIbkXgKQudkfbWp
	oVoM6r/Uf8TYbrL9oj7KG6+UeUQHy4gxub3tMDS6riam1J2qNB8ek6FDs85ESnWVBce8+US
	RBJTccl3WdMWdoyGyoDjCVJNPEyHXO2yRHxHa5EFAL0vKBk9Z5IGKSRacU4unhLoNPYnUCn
	z606ipoyQip+7mkcm+H9Iu//QwXpAzWkR6Fz5gKY77PqFkMYeppbvVH8FJl+I3Kq+gAQnUB
	w1dpERtycGLN7cCwAupcKHjdTh2gHc3epdP/mTxsOskmFzNB+nllP8ti7AI/nLAPf6Lyj9v
	WJ5PGSrrXQuOqw7z6s26jtIWKTkvu+qHxVvX+b+7XU41wJAXacBYgVsPtEboy9Ep9T/jju0
	ELG3ncuppSIuNBgm8mntQLpYjHPX2U3vOUR12DsPMSpAgKdItzTUn3DNnb4jwDRtS3bfl/s
	XugpdOnzo5T6yHE0wjCDQ6dCj3FwHAZC1sUO39vIAd3//0NETWpc5xiIkH8qHfEubb0S+dK
	XSDjmQ+DF++EuIZYtzlc+2L5hrofGtU8zmHCntamRFx0NAka/tFhRXBV65VYVzWj45VrwdK
	V/mPudlb4AKLjW9nqSVig3Y/hfJvO128cvodxYJLCYlRdMigz6231kPDzAzujzOHjPQuZrD
	FMuhfKuLg9VN4j5OJ79SZmyqdiYfCMdO76ct5CnrlDqTBhqMPTMdsSxz8yJeZIa9Cv016WS
	0t9yrqDmZDUTVfXRGGsdrOpbXYz+LZRQmViZqEzcFWbzBrw0C4nUxXTCBg1sLJmcYYMLEpM
	1jCNLffge8fO6mLgZ9HHWvgmwksBIxTwqOWHINlQueJs95M4Ayvo+mLFD3nMfkhrkH5djbR
	veHUdOJUdx066IST0VMwxN4qbxfjOyTDRki1MmxBS8YwcmPhcrgj7kTWK/EHWj+96xIoE7v
	o6TrMcUbd5VUGUnopT
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add device IDs for Hygon 10Gb Ethernet controller.

Signed-off-by: Zhou Bowen <zhoubowen@kylinsec.com.cn>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index f409d7bd1f1e..206ff2e9e3cb 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -510,6 +510,10 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(HYGON, 0x1458),
+	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
+	{ PCI_VDEVICE(HYGON, 0x1459),
+	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.27.0


