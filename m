Return-Path: <netdev+bounces-211308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC79B17D55
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1933B1C810DC
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6BA1FCFEF;
	Fri,  1 Aug 2025 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZLqfKfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBC2E3709
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032364; cv=none; b=RXtktYmeb05NrYC1e5iCaayetgwvjDPkQrni0hz6dVdGYB4cjggTaxwq9B4i0FHJflOesE49JE+sSGDf5meDMh3MlAI/ar3MnXIR0xqymh7mHNusf10Sn50SRUqJoLtkn6C5jC+gElQypqG27Iycim6OTr9ON7yHPyxwPoozsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032364; c=relaxed/simple;
	bh=kZ2ssGifWusx+VAn097N3kTz4drLvew5uJnr57tCeTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jdxeXVQ/2VzzzJWiisaxeKvDV/AbOBwmhb7Vy8AWXw9R1LZ7vUIr08GBbztcda3Xg7iiB2gHi36HYthc9wA9qsSsHVCS8UoAkgULL+9Ow0X0OKkZaA250WjV3oUQTgKIrKGBoq5dIL4ahDZ0Cas1Wyh66ecDOC11UbKEJTM7OJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZLqfKfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9F1C4CEE7;
	Fri,  1 Aug 2025 07:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754032362;
	bh=kZ2ssGifWusx+VAn097N3kTz4drLvew5uJnr57tCeTk=;
	h=From:Date:Subject:To:Cc:From;
	b=VZLqfKfiKRLlgY1GsmMNqmcAw+Ljlp+kTbga2cVoFEGFqoZLcyLQLg1lTEBuniLPG
	 U37aCWmUSTcCCaxJ8fnsdKhBs2jvv0TuUhpX4k0sRbiQU5rmCiha8wMgqYgiuCaiEQ
	 x9yUzwpZs8nqy0/CjEF48+b/pq0CqtesNohPItUGXL2iyPL+zG0/jlB867lu+18K7z
	 JZmkXC1n8GFoxta3Zsgc03uRqRKK2Ahrgs9bmnibBwB8ZD6aHGps4sb7hbnc4+zhTB
	 XAX2irL2hZdpj7WP2LAJxgdmC3hypmnrK6/Axej8UXQuqeoc+rDknJf0n2l96PJcGD
	 N3QT6otILCZHw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 01 Aug 2025 09:12:25 +0200
Subject: [PATCH net v2] net: airoha: npu: Add missing MODULE_FIRMWARE
 macros
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-airoha-npu-missing-module-firmware-v2-1-e860c824d515@kernel.org>
X-B4-Tracking: v=1; b=H4sIANhojGgC/5WNQQ6CMBBFr0Jm7ZgWLCSuvAdhUcsAE6ElU0EN4
 e5WbuDmJ+8v3tsgkjBFuGYbCK0cOfgE+SkDN1jfE3KbGHKVG1UVGi1LGCz6ecGJY2Tf4xTaZST
 sWKaXFcKq0ureKmNsYSCJZqGO30ekbhIPHJ9BPkdz1b/3L/2qUePFKFc6l5bK24PE03gO0kOz7
 /sXfRMOItUAAAA=
X-Change-ID: 20250731-airoha-npu-missing-module-firmware-7710bd055a35
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce missing MODULE_FIRMWARE definitions for firmware autoload.

Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Add missing Fixes tag
- Link to v1: https://lore.kernel.org/r/20250731-airoha-npu-missing-module-firmware-v1-1-450c6cc50ce6@kernel.org
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
base-commit: 01051012887329ea78eaca19b1d2eac4c9f601b5
change-id: 20250731-airoha-npu-missing-module-firmware-7710bd055a35

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


