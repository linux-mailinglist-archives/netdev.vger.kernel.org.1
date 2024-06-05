Return-Path: <netdev+bounces-100874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F728FC6D4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9601B232BC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C11946CD;
	Wed,  5 Jun 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FVPItTTd"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509544962C;
	Wed,  5 Jun 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577034; cv=none; b=IfF+1/Hb+V2g29tpwltsm8fV6YdK5t6sHdsi2BfXP6ulfCODQTa20WZLBKOtKZ2k0peARbGh6km2SFHwK2m8i0F5l0drtB6nSLHDYdNsYXG70fbZ3+ByZdy6FkCHO/c5fbjpA+0Sx+QBOoA7lULyQeaVZfv9y8RSWHuoZ/O4hFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577034; c=relaxed/simple;
	bh=jZ//xqLY5MABrAu+hTMq7OGpEIr0joF93MaJu/Iw+4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SaJP3e+UktlSXyYj41ssQur7qlxHK99P5ewse4ZmG8jB2TWjQtqtdCSyMVUwWtvcHl6PqqRJ/8THgrY1Cg4bKeBi5gwvfwKbNk6fhdNSfXty8farH5Gesatq/XKqtZRusIauZcbS6cCwrbU4rKvv4XX4USRRwiUvvSLXcG886gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FVPItTTd; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7762EA0673;
	Wed,  5 Jun 2024 10:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=g8zm70D3lRPSYVdgRgWMFlw4wLi2O0HtRTHjaSgr9q0=; b=
	FVPItTTdNVcj+vJpv+0m6rnG7tOwf+ewvz9Ydm3KI+RuF/MB+vOBkDaSBCij3j6X
	9swGmLQxULBjyxwQ/aLNk8MLocORTNLqVceL3Wpa7jpQv04rnzsG196xViATpVcf
	86el0c+BNaOmymKHRT76h8v7GLuydDO2s4CzcL3Hr4Y2L2JVQzsWHPOsKvx4EKkI
	JowHDcqLNtZwQy9hVwV3IglIwKh1iuq1JLG557oNFjp0OTBWYViVgTvXor1F5zBZ
	NKjd71BoP1B7q6CGO+uByc1LUjx82eGXA6GxpJg1tSbZeBJwPE1mOEKOP2AxI5SH
	tiGsnfua/6qmm3krNnk8gjs+lR2qOsfArTC6RuTuITJ319Btnx+o/k3pPSa+Mdga
	j5DsQ0VxsxGPcEp+a+CEXkH2vgrRPDG1rrr5n0s6zC/PvRfy8dTuwtezLUpFTVZ8
	/CNEtpXzsPs9Fk/buGlmh87bSyFo9aICCTfDL14+FbDQ5kMfXKdJwuWoKoVwqthd
	uCsLKbu/mMS2+eVN/1I88L5zlEe+6pK66ZXOTSa44EJxr+GNA9Dep2E0psR1nuaj
	tROM+EjQI07PHOxOKiqEzHv2J3onU/qgh40okvO9RtrlKNOu8EyFEjNLeE1b3i0m
	4cQ4QxK0yhd9eWYDpc6u/A43ksdG4et/B32Wek5alQE=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Russell
 King" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH] net: sfp: Always call `sfp_sm_mod_remove()` on remove
Date: Wed, 5 Jun 2024 10:42:51 +0200
Message-ID: <20240605084251.63502-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1717577020;VERSION=7972;MC=1104090605;ID=105813;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A1295762776B

If the module is in SFP_MOD_ERROR, `sfp_sm_mod_remove()` will
not be run. As a consequence, `sfp_hwmon_remove()` is not getting
run either, leaving a stale `hwmon` device behind. `sfp_sm_mod_remove()`
itself checks `sfp->sm_mod_state` anyways, so this check was not
really needed in the first place.

Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
---
 drivers/net/phy/sfp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f75c9eb3958e..d999d9baadb2 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2418,8 +2418,7 @@ static void sfp_sm_module(struct sfp *sfp, unsigned int event)
 
 	/* Handle remove event globally, it resets this state machine */
 	if (event == SFP_E_REMOVE) {
-		if (sfp->sm_mod_state > SFP_MOD_PROBE)
-			sfp_sm_mod_remove(sfp);
+		sfp_sm_mod_remove(sfp);
 		sfp_sm_mod_next(sfp, SFP_MOD_EMPTY, 0);
 		return;
 	}
-- 
2.34.1



