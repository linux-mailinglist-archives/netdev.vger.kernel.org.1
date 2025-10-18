Return-Path: <netdev+bounces-230650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610DCBEC54E
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 04:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115D26E5983
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF321A449;
	Sat, 18 Oct 2025 02:31:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBA2A1CA;
	Sat, 18 Oct 2025 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754660; cv=none; b=L2oVvfphilFC5XnbnX5dZ6JarBi0kDZK2iABVn4uoK1cdMx1mykoJcnFF4+Nbu1CcvIYSa69Qdi1J7azojs84XB+07ow5L0mL+hE2Kchpq5Ma5ZQJQtvCE0uuSd1I6gOyCIBqzF4zIutW2tMPv/J4zekKE+OUqip43S98zKLivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754660; c=relaxed/simple;
	bh=dGLHpnOfSrFGVk1o2I1ecKIPDlTcUNmVZyhAjpteRe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3/Z7a6EaGVE1V6ohaOUM8tArGxiqx0ZOTfSi2/ib2DdTOH9gs88zqlIx6C6aGt+t5tCTLlkaEoN2lj+qGtTv8RYj8i7sWNHXK09KoExvOPVwyyrR53dLAUhugwYRR9nwbPyDU4pkCMDd1pSEltJcGKWHitkkB2jHDF3ag8FB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9wiS-000000002DF-09rA;
	Sat, 18 Oct 2025 02:30:44 +0000
Date: Sat, 18 Oct 2025 03:30:40 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-net v2 1/7] net: dsa: lantiq_gswip: clarify GSWIP 2.2
 VLAN mode in comment
Message-ID: <7135c0bd3df9f81e6d1124a822e765735fd77201.1760753833.git.daniel@makrotopia.org>
References: <cover.1760753833.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760753833.git.daniel@makrotopia.org>

The comment above writing the default PVID incorrectly states that
"GSWIP 2.2 (GRX300) and later program here the VID directly."
The truth is that even GSWIP 2.2 and newer maintain the behavior of
GSWIP 2.1 unless the VLANMD bit in PCE Global Control Register 1 is
set ("GSWIP2.2 VLAN Mode").
Fix the misleading comment accordingly.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 25f6b46957a0..86b410a40d32 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -588,7 +588,11 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr),
 			  GSWIP_PCE_VCTRL(port));
 
-	/* GSWIP 2.2 (GRX300) and later program here the VID directly. */
+	/* Note that in GSWIP 2.2 VLAN mode the VID needs to be programmed
+	 * directly instead of referencing the index in the Active VLAN Tablet.
+	 * However, without the VLANMD bit (9) in PCE_GCTRL_1 (0x457) even
+	 * GSWIP 2.2 and newer hardware maintain the GSWIP 2.1 behavior.
+	 */
 	gswip_switch_w(priv, idx, GSWIP_PCE_DEFPVID(port));
 }
 
-- 
2.51.1.dirty

