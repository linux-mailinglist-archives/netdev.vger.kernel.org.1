Return-Path: <netdev+bounces-129673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C494B9855E7
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAB81F2565D
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896915852E;
	Wed, 25 Sep 2024 08:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CCD15747D;
	Wed, 25 Sep 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254539; cv=none; b=WLmwbV4OE3JWVIe+/t/qaDFQ83OCr/35LfZBFuhmWca62B7CaG5m+R8K6NiOBudsiwds7HkWZDERWdy8PzTtkErDmkHBCGSiE7evXa7XB6H/U45dbwpIcqdo97cMKvYCiMWyObK5EldfmQPo/4pirAq8I3hVlV2iogDSI3H56AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254539; c=relaxed/simple;
	bh=lhSsYpNmbIkkmSCV1rETJVNHXvWLD+63NYOe4YSZCIs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JFj1TyD6Uoj1NTs+5oYRs96WUfG7OO2aSUmCuwCa6xikZoXUTvjI5qkx8kV8BlgDvM0eXXVvOkm9Cus9FGNx458DBPbB8EFUhk4bfbjnfRR3tqtfYQffxVJ95pS5VfiZ/H0dUZVBAfpvP1d2T7RaQUPRY3tcGhvHQxUfxIQ6SS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166f3cffed4d-5d650;
	Wed, 25 Sep 2024 16:55:26 +0800 (CST)
X-RM-TRANSID:2ee166f3cffed4d-5d650
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466f3cffd430-c4ac5;
	Wed, 25 Sep 2024 16:55:26 +0800 (CST)
X-RM-TRANSID:2ee466f3cffd430-c4ac5
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	zhujun2@cmss.chinamobile.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/net:Fix the wrong format specifier
Date: Wed, 25 Sep 2024 01:55:24 -0700
Message-Id: <20240925085524.3525-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The format specifier of "unsigned int" in printf() should be "%u", not
"%d".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/net/ynl/samples/page-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/samples/page-pool.c b/tools/net/ynl/samples/page-pool.c
index 332f281ee5cb..e5d521320fbf 100644
--- a/tools/net/ynl/samples/page-pool.c
+++ b/tools/net/ynl/samples/page-pool.c
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 			name = if_indextoname(s->ifc, ifname);
 			if (name)
 				printf("%8s", name);
-			printf("[%d]\t", s->ifc);
+			printf("[%u]\t", s->ifc);
 		}
 
 		printf("page pools: %u (zombies: %u)\n",
-- 
2.17.1




