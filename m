Return-Path: <netdev+bounces-152225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233089F3206
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BCB16256F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C8205507;
	Mon, 16 Dec 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="gB8TxqS3"
X-Original-To: netdev@vger.kernel.org
Received: from out30-87.freemail.mail.aliyun.com (out30-87.freemail.mail.aliyun.com [115.124.30.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363F29CA;
	Mon, 16 Dec 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357298; cv=none; b=ks+QHDF6ZtJvTnSIT9BCtPkWANgAjN272HOUdhohWwo4M7vwQVJc9T20PQqMtnNrg76vuscmqp+kY3oUO093UlyZwkB+Z57SQH0kAxdzZrOCQgC48FfMiMAInnv6K8iwJBcpjdsdmjp3+PI5fRSKlo2iybLIql49FmG9puyEChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357298; c=relaxed/simple;
	bh=q2+3SRjF9qbMNvP+247J8CdWSaf4GYae5QBp9nFhcHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zq/T3x/je6yc/TKcJm+Z7qRF60lnZX9zS5vv2BAp9JWIf75geb3qeyEzXueylTnZDoNEv3kFbG90i0dAqoVMCdKWZ+SkRV8zXoYcQXpulInEHL7cgl3F7lH7/oVFtxLdVNzmPvKvlDLVo31DFewPDyRWKbM8gqfFwlCIqC9kcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=gB8TxqS3; arc=none smtp.client-ip=115.124.30.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1734357293; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/v8vSp8uWtypDFIWVXVjjX5GA/863eX9W8qS19nLx9E=;
	b=gB8TxqS3mKywD1XJN5jXMqtXARlQ5Gp0hbSpLX07f1hS4vVeocwXipOqf6YEdmGoiLf+shHmaCAws9CNk80MEy9IFZ80JS51iJTkknEiYfLWPgjbMpv9RCsKeCdnElRxyyiBQ17IWEdwwLbMdXJAhfupLUFrMNVhUYYsoVVSHss=
Received: from oslab..(mailfrom:shunlizhou@aliyun.com fp:SMTPD_---0WLdRvjW_1734357291 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 21:54:52 +0800
From: shunlizhou@aliyun.com
To: jv@jvosburgh.net,
	andy@greyhouse.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shunlizhou <shunlizhou@aliyun.com>
Subject: [PATCH] docs: net: bonding: fix typos
Date: Mon, 16 Dec 2024 13:54:46 +0000
Message-Id: <20241216135447.57681-1-shunlizhou@aliyun.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shunlizhou <shunlizhou@aliyun.com>

The bonding documentation had several "insure" which is not
properly used in the context. Suggest to change to "ensure"
to improve readability.

Signed-off-by: shunlizhou <shunlizhou@aliyun.com>
---
 Documentation/networking/bonding.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index 7c8d22d68682..a4c1291d2561 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -1963,7 +1963,7 @@ obtain its hardware address from the first slave, which might not
 match the hardware address of the VLAN interfaces (which was
 ultimately copied from an earlier slave).
 
-There are two methods to insure that the VLAN device operates
+There are two methods to ensure that the VLAN device operates
 with the correct hardware address if all slaves are removed from a
 bond interface:
 
@@ -2078,7 +2078,7 @@ as an unsolicited ARP reply (because ARP matches replies on an
 interface basis), and is discarded.  The MII monitor is not affected
 by the state of the routing table.
 
-The solution here is simply to insure that slaves do not have
+The solution here is simply to ensure that slaves do not have
 routes of their own, and if for some reason they must, those routes do
 not supersede routes of their master.  This should generally be the
 case, but unusual configurations or errant manual or automatic static
@@ -2295,7 +2295,7 @@ active-backup:
 	the switches have an ISL and play together well.  If the
 	network configuration is such that one switch is specifically
 	a backup switch (e.g., has lower capacity, higher cost, etc),
-	then the primary option can be used to insure that the
+	then the primary option can be used to ensure that the
 	preferred link is always used when it is available.
 
 broadcast:
@@ -2322,7 +2322,7 @@ monitor can provide a higher level of reliability in detecting end to
 end connectivity failures (which may be caused by the failure of any
 individual component to pass traffic for any reason).  Additionally,
 the ARP monitor should be configured with multiple targets (at least
-one for each switch in the network).  This will insure that,
+one for each switch in the network).  This will ensure that,
 regardless of which switch is active, the ARP monitor has a suitable
 target to query.
 
-- 
2.34.1


