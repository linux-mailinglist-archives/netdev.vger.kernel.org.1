Return-Path: <netdev+bounces-218934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772BB3F082
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74AE4E0953
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52E27CCE2;
	Mon,  1 Sep 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="C+L9Wy9H"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2D2798F8
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762277; cv=none; b=oNgRKHqYV2PN0MWoYpOtm+EOc3nrPymX3AYve8SLDfoMTW5Mz6RyoVMmgmARRjODmKVD7VmA3dkCj5xOmk+1/cpRx5mVZBabrAsv7qyo7D9sms15TKFrUwbDr1eJGNTs/bvw29JfvltvvQpB1eR0d+IZpZbVRnOq3ceNIGgOuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762277; c=relaxed/simple;
	bh=3cHHKoLLd8P7jSZEouF2NN0VNcZxz8sIl2sXDm8YC1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vs6qr5JZZIq3bIFBYZ6pyz97Jy00RQnVQcMqBJMG3l5qg/qhLYDgXn5Ab+9IktHsFubKaYWQB5Vdx970SyK1H2K3rw4ea0q3AgPwikG155T4UDJH6IYCIFclVLT0ymMN9GW7jyKdQY7HMdTU21ycoW6QzIlHC1zaRtFPaq+O/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=C+L9Wy9H; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cG29r20Dhz9tFL;
	Mon,  1 Sep 2025 23:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1756762272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BzWVpOuweO8xL9X7XLbSKS682/MfCO3qbXjwPcJLwYs=;
	b=C+L9Wy9H+b1Il58OZlxb2R6Wapb8fVQBJDnHpZQdikM8oTz3Jm3/uGn8A0tstFZtI+lV6A
	Pg+sL49aZ1lhrMKZ0XjtPYi5PAaUjij6wMU9PZImbzBVmDfvWRQmM2FjfQEec4Mc4CWukJ
	IYtyTEdp3Cpb8uol8mQsHbnV8OQ5IMOtfSXBhbOfid3zqYX8KHpqYUyydZHR7tAniQHnPx
	vtju7pZihrmhH1Tl86ptiGClWi2r2n9fmQ5yzQrLMNWofe4Oi7MVlEfAMm5Zi35zm6SeNU
	TxtesJms722ZNdJXpzAoa3tIuzYEweWf6t+8Dzoc91huQwB+1L15mJJ54diUeQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	listout@listout.xyz
Subject: [PATCH] net: intel: fm10k: Fix parameter idx set but not used
Date: Tue,  2 Sep 2025 03:01:00 +0530
Message-ID: <20250901213100.3799820-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cG29r20Dhz9tFL

Variable idx is set in the loop, but is never used resulting in dead
code. Building with GCC 16, which enables
-Werror=unused-but-set-parameter= by default results in build error.
This patch removes the dead code and fixes the build error.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 drivers/net/ethernet/intel/fm10k/fm10k_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
index f51a63fca513..2fcbbd5accc2 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
@@ -457,7 +457,7 @@ void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count)
 {
 	u32 i;
 
-	for (i = 0; i < count; i++, idx++, q++) {
+	for (i = 0; i < count; i++, q++) {
 		q->rx_stats_idx = 0;
 		q->tx_stats_idx = 0;
 	}
-- 
2.51.0


