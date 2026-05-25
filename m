Return-Path: <netdev+bounces-291273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGFiMTcbFGoGJwcAu9opvQ
	(envelope-from <netdev+bounces-291273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:49:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 612505C8CB9
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D9F130067A3
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEDE35DA46;
	Mon, 25 May 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1O+VvpGy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FD328B62
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702581; cv=none; b=m8DQXZZCpaSy7bV+VWA1mm0azDTI5BjBXSyzzoS0uy2C0MEsPgwB8AwSX7L5V/cAVYI/PNY3HM2JOxYXri75Mm+nDBn6VynzhH4toOdal43MbzPGQZVsezMoKNLEPRZMwUtDfhPBR/CwA6egfsBHpqzb7c59CPagpu4ao+x5pqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702581; c=relaxed/simple;
	bh=9DWvzXM5x3I+jWn2CjFLRTSopAZVGMawXrOIYXOe3SQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wt7ZnRvBvKdEHtNLEzhcVg2FUchOiM4wakdiPwrmzKDXfGyYPr9U6JQjNxqM+Lk7SClhrgQGMGPs6KL6raBXwdUwCWpUgdpzb/PKCWtO0zWxNTUZ/XDK3TqDOg5PSY2aB2WVkNuaAqkx0Ijy1Tuc2QFkqUe6RF0G84TS4iJTCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1O+VvpGy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779702581; x=1811238581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9DWvzXM5x3I+jWn2CjFLRTSopAZVGMawXrOIYXOe3SQ=;
  b=1O+VvpGyhneZ7K+BsKtHRVCOJ3UVKSJzdixhkRpqG8OaljBFDGnjOmZn
   JdzWf/W3j9oSOSnN7lGjB4mmeI2XN9keN7pJBzFkUBQZaGQoFHlQnTBpx
   ytcbaeWhIgxhIYODLqgH5wdagE3GqUvvWd7QfUuCzmET5gUNDzxuDPUu2
   iaWcs0FYVfpE4+TIRBiARxbmBUwwwhNLMeLy5r1Ja98bMUIRFYtFj2/5i
   5hLrE4TTJMnOnbxmHp3bmnNlvUTgYX59y6fUbaYwdTMKLIAi5IBflXy9L
   syfdhyqCA1Wzw/bVn3nbOpBRK82BfivgcdKkd77kyUdZVNtAACyhP72XQ
   w==;
X-CSE-ConnectionGUID: 9co2/ujtTM+KubPcTKSk6A==
X-CSE-MsgGUID: JzD4Zim0StyhxoPkAkOtxg==
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="58001449"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 02:49:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 25 May 2026 02:49:38 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 25 May 2026 02:49:35 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<richardcochran@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<Raju.Lakkaraju@microchip.com>
Subject: [PATCH net 0/2] net: lan743x: ptp: Fix simultaneous PEROUT on PCI11x1x
Date: Mon, 25 May 2026 15:19:29 +0530
Message-ID: <20260525094931.10371-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,kernel.org,google.com,redhat.com,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291273-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 612505C8CB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PCI11x1x hardware supports up to 12 PTP-IO pins as simultaneous
periodic outputs, but the driver was limited to 2 due to two bugs:

1. ptp_io_perout[] was sized by LAN743X_PTP_N_PEROUT (2) and n_per_out
   was hardcoded to LAN743X_PTP_N_EVENT_CHAN (2), so any perout index
   above 1 was rejected immediately by the PTP core.

2. lan743x_ptp_reserve_event_ch() refused to assign a channel already
   in use, and lan743x_ptp_release_event_ch() unconditionally tore down
   the hardware channel on first release — both preventing multiple pins
   from sharing the same event channel.

Patch 1 introduces PCI11X1X_PTP_IO_MAX_OUT_PINS (12), resizes the
arrays, and sets n_per_out conditionally for PCI11x1x devices.

Patch 2 fixes the channel assignment logic: maps perout indices to
channels via index % 2, adds refcount-based sharing, and guards
hardware teardown until the last user releases.

Thangaraj Samynathan (2):
  net: lan743x: ptp: Add PCI11X1X_PTP_N_PEROUT and extend ptp_io_perout
    array
  net: lan743x: ptp: Fix PEROUT event channel assignment on PCI11x1x

 drivers/net/ethernet/microchip/lan743x_ptp.c | 87 ++++++++++++--------
 drivers/net/ethernet/microchip/lan743x_ptp.h |  5 +-
 2 files changed, 55 insertions(+), 37 deletions(-)

-- 
2.34.1


