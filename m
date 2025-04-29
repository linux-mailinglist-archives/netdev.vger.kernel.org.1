Return-Path: <netdev+bounces-186749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B9AA0E90
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BA17B306A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652B2D29CC;
	Tue, 29 Apr 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMoRaJlL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8F2C257C
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936268; cv=none; b=ry9jRc8RGyRsGJHypkxPAaxtOa8xycXWgp6Vx9tucGS9JMNJdXPSWv9DEryqOt/DqVJX/zuy51YaV4OY25fLseDuB5dzL6aK8WXkEUTRnvUyuSuDmtGtHYKmKxBMnFyUnqT/azVnSD1L3bl+W6m5qHU4RGiQHurRnQ4AT+i8jdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936268; c=relaxed/simple;
	bh=/BXoGZJ5icxIf4fvbX8yXHFsbB3xN9Dr6k/WLaLOqkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i3WLwu5hqVzxAjqtndaFVSiwbMRM1PmfCA2nEQjw4FLFOoOHxiEegB7Za4tMMEVhfHHTLDYkXDWYdq8meUr/J2158hLoErzSXFjWOio0rM0sLgePBK3IwZzHrGJCIb16+DLETIqSWV7O9JBRq/Av7EjMTGCyi4krL3akoLuFSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMoRaJlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB69C4AF0D;
	Tue, 29 Apr 2025 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745936267;
	bh=/BXoGZJ5icxIf4fvbX8yXHFsbB3xN9Dr6k/WLaLOqkc=;
	h=From:Date:Subject:To:Cc:From;
	b=dMoRaJlLwsODhJQEKwlHMT8OZ1/x0gOgHYC5rEa6dDmD6aKhf4i0YZEe+fQ54jjsW
	 6u+b8ObfzBHoBoAirSi5BBYdsJ+4HKe9vHxfi0SzblihaL9BeGu1zuxAZJ4TVwyB6x
	 K3KGD5yNXV6myj3tPkfG1BsBujzSGnFi+MJQdb2jCjECS+pJ3FUiMKU1dLRQtjnuwq
	 4dyMXl54Ck/GO7tFAzHJquO6QQ28cXOP1km6NBq9DtDaQtfNDsnkzyi5+23PXG9sVc
	 iyUcEbOpGQyi65N0vFk0LZfkOX6RD7NLnXMC9lySFe4LQYZM5IzcJ5YJyja7ZSUmZa
	 QPzs0mIXk4/0A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 29 Apr 2025 16:17:41 +0200
Subject: [PATCH net v4] net: airoha: Add missing filed to ppe_mbox_data
 struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAITfEGgC/42NQQ6CMBBFr0Jm7RgoFNCV9zCEVGeAidKSlhAM4
 e5WTuDy/fy8t0FgLxzgmmzgeZEgzkYoTgk8B2N7RqHIoFKl00IpNOLdYJBtpesMO1lxmrgdH25
 tycwGdUldpqigrlIQLZPneDoK9ybyIGF2/nMEl/y3/u9ecsywroh0SuqiS7692Ft+n53vodn3/
 QtYKHlszwAAAA==
X-Change-ID: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The official Airoha EN7581 firmware requires adding max_packet filed in
ppe_mbox_data struct while the unofficial one used to develop the Airoha
EN7581 flowtable support does not require this field.
This patch does not introduce any real backwards compatible issue since
EN7581 fw is not publicly available in linux-firmware or other
repositories (e.g. OpenWrt) yet and the official fw version will use this
new layout. For this reason this change needs to be backported.
Moreover, add __packed attribute to ppe_mbox_data struct definition and
make the fw layout padding explicit in init_info struct.
At the same time use u32 instead of int for init_info and set_info
struct definitions in ppe_mbox_data struct.

Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v4:
- use u32 instead of int in ppe_mbox_data struct
- add __packed attribute to struct definitions and make the fw layout
  padding explicit in init_info struct
- Link to v3: https://lore.kernel.org/r/20250422-airoha-en7581-fix-ppe_mbox_data-v3-1-87dd50d2956e@kernel.org

Changes in v3:
- resend targeting net tree
- Link to v2: https://lore.kernel.org/r/20250417-airoha-en7581-fix-ppe_mbox_data-v2-1-43433cfbe874@kernel.org

Changes in v2:
- Add more details to commit log
- Link to v1: https://lore.kernel.org/r/20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org
---
 drivers/net/ethernet/airoha/airoha_npu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..c81e25139d5ff4b6c52ce8802dd9c9b9b6c8c721 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -104,17 +104,19 @@ struct ppe_mbox_data {
 			u8 xpon_hal_api;
 			u8 wan_xsi;
 			u8 ct_joyme4;
-			int ppe_type;
-			int wan_mode;
-			int wan_sel;
-		} init_info;
+			u8 max_packet;
+			u8 rsv[3]; /* align to fw layout */
+			u32 ppe_type;
+			u32 wan_mode;
+			u32 wan_sel;
+		} __packed init_info;
 		struct {
-			int func_id;
+			u32 func_id;
 			u32 size;
 			u32 data;
-		} set_info;
+		} __packed set_info;
 	};
-};
+} __packed;
 
 static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 			       void *p, int size)

---
base-commit: d4cb1ecc22908ef46f2885ee2978a4f22e90f365
change-id: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


