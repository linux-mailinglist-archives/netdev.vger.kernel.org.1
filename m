Return-Path: <netdev+bounces-99869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420298D6CD8
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4221F2652E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBA484DF8;
	Fri, 31 May 2024 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oBeaRRpv"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C98168DA;
	Fri, 31 May 2024 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198168; cv=none; b=Ge/8Pv5wBwSbT0WwxhRKnNwg/WDWbXpU65q4xo5y+V3vLKBZTXqLafYcKtyLvWoKlQcK4ihkXFf6MN2Vi4z4BmpoOYvQBfnLwfr5pRaG67HEk76ISU2m7b/BRz2bQ5AM3bwCKyoqVrOIYlCTuAVLNC+w1tH1LXsk7nSnFXZBfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198168; c=relaxed/simple;
	bh=fxw6B70FoOVHtyTlYXBc6aAzqLvR9TS1xLMCWUQqPgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qm/HBVCFf2F8zt0aGYrHoHHTNKfzqC1fmK/kKdzHHq+6y1wx78gKOpPq04Y2a/mFMGsm011jmDMugrTeicGses0ahZ5w7kMViiVLM6tsfgIKXdyETlwV+WNh+1wiEOc6AyLj3OTfla+jMQh2W8waggfHxrijGqksWO59nGH15hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oBeaRRpv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=LHsHHWwS81QuUEO9BxZ97COZKyQ2LJ0ITfj9uotAElo=; b=oBeaRRpvvRUorjtd
	kRgY/2XFiAiMKflmRoFnGG1x9CQ/RhIZDrDqUmLSGpPBZ+somJwlexH0wIVJN9LVzbgbx2QqhuqAM
	sMONU6ZkcXD1y1twmR/8ltXhQHzz3bxiU0oGJN+HbwV7AS4abmjOn+6lH4vqlmEWVOMMtXnu4kW9B
	9CKgBfmjKsu3KZmkeDmBpOs2HCNf+08mKZYzt1ipZh+2dv4L0lC60napmL+oaQWyFyD31xS+/v/Ti
	0BiCD4zSMrOH3RV3KkQooL+NWq43ncO8mysE8Pl92rvlvqpO1dLrXkyq0GFi9CozBaXIoCBZQb5UY
	6yHH50wAdBw0Kq3Nsw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDBgT-003gTW-2w;
	Fri, 31 May 2024 23:29:18 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] net: caif: remove unused structs
Date: Sat,  1 Jun 2024 00:29:17 +0100
Message-ID: <20240531232917.302386-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'cfpktq' has been unused since
commit 73d6ac633c6c ("caif: code cleanup").

'caif_packet_funcs' is declared but never defined.

Remove both of them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/caif/caif_layer.h | 2 --
 net/caif/cfpkt_skbuff.c       | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/net/caif/caif_layer.h b/include/net/caif/caif_layer.h
index 51f7bb42a936..0f45d875905f 100644
--- a/include/net/caif/caif_layer.h
+++ b/include/net/caif/caif_layer.h
@@ -11,9 +11,7 @@
 
 struct cflayer;
 struct cfpkt;
-struct cfpktq;
 struct caif_payload_info;
-struct caif_packet_funcs;
 
 #define CAIF_LAYER_NAME_SZ 16
 
diff --git a/net/caif/cfpkt_skbuff.c b/net/caif/cfpkt_skbuff.c
index 7796414d47e5..2ae8cfa3df88 100644
--- a/net/caif/cfpkt_skbuff.c
+++ b/net/caif/cfpkt_skbuff.c
@@ -21,13 +21,6 @@ do {					   \
 	pr_warn(errmsg);		   \
 } while (0)
 
-struct cfpktq {
-	struct sk_buff_head head;
-	atomic_t count;
-	/* Lock protects count updates */
-	spinlock_t lock;
-};
-
 /*
  * net/caif/ is generic and does not
  * understand SKB, so we do this typecast
-- 
2.45.1


