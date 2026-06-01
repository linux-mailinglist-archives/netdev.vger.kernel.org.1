Return-Path: <netdev+bounces-293572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJJODZUmHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:28:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96F61A2A6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5360D3034AA9
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17926346E6C;
	Mon,  1 Jun 2026 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="b7Jugmsb"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF1345757;
	Mon,  1 Jun 2026 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295076; cv=none; b=h7zw4WU/Wps+I4HScbke3vWsUJov6/Us/eJXgG043V/6Gt3mltbOc0xefrBIl6aN7cWxTdRrs19ZHeXJ+YfiVLNrT5uSX/D85+HLMgESYFQrHIMmdEfGNILGz0hdg2U+GKhpfJIFUYYJ6wnQPVRvYqvIpeDstXKUlgnvYm5za2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295076; c=relaxed/simple;
	bh=vmgAXD09cVpOj90a7laVl88qBf7NWNmKjxtNUYBmm4o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A5cL0SbrAibLOnyQHEdYCgZNpG8DBRSwOaFcPIfxrsZ3Sl6ERRMkacYan506UaTmwfYEfYRfduY1iZVLrHFvK1lrm1LUg39aCBqikHyIknraHJBivpZuisx6FJsVP7pzyxNzKhSRjCb68TZQZ+aKMP/eoWgLd2/M6N97C4bBnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=b7Jugmsb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6516OJeI41861201, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780295059; bh=3qc2Bp/haccANt3EoIOQnj5YGcD4qZRZ64CoK9AA6T8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=b7JugmsbajQYTKEymJMlae6bzVtIFAQdc2YxuGj7VdWzUTe/Tqyy3NEBnh7aSVgOz
	 9AIo7FqjZcVXMR9SXibIzbtc8MbxxJjI1h9Mj4QZMS/L3b53s5NMTCcV1uEUltq6v5
	 Js/FfrGoQsSMw+ooBXKa4mfgUuAW9Ly/y/tbHNdpB0XJbWuGuA8MIuHFwkKxWRXrYg
	 rykEX2Zg55xO7J+FqkAHeeaiaDgCs2OCpWIKqcT44rJ3T7NpdpNTMuOU19FKmutK9w
	 wL8N0wIDa3Ebb/3qAZ+WzSKlVCNtz2HInpJupzjp3cyTKTl4Yh/syZZ6UueRJKpryu
	 rkyeglMsETk7g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6516OJeI41861201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 14:24:19 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 14:24:19 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 1 Jun 2026 14:24:19 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH] rtase: Reset TX subqueue when clearing TX ring
Date: Mon, 1 Jun 2026 14:24:18 +0800
Message-ID: <20260601062418.64004-1-justinlai0215@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293572-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B96F61A2A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtase_tx_clear() clears the TX ring and resets the ring indexes.
However, the TX queue state and BQL accounting are not reset at
the same time.

This may leave __QUEUE_STATE_STACK_XOFF asserted after
rtase_sw_reset(), preventing new TX packets from being scheduled.

Reset the TX subqueue when clearing the TX ring so the TX queue
state and BQL accounting are restored together.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 43a4aa275b62..11e9d0feea68 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -240,6 +240,8 @@ static void rtase_tx_clear(struct rtase_private *tp)
 		rtase_tx_clear_range(ring, ring->dirty_idx, RTASE_NUM_DESC);
 		ring->cur_idx = 0;
 		ring->dirty_idx = 0;
+
+		netdev_tx_reset_subqueue(tp->dev, i);
 	}
 }
 
-- 
2.40.1


