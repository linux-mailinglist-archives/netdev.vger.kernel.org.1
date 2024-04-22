Return-Path: <netdev+bounces-90041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A388AC932
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D451C21087
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C867F496;
	Mon, 22 Apr 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3SRkzs3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CB5579A
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779086; cv=none; b=NZyOmLl5bjMyluhd8jGJcgPmjHwDHd+O4z1KRSXu2G2DNcfbRZuQ7g7WKrz37tTx7zFHC4qrKAsHphOyFBTQLbAezHGnK+53ybaesmsHF14L79GHQlZD0dOrH4gJmHppBVPuE/cVSBqcDIn+ncPiwR+b15VJ2JY8eRO86iFE1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779086; c=relaxed/simple;
	bh=Rs38yYhmzLus4bRtmiHPZEPwON0z0AYCa84i+53z8OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFT9mlsvjekQjrObzFYoARz6Ceq7S9GLDA7YwZkbXNUoSUm/JjyzGQxi72FCM8e0pCWAFy9IRRjX1lf17a+xMzi6LydOYz3LPKq/wZdU2PRI9nahM05/ud3MYoQH4phwVyKOF1CFrmWW7RaLEVFBzOwHbjFq3tDy6YtE6aDLJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3SRkzs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAE9C2BD11;
	Mon, 22 Apr 2024 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713779086;
	bh=Rs38yYhmzLus4bRtmiHPZEPwON0z0AYCa84i+53z8OQ=;
	h=From:To:Cc:Subject:Date:From;
	b=O3SRkzs3tUEFiJtDXA7Joj8WLTceDGXBAo8tUvxzvn9qM8fnt3deggPqajvL8JbIt
	 oVKowo622dfK7nmAxUM1TvEKiE3ED0/VpUY2PebTMplt3yiqyxJyee9J6iGsQAZzz/
	 K76KeGZ/B1hK5rpZV8zW7g9ulKbBRhiGoHQLObXOBfCAPfxXdB1rUgZj2G9zZQBimV
	 d/uTnyZ36lvBvVYQ5QRpDllVfbSnNkvpuf4iohCNOznbWQXfvYqOLgdqSviy87VLFd
	 o6YhZvz9loqBgvBvyqDt5+hGqfL0PUKXbfJnkGIiCnnxXwXZEazYxmHZC2Nu17SQf8
	 BQDPTKpz1Qd3w==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 1/2] net: sfp: update comment for FS SFP-10G-T quirk
Date: Mon, 22 Apr 2024 11:44:34 +0200
Message-ID: <20240422094435.25913-1-kabel@kernel.org>
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


