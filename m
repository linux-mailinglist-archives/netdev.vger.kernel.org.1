Return-Path: <netdev+bounces-28160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B165C77E6AF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9469D1C2117A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC16174E6;
	Wed, 16 Aug 2023 16:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A63174D9
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:10 +0000 (UTC)
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 09:40:09 PDT
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D3199B
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:09 -0700 (PDT)
Received: from kero.packetmixer.de (p200300FA272a67000Bb2D6DcAf57D46E.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 4E9A2FB5CA;
	Wed, 16 Aug 2023 18:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204003; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW70VC8neWnWOII3gWAKEJvTBQed0PVoEJYqOOj4oac=;
	b=0pgIlluFbyenkLOXiV2hFNdxgWMSmASEV6FNzo35RFKowAvP+t1JFk9FBL4U1Xn/4HFr3r
	GtO0f8foQAXJ5j7vr3xWz4bApaZDyknwvfA24EbpQ8napChEui9eWw+w41DK+qDJAAjpmz
	pj6EW+x2RmBIMe5DMt7RI8fz5ZnsACKc8oxSiQwx2HdZ1rA/odUA9O1Czhr8WEvv3/Lw7e
	xA7z0JHwXkeSg1xJ+tYvk2P2dtyFj2kFfa27cZ36VjFFkpYrSLLeNJEuI0DDLORnU04rvS
	YlOYztjqeSxdQk5f5NfFZ6ux5Jh7JLA2MI82AicMjLiO/bXhqjEIKxnn2RFQ8A==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5/7] batman-adv: Drop unused function batadv_gw_bandwidth_set
Date: Wed, 16 Aug 2023 18:39:58 +0200
Message-Id: <20230816164000.190884-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816164000.190884-1-sw@simonwunderlich.de>
References: <20230816164000.190884-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204003;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW70VC8neWnWOII3gWAKEJvTBQed0PVoEJYqOOj4oac=;
	b=n7+iRaexOwST9/xzbZzXws23EGdRsfsehX9ut+4V4rSH/j5kompevJUhBrqRX+didg+zQ7
	JtJMTMNgZk6Bh9EEJBeNx1fJLUzWW53S1Zv8poXf3AnGy5DDG+V6QQXxkZgcwsPCivn+dc
	Zur9jwlHznaDfY0j/NpSSGVJHV3kv9GCPXUqUKefU73cSLkNPvUYW95mlLv6N3RJhTHgsG
	hlVrSrhDjh9ucPLtQtCmGXP6Xqm0Z4j4irPW2GJ54PWktQqbzR40H1es5UTNdaXfjkjGrF
	zbcfTsWYJTuPD8fc2Tk1lAdswBBip7r8w79zm8qbTkXnmI6Mv4NszOfM3k0DQQ==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204003; a=rsa-sha256;
	cv=none;
	b=NRDQZmqNZwJ06vtJR14s2Kbiu8ZY4LL+IwRIDvE99fs8e8XzOic/nzmEYaCpPgkWKIZ7gjeraxR2qotACDtzy4iaZyYf4ISg8ZDTBaFpzgXlPtrdjFcV+vEL6ZXbay8/4DWNQ7SToLz1AwjyY4jCXYRq4BsQFnhOlhbknMttX12JGpt4SKymONa8BGSd7SnBnizzruO/u2aoqp9w5C6f2LUQj44sArAz9SkyMwc+BH2HJ0uJ8x5+1ztNrea2h+gJ/wAZzIc55vcnILmurk+doqeIbYs6W3DLK4kFS9xiy6gX+R6NLza1nxz59O12HUUlZ3Yynaq2dCMlmPhi2KjtxQ==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sven Eckelmann <sven@narfation.org>

This function is no longer used since the sysfs support was removed from
batman-adv.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/gateway_common.c | 88 ---------------------------------
 net/batman-adv/gateway_common.h |  2 -
 2 files changed, 90 deletions(-)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 6a964a773f57..d9632607f92b 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -9,7 +9,6 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
