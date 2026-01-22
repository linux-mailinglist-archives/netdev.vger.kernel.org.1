Return-Path: <netdev+bounces-252453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FNJC5FacmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:12:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FF6AEB0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B03C03049CD0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54A3D9058;
	Thu, 22 Jan 2026 16:39:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370336604F;
	Thu, 22 Jan 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099940; cv=none; b=VkzkMIGNrwOMNRzfyInVgvMO7Ert3e122ks8i/XnYh1aRvElwJ/xQAmLa0VYnc32spPnVQl0snpl79oVy0FEB5lb77jjtnylDNP+dOm5z2A4NgVAcQwNlfmIq/tDc0CX36WaPfzb3g7xWmx3BiYsT4B+r145mw98Y1H1xerga3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099940; c=relaxed/simple;
	bh=q3BLYaETzihHTjn3740y+fY1++XF0dwoVviNbivMTww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lz1WojhUGrfyR4PZ6KMoMkXtfqjMvB9JqRphnAHCXNPmeIGf2gp5aUk54Sumu499rBAiQHAEy+nqy9BHr0fq8XA11a4opZxq9B7aED7lP+QyOKvdiyCbjFBb+q2dEkSgle48FCqtgmVMghhCXsk/2C4hRoHGfFdNAi/t+u9wQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vixhf-000000001Q4-1o9E;
	Thu, 22 Jan 2026 16:38:39 +0000
Date: Thu, 22 Jan 2026 16:38:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v6 0/6] net: dsa: lantiq: add support for Intel
 GSW150
Message-ID: <cover.1769099517.git.daniel@makrotopia.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,gl-inet.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 227FF6AEB0
X-Rspamd-Action: no action

The Intel GSW150 Ethernet Switch (aka. Lantiq PEB7084) is the predecessor of
MaxLinear's GSW1xx series of switches. It shares most features, but has a
slightly different port layout and different MII interfaces.
Adding support for this switch to the mxl-gsw1xx driver is quite trivial.
---
Changes since v5:
 * rebase on top of current net-next
 * update Kconfig to mention GSW150
 * allow configuring RGMII slewrate introduced by commit dbf24ab58fec3
   ("net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration")

Changes since v4:
 * fix wrong indexes in array default initializers

Changes since v3:
 * spell out mii_cfg and mii_pcdu values in struct gswip_hw_info instead
   of using default initializer which requires diag exception

Changes since v2:
 * enclose the gswip_hw_info initializers in compiler diag exception
   to prevent triggering -Woverride-init

Changes since initial submission:
 * add patch fixing node naming convention for dt-bindings
 * introduce GSWIP_MAX_PORTS macro
 * don't assert SGMII PCS reset in case chip doesn't have SGMII
 * use case ranges in phylink_get_caps


Daniel Golle (6):
  dt-bindings: net: dsa: lantiq,gswip: use correct node name
  dt-bindings: net: dsa: lantiq,gswip: add Intel GSW150
  net: dsa: lantiq: allow arbitrary MII registers
  net: dsa: lantiq: clean up phylink_get_caps switch statement
  net: dsa: mxl-gsw1xx: only setup SerDes PCS if it exists
  net: dsa: mxl-gsw1xx: add support for Intel GSW150

 .../bindings/net/dsa/lantiq,gswip.yaml        |   6 +-
 drivers/net/dsa/lantiq/Kconfig                |   4 +-
 drivers/net/dsa/lantiq/lantiq_gswip.c         |  46 ++++--
 drivers/net/dsa/lantiq/lantiq_gswip.h         |   6 +-
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  |  27 +---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 151 ++++++++++++++----
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |   2 +
 7 files changed, 168 insertions(+), 74 deletions(-)

-- 
2.52.0

