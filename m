Return-Path: <netdev+bounces-274089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGgYEGIRzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 479BA37A869
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20022309F89E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F104240711E;
	Wed,  1 Apr 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Voah0Pii"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87572E8DEC;
	Wed,  1 Apr 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046369; cv=none; b=FgN5trwouadk6Lmrb7LIg5f4v1v/10ACqekfPeCtLu80nNBE+icam8LrzXrxPUkh8HfwvCGkbuIqWG6kq8ySpqrphg5yeTiJ7o/DWw1MeujZwnsuLDI6ozgHCvWOZ5BPW7+2THThusmUBGTDLZ7C7afxQXa2/GmM+bXg/nSKYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046369; c=relaxed/simple;
	bh=U/vmET87/7jfdbNUxMDjD8n3bscYZ1KZ5mcNwJJFrp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WrrNyU9oOF/7rU3FxMHzoPXUvudOWj8TGIYsv2VNGiuhu5Tv2KBNBD9z8bIRMqHyU2qyJl+Xcrr5ApBRIg/TNX0I6fpcmmFjMa/eEqxCDWRn4nVZUlYG1WhYbKym3o2aBqSu/0WlyZsvyniLR8lYDXoxx6gH/TF5zYqykylR9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Voah0Pii; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=l0q4mDPNZn9d2zngjDTeDMoVQBeBADZn5IY9XJjSkRU=; b=Voah0Piiz36h8FePLR/6Apla9L
	94vZXyylBhu3oMrpPw+a+M6YSjVWi7/ls26IleNSIgkTg0Jt821RJg9voO/mWuj8z5ZEjrKr+WsLp
	/qieh7YXXxuCbBrhWDrAWJM+Wj2mMiCxFC3PzciBOF6iFhzAGjXDkgT9jOFgB+Zwf9tFKv/dAEJLV
	oQ12t9MB6tJZBUMUb6MTlJVxzbayjES0Yx1d/by0nrpU+OUxe+mEEQtbq/4+elbj9nP+H8V/ftVTh
	eUz8zzrGRBgg2/VY5eDFYvUo9sr9+vkXdv6iOpE34p38j/PrTFTAlNQYKQ+ZXvMNYBpL43xmy68cb
	FKmJOEpw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue2-000IQS-1Z;
	Wed, 01 Apr 2026 14:26:02 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue1-00089b-38;
	Wed, 01 Apr 2026 14:26:01 +0200
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
Subject: [PATCH v3 0/5] J722S SGMII support
Date: Wed,  1 Apr 2026 14:25:20 +0200
Message-ID: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27958/Wed Apr  1 08:24:34 2026)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tq-group.com:url,ew.tq-group.com:dkim,ew.tq-group.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 479BA37A869
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
https://patchwork.kernel.org/project/netdevbpf/list/?series=1075806

Fallback compatible strings allow for the patches to be applied in any
order and to go through different trees without breaking existing
functionality.

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

 .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++-------
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 20 ++++++++++------
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 12 ++++++++--
 drivers/phy/ti/phy-gmii-sel.c                 | 13 ++++++++++
 drivers/phy/ti/phy-j721e-wiz.c                | 24 +++++++++++++++++++
 5 files changed, 75 insertions(+), 18 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

