Return-Path: <netdev+bounces-255573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bzDPCX7LfmneeQIAu9opvQ
	(envelope-from <netdev+bounces-255573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 04:41:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0CC4D9A
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 04:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 167CE300C59F
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFE279DAD;
	Sun,  1 Feb 2026 03:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8671EDA2C;
	Sun,  1 Feb 2026 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769917307; cv=none; b=ngw3W+yAaj99/yF4rKUEIStMINPxTHj5hlA+mtcHg3MTd8fUikN650x7rLEZ3HziAjNUVN79x9Z0SnaLif9L0Sm9Ml5devUStOMb0QOI4sUnXO+8PhqR8WZfGvi8U1V26BMvDV5n6fA8i9DOodspysHpoPzJ5/W7DUE3v4OmxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769917307; c=relaxed/simple;
	bh=bnnJAHumSHO4V2SDDaOm9PehTi5dNf6iI3BecXzzN2c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZvJ1YZExfe40n4gHD8T3Tsi/X8E/ZdHlRQgMmziQ/3uYApj5M1PQesSQfuTna3dW4Bt6HHGvm0J6RJh9QBJlLYLCgwAx5HTA9JfUOria7Yr4+j4hGHF1Pm1IfsXfUebAJcf4cPP6l8jfiT7Zy/5U8+a9b5HT4Ig5lc9Obv14zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vmOLB-000000002WN-4BU9;
	Sun, 01 Feb 2026 03:41:38 +0000
Date: Sun, 1 Feb 2026 03:41:34 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: dsa: mxl-gsw1xx: setup polarities and
 validate chip
Message-ID: <cover.1769916962.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255573-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70D0CC4D9A
X-Rspamd-Action: no action

Now that common PHY properties make it easy to configure the SerDes RX
and TX polarities, use that for the SGMII/1000Base-X/2500Base-X port of
the MaxLinear GSW1xx switches.

Also, validate hardware in probe() function to make sure the switch is
actually present and MDIO communication works properly.
---
Changes since v2:
 * be more clear about describing polarity at port, ie. external pin level

Changes since initial submission:
 * use allOf to include phy-common-props in dt-schema
 * use phy_get_manual_rx_polarity and phy_get_manual_tx_polarity helpers
   instead of open-coding them


Daniel Golle (3):
  dt-bindings: net: dsa: lantiq,gswip: reference common PHY properties
  net: dsa: mxl-gsw1xx: configure SerDes port polarities
  net: dsa: mxl-gsw1xx: validate chip ID

 .../bindings/net/dsa/lantiq,gswip.yaml        |  4 ++
 drivers/net/dsa/lantiq/Kconfig                |  1 +
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 66 +++++++++++++++----
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  9 +++
 4 files changed, 68 insertions(+), 12 deletions(-)

-- 
2.52.0

