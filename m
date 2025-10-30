Return-Path: <netdev+bounces-234373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62843C1FD35
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE121A612A1
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762135504C;
	Thu, 30 Oct 2025 11:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3313043CB;
	Thu, 30 Oct 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823782; cv=none; b=mlevjErZV9BnaJTi5GSLTuFUo3uPAPLbHwSHzgpGp5EeQq1eE5vHHnCUEl03jJylztBgtvXjF7D5d+yLW5GcE514ewZGCjzzxiJ25xp58QO/FWIOrro055FDdSSjhOiuJDpsD7O0aUwJPpaDoyy65BX+wR5DE38kX3jVopHBdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823782; c=relaxed/simple;
	bh=/hMAwyTfc7mdPGx8wIHOaFuYwBow6bCR5D0j4c29L6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVtrYUBZoJfBPyEBMdTj+DEpQZjLZigk1v+QBN43ZWq6nH7ZBDN13q4gdc2oq2hLxwvPJwwvvROW/qZw4wUz9bSPV1pILphxycngnb7Xoj0xcA+Rpkk4bE5FJ30S/RyEXCzydQOU9+cNQeEnWX8ZCNkhkr8JLALgw2wJdwQ0VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEQqW-000000005FM-1DTm;
	Thu, 30 Oct 2025 11:29:36 +0000
Date: Thu, 30 Oct 2025 11:29:32 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v5 08/12] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear RMII refclk output property
Message-ID: <4573bd3c32be28ca6f17b68a77edb1373d7f509d.1761823194.git.daniel@makrotopia.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761823194.git.daniel@makrotopia.org>

Add support for the maxlinear,rmii-refclk-out boolean property on port
nodes to configure the RMII reference clock to be an output rather than
an input.

This property is only applicable for ports in RMII mode and allows the
switch to provide the reference clock for RMII-connected PHYs instead
of requiring an external clock source.

This corresponds to the driver changes that read this Device Tree
property to configure the RMII clock direction.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 8ccbc8942eb3..ab3ee4ecd938 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -31,6 +31,11 @@ patternProperties:
               The delay lines adjust the MII clock vs. data timing.
               If this property is not present the delay is determined by
               the interface mode.
+          maxlinear,rmii-refclk-out:
+            type: boolean
+            description:
+              Configure the RMII reference clock to be a clock output
+              rather than an input. Only applicable for RMII mode.
 
 maintainers:
   - Hauke Mehrtens <hauke@hauke-m.de>
-- 
2.51.2

