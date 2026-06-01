Return-Path: <netdev+bounces-293574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEKOMsUlHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:25:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CD61A22E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F3323001FE7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E66347BC6;
	Mon,  1 Jun 2026 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WaRYmgAc"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C7346E6C;
	Mon,  1 Jun 2026 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295106; cv=none; b=CuYdmy1Jmp3JdttOh9U/cnbp0QF8+1PDrW14O18PU/d+l/9xcrVAeKQ1kOpfLpsKO+sd24YkjkKFw0h0srXQJ8xXJ0AZWGq7FgTX742e0LXYLEtJeROHPc1Ka0hINutkO8y2r7Czj4s2aT2QmJtSD8QEXtWWCz+z6Qx9C+vm45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295106; c=relaxed/simple;
	bh=+QT2eYSCqs2VEyWevoxf7T/byP3p9S17eo6ZrdEvQbg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lFz7XKN1QrW4w/0VxcN+kwOtYCN0aukYxq4Zbov7t4pvD8CzAmrWc6zlBLOGx+qLlqQqU+Y0k7P1ZDODFbVBZ6yDki4V0Xzm1XVIkmvSMKjo6nCnAGa1wx+yR3ICKbblGaT/gBU3n8Kf3Phdcz+by+1lSf5IdjCUI3BaLRkyApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WaRYmgAc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6516Omp861861285, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780295088; bh=UpTCI4g2YkaJ6FRjNzBWkItBByRrymDA8/cJ6D33yAw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=WaRYmgAc7Fi2CnOByJIfaDEB264sIQQBslndJQa6V82hqsY2XLCJIBAWb76MkByOb
	 PBVmclM4kBiLj7DZZ7NXZ5CTUsOcnvyqBz71cz3ZqHApuQz9e/P+7lGnogHd52EeXU
	 hc5dqXdHUxviaCHc17yYGh/3V0EDlZzrrHAXRW9OpzIFbCp6yUv2Jc2++MYKDV0cKq
	 nHRZ5n41+UWZJp8440jnU4O+3z0JdN/31n8f191S3HXs+dPRUU6VVOeJPsuTcmU7qS
	 qFIhBbxhx6sbmQ4ProHEBMStQs16VktT2NPbNNuciVBv5W95O0zEQ/5mmB4Eh0EYG2
	 k2jA9E1JnPWZQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6516Omp861861285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 14:24:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 14:24:49 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 1 Jun 2026 14:24:49 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH] rtase: Avoid sleeping in get_stats64()
Date: Mon, 1 Jun 2026 14:24:47 +0800
Message-ID: <20260601062447.64027-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293574-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 630CD61A22E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The .ndo_get_stats64 callback must not sleep because it can be
called when reading /proc/net/dev.

rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
the tally counter dump bit with read_poll_timeout(). This may
sleep while waiting for the hardware counter dump to complete.

Use read_poll_timeout_atomic() instead to avoid sleeping in the
get_stats64() path.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 11e9d0feea68..17912f372740 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1618,8 +1618,9 @@ static void rtase_dump_tally_counter(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd);
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_DUMP);
 
-	err = read_poll_timeout(rtase_r32, val, !(val & RTASE_COUNTER_DUMP),
-				10, 250, false, tp, RTASE_DTCCR0);
+	err = read_poll_timeout_atomic(rtase_r32, val,
+				       !(val & RTASE_COUNTER_DUMP),
+				       10, 250, false, tp, RTASE_DTCCR0);
 
 	if (err == -ETIMEDOUT)
 		netdev_err(tp->dev, "error occurred in dump tally counter\n");
-- 
2.40.1


