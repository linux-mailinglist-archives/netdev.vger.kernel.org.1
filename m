Return-Path: <netdev+bounces-296854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BaDrG2d2J2oaxgIAu9opvQ
	(envelope-from <netdev+bounces-296854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:11:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B939E65BD06
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:11:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=KOV7gisL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296854-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296854-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D9EF301ECCE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFED3603EB;
	Tue,  9 Jun 2026 02:08:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FF346E75;
	Tue,  9 Jun 2026 02:08:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970929; cv=none; b=njGsKlShlUvwm8b7O1snUivUCBRS20Uo3KCU4lX68tDqWhTgjQSnNaIvRvt28r+PfoJQNCeNUVQ5mZdD3p2d3iUAyV/KF27mLK4qDZjzOihLHP2fxbVOT0M2KiuF2dCdS1OG4gYkASbh/hIu9DGAZzKyAlTdxULi+uPOuq5si54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970929; c=relaxed/simple;
	bh=4bEZbwNr96N8q8ruYinI3Xxo9B2GJ3hy71B/uj7qA0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nTND9Jzx1nYY1YDzNURH1XOvGdN8p9oxFOgyuczsDwKsuF5XfYiw9YtsLiSC5bVEZxD7iTcGXCgu77C39DCZelep4ZUwS3Q440DLRJ4Xrhyr76BPQM2DHNrkLgfFYPs5IKQS4+WQoCRBd8oJ4CxR7GlNg4CGVlq4Jo1AScRfQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=KOV7gisL; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65927VbG44078006, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780970852;
	bh=iAuAcHyW9ngdN8p/ip5z8PrWS/Tb9Pesd6bn8uLu4ps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=KOV7gisLIpHQKyS0XdoVLtdKE1pYqHMEJBWq55Lf0sIlBVmb7JlvJLlzTEUFY1G9i
	 PPd2V6IiTZEsvURcRelHd2nz2VmGzFlN8pXM8fE6sGTiH+A5RQ/v/LP0UVvstzb121
	 1eHwSxkHEUROMtB1P56xWgEYNB8qHoT+oLGPSKhnJl/zcM+WfLgKFENBqJ70u/mqOb
	 H+9arRIonMzPzBuiW7762Knr//qPCg1L5zISbDLEVHFu3GJ4GlkQHEnxPsGIR4TFWE
	 swkJwAT82bnTODd/dbtMgLlbqvc8akakL35yFFayxlfYiiBuFWa0cmX8p6jS4L8MHi
	 kzl2XBjSCikww==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65927VbG44078006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 10:07:32 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Jun 2026 10:07:31 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Jun 2026 10:07:31 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v4 0/4] Add support for RTL8261C_CG
Date: Tue, 9 Jun 2026 10:07:23 +0800
Message-ID: <20260609020727.1152-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296854-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B939E65BD06

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for RTL8261C_CG and add support for loading firmware.

Javen Xu (4):
  net: phy: c45: add genphy_c45_soft_reset()
  net: phy: c45: add genphy_c45_config_master_slave()
  net: phy: realtek: add support for RTL8261C_CG
  net: phy: realtek: load firmware for RTL8261C_CG

 drivers/net/phy/phy-c45.c              |  64 ++++
 drivers/net/phy/realtek/realtek_main.c | 406 +++++++++++++++++++++++++
 include/linux/phy.h                    |   2 +
 include/uapi/linux/mdio.h              |   3 +
 4 files changed, 475 insertions(+)

-- 
2.43.0


