Return-Path: <netdev+bounces-101324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139608FE1F3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B663A1F27965
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9DE13DDBF;
	Thu,  6 Jun 2024 08:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520D13E02E;
	Thu,  6 Jun 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664148; cv=none; b=afI0RBLvxQrWjxF7kUtbVidfyjXbPCDu3Qm6MSp3XJYjExaB/DaR4BfsP6A2DjWTFnSdgyKdp+U49wsWG9p68QkYtyAEretlVdvflfDz4GXKGAIYYjZfSaPyma6v784Z/NgmOIYFbI1CkOVNioZsaEeVYLCZc667qz8FO9gR2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664148; c=relaxed/simple;
	bh=5SkCojbOupms9kdTbT85vRcF6Ax30rBWXXz0025LSO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zth3jaADglqVW0iAhurBfuIz2nvcgzcSP+LVcRZHOWtMRd4NOjfHxJEd0dEvnfQlHiYdI5YqoGRd3wRYeR2wtoog3LT7hx0uvyp3OpmXUFogL6ITzn/jqIRaL9I6uOzYmCnsR2+U7EPt1a1YWTsyf4nOU9PEA9pREXFOtuy4VX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8si-008wh2-Uz; Thu, 06 Jun 2024 10:54:01 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8si-002ket-B6; Thu, 06 Jun 2024 10:54:00 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 114DF240053;
	Thu,  6 Jun 2024 10:54:00 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 95F92240050;
	Thu,  6 Jun 2024 10:53:59 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 47359379F6;
	Thu,  6 Jun 2024 10:53:59 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com,
	hauke@hauke-m.de,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/13] dt-bindings: net: dsa: lantiq_gswip: Add missing phy-mode and fixed-link
Date: Thu,  6 Jun 2024 10:52:22 +0200
Message-ID: <20240606085234.565551-2-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606085234.565551-1-ms@dev.tdt.de>
References: <20240606085234.565551-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1717664040-AF4A7257-89460A7D/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The CPU port has to specify a phy-mode and either a phy or a fixed-link.
Since GSWIP is connected using a SoC internal protocol there's no PHY
involved. Add phy-mode =3D "internal" and a fixed-link to describe the
communication between the PMAC (Ethernet controller) and GSWIP switch.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt b=
/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
index 8bb1eff21cb1..e81ba0e0da0f 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
@@ -96,7 +96,13 @@ switch@e108000 {
=20
 		port@6 {
 			reg =3D <0x6>;
+			phy-mode =3D "internal";
 			ethernet =3D <&eth0>;
+
+			fixed-link {
+				speed =3D <1000>;
+				full-duplex;
+			};
 		};
 	};
=20
--=20
2.39.2


