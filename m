Return-Path: <netdev+bounces-102288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13926902384
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FE828A76A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F05213DDCD;
	Mon, 10 Jun 2024 14:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46CF14A4E2;
	Mon, 10 Jun 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028196; cv=none; b=D9vHSHZ8eVG3pMnccW6fxl5EhI6J+xR4luaNJ2jX6LvcJ7+a/h/c5fTVZ+aPDBXMhp47uN2HjhNxDJ+aNWS88H+22iGnwcSEKD8SYOKndBHqQoRMO+FzP1W5ilCJE0GU/ErPRhQBp3zRT8rQf9TTQ1RLk9/SJk1f45Ou5BcPRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028196; c=relaxed/simple;
	bh=5mzS9U63qJYEr+djD+AKAUEckUE+rEYFhHHlVMt+kNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juxoBlztMOAArXSBDSmPruJglRFbdvxOWlbCaSLkIcnjEHgTmPJHuqZOTqEcQOOgAXG30Xnrbzfc9sEVl7e119fglZTXPyg6114u4OkmShQhYbYqirgfbbiq1LhdVutSaRXpcF8cFWGbkidOTURLkkwx+UvFQuZb29Vb2WB718g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfc8-00C8bt-Kh; Mon, 10 Jun 2024 16:03:12 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfc8-006WY4-3m; Mon, 10 Jun 2024 16:03:12 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id CF570240054;
	Mon, 10 Jun 2024 16:03:11 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 6300E240053;
	Mon, 10 Jun 2024 16:03:11 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 3029436F2E;
	Mon, 10 Jun 2024 16:03:11 +0200 (CEST)
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
Subject: [PATCH net-next v3 08/12] net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
Date: Mon, 10 Jun 2024 16:02:15 +0200
Message-ID: <20240610140219.2795167-9-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1718028192-90C5134D-486F9970/0/0
X-purgate-type: clean
X-purgate: clean

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


