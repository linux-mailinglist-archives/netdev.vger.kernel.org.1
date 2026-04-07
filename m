Return-Path: <netdev+bounces-275960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDfBBtbt1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:43:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BEF3ADDB3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94E3E30143F4
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FD3AEF43;
	Tue,  7 Apr 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lqLvqhF3"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388022D7B5;
	Tue,  7 Apr 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562193; cv=none; b=S5YET52PDXnWMFFOjUQo60Gxsd3Ev4keoMTlQw1G0KkVOB9m46lIikcKqfj0oIXn0GCLzx0dvylioMsn8Rbi28yUrC+BBvR0hXp8wozh/ZcSPUVk5J0xRtmZr8CWk29mWK/eFiLFHyyuuP7VLI3tCupvDRycz1VZUJMOgbFhwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562193; c=relaxed/simple;
	bh=nHrM03wRuMc4wMBBtQ8fqkoqDTyblmWSd3XLIUHzVpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sqL0VqY1lj7mC7OxGRIgoPHIogQ6t+AOWxvYIsxJsICxVlcgR3e2mICO9QtiwZlRn9TG/02Z/rF/hqF9i7JoHkBoN4TOaFv+/wSss+IWADJ9/qNrmzy9jvzvcWJg7dWkPaWLm4QX8BYRD6h2t/X56jUf3QnK84ZO8GE5RqeS9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lqLvqhF3; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=m8+dxvmtECNtO6/nlvcPTQOUYVBF4c5AJ3AT7nnB+dY=; b=lqLvqhF3ilaOrBHq8SKJmK6IJv
	ypuf7HzVvhUCp4JK/C6quvv7u1N0L0XY1DKGnEA1k+Ndys6s+N3Wk7jq5JErjE4ECWaiCx9p/sZ2d
	VYVwGQNJgfLe8a6FmhdGP9TAwUHztx/BWLd0bMB6/rzoRADtoKpdVJ3P7wiThH6Q2OkKPr05rOFMO
	hFMEeMNFS6VfhK6GJgUr17EZtyp+LVe9VxQHJXq27a8J7d9DtDwy0VEawEQJ/7gBoijtc9C0+3EZX
	E2/q+dw/V1jczghDcQiMUlstZKNp1eJYg/nK+HgT4ZYt1lVvqZt0wDNBpBIFmHw70zsJQHRmXtZOj
	Nb8wtueA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA4pn-000IJI-0U;
	Tue, 07 Apr 2026 13:43:07 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA4pl-000PKA-1n;
	Tue, 07 Apr 2026 13:43:06 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v4 0/5] J722S SGMII support
Date: Tue,  7 Apr 2026 13:42:32 +0200
Message-ID: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27964/Tue Apr  7 08:24:40 2026)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275960-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A8BEF3ADDB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S CPSW and SERDES are very similar to the variants found on the
AM64, but they additionally support SGMII. Introduce new compatible
strings for the J722S to add this support to the drivers.

This is a prerequisite for the Single-Pair Ethernet interface of the
TQ-Systems MBa67xx baseboard for the TQMa67xx SoM, which will be
submitted separately.

For SGMII to actually work on the J722S, the am65-cpsw needs to be extended
as well, which has been submitted for net-next:
https://patchwork.kernel.org/project/netdevbpf/list/?series=1078111

Fallback compatible strings allow for the patches to be applied in any
order and to go through different trees without breaking existing
functionality.

v4:
- remove redundant items: level from DT binding YAMLs

v3:
- Drop am65-cpsw changes from this series, they need to go through net-next
- Fix missing PHY_GMII_SEL_RGMII_ID_MODE and PHY_GMII_SEL_FIXED_TX_DELAY in
  gmii-sel driver for RGMII delay mode configuration

v2:
- Keep support for the AM64 compatible strings as a fallback, adjust commit
  messages
- Drop reference to AM64_CPSW_QUIRK_CUT_THRU flag, which only exists in the
  TI vendor kernel

Nora Schiffer (5):
  dt-bindings: phy: ti: phy-j721e-wiz: Add ti,j722s-wiz-10g compatible
  dt-bindings: phy: ti: phy-gmii-sel: Add ti,j722s-phy-gmii-sel
    compatible
  phy: ti: phy-j721e-wiz: add support for J722S SoC family
  phy: ti: gmii-sel: add support for J722S SoC family
  arm64: dts: ti: k3-j722s-main: use J722S compatibles for WIZ, gmii-sel
    and CPSW3G

 .../bindings/phy/ti,phy-gmii-sel.yaml         | 23 +++++++++++-------
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 19 +++++++++------
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 12 ++++++++--
 drivers/phy/ti/phy-gmii-sel.c                 | 13 ++++++++++
 drivers/phy/ti/phy-j721e-wiz.c                | 24 +++++++++++++++++++
 5 files changed, 73 insertions(+), 18 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


