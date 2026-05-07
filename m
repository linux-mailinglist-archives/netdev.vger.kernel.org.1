Return-Path: <netdev+bounces-285296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILKJFx6A/GkcQwAAu9opvQ
	(envelope-from <netdev+bounces-285296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:05:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D7C4E7F68
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B358030068FF
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617339A7E7;
	Thu,  7 May 2026 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oDl0EX7P"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB763B8BC4;
	Thu,  7 May 2026 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155542; cv=none; b=vFWoPjg9VKVw1XhWs00nck4ef/c7eeAMXt7910uafpHytxitTsl3fQsh8hmfmS2OL6vZQm89kd58vFUqjreSE5vtGq0tQgO3PQCEMdUFkFm7kmW1ZHxMTdzlMCy2/MIfgfpp12uvZHZtERIagsfYELcFpVjVTJ4sPh+SawPexgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155542; c=relaxed/simple;
	bh=EslzJJMqkthcUMFMyk8m6chx1s41wR3exbqWEeSABcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/o9kVqOEGFBJbmgCUrjV/S4liy23mp3uSRnUGYhaP0odrWnTRqy010sfcmmjzq2/cmYOupWTvKSMMqlX6WGsJ0ZYaMXxyuJWOHXUtA5lePlvMmexV4bqLiIce5iXbmIDlCMoHMd6+mkJVRCo2GjNRSAJiXJuYVWtjh6jVF57Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oDl0EX7P; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778155540; x=1809691540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EslzJJMqkthcUMFMyk8m6chx1s41wR3exbqWEeSABcI=;
  b=oDl0EX7PQCPdo00zhdWsO2rU5feOIH2senzwarx3HO2o9Zv3Navrh9H7
   sgq3w8hq0MVF2H3jb3gWluAq3qY+GA+8l1G7DdxuRWbM5/H9ULX0UFb5y
   WvrPcW+0rdt0L91dleQxJ0Lt109QJfTHjOTMfw1vY9L0SI8ZHrMM+dnaH
   6bRO/x9B/qkjdbMsUaWccqANwuEw7rD+vAlmz5aM4rVAwbVB/H/e6ar71
   3ZhpYth5rvBNQUPSslSXDeybW/+3gto1tI6tMct3GksU0MdnIUJCQ66bQ
   J8rZId0HWRf99OHi8P/hUZd4QmbXc2eSDdNuJxSeN4rsuTn3eUg635b8Y
   A==;
X-CSE-ConnectionGUID: yBpSBo4qQtCNmd1ecBacGA==
X-CSE-MsgGUID: tpTIs552R8K2d6BHX5VvgQ==
X-IronPort-AV: E=Sophos;i="6.23,221,1770620400"; 
   d="scan'208";a="224414037"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 May 2026 05:05:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 7 May 2026 05:05:38 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 05:05:35 -0700
From: <nicolas.ferre@microchip.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, <netdev@vger.kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] MAINTAINERS: change maintainers for macb Ethernet driver
Date: Thu, 7 May 2026 14:04:44 +0200
Message-ID: <20260507120444.9733-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8D7C4E7F68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285296-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nicolas.ferre@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Action: no action

From: Nicolas Ferre <nicolas.ferre@microchip.com>

I would like to hand over the macb maintenance to Théo, as I'm unable to
keep up with the recent flow of patches for this driver. After speaking
with Claudiu, he indicated that he is in the same position as me.
To help with this work, Conor has agreed to act as a reviewer.

I was given responsibility for this driver years ago, and I'm glad to
see it continue with talented developers.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37b105a443dd..ad60104f30a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4181,8 +4181,8 @@ F:	include/uapi/linux/sonet.h
 F:	net/atm/
 
 ATMEL MACB ETHERNET DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
+M:	Théo Lebrun <theo.lebrun@bootlin.com>
+R:	Conor Dooley <conor.dooley@microchip.com>
 S:	Maintained
 F:	drivers/net/ethernet/cadence/
 
-- 
2.43.0


