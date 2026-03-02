Return-Path: <netdev+bounces-262600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J53I35npWmx+wUAu9opvQ
	(envelope-from <netdev+bounces-262600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:33:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9141D6941
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 309EA3013CBE
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98C39B95E;
	Mon,  2 Mar 2026 10:24:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865F39A81C;
	Mon,  2 Mar 2026 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447080; cv=none; b=mkSNqLHzpS2vuCB6hIuoYqvcbpYaVx8bfc1TJUEqwAKCQePGwZZ9W1yGNFNc5vS4Ax6IZhaB/SMZtCBxDkR3xVE68eEolYBFhZuLnOJVqpUQLyKLh+QBwL1irnwNbFwTv7nn2rjAKy/G4tMdqMDYWyE3SjhHaAm5myvyKL6Hu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447080; c=relaxed/simple;
	bh=eWVFKW3A7MKx5p5Dxot9aQIkqN7okMarVB1Y+6uExOA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kjekh/pd7jfGcKDVmm5JXMQUb5FdvgzKsYwMVtAu4feAVd/9WqKDMvTkT6llhK94wG/rrBeiYHUcGMKzlz/S8/DRyU83La6oaTEf5bc9+1RzgknG9VaFDn/2ZQ9T8E3HZKtQMV1a6C1ixJugJ9VC+hzm7UyBJvkpAUuJ7//m7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Mar
 2026 18:24:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Mar 2026 18:24:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v6 0/5] Add AST2600 RGMII delay into ftgmac100
Date: Mon, 2 Mar 2026 18:24:27 +0800
Message-ID: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtlpWkC/4XRwWrDMAwG4FcpPs9BlmM73WnvMUpwbaXx1iZdk
 oaGkneflsI6aGAnI8T/GUk30VOXqBevm5voaEx9ahsu7MtGhNo3B5Ipci0Q0CjQSnaHU0plpKO
 fSrQA0gPsAfMiOLKCY+eOqnRdyHfR0CAbug5ix5069UPbTctfo1r6Pyyrjp8tYqYM2q12UskPH
 z6nMtTt5c33Z6I4UKiz0J4WacRHulAarNagMq2Lwqj/w/o3rHik54lGLUES+gqtsZWLblXJ/yg
 KVpScFRN81BicZWdVMQ8FwawohpV9xAKBpeiflfm+846+Lny94b743Tx/A56cdT3bAQAA
X-Change-ID: 20251031-rgmii_delay_2600-a00b0248c7e6
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772447070; l=3669;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=eWVFKW3A7MKx5p5Dxot9aQIkqN7okMarVB1Y+6uExOA=;
 b=6pvceYIVye2BfNotK79vvawC/nSneY5yAm8dVU1hEUqBkfrHg+QV7ZvBEiOwZWteK1lI8d4dj
 t2y1LsqEvh8CXYR6CroaDyZjuU05z/WnPqtcLMfjh4Y1sMdAk1GhQIu
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262600-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aspeedtech.com:mid,aspeedtech.com:email]
X-Rspamd-Queue-Id: 9A9141D6941
X-Rspamd-Action: no action

This patch series adds support for configuring RGMII internal delays for the
Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
units differ.
The device tree bindings are updated to restrict the allowed phy-mode and delay
properties for each MAC type. Corresponding changes are made to the device tree
source files and the FTGMAC100 driver to support the new delay configuration.

This enables precise RGMII timing configuration for AST2600-based platforms,
improving interoperability with various PHYs

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v6:
- Adjustments made according to net: ftgmac100: Various probe cleanups.
- Split [net-next,v5,3/4] net: ftgmac100: Add RGMII delay support for AST2600.
  1. Confgure RGMII delay value according to rx/tx-internal-delay-ps from dts
  2. Keep RGMII delay value for old dts
- Link to v5: https://lore.kernel.org/r/20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com

Changes in v5:
- Remove the new property, "aspeed,rgmii-delay-ps" from yaml and driver
- Add aspeed,scu to aspeed-g6 dtsi back
- Determine delay value from bootloader and tx/rx-internal-delay-ps to
  configure RGMII delay value with phy-mode
- Add a helper for AST2600 to get phy driver handle
- Link to v4: https://lore.kernel.org/r/20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com

Changes in v4:
- Remove the compatible "aspeed,ast2600-mac01" and
  "aspeed,ast2600-mac23"
- Add new property to specify the RGMII delay step for each MACs
- Add default value of rx/tx-internal-delay-ps
- For legacy dts, a warning message reminds users to update phy-mode
- If lack rx/tx-internal-delay-ps, driver will use default value to
  configure the RGMII delay
- Link to v3: https://lore.kernel.org/r/20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com

Changes in v3:
- Add new item on compatible property for new compatible strings
- Remove the new compatible and scu handle of MAC from aspeed-g6.dtsi
- Add new compatible and scu handle to MAC node in
  aspeed-ast2600-evb.dts
- Change all phy-mode of MACs to "rgmii-id"
- Keep "aspeed,ast2600-mac" compatible in ftgmac100.c and configure the
  rgmii delay with "aspeed,ast2600-mac01" and "aspeed,ast2600-mac23"
- Link to v2: https://lore.kernel.org/r/20250813063301.338851-1-jacky_chou@aspeedtech.com

Changes in v2:
- added new compatible strings for MAC0/1 and MAC2/3
- updated device tree bindings to restrict phy-mode and delay properties
- refactored driver code to handle rgmii delay configuration
- Link to v1: https://lore.kernel.org/r/20250317025922.1526937-1-jacky_chou@aspeedtech.com

---
Jacky Chou (5):
      dt-bindings: net: ftgmac100: Add delay properties for AST2600
      ARM: dts: aspeed-g6: add aspeed,scu property for MAC
      net: ftgmac100: Add RGMII delay support for AST2600
      net: ftgmac100: Support rgmii delay in old dts with AST2600
      ARM: dts: aspeed: ast2600-evb: Configure RGMII delay for MAC

 .../devicetree/bindings/net/faraday,ftgmac100.yaml |  42 ++-
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts    |  20 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   4 +
 drivers/net/ethernet/faraday/ftgmac100.c           | 318 ++++++++++++++++++++-
 drivers/net/ethernet/faraday/ftgmac100.h           |  25 ++
 5 files changed, 388 insertions(+), 21 deletions(-)
---
base-commit: 01857fc712f6469cab9cc578120cdc80f1c2a634
change-id: 20251031-rgmii_delay_2600-a00b0248c7e6

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


