Return-Path: <netdev+bounces-206380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB56B02CFD
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735B5178940
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CA226D04;
	Sat, 12 Jul 2025 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rQisFPWB"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F82AE99;
	Sat, 12 Jul 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353896; cv=none; b=KuhqL/c2178h3oPwZIVbstIHipM7FvJ8v4SSUI3n4E0+V/4hLh/kTztS5vTB3l7/CyZJyu5wZKxCinEMVzQcbEzLRf+ADH/Zh6HSHPpTh2PTc23bg154CLHNTrs3R2e5wCYfqXGbELrho0PgKMLz/InMWSAlL49up8jaVJcwY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353896; c=relaxed/simple;
	bh=FEMsf/9UUhbO1J42GaCRa+G6cmu7M28PWoVxpXXzl9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSOp2gvFMGghj0+Q3cVmv8aVR2PCtKmXUF1i8zwwbyNaXUS1j/x3vOXp7OErYqx847Snxjx5plx41ES18Egqugoy7cN34zSOF8tsYl10rC8gaob1ld+zPvT5aKnLstnZMwUxIWgkil8PS6AoHfWC8I9Tke+Pev9yeIcLIoKxUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rQisFPWB; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=PdU3RQRc7EGqYt9TTQYBK9ze3sa2k9tRuF6p73T8Yxk=; b=rQisFPWBdpvBaJfV
	ogaZCdtLzGt5LrlqfzQUOoj9EsRKXO0FJMHp+iwxvD4rzvo7cg7mkGCLkIV2mfCUz+Xd+uKI2Qr1G
	ESCUltzt40WdBicQZDjzm81T0GW+1CeA6tnDn7+j2Z3oStrBNOzZrlDciocP5ojkUNS2c696BG2d2
	M+t5G8OGStFQHMii266OoVAHbeJqyoys1lLLl2KS1H2Y36Ge6Oxryrg46ftHCANpXZftfTd7UOXoR
	shnuzh9HBoUZICdbniL/Q8XalmMYlOuwGyiS0q3UkSmWZXHtBObhXtywWadfIqMKKch1HDjtOARaY
	7tsBRvotMkcdyqXgtg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uahIG-00Fjnq-20;
	Sat, 12 Jul 2025 20:58:00 +0000
From: linux@treblig.org
To: ms@dev.tdt.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net/x25: Remove unused x25_terminate_link()
Date: Sat, 12 Jul 2025 21:57:59 +0100
Message-ID: <20250712205759.278777-1-linux@treblig.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

x25_terminate_link() has been unused since the last use was removed
in 2020 by:
commit 7eed751b3b2a ("net/x25: handle additional netdev events")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/x25.h |  1 -
 net/x25/x25_dev.c | 22 ----------------------
 2 files changed, 23 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index 5e833cfc864e..414f3fd99345 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -203,7 +203,6 @@ void x25_send_frame(struct sk_buff *, struct x25_neigh *);
 int x25_lapb_receive_frame(struct sk_buff *, struct net_device *,
 			   struct packet_type *, struct net_device *);
 void x25_establish_link(struct x25_neigh *);
-void x25_terminate_link(struct x25_neigh *);
 
 /* x25_facilities.c */
 int x25_parse_facilities(struct sk_buff *, struct x25_facilities *,
diff --git a/net/x25/x25_dev.c b/net/x25/x25_dev.c
index 748d8630ab58..fb8ac1aa5826 100644
--- a/net/x25/x25_dev.c
+++ b/net/x25/x25_dev.c
@@ -170,28 +170,6 @@ void x25_establish_link(struct x25_neigh *nb)
 	dev_queue_xmit(skb);
 }
 
-void x25_terminate_link(struct x25_neigh *nb)
-{
-	struct sk_buff *skb;
-	unsigned char *ptr;
-
-	if (nb->dev->type != ARPHRD_X25)
-		return;
-
-	skb = alloc_skb(1, GFP_ATOMIC);
-	if (!skb) {
-		pr_err("x25_dev: out of memory\n");
-		return;
-	}
-
-	ptr  = skb_put(skb, 1);
-	*ptr = X25_IFACE_DISCONNECT;
-
-	skb->protocol = htons(ETH_P_X25);
-	skb->dev      = nb->dev;
-	dev_queue_xmit(skb);
-}
-
 void x25_send_frame(struct sk_buff *skb, struct x25_neigh *nb)
 {
 	unsigned char *dptr;
-- 
2.50.1


