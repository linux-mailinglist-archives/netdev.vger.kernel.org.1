Return-Path: <netdev+bounces-189165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B79AB0E4F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135984C6498
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F227585D;
	Fri,  9 May 2025 09:10:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64925274FE5
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781847; cv=none; b=ofVLjIBe1ithseiqAWniEXvpkEwtI6XfCebsfX+09/CPJDmAX7+br6s19cdgRAF0oIQfZWkm5+9Om01cyUMzHjQnODCEZ2R3Qhr/b+t1rCos7Ul6Y6//WXjBRMP+mzl215e+s47IXMyrTcP4ABZOpZF9Vd91xhyedTVSRw1+03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781847; c=relaxed/simple;
	bh=5SJSQalMaw2chFTXxXGyj+dU18v8dfgSuEPFX2SlVIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koAxo3OZo8/3WNt6hq/AMA0w9wZ0HdQLoS2dWRaVVh2q2mhF0qx1iW2C59aDbvi1jgIqkXXSvsHMsqDL/EtnSNd/wT5YwSouTnnNsh2JJmli7Q0tWVZ6DHO+YmEcwR5GhPz97IFj4I1GVbxiLboG1dxAUE8wTxENnWkCQ5Gpan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59736c7D829705d90AB67A755.dip0.t-ipconnect.de [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 484FEFA132;
	Fri,  9 May 2025 11:10:43 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 1/5] batman-adv: Start new development cycle
Date: Fri,  9 May 2025 11:10:37 +0200
Message-Id: <20250509091041.108416-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509091041.108416-1-sw@simonwunderlich.de>
References: <20250509091041.108416-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version will contain all the (major or even only minor) changes for
Linux 6.16.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 67af435ee04e..4b5ce8972848 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.1"
+#define BATADV_SOURCE_VERSION "2025.2"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.5


