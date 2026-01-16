Return-Path: <netdev+bounces-250359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B57D295F4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E32D301AAAF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9A273F9;
	Fri, 16 Jan 2026 00:07:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03517BCA;
	Fri, 16 Jan 2026 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522042; cv=none; b=MkDJCAWhun3YBR/hG9Tf9vT/A7BNzRPDrKtYvjEkPwuLXDPFa91HngVeq1urJ0MAhhNQ2KAMSkUzJzxqCBQ0I8+Oqzgqo1ZIh8jDJFdnH/GitRDI7MG1mVf8rzE+kGcnlUCe1xdVr3F8aQ/InH1tsj3cNFEUNCWerEcNq8Bwe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522042; c=relaxed/simple;
	bh=hJeEr+ILCMiYD8+CQBNSd8Yh6IjMKJJX6qe+O3HaMKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9l8UJLTiikmIGDcpTxaOnT2akOxfgMygoy1jgPK6oAV5Mw4aMCOYbmP23fwGqWs6skAyGcKaqTRynhmu//M/Ar/2A3qQqD9yFcfHl/BKN/ZmVabzsURLeT6Hx3zJR1tVn1eFG/9HrIJeBlk74Y2JsWHOoY1KDbMViEbM9+yeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgXMy-000000007YT-2gAB;
	Fri, 16 Jan 2026 00:07:16 +0000
Date: Fri, 16 Jan 2026 00:07:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v3 2/6] dt-bindings: net: dsa: lantiq,gswip: add
 Intel GSW150
Message-ID: <ca8ca2c4a05185a933069917397c8d82a56af7a5.1768519376.git.daniel@makrotopia.org>
References: <cover.1768519376.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768519376.git.daniel@makrotopia.org>

Add compatible strings for the Intel GSW150 which is apparently
identical or at least compatible with the Lantiq PEB7084 Ethernet
switch IC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v3: no changes
v2: no changes

 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 9c0de536bae97..97842523772f4 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -19,6 +19,8 @@ maintainers:
 properties:
   compatible:
     enum:
+      - intel,gsw150
+      - lantiq,peb7084
       - lantiq,xrx200-gswip
       - lantiq,xrx300-gswip
       - lantiq,xrx330-gswip
-- 
2.52.0

