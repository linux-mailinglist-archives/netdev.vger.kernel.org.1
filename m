Return-Path: <netdev+bounces-102603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB63B903E26
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3DB2895D4
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C0717D898;
	Tue, 11 Jun 2024 13:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08517D891;
	Tue, 11 Jun 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114154; cv=none; b=O8Afa5yg6rVFpfHV5wOsuqSAZrrPIOCRCETqnjAMkdao7tWoLRdRyMTyUUo/O40F2vy6AeVwZiI0ulX0wsigTUgODY6aWcvvuoakO26FhWdYIKEnid9HQe2/kwzgkZ2FxLniX0ulU065fjFhl7gsJpFEJ6M+vbkeY7NMTdPeSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114154; c=relaxed/simple;
	bh=sNenjLkdEDNsS2T6eR6jONUUmRt4ZOGfPilabUzVC44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1JuHAmgb+gcpop6pKCNsp198VVfocg8DreXfG87JqV7298s3ufFoYEcfXQZX2H2SWOjdjS0DEnS60Yz7c0nyFfUoL63LtP7zRoibIDBB/FFP68Ld1DMCjCVFKpJmcKauVaOd368slBlUWbh70I8RZx/yJoFHuEC8sKKk1sKIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1yZ-00ABOa-1r; Tue, 11 Jun 2024 15:55:51 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1yY-003ICj-H4; Tue, 11 Jun 2024 15:55:50 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 3F4DA240053;
	Tue, 11 Jun 2024 15:55:50 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id CAC9E240050;
	Tue, 11 Jun 2024 15:55:49 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 8EB76376FA;
	Tue, 11 Jun 2024 15:55:49 +0200 (CEST)
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
Subject: [PATCH net-next v5 08/12] net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
Date: Tue, 11 Jun 2024 15:54:30 +0200
Message-ID: <20240611135434.3180973-9-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611135434.3180973-1-ms@dev.tdt.de>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718114151-80CBF642-7CA49305/0/0
X-purgate: clean
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The addr variable in gswip_port_fdb_dump() stores a mac address. Use
ETH_ALEN to make this consistent across other drivers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/net/dsa/lantiq_gswip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index 58c069f964dd..525a62a21601 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1413,7 +1413,7 @@ static int gswip_port_fdb_dump(struct dsa_switch *d=
s, int port,
 {
 	struct gswip_priv *priv =3D ds->priv;
 	struct gswip_pce_table_entry mac_bridge =3D {0,};
-	unsigned char addr[6];
+	unsigned char addr[ETH_ALEN];
 	int i;
 	int err;
=20
--=20
2.39.2


