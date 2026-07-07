Return-Path: <netdev+bounces-305376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IqQPJV3HTGqOpgEAu9opvQ
	(envelope-from <netdev+bounces-305376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:31:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C45719CD9
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:31:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=LfKTwhYV;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305376-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305376-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5D91302AF20
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1203AE712;
	Tue,  7 Jul 2026 09:22:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2F3976A4;
	Tue,  7 Jul 2026 09:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416164; cv=none; b=XXngXf04BJSW/FvUgFm0litxZgtjj2X0kq3dLdhet5hpglyO4DtN0BFnO8h02UxyEpEO8R+AyMw44YVo7nbMD0LBpsCQXbk+moHb3R9qTQHxyXt1/VaqH5Nv/xcT5qLnCB4aKSey75Frdz5CObJ3nasxmUG8y+aBN3HdZk3P/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416164; c=relaxed/simple;
	bh=g90/hc+bGcc19tZiH/8O+YCG73xwj3PTDSVhtPmCtK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hh5Lbnxj6IBerzbtLVf6JXTHbEFtlVY5HX1ERBYPNPoJpGf2MRZy0+s+94wzA+xyf+BndXebYFHu1oUE7V1lX3+0GD0zXf9D7TuSRJp+K8GNOjt6leEtHAckC2jd3oV2iesV+cJgLuzgjlW4RrxUC9jnyHuU5mIhyl8TimJxIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=LfKTwhYV; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679GcouE1361138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783415799;
	bh=NqmJATtYQ3e7mMUwDYI9nvd6QFKJ1fMq8pqPKj3AOIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=LfKTwhYVRQCfMpwzLRTZLNjWvrWSk11FsZBcG6San/K5d/RUNab+EYH3Wfq8lmAbf
	 mXCgLRwP8974Pz2d53JoGe+sgtajW5QyH8XmMGc8fbLrFBWfjctFcEpLNmKRllfIY3
	 1RWysYer+Tj7DdfRnuuDvJol/Fsvt/cMfjnPTRy8n2n3GXG+DnTFNi12vEd6ifAdC2
	 Oy6Q4IDJA8T8mQxojKolMQrJRzCnRWGyPGRJTZ95uzmA2Q5p6aUL8lQ47OfVC7wbUw
	 O4FnzQkLhOaCKMR4EZcTuXlL3GcbE8m30hoLRkn2TDfEmjnJWT4L8H14GRNs9ggbmR
	 hYPRH2SE6VAQA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679GcouE1361138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jul 2026 17:16:39 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:16:38 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:16:38 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 0/8] r8169: add support for phylink
Date: Tue, 7 Jul 2026 17:16:28 +0800
Message-ID: <20260707091637.371-1-javen_xu@realsil.com.cn>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305376-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:linux@armlinux.org.uk,m:enelsonmoore@gmail.com,m:daniel@thingy.jp,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,armlinux.org.uk,gmail.com,thingy.jp,realsil.com.cn];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03C45719CD9

From: Javen Xu <javen_xu@realsil.com.cn>

This series patch adds support for phylink. RTL8116af is a fiber mode
card, link status and speed can not be read from standard phy reg. So
we read link status and speed from serdes reg by pcs. So as RTL8127atf.

Javen Xu (8):
  r8169: add speed in private struct
  net: phy: phylink: add helper to modify pause
  r8169: add support for phylink
  r8169: add support for RTL8116af
  r8169: add ltr support for RTL8117 series
  r8169: fix RTL8116af can not enter s0idle and c10
  r8169: add phylink support for RTL8127atf
  r8169: add 1g support for RTL8127atf

 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/r8169_main.c | 658 +++++++++++++++++-----
 drivers/net/phy/phylink.c                 |  66 +++
 drivers/net/phy/realtek/realtek_main.c    |  54 --
 include/linux/phylink.h                   |   2 +
 include/net/phy/realtek_phy.h             |   7 -
 6 files changed, 585 insertions(+), 203 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

-- 
2.43.0


