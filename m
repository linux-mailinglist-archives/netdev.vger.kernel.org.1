Return-Path: <netdev+bounces-124097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DFC968029
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671EC1C2129A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF917A5B4;
	Mon,  2 Sep 2024 07:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75916F851
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261031; cv=none; b=Of7MWDerRPKG55m306RXYLdy3rtXn0w97V3gzwanmNqxrhA2fUBKXKaH08JIQ23w3zTb2Cv25MPL36v9xkmzuGPc4Bi6e379cqJ47FPPNGHZJ4rSc5OHT/NPnVYLQdgx+uJ6ZlCjICp71J01NXoL49Oom+DXvwyL4Ra46T9TaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261031; c=relaxed/simple;
	bh=OVixF50jdUmVlgEfbTv4EORieiSh5n2s3kZuus77CWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uQmedINQsacO63glT/l0ABIbrkw3Kk8CcJHz8h6grwJqreZDCKQ08CpFKxoyLKHlfhAbs/p5BSpQCl8OVSXxLsEpuK4wFaX+gZCOStJta0xIwTr7G+03dFRuCe7OHLaaZ9VH7nzw3og/hTBi/uL2z+FtGTKqRx/Xjx72uAVkCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wy0HV3Y2jzyR1s;
	Mon,  2 Sep 2024 15:09:26 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F6DC180AE7;
	Mon,  2 Sep 2024 15:10:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 15:10:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] net: lan743x: Use NSEC_PER_SEC macro
Date: Mon, 2 Sep 2024 15:18:41 +0800
Message-ID: <20240902071841.3519866-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

1000000000L is number of ns per second, use NSEC_PER_SEC macro to replace
it to make it more readable.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/microchip/lan743x_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index dcea6652d56d..9c2ec293c163 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -409,7 +409,7 @@ static int lan743x_ptpci_settime64(struct ptp_clock_info *ptpci,
 				   ts->tv_sec);
 			return -ERANGE;
 		}
-		if (ts->tv_nsec >= 1000000000L ||
+		if (ts->tv_nsec >= NSEC_PER_SEC ||
 		    ts->tv_nsec < 0) {
 			netif_warn(adapter, drv, adapter->netdev,
 				   "ts->tv_nsec out of range, %ld\n",
-- 
2.34.1


