Return-Path: <netdev+bounces-257434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PlsL15dhWmfAgQAu9opvQ
	(envelope-from <netdev+bounces-257434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:17:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2300CF99CA
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8AA300A8E4
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289E2C027E;
	Fri,  6 Feb 2026 03:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DE227BB5;
	Fri,  6 Feb 2026 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347867; cv=none; b=JZNLEaNtc1v0qsbYmVt2ELw4a5KrZ11Jxm2+x1aMpvEff/aew8cSv0NyJOrhFN2oc22oWJ+otR6EYA9VkTQH/6vZ4UVBmFezfRsRU54ZVaEZwPywzyCBkB3xmLbzuu+f9W/6HSzowRLn8vRjeiJWncZVFm9qhvv24m0ZP6HM67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347867; c=relaxed/simple;
	bh=z25eX0S/LACEFoL8AIe7vIAYExg927ae+1WlWleqI/E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=erKzHICOdTdHalOvt+m2iN9OLexFsdpGDhaFWNjQY4FgxhwCmKa2ZHFM217dsDApIFY/0qiLOgqegaD9/n9X3L+6hy1n5FeLoznwRGtI6TMCAdSM/rMDlMgwLNhdXZcwNvSQ3YEmmNSMYKE1LzFEl2z+QbQeqQ9X7IOv83U04QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Feb
 2026 11:17:44 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Feb 2026 11:17:44 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v5 00/15] net: ftgmac100: Various probe cleanups
Date: Fri, 6 Feb 2026 11:17:40 +0800
Message-ID: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFRdhWkC/23PwW7DIAwG4FepOI8KG0JIT3uPaQcgpkFaSRRY1
 KnKu4/m0qrpxdKvX/4s31imOVJmp8ONzbTEHMdUQ/NxYH6w6Uw89jUzFNgACsNDOV+s5/6HbPq
 dOAqHKF1Q2gCrS9NMIV438IslKjzRtbDv2gwxl3H+2y4tsPUV1QJE84ouwAV32pCysjfB0afNE
 1FfyA9HP142b8EnA/TOwGoYCAqCgIDWvDXkw6hjZ8hqaKut6VWDRti3hno21M5Q91/aINuuk51
 r9c5Y1/Uf/f+BnocBAAA=
X-Change-ID: 20251208-ftgmac-cleanup-20b223bf4681
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770347864; l=2990;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=z25eX0S/LACEFoL8AIe7vIAYExg927ae+1WlWleqI/E=;
 b=uZ4SvK2ryUuB8YzW/C6EUwzt4UkepAvApyTuwVB/cZU7QYLoPtpIpOFbrdZEMWjM0Eiyv6ZEA
 Mm62Df0PtCpAZu/STFPhU5gnbUBESQdqkOWDwCcfFE1lbLZE12B8Ijh
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
	TAGGED_FROM(0.00)[bounces-257434-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2300CF99CA
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
Changes in v5:
- [8/15] Updated commit message.
- [8/15] Assigned priv->ndev to NULL when failed at ftgmac100_probe_ncsi()
- [9/15] Updated commit message.
- [9/15] Added a check for priv->mii_bus whether exists.
- Link to v4: https://lore.kernel.org/r/20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com

Changes in v4:
- [08/15] Add err lable to ncsi_unregister_dev() or
  fixed_phy_unregister() when getting any fail in ftgmac100_probe_ncsi()
- Link to v3: https://lore.kernel.org/r/20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com

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

 drivers/net/ethernet/faraday/ftgmac100.c | 356 +++++++++++++++++--------------
 1 file changed, 194 insertions(+), 162 deletions(-)
---
base-commit: 24cf78c738318f3d2b961a1ab4b3faf1eca860d7
change-id: 20251208-ftgmac-cleanup-20b223bf4681

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


