Return-Path: <netdev+bounces-211156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C68B16F6F
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9397B1AA38E8
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7562BD5B3;
	Thu, 31 Jul 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNacCbqz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637320C461
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957549; cv=none; b=lJDf+aEeVYrcKdxh5ERh4l1abeL+2lL8QfWUycg/+tR+d92/oqAdDVcO+CKRtv7WqhRcCeoBuLSY7ZFVr81lNxsEsx3G1ShiCFsyVtDX4NwT0jg8MHRjAmX9oQEUBOem8/MvJiKwbsTvB1BsqeMAWuVejs2/JT2WovouDAf78io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957549; c=relaxed/simple;
	bh=7Fd9WJGGEH/ptepLhWaVJOgjnuQ/nuG0jrZ0GePe7JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YhJ/ZsYdhseJqjuM3c3M1MykFXCRoPFlVC5He2Pp22xI/IyPQ9LvKcpCLGX+kLQAXtMYNof43Hbe/r9uUACB/2kem2J5FjaEiioTy7qkx50wbLpGAlriThqsYXWeCE144qYO/fW1y5FHksy/3I8K6V+q1Xp8hRMG3u7gRGyQ0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNacCbqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA37C4CEF5;
	Thu, 31 Jul 2025 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753957548;
	bh=7Fd9WJGGEH/ptepLhWaVJOgjnuQ/nuG0jrZ0GePe7JY=;
	h=From:Date:Subject:To:Cc:From;
	b=YNacCbqze0RsKwE7YCQEKcwKKwGPXhylIhwMfrKkTxSbtoubtMahb/DAqCA6jmGge
	 ztQyR3nWPSlsdbftw6/HdPu3S9NCLbLMHnKYdjxPa0zmtealEEwjUnmZiLF/FN1Ayn
	 +GMM39kxKxmCKHp5sUtY+10IE5glcCRLfvybGNFIhyTCds1NYvU/fXevEp/mKi76yT
	 3a2DoD3IUxMXK6exw2bBhUPpMhh1onEewA9xJ1aQfcrZ90+R/W6Wo+7GY348k/vxCI
	 v+7USAytiwXMc8V9h4mUBOk5cy2Mu+kWgpU0WmTSdcBvqUUrnUbyNrM3bl2metrBZl
	 1Swi1/xlImuDA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 31 Jul 2025 12:25:21 +0200
Subject: [PATCH net] net: airoha: npu: Add missing MODULE_FIRMWARE macros
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-airoha-npu-missing-module-firmware-v1-1-450c6cc50ce6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJBEi2gC/x3NwQqDMAyA4VeRnA20SinsVcYOcY0asK0kuA3Ed
 1/x+F3+/wRjFTZ4dCcof8Sklgbfd/BeqSyMkpphcENwcfRIonUlLPuBWcykLJhrOjbGWTR/SRl
 j9G5KLgQaA7TQrjzL7548X9f1B9NBQAt0AAAA
X-Change-ID: 20250731-airoha-npu-missing-module-firmware-7710bd055a35
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce missing MODULE_FIRMWARE definitions for firmware autoload.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 9ab964c536e11173e3e3bb4854b4f886c75a0051..a802f95df99dd693293b1c0cc0fbf09afab2c835 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -579,6 +579,8 @@ static struct platform_driver airoha_npu_driver = {
 };
 module_platform_driver(airoha_npu_driver);
 
+MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_DATA);
+MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_RV32);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_DESCRIPTION("Airoha Network Processor Unit driver");

---
base-commit: 759dfc7d04bab1b0b86113f1164dc1fec192b859
change-id: 20250731-airoha-npu-missing-module-firmware-7710bd055a35

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


