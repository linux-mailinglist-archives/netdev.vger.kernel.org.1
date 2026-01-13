Return-Path: <netdev+bounces-249279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD321D1679D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4916C303532E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D640D2E542A;
	Tue, 13 Jan 2026 03:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F922E0B5C;
	Tue, 13 Jan 2026 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274688; cv=none; b=NawM2HThCP6N+oPdqURlej2u2AMxpk85LduuA8k7KowZQ/wMKVIB86ptwCmu6vha3c2pvhvyb6jFH1A/9LmGdvcyMGaURBsd682y2EUdWpgMxGg52t3bhEZYFw/RDVI/jo57Z5DKNlOiAvX7z/lcAiEP6QW+ZqShWXCbugeKHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274688; c=relaxed/simple;
	bh=uplZQt70PZ8hLU2m02GVS+3vvwDPluy0hT1fuhJb38g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j12yGAYEMYRHRx0IXlwvxudZwAVTk+HMTtBa8Rhe2mez5cGLHx2N7uW67Jz+HbdT28sotNuja3BcPmBJOYhlNKBnNrUznOgWTc5Ophb9CSqrY0m6UBHI6/92Tj8OG6nKkhthl0hI+zXa1uS0RbiVZQPFAqa3GIjlQJKxk3/9VB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfV1P-000000001LV-0EeZ;
	Tue, 13 Jan 2026 03:24:43 +0000
Date: Tue, 13 Jan 2026 03:24:40 +0000
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
Subject: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip: add Intel
 GSW150
Message-ID: <1217a182e52247dd8943aa32e064be12f09ecedb.1768273936.git.daniel@makrotopia.org>
References: <cover.1768273936.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768273936.git.daniel@makrotopia.org>

Add compatible strings for the Intel GSW150 which is apparently
identical or at least compatible with the Lantiq PEB7084 Ethernet
switch IC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 747106810cc17..f8d14708af560 100644
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

