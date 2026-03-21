Return-Path: <netdev+bounces-270246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFx1Aw/1vmk0mAMAu9opvQ
	(envelope-from <netdev+bounces-270246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:44:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFAA2E70C3
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EB373009F39
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16643342CA9;
	Sat, 21 Mar 2026 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="GKUGiyLa";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WGZXpLYR"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048E3314C2
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122251; cv=none; b=OHlkGzJaQZ9vfQ/Ix1Ix8Ibq+p8u9A3yMPCJF//TGDUNYUiGoW6LVZZLUchp+zVwwX/bCEpqz19g3vL5IABcGSb0QhNPfqOth+RAd+6pYeQ8hhp5fznTMAj4ZaNGoa/Zn4SjRWKAzZ/KlnEg7mModZBztx6TTGtQJnjsq8p24WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122251; c=relaxed/simple;
	bh=RhlUd5nJZtyzPTrb6142vd7/kHj3AnKxbcivtAnbRiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RMxOnuBANmLlFRSGs/EirxN5hBuHKbiMcF1bgTEIAV4g4g7OATyWcovKz8SR+cqH116YaFE3ywR/x7Tpob+8yTomwG6h8sllH0ywN17SLoJkLPniDUZeC7KUebwds4qR3Ec/ENQubRHStEXlU1zbd1lcQ0/qj6WYVMx7Zb+a+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=GKUGiyLa; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WGZXpLYR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=GKUGiyLaA+adTt3TkBqU6pyUp2FYdTmpg88T+qNgrFdyC2R9JhMfyHh4SPC6gH8/qwNfqZpOA04zfSVgPLrgprNpp++LiL6IXe/Nsa6lxI9HrO88TDCBOXwaHwB4HTeJ4ZDdUeDtFXqwr2f74OENHoCnhM4a9AAWennsKU61noV0FutkcCAB2xYDWEBEOmSE/ZupzfgJv2LblcgMviICFd1+l59E9oefQ8ZGHESipdUf1DHItGZBowhRwmwDj53v2UGlfOSGaOViH+73YNaD7X+w4wZlKuZSx6z7gQj3wLhGofAgk0RCOkEPSvkZjL9NBkz7/Y1d0Itv+G9qNBiWfw==; s=purelymail3; d=tinyisr.com; v=1; bh=RhlUd5nJZtyzPTrb6142vd7/kHj3AnKxbcivtAnbRiU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WGZXpLYRXdWLBU6iq+/kKo/3qG65qO7DrBgWdpNo9Zos2/V+Oo/uelwi1GKTE9qp+CMSTFkm5j5mDrjmEDrh1/q71nd/7VLi1Kv70/Ycqgqc6JJse/9PXmdte/Nc4RUtknXwaA0FwJX4Kvc/WjWJRlLVFb5YLUZnKHnTzn9O1RvchhD7xVQJz2LMF6QOAStM+NLcSsU5ynkaBKzB3ZV1s6nnWBTJZXuAHbQgPyWgz6Mknlr4gdM7gLH09T/1JVisp2DH0b8RoBuX4beBNyqN/9Lw/aW9lkLgICU2GAMiVunUs//b0sHRpMVubyAiUCBxa7DdpAY1gACzA1Lihy6eUA==; s=purelymail3; d=purelymail.com; v=1; bh=RhlUd5nJZtyzPTrb6142vd7/kHj3AnKxbcivtAnbRiU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 958892867;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Mar 2026 19:44:07 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC v3 0/4] net: dsa: MT7628 embedded switch initial support
Date: Sat, 21 Mar 2026 21:43:36 +0200
Message-ID: <20260321194340.2140783-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270246-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,tinyisr.com];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purelymail.com:dkim,tinyisr.com:dkim,tinyisr.com:mid]
X-Rspamd-Queue-Id: 6DFAA2E70C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

This RFC series adds initial support for the MT7628 Embedded Switch.

The implementation provides basic functionality required to operate the
switch using DSA. The hardware exposes 5 internal Fast Ethernet ports
and a Gigabit port which is internally connected to the CPU MAC.

This version aims to be functionally complete and attempts to address
all feedback received on the previous versions.=20

Tested on a MT7628NN based board.

RFC:

I would like to transition this series toward a proper PATCH submission
as it seems that the feedback on the last RFC did not point out major
issues. As this is my first driver submission, I would greatly appreciate
any guidance on what should be addressed before it is appropriate to
send this in as a PATCH.

Thank you for your time and review.

---

v3:
=09- add DTS bindings for mediatek,mt7628-esw
=09- update tagging driver to use htons instead of manual byte swapping
=09- remove port 5 from config as it doesn't exist in the hardware
=09- fix code formatting
=09- add helper macros for configuring packed VLAN table registers
=09- fix mac_capabilities for cpu port, replace supported_interfaces
=09  with PHY_INTERFACE_INTERNAL to accurately reflect the hardware
=09- update MEDIATEK_GE_SOC_PHY tristate name, fix sorting
=09- remove unneeded PHY_PACKAGE from MEDIATEK_FE_SOC_PHY Kconfig
=09- remove untested features from mtk-fe-soc.c phy driver

v2: https://lore.kernel.org/netdev/20260314150845.653866-1-joey@tinyisr.com
=09- Update commit messages with more relevant information
=09- Change all references of "special" tag to "MT7628" tag
=09- Fix coding style errors
=09- Use dsa_xmit_port_mask instead of BIT(dp->index)
=09- Replace phy_read/phy_write with an MDIO bus definition
=09- Remove PHY init from switch driver
=09- Fix undocumented writes to SGC2 and FCT0
=09- Fix missing double-tag enable required for VLAN unaware
=09  functionality
=09- Fix VLAN remove logic
=09- Update VLAN add logic to use the first unused slot
=09- Add a dedicated phy driver for MT7628 FE PHYs

v1: https://lore.kernel.org/netdev/20260228185242.800836-1-joey@tinyisr.com

Joris Vaisvila (4):
  dt-bindings: net: dsa: add MT7628 ESW
  net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet
    PHYs
  net: dsa: initial MT7628 tagging driver
  net: dsa: initial support for MT7628 embedded switch

 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 136 ++++
 drivers/net/dsa/Kconfig                       |   7 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mt7628.c                      | 634 ++++++++++++++++++
 drivers/net/phy/mediatek/Kconfig              |  10 +-
 drivers/net/phy/mediatek/Makefile             |   1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c         |  50 ++
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   6 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mt7628.c                          |  92 +++
 11 files changed, 939 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.53.0


