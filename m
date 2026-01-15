Return-Path: <netdev+bounces-249983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E14CFD21EBC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E24C3030FE0
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B01E5207;
	Thu, 15 Jan 2026 00:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601421CDFCA;
	Thu, 15 Jan 2026 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768438622; cv=none; b=MQU1XTvHy5f7tLu9+IPff+AT98s3lne2zjv5Eqi3pWmBjf9cNxgwVp4oZYtT64t8QcF8DEV05Nesev1eEG/r3O9yZPDltspcL/1Vli88hn/Wg7l2nQTjWNZRoykbV3PSoXh12vplE3FcKgpgCKh0KWxWElt/xePdpnljWs1DG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768438622; c=relaxed/simple;
	bh=3+eC1JtO/mmuCAkNXbLPYZhWz1BhLg2cr3IBFwcz434=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHdDfR48egxGGnEn7ZnfEaX4kBqfbk+NOQWV7GLZRMyC53gr21oQgbw5P/hWp43m1WrIFyn8JTgE8/Ym1fuSQvrNXr1axxzSNj52QK1bXuixzmdYTJwZGQ1PyD4Ew6QroZ0umIRFPOymZwYvJajwVB0gwZ+w/FnJL8JiRoucumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgBfU-0000000022G-1AgL;
	Thu, 15 Jan 2026 00:56:56 +0000
Date: Thu, 15 Jan 2026 00:56:53 +0000
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
Subject: [PATCH net-next v2 2/6] dt-bindings: net: dsa: lantiq,gswip: add
 Intel GSW150
Message-ID: <10fdede364239ac04ef768983e5a18dbb37b4c55.1768438019.git.daniel@makrotopia.org>
References: <cover.1768438019.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768438019.git.daniel@makrotopia.org>

Add compatible strings for the Intel GSW150 which is apparently
identical or at least compatible with the Lantiq PEB7084 Ethernet
switch IC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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

