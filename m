Return-Path: <netdev+bounces-242755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE839C949D7
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 01:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD33A48DE
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EACC1F419F;
	Sun, 30 Nov 2025 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GDJ4KkaU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R8ogj7Iu"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B2D2FB;
	Sun, 30 Nov 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764464341; cv=none; b=rCDdkUJ1Qki8vYyCtwJ7XWAEULQIPAVL0slvL0TQuZB/ycUdt6L0+mcIZN7ogquxOXfrHAuNdbu3+raRDsj6IwElpUM9jhP7rzS1SwaS2zfQW65mJpfcLWW5pgROeHTTNvT7ILI1arbQfz0w7HzXvE8HbHSZHsS60ggvfbXldL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764464341; c=relaxed/simple;
	bh=tRDtE7KUg6DIkaQA/ifHZudl2WW9s/egjiKBNK+auKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUzxvoI41C47l/uKmfSEO3USP+SToGjrwf6hn/0E4mVvxVTPjTaoa2g78CxTJnnSNwCmUmkeLxKUA/SIKruGTBD73pVECcSVnsqRLcwX4qS9MCIuuBRGsPzCpsDzi2E+Y89o23sDU+1dGsjmvUB0bxAMs1FnZDNwCbP7oUSRWbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GDJ4KkaU; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R8ogj7Iu; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dJpZM5Vkzz9thx;
	Sun, 30 Nov 2025 01:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764464331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UzyzCbbIsL2cl1obWDT12GSQSmDtX1Z2Fdyk0wFw+Og=;
	b=GDJ4KkaUZ3RUg2A+secNLimb9P34zsNRZc3Uaf6tUvnIdlzoYJQZ+W4SmA5F2b2WBBKPPA
	c2SHruxSA0zxAXH/u5eYywPjsmKfKQ8avIOhE/BfSLuyrFZdlskNeNKK8JwhCerrhaF6SW
	zdN6D8P3twI2otMT212YdearWH5nSbhkfR2ICx+UaA3Li8+Om+8HjgioyG0egkJPXODaNc
	dyRhYEqNOWnn/QxlpatNhJhvNbGBPFsIJAvfmPPL4tJ0ct8Ey1k+bC7Y6udump81qfZ3DQ
	jZx9flHAE6M9teqGf5tQIDFlVQs9NG7u0+DrIWyMkagBq8xtclG1u26zCtWrAA==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764464329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UzyzCbbIsL2cl1obWDT12GSQSmDtX1Z2Fdyk0wFw+Og=;
	b=R8ogj7IutUtQN2Gx6HN7+0xH9RlCHLodREdkhY4W9cvP9EaIgJEo6V2l/HjYZXPCwbLBxP
	/8L1fLkhmaF8e5SqywVRs9e+fmuMZXzrBMulwq5szGMh5weZpPwTNU3b6MzumiiK8rLx6O
	DR/npY9Zcjcss6mzEC5IcD6+lHrhh5+PuRDff5xwIxSalSc//B2VcrjjlFe4+o9YROBYVe
	0OoMh62a4PLudKnoZOz6M1RQro8v/oTinGggDN63diejDCx3ln/Z2c4IORSxQQZ003fKVW
	ekUKXQX3133ZYGSDJULKw7AEZRc1Slrj5De5BRPJbhTMSPs7rOTyVCuoaK+wCw==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH 1/3] dt-bindings: net: realtek,rtl82xx: Keep property list sorted
Date: Sun, 30 Nov 2025 01:58:32 +0100
Message-ID: <20251130005843.234656-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dac622d50c6456c1c73
X-MBO-RS-META: hu36wwodc3amws5df3er5oeg8ddqgw89

Sort the documented properties alphabetically, no functional change.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 .../devicetree/bindings/net/realtek,rtl82xx.yaml          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 2b5697bd7c5df..eafcc2f3e3d66 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -40,15 +40,15 @@ properties:
 
   leds: true
 
-  realtek,clkout-disable:
+  realtek,aldps-enable:
     type: boolean
     description:
-      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
+      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
 
-  realtek,aldps-enable:
+  realtek,clkout-disable:
     type: boolean
     description:
-      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
+      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
   wakeup-source:
     type: boolean
-- 
2.51.0


