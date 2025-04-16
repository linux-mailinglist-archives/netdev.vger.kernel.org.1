Return-Path: <netdev+bounces-183414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C189A909B9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831CD7AC0DE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950A21770D;
	Wed, 16 Apr 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l34SkYT6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC3216E1B;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823700; cv=none; b=Nz9KDSu/taWOrM3+u00ICOTfVVmvaI2pKWZG0NN+FEP/b5jxKOFK/HmwDTCXfCCI7N+PY0x9MhbfXbV1zMF2vW0puyo71qPV79bQhECQAnTTZWEJQLy1+pYb5NyZYT1Dh8zBBJMfDSOE06aoFAXKw6Vh8FuInohi5BoIsFwcAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823700; c=relaxed/simple;
	bh=cFwspKEdNzMDgmNkSYSyp+e+y0BEh+uJjdRR5wLf1ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1LnzM+2AHs+eyXfxQFHQQL98ZTQXJnBuQLSVxSW6nsLYZI9gxDP2ztjVgXdJRgYxf4tAp0UViaMM6v3wG52LWhF8LdzUfgR5G9Ap2LFynEg4+0DEWqYaGKxYZgxQqDqLUMO57FNH0aICvv03Mro0ymNgWZ2wwSeT4ph9Npm2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l34SkYT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BE36C4CEE4;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823699;
	bh=cFwspKEdNzMDgmNkSYSyp+e+y0BEh+uJjdRR5wLf1ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l34SkYT6OzVvBAGqrofLd36W52hRzPw+/yVSoFhglycwwfUupVnsE0hphBAg9dlzK
	 z0YuKDWx5ZN/wOyZMQiUgbxx+b/164rvF5tZFLlz3WDYYCWdi0Nj6monLgbslMwpmR
	 DtKsjJ7dGlyrh2kVywtahVNia+uG5Vu84jo5lOYsv89Hd75DHCVnS8d+BxWJJKR134
	 YDvb5lygAZO+g95vD7z8Ggs6WN/15w5EsbovSH6kNICCd34fVZdDAaeiEKB5dAWh+H
	 VIdC+GXT7j/6f4YAg31fZ6OnmaYqCIMiuXqxGzuC5pc3aEGuYdVsCD39FCJAors4PK
	 wiNJPYZcssgaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D37C369C7;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 16 Apr 2025 19:14:48 +0200
Subject: [PATCH net-next v3 2/4] dt-bindings: net: dp83822: add constraints
 for mac-termination-ohms
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-dp83822-mac-impedance-v3-2-028ac426cddb@liebherr.com>
References: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
In-Reply-To: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Davis <afd@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744823698; l=1043;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=7BGE9tLp93J171J2FMQIe9ov/36XBFIFpQ/JiCi+QRk=;
 b=4I4GSYv9VJSa6JnkgkwdunnyRsu48D4YMC+tlSYhLrhhWW74kjNAHiycTFCavsjRpRaeOnR81
 QtWOY7xs/R8Cl1wSiciNSdgVaQVE5QmmgS3xVlZadhaULjNuf8AhPC+
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Property mac-termination-ohms is defined in ethernet-phy.yaml. Add allowed
values for the property.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/ti,dp83822.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index 50c24248df266f1950371b950cd9c4d417835f97..28a0bddb9af940e79a7a768a35ef588e28ec5bd4 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -122,6 +122,9 @@ properties:
       - free-running
       - recovered
 
+  mac-termination-ohms:
+    enum: [43, 44, 46, 48, 50, 53, 55, 58, 61, 65, 69, 73, 78, 84, 91, 99]
+
 required:
   - reg
 
@@ -137,6 +140,7 @@ examples:
         rx-internal-delay-ps = <1>;
         tx-internal-delay-ps = <1>;
         ti,gpio2-clk-out = "xi";
+        mac-termination-ohms = <43>;
       };
     };
 

-- 
2.39.5



