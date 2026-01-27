Return-Path: <netdev+bounces-253829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AmhLw6jeGmGrgEAu9opvQ
	(envelope-from <netdev+bounces-253829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:35:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FFE93A9D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C5F3039CA4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B5349B0D;
	Tue, 27 Jan 2026 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="vEO7wJWO"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC491221DB6;
	Tue, 27 Jan 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513710; cv=none; b=qrh84yH9HS8YjE3WqNbbC5Cy5boXaT2jm3rLP7RotJNwDr/xaSA8EWw2n4iinFuvtxSAGDoNFTJyXSSQldjrJlRba1/wX8j7l0YenRtV853Ct9GTDAIKAk1guOxj1YnSZbGlsOdwk9Yx0j+mKA8+hNCidSYZFieGFPTxb9qdzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513710; c=relaxed/simple;
	bh=gL04srd4swDoQ2n6C8dHgMhz+Wno5bn1/c5nxrm7JsA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uVnRM4YEymeezTkMp9GJyHEP2x+hTMFofhTuIoqU4MvMMWjxD2gilDYo2ljd3RqqnDk7/TeoOPNgjssPF9i3uKzq3gEUn8jvrz6HOlAj9L+TmtpUc/kCtim3ei9f1NAhihanOVl50TtZDbRC2eGXn6xiBaJ6hV6Ac6OSAwQFcIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=vEO7wJWO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60RBYQI702868623, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1769513667;
	bh=bVJjj5bwEztRwz6xBsZN3HOG4bf680Bbi4oHUGm90T0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vEO7wJWO41bsrT/Nfo4fgGBVRLinZsw8vVc5tfDf/4tUwK5F5dp1ObvkdOu3q4cCa
	 CgiZRMA6tvvdt+lMh7ObtnMGPK06Ylx9KCqmesw8f6nZMc4hoha+vG9+FcsvTu7oto
	 LWs/2unPCeDDNiHol/uVs+rKiMYshEWuWoaLwfCU+odOIyAhnFxuYgmwjEjU34m6oj
	 ftA49BDpCSndY9jbzD0PoFHweZG1PovI7o/ExRe5sebUYQ176t+ovrobIRpz+8RRjN
	 XGOsyYicU+XSx2ZWTcz7ieTNffCNWNm3PoQbdZJBy+G79P0UmykkwpW9GMCucH1SPc
	 d+0Hb2npMfxVQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60RBYQI702868623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Jan 2026 19:34:27 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 27 Jan 2026 19:34:26 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 27 Jan 2026 19:34:26 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/3] r816e: Add r816e driver in Realtek
Date: Tue, 27 Jan 2026 19:34:22 +0800
Message-ID: <20260127113425.1989-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-253829-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10FFE93A9D
X-Rspamd-Action: no action

From: Javen Xu <javen_xu@realsil.com.cn>

This series patch add a fake driver r816e to ensure the kernel could set the
correct power state for #fun through r816e driver when suspending.

Javen Xu (3):
  r816e: add a fake driver r816e for RTL8116af
  r816e: Add a Makefile in the r816e folder
  realtek: Update Makefile and Kconfig

 drivers/net/ethernet/realtek/Kconfig        |  7 ++
 drivers/net/ethernet/realtek/Makefile       |  1 +
 drivers/net/ethernet/realtek/r816e/Makefile |  8 +++
 drivers/net/ethernet/realtek/r816e/r816e.c  | 75 +++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/r816e/Makefile
 create mode 100644 drivers/net/ethernet/realtek/r816e/r816e.c

-- 
2.43.0


