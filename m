Return-Path: <netdev+bounces-248370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5471D076D0
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 07:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9627E303CF56
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 06:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BB52DF142;
	Fri,  9 Jan 2026 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="cK+DjPUP"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB272DE717;
	Fri,  9 Jan 2026 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767940991; cv=none; b=L22O0lbgbp3hfcwfSsLQmdgqg6ne4OLEXKwrUX4jbHWNX/5wu7aZZ00Y2YLoSrSNEeRXqcJMJa6vK9lIpTcq16z+SwuI8FLdUhV6SnZoObJOMu6gijYzpBjieicNavMyqJ26qtnvkcJN3IW0ayMZJDZ/p3A5/YjvwIkNMJKclH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767940991; c=relaxed/simple;
	bh=W6s5951toHUTdtrFU2u+oz7AxaVZl4BTJ4rKwG0+JX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WooP1BYlA4RhTLwms1Y/5taAgtSrNpEaX2VtpgGlwyu884mdgj49e4/VpuHVcj6pbOhFe1RxwfSSqdXULeDBzrbY3sk549TBw5A+llsKHvaHsANnPU/L+h67g1lSNIqx4sprZ2cuPob82jIuA/pGnS448W30GiqagVFdIeGs8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=cK+DjPUP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6096gUCh92683139, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767940951;
	bh=76jXoJYtA7zwMK14+hNMFgZqlbkByTMJtKi417PFTHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=cK+DjPUPjrMsQpLlbidWeGMpltCmMme6dpI0PK5I3JWTNGJGDYg2c7gGVx8DzqP8U
	 YsxOA69VvIJG8NFnNNrBUuU9bZQ722LfjLxeDJNQ6kNfyDVq+XpqzILxh/bGG5Y87A
	 ySHsgGJvq2i2UNHHI1NphEvWuYvdzFo7ENjZFtYx7C1sNcIxfhWTS7nKzcZQ3QOvFI
	 JPLpkrrNdvkZ5aLfcF2KSoJW7SHPKu2XSFgdi6vmDblR+0G6k29XXJ9mSds30CHBEk
	 8Ep6FwawfPDaU27n9qhGuyxP5tmnCgiNQsPfz2TkKBW9EuOf/Uq81zz6gCoKNjYnBp
	 +1MfqVdkopBuQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6096gUCh92683139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Jan 2026 14:42:31 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 9 Jan 2026 14:42:31 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Jan 2026 14:42:31 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v3 0/2] r8169: add dash and LTR support
Date: Fri, 9 Jan 2026 14:42:27 +0800
Message-ID: <20260109064230.1094-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This series patch adds dash support for RTL8127AP and LTR support for
RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127.

---
Changes in v2:
- Replace some register numbers with names according to the datasheet.
- Link to v1: https://lore.kernel.org/netdev/20260106083012.164-1-javen_xu@realsil.com.cn/

Changes in v3:
- Address some checkpath warnings and remove rtl_disable_ltr().
- Link to v2: https://lore.kernel.org/netdev/20260108023523.1019-1-javen_xu@realsil.com.cn/
---

Javen Xu (2):
  r8169: add DASH support for RTL8127AP
  r8169: enable LTR support

 drivers/net/ethernet/realtek/r8169_main.c | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)

-- 
2.43.0


