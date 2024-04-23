Return-Path: <netdev+bounces-90400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5E8AE049
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588D31F21AB8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1755C2A;
	Tue, 23 Apr 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GttxDiCi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319A55782
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862247; cv=none; b=CxstfFLb6GZSPNTRXpqaTP9WnKeDxNKeZ2EBAhTOvGXmSi8WNt3j4hopQMh3nnORw23S3r/H2jsEL062jdq0CHubfPS51KRPu0NKOnC2FLQxhAh766Z67JKwUBI0s+3YMJ4MQO5UfL+DQPCPickZykQEBy9j5c064kqTYuyi37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862247; c=relaxed/simple;
	bh=ZriBtzS/8pdC+TZzWotyoCsb5KLor5nIotYwCDz1AfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MCS167bhU/7t+AmE4qcJ6uw+zb7Et6a/zq8+LJpwUHzhGs8hjPDBca2x4CrMZTvfFa7Gk1XHjmhz8HetYZF1W+sOUOSo8ce5QW/G5lZt4I2NQKOk6sMnAfPEtkESYmkX4YZ5e/VNz3oketcgr5qp3Rve3oeJm4qWq//iI3+GIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GttxDiCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E67C116B1;
	Tue, 23 Apr 2024 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713862246;
	bh=ZriBtzS/8pdC+TZzWotyoCsb5KLor5nIotYwCDz1AfM=;
	h=From:To:Cc:Subject:Date:From;
	b=GttxDiCiHns8V3NGnVSTJAIfeX5Qz2AAoEveyo7rT/NhIrjNMQdOiIe8l6ROb31fk
	 n0dhP7mtz3fq74KHYbCmBYnB1W66AAWUx/INzlsYYOOwibSCK/ubIpsNAudW7F1EnK
	 kDp5Ug6qZgaoHOeZhXZ3Y74oX4yszZd51i0+J3wpzfjg9uVixLkBGxZ5GHdg79GDQy
	 4+NwsvH1lp6iVx4TtGQyQ4wikdMvIV6/zVhny1rYTVwJJIxXdtdW+iFPcPF7dz9a7T
	 +mRxvPD5Qa/hmwvFHZwF+Vs1OT2CGNaNs/ocVhmS/xNKWwDpeIFA0rZZUjgDWQZ0tl
	 kWchIc915WrqA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 1/2] net: sfp: update comment for FS SFP-10G-T quirk
Date: Tue, 23 Apr 2024 10:50:38 +0200
Message-ID: <20240423085039.26957-1-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the comment for the Fibrestore SFP-10G-T module: since commit
e9301af385e7 ("net: sfp: fix PHY discovery for FS SFP-10G-T module")
we also do a 4 second wait before probing the PHY.

Fixes: e9301af385e7 ("net: sfp: fix PHY discovery for FS SFP-10G-T module")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Since this only fixes a comment and the next patch is based on this one,
I am sending to net-next instead of net.
---
 drivers/net/phy/sfp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6e7639fc64dd..1af15f2da8a6 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -468,8 +468,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("ALCATELLUCENT", "3FE46541AA", sfp_quirk_2500basex,
 		  sfp_fixup_nokia),
 
-	// Fiberstore SFP-10G-T doesn't identify as copper, and uses the
-	// Rollball protocol to talk to the PHY.
+	// Fiberstore SFP-10G-T doesn't identify as copper, uses the Rollball
+	// protocol to talk to the PHY and needs 4 sec wait before probing the
+	// PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
 	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
-- 
2.43.2


