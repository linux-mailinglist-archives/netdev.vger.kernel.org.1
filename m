Return-Path: <netdev+bounces-189169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B83AB0E56
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EFF4E0D3F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106B4278170;
	Fri,  9 May 2025 09:10:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFEF276026
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781850; cv=none; b=Jw2e2yhqkPPMqkBeNMPYtsaZhQRWmAEuNWOS+v1/cZ0nxjzKJP5NoTW7nrcqE/s1+XwYl5RbTrw9Z/aVwNeT0fonqO29iC1KfH36GWnYkRj2SLfTgfjdvE4CWUVM7mZPdUzk1hJ0TFUEvG2KAnc6CWmwKsb0WrLdgFB1/qDA8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781850; c=relaxed/simple;
	bh=g+jLUB8xP8PZmzoAUc8MeEZ7mhn2BUw+sO/iiWn9IDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GhwOBy71UD2yi6KVWMjLZd2o7u2M85B4tPqjR4Po3jlzrgd8xzrlBBPHfYWBMT1m9PgkP36W/9h8odNWweG3AZkzuMrlP0QuouB7dbgKz9HTd5AhpRLRySDkPeJ+Kava+lZnBjrcPLerlWa1qMb1vZCiUwu+RcrGs5lXlmFjEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C59736C7D829705D90aB67a755.dip0.t-ipconnect.de [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 4FA14FA374;
	Fri,  9 May 2025 11:10:46 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 5/5] batman-adv: Drop unused net_namespace.h include
Date: Fri,  9 May 2025 11:10:41 +0200
Message-Id: <20250509091041.108416-6-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

Since commit 69c7be1b903f ("rtnetlink: Pack newlink() params into struct"),
.newlink() doesn't use the struct net parameter. A type definition from
net_namespace.h is no longer needed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e48b683a033f..5bbc366f974d 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -36,7 +36,6 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <net/net_namespace.h>
 #include <net/netlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
-- 
2.39.5


