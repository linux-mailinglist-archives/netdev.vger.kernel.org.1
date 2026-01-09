Return-Path: <netdev+bounces-248409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B554CD083D1
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2980B302EAC5
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62343590AB;
	Fri,  9 Jan 2026 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="D45yIdT0"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB73321B3;
	Fri,  9 Jan 2026 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951358; cv=pass; b=A1IoHoaCSnpGKghB6FfxQjx6I2Jgd/7AcM9BFnyHIR8qnZXPUeDk2hIsgMZCioEzuDlSPSsUtSdtSXygZKrm+e2f5bOU4DHNgLkaoOKqK44jCdQLH4mM5x0fq0hWFQ5IqEB1IYdWxtN/LIh4a7chg0lMxQfr6EjXhA6BbRGKNQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951358; c=relaxed/simple;
	bh=nhiQgyuD12KOGuD9Yf/An3hdJXWKQhT5Etwnt3+VfOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSHrOAj7nU4EzOWJ9TBh9Z6zFdIfYexvSuathw4SJO6i5xiu6NAjif1fi1qcuOab0sitj0a0Pbys4bbIYtMwjdzjbgahgZQraxeIF6zM4HYMuDlDB2sDAQ9bLGtAFIXyMqVaWmP0ViczJOsNQiTX9HISDzH8BGVfFmhago60bjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=D45yIdT0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1767951329; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LaGUmdQIkTYw/6Pib1XpKEl2j76X+kNnjnHxJa91Ve50IpJyFsgkR6k8g/I+TsJt0UvZ0LcGE1nSmMt1qo3NfB1pXk/xDL2nA57ebsi/l57RqrtE3eDXVaepu3QwDjuS7BzLYo9jaaYmR9K+Rh5lcfQK0wjAoD50n2gFwCgHu2E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767951329; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rrJTZqDCPTYnDwUQDB+1u2rirB58dty5EunkqoMblmI=; 
	b=cQIUhJ9BbJRADrphySN/fHmwvHD8DB1GfRVDDmFI9+ORxI8xkeBjiMf8Qdg/aw/NHTHyYN2Z7v/UJYvhtslUlOAv/d4LUyQvejlji9YBE8Nz0ucCR9sRdcJ3nYHWLDTKQ6D2mWjUHr57Jtpdz3moe1wCdYOY+rsI7Dlrmh/WUSM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767951329;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rrJTZqDCPTYnDwUQDB+1u2rirB58dty5EunkqoMblmI=;
	b=D45yIdT0ojw99JHxAfwV4L1AxkDqZ7NsMIcXifz5cHjuCAPb/9KPNXykbfHnMwCZ
	e6nYPBqrV1oGMY9j0A+qR0vYvdSfRQFoYlo45VecBB6v+5nobP14o3rO+hyX956QAke
	MIIaCRuLAJG5fIaCur0e4Ciwk+hgZeZO3N58GI2I=
Received: by mx.zohomail.com with SMTPS id 1767951327443140.90428987681742;
	Fri, 9 Jan 2026 01:35:27 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH RESEND net-next v6 3/3] MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue driver
Date: Fri,  9 Jan 2026 09:34:46 +0000
Message-ID: <20260109093445.46791-5-me@ziyao.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109093445.46791-2-me@ziyao.cc>
References: <20260109093445.46791-2-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

I volunteer to maintain the DWMAC glue driver for Motorcomm ethernet
controllers.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e083f15fc28..4ae3736d8010 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17711,6 +17711,12 @@ F:	drivers/most/
 F:	drivers/staging/most/
 F:	include/linux/most.h
 
+MOTORCOMM DWMAC GLUE DRIVER
+M:	Yao Zi <me@ziyao.cc>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
+
 MOTORCOMM PHY DRIVER
 M:	Frank <Frank.Sae@motor-comm.com>
 L:	netdev@vger.kernel.org
-- 
2.52.0


