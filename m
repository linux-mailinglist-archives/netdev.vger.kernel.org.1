Return-Path: <netdev+bounces-200587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2943AE62FD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7408E4A2D25
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C9288536;
	Tue, 24 Jun 2025 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GuIe1d3s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="saOa8bYq"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AE22839A;
	Tue, 24 Jun 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762470; cv=none; b=FwhTVo7bhoy31A73sE1VaQsHX/mMROmW7POhiY57w1sqclcI7c8dlRJXQtxtP8KzZk4Ae/hbC7GyuEVbDPxcYpHRF0bxp+ttzqxmWBI04ZgVo2vph8PCspISaoCdRJeSG3EJyu2gFAM1YGj8Nu6tekFSOCl+FQ14qGWxvcUqodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762470; c=relaxed/simple;
	bh=XFQUL/ufKmduvsab7cpaVa7z9kXRW8qygpQbUY4yqmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BvoBjP7/61NhpszLoAU8hOcW7UNyrOAV86kBo6pZBqpBwz2ygVbzeXMMQmKB4BO1QoZQT0oMcd3YDo79CCazyYKfen9oFG/sKeY61U4PUB+WDZszkxF499Z/cNGZKuvB0mEhcu8XdDEwEjeVI7brz2db105Z1PTEmLEPGgamZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=GuIe1d3s; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=saOa8bYq reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1750762466; x=1782298466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LNMTaDoZOlzVn3fThn2AT/sDwHK58mLK2vG4Ir0w4rU=;
  b=GuIe1d3sCVa1mgPSdWajGnhLB1hYulNbbTIbsZiN4OT1AQJ3y8o4Zmqk
   pvtWwemHX525YSaZ4QuGvseltMz+ibkgniFtICrgF9rU+5VM4utURJs7v
   G3IgBWRZ3xgRC2o+vee/W/A3kZLpLNPl0ujCL2xApxJRT2DafNd35QwTy
   BiMIKxvQ6phKRUFHeIVWiO0RlMcQENUpVkyRCyM25NYz9e70od1BlM5G6
   SkXUPYgauzeelk+4s71izH/QJ+r6RornHEHJI7VSvT/ZYuCivcssJIKfU
   E6vn+PIBdmUOHWh+cxoc8bnQzh8RwhHD0kEfVSErYX5ryel4snbPBn0j/
   w==;
X-CSE-ConnectionGUID: XNJw146vS0S96A/0Nhey9g==
X-CSE-MsgGUID: XYPmM7QWQlSUiFR7VllvFQ==
X-IronPort-AV: E=Sophos;i="6.16,261,1744063200"; 
   d="scan'208";a="44816885"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2025 12:54:22 +0200
X-CheckPoint: {685A83DE-2C-B72BD212-DAE8BA0F}
X-MAIL-CPID: A72EB87A374EF68D021090087AE03C24_1
X-Control-Analysis: str=0001.0A006375.685A83EC.0004,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9384116423B;
	Tue, 24 Jun 2025 12:54:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1750762458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LNMTaDoZOlzVn3fThn2AT/sDwHK58mLK2vG4Ir0w4rU=;
	b=saOa8bYqz49bPCywbHMDxBDmgEkl/9wgRYj/qEDSmQOU4uM2DBolqjUuAWtcnTbyC1Ahzz
	2MniU12XGqOGT9khFu2JtBdtDeWha8crh1JMQN7IpTpPo+khBkmuOIN/BVxhHxz40xF5YW
	KXSKGAn3yyfzyk1ZD2Qe/hVu2eHf0qpkkrgCkBjX2ypGxz8Qj27SiUB5mslwISenZ3uu+K
	GFcmB/zOURYTVtv2oP8Id5nNkbBIMPeQz+wxaYqEPvfGLGZSofRA3Vmnhld/2FtMjOsXTv
	fzfk61lQKdOUCs5BzayybDhxhSdA9X5LTKe0EjRskLuA0tNiEVcMZ/0EgxwKXA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next v2 0/3] Follow-up to RGMII mode clarification: am65-cpsw fix + checkpatch
Date: Tue, 24 Jun 2025 12:53:31 +0200
Message-ID: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Following previous discussion [1] and the documentation update by
Andrew [2]:

Fix up the mode to account for the fixed TX delay on the AM65 CPSW
Ethernet controllers, similar to the way the icssg-prueth does it. For
backwards compatibility, the "impossible" modes that claim to have a
delay on the PCB are still accepted, but trigger a warning message.

As Andrew suggested, I have also added a checkpatch check that requires
a comment for any RGMII mode that is not "rgmii-id".

No Device Trees are updated to avoid the warning for now, to give other
projects syncing the Linux Device Trees some time to fix their drivers
as well. I intend to submit an equivalent change for U-Boot's
am65-cpsw-nuss driver as soon as the changes are accepted for Linux.

Changelog v2:

- Previous patch 1/4 has been dropped, has it has been replaced by [2]
- Patches 1/3, 2/3: collected review and ack tags
- Patch 3/3:
  - Fixed multiple typos noted during review
  - Extended to check .dtso in addition to .dts and .dtsi
  - Changed CHK() to WARN(), so the warning triggers without --strict

[1] https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434dc28@lunn.ch/
[2] https://lore.kernel.org/all/20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch/
    commit c360eb0c3ccb ("dt-bindings: net: ethernet-controller: Add informative text about RGMII delays")
Patch series v1: https://lore.kernel.org/all/cover.1744710099.git.matthias.schiffer@ew.tq-group.com/


Matthias Schiffer (3):
  dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example
  net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay
  checkpatch: check for comment explaining rgmii(|-rxid|-txid) PHY modes

 Documentation/dev-tools/checkpatch.rst        |  9 +++++++
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      | 27 +++++++++++++++++--
 scripts/checkpatch.pl                         | 12 +++++++++
 4 files changed, 47 insertions(+), 3 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


