Return-Path: <netdev+bounces-67919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CCE8455F9
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D5D1C238C6
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2815CD7B;
	Thu,  1 Feb 2024 11:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FAB3A1C3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785684; cv=none; b=rlQJ+mQLtZRRFMNCdhxT+9OadVHMvNBOBQdFiCF029PEMmY4R+heWrNbteHihQWr35lgrjO9nTgdevgZtrTjvCtAmBFM9t13vRbKcRYEXRQpGmTPR+0p8GcVLRKTjGxgO7nlFGr9aykWc40YXlyz7YCOnhwMtXoqx62BNulZT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785684; c=relaxed/simple;
	bh=yCvmMvZo4d1/zf+xOeRi/KRoYe2vtL1q4mf2G69SU90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxat0/+xjoh3eKVt6W8pK42JHxlMykGSRYAG5gNmru8pqENiKNmAlhACRDN6AQ+7LX1QY+udkiHqoQWmDLpda47wqI6aNxe191TH6aVQAapPJCzENynCh4LaV8ik3GO9Acuhvm6tIFtG01NugztgfUBvdVzQHLNUxCIqNxcXqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59712C7d8D89318FB9D63B559.dip0.t-ipconnect.de [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id A6904FA9B6;
	Thu,  1 Feb 2024 12:08:00 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/4] batman-adv: Drop usage of export.h
Date: Thu,  1 Feb 2024 12:07:56 +0100
Message-Id: <20240201110756.29728-5-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

The linux/export.h include was introduced in commit 9bcb94c8617e
("batman-adv: Introduce missing headers for genetlink restructure") to have
access to THIS_MODULE. But with commit 5b20755b7780 ("init: move
THIS_MODULE from <linux/export.h> to <linux/init.h>"), it was moved and the
include for export.h is no longer needed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1f7ed9d4f6fd..0954757f0b8b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -15,7 +15,6 @@
 #include <linux/cache.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/export.h>
 #include <linux/genetlink.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
-- 
2.39.2


