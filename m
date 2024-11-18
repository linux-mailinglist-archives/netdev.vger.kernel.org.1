Return-Path: <netdev+bounces-145831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7949D1177
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE15B21B65
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C025195FD1;
	Mon, 18 Nov 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOCS299h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD71E49B;
	Mon, 18 Nov 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935383; cv=none; b=Xyrm15qg1GRYWDxFrxD/u1qY6eXv6/unul9OxYZ6noP7AV/pB2MQNKsXg3Yzsfu8WtsVW7m7kK2DNzHE5JeGRlNZKPBo7Wl4VVZHsaqP5ntLUa/U5nAlIvnac2enUllKErUuHfBLAE0IRv89uN67m4kT9Imi8k1XTaBHp/sbV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935383; c=relaxed/simple;
	bh=cQo4iAMdE75Iju1hmRvTp8v+SSIrunOvBCkb1Gi4F2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ULOrakvaSX5HZN20FCEln7b/Ba45ENh8AyaEdhe5HmiZdaYadkNNdd1JU8XpPd4j7OtNwRptq4Te9wF7DfaE8N2TvG2R2fcBPyPGyfYqt8mKFWb6enbgtDW3fSfZweNOD5Ptg44KJkGBiq9QqXJjbqjvPGUMLWhyaJP+okezZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOCS299h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8AA0C4CECC;
	Mon, 18 Nov 2024 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731935381;
	bh=cQo4iAMdE75Iju1hmRvTp8v+SSIrunOvBCkb1Gi4F2E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hOCS299hs+zrZICivNdsbZn90+4ryiqcy4A6IfFKQqJdNjPqtuc0b6nXQIyZ+QTtD
	 2r0f1E2Nd/Khv/yzP5CAXaMdGVEPvs2Ea5BTJIEaa16kp+d80+LLHcFAhXNugG3ucL
	 XKjE4/5l8q3Lv7IFd5YcRzN7Yb/MAp/SRR+O7z1TveTepu0m/EEzxLGf2D8gWi1pIz
	 5GxPzS2p+XfSDm9UvYSB1exFSKSTcTVrYDRuWdLjY0gEbokm8qvTrozBo0cLFLiaPb
	 iePIowrO8kUZ0VLTPlEnTMA9fMhaW+pLy2zrAQof2HJ3XKYdCBVuNC++j+JdemNLJv
	 v+SJDxhTNJrcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46AED4921E;
	Mon, 18 Nov 2024 13:09:41 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 18 Nov 2024 18:39:34 +0530
Subject: [PATCH net-next] net: phy: qt2025: simplify Result<()> in probe
 return
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-simplify-result-qt2025-v1-1-f2d9cef17fca@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIAI48O2cC/x2MSwqDQBAFryK9tsH2A+pVgouoz6RBRzM9EUW8e
 4Ysi6LqIoNXGLXJRR67mq4ugqQJDe+ne4F1jEx5lpciUrPpss06nexh3znwJ0RVsfR904w1qgI
 DxXjzmPT4jx/kENjhCNTd9w9rgZsTcgAAAA==
X-Change-ID: 20241118-simplify-result-qt2025-1bb99d8e53ec
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731935374; l=1232;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=b+u/enFxPC2OQb24qeuinsUzhoPbbFPNjp30yv8A78E=;
 b=VVCd959mHl3fdAs00yFofntkbHvAfCQ2XltcauKLxVDNZfmtVWdVj1Nm4rF9y767uXY4UvSAY
 qf/QRFW7KT3CjzzeOo61XIcbXoEmUYDUqLjvqyWWmeNhZuE4CwcHlJT
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

probe returns a `Result<()>` type, which can be simplified as `Result`,
due to default type parameters being unit `()` and `Error` types. This
maintains a consistent usage of `Result` throughout codebase.

Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
 drivers/net/phy/qt2025.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..25c12a02baa255d3d5952e729a890b3ccfe78606 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -39,7 +39,7 @@ impl Driver for PhyQT2025 {
     const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043a400);
 
-    fn probe(dev: &mut phy::Device) -> Result<()> {
+    fn probe(dev: &mut phy::Device) -> Result {
         // Check the hardware revision code.
         // Only 0x3b works with this driver and firmware.
         let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241118-simplify-result-qt2025-1bb99d8e53ec

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



