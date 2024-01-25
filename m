Return-Path: <netdev+bounces-65783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAE83BBBE
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B0D2811AD
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48D13FFD;
	Thu, 25 Jan 2024 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="uVZvbgkF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D0175B9
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170904; cv=none; b=ulJnKdlv3HupkVfuCOCSrSl3kr1rmup+BOWjXPj/V2Baq8pQdr6JX/DtKVhTbEq+5HjZ5HLZNh9p+NAeFb4i2bK++7cx6syM9Cwp3MDo/CiWPhm6VO68+GfPuhh9enMJvnYhi6B5PztT2nBzCH0Sjoe4D8KlifQ77xgyM6TTiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170904; c=relaxed/simple;
	bh=Wwr/9VY0CuvcH7ywePcK0l0TShBy0NXgTb8eojUbKq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qsnM9pof6zzA7D6Zxzp0DWJPr9oqziYJdKxdUbt2YGZMdXt4Rw3Wcneu3fNdGnxO3Ps8iBQkHXIC3dVMs6aTQ/ZTUYZBtaeP3U8qKyVRQFAw5Yybl8DsXG57RBSAfr81AB+/W9hwZdTW+0rOjN02i7JqZ6fjV3SNPKZAl7QOCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=uVZvbgkF; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TLD0R2qpqzVH7;
	Thu, 25 Jan 2024 09:05:43 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TLD0P73LMzny1;
	Thu, 25 Jan 2024 09:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706169943;
	bh=Wwr/9VY0CuvcH7ywePcK0l0TShBy0NXgTb8eojUbKq0=;
	h=From:To:Cc:Subject:Date:From;
	b=uVZvbgkFPM2U+jrm09GDGJPALEzxJtSZhEup77eEx1CuQCjnL/ixkXrZyU+8t1SPU
	 WMfh3qyG5ZUBsRRj86M/x63r/atchTEeOhMyuylJdeUhK1mYqStoq9Uk3t/pXIWFwN
	 cut8XDiSo8CIE97PLUgXD8XH/ZSpgJD4mw5w+ilI=
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>,
	stefan.portmann@impulsing.ch,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: dsa: Add KSZ8567 switch support
Date: Thu, 25 Jan 2024 09:05:03 +0100
Message-Id: <20240125080504.62061-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Philippe Schenker <philippe.schenker@impulsing.ch>

This commit adds the dt-binding for KSZ8567, a robust 7-port
Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
each capable of gigabit speeds, complemented by five 10/100 Mbps
MAC/PHYs.

This binding is necessary to set specific capabilities for this switch
chip that are necessary due to the ksz dsa driver only accepting
specific chip ids.
The KSZ8567 is very similar to KSZ9567 however only containing 100 Mbps
phys on its downstream ports.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes in v2:
- Describe in commit message why this is necessary

 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index c963dc09e8e1..52acc15ebcbf 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -31,6 +31,7 @@ properties:
       - microchip,ksz9893
       - microchip,ksz9563
       - microchip,ksz8563
+      - microchip,ksz8567
 
   reset-gpios:
     description:
-- 
2.34.1


