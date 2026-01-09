Return-Path: <netdev+bounces-248377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C2D07812
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D53D1301558C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5A62EC562;
	Fri,  9 Jan 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="AuNyG2kR"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52223284B3B;
	Fri,  9 Jan 2026 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942283; cv=none; b=Vw2kQGVc6r1/qZoLK8aMDr/dprrRvS8GpiIj6ysTGed3qJInS2udkQhtBnp5aIE64ps0tOCdk/HqaJVXDcb2fef14mfDdYUwQdpjA+njAB/gbhrBS5W5A7AqqeUG8czmCEu45DpM97nSbPYIazj0tKiGrFK762Kc24z6Tq+QbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942283; c=relaxed/simple;
	bh=8dLUuXEBTMVnNAfMIUge0qeqNmZpZ4t9Y0r5/jNzDwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPRAXNmFBlCjVyxQvHX2hy5+ltaRf2bBVTvhJc+zmSub1noBuRjFfCukQs0UbLhhsBvA2Qwd1cBO0k3O1FbG54c0bYzCapDw9u3w9BL03MFgQJgIxMo0yJW2QcVtPmJhfXmvCGwv9C6bdpAvNazlm4YJXOvbM/23xk4+/nZZSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=AuNyG2kR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60974G2M02723801, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767942257;
	bh=Q8hYwp5seatcHmX7xtSYqRRtjfU4m6rfOPxYyubi3+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=AuNyG2kRIOGDDwYdEPxrO+becX4Xhjtbd+CE6ag4kkIZX3PuJx/USenwLtHuYeF0B
	 AjLn2hmipyB20d41xWjnJb3cF7yuoSfaVlq+qbcnJJilVbIWzeeps8Mqb1oPClzSWj
	 7A/0RthEsk8fcYw2s9nCiW6GgRGTt0UZ7/b4riTdmIBC5OdG8j0PAF5ZdR1g15eeTa
	 VUjzNTD3fcSxfVtBHJ+zblpkiLrwnC5bmcifdVibljkxgO5eAIQ2EPheu8QnQgczZl
	 ea61QxmOWyIKqVBgKHl6wmNQYxVktaUyOBy3+evC3Fs1jOnLTLkgBhGrH8R6DLmOu0
	 UgLpSc0BFQDwQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60974G2M02723801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Jan 2026 15:04:17 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 9 Jan 2026 15:04:17 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Jan 2026 15:04:17 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v4 0/2] r8169: add dash and LTR support
Date: Fri, 9 Jan 2026 15:04:13 +0800
Message-ID: <20260109070415.1115-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This series patch adds dash support for RTL8127AP and LTR support for
RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127.

---
Changes in v2:
- Replace some register numbers with names according to the datasheet.
- Link to v1: https://lore.kernel.org/netdev/20260106083012.164-1-javen_xu@=
realsil.com.cn/

Changes in v3:
- Address some checkpatch warnings and remove rtl_disable_ltr().
- Link to v2: https://lore.kernel.org/netdev/20260108023523.1019-1-javen_xu=
@realsil.com.cn/

Changes in v4:
- Fix some formatting issues.=0D
- Link to v3: https://lore.kernel.org/netdev/20260109064230.1094-1-javen_xu=
@realsil.com.cn/
---

Javen Xu (2):
  r8169: add DASH support for RTL8127AP
  r8169: enable LTR support

 drivers/net/ethernet/realtek/r8169_main.c | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)

--=20
2.43.0


