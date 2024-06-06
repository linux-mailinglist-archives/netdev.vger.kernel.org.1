Return-Path: <netdev+bounces-101316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE898FE1C8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE3D1F23BE6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85F14F9CF;
	Thu,  6 Jun 2024 08:54:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48892EAE6;
	Thu,  6 Jun 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664085; cv=none; b=GXSWNcE85O0bmt9XWnsGMjQUl8IdKJxNIDrqbAVb9bqfWyJOfg8CxeBoCeHGj2zfGuwVRZT50gJ+Au0fg/wP+pOrzkLSPqSW1mQkKpB2V5Z3CY2EclOHKuDy5Qa6jL92r6vW34wpIrpjEaasKMZU6k9inuKTSM4zl6q2l7NbFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664085; c=relaxed/simple;
	bh=hAqr40aLxM9Ss999aTo1EmdgF4JWFBEkKDHKpKlM5Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNIRipB1YICXeSvQA+x5UrMwokdcu9+/lL8szKsH5DTkKF2eT872FheFC7UgUdieiA5YVzViN5e1qmA2SnTGUX0PqLG/qjn0095bySi4Q47Puxu7UY+2mm5hE/SP1zk88gDzZiX7KB4rRpxWUbGdDn0CLFje3zbYw4MzrsEl6Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8tN-003vyy-DC; Thu, 06 Jun 2024 10:54:41 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8tM-002l3J-SQ; Thu, 06 Jun 2024 10:54:40 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 96F8D240054;
	Thu,  6 Jun 2024 10:54:40 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 28D6C240053;
	Thu,  6 Jun 2024 10:54:40 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id E553B379F6;
	Thu,  6 Jun 2024 10:54:39 +0200 (CEST)
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
Subject: [PATCH net-next 07/13] net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
Date: Thu,  6 Jun 2024 10:52:28 +0200
Message-ID: <20240606085234.565551-8-ms@dev.tdt.de>
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
X-purgate: clean
X-purgate-ID: 151534::1717664081-824B2642-649193BA/0/0
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The addr variable in gswip_port_fdb_dump() stores a mac address. Use
ETH_ALEN to make this consistent across other drivers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index 789b8a1076f1..c049f505fcc7 100644
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


