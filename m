Return-Path: <netdev+bounces-184459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CDCA95961
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B5188FB95
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF868227EA0;
	Mon, 21 Apr 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3LDWFgc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2B227E99
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274521; cv=none; b=OTvUOGvm3dvYEGYwVzzZ/peapDt3lnbwTk88uenQUF5Ql2kLkfaOolBt28qeds6jEbaaG0Ox3ij2nFop4za0lkiNc4bSOHAux9u22aV2GjTrN18LuDGwcteqrnBS4nkl1R9widyGzF/RpG0JjVbypFtsvZWVTWI0aGyhcvluL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274521; c=relaxed/simple;
	bh=Q0pac5Wjrtl9yws9IhT5q+cWoJ/29gPWqnpVqOwy0NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnLR3hJDtljjwFHIKFc7PoaVgda74yuS/g1pMpnzPkOKwuKWmFczQj5m3+HAqZiBzwmstH6VLrYZKKSpMXK8vmvTXQ6eoXTpKmJl+h0RazYYr8sxyBBLwVN2NrKt77+J6pzjr2jpQvIxDKqJMUpk3KIhZEyK0gOwgCNqKr2wGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3LDWFgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEB0C4CEEB;
	Mon, 21 Apr 2025 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274520;
	bh=Q0pac5Wjrtl9yws9IhT5q+cWoJ/29gPWqnpVqOwy0NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3LDWFgcJw/Lk4WywMtlmX6MWsdyOXyV91HeH0rJITh5irYvt2vudOjyO6/+KM6kp
	 hcQWrFLCJxJjki2UtQYZbKbgLM0bvQ1fVxMgs0b73Lten3JrldPOl3+TqXKAhTLMYt
	 +Npi2/TsGK7S/a0Pw15iWq24vxWuvwVbnEm9vwUerC697aYmcxMJzpp7BxPRc84ENv
	 OfzQw69+5QjucCMehJ6xBlBtw0nwDFFq6kiZDrcwnlrp9k1AbRwqbm9q6OJqyuC4t9
	 J0IpTjU3Xg0Jp3WcRDYNb3jcBnil246AkTI3OsysUAh0eVchIhxFYEthbaVBxPCktO
	 BDtJuMDALUa5w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 10/22] net: reduce indent of struct netdev_queue_mgmt_ops members
Date: Mon, 21 Apr 2025 15:28:15 -0700
Message-ID: <20250421222827.283737-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial change, reduce the indent. I think the original is copied
from real NDOs. It's unnecessarily deep, makes passing struct args
problematic.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_queues.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index a9ee147dd914..c50de8db72ce 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -145,18 +145,18 @@ struct netdev_stat_ops {
  * be called for an interface which is open.
  */
 struct netdev_queue_mgmt_ops {
-	size_t			ndo_queue_mem_size;
-	int			(*ndo_queue_mem_alloc)(struct net_device *dev,
-						       void *per_queue_mem,
-						       int idx);
-	void			(*ndo_queue_mem_free)(struct net_device *dev,
-						      void *per_queue_mem);
-	int			(*ndo_queue_start)(struct net_device *dev,
-						   void *per_queue_mem,
-						   int idx);
-	int			(*ndo_queue_stop)(struct net_device *dev,
-						  void *per_queue_mem,
-						  int idx);
+	size_t	ndo_queue_mem_size;
+	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       void *per_queue_mem,
+				       int idx);
+	void	(*ndo_queue_mem_free)(struct net_device *dev,
+				      void *per_queue_mem);
+	int	(*ndo_queue_start)(struct net_device *dev,
+				   void *per_queue_mem,
+				   int idx);
+	int	(*ndo_queue_stop)(struct net_device *dev,
+				  void *per_queue_mem,
+				  int idx);
 };
 
 /**
-- 
2.49.0


