Return-Path: <netdev+bounces-85117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5262F899857
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E441F21EF9
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F0156F41;
	Fri,  5 Apr 2024 08:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161615F304
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306758; cv=none; b=GyzDGaB7JYshvlt6T+joGlMZ6ZE0WT4Kr9QSH0YzVoZwtKacAchJRFefjOCq1E7X0kDAtaBmlOG8crMbW3aZFJXwYWRCzQVczykB3qAvLSmtrvA6Ajt6DrXsDZ/63HlFJIGoJmdYE4+kAMzPuTzm2uWGSuZiCI2T7cF4+QV6p3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306758; c=relaxed/simple;
	bh=zkk2yEVNFGcxBr/wL4dnTCOQ4szmJILPSs1/K/HP2pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVe5YMzqOqfyn3Bwcfl9Bw3c39Soe2ynTa+tAG6kvf4RaK4tNdgxQn8Y4hjxBwhn3mBnCwu3WK3Ns9BsNQZ6+1npkm/nHDL++TzXSwY/MgoIIsQldYaLbm906xSRWrPJ/lUmUJTNWQ+bww44Uo0kbwhf9z7YecL3dSCxkQRqBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p5de1fdf8.dip0.t-ipconnect.de [93.225.253.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6CBFEFA101;
	Fri,  5 Apr 2024 10:45:55 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/3] batman-adv: Start new development cycle
Date: Fri,  5 Apr 2024 10:45:47 +0200
Message-Id: <20240405084549.20003-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405084549.20003-1-sw@simonwunderlich.de>
References: <20240405084549.20003-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version will contain all the (major or even only minor) changes for
Linux 6.10.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 8ca854a75a32..3d4c36ae2e1a 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2024.1"
+#define BATADV_SOURCE_VERSION "2024.2"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.2


