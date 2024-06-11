Return-Path: <netdev+bounces-102553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B016903AC8
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F3FB26A25
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10917F37C;
	Tue, 11 Jun 2024 11:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427617F369;
	Tue, 11 Jun 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106116; cv=none; b=E+/mW2nrwk1pNwsvfVSIoWWpWEGEVQr/o3DEsLPziL9bKkUX9wJboJg2xws3i7n1AXBy+gIM7WNFI1oHm37R/pnuF0Z7McA2EU76ktjL3w9FgmSzHicghjzm6Ctitr4nMbBC6mT666bFrxfh3oPZu3RWwjl9a2NDDvtUzwcb3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106116; c=relaxed/simple;
	bh=I3jDDLhhE9CvNnNbIVh6mYYXoYpZ6qnnBn0WuqEZwZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh4wqNCS+vQL4sT4lCJZnKm6xSxmj+kHlwAQPCZeIgb38FlFCiVw/dzGnXJopEYmXl9Vq51Fv5yH74BmbDlFvjATnd9BPmOH0zMGA6IapMgiiRvcolQo1N4hda2Cn3y9Nr4zQMvgMUBDEmm892dB/sSXedLklWqA4DJpdRKa+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sGzsu-002Z0t-Vj; Tue, 11 Jun 2024 13:41:53 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGzsu-001L8n-DI; Tue, 11 Jun 2024 13:41:52 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 1C8F6240053;
	Tue, 11 Jun 2024 13:41:52 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id A2F3F240050;
	Tue, 11 Jun 2024 13:41:51 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 0DC6629768;
	Tue, 11 Jun 2024 13:41:51 +0200 (CEST)
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
Subject: [PATCH net-next v4 12/13] net: dsa: lantiq_gswip: Update comments in gswip_port_vlan_filtering()
Date: Tue, 11 Jun 2024 13:40:26 +0200
Message-ID: <20240611114027.3136405-13-ms@dev.tdt.de>
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
X-purgate-type: clean
X-purgate-ID: 151534::1718106112-14A01D11-26A7E30E/0/0
X-purgate: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Update the comments in gswip_port_vlan_filtering() so it's clear that
there are two separate cases, one for "tag based VLAN" and another one
for "port based VLAN".

Suggested-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
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


