Return-Path: <netdev+bounces-194413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60DBAC957F
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846717AC717
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1074426461F;
	Fri, 30 May 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T2v5w5zE"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A71A2396;
	Fri, 30 May 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628651; cv=none; b=JBM/t543M9WY+JFkmX8P4C3btOJdwUmAEZRhm/al1sJqhq/R8zoRRQTXqRPdQXg7uJzPL4Mok5aOT5bDsWBWJ3pOaGeSsyDQnrWIDi1jikP4NDwigICmVdvoiaeCeEz3OMrR8ebUX/sl2tlZaOfBdTPBEeB1Y0cX5qA4PIBueaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628651; c=relaxed/simple;
	bh=9Zfdj00/kJOzSoNoPj/y7wPpoio7zTQ83fIGe4o8PMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZ3IQhJ1swDsW1hKQobC/+b0M/WweShbZc5uh4eFOHdkvBPk15uLXc8BxiN/18sBGOtz3ICvJDZE07I13kQWSeCCyr2eLNIIiiLfMvpbgitrZ0FcOX20u2rSJCKHnGQTp7UzW9D2q4D30HMo6xvBDmaobAswqLsHFwdUvBZfziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T2v5w5zE; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Zz
	yJ/Kz22cI9tO/krLLF+mHfoWTVlQI+u3K2yCHH1Hg=; b=T2v5w5zEpe9RZdi9y1
	/gsQMChnPYZkUSdzCWMKFYSozpBOM2y7ihqlB5G21kSbRRC0Mxj5cKozwjUzrIh/
	CfunqXwT8XsrGTAeivr49R6qP4CIorMDkj1CQU6zuPXReDsuGKmF0AUJZoq4L5cg
	VDbxlIcdjDLLr/GZt/3zWj/kE=
Received: from gnu.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3Gt2A9DloRW+rFA--.14715S2;
	Sat, 31 May 2025 02:10:09 +0800 (CST)
From: moyuanhao3676@163.com
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	moyuanhao <moyuanhao3676@163.com>
Subject: [PATCH] mptcp: fix typos in comments
Date: Sat, 31 May 2025 02:10:04 +0800
Message-Id: <20250530181004.261417-1-moyuanhao3676@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3Gt2A9DloRW+rFA--.14715S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFykCw13uw15ZF1Dtw4Utwb_yoWftFb_u3
	WrtFZrKF4qgF1UCa18AwsxArn3trWDury8GF4ftF9rG34DJ3ZYvr1rGry5Zr48uw17Jay5
	Ww1Yk345twsI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRta0PUUUUUU==
X-CM-SenderInfo: 5pr13t5qkd0jqwxwqiywtou0bp/xtbBhQ1dfmg5ZDxR5AACsV

From: moyuanhao <moyuanhao3676@163.com>

This patch fixes the spelling mistakes in comments.
greter -> greater

Signed-off-by: moyuanhao <moyuanhao3676@163.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0749733ea897..18058688e483 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1376,7 +1376,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * - estimate the faster flow linger time
 	 * - use the above to estimate the amount of byte transferred
 	 *   by the faster flow
-	 * - check that the amount of queued data is greter than the above,
+	 * - check that the amount of queued data is greater than the above,
 	 *   otherwise do not use the picked, slower, subflow
 	 * We select the subflow with the shorter estimated time to flush
 	 * the queued mem, which basically ensure the above. We just need
-- 
2.34.1


