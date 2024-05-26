Return-Path: <netdev+bounces-98096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E18CF508
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6B91F211CF
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B354906;
	Sun, 26 May 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qK0lVCNW"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AB53E16;
	Sun, 26 May 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716744343; cv=none; b=AHsnkFktQKFoc3al/lDxypeBBzdD244HnxLdAGqNkRZEVJzfdqSowDz5ILrpl5Irs1BmOYjDkoWzNn9xkMfG94TRtak7iXo/t93jBN2eNg7qlf/3alLDlhWTUANtuimPCbp8SWtwHSutSTpy0IoqQF9EnXd82uBMyjo1SlgHkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716744343; c=relaxed/simple;
	bh=pBPCZ6EsFhm3TSWJxG2KKXUgP+h+hHYq1uqn+cEpGUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqU2O84B/k4CgTpOu/+OAdFyLC5cZfroY5MNzYUfqKp3ZY8BnKtfY8Ifes1OI9YhMErG6QCX+5LJrtH5V6c5iSck/VWa7qxW7GPdlsO1UK48+y1JKMiU0o634agtUp3XAINmT8SLhV9zVrjAGdbkxZgHp6+gGxByB02KLSwPVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qK0lVCNW; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=OzL+FqR94BdzBBlPMqzxqdPf2qKaPSodPf5IIdV4i5c=; b=qK0lVCNW8FCkSYvJ
	leSBvW13jeiyOLS2Ukp7m3jI1B//GC6QNca+9C+mkbj6k/fkYuenmdnzA/TaB5X5erVjlMGOkmTxO
	kwHdjJmNHLxwBawWbh0CEQPnWzBTHWIXB8SgODB1yHKBBNIwpuNTTcrbVmc0Bk690Da52AKrZFzRt
	6yUfzI9JumIxzghp2UqXCTTcWFKcfdo5RfaStiR2Cb/s9hNd+ZjJZXYgcpsgWeLD9MYj9CbtjzGSv
	YfIdN4Qzm0GJtUHDlXBoYWvnxSwZMwwmhcRrK2PkzBmmRMYvpG37h27H1vPEldXSo/yOS0h0bZd/6
	Z4h8cCxspXXLW4JPCw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBHcc-002aYf-27;
	Sun, 26 May 2024 17:25:27 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ionut@badula.org,
	tariqt@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/4] net: ethernet: liquidio: remove unused structs
Date: Sun, 26 May 2024 18:24:26 +0100
Message-ID: <20240526172428.134726-3-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240526172428.134726-1-linux@treblig.org>
References: <20240526172428.134726-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'niclist' and 'oct_link_status_resp' are unused since the original
commit f21fb3ed364b ("Add support of Cavium Liquidio ethernet
adapters").

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c    | 6 ------
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 34f02a8ec2ca..1d79f6eaa41f 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -92,12 +92,6 @@ static int octeon_console_debug_enabled(u32 console)
 /* time to wait for possible in-flight requests in milliseconds */
 #define WAIT_INFLIGHT_REQUEST	msecs_to_jiffies(1000)
 
-struct oct_link_status_resp {
-	u64 rh;
-	struct oct_link_info link_info;
-	u64 status;
-};
-
 struct oct_timestamp_resp {
 	u64 rh;
 	u64 timestamp;
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
index 0d6ee30affb9..eef12fdd246d 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
@@ -30,11 +30,6 @@
 #include "cn23xx_pf_device.h"
 #include "cn23xx_vf_device.h"
 
-struct niclist {
-	struct list_head list;
-	void *ptr;
-};
-
 struct __dispatch {
 	struct list_head list;
 	struct octeon_recv_info *rinfo;
-- 
2.45.1


