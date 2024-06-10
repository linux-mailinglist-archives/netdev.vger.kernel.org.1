Return-Path: <netdev+bounces-102232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF479020C4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686BEB266F7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3537E0E8;
	Mon, 10 Jun 2024 11:54:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF61DDCE;
	Mon, 10 Jun 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020484; cv=none; b=Zcrn2EP8Atlrz4mL73SLRcmAn1zEqtfhvUUwkltoPw8irrz8Ssg/GlEE5ylnjXdNvCkX8/XOwSNZYKnQnJfYhwmqa/XPOa7YjsXX1E2h0XQ6oks2P0S3w0V2DT5WwIbO5ut3E6xnqTtoRSFhN4Oqnb6sE7jGl4fTHFfK8ofc42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020484; c=relaxed/simple;
	bh=h/Ei+Yjui9isJ/5R/EECN7T9kfutV8lxqpWOiqpmr1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPzi/mA/2GWs7NAhbu4pI/B88DTHyW101k3iioaA5g42yRhoEHBdw32DJoj+/lf5dEC8RAKOyv6KLMSN/Md2N4ARkwBye2POLp76ToSRX8J6tYf0RdV20MRxwJ79N9jxCoUY11g4ENGNf5uEubf6DCn2a2dTIx1/27h6BDHVE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGdbl-00027O-0s; Mon, 10 Jun 2024 13:54:41 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGdbk-00ADoE-EA; Mon, 10 Jun 2024 13:54:40 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 177EF240053;
	Mon, 10 Jun 2024 13:54:40 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id A0ECE240050;
	Mon, 10 Jun 2024 13:54:39 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 490B426128;
	Mon, 10 Jun 2024 13:54:39 +0200 (CEST)
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
Subject: [PATCH net-next v2 01/12] dt-bindings: net: dsa: lantiq_gswip: Add missing CPU port phy-mode and fixed-link to example
Date: Mon, 10 Jun 2024 13:53:49 +0200
Message-ID: <20240610115400.2759500-2-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610115400.2759500-1-ms@dev.tdt.de>
References: <20240610115400.2759500-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718020480-016F6E81-3936FF28/0/0
X-purgate: clean
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The CPU port has to specify a phy-mode and either a phy or a fixed-link.
Since GSWIP is connected using a SoC internal protocol there's no PHY
involved. Add phy-mode =3D "internal" and a fixed-link to the example cod=
e
to describe the communication between the PMAC (Ethernet controller) and
GSWIP switch.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
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


