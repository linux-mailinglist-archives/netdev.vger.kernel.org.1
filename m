Return-Path: <netdev+bounces-163070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A04BA294E9
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13427A506A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B21DB128;
	Wed,  5 Feb 2025 15:32:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7CE1DA31F
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769576; cv=none; b=eh344qxR6180PFrUdQya3mmnRDCTT0+gPhfAsAiCbbCmD6nPVSiH89HJeMnYQOy8mwfUDBnBGK5GuHE5Jlle6etqDFJ+svZ7lACgTVJLt3hU4+HyN8xK7ZsUdHB5ht4Uabth4xH67RSoTnYwwNsftp0MKCR7FTdEdvtBRia4nHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769576; c=relaxed/simple;
	bh=W6EXVDRclBOqT165c+5pG3UXqmPzGOlJeB0NP+pr+eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggWSLbCpO7TN/S5+OagpAkC8KybNl+NawneA6TKGpx35/vnmPf1TxBIhkpuzodH5qLe8Cyq/EIZg6VeexllxmfZ5oH5QZjip6C2LtsYm9Rddm9tZK9s8cYZhhSJmX4H+6tCifhRNobE/ZzO6MBEFonwCrCMT6poftQcBXUGRoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tfhOK-0005Jb-UX; Wed, 05 Feb 2025 16:32:40 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 05 Feb 2025 16:32:24 +0100
Subject: [PATCH v4 3/6] dt-bindings: net: dwmac: add compatible for Agilex5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-v6-12-topic-socfpga-agilex5-v4-3-ebf070e2075f@pengutronix.de>
References: <20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de>
In-Reply-To: <20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The Agilex5 SoCs have three Synopsys DWXGMAC-compatible ethernet
IP-cores.

Add a SoC-specific front compatible to the binding.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/net/socfpga-dwmac.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
index 2568dd90f4555485f18912b5352f191824bb918c..31c163bf1b59e14216d1fb4b4b9aaa747e1b19e2 100644
--- a/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/socfpga-dwmac.yaml
@@ -21,6 +21,7 @@ select:
         enum:
           - altr,socfpga-stmmac # For Cyclone5/Arria5 SoCs
           - altr,socfpga-stmmac-a10-s10 # For Arria10/Agilex/Stratix10 SoCs
+          - altr,socfpga-stmmac-agilex5 # For Agilex5 SoCs
   required:
     - compatible
 
@@ -45,6 +46,12 @@ properties:
               - altr,socfpga-stmmac-a10-s10
           - const: snps,dwmac-3.74a
           - const: snps,dwmac
+      - items:
+          - enum:
+              - altr,socfpga-stmmac-agilex5
+          - const: altr,socfpga-stmmac-a10-s10
+          - const: snps,dwxgmac-2.10
+          - const: snps,dwxgmac
 
   altr,sysmgr-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle-array

-- 
2.46.0


