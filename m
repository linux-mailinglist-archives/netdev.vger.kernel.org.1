Return-Path: <netdev+bounces-250358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA33D295E5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEA80301BB0D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB141F92E;
	Fri, 16 Jan 2026 00:07:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716D182D0;
	Fri, 16 Jan 2026 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522031; cv=none; b=WNGYNNjWOg/Pb9uvWPuLEAumVgRe41hjabzw24bq+bJq38K1PhFrCQUeCC3gC+OV4ty4XspqlaE0epiBydGI+I+UKqMxGbAtNA4LVSP3FP195Ij8zRMpIXGLb98YfX0hqyMLEA4XG5q2qMCwcW0CRnad/6dXtQMvHtnR2cDSwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522031; c=relaxed/simple;
	bh=lVwW+ZIzwZlAGPTlomz9CtGlt07l+YYmlibe8px+xUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQphf/IqZHWFELu20y9CWOrJFVy/47bg3paM4z+EOmVyYlSmY4odfdJbTXDcE1JKthVTjTVxXLKAAZl9kykWRUSKkGlfz4BHq2YkzoJ3mTQqxm4rWSJVPEayR2lTRcpRU85sYl0rMw/OO2tfVf1dJq2obhQADnH+sd2efQkKut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgXMn-000000007Y7-249h;
	Fri, 16 Jan 2026 00:07:05 +0000
Date: Fri, 16 Jan 2026 00:07:02 +0000
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
Subject: [PATCH net-next v3 1/6] dt-bindings: net: dsa: lantiq,gswip: use
 correct node name
Message-ID: <b85391636db5af2f038ba6968b292199d312f403.1768519376.git.daniel@makrotopia.org>
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

Ethernet PHYs should use nodes named 'ethernet-phy@'.
Rename the Ethernet PHY nodes in the example to comply.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v3: no changes
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

