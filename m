Return-Path: <netdev+bounces-130306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC298A06B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F36285E14
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EBD192D93;
	Mon, 30 Sep 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="k/WLK6em"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D4191F6F;
	Mon, 30 Sep 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695311; cv=none; b=VmiummY5HelXmBqX1QqupXiK9TiJK8DjMr2+VhLPdKZub3utHP7QDaUT8lFZXWJvnet359j7ue02cFfXdWKE0TvwsnjEaxMqlywcxbYen5rT3mldvtTThURJ1gJhAmydT8exGBwNLl5iL/4AYbtSfoB/G1tEjtP1LbM3Y4OPlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695311; c=relaxed/simple;
	bh=lkksD6NGuXpIY+XpTHVBhF7SHlisT53r+IndpiuzOwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1IqxbSsDBa4v6NUjtxwODjF0lYor2gwzwOcr2t1OehTTMoWxZmevfXDLG0/BaOqDc0qKuZwYZJGTocOE6cdy0YCL+l/E+Dcho9hdlTbSHGMpkDUSO/s5FWbhalTSwOPOE/Aqp4gcubgyc8OPApSudzgz6pl5+dMpmlwRq3LQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=k/WLK6em; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2XKlhDn6AgGoqTZxo5VdksoOUikd1owa2yhjw2qwHt0=;
  b=k/WLK6em86nT5+RBYtbTv2INfkmz5Wvk4WVE0xnMflr/XVcrxCQt6b/U
   dXroARqG7x8nBEoU3LOJhCYDlkFZyaTX4S4eHuLdxJm3ZxSHZNRRaqrke
   bKckiNeCeD30R1cMAvG+/UuxU0neSY+lKsK2E8ddr03qnWL/BU17EFPae
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956886"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jon Maloy <jmaloy@redhat.com>
Cc: kernel-janitors@vger.kernel.org,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/35] tipc: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:01 +0200
Message-Id: <20240930112121.95324-16-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/tipc/link.c |   14 +++++++-------
 net/tipc/msg.c  |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 5c2088a469ce..55c2ad1d88a2 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -461,15 +461,15 @@ u32 tipc_link_state(struct tipc_link *l)
  * @min_win: minimal send window to be used by link
  * @max_win: maximal send window to be used by link
  * @session: session to be used by link
+ * @self: local unicast link id
  * @peer: node id of peer node
+ * @peer_id: 128-bit ID of peer
  * @peer_caps: bitmap describing peer node capabilities
  * @bc_sndlink: the namespace global link used for broadcast sending
  * @bc_rcvlink: the peer specific link used for broadcast reception
  * @inputq: queue to put messages ready for delivery
  * @namedq: queue to put binding table update messages ready for delivery
  * @link: return value, pointer to put the created link
- * @self: local unicast link id
- * @peer_id: 128-bit ID of peer
  *
  * Return: true if link was created, otherwise false
  */
@@ -538,17 +538,17 @@ bool tipc_link_create(struct net *net, char *if_name, int bearer_id,
 /**
  * tipc_link_bc_create - create new link to be used for broadcast
  * @net: pointer to associated network namespace
+ * @ownnode: identity of own node
+ * @peer: node id of peer node
+ * @peer_id: 128-bit ID of peer
  * @mtu: mtu to be used initially if no peers
  * @min_win: minimal send window to be used by link
  * @max_win: maximal send window to be used by link
+ * @peer_caps: bitmap describing peer node capabilities
  * @inputq: queue to put messages ready for delivery
  * @namedq: queue to put binding table update messages ready for delivery
- * @link: return value, pointer to put the created link
- * @ownnode: identity of own node
- * @peer: node id of peer node
- * @peer_id: 128-bit ID of peer
- * @peer_caps: bitmap describing peer node capabilities
  * @bc_sndlink: the namespace global link used for broadcast sending
+ * @link: return value, pointer to put the created link
  *
  * Return: true if link was created, otherwise false
  */
diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc538eb..dc3000c28d43 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -196,8 +196,8 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
  * tipc_msg_append(): Append data to tail of an existing buffer queue
  * @_hdr: header to be used
  * @m: the data to be appended
- * @mss: max allowable size of buffer
  * @dlen: size of data to be appended
+ * @mss: max allowable size of buffer
  * @txq: queue to append to
  *
  * Return: the number of 1k blocks appended or errno value


