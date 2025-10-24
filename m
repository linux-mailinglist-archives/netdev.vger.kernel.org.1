Return-Path: <netdev+bounces-232401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F062C0557E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5363B039D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA7309F0E;
	Fri, 24 Oct 2025 09:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34BD306D26
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297812; cv=none; b=CA/ETTc5zd1w4Mt56Sjkmf0+iur6sv35zLmnxUpg/5AzRgjKM1M+9ucZ/LMjqbCDXjZT4DXmIZ1kDwaE8YX0HqZf93Thi6Y32WOja07upoGf8PS2aL2CNj6xZAWyp+TwZ0NphSNbbOzEvheeQtsgxFMuTl6uuzv7SbYjLLwTqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297812; c=relaxed/simple;
	bh=LqqjUNDHKWYYL+/DvZQKkZp54ecxzQcon9fi3gEdDLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZEKHmE+4RKtaA4M09+7GsnuZ1uvcNajkDEA7OUb6RLCT1RoTivLPT4AQMxImXWIiI5V+SfyqzwMcuuAIODEbJh+W66sidtnZ4MirVb3Jnogxl5INnscptLU0+uuCLf71DDKugf83KGF/cTlRlw7jODL7JPetzFOWvcIcXb7SiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5970781d8b076411bb4C554A3.dip0.t-ipconnect.de [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 970B0FA14B;
	Fri, 24 Oct 2025 11:23:28 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 1/2] batman-adv: Start new development cycle
Date: Fri, 24 Oct 2025 11:23:14 +0200
Message-ID: <20251024092315.232636-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024092315.232636-1-sw@simonwunderlich.de>
References: <20251024092315.232636-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version will contain all the (major or even only minor) changes for
Linux 6.19.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 2be1ac17acaa4..af230b017bc17 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.4"
+#define BATADV_SOURCE_VERSION "2025.5"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.47.3


