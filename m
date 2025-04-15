Return-Path: <netdev+bounces-182612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA70A89500
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD6A3B8D7E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55AA27FD6D;
	Tue, 15 Apr 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIHV8i1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B927FD5E
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702057; cv=none; b=u2AiQfD1bTno7LGbg01gmJEifmxN5NztqurXh0DZ6iTzymBht1bThnnDGS5SbQytMVqh++ShO9MZ25luwR9WpsXRDVNDAOY8tyldhFtgn01JkBCJaDODztGMKqZVg74zXzNnPILlAp4d7GJe/iBZvPSfIcQtOXgcI5xVqHnDKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702057; c=relaxed/simple;
	bh=dZQ8SDSY3nzADxdIRyPbZ5ANl2eO50k1qUuqFn6sLA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hlbsgVQbh8LIcjyPdnEUfXeyIq2TNcVq9B/QR87OudRwuiqnzCjcTGIEtHxUkVkZigUYKYrA2mdT8AyClKMp8+YfBv7MHtqv/fcDyLApFVnQzGckY9j8Dz3RmfuThl3DWOvrgQ5wH5U204rGkU7cre5cPaR/dCWa/gRMgltEIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIHV8i1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAA4C4CEEB;
	Tue, 15 Apr 2025 07:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744702057;
	bh=dZQ8SDSY3nzADxdIRyPbZ5ANl2eO50k1qUuqFn6sLA0=;
	h=From:Date:Subject:To:Cc:From;
	b=ZIHV8i1W9FGUePD4u+PqfvHLcQbG9YgPnZjc6Z6evvRS4FDVZOJbbn6FxovjxNQmm
	 23Ms2LpW90vehb9IIMoeatWG6U7o4Q0iuP+9FOipsyO6hyABb4y8RoiR/xNdsVtYMt
	 mqltHezMSMb1A74MLAzRZdM0xfOC5ZBnpPqzrf/n3UvXZpMDWhCyrqclS0+Uga9N8+
	 7A0EuiDSqxYWu/vUqw1AssT16yt55qUOdJJvkt5XeWx6pXRzvViVpmP4rtWaA/6Db9
	 sMol9VqDP62m4LECbplj5zLtjQMpjpzxGDGlPEJNpJ5TjsXx7c3NlJtH5SNQUjT8SL
	 U+g9S4K9nqLpw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 15 Apr 2025 09:27:21 +0200
Subject: [PATCH net-next] net: airoha: Add missing filed to ppe_mbox_data
 struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFgK/mcC/x2N0QqEIBAAfyX2uQUVK+lXImKv1msfTkUjgujfT
 3ocGGZuKJyFC4zNDZlPKRJDBd02sO4UvoyyVQajTKestkiS407IYeicRi8XpsTL7xOvZaOD0Hj
 tnPKDdf0KtZIyV+k9TPPz/AFrMhxAcQAAAA==
X-Change-ID: 20250414-airoha-en7581-fix-ppe_mbox_data-2f1880f7486c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

The official Airoha EN7581 firmware requires adding max_packet filed in
ppe_mbox_data struct while the unofficial one used to develop the Airoha
EN7581 flowtable offload does not require this field. This patch fixes
just a theoretical bug since the Airoha EN7581 firmware is not posted to
linux-firware or other repositories (e.g. OpenWrt) yet.

Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
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
base-commit: 23f09f01b495cc510a19b30b6093fb4cb0284aaf
change-id: 20250414-airoha-en7581-fix-ppe_mbox_data-2f1880f7486c

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


