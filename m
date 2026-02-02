Return-Path: <netdev+bounces-255748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLKyLvZLgGne5wIAu9opvQ
	(envelope-from <netdev+bounces-255748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:02:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25642C902D
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD673004627
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 07:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7808306B02;
	Mon,  2 Feb 2026 07:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09F2FFF87;
	Mon,  2 Feb 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015731; cv=none; b=nOpF3gx8+Tpja4HHuXrAGP2i0/Y1GzAgomq+7w41WlS1+XAe47DYzIzBoJOnlrGf53tEGKA1OGEJbnBhV+22pPZsiCr99i2AHF71drNETISTiiL+ppFtxvksdzSKN1vTH9B+/uWgO01B/mAud25qXR4G9OWOkrUC4bgKg2MckXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015731; c=relaxed/simple;
	bh=w2b1ntVS1o5foLpIBIHR8PBWnn5GOU1gK40AGtzTNL4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Z0SABvH4G8+Q9ZUmuaWbZ+IEIo0cNHxla1qqUBoqz24y6TT3Be/tXNz3V4WRmOD7oWSqvoonTT4V4Well0uFmCR8xV3ukqV8fhuaQdyZGzVSnaIIsISMd4ylJ5rz7zk0ev87ZufcSUInM33GEJDn7rYbXVdlD+z8tAj0ZR1zvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Feb
 2026 14:57:00 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Feb 2026 14:57:00 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v3 00/15] net: ftgmac100: Various probe cleanups
Date: Mon, 2 Feb 2026 14:56:54 +0800
Message-ID: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZKgGkC/2XNQQqDMBQE0KtI1k3J/2oIXfUepYsYfzRQoySpW
 MS7N2RV6nIY5s3OIgVHkd2qnQVaXXSzz6G+VMyM2g/EXZ8zQ4EtoFDcpmHShpsXaf9eOIoOse5
 sIxWwPFoCWbcV8ME8Je5pS+yZm9HFNIdPeVqh9BmVAkT7j67ABe+kokbXvbId3XVciPpEZryae
 Sreij8GyJOB2VBgG7ACLGp1Mo7j+AKmmWGa/wAAAA==
X-Change-ID: 20251208-ftgmac-cleanup-20b223bf4681
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015419; l=2429;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=w2b1ntVS1o5foLpIBIHR8PBWnn5GOU1gK40AGtzTNL4=;
 b=+PCBrw2Z/8AjKd4w0Bo5guzn24SwBfD9PH7yo2UzdhZsX87IYNMn+efE93+QdyJkC+9OfqzFG
 hh6tNvoE9DJA82BJxs9SAkkWZiN/yGcn6TmbcGAPzuxcu0vatIPRE4i
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255748-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:mid,aspeedtech.com:email,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25642C902D
X-Rspamd-Action: no action

The probe function of the ftgmac100 is rather complex, due to the way
it has evolved over time, dealing with poor DT descriptions, and new
variants of the MAC.

Make use of DT match data to identify the MAC variant, rather than
looking at the compatible string all the time.

Make use of devm_ calls to simplify cleanup. This indirectly fixes
inconsistent goto label names.

Always probe the MDIO bus, when it exists. This simplifies the logic a
bit.

Move code into helpers to simply probe.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v3:
- [06/15] Add check for devm_clk_get_optional_enabled().
- [09/15] Directly return status from ftgmac100_setup_mdio(). That is
  [13/15] patch behavior, so delete [13/15].
- [09/15] Adjust err lable.
- Add a new patch to make use of devm_ methods for mdiobus to simplify
  cleanup.
- Link to v2: https://lore.kernel.org/r/20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com

Changes in v2:
- Add net-next prefix.
- [08/15] Updated commit message.
- [04/15] Deleted {}.
- Link to v1: https://lore.kernel.org/r/20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com

---
Andrew Lunn (14):
      net: ftgmac100: List all compatibles
      net: ftgmac100: Add match data containing MAC ID
      net: ftgmac100: Replace all of_device_is_compatible()
      net: ftgmac100: Use devm_alloc_etherdev()
      net: ftgmac100: Use devm_request_memory_region/devm_ioremap
      net: ftgmac100: Use devm_clk_get_enabled
      net: ftgmac100: Simplify error handling for ftgmac100_initial_mac
      net: ftgmac100: Move NCSI probe code into a helper
      net: ftgmac100: Always register the MDIO bus when it exists
      net: ftgmac100: Simplify legacy MDIO setup
      net: ftgmac100: Move DT probe into a helper
      net: ftgmac100: Remove redundant PHY_POLL
      net: ftgmac100: Simplify condition on HW arbitration
      net: ftgmac100: Fix wrong netif_napi_del in release

Jacky Chou (1):
      net: ftgmac100: Use devm_mdiobus_alloc/devm_of_mdiobus_register

 drivers/net/ethernet/faraday/ftgmac100.c | 342 ++++++++++++++++---------------
 1 file changed, 180 insertions(+), 162 deletions(-)
---
base-commit: a22f57757f7e88c890499265c383ecb32900b645
change-id: 20251208-ftgmac-cleanup-20b223bf4681

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


