Return-Path: <netdev+bounces-184765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E26A971D1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD225440BA4
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477E28FFF7;
	Tue, 22 Apr 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9OhbOCG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AC28FFE7
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337584; cv=none; b=JLNiCnasYQJ6/WceAotMzwjVJqVI1IY5zCnITWBDTDbunIh3aSO7R4jdF06lafkmzZZ9jt1D8dJfcB/1iD2akztJrSeEYypB4g2W5wWkE+YBElB0ZG/VTK/7VCQ1BRHAtWLSHwX9SN+0ey2nSTIyUlbTG9Qfaqp9dZzCq7+gXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337584; c=relaxed/simple;
	bh=qmjXZDeehc6+VqaGfMuHTX89SmLxYMBp7YUw/6wlzic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kkcxB0LwjRs/oyBfX96rwLOnooIqzu0pT+uKG/wUoeTs/W2zbBTjsNqucwqJBWRo0CD/cKGrH+N+U8sTc/WfKvIe2tPhvfywlol28fr0iichMmDwgktJo89I93r5diiQJ2S2dEtkq7fxDCh+6AdiGyuGHi/K+iCUHjzMUEewr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9OhbOCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A764CC4CEE9;
	Tue, 22 Apr 2025 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745337584;
	bh=qmjXZDeehc6+VqaGfMuHTX89SmLxYMBp7YUw/6wlzic=;
	h=From:Date:Subject:To:Cc:From;
	b=b9OhbOCG5ZmDmCO1zAPiAhwgT+WRh9dK7dfjUclNkMddBCThfZw1+B5pSzVjxi8s5
	 Jtq7VpINWOncN402VRE/azZWY9Sh1BrVKXVTa56jU/VBGDzbJhY7bCavIfIQZgh1tO
	 Ot7S7gbyt7GFFTaiJbxvbbnDV0BgI8sUvp7OMYSqIylYjw1SdDZMzKfa9vzn9RYGBr
	 ewo6Uy7D2aOnwTb6NoK4ITav2PIQ9BbAlEbti1mPQfnYeX1urMgLoQeM9UgV3HbzIK
	 8EvTXwEPrYimE3QjEdfWsNgxWjA0QwyWfGEhkY5ylt7d1WlB6t4hH1ZOI/IPlxjJLQ
	 jQ8fBQLTfwo6A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 22 Apr 2025 17:59:23 +0200
Subject: [PATCH net v3] net: airoha: Add missing filed to ppe_mbox_data
 struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-airoha-en7581-fix-ppe_mbox_data-v3-1-87dd50d2956e@kernel.org>
X-B4-Tracking: v=1; b=H4sIANq8B2gC/x2N0QqDMAwAf0XyvIBmdo79yhDJllTzYFtaEUH89
 5U9Hhx3JxTNpgVezQlZdysWQ4X7rYHvwmFWNKkM1JJreyJky3Fh1DC4Z4feDkxJp/UTj0l4Y3Q
 P8R1JL34gqJWUtUr/w3u8rh+h5HTucQAAAA==
X-Change-ID: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

The official Airoha EN7581 firmware requires adding max_packet filed in
ppe_mbox_data struct while the unofficial one used to develop the Airoha
EN7581 flowtable support does not require this field.
This patch does not introduce any real backwards compatible issue since
EN7581 fw is not publicly available in linux-firmware or other
repositories (e.g. OpenWrt) yet and the official fw version will use this
new layout. For this reason this change needs to be backported.

Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v3:
- resend targeting net tree
- Link to v2: https://lore.kernel.org/r/20250417-airoha-en7581-fix-ppe_mbox_data-v2-1-43433cfbe874@kernel.org

Changes in v2:
- Add more details to commit log
- Link to v1: https://lore.kernel.org/r/20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org
---
 drivers/net/ethernet/airoha/airoha_npu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..16201b5ce9f27866896226c3611b4a154d19bc2c 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -104,6 +104,7 @@ struct ppe_mbox_data {
 			u8 xpon_hal_api;
 			u8 wan_xsi;
 			u8 ct_joyme4;
+			u8 max_packet;
 			int ppe_type;
 			int wan_mode;
 			int wan_sel;

---
base-commit: c03a49f3093a4903c8a93c8b5c9a297b5343b169
change-id: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


