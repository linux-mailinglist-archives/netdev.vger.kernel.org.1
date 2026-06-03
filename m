Return-Path: <netdev+bounces-294595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nUYHOIbQH2oSqQAAu9opvQ
	(envelope-from <netdev+bounces-294595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:58:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D3634E21
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:58:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=QMD4CtQ3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294595-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294595-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D604300B3FA
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491993955E4;
	Wed,  3 Jun 2026 06:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734525A2A2
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:55:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469751; cv=none; b=Dv+3AbT8ckmL2V/UVsCBSCnZVuoPT7qJ6GbyxxsPAnNowSGagNv4cRSvcoymFiHcqN0C+3F+LsHGFvXAFWkOvHlJQvMWtAP/dlPlMHUvtNXKnuIQSKwymJYd/Nl+oqESFXnocmMCam/rNkFleIOU2dNByBbXMfwUtr30iKB+OJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469751; c=relaxed/simple;
	bh=T4nH7kswoxYky/LK3H2kyzxxkH+A3aQLpb5SaaFFCks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tX6Rl0BJ8H63uVVM/gaCzflhVZBV53bQSKGzjTcHMRkp0lglMoGZ/U2BWP/HneVKZV0df5IgoXhpHJGUfeiDoAb/UkX6KihQw9WC6DOIHkJxf5c+UKSKXYBIOXcQLYHCM718A6Tv4iNsl+L8Dmh4L91sA/vHT7VYItCFYPM4sTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QMD4CtQ3; arc=none smtp.client-ip=44.245.243.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780469750; x=1812005750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tQERlSpJaBvbN18WlPgByo80Qb6GrsVh58XCQrW6F4k=;
  b=QMD4CtQ3IR0v7+609af4r6NPog46Di59OmgvWZEkMj2dqIHTYrS54c2h
   pf8Tl+PqJP6VnczZdWNLFBsSE+200Z9LLsmyPXXIWgD+pwZg8drA03KCC
   K7MnAoKofGdQWpkGPaq3idiPuH3dDEtMmyQJowEQK/cjqf5R1/HLg6mM9
   Ufj1KaGSeuZ+yBw8OW+kbJxHqDSwm0GiPF2iW6q4KURt4JpKKHs8cpqnV
   AIkKZUGAbH40QQvdRsUj88hKzGipiwImmoAImnBubYG+We552XfDF06oj
   ISLO4J83/1g/ndxgkDzNohBnJJLkJF6ywL3DnYlz2b8byNl+l0uvbBpfK
   w==;
X-CSE-ConnectionGUID: 9GojaIXzTta2Sk0dKkKIMg==
X-CSE-MsgGUID: KH4CgbFbQp6+We1EpaKOnA==
X-IronPort-AV: E=Sophos;i="6.24,184,1774310400"; 
   d="scan'208";a="20496921"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:55:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:19041]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.239:2525] with esmtp (Farcaster)
 id a08914ee-dc77-418b-8a98-49ae067ab96a; Wed, 3 Jun 2026 06:55:46 +0000 (UTC)
X-Farcaster-Flow-ID: a08914ee-dc77-418b-8a98-49ae067ab96a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 06:55:46 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 06:55:43 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Arinzon, David" <darinzon@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH net] net: ena: PHC: Add missing barriers
Date: Wed, 3 Jun 2026 06:55:30 +0000
Message-ID: <20260603065532.13260-1-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294595-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:akiyano@amazon.com,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F0D3634E21

Add dma_rmb() barriers after both req_id completion checks in
ena_com_phc_get_timestamp(). On weakly-ordered architectures,
payload fields may be read before req_id is observed as updated.

Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
Closes: https://sashiko.dev/#/patchset/20260430032507.11586-1-akiyano%40amazon.com
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 43 +++++++++++++++--------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 8c86789d867a..79cfcd87d4bf 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1822,23 +1822,31 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 				   "PHC get time request 0x%x failed (device error)\n",
 				   phc->req_id);
 			phc->stats.phc_err_dv++;
-		} else if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
-			/* Device updated req_id during blocking time but got
-			 * a PHC error, this occurs if device:
-			 * - exceeded the get time request limit
-			 * - received an invalid timestamp
-			 */
-			netdev_err(ena_dev->net_device,
-				   "PHC get time request 0x%x failed (error 0x%x)\n",
-				   phc->req_id,
-				   resp->error_flags);
-			phc->stats.phc_err_ts += !!(resp->error_flags &
-				ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
 		} else {
-			/* Device updated req_id during blocking time
-			 * with valid timestamp
+			/* Ensure PHC payload is read after req_id update
+			 * is observed
 			 */
-			phc->stats.phc_exp++;
+			dma_rmb();
+
+			if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
+				/* Device updated req_id during blocking
+				 * time but got a PHC error, this occurs
+				 * if device:
+				 * - exceeded the get time request limit
+				 * - received an invalid timestamp
+				 */
+				netdev_err(ena_dev->net_device,
+					   "PHC get time request 0x%x failed (error 0x%x)\n",
+					   phc->req_id,
+					   resp->error_flags);
+				phc->stats.phc_err_ts += !!(resp->error_flags &
+					ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
+			} else {
+				/* Device updated req_id during blocking
+				 * time with valid timestamp
+				 */
+				phc->stats.phc_exp++;
+			}
 		}
 	}
 
@@ -1880,6 +1888,11 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			continue;
 		}
 
+		/* Ensure PHC payload (timestamp, error_flags) is read
+		 * after req_id update is observed
+		 */
+		dma_rmb();
+
 		/* req_id was updated by the device which indicates that
 		 * PHC timestamp and error_flags are updated too,
 		 * checking errors before retrieving timestamp
-- 
2.47.3


