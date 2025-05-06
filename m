Return-Path: <netdev+bounces-188409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B117AACBBE
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4613A1892E3A
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AA4286D68;
	Tue,  6 May 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIwUl4sz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF592857FA
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550626; cv=none; b=L13tDyIaBRMPuKd4nGnUPgq8Q8uiQvgRk4nWg7tRKmjvgRNVttA4JPPMZIsXuF0/NtLsYTeYlyJh7RR+TxbVy6tRV2n7LKgX7ltd8+qqZtvw0xGIPFdI+1C0DiFzUvHqzm8H3BoKZJqkzPlcyGBC+FP7TfMhzK4VqKH/pM/Ra14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550626; c=relaxed/simple;
	bh=ABOzDivVUxun6WUKZw1BVS9aK7ElmNBbTSdCr3O5K3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O8nBfyWue2hwRXmi6ttTa9AQdhgXMBtsazNCmloBosi2Ng7I+QkaWMB3iW1Uh6IeqOvVUTb151mP3R5EgWTIPZ1wt8p056/h6kTXolis1XFwVKlmvxbLzQ7in9+wys3cGe8VALD68FJVo2M5PzcsG+urlrBJAQRwgW2Q2lvghqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIwUl4sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC8FC4CEE4;
	Tue,  6 May 2025 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746550625;
	bh=ABOzDivVUxun6WUKZw1BVS9aK7ElmNBbTSdCr3O5K3k=;
	h=From:Date:Subject:To:Cc:From;
	b=vIwUl4szxr3mn6Ht3u4ZVPXR/v6wJMjbKlWscQEC/YHKl8rrGfxvpRBLGmzQU+mpS
	 b+VeyEgmauFg4x3+41BUuqEY/Y22IlvN4CO7gj9MPt3hovP6Gxs/8cQIxbRqsrPtdn
	 ziGBkUELy5D5jCyYlKizfzQL8Kd9fv9j204USMYHri5VsnfROEJZxb0PQNSEoSiz6U
	 T4nBK7LaVnDyC82SxksY38gcPYZuhZTzzXQSQfKtqSzm17+25UvkTHOLSZu8h2KfLi
	 0je2lxzb/80PrOiTVkb+gP8BdU+5lnCz4PBzxurBPdXePxJf604iDwjaH78B9PMGAh
	 p1uRSGsPvwugg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 06 May 2025 18:56:47 +0200
Subject: [PATCH net v5] net: airoha: Add missing field to ppe_mbox_data
 struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-airoha-en7581-fix-ppe_mbox_data-v5-1-29cabed6864d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE4/GmgC/43NTQ7CIBCG4as0rMUAhf648h7GNNSZtkSFBhpS0
 /Tu0q50pct3Mnm+hQT0BgM5ZQvxGE0wzqZQh4zcBm17pAZSE8GEYlIIqo13g6ZoS1Vx2pmZjiM
 2z9bNDehJU1VAxwVI6EpBkjJ6TE/7wuWaejBhcv61D8Z8u/5vx5xyWpUAioGoVYHnO3qLj6PzP
 dnwKD/B+jcoEwhCV23NOGhgX+C6rm/E/BQbIAEAAA==
X-Change-ID: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The official Airoha EN7581 firmware requires adding max_packet field in
ppe_mbox_data struct while the unofficial one used to develop the Airoha
EN7581 flowtable support does not require this field.
This patch does not introduce any real backwards compatible issue since
EN7581 fw is not publicly available in linux-firmware or other
repositories (e.g. OpenWrt) yet and the official fw version will use this
new layout. For this reason this change needs to be backported.
Moreover, make explicit the padding added by the compiler introducing
the rsv array in init_info struct.
At the same time use u32 instead of int for init_info and set_info
struct definitions in ppe_mbox_data struct.

Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v5:
- get rid of __packed attribute
- fix typo in the commit subject
- Link to v4: https://lore.kernel.org/r/20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org

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
 drivers/net/ethernet/airoha/airoha_npu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..ead0625e781f57cd7c5883b6dd3d441db62292d3 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -104,12 +104,14 @@ struct ppe_mbox_data {
 			u8 xpon_hal_api;
 			u8 wan_xsi;
 			u8 ct_joyme4;
-			int ppe_type;
-			int wan_mode;
-			int wan_sel;
+			u8 max_packet;
+			u8 rsv[3];
+			u32 ppe_type;
+			u32 wan_mode;
+			u32 wan_sel;
 		} init_info;
 		struct {
-			int func_id;
+			u32 func_id;
 			u32 size;
 			u32 data;
 		} set_info;

---
base-commit: e8716b5b0dff1b3d523b4a83fd5e94d57b887c5c
change-id: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


