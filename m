Return-Path: <netdev+bounces-101320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D606F8FE1D4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63158284BE5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270C1474BD;
	Thu,  6 Jun 2024 08:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4629513D8AE;
	Thu,  6 Jun 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664101; cv=none; b=HuKmF2IbXiAVg8woW+7MoBCpeYX7Bk1uJfuNYNc+YGbNKb/849WpZ/DDRM/UNHMp7VwEmsA3kOkV2kW9kzUtkLDHvEW5Z4hqnVfOUAwSNzjcK/67rU75AP6oeg60NAkQTWVMbkPn/odCAMNM4f7eNIGZHb4nnvij0lyvgwXYMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664101; c=relaxed/simple;
	bh=KYnzf2IvAqkR+TMZf28aEgu6bpbKnDGL8pVsCkiQRq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+zIFN0hmFol8Ai66kWCGap/u8pJGTA3uzxpi9Ybv0t74ALJpra/NrJFaGeyjF5RQWWV5sKiJgVOIrGvwlV8T3HUt5V2FRyExY5+7mAYZfSyqURN0rmpa7fxM3UOLA+5vBJjMGxlfEBSNLQoK+M5m288JKGdZDEq7x8dPBgsInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8te-00EUz7-7r; Thu, 06 Jun 2024 10:54:58 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8td-00EK6Z-MQ; Thu, 06 Jun 2024 10:54:57 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 6C6B9240053;
	Thu,  6 Jun 2024 10:54:57 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 03993240050;
	Thu,  6 Jun 2024 10:54:57 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id ACCFC379F6;
	Thu,  6 Jun 2024 10:54:56 +0200 (CEST)
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
	Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next 11/13] net: dsa: lantiq_gswip: Fix comments in gswip_port_vlan_filtering()
Date: Thu,  6 Jun 2024 10:52:32 +0200
Message-ID: <20240606085234.565551-12-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1717664098-EEC7DADA-81332706/0/0

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
index 3c96a62b8e0a..f2faee112e33 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -786,7 +786,7 @@ static int gswip_port_vlan_filtering(struct dsa_switc=
h *ds, int port,
 	}
=20
 	if (vlan_filtering) {
-		/* Use port based VLAN tag */
+		/* Use tag based VLAN */
 		gswip_switch_mask(priv,
 				  GSWIP_PCE_VCTRL_VSR,
 				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
@@ -795,7 +795,7 @@ static int gswip_port_vlan_filtering(struct dsa_switc=
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


