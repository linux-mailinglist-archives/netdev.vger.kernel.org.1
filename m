Return-Path: <netdev+bounces-294598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7vl+HhvWH2r+qgAAu9opvQ
	(envelope-from <netdev+bounces-294598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:22:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C363526F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:22:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=XRSppAaY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294598-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294598-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63FFE306592F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177DC40C5DD;
	Wed,  3 Jun 2026 06:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB240B6DC;
	Wed,  3 Jun 2026 06:59:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469985; cv=none; b=Q5mn03sYjCg+LzqGF5Pwkh7tjXA49/K0wzUA0ywqs+j0oIg78FndxbakDSKRsuJrmzfOeNio+uChce2WxCtftZCQMz8Tt51D/HqMXYdvX1ESrv2B+By8NKaHevGpCFiqKnRRt8gM+UkNaAFIvXv16W3KMYRnC/+DwHY2JpZWKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469985; c=relaxed/simple;
	bh=ImCdehpsW+CSd6wqR798R/oMBtK0Q3OlfSY2u1RHHLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NpaHUBv43EOnMNnDiKC70P2DHawQ3FSD9Rz0id/LmE/Qu5q7aAQR6/p7zb8qRJEwhFP8L9z8GHKEkROJmr6E76v6XXHDib3JlyTJGmRy7D768WHDTcXsFV2v6WhVtkjexN5TH7pbONI8q7YEavHijR9+QHB+zN/fFP52I/cdp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XRSppAaY; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536xI0213643786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780469959;
	bh=/KEaKqyxdusPu1ymUfX5D9sP+tOQq7VEKGlj8VLoDxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=XRSppAaYsjsQyT1I1M1LSrZnDZCA2VTapVviFSH8Rh/6rrMPo6TYnBqENvTYl1Ehe
	 eO3dzI4EImWTSLpQzFMcUjtssdq8cjpBwJSVwoTLXklFUPVi38eF39S/rGhLfZ7n6d
	 xgAPUA8yCpoc6BFj2gnXStYXidkT+oglIluJJ6ijPazANPloxpj7LIttNtWDXEPaO3
	 ElfWBNTHhcRUknzUJCDGJQcWTNS3WHpbeir32C0pqZJ1fQSSqj/BCBZL8a/DAohRg4
	 nhAeygCz01sYWd/S23EA/WLkFR2PdhpKP+BUxg4C0u0OkqiuBb+gHCvLCqcXRlQH8z
	 Bmgbci9MUBGsg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536xI0213643786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:59:18 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:59:18 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:59:18 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/5] r8169: fix RTL8116AF low power and link readiness issues
Date: Wed, 3 Jun 2026 14:59:11 +0800
Message-ID: <20260603065916.334-1-javen_xu@realsil.com.cn>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294598-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 702C363526F

From: Javen Xu <javen_xu@realsil.com.cn>

This series fixes several RTL8116AF issues in r8169.

RTL8116af operate in a SFP mode where the standard PHY register path does not
provide all required information for normal phylib. In this mode, the driver
needs a dummy PHY ID so that phylib can attach to a dummy Realtek PHY driver,
while selected standard PHY registers are handled through the SerDes register.
And RTL8116af is a multi-function card, all the function should be set to d3hot
and enable aspm to ensure that system can enter C10 and s0ix power saving state,
including invisble function 2 to 7.

Javen Xu (5):
  net: phy: realtek: add support for dummy phy
  r8169: move funcitons forward
  r8169: fix RTL8116af readiness bug
  r8169: add ltr support for RTL8116af
  r8169: fix RTL8116af can not enter s0idle and c10

 drivers/net/ethernet/realtek/r8169_main.c | 217 ++++++++++++++++------
 drivers/net/phy/realtek/realtek_main.c    |  54 ++++++
 include/net/phy/realtek_phy.h             |   1 +
 3 files changed, 214 insertions(+), 58 deletions(-)

-- 
2.43.0


