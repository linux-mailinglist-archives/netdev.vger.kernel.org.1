Return-Path: <netdev+bounces-151976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC19F21BF
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 03:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415FC1886F10
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187846FBF;
	Sun, 15 Dec 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Nc9GBSvF"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5F79CF;
	Sun, 15 Dec 2024 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734229590; cv=none; b=ZZM+me/vQWTgduZWP51S2C9QFN8blbJNJxEpUGE/2Sq5F4A4UOofrz2Ly2Ed/mjyKh0QS22jVsN8XoZre0hT8PyHQM2MNiYPBu3SIzQrnVa/uNUP+aR5UIKd2JpTznRJ5faf7m2sEiq/W6na8OTaff69UjfCU2jOQXAeEAIWsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734229590; c=relaxed/simple;
	bh=Ldn6CTUjryaD3q08oP5hnRDfoH4SLjS9R2cQ6xQPXZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MubMCYpL/E7CUsvLFf+rU7s8aKTBSlZxsZZptMtVMAXD6rgn3IpPyllB1+Xq4tCG+/jGFbRDidto5spLo735qAuPGcMHwgblSj+MZZS14LNSsmMLBV5cc19BvTF9j2fm4Qq3tErVFGSgyOJacNoKWjtQ+ZD9uUqAceMi2VQa7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Nc9GBSvF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=xWgFc3JYDQAwYvHwwdvWJleePGeQwga9IFxSxRCkdV0=; b=Nc9GBSvF6qPDGEhI
	ie+SdI5lOOoXJQPP/4p69cMXKGh9XTCBPUJ4SgXRXzK2MpSmcEHy5VIa3inXcLTe9KAlGzfWUv4sO
	n9grQ7gqTF1HXFG1AIPAZkQmGWaWVB+qTpVILEAZe4e+auLKq3O/PHptroq0bw5euyeP8Zc3duvjh
	YV8Rl3hSSdnvIakYTh++WGYmMv9RkZo/N7FKAOozqljHrpxml58azShgIBLb3Q46rpgXocF6+fm7v
	vMOJUcmAG53WmiooQI1CKoFy3Ym1/KU6nXM+qM7qSkOlATi2P11SntsU1e4ioaZXsxtoAW0UbdLoa
	Dqe+Hpt/1zf02bpvIg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tMeKq-005RGe-1F;
	Sun, 15 Dec 2024 02:26:20 +0000
From: linux@treblig.org
To: jes@trained-monkey.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-hippi@sunsite.dk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] hippi: Remove unused hippi_neigh_setup_dev
Date: Sun, 15 Dec 2024 02:26:18 +0000
Message-ID: <20241215022618.181756-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

hippi_neigh_setup_dev() has been unused since
commit e3804cbebb67 ("net: remove COMPAT_NET_DEV_OPS")

Remove it.

(I'm a little suspicious it's the only setup call removed
by that previous commit?)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/hippidevice.h |  1 -
 net/802/hippi.c             | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/hippidevice.h b/include/linux/hippidevice.h
index 07414c241e65..404bd5b2b4fc 100644
--- a/include/linux/hippidevice.h
+++ b/include/linux/hippidevice.h
@@ -33,7 +33,6 @@ struct hippi_cb {
 
 __be16 hippi_type_trans(struct sk_buff *skb, struct net_device *dev);
 int hippi_mac_addr(struct net_device *dev, void *p);
-int hippi_neigh_setup_dev(struct net_device *dev, struct neigh_parms *p);
 struct net_device *alloc_hippi_dev(int sizeof_priv);
 #endif
 
diff --git a/net/802/hippi.c b/net/802/hippi.c
index 1997b7dd265e..5e02ec1274a1 100644
--- a/net/802/hippi.c
+++ b/net/802/hippi.c
@@ -126,21 +126,6 @@ int hippi_mac_addr(struct net_device *dev, void *p)
 }
 EXPORT_SYMBOL(hippi_mac_addr);
 
-int hippi_neigh_setup_dev(struct net_device *dev, struct neigh_parms *p)
-{
-	/* Never send broadcast/multicast ARP messages */
-	NEIGH_VAR_INIT(p, MCAST_PROBES, 0);
-
-	/* In IPv6 unicast probes are valid even on NBMA,
-	* because they are encapsulated in normal IPv6 protocol.
-	* Should be a generic flag.
-	*/
-	if (p->tbl->family != AF_INET6)
-		NEIGH_VAR_INIT(p, UCAST_PROBES, 0);
-	return 0;
-}
-EXPORT_SYMBOL(hippi_neigh_setup_dev);
-
 static const struct header_ops hippi_header_ops = {
 	.create		= hippi_header,
 };
-- 
2.47.1


