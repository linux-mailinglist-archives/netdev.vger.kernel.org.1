Return-Path: <netdev+bounces-243460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45610CA1A0D
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D481301A714
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE742D063C;
	Wed,  3 Dec 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wggsSFBx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VfU5lGeu"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D924DD15;
	Wed,  3 Dec 2025 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796151; cv=none; b=k6CCCJjLnJ7Sq5jTWdBtvARZaRm4TfWd4u+EkQf2s2Kw9UvW7KqqnLkAUTWo9DfCxqBNX/yx44aDonVguuF0TBPpZ35hIOo5z402ynpCfEDV7E8wafNV1//3JMJ4nnj8AL1u/b/xxVatfqJqbuiaqomGNG+OgH2i0chVoteTr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796151; c=relaxed/simple;
	bh=rPqG2kR2xua/OZ3PxuiVmscoQv7tQ7iP3eBYF5aoQ3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YoZF89u6ZYRIETwocZxsPs4L5ll48hVAadPqh0L7yR07acncwNE/snFRhNeC6FGbiZ75wRtB7c+ZbVZZvcYxi+mTt1Dk5hxnCCs2O4Qxfyqzl+4tTDMATZ255mKk0RhzHtuEWEKj4dX0cZzQHk0C5FXsOoPjt3OChu2jMXKr4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wggsSFBx; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VfU5lGeu; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dM9HQ64jkz9sWL;
	Wed,  3 Dec 2025 22:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AAF973vn28TqQ3uC+RgqK8Xw/VghUqC4XDR067oeP04=;
	b=wggsSFBxvO8MpRRfq1RwvL8s/Otm+t4D/6DlfU7wwRS6TFTJ6atysA8gsuCgpWGRJNjmvy
	kpf52NlTzbhhtUNZwwlUgW3hazu4d6xsEeuVUorZ/FgaNg534T8AW1RpFmXLEVleUaI7lS
	yKG7VnxrO7zZmhvWwrAZmrSQ3vNetcmv1s7wR/knaSw8Gzh6yL6NcTsUbn86+wkUaGP+4f
	eGHrT6iQhCjWwlWggWi9OnOimPyNA8QDUF96WylnyrxSVtPdahJEvsHYI2UWSRzvmsBV3Z
	KC/rTCwPmd9rFDPFShSMdaNhp/xwSGMsArMLc3ojVPmpPgCL/+bYxC4eFYh9RA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=VfU5lGeu;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AAF973vn28TqQ3uC+RgqK8Xw/VghUqC4XDR067oeP04=;
	b=VfU5lGeuBnGUSoLMjKGHzjhmK/E+p7I9IuBuuxJYKM3ctc/is/BY290vgXJIq+e1YwFgi0
	y/Hbu1TGUSykTEHVSPrjd9q2Ck8KyxjMreCK20mQ3BrrsWZe9LIoLm4UTkMHXfiMPw3rwq
	kRRjzkkwwtx4pAdSveE7u0Ms+9qJZCmQDsGZ9rsSE5SYs4bJbZUV2zioGOwZhycMGBcQDM
	TNTY5dVtwv4zgGmepPphsX9TW4fLDkDBH8i4VQ3kDTg7UZFklptqQ4nDxzgF4pgZaWJSnx
	IkZJNlH/z4075LibCk7pGrTA4kbx4eVOtCNVk2LTjfVaCARNclSAV24hZIcQxw==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v2 1/3] dt-bindings: net: realtek,rtl82xx: Keep property list sorted
Date: Wed,  3 Dec 2025 22:08:04 +0100
Message-ID: <20251203210857.113328-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cb5fcb4ceaa1a6d2f6e
X-MBO-RS-META: o56k8bpp3oyfn87kuxonkzungk539fbo
X-Rspamd-Queue-Id: 4dM9HQ64jkz9sWL

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
Cc: Ivan Galkin <ivan.galkin@axis.com>
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
V2: No change
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


