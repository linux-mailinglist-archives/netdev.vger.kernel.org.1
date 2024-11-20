Return-Path: <netdev+bounces-146422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B269D3509
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251761F2169A
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4E158DD1;
	Wed, 20 Nov 2024 08:07:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C848360DCF;
	Wed, 20 Nov 2024 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090048; cv=none; b=Y61+Yb6/8YzKJdVNDaEUw78KIigNnCfQN7s5nnIkZw6/epzD9eqkNKxHzkdwJrgBxF5deeWmvkvpLb0RdIAms2tB1p7xzdjhv5GqjyumC949vRwo/q0FrQCe9ffvH3SHWtpLqcQtfgBKDwTYrTwQJKogMTShQjZQiVzBpPr9OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090048; c=relaxed/simple;
	bh=ouJXrUW2N3OuxsMMYy0qt0J1XOkLzf4/w6AsN7KLD2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qQkj/TGk+nezl0K8fDLfanh6K1vGULugns2LJ71DvxFfr46lPtnZqYj2+GzB/gj0pW/hAOwTQ4LJ0wMDQZ63Mznh83wOzHjCwGHm5IcQs1vqnZx2K4XEY4ggQECdRxNhHKQ+m0A0+jXif/cVNO8ZgVJRklvb1nopbYMPVttdLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6673d98b3b2d-223fe;
	Wed, 20 Nov 2024 16:07:15 +0800 (CST)
X-RM-TRANSID:2ee6673d98b3b2d-223fe
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2673d98b2135-74007;
	Wed, 20 Nov 2024 16:07:15 +0800 (CST)
X-RM-TRANSID:2ee2673d98b2135-74007
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: jonathan.lemon@gmail.com
Cc: vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] ptp: ocp: Fix the wrong format specifier
Date: Wed, 20 Nov 2024 14:26:05 +0800
Message-Id: <20241120062605.35739-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Use '%u' instead of '%d' for unsigned int.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 5feecaadde8e..52e46fee8e5e 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1455,7 +1455,7 @@ ptp_ocp_verify(struct ptp_clock_info *ptp_info, unsigned pin,
 		 * channels 1..4 are the frequency generators.
 		 */
 		if (chan)
-			snprintf(buf, sizeof(buf), "OUT: GEN%d", chan);
+			snprintf(buf, sizeof(buf), "OUT: GEN%u", chan);
 		else
 			snprintf(buf, sizeof(buf), "OUT: PHC");
 		break;
-- 
2.33.0




