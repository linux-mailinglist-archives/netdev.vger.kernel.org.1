Return-Path: <netdev+bounces-183671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A600A917E1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B768B1907851
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5821ADD6;
	Thu, 17 Apr 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVycZnPz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AF1898FB
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882270; cv=none; b=uFoHstaHxKekXB3sdeYEGyV654+83Jg/mOnmP2xUaWdJPZxzystaSfqN5PiCo55msBPlXFCWU8B5A9acy9rUyYMCZJRsl5mtvpPeXjAd8dwoEnm9eoNLl8nq+g/RTMRdWawoSjQ2dCiWV5vGr6BRF773sFc8GoJrxwNMKyccrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882270; c=relaxed/simple;
	bh=F9Y0DmU3wEHCJH5F3T95MiuKcenBBiSBi8gA0omO2Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ErtorcZShkpwbEpkagH9WrSd195HrjLt1Gv2ysj0z6CSMbbpiGxByvsLoYkv2mk95/bljvO5UWa/Gj2mNynH3yR4uqhBiHwXas+sGjBAG95OhaGU/VYQtVmIN1ZtX1q8sIh+7C+FI8FPL1CSZ4mDhBhCDieAWoEb3/Z5wstbNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVycZnPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFEBC4CEE4;
	Thu, 17 Apr 2025 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744882269;
	bh=F9Y0DmU3wEHCJH5F3T95MiuKcenBBiSBi8gA0omO2Jw=;
	h=From:Date:Subject:To:Cc:From;
	b=hVycZnPzum4yr9YF4zE6ZoE1n4jiB7kwZGrvFjJoajF1H/89TXibD7P5tQp7F692c
	 kmYIs1RFigJ3uAxAtUeaEEjSrwdWb8f00j6CdH17Kq/zBQzrkxRYw8K7SLd+rPtLa4
	 VeVWaugCImE+1VDru/5y1tFAsTIGnQ1XoaGDhhVHQzF7drAEeq4K7sNxGCEZmt2yj0
	 d6X4Mz2jfteqN5esQoC9TrE9IPoZEmphntToDgnM3XNd0IkHswztc2W2bRi9oXoxDu
	 KIIEPuqEg25QybHDIoIH7vhNpbmUzhDthXgVups+MCSxb6Z1uCtzwipUElMg0OWfvi
	 YNgabBdnzSMRA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 17 Apr 2025 11:30:47 +0200
Subject: [PATCH net-next v2] net: airoha: Add missing filed to
 ppe_mbox_data struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-airoha-en7581-fix-ppe_mbox_data-v2-1-43433cfbe874@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEbKAGgC/4WNQQqDMBBFryKz7pQkRE276j2KSNRRh7aJJCIW8
 e5Nha67fJ/PextECkwRrtkGgRaO7F0CdcqgHa0bCLlLDEqoXGip0XLwo0VyZW4k9rziNFH9avx
 ad3a2qHppjOhLbYoWkmUKlE5H4V4lHjnOPryP4CK/68+d/3UvEiVqLUxbiMZeCn17UHD0PPswQ
 LXv+wcWwJXizwAAAA==
X-Change-ID: 20250414-airoha-en7581-fix-ppe_mbox_data-2f1880f7486c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>
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
base-commit: df8398fb7bb7a0e509200af56b79343aa133b7d6
change-id: 20250414-airoha-en7581-fix-ppe_mbox_data-2f1880f7486c

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


