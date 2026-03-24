Return-Path: <netdev+bounces-271034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEMoNICGwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:41:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 295F9308755
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5EA33030343
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665BC3F9F55;
	Tue, 24 Mar 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="SdxsBP5a"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F943F99CD;
	Tue, 24 Mar 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355430; cv=none; b=POf4XFjnu1PnqculilLo9MAOJ06cwk0vCDSf6LMJ7ewFtKGsnkqE6JADYCVe+Sgl6EOQ7qiRxIrOJFjLpExoDXuxTnpMkQrk2Sge+YrQaqU9t3/xUtQHguFy98tP+K4pLHZlKFdRxFB6jG4JOS+WV20q5ySEOqVNep1MxhN7gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355430; c=relaxed/simple;
	bh=rQpwsN7Cjk47XkxRTNapKlV5btqq58zaFAbWUaMcZsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zjky9EniRwEo080SWwsWtzegDk/8I0xYRHdBPr9379AUjNwZsjTw7Z9qmwAIoUBrjKbH0jX0WTZlfVgrbAKoC127rztCSQ3t9wmKC6OLGbBdj+JuYwXuHlteHNng+knItqPLbXlrdw1ZhLoubRomn784gyMJZaOj1nZ0FYbgKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=SdxsBP5a; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=r2f84TTEWNrh6ZSSjAaDbdTly3GCRBMKBI+zPfcgc9Y=; b=SdxsBP5aJYd4z/xFwxCiA3pg2V
	sTHuoCjzNSO3ZJ5umP6P3cZXGC/5ziC+kfIm8sJEHJRiic2wPmYXNFUyM9l0fHLsDJ4f4JVlxsI33
	OcnmHXrll+bTLVa6hnH8JYiWjnddwpwwwGALji7C/57ZbXsMUNx2dJCTPoer0xGgcaRzdPPvFKgC7
	NUaR8rCrpNqUkxwGc0LzrZ/jCaeGVzBvJtmz0oO7QUbWKPh7SwfGpiQFivoiCeuwAt5FX6Vy5+tO1
	SpPef78ma2kA8OHhtNyR6JFaLxPzt9hwGA08McUAIbCzyNv6iFKRbIm4E7s0k5ILxji0XZDDQdgmx
	JybvRH/w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tp-0005qD-1u;
	Tue, 24 Mar 2026 13:30:21 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tp-000Pna-1M;
	Tue, 24 Mar 2026 13:30:20 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 0/7] J722S SGMII support
Date: Tue, 24 Mar 2026 13:29:36 +0100
Message-ID: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27950/Tue Mar 24 07:24:19 2026)
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
	TAGGED_FROM(0.00)[bounces-271034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tq-group.com:url,ew.tq-group.com:dkim,ew.tq-group.com:mid]
X-Rspamd-Queue-Id: 295F9308755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S CPSW and SERDES are very similar to the variants found on the
AM64, but they additionally support SGMII. Introduce new compatible
strings for the J722S to add this support to the drivers.

This is a prerequisite for the Single-Pair Ethernet interface of the
TQ-Systems MBa67xx baseboard for the TQMa67xx SoM, which will be
submitted separately.

v2:
- Keep support for the AM64 compatible strings as a fallback, adjust commit
  messages (patches 1-3 and 7)
- No changes to patches 4-6

Nora Schiffer (7):
  dt-bindings: phy: ti: phy-j721e-wiz: Add ti,j722s-wiz-10g compatible
  dt-bindings: phy: ti: phy-gmii-sel: Add ti,j722s-phy-gmii-sel
    compatible
  dt-bindings: net: ti: k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss
    compatible
  phy: ti: phy-j721e-wiz: add support for J722S SoC family
  phy: ti: gmii-sel: add support for J722S SoC family
  net: ethernet: ti: am65-cpsw: add support for J722S SoC family
  arm64: dts: ti: k3-j722s-main: use J722S compatibles for WIZ, gmii-sel
    and CPSW3G

 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 20 ++++++++++------
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++-------
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 20 ++++++++++------
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 12 ++++++++--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  8 +++++++
 drivers/phy/ti/phy-gmii-sel.c                 | 11 +++++++++
 drivers/phy/ti/phy-j721e-wiz.c                | 24 +++++++++++++++++++
 7 files changed, 94 insertions(+), 25 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

