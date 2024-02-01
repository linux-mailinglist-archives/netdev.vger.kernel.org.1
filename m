Return-Path: <netdev+bounces-67989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EAB8458CA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68A41F22307
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5DA5336A;
	Thu,  1 Feb 2024 13:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34586656;
	Thu,  1 Feb 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793801; cv=none; b=UdEQOAR51z75Ozp6qN2G1oA7gDcurVlRrd4BFV0XcC4zNN3gAhJzewKiIy6T42xqLsLjN8vr7UoaN8P4LusCYaareOtVvt9yCPBXERJe5EhlB48GJ/o0k+ugRSiU6lqjX7QUXj85pUXqXzPLK8YTMi00UkKazT8e7DvyKkaB0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793801; c=relaxed/simple;
	bh=lm9LwpnwHVLkoxdrAp2M03hn2nsbyzgQA6y9JS58UnU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=btqqtjro6qDr2QLHwCJ9KZ1zxIum4bdIaLqTKdRg1yvxk8K1twYvw9uH/MzRP/uvkgR1jNp3puHNP5+rm8SrIp5sh5Z+Fb6xwt0rEmLXBhABkbPg66uzpol8If9ewTrG57FTcBwfwFrJ3NPjKjq8eDcRRia0E8eTf3t2eYDV0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TQfj42N2kz1vsrD;
	Thu,  1 Feb 2024 21:22:48 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id E014B1400D4;
	Thu,  1 Feb 2024 21:23:13 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 21:23:13 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net-next] tun: Fix code style issues in <linux/if_vlan.h>
Date: Thu, 1 Feb 2024 21:23:12 +0800
Message-ID: <1706793792-20928-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500008.china.huawei.com (7.185.36.136)

This fixes the following code style problem:
- WARNING: please, no spaces at the start of a line
- CHECK: Please use a blank line after
         function/struct/union/enum declarations

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 include/linux/if_tun.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 2a7660843444..043d442994b0 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -27,44 +27,54 @@ struct tun_xdp_hdr {
 #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
 struct socket *tun_get_socket(struct file *);
 struct ptr_ring *tun_get_tx_ring(struct file *file);
+
 static inline bool tun_is_xdp_frame(void *ptr)
 {
-       return (unsigned long)ptr & TUN_XDP_FLAG;
+	return (unsigned long)ptr & TUN_XDP_FLAG;
 }
+
 static inline void *tun_xdp_to_ptr(struct xdp_frame *xdp)
 {
-       return (void *)((unsigned long)xdp | TUN_XDP_FLAG);
+	return (void *)((unsigned long)xdp | TUN_XDP_FLAG);
 }
+
 static inline struct xdp_frame *tun_ptr_to_xdp(void *ptr)
 {
-       return (void *)((unsigned long)ptr & ~TUN_XDP_FLAG);
+	return (void *)((unsigned long)ptr & ~TUN_XDP_FLAG);
 }
+
 void tun_ptr_free(void *ptr);
 #else
 #include <linux/err.h>
 #include <linux/errno.h>
 struct file;
 struct socket;
+
 static inline struct socket *tun_get_socket(struct file *f)
 {
 	return ERR_PTR(-EINVAL);
 }
+
 static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
 {
 	return ERR_PTR(-EINVAL);
 }
+
 static inline bool tun_is_xdp_frame(void *ptr)
 {
 	return false;
 }
+
 static inline void *tun_xdp_to_ptr(struct xdp_frame *xdp)
 {
 	return NULL;
 }
+
 static inline struct xdp_frame *tun_ptr_to_xdp(void *ptr)
 {
 	return NULL;
 }
+
 static inline void tun_ptr_free(void *ptr)
 {
 }
-- 
2.33.0


