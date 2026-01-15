Return-Path: <netdev+bounces-249982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC63D21EA1
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 299C3303CF63
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1AF1EA7DF;
	Thu, 15 Jan 2026 00:56:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C081F0995;
	Thu, 15 Jan 2026 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768438610; cv=none; b=rs6BaBdde86qxsvpuvniEfNfhypDSicrwG1vp27ZO/0hBqIJpfXLD9wCOdiM7D/huLXm1wPZ4mK55y4phMFmMSmNH4HzKBU2s07yo6qQGoyX6PBV67QG1i9IpobBj8I05hZnTg5WwArha2km5K9o3Oq4abKirS4ogKgak5CSi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768438610; c=relaxed/simple;
	bh=N6YDEJuLVuowyOYXj01PWUfuKnkaZl5gKTEzGDsQ5Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRnLzvgVMEA05HI50/OmJTgZ4teX9hJtFYkHPC/9nkhU2i+WTlYYmNwYSmVOyDAhCayeiy40r+peQ5Su+eyGuqKJza+sGSWmKHrTVY/dGYEAHcwJLUg91AWUp+k7HofUShzQsWGrJpmONBI/HCXETZ6QZKu2kHQ5rxY0AMMXl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgBfF-0000000021v-3LZi;
	Thu, 15 Jan 2026 00:56:41 +0000
Date: Thu, 15 Jan 2026 00:56:39 +0000
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
Subject: [PATCH net-next v2 1/6] dt-bindings: net: dsa: lantiq,gswip: use
 correct node name
Message-ID: <83c6aa2578c6fa7b832a6146ef74b9f7aee0941d.1768438019.git.daniel@makrotopia.org>
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

Ethernet PHYs should use nodes named 'ethernet-phy@'.
Rename the Ethernet PHY nodes in the example to comply.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch

 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 205b683849a53..9c0de536bae97 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -316,7 +316,7 @@ examples:
                 #address-cells = <1>;
                 #size-cells = <0>;
 
-                switchphy0: switchphy@0 {
+                switchphy0: ethernet-phy@0 {
                     reg = <0>;
 
                     leds {
@@ -331,7 +331,7 @@ examples:
                     };
                 };
 
-                switchphy1: switchphy@1 {
+                switchphy1: ethernet-phy@1 {
                     reg = <1>;
 
                     leds {
-- 
2.52.0

