Return-Path: <netdev+bounces-144852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7879C88DF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25A2283E5E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBE81F8F15;
	Thu, 14 Nov 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qv9MWOgI"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F858192D9D;
	Thu, 14 Nov 2024 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583601; cv=none; b=mtl+2DypR66edtjVqhba0mbCHrqriiydPcQXOa8NWf1KtzpdZT2EevHuxfG5FFApef0yys8ZAt4xxQjuV38gYqb/ofW1brddqyf6R7ZkHKVMXCgB5Lh9GmF7o1Qn6+85ucBRM7gqg0zLHH5B/ISi2nLgrybTWev32BNtoQHZ/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583601; c=relaxed/simple;
	bh=kKjgiDjn34LW7LUqNfMkPGcZHB4LMhAYI0N5yrhZZEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGb+JrXuedcW8RcvEkahDkWxIT5ofas74qT+a/xOzI+B/ovSGKkW8lhSIo2KuYYAjfOCRAGl1rfCzqvf/bZspmNaOvr5D6Xww0/fmlGQbFvx/U5foMNlLo+IIsM8Tsz8dj6Z0AYrM47UhCJ9O3ub9UAe0KbznlQb5NFkXAErggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qv9MWOgI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AEBQPJf82914541, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731583585; bh=kKjgiDjn34LW7LUqNfMkPGcZHB4LMhAYI0N5yrhZZEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qv9MWOgItQOJTXeQNARreVCz6worTxDRNKpv5aHiD1Pd0D2ljgN+GPng/l8Y4ouxE
	 Do2ix7DKL7fCYmMuU5/qL3GKGyeUJM6xl6mz2Z87q4MX9Tlk4wz+TmS6189g812FE/
	 r4lAff4MzBCu74c9m3Q+eaC2vXTAUsVFa5L83sBN1n9g5e+/KA4NtjCPuNuRZYp9F+
	 o/KYumnpBEo2tZbNO7XdaGk0+1/CjkF+nddSH/6wBjxHnrG9gyVs1PgUF1iIucvq/W
	 IjAVdykv8lsOQxg8FuQ9idfXkuZ+NIIbG64DnEF6mtlIv1qDaIJRjaoyQwLjHRRoyn
	 Cjr+djWHLm2Yw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AEBQPJf82914541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:26:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 19:26:25 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Nov
 2024 19:26:25 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next 2/2] rtase: Modify the content format of the enum rtase_registers
Date: Thu, 14 Nov 2024 19:25:49 +0800
Message-ID: <20241114112549.376101-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114112549.376101-1-justinlai0215@realtek.com>
References: <20241114112549.376101-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Remove unnecessary spaces.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 583c33930f88..942f1e531a85 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -170,7 +170,7 @@ enum rtase_registers {
 	RTASE_INT_MITI_TX = 0x0A00,
 	RTASE_INT_MITI_RX = 0x0A80,
 
-	RTASE_VLAN_ENTRY_0     = 0xAC80,
+	RTASE_VLAN_ENTRY_0 = 0xAC80,
 };
 
 enum rtase_desc_status_bit {
-- 
2.34.1


