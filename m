Return-Path: <netdev+bounces-117137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6411994CD33
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774191C20DA5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45F1191F97;
	Fri,  9 Aug 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YjcqWJJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EAA190047;
	Fri,  9 Aug 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195136; cv=none; b=cEanAKXT+1RgiQN2/WfBCV7FcsmWxAUpjT19eG0oinBhZ14bvY+fRRyEzHYR7KMsxfGS8o/SJPNaRhU7GrNMmb01z8lM6fP717tZjXaLOKQvtmITjmlU3adtanUbc8q7dJwwIw+vZMHT2d3fAbFLBrGvAgF7RGEy0z3GGsZxiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195136; c=relaxed/simple;
	bh=VqHU0VsOI9CjUOixVRHu+UzVLCWlfQ+f5ptq2gPCu68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxOm5nz4HKZojvLbO51nEzC0pdFXD2o562WSG3xdbu43iFoGM6V7N9Cp0pctDeG1wcjv6jMguA0otzvCOfDLHehHh7XjO5D0fYHjwpo7TjykcpvJ0Y/2DJr4Pq4qJZmXSjNqGmcll2V6U/iRuO32vZ0DkJ1EpPfjcn2C35PFwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YjcqWJJV; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E3A1F22256;
	Fri,  9 Aug 2024 11:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723195130;
	bh=9oKfdjQrtqrz8jcoWQ7rWOQgPGtJwLhkARzik2qT8Ug=; h=From:To:Subject;
	b=YjcqWJJVPYsyAyTcjBsFhpdGVgrgDjKFVFBP21JZsLtQBNZ95RpGpVOQyTB4yhSYx
	 YX7P8ZGCXtG/rcNZb2yi7VV0NolEGE0mArS23xKFrkBxVlFQ8ckKm+A7bLRFK0KOGb
	 kYcoAgNP6Imx+ze9WCsoIzPtypMKwBzW5ANDq3aGyGcC/az6IQOpb9UeVIoROhbi1p
	 2E4nfZMwN+vkpBW59ThRMbOcYhFyyezlUsBYl+yNufTphCw4JCGf2/+8LpTUrXyK1A
	 qf1RrD/OKPsL1s3zdI1Vp62TeyDGTRhyehDevmrF9p2M4YminazH3W+gp3ToaNmDMQ
	 +eeE+GbOB82MQ==
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
	Linux Team <linux-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: net: fec: add pps channel property
Date: Fri,  9 Aug 2024 11:18:42 +0200
Message-Id: <20240809091844.387824-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240809091844.387824-1-francesco@dolcini.it>
References: <20240809091844.387824-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fsl,pps-channel property to specify to which timer instance the PPS
channel is connected to.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
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
2.39.2


