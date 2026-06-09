Return-Path: <netdev+bounces-296834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B9DoArJrJ2rKwQIAu9opvQ
	(envelope-from <netdev+bounces-296834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:26:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7571465B999
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:26:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296834-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296834-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A1C4301A159
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD503033E9;
	Tue,  9 Jun 2026 01:26:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392328980F;
	Tue,  9 Jun 2026 01:26:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968365; cv=none; b=iND3jD1LWFYKnrHV+Lmfq5UVLq0tQ+p2WEvheVGPU5/SLosLtpJp4UZVbXBR27kbk/k18o8pXqCw37IwZdsk4bvVjVN0Ma+v24sh5qOzwdCuJYRKnymuCnSTlcCfv46gD/uqt/jimlv47PiUrrxoZkYsb7SbUiLpj0afecQdm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968365; c=relaxed/simple;
	bh=ShCwm8bZtTrnC0mFFLxhD0N7L2Dhlicpo3q1QKheDr8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oYVmCTaFOjCl1OAyi/Ai87+RDNRtm2dFv7OK0b4uEBMqdBhECuRTWn7EuGlGIrGNecf6ztkzZ4l8T1KTp+oJxPOBcQV/qZnfGpXweZZyzGp1WdMWKxb1lxmzyA7b1ZSaPoJhtali/5GVwyHjQK1kOLm/sI3AY2e2tkiBIsK+5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wWlDw-0000000034K-3q29;
	Tue, 09 Jun 2026 01:25:49 +0000
Date: Tue, 9 Jun 2026 02:25:44 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 0/4] net: dsa: mxl862xx: SerDes ports
Message-ID: <cover.1780968180.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296834-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,makrotopia.org:mid,makrotopia.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7571465B999

Add support for the two SerDes PCS interfaces of the MxL862xx switch
ICs, which can both either be used to connect PHYs or SFP cages, or as
CPU port(s). 1000Base-X, 2500Base-X, 10GBase-R, 10GBase-KR, SGMII,
QSGMII and USXGMII (single 10G or quad 2.5G) are supported.

The firmware only added the API to directly control the PCS as of
version 1.0.84, so the PCS features are gated behind a version check.

As the driver is growing do some refactoring to break out the phylink
parts into mxl862xx-phylink.h.
---
Changes since v4:
 * use FIELD_GET/FIELD_PREP and macro definitions for the bitfields
   instead of endian-aware structs with bit-sized members
 * do not error out on old firmware, so driver at least probes and
   CPU port keeps working in firmware-configured mode. Issue a
   warning instead.

Changes since v3:
 * replace atomic_t serdes_refcount with a plain int guarded by a new
   serdes_lock mutex

Changes since v2:
 * get rid of endian-specific union handling firmware version
 * replace serdes_active bitmap with atomic_t serdes_refcount
 * defer mpcs->interface assignment until after firmware ack
 * handle firmware error codes in pcs_config
 * set st.usx_lane_mode in pcs_get_state
 * set lu.usx_subport and lu.usx_lane_mode in pcs_link_up
 * use phylink_mii_c22_pcs_encode_advertisement() in CL37 adv
 * rework commit message

Changes since v1:
 * drop custom ethtool stats (former patch 5/5)
 * add __{LE,BE}_BITFIELD layouts to ABI structs
 * per-sub-port QSGMII AN restart via usx_subport / usx_lane_mode
 * shared-SerDes refcount in pcs_disable via per-XPCS slot bitmap
 * let every sub-port call pcs_config
 * cache phy_interface_t instead of firmware type
 * skip pcs_link_up when inband-AN enabled
 * gate phylink_get_caps SerDes modes on same FW version as select_pcs
 * interpret xpcs_pcs_cfg.result as signed (s16)
 * drop dead MXL862XX_PCS_PORT macro
 * drop misleading "downshift detection" line from commit message

Daniel Golle (4):
  net: dsa: mxl862xx: store firmware version for feature gating
  net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
  net: dsa: mxl862xx: move API macros to mxl862xx-host.h
  net: dsa: mxl862xx: add support for SerDes ports

 drivers/net/dsa/mxl862xx/Makefile           |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h     | 215 ++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h     |   9 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h    |   8 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 433 ++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h |  21 +
 drivers/net/dsa/mxl862xx/mxl862xx.c         |  55 +--
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  57 +++
 8 files changed, 754 insertions(+), 46 deletions(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h

-- 
2.54.0

