Return-Path: <netdev+bounces-98097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910558CF50A
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A2D1F21209
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7BD56768;
	Sun, 26 May 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RtYdLwtt"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFE54F96;
	Sun, 26 May 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716744346; cv=none; b=jv1QpxhBECJfDHela1GGkkqhRTRqeq/YTczt2plr77gAlHhk6rT8wa8wJSlYy4YtE9GGxwqIa32SdkTdX2rqMsNhWvjmIfG5BcV8veNkI43un6tz+FEtlGBTcpVi2Siikyc7Pba3V58n1mEoePLIql94KQpSzuAwrkuxsK6UdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716744346; c=relaxed/simple;
	bh=eWzHuG7A2dtXBOBODhzxQoEnvU87Oz4nAD+ahmMXaaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7NYrThse4jBu5cJIn+IMA6o5XmRtJIoi6audZbSDZL/plWMtcXtV/FuTZjnLUM4tJTn5A4L0nxOkG3w1/anqOiOXSw14GzKKIGiUX2SNXKZFCsvVpu5KNBQOqhc9srnUDqqcnjYyqgZeFc2sZnD/Fgiy3WDK5kWAWC4hXQmYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RtYdLwtt; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=MQ0kr12Y+48Q4e9VAShbfG29E9NVQKb0iwHkSFlfbVM=; b=RtYdLwttkNDpFq0U
	aEgK2zSQTaOmDTx82w9+y0t9nsKWRjdBwVfxLMChtQ1iv/a/gxWdZdxlZOPQyLAwAw5cfNjp+YRIb
	CvgbAzxRiUkyoJlxF3RIpl528BAv2BLhygXwYUl1F6g64EiHH3urzhBf113wmpfh6F+t4jZzcsg62
	kmS45m7NMMDe4SaBNDdJZlb4wJXRUrqLJMKymhEQymWZHbL3IbJ4moCt1Sl3Xuj8NrbMv1Xb0wzz2
	tOPxU8l+dIeqxm9yIUlM/xj31YtIjc2u8CkSrlOcCVl53f5/6WH4ASuq+QyW5/+WsXULS0NFLwS6J
	ypERJkTGwoQZ+PDEFA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBHcl-002aYf-10;
	Sun, 26 May 2024 17:25:35 +0000
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
Subject: [PATCH 3/4] net: ethernet: mlx4: remove unused struct 'mlx4_port_config'
Date: Sun, 26 May 2024 18:24:27 +0100
Message-ID: <20240526172428.134726-4-linux@treblig.org>
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

'mlx4_port_config was added by
commit ab9c17a009ee ("mlx4_core: Modify driver initialization flow to
accommodate SRIOV for Ethernet")
but remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 98688e4dbec5..febeadfdd5a5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -169,12 +169,6 @@ module_param_array(port_type_array, int, &arr_argc, 0444);
 MODULE_PARM_DESC(port_type_array, "Array of port types: HW_DEFAULT (0) is default "
 				"1 for IB, 2 for Ethernet");
 
-struct mlx4_port_config {
-	struct list_head list;
-	enum mlx4_port_type port_type[MLX4_MAX_PORTS + 1];
-	struct pci_dev *pdev;
-};
-
 static atomic_t pf_loading = ATOMIC_INIT(0);
 
 static int mlx4_devlink_ierr_reset_get(struct devlink *devlink, u32 id,
-- 
2.45.1


