Return-Path: <netdev+bounces-102541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E442F903A9D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B9A284CED
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C317C9E5;
	Tue, 11 Jun 2024 11:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F717C230;
	Tue, 11 Jun 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106061; cv=none; b=VnhNGc4olnqQ9azm4JVefRVhGC8I30/Egn6W8AMkT89/DH9ZgS882yfaZ3Ug7foXgcD82h/2gc95waomTtH773V8UMHbnQCJv1vEiTbXEtXdU4SWxAMgDI+uTnxXbtIUrFjrC8W0YQoI4wefi0Ity2iOqPOnPJJZlq3t4XQ9nxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106061; c=relaxed/simple;
	bh=J+ShQcSfMFQua/iBu3F7P2z4tGMB8EjLrHd4X8I8gFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eP69AE4i303IhuGeGcigWUMEhq5Nxo4q3YiZSq/gx3HCWSPbL6tLJig7RGWlv8ixLNM65G9x3k2ISocxtckKdlq8sODG5swh5C8GrwjOFvH+xlKDSkhFR3NWhotDoAq80eHju/EFsQFnQzr5OQiZkTeKGejEOlzRTKme6K7oQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sGzs2-0026WB-0I; Tue, 11 Jun 2024 13:40:58 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGzs1-0026W3-FV; Tue, 11 Jun 2024 13:40:57 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 375F2240053;
	Tue, 11 Jun 2024 13:40:57 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id C3703240050;
	Tue, 11 Jun 2024 13:40:56 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 7698829768;
	Tue, 11 Jun 2024 13:40:56 +0200 (CEST)
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
	linux-kernel@vger.kernel.org,
	ms@dev.tdt.de
Subject: [PATCH net-next v4 02/13] dt-bindings: net: dsa: lantiq,gswip: Add missing CPU port phy-mode and fixed-link to example
Date: Tue, 11 Jun 2024 13:40:16 +0200
Message-ID: <20240611114027.3136405-3-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611114027.3136405-1-ms@dev.tdt.de>
References: <20240611114027.3136405-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718106057-A906B34D-D17775D9/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The CPU port has to specify a phy-mode and either a phy or a fixed-link.
Since GSWIP is connected using a SoC internal protocol there's no PHY
involved. Add phy-mode =3D "internal" and a fixed-link to the example cod=
e
to describe the communication between the PMAC (Ethernet controller) and
GSWIP switch.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml =
b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 14ef48d6a0ee..234ad3b88dfe 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -146,7 +146,13 @@ examples:
=20
                     port@6 {
                             reg =3D <0x6>;
+                            phy-mode =3D "internal";
                             ethernet =3D <&eth0>;
+
+                            fixed-link {
+                                    speed =3D <1000>;
+                                    full-duplex;
+                            };
                     };
             };
=20
--=20
2.39.2


