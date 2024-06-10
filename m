Return-Path: <netdev+bounces-102291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A79190238C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FE21F25CB8
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6614F135;
	Mon, 10 Jun 2024 14:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391013F437;
	Mon, 10 Jun 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028211; cv=none; b=WnaTuT4dbQLsDC7kluXOXuyoNb85DLYXnPLh20iBpmXwkGG5yZewYPfyOscxCe8tj16OviwL511jlItNJba8IC6/lxqmTnecDKdhz3qBKyR29qddBm0wURXwjWW9s7dTt0tg/DJp+H3vyjHTqqPlJ9G5B1gTBPabIakv6I33dfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028211; c=relaxed/simple;
	bh=qC4T/GQOiYzvb7nkwwoepLv8iceGjDKj4gsAlQ5oknE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcLrFwCTN8WIKVs+XrnAOuug1stfkLyHIiPYS4Li6yO2Q7P/yqGdkcs6XXELrWdi3Q6pqtN/8DAM9sQvwmRaVyNpwIupQWTT9+v1cJUBow+bfS/SLlmFqW0yJ7Ow/LpiGkV272RWUIL/NNo86jbU1ZDc7uCVLHsfoaq+wJ/PlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfcN-001sTs-U0; Mon, 10 Jun 2024 16:03:27 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfcN-00C8eG-CH; Mon, 10 Jun 2024 16:03:27 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 138F6240053;
	Mon, 10 Jun 2024 16:03:27 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 9F869240050;
	Mon, 10 Jun 2024 16:03:26 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 5A75C36F2E;
	Mon, 10 Jun 2024 16:03:26 +0200 (CEST)
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
Subject: [PATCH net-next v3 11/12] net: dsa: lantiq_gswip: Update comments in gswip_port_vlan_filtering()
Date: Mon, 10 Jun 2024 16:02:18 +0200
Message-ID: <20240610140219.2795167-12-ms@dev.tdt.de>
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
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1718028207-83CB5642-A622B1AD/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Update the comments in gswip_port_vlan_filtering() so it's clear that
there are two separate cases, one for "tag based VLAN" and another one
for "port based VLAN".

Suggested-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index 2bbc7dd45418..ec52c62eadce 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -780,7 +780,7 @@ static int gswip_port_vlan_filtering(struct dsa_switc=
h *ds, int port,
 	}
=20
 	if (vlan_filtering) {
-		/* Use port based VLAN tag */
+		/* Use tag based VLAN */
 		gswip_switch_mask(priv,
 				  GSWIP_PCE_VCTRL_VSR,
 				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
@@ -789,7 +789,7 @@ static int gswip_port_vlan_filtering(struct dsa_switc=
h *ds, int port,
 		gswip_switch_mask(priv, GSWIP_PCE_PCTRL_0_TVM, 0,
 				  GSWIP_PCE_PCTRL_0p(port));
 	} else {
-		/* Use port based VLAN tag */
+		/* Use port based VLAN */
 		gswip_switch_mask(priv,
 				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
 				  GSWIP_PCE_VCTRL_VEMR,
--=20
2.39.2


