Return-Path: <netdev+bounces-269035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIPWNjayumlWawIAu9opvQ
	(envelope-from <netdev+bounces-269035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:09:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9E2BCB8F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65CB23060CF0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8533DBD63;
	Wed, 18 Mar 2026 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="nmrnwH9p"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD03D9DDE;
	Wed, 18 Mar 2026 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842820; cv=none; b=f+0ThNez6dsr43/zYJOd6YERRFmNWKjERZomQZWtnndCrSVVFXGfmPTOUMt0ztoOskszMwkNYE4DmfGaeyaqRTJRckZnMadHrMlqKphEDJmgAn/yYkUkisxfjj94IdvI+LSnHB83Nnc5Xok/vD3DdAloTiFNiUTnFXTdKb1mXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842820; c=relaxed/simple;
	bh=gliH2u6PUd4HPQcSEggmPnW0d8g+GgTPYXptlk/xxXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iscSjiwBCD/Sc11xznXDn+ISq605yX1hEvLurSq+iwiHi9aiMOR32mE9IILQw3Z2h4zUzvH8vsR/ZDI0gaOV/y9YQyCd7z1pyNUEwTM+VIqyLyNodlpPzKK5KTPYdqitIBoy49KBStXH8cIBEqNEajbO0Z4CimP1TZ6GR7JfBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=nmrnwH9p; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=A91VE9zUrSarhv4N3nkmhVVO6faCulKxcborukDvgLY=; b=nmrnwH9pG2mqsKD1lZrM19kaDU
	/3aLB0+tIO0Vrg8qlynkCu8JEZ3w06Z3JVCUCNpcxuHccWniFaEAjXhiKdToTHTKhF2CaKDLbE/oM
	qKxusimom65Ks2viu8TFARbsEiJJrrWO3CglRF6uKKictQ/+quEkR4YEM7xbaZH0/bxCvSqAjnEPH
	E/N+VMjVNkSM9s3Oi54xkY6G/ZegcgfQnh0Kl5TP9hiRQLSKWv5gASuq915BzCX0vXR+hYMz6Ta4t
	1UySG8addNXDFPx4ZyiLGdqsveKKpUOnKat0muU+tAduH2XTAk1wiDtGqJJYqrqqL60VSuPYRqD/Q
	XLf5MjnA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w2rXv-000BpY-2w;
	Wed, 18 Mar 2026 15:06:52 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w2rXT-000B1s-08;
	Wed, 18 Mar 2026 15:06:23 +0100
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
Subject: [PATCH 0/7] J722S SGMII support
Date: Wed, 18 Mar 2026 15:05:22 +0100
Message-ID: <cover.1773751309.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27944/Wed Mar 18 07:24:13 2026)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269035-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tq-group.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ew.tq-group.com:dkim,ew.tq-group.com:mid]
X-Rspamd-Queue-Id: 7CC9E2BCB8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S CPSW and SERDES are very similar to the variants found on the
AM64, but they additionally support SGMII. Introduce new compatible
strings for the J722S to add this support to the drivers.

This is a prerequisite for the Single-Pair Ethernet interface of the
TQ-Systems MBa67xx baseboard for the TQMa67xx SoM, which will be
submitted separately.

Nora Schiffer (7):
  dt-bindings: phy: ti: phy-j721e-wiz: Add ti,j722s-wiz-10g compatible
  dt-bindings: phy: ti: phy-gmii-sel: Add ti,j722s-phy-gmii-sel
    compatible
  dt-bindings: net: ti: k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss
    compatible
  phy: ti: phy-j721e-wiz: add support for J722S SoC family
  phy: ti: gmii-sel: add support for J722S SoC family
  net: ethernet: ti: am65-cpsw: add support for J722S SoC family
  arm64: dts: ti: k3-j722s-main: use J722S compatible strings for SGMII
    support

 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   |  1 +
 .../bindings/phy/ti,phy-gmii-sel.yaml         |  1 +
 .../bindings/phy/ti,phy-j721e-wiz.yaml        |  1 +
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 12 ++++++++--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  8 +++++++
 drivers/phy/ti/phy-gmii-sel.c                 | 11 +++++++++
 drivers/phy/ti/phy-j721e-wiz.c                | 24 +++++++++++++++++++
 7 files changed, 56 insertions(+), 2 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


