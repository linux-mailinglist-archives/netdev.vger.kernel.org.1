Return-Path: <netdev+bounces-102239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2905D9020E2
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB2B28416D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEFB80045;
	Mon, 10 Jun 2024 11:55:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C38002A;
	Mon, 10 Jun 2024 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020521; cv=none; b=JT4p945NMulPPftR55ZFCB60ZjTuZoJcG0zX1YwOVaI5nJlA5nNgSdOkQRE7M5K/6pVEMgxYd2iGWNn40RWZ/U3gVeyVeA4YiS6g7edyyfH/ICW3YTtqo/VADKqB6/qePjwBG6e4TBrvlYPj8+E8Pm3/GKjjXMFRtgfRQztPlsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020521; c=relaxed/simple;
	bh=5mzS9U63qJYEr+djD+AKAUEckUE+rEYFhHHlVMt+kNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPLe7DWhrTNk9Q8zM9WmMvZeS/Hqak3Tk1EXKRJg3WG/9L5JOwiHVTX/L9ogDzO9bTjqj+TxVtpQ3smk21zsZy9GLw9suVDdYtTc8/xKjAZjWAucAYINss5UKfqJeVzLd7P3cJN4b4ba8eVoWj8eo42chaPaEJ9cAuZZQ9fzCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGdcM-00AE4D-8A; Mon, 10 Jun 2024 13:55:18 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGdcL-00Aikn-Ly; Mon, 10 Jun 2024 13:55:17 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 5B2A2240053;
	Mon, 10 Jun 2024 13:55:17 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E4FFE240050;
	Mon, 10 Jun 2024 13:55:16 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B7B3E26128;
	Mon, 10 Jun 2024 13:55:16 +0200 (CEST)
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
Subject: [PATCH net-next v2 08/12] net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
Date: Mon, 10 Jun 2024 13:53:56 +0200
Message-ID: <20240610115400.2759500-9-ms@dev.tdt.de>
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
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718020518-28CAA62D-BBAB8480/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The addr variable in gswip_port_fdb_dump() stores a mac address. Use
ETH_ALEN to make this consistent across other drivers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
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


