Return-Path: <netdev+bounces-290220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH79AOlwDmq8+gUAu9opvQ
	(envelope-from <netdev+bounces-290220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926859E2C2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D80A301983E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624F375F83;
	Thu, 21 May 2026 02:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF136AB56;
	Thu, 21 May 2026 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331217; cv=none; b=MGglXI/6SAaPdSxbigWnl7MBIKn5E3wFZAc4Ajuu7ZbPOjCBkBF2aN8zR07pE6Oq6IEIaYw3bBI+A6AxEAP5NuGjkYWnMEe+4WUcCZcSkCbRtudyZxKbqcV6VBtvr33dTNdFytLL101J2sfYOs7ngmvv2winxLqkcybRTkWy6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331217; c=relaxed/simple;
	bh=U2UZNLkL86bi9APMNPIl8uGlEIryY3wwdcEi0ga9w1k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ozpb2yFh3DhxTeMD7m+7TINV/CkewfhmQqW2cH7B5v+jqZcnSbkE/rw05OO13owLEuoNLJ5C8bl7a5QKr7O+TM0D40T/wZOIKNPy9v38zVNJ+Cz/GQ2It8VcOHfp+p+r7NT3qBvFZjsoGizZoltJdJsgfiFCJ0RoPuck+p8UI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPtKE-0000000033i-0GVA;
	Thu, 21 May 2026 02:39:54 +0000
Date: Thu, 21 May 2026 03:39:50 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/4] net: dsa: mxl862xx: add SerDes ports
Message-ID: <cover.1779330653.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290220-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6926859E2C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the two SerDes PCS interfaces of the MxL862xx switch
ICs, which can both either be used to connect PHYs or SFP cages, or as
CPU port(s). 1000Base-X, 2500Base-X, 10GBase-R, 10GBase-KR, SGMII,
QSGMII and USXGMII (single 10G or quad 2.5G) are supported.

The firmware only added the API to directly control the PCS as of
version 1.0.84, so the PCS features are gated behind a version check.

As the driver is growing do some refactoring to break out the phylink
parts into mxl862xx-phylink.c.
---
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
 drivers/net/dsa/mxl862xx/mxl862xx-api.h     | 358 ++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h     |   9 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h    |   8 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 379 ++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h |  21 ++
 drivers/net/dsa/mxl862xx/mxl862xx.c         |  54 +--
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  67 ++++
 8 files changed, 852 insertions(+), 46 deletions(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h

-- 
2.54.0