-#include <linux/errno.h>
 #include <linux/kstrtox.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
@@ -90,42 +89,6 @@ bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
 	return true;
 }
 
-/**
- * batadv_parse_gw_bandwidth() - parse supplied string buffer to extract
- *  download and upload bandwidth information
- * @net_dev: the soft interface net device
- * @buff: string buffer to parse
- * @down: pointer holding the returned download bandwidth information
- * @up: pointer holding the returned upload bandwidth information
- *
- * Return: false on parse error and true otherwise.
- */
-static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
-				      u32 *down, u32 *up)
-{
-	char *slash_ptr;
-	bool ret;
-
-	slash_ptr = strchr(buff, '/');
-	if (slash_ptr)
-		*slash_ptr = 0;
-
-	ret = batadv_parse_throughput(net_dev, buff, "download gateway speed",
-				      down);
-	if (!ret)
-		return false;
-
-	/* we also got some upload info */
-	if (slash_ptr) {
-		ret = batadv_parse_throughput(net_dev, slash_ptr + 1,
-					      "upload gateway speed", up);
-		if (!ret)
-			return false;
-	}
-
-	return true;
-}
-
 /**
  * batadv_gw_tvlv_container_update() - update the gw tvlv container after
  *  gateway setting change
@@ -155,57 +118,6 @@ void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 	}
 }
 
-/**
- * batadv_gw_bandwidth_set() - Parse and set download/upload gateway bandwidth
- *  from supplied string buffer
- * @net_dev: netdev struct of the soft interface
- * @buff: the buffer containing the user data
- * @count: number of bytes in the buffer
- *
- * Return: 'count' on success or a negative error code in case of failure
- */
-ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
-				size_t count)
-{
-	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	u32 down_curr;
-	u32 up_curr;
-	u32 down_new = 0;
-	u32 up_new = 0;
-	bool ret;
-
-	down_curr = (unsigned int)atomic_read(&bat_priv->gw.bandwidth_down);
-	up_curr = (unsigned int)atomic_read(&bat_priv->gw.bandwidth_up);
-
-	ret = batadv_parse_gw_bandwidth(net_dev, buff, &down_new, &up_new);
-	if (!ret)
-		return -EINVAL;
-
-	if (!down_new)
-		down_new = 1;
-
-	if (!up_new)
-		up_new = down_new / 5;
-
-	if (!up_new)
-		up_new = 1;
-
-	if (down_curr == down_new && up_curr == up_new)
-		return count;
-
-	batadv_gw_reselect(bat_priv);
-	batadv_info(net_dev,
-		    "Changing gateway bandwidth from: '%u.%u/%u.%u MBit' to: '%u.%u/%u.%u MBit'\n",
-		    down_curr / 10, down_curr % 10, up_curr / 10, up_curr % 10,
-		    down_new / 10, down_new % 10, up_new / 10, up_new % 10);
-
-	atomic_set(&bat_priv->gw.bandwidth_down, down_new);
-	atomic_set(&bat_priv->gw.bandwidth_up, up_new);
-	batadv_gw_tvlv_container_update(bat_priv);
-
-	return count;
-}
-
 /**
  * batadv_gw_tvlv_ogm_handler_v1() - process incoming gateway tvlv container
  * @bat_priv: the bat priv with all the soft interface information
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 87c37f907261..cb2e72d7ab14 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -27,8 +27,6 @@ enum batadv_bandwidth_units {
 #define BATADV_GW_MODE_CLIENT_NAME	"client"
 #define BATADV_GW_MODE_SERVER_NAME	"server"
 
-ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
-				size_t count);
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv);
 void batadv_gw_init(struct batadv_priv *bat_priv);
 void batadv_gw_free(struct batadv_priv *bat_priv);
-- 
2.39.2


