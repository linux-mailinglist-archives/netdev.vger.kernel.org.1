Return-Path: <netdev+bounces-102281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F990236B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AB7286C90
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E32D136E2E;
	Mon, 10 Jun 2024 14:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD5135A7E;
	Mon, 10 Jun 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028161; cv=none; b=Dom+fCLb+2CSiQwlGxB+xIYHlO/YTSgH/6xPpDJft/ReW84T+atU0H5SeT2aqo84r3tQyoZVrvAiBa7qGjVIwuqbFmmJRS1hVza48yYDTeoKo05M0MCSTtnNaOvn+wmKZebn9N2bAwscMn2gMXQM2FVXJrvpHVvD4/DFMz0I6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028161; c=relaxed/simple;
	bh=h/Ei+Yjui9isJ/5R/EECN7T9kfutV8lxqpWOiqpmr1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYOF9prs8YXMhEkLB8KQ8Q4i1yjnf22TcjzmSMTJkGOQZt4a3vzz/cwQZrwd4YtEnjTgPJdRN9wYDeTvNrXpNSIHSVV2WYZccyrz5N+A6xdIGnEjwHNUdevIegL5+4/99fxjjrC59LICKaJ1WSC53LB0cU8ao8h5VNPotpiyybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfbZ-00A3AU-Ne; Mon, 10 Jun 2024 16:02:37 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfbZ-001s1y-6Y; Mon, 10 Jun 2024 16:02:37 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E2132240053;
	Mon, 10 Jun 2024 16:02:36 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 77424240050;
	Mon, 10 Jun 2024 16:02:36 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 29A0236F2E;
	Mon, 10 Jun 2024 16:02:36 +0200 (CEST)
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
Subject: [PATCH net-next v3 01/12] dt-bindings: net: dsa: lantiq_gswip: Add missing CPU port phy-mode and fixed-link to example
Date: Mon, 10 Jun 2024 16:02:08 +0200
Message-ID: <20240610140219.2795167-2-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610140219.2795167-1-ms@dev.tdt.de>
References: <20240610140219.2795167-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718028157-34DF7522-1B3DA6DB/0/0
X-purgate-type: clean
X-purgate: clean

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


