Return-Path: <netdev+bounces-104145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B6C90B511
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C801F251D7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0215B0E3;
	Mon, 17 Jun 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="CHqgnA5e"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3015AABB
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637754; cv=none; b=CCa9fIeEzkfR/iDbVpMZ6+UmpGSmpUgii8dU9/IUfBy1mPOK8a3B4ruQLkUtpxerzjHK0dZemgm9bw9SIs9w/lqeHDQ+q1HWq5tLR9rDmvnGxIuGBaV1yuMxN73kgrdTxnOheeVAqROndS3xeSYuIOVcXg7AGIFlRsGLZ6XiPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637754; c=relaxed/simple;
	bh=wJNV/42HjLFWQUYppiDPj8EoEZINZLRmNLoQPS7mZ2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3C7k+VXpEFF7xTSlJdbzVcyijnQWXVP1sFAHISZRacYTi+djddpWZvbsFafzmc+K0XYef+bfsYZ7oo1j9AroQs0/CgPYZyebalI0CMNSe0uyGveQ0WIyYUFEIZvJ46XgoScETH15qoLhGbRuFhrL/TYdBclLAhRaHLJuZPkTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=CHqgnA5e; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024061715222874f29b013efdbd9e94
        for <netdev@vger.kernel.org>;
        Mon, 17 Jun 2024 17:22:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/EABjvlbPLsARyzJ4KZzxhNg4k6Cnivu4GX/GT6Rja0=;
 b=CHqgnA5e3RNIn2wxD3FM4gITg26Mo6RhpPOKUXfVmxxGQ0giG1HPFAW4A1Lu9plm4XkDA+
 XDKKfm3zP5xYi/a7havgREJM6ize6FMdh2C850HzkGhJfQ4H0NSDSqyjiNMWUtuwAM6G9rL0
 JgQvaPHp6mtt1RC/+cGH4ADvv7I4Y=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Mon, 17 Jun 2024 16:21:42 +0100
Subject: [PATCH net-next v4 3/5] dt-bindings: net: Add IEP interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-iep-v4-3-fa20ff4141a3@siemens.com>
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
In-Reply-To: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718637741; l=1034;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=wJNV/42HjLFWQUYppiDPj8EoEZINZLRmNLoQPS7mZ2A=;
 b=6wsqJo9kwhlrVNl3BTDdfJCSIJGUy1Qdt5j4AIV6Y3fJQ2Y9J07WynWqqDx9Tl05Y07CkBZrZ
 DlYEMMn/vKHCbtN5G0goMFL03s6Oanml5qeRkeykqbaVBB/WAoee2x9
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

The IEP interrupt is used in order to support both capture events, where
an incoming external signal gets timestamped on arrival, and compare
events, where an interrupt is generated internally when the IEP counter
reaches a programmed value.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 Documentation/devicetree/bindings/net/ti,icss-iep.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
index f5c22d6dcaee..e36e3a622904 100644
--- a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
@@ -28,6 +28,15 @@ properties:
     maxItems: 1
     description: phandle to the IEP source clock
 
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt specifier for capture/compare IRQ.
+
+  interrupt-names:
+    items:
+      - const: iep_cap_cmp
+
 required:
   - compatible
   - reg

-- 
2.45.2


