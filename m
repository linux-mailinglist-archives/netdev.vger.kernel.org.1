Return-Path: <netdev+bounces-102242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DFE9020EE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35080286566
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F61D80BF5;
	Mon, 10 Jun 2024 11:55:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB87E78E;
	Mon, 10 Jun 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020541; cv=none; b=XT/KRqGa5OnnA6SN+GYcvGOduyoWaJj+rlA54Un35acA9iMyv8TNS2iSW4kPSkDzLNYrMmIq4jQNeiiqNj6uH2s2FABa1VPjR6AQNxqTtGxtIzIglbrgqJD9Azo3kTVV0LpMsz77TJAdsoEX9+TkL4K3OvIjRB9YWaUHm+q7vRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020541; c=relaxed/simple;
	bh=d3FLFCLYnnnPpoRRDa2yuCWPCF9Q7F6Aj01GeLQTMJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn6KUtxfnBOuWskLTc9vMYRYwDZxjN1qqkI1LHLV7J25xdkvCY+2uR5siwUyvRbx819vzRwFjTJerPmPzMG/P+0Uqe/PeBcZfs+wEkWDVXS5QjaZFCtcNdedA+fztfkesnkPKjpRIHCnDlIxWS2jNEUiTT3PucwF7iHgmY58Oog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGdcg-009BZJ-AD; Mon, 10 Jun 2024 13:55:38 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGdcf-005Z5P-On; Mon, 10 Jun 2024 13:55:37 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 77C5F240053;
	Mon, 10 Jun 2024 13:55:37 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 0E3C4240050;
	Mon, 10 Jun 2024 13:55:37 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B29F426128;
	Mon, 10 Jun 2024 13:55:36 +0200 (CEST)
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
Subject: [PATCH net-next v2 11/12] net: dsa: lantiq_gswip: Update comments in gswip_port_vlan_filtering()
Date: Mon, 10 Jun 2024 13:53:59 +0200
Message-ID: <20240610115400.2759500-12-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1718020538-37115522-D0BB847F/0/0

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
index ea079d1a31e4..2aa9381dac41 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -781,7 +781,7 @@ static int gswip_port_vlan_filtering(struct dsa_switc=
h *ds, int port,
 	}
=20
 	if (vlan_filtering) {
-		/* Use port based VLAN tag */
+		/* Use tag based VLAN */
 		gswip_switch_mask(priv,
 				  GSWIP_PCE_VCTRL_VSR,
 				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
@@ -790,7 +790,7 @@ static int gswip_port_vlan_filtering(struct dsa_switc=
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


