Return-Path: <netdev+bounces-153065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E49F6B3C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BFF188B8D7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F9B1F868D;
	Wed, 18 Dec 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sy0FtCmG"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1801F37C7;
	Wed, 18 Dec 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539639; cv=none; b=AFJOSeRh5bkB1LPRGONxM9ucuPdtbCj2/TzhA8V+tt3mxKmaAWhKrK8goMD/I+jxB3NopSsoNMFgFhlZ+k8CqKtIzLqDxHrTPZ9lhpfR7NvZWfRlEewuP6OoOvHfEIGotzt/0kY3A5rIIXMJX1LWmEOaR/ekNE16ZE5deHsVxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539639; c=relaxed/simple;
	bh=vqXS2D6cR3bjZvdBuUU1/CYUS8GCL340U5wEYJhFz5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi4e5H3OGTH9Ggm1n2pUh0SP3gk9HKxsobm+c7CxWUrR3zOOWMcPKJfQzId7lphKYyhUiFgPP++2bwieS+IfQzP9RnSbliCo4FFgpq+I4BcrAq28j7WVj/tJE2im2D+pnBm7XWTPMfSROoGga//qJt4gI+HbTm+x40Tnonfd0JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sy0FtCmG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=AM+1w7yefU5B4WBk2Bz/qL6bi+nDgXxrhDqORA3Fqls=; b=sy0FtCmGWgfE1h3V
	qw9ocT24l1g9nNRZ+GuIXp+6CQwMyauqmCSr96UZFLo/YU0ctJ23PyYI1hcYAYrfUMh7gftJqgWGK
	+yTAkKhNlYpl4WJ3i7gXyFp7cu3hsy8bp094TbxSM80rlwrSprPFzco2r7DZQEY7mbYwea3/ct8gu
	vSZPC9M20QThweNOwc0cYskzmHvtcQl8ALZqmPSoTmQ6X1Ngrc/ExPzqAEkPt5OmNkrzX6gGCnzNB
	naIRoAMhu/YOFCyr34/ayT4Ch2I5pXAqultnUW3dN57GPF+U2d08K6NHJ8HuYL1tOrNmOKW4BqZNm
	mx2lqUXAJAGeqhQaPA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNwzc-0068f8-0T;
	Wed, 18 Dec 2024 16:33:48 +0000
From: linux@treblig.org
To: salil.mehta@huawei.com,
	shenjian15@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next v2 4/4] net: hisilicon: hns: Remove unused enums
Date: Wed, 18 Dec 2024 16:33:41 +0000
Message-ID: <20241218163341.40297-5-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218163341.40297-1-linux@treblig.org>
References: <20241218163341.40297-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The enums dsaf_roce_port_mode, dsaf_roce_port_num and dsaf_roce_qos_sl
are unused after the removal of the reset code.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../ethernet/hisilicon/hns/hns_dsaf_main.h    | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
index bb8267aafc43..653dfbb25d1b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
@@ -42,29 +42,6 @@ struct hns_mac_cb;
 
 #define HNS_MAX_WAIT_CNT 10000
 
-enum dsaf_roce_port_mode {
-	DSAF_ROCE_6PORT_MODE,
-	DSAF_ROCE_4PORT_MODE,
-	DSAF_ROCE_2PORT_MODE,
-	DSAF_ROCE_CHAN_MODE_NUM,
-};
-
-enum dsaf_roce_port_num {
-	DSAF_ROCE_PORT_0,
-	DSAF_ROCE_PORT_1,
-	DSAF_ROCE_PORT_2,
-	DSAF_ROCE_PORT_3,
-	DSAF_ROCE_PORT_4,
-	DSAF_ROCE_PORT_5,
-};
-
-enum dsaf_roce_qos_sl {
-	DSAF_ROCE_SL_0,
-	DSAF_ROCE_SL_1,
-	DSAF_ROCE_SL_2,
-	DSAF_ROCE_SL_3,
-};
-
 #define DSAF_STATS_READ(p, offset) (*((u64 *)((u8 *)(p) + (offset))))
 #define HNS_DSAF_IS_DEBUG(dev) ((dev)->dsaf_mode == DSAF_MODE_DISABLE_SP)
 
-- 
2.47.1


