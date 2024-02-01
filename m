Return-Path: <netdev+bounces-67916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D378455F6
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D571F28BDE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838BE15CD54;
	Thu,  1 Feb 2024 11:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374C158D9A
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785683; cv=none; b=ZtHVwQDvgzO2SOU80xb/skob+F/l6aa9ML/Yl4/cVG9eqdv/gaIPEab+/UG1ZE1GKAdSqduM+/Ww2nYopsT1snRktJGeKcDhDIu65GAX8802P7lKt4TYPWHoUe+DzwFhgS71GtArpp67GftpBdEjruxW/zCkM66hKwAXuIZM9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785683; c=relaxed/simple;
	bh=903/UUN7Gp3362R3ImecBjutWtzfdLiSfuT8IxppXDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iEY9/niayfHEKhQ36q/86Gpqm1/f1XD5LjWwdmYiXdq2Z/1KMJgt3vKx1M4UCz7hi6JNKUmzXLjlwFYMdleBc7Sj1dKGWIm1VDLuIe6oXCp8ioHuTnDu7sG3lXBT+GJhamjdh95FLelr4LjQdHbI7S2kCoYOfKwKjA3Q1u5PWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C59712c7d8d89318fb9d63b559.dip0.t-ipconnect.de [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 701F8FA9B3;
	Thu,  1 Feb 2024 12:07:59 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/4] batman-adv: Start new development cycle
Date: Thu,  1 Feb 2024 12:07:53 +0100
Message-Id: <20240201110756.29728-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201110756.29728-1-sw@simonwunderlich.de>
References: <20240201110756.29728-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version will contain all the (major or even only minor) changes for
Linux 6.9.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 870dcd7f1786..8ca854a75a32 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2024.0"
+#define BATADV_SOURCE_VERSION "2024.1"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.2


