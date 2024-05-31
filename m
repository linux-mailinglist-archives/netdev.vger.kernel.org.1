Return-Path: <netdev+bounces-99870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587A8D6CDA
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E34B25227
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A4B8287C;
	Fri, 31 May 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="W579kMVW"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27524211;
	Fri, 31 May 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198216; cv=none; b=PzsIDHc05NjNZHVv6bEqwgxZKF669mj7Ips5kL9fbBPO4t71nJohVfiLiLi0DZEoE6Tg+uJbzr+3h1LdVDoaLu43GhXQ7bvh3sxKFm3PV7kNLB5vPs/aPrldsc707U7I1iCzxFoV1UimGc5W2HWjMB6OEiHJR8AmTKFzjpPRMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198216; c=relaxed/simple;
	bh=ycNY+F6QgQKmiB+vp/3dqcdfN1kdb0Mq7hpTV+9dSDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXuPbSjlzQgAP2sVPHoHGLT4fyC5kXXezKq7hOVAnM6+0pzi69aI11nytRnArS0DsODWWDNjbqCPuHaome1KO8vMUAUlgJSUJwOon03daq9Qafmk8rAO2df2Z38cHcX2J+PRmnNtDylPPkL6rOBif4F6LofFT2Ij+X2Os7uoZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=W579kMVW; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=cJoesVlwXJebXFanbZcxbOntDgTDiHQC2TNzXXmcIug=; b=W579kMVWRBHUWo7j
	89VnwkQ4sKT3SPuz72DPmGgCN8BWmgCQARx8onBanADyMqw+rtzcipYku+zSzvK0XLeAdTk29DA5A
	GxOqQA3Bt/6T9BDFhbEtJTpHornCHp9OsAafS82j8iJONsnsV1ngR81RAPyl218y2u56G00X6pwnk
	OHW3fjELjaVnSRK1MBLiaomfrjyMeikoXUCzed/3TOu9oA7qdKN0SBQLXGvEI6Q/TGMe3Cv2WyxZo
	I9a6aINnVqn5VCsAeYbeEMxKRgjB8e8FFYMWXGNr9JdRRvj8+zxTzS3kWwfwxwejs5aEpGzyb7xcF
	nXMQyAklisHn69kzUw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDBhI-003gUZ-0U;
	Fri, 31 May 2024 23:30:08 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] net: ethtool: remove unused struct 'cable_test_tdr_req_info'
Date: Sat,  1 Jun 2024 00:30:06 +0100
Message-ID: <20240531233006.302446-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'cable_test_tdr_req_info' is unused since the original
commit f2bc8ad31a7f ("net: ethtool: Allow PHY cable test TDR data to
configured").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/ethtool/cabletest.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 06a151165c31..f6f136ec7ddf 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -207,10 +207,6 @@ int ethnl_cable_test_fault_length(struct phy_device *phydev, u8 pair, u32 cm)
 }
 EXPORT_SYMBOL_GPL(ethnl_cable_test_fault_length);
 
-struct cable_test_tdr_req_info {
-	struct ethnl_req_info		base;
-};
-
 static const struct nla_policy cable_test_tdr_act_cfg_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST]	= { .type = NLA_U32 },
 	[ETHTOOL_A_CABLE_TEST_TDR_CFG_LAST]	= { .type = NLA_U32 },
-- 
2.45.1


