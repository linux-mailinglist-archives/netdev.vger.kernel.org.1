Return-Path: <netdev+bounces-263694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM7KF8f9p2mlnAAAu9opvQ
	(envelope-from <netdev+bounces-263694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:39:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3CB1FDBE5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA13A30F11B1
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473E39902E;
	Wed,  4 Mar 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gU6aUdC6"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63473947A9;
	Wed,  4 Mar 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616978; cv=none; b=gd6xiY2N9KbYSJMzIMqxYbmXa5JLKIbCAi7p6jSE90lei/wgRXf5EP2cli5sCoPKG2WFp2OQIU6LDk1l5WE3yjM728vM3JjR87HRjXj3urQnZJfYicJ408O0sKEyFeTKjURXG+3dltVhSrjT3YBuxA3WXUIUWtE48wN9nj5oeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616978; c=relaxed/simple;
	bh=2R7/eNnX/6fgjXow5X/hQIDpbueZctqQyMkZeUPD3Zg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h9UceQthZjyRgzLkcyemEJrA58rycfNzBmqCfsEGA1BNr+zfXpkErZNOuR6cbJFhGqRYtAli+BqEq6Qzj8bWp+EbL3q7cdoBrwKEKR0DhUYYGNBv3QQXXwpuTBbDPyCQ59MOkf0C87rhBuW+4Nwj8yd3C0m1+jBStwfDL80uewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gU6aUdC6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772616974;
	bh=2R7/eNnX/6fgjXow5X/hQIDpbueZctqQyMkZeUPD3Zg=;
	h=From:Subject:Date:To:Cc:From;
	b=gU6aUdC6kbOfvCyKVzGIJ/YbT+A+agy1LU6O9HNv865acYzDED1GDlGlo1GlUNzZs
	 hFHNHcXGwVwaINPH2UZe3W6epkwfbQ0NDi/mmgNqnCv26bcdfHqT1y6P95+khcUM/r
	 RS+cs3N8W+k3MZP8ermqcqBPZ3MSHNhl5I+SEDmq98Ey2Mtnsct20i1h7wBmmPho6I
	 ECpegWJmCPKKtPLlrTFVPZ1B/lbBJf84s9CGrSHSSyPRLyq2wEB50HfkoMXyYcmZc4
	 1eD8fuD2BwSs1cKeHNRMemITm2dy/A+OTKgYSfmNtuUKMywPBnLVvI0f9crOXMpNkU
	 /JtFQBmErgh9w==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1BE1817E0D90;
	Wed,  4 Mar 2026 10:36:14 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net-next 0/2] Introduce Airoha AN8801R series Gigabit
 Ethernet PHY driver
Date: Wed, 04 Mar 2026 10:35:27 +0100
Message-Id: <20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2Nyw6DIBBFf8XMupOAYH38SuNihKGyEC1gY2L89
 5K2y5OTe+4JiaPnBEN1QuS3T34NBeStAjNTeDJ6WxhqUd+FEgrJWiQf15mQQtcJiWnftjVmbFr
 baE2aHFso+y2y88e3/YDAGQMfGcafifzay1n+64kSo1mXxeehYitoctwrZ6VqLJm6Vty1pEyvG
 yHbSTrqJmdgvK4Pj9Ed7cEAAAA=
X-Change-ID: 20260303-add-airoha-an8801-support-57d544a4afed
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com, 
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772616974; l=1977;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=2R7/eNnX/6fgjXow5X/hQIDpbueZctqQyMkZeUPD3Zg=;
 b=B87Z3g8NFoaXD7nNm4y0khdWOoYUP0ZxT7XGmcxAmxVfRqLR0uhRDIQ5g80Nfsm/ij0CMbfr+
 KPeAsHQGPYPBEo5C2/v6ECbJjUGY1JsYdwMRHa9aoqb6l8PtiaDDT37
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Queue-Id: 0C3CB1FDBE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263694-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gitlab.com:url]
X-Rspamd-Action: no action

This series introduces the Airoha AN8801R Gigabit Ethernet PHY initial
support.

The Airoha AN8801R is a low power single-port Ethernet PHY Transceiver
with Single-port serdes interface for 1000Base-X/RGMII.
This chip is compliant with 10Base-T, 100Base-TX and 1000Base-T IEEE
802.3(u,ab) and supports:
  - Energy Efficient Ethernet (802.3az)
  - Full Duplex Control Flow (802.3x)
  - auto-negotiation
  - crossover detect and autocorrection,
  - Wake-on-LAN with Magic Packet
  - Jumbo Frame up to 9 Kilobytes.
This PHY also supports up to three user-configurable LEDs, which are
usually used for LAN Activity, 100M, 1000M indication.

The series provides the devicetree binding and the driver that have been
written by AngeloGioacchino Del Regno, based on downstream
implementation ([1]). The driver allows setting up PHY LEDs, 10/100M,
1000M speeds, and Wake on LAN and PHY interrupts.

The series is based on net-next kernel tree (sha1: ed0abfe93fd1) and
I have tested it on Mediatek Genio 720-EVK board (that integrates an
Airoha AN8801RIN/A Ethernet PHY) with early board hardware enablement
patches.

[1]: https://gitlab.com/mediatek/aiot/bsp/linux/-/blob/mtk-v6.6/drivers/net/phy/an8801.c

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
AngeloGioacchino Del Regno (2):
      dt-bindings: net: Add support for Airoha AN8801/R GbE PHY
      net: phy: Introduce Airoha AN8801/R Gigabit Ethernet PHY driver

 .../devicetree/bindings/net/airoha,an8801.yaml     |   81 ++
 drivers/net/phy/Kconfig                            |    5 +
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/air_an8801.c                       | 1059 ++++++++++++++++++++
 4 files changed, 1146 insertions(+)
---
base-commit: ed0abfe93fd135dac223e87a3c945017b1fa8bfc
change-id: 20260303-add-airoha-an8801-support-57d544a4afed

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


