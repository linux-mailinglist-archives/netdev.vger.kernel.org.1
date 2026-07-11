Return-Path: <netdev+bounces-306854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AuXCDxlGUmq5NwMAu9opvQ
	(envelope-from <netdev+bounces-306854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:33:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0E741B03
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:33:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=b7hUmvAO;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306854-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306854-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D418300F11E
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA343C3C0E;
	Sat, 11 Jul 2026 13:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285841E5B88
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 13:32:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776779; cv=none; b=Zv6R1tQdhFRYPDNiwouA9K5Sut9gRtL6g6KjzU8dL9/7TtqChzwzjOk5GY5991XmJ/6NPLpCwZ8bI359OYacKMafyK1mQPe7KRy9BxtN3ZdQlnybudwINJ8OSaUyaDqDVXCJ7UMofLhZmgA2elmSmNKUHQcxj+xUb8SvxSxl1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776779; c=relaxed/simple;
	bh=6N8s8WpDJzEut9jXnSmRAPwDpWrRRlwQ0OVCcst2cvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwzsI1tTmAqrH+WPYwEqf6/JYVcjkpZqz0i6EgqB0odKJJj5grLIivFEPn+PM0TP1j990EFIF/tOEgMLlUNObjv455SM46Hksy7u3ETJ41iJy5YnY8bzFfsYovtIea8nzPSg3QrgYouCY4G8fEkRnx2IO5ooOAmKgFw7tDiglJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=b7hUmvAO; arc=none smtp.client-ip=50.112.246.219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783776778; x=1815312778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GKRJbIofdXLrYeFk4YuP+m2CmFCaXhx3FTzh99Bd4VA=;
  b=b7hUmvAOrVtRyzHsFbpkrJOnNiKZj9E+9cqZ+nsYk15xNzSt0PaoXmFE
   +v5Kj8QhA94VlHlsIO8mFAr2dugLdHnpflnv9yPcop8mNf2gg6MOYKLFA
   SXO2RED9LprojGdseanYpLCX2pqnK6qL65rkLftWHe6fK2VMkJeVwnLmB
   AWiwQryysTYsxSSSrFLrJi7dS73jOgWK3SF5XOFeclXoz6alQ0fTGOjuS
   /kRARCspuxCEiXPRlkj/XzcQZAu2gZI5ItZ7GJ2geJZVBZwl13/akaeer
   iVInxi4w+vE6Mh09YEkuF8ghCUvNKBZyR6noDIDjslE4tcc3yNMaxJJ8R
   w==;
X-CSE-ConnectionGUID: vdyG+9NkRkGo+kSHQkLhww==
X-CSE-MsgGUID: vzBp9IjDTPawjohMvXIupA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23288930"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 13:32:52 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:25614]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525] with esmtp (Farcaster)
 id c035339e-bd81-4714-b361-2bc44f40193d; Sat, 11 Jul 2026 13:32:52 +0000 (UTC)
X-Farcaster-Flow-ID: c035339e-bd81-4714-b361-2bc44f40193d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 13:32:52 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 13:32:50 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <kohei.enju@gmail.com>, Takashi Kozu
	<takkozu@amazon.com>
Subject: [PATCH iwl-next v1] igb: remove ASSERT_RTNL() from igb_write_rss_key()
Date: Sat, 11 Jul 2026 22:32:15 +0900
Message-ID: <20260711133239.29270-2-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,gmail.com,amazon.com];
	FORGED_SENDER(0.00)[takkozu@amazon.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306854-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:kohei.enju@gmail.com,m:takkozu@amazon.com,m:andrew@lunn.ch,m:koheienju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takkozu@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DA0E741B03

igb_runtime_resume() calls __igb_resume() with rpm=true, which
skips rtnl_lock() to avoid deadlocks. On that path __igb_open()
-> igb_configure() -> igb_setup_mrqc() -> igb_write_rss_key()
runs without rtnl held, so ASSERT_RTNL() fires a false-positive
WARN on every runtime resume. Drop it.

Fixes: dfaf57ef99cf ("igb: prepare for RSS key get/set support")
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 65014a54a6d1..4eb586f9af99 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3031,8 +3031,6 @@ void igb_write_rss_key(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 
-	ASSERT_RTNL();
-
 	for (int i = 0; i < IGB_RSS_KEY_SIZE / 4; i++) {
 		u32 val = get_unaligned_le32(&adapter->rss_key[i * 4]);
 
-- 
2.54.0


