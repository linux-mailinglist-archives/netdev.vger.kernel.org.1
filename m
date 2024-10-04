Return-Path: <netdev+bounces-132113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1556990757
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FB01F224BB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16C61AA7B0;
	Fri,  4 Oct 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JX+Qc1NA"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD831AA79D;
	Fri,  4 Oct 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055474; cv=none; b=iTQQFRgiXsCN6X88dYqTGDnZO8BcFUG1vg26FISEfZMWUxHKNBnPtcUJjwy4jXyUjD0woyb7R4bQP696aX+WdzXDyAXJ+Y4wlpk0YKsOpqBUVn1MU7btJt/2AhQ6S3f5wiJPndFYxKzBHUpPBSRmwlqbKV6aWab7n+TRE820oHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055474; c=relaxed/simple;
	bh=thbcL5jlQQJ3wzU2QTA/WH5nBQtUPrtJuYneyPiYqwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JC6JNDTci8jsJKtMj52SPLgGk56g4ETybdflItV4wezDScKSpzpJLevP9A44HOW5JUAtZCVKAUum9+8mtiOTSH1qqGklKojXXYfxVe9+T3LWdkFYC2COBeMvDWEmqV5tBpnwhhtxrtPTSkt5ucbZjigtsnAptm+vwh1gN1kwIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JX+Qc1NA; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id AEFD620BC4;
	Fri,  4 Oct 2024 17:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728055470;
	bh=K6Z3oNeKFKx8bkxnmXTRsD0CwVcOpRTtG+ExOpbstjE=; h=From:To:Subject;
	b=JX+Qc1NALyA4j/FMFMMFG/SjIJWapIhcaHzypuXTKFZHqmyW97hRqCFekintLv/44
	 wNn0f6k0EQNEVdTRcw7x+hb1D6pF6IYs3SaNq5Dnkepnj0ue7RAOdfB9E5ANrnljLs
	 3KJu1t3LFT75Bj41SgGEH1HZtVzYPmyq4Nu7MzxVRUnUuQXOSBwk7sp0pRSVVaVAeG
	 96bfItOkS/9qzu2QCdJTbYBObPmZkG3wxfhqQ3k3LVYymDL9KdfC/4Cohhk+4z9Dml
	 EBG7xA+8X39q75KBB9/A5i6oxwiNZwYwXRpQ2rWRTx6KLlxlaSRSxXsmuv7QqAizM/
	 vz1NjCPVS48bA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Linux Team <linux-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v4 1/3] dt-bindings: net: fec: add pps channel property
Date: Fri,  4 Oct 2024 17:24:17 +0200
Message-Id: <20241004152419.79465-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004152419.79465-1-francesco@dolcini.it>
References: <20241004152419.79465-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fsl,pps-channel property to select where to connect the PPS signal.
This depends on the internal SoC routing and on the board, for example
on the i.MX8 SoC it can be connected to an external pin (using channel 1)
or to internal eDMA as DMA request (channel 0).

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v4: improve commit message and explain why this is needed, as requested by
    Conor Dooley.
v3: no changes
v2: no changes
---
 Documentation/devicetree/bindings/net/fsl,fec.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
index 5536c06139ca..24e863fdbdab 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -183,6 +183,13 @@ properties:
     description:
       Register bits of stop mode control, the format is <&gpr req_gpr req_bit>.
 
+  fsl,pps-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description:
+      Specifies to which timer instance the PPS signal is routed.
+    enum: [0, 1, 2, 3]
+
   mdio:
     $ref: mdio.yaml#
     unevaluatedProperties: false
-- 
2.39.5


