Return-Path: <netdev+bounces-224261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B4B833D0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79BC625DF3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859492DE6EE;
	Thu, 18 Sep 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8grMfXR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F7208A7
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178801; cv=none; b=THgj/i4E7jIf8FC2dbnSnfboIiWErK8/ozvlnEgF1e9xF3nlX/PX3ldRwI87kDJwcJiXP33T2z7wKBrGpJdXlWi880I3WwiRxp4KktDVmP3JTC/i45NVaOoD7aLgVdPSpkiP/cPFTOkRASHi7GuG/bf9TDTqHLffKxlTB2BVf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178801; c=relaxed/simple;
	bh=GYQQZBRFtvo1wyXj5F3TK1koEo9eY7xeSRvG8LEDgI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ri9eBHUlgm5zUyzNQxr91AUzjJS9KbboZOo5W6EiuTKjWVb+XMMSy8ykcsKU5TZvlzgO+6MAuoMbxTxSsJO4v4L4Dw3oTsTwWnX3E3oabWNe/ohbd8a4plmpIfaAeQ1aVINGmOzQczOA60jct9lZuiSuhdRozzQoKKuR/dcwM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8grMfXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1EDC4CEE7;
	Thu, 18 Sep 2025 07:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758178801;
	bh=GYQQZBRFtvo1wyXj5F3TK1koEo9eY7xeSRvG8LEDgI0=;
	h=From:Date:Subject:To:Cc:From;
	b=d8grMfXRdRd3M9C9BtlejCL9yVW52ikV/pMYn+LBjuSxIFfD2fzW2IwFp57BMXb6y
	 iCAGvdkM16oYI+dPYoIdEmUa6KBm3fNkvTrFQzrlteahCjfaWMXWKFonXhNfQuYFve
	 p1ExhG2VOMbGyzYQaf+ltk6DzUsfHsS/2WNSCKC/1YnFdhh6Ajc2ezlZYrWjdnh8yo
	 jrCzHi9wNGtcA/KHM+zk+GvbtuvSQBq+/9ZDS4LKKAJRCvHTim11/8arP4IEbd9GVi
	 4peqAa/yJQxK7XbxhUoQPayr9L9xG6b5QBgx4VC6FkSZ0gq3f0uubq2DKyuCF/v8Th
	 K3iNBia4v2Qwg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 18 Sep 2025 08:59:41 +0200
Subject: [PATCH net-next] net: airoha: Fix PPE_IP_PROTO_CHK register
 definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ppe_ip_proto_chk_ipv4_mask-fix-v1-1-df36da1b954c@kernel.org>
X-B4-Tracking: v=1; b=H4sIANyty2gC/x3N2wqDMBCE4VeRvTbgsU19FZEQ7bQuUrMkIoL47
 l28/P6LmZMSIiNRl50UsXPisCrKPKNp9usXht9qqoqqLV6lNSJwLE5i2IKb5kWxN+7n02I+fBg
 Az3pE6+3Dko5IhOb7oB+u6w9dDuLXcAAAAA==
X-Change-ID: 20250918-ppe_ip_proto_chk_ipv4_mask-fix-eee73be5a868
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix typo in PPE_IP_PROTO_CHK_IPV4_MASK and PPE_IP_PROTO_CHK_IPV6_MASK
register mask definitions. This is not a real problem since this
register is not actually used in the current codebase.

Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 150c85995cc1a71d2d7eac58b75f27c19d26e2b5..e1c15c20be8e13197de743d9b590dc80058560a5 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -237,8 +237,8 @@
 #define PPE_FLOW_CFG_IP4_TCP_FRAG_MASK		BIT(6)
 
 #define REG_PPE_IP_PROTO_CHK(_n)		(((_n) ? PPE2_BASE : PPE1_BASE) + 0x208)
-#define PPE_IP_PROTO_CHK_IPV4_MASK		GENMASK(15, 0)
-#define PPE_IP_PROTO_CHK_IPV6_MASK		GENMASK(31, 16)
+#define PPE_IP_PROTO_CHK_IPV4_MASK		GENMASK(31, 16)
+#define PPE_IP_PROTO_CHK_IPV6_MASK		GENMASK(15, 0)
 
 #define REG_PPE_TB_CFG(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x21c)
 #define PPE_SRAM_TB_NUM_ENTRY_MASK		GENMASK(26, 24)

---
base-commit: 11bbcfb7668c6f4d97260f7caaefea22678bc31e
change-id: 20250918-ppe_ip_proto_chk_ipv4_mask-fix-eee73be5a868

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


