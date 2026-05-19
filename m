Return-Path: <netdev+bounces-289552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFSILDOgDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:38:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C29583335
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 966EF305C4EF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC48C33F5B1;
	Tue, 19 May 2026 17:38:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DD4963BE;
	Tue, 19 May 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212294; cv=none; b=FnO21NdKtIwRi6L0DdJ69WNVv4i5jBQaBmRCLZCXTKrOaVUIqjsC862wpC/Yr5eV6CSbIs2l6+qmP6k96ArjtUcbdO69u0mrKsoknllfqDIXcuVMfoyzp+rbWY+ZDmRXNpYiFHR4pr+nfRamohVk5RaFf5GbP/hJS/3UQN8W6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212294; c=relaxed/simple;
	bh=M34YFTLToBpjfj88NBBaS+M/mGr7lyKIXgnsgl8sP0M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BxLtfzEMqlk/NY4UYaErjNSFET8rD6/mhS6FanP7++BmWu5e7bVtSYGk/fm1dT8SDZkhiR0nRhXZBIr4hit/xf81edXTWZvyHPePr27cTKD74Wxli4VhssJWurG2l6XEb4fGLkvwvUm0hG/1f3ZRieYpl6v4EgTHmLB+FSo843s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPOOM-000000001d8-45Mg;
	Tue, 19 May 2026 17:38:07 +0000
Date: Tue, 19 May 2026 18:38:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/5] net: dsa: mxl862xx: SerDes ports and stats
Message-ID: <cover.1779203863.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,makrotopia.org:mid]
X-Rspamd-Queue-Id: 57C29583335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the two SerDes PCS interfaces of the MxL862xx switch
ICs, which can both either be used to connect PHYs or SFP cages, or as
CPU port(s). 1000Base-X, 2500Base-X, 10GBase-R, 10GBase-KR, SGMII,
QSGMII and USXGMII (single 10G or quad 2.5G) are supported.

The firmware only added the API to directly control the PCS as of
version 1.0.84, so the PCS features are gated behind a version check.

As the driver is growing do some refactoring to break out the phylink
parts into mxl862xx-phylink.h.

Also add custom ethtool stats for the various diagnostic values related
to the SerDes interfaces which can be read from the firmware.

Daniel Golle (5):
  net: dsa: mxl862xx: store firmware version for feature gating
  net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
  net: dsa: mxl862xx: move API macros to mxl862xx-host.h
  net: dsa: mxl862xx: add support for SerDes ports
  net: dsa: mxl862xx: add SerDes ethtool statistics

 drivers/net/dsa/mxl862xx/Makefile           |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h     | 392 +++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h     |  11 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h    |   8 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 446 ++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h |  27 ++
 drivers/net/dsa/mxl862xx/mxl862xx.c         |  60 +--
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  58 +++
 8 files changed, 957 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h

-- 
2.54.0

