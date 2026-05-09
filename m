Return-Path: <netdev+bounces-286124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B6ONIin5/mnu0gAAu9opvQ
	(envelope-from <netdev+bounces-286124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:06:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F94FEE4C
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 360AC30158BB
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6638F65F;
	Sat,  9 May 2026 09:06:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C042046BA;
	Sat,  9 May 2026 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317606; cv=none; b=nexmeczbZxyjCO1TpdKWTiLqfi03Q+wDXo+fcjN992EPGc4ZIyj6FcTSZMOqIyZNWHp/sd049tEe30sITLWoIZTHYlnuj1bwe2Y/eUDvkFv8NVKwgGXXTEgNY4yZ7YbxskKtTaJT9ZpAnlgEdCpIGI/zA2xv0J2tHssucsZ1Xb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317606; c=relaxed/simple;
	bh=/HTnoMOipIPbVWm+I9uQOjYKDPY1waqq7qgbez3iLQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYFLbYWXh5iT8wOLj2kqXazeKrCTDY+stNF/gBMevJta0xI8aTDSC6gow6Vpwh0PzblZzPCOASSL+Fh+tSl/6sT9TiY0lKEUQTHzM5Xq8W8U5375LDsG0auDIL4pY3P8WeV1OvVOKKIK9+qr1wx5yREOFTHjARvDJaHE2HyoCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B1C71A4357;
	Sat,  9 May 2026 11:06:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EB061A24EE;
	Sat,  9 May 2026 11:06:43 +0200 (CEST)
Received: from lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com [10.52.8.159])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2B2F318002C9;
	Sat,  9 May 2026 17:06:41 +0800 (+08)
From: Minghuan Lian <minghuan.lian@nxp.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Minghuan Lian <minghuan.lian@nxp.com>
Subject: [PATCH net-next 0/4] net: dsa: Add NXP i.MX RT1180 NETC switch support
Date: Sat,  9 May 2026 18:06:28 +0900
Message-ID: <20260509090632.2959553-1-minghuan.lian@nxp.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: D02F94FEE4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286124-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.571];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minghuan.lian@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,i.mx:url]
X-Rspamd-Action: no action

This series adds DSA support for the NXP i.MX RT1180 NETC Ethernet
switch using the Heterogeneous Multi-SoC (HMS) architecture.

In HMS systems, the i.MX RT1180 MCU runs firmware that manages the
NETC switch hardware, while a host SoC (e.g. i.MX93/i.MX94) runs
Linux and exposes the switch ports through DSA. The host communicates
with the RT1180 over SPI to configure the switch and exchange control
traffic.

The series includes:
- DT binding for the switch
- HMS tag protocol using tag_8021q for data and meta frames for control
- DSA driver with SPI transport, phylink, FDB, VLAN and bridge support
- ethtool statistics support

Minghuan Lian (4):
  dt-bindings: net: dsa: add NXP i.MX RT1180 NETC switch
  net: dsa: tag_hms: Add HMS tag protocol
  net: dsa: hms: Add NXP i.MX RT1180 NETC switch driver
  net: dsa: hms: Add ethtool statistics support

 .../net/dsa/nxp,imxrt1180-netc-switch.yaml    | 118 +++
 MAINTAINERS                                   |   9 +
 drivers/net/dsa/Kconfig                       |   2 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/hms/Kconfig                   |  14 +
 drivers/net/dsa/hms/Makefile                  |   9 +
 drivers/net/dsa/hms/hms_config.c              | 253 +++++
 drivers/net/dsa/hms/hms_config.h              | 259 +++++
 drivers/net/dsa/hms/hms_ethtool.c             | 346 +++++++
 drivers/net/dsa/hms/hms_main.c                | 938 ++++++++++++++++++
 drivers/net/dsa/hms/hms_spi.c                 | 116 +++
 drivers/net/dsa/hms/hms_switch.h              |  73 ++
 include/linux/dsa/tag_hms.h                   |  28 +
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   9 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_hms.c                             | 366 +++++++
 17 files changed, 2544 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,imxrt1180-netc-switch.yaml
 create mode 100644 drivers/net/dsa/hms/Kconfig
 create mode 100644 drivers/net/dsa/hms/Makefile
 create mode 100644 drivers/net/dsa/hms/hms_config.c
 create mode 100644 drivers/net/dsa/hms/hms_config.h
 create mode 100644 drivers/net/dsa/hms/hms_ethtool.c
 create mode 100644 drivers/net/dsa/hms/hms_main.c
 create mode 100644 drivers/net/dsa/hms/hms_spi.c
 create mode 100644 drivers/net/dsa/hms/hms_switch.h
 create mode 100644 include/linux/dsa/tag_hms.h
 create mode 100644 net/dsa/tag_hms.c

-- 
2.43.0


