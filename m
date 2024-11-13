Return-Path: <netdev+bounces-144601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D08A9C7E7F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FF8282407
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573418C326;
	Wed, 13 Nov 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz+Rqjpu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF0189BBD;
	Wed, 13 Nov 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538655; cv=none; b=KJqnR5ZK6R6GQYFyfxmsO0OOWLaHvYuelvM8Pqxusre14/FZX8wrP8lsORNujrbC33jYUjwKlCsSb5DkHR0IquHRMjBnwX5ijbUdNozR4YtWj3DeUtz65hsovoSIBacF8gLxGQtkedVxQ6ikI+c4DBDvzLyEPXGIwAh0m+n4YAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538655; c=relaxed/simple;
	bh=oSC9Gb3OVTLedacO6F0fCYe2uR6bfLpRfwHWeR982cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8BG9AiuAnHu21FhVVo4qdr7zCgzObj9AkYnRK2dHeBolxdozQRZjyQDpC6xZy1IGSiZZQLtJXK8E2k3Z7YZOH9yOoYpsgaDMFdpAJ0hQ9LcYzMsFYKtsNSJDVNclgKno2Vp/2zDWh8wL9p3VR4pRUoSbTDoemXXidc11i3PlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz+Rqjpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473DAC4CEC3;
	Wed, 13 Nov 2024 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731538655;
	bh=oSC9Gb3OVTLedacO6F0fCYe2uR6bfLpRfwHWeR982cI=;
	h=From:To:Cc:Subject:Date:From;
	b=mz+RqjpufpyV18W+tIYoDZaWQ+czpv9ohYOYAdrujokJm4IZKlCKZ2LKLFt9BV+wx
	 L8Nb1VMGC3VYgxNQVrzNJqlhvBR2ZmItXSxXH3Xt6KT14iApFiN0D2OhMu0bBM0KRT
	 0sba2toglf3DFcOD3dZuYG+Lj22yv7RnCMo8uG42Moe8YOfldzQCot3QD7t1wUgwnd
	 kFtkIJG6ejnA6lyM3hTpZemEwvBpoFEVg9Cm65yGmX51j9qqMPVgAzT0nUktTpWHhk
	 2aQtrvwnUMjbRnueoA2xwgHg3u2t7C4HlS6JcFEGsX1LjNb1FurYOD3cXZl95OIg2j
	 ccfpw3SQ7ztGA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: mdio-mux-gpio: Drop undocumented "marvell,reg-init"
Date: Wed, 13 Nov 2024 16:57:13 -0600
Message-ID: <20241113225713.1784118-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"marvell,reg-init" is not yet documented by schema. It's irrelevant to
the example, so just drop it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/mdio-mux-gpio.yaml           | 32 -------------------
 1 file changed, 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mdio-mux-gpio.yaml b/Documentation/devicetree/bindings/net/mdio-mux-gpio.yaml
index 71c25c4580ea..cc674b21588c 100644
--- a/Documentation/devicetree/bindings/net/mdio-mux-gpio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio-mux-gpio.yaml
@@ -53,37 +53,21 @@ examples:
 
             ethernet-phy@1 {
                 reg = <1>;
-                marvell,reg-init = <3 0x10 0 0x5777>,
-                  <3 0x11 0 0x00aa>,
-                  <3 0x12 0 0x4105>,
-                  <3 0x13 0 0x0a60>;
                 interrupt-parent = <&gpio>;
                 interrupts = <10 8>; /* Pin 10, active low */
             };
             ethernet-phy@2 {
                 reg = <2>;
-                marvell,reg-init = <3 0x10 0 0x5777>,
-                  <3 0x11 0 0x00aa>,
-                  <3 0x12 0 0x4105>,
-                  <3 0x13 0 0x0a60>;
                 interrupt-parent = <&gpio>;
                 interrupts = <10 8>; /* Pin 10, active low */
             };
             ethernet-phy@3 {
                 reg = <3>;
-                marvell,reg-init = <3 0x10 0 0x5777>,
-                  <3 0x11 0 0x00aa>,
-                  <3 0x12 0 0x4105>,
-                  <3 0x13 0 0x0a60>;
                 interrupt-parent = <&gpio>;
                 interrupts = <10 8>; /* Pin 10, active low */
             };
             ethernet-phy@4 {
                 reg = <4>;
-                marvell,reg-init = <3 0x10 0 0x5777>,
-                  <3 0x11 0 0x00aa>,
-                  <3 0x12 0 0x4105>,
-                  <3 0x13 0 0x0a60>;
                 interrupt-parent = <&gpio>;
                 interrupts = <10 8>; /* Pin 10, active low */
             };
@@ -96,37 +80,21 @@ examples:
 
             ethernet-phy@1 {
                 reg = <1>;
-                marvell,reg-init = <3 0x10 0 0x5777>,
-                  <3 0x11 0 0x00aa>,
-                  <3 0x12 0 0x4105>,
-                  <3 0x13 0 0x0a60>;
                 interrupt-parent = <&gpio>;
                 interrupts = <12 8>; /* Pin 12, active low */
             };
             ethernet-phy@2 {
                 reg = <2>;
-                marvell,reg-init = <3 0x10 0 0x5777>,
-                  <3 0x11 0 0x00aa>,
-                  <3 0x12 0 0x4105>,
-                  <3 0x13 0 0x0a60>;
                 interrupt-parent = <&gpio>;
                 interrupts = <12 8>; /* Pin 12, active low */
             };
             ethernet-phy@3 {
                 reg = <3>;
-                marvell,reg-init = <3 0x10 0 0x5777>,
-                  <3 0x11 0 0x00aa>,
-                  <3 0x12 0 0x4105>,
-                  <3 0x13 0 0x0a60>;
                 interrupt-parent = <&gpio>;
                 interrupts = <12 8>; /* Pin 12, active low */
             };
             ethernet-phy@4 {
                 reg = <4>;
-                marvell,reg-init = <3 0x10 0 0x5777>,
-                  <3 0x11 0 0x00aa>,
-                  <3 0x12 0 0x4105>,
-                  <3 0x13 0 0x0a60>;
                 interrupt-parent = <&gpio>;
                 interrupts = <12 8>; /* Pin 12, active low */
             };
-- 
2.45.2


