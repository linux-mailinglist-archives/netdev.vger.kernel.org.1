Return-Path: <netdev+bounces-182673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A4A899BC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972C8189DF33
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB7B28F53A;
	Tue, 15 Apr 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="UdrFsLdC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="X3coK32o"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387F28E607;
	Tue, 15 Apr 2025 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712351; cv=none; b=fW9Yuhv8JGUVyK+MqYy4u8Q/VayKdAC4vn2OXpAZ6jnYFUSopXeEiBSWK/ndfbCIOnuyCAxoskC3myYoEQSw/woL9dKPZgz3NYrlTkQBBfhp+JlUoE3ywb+1X+SKMX4kMEJUASTKA4U7iqfhh0+JbALDHFRvKlr3wi8Ndyr87P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712351; c=relaxed/simple;
	bh=N8Liv9QfdjKawBDNuMnGi9SFQeE+8ajkB3VNyo5vbTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCjAiS/w+a8dayCQTqsRwIcbay92Lv4Q4YXYnTnfrktRKZ7aQs2HsI4N5ITnUKw6zhnt6envkDq5LcPYygSJJ4K7gajt+W1WoFyftJ8q9moB3o02E54p2Mz0xrGet92EVJ0shw6pqDl+5HelJNp+EnainVwsGctO/B0bdvr0KG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=UdrFsLdC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=X3coK32o reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744712347; x=1776248347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MFqpgQW5EamtR8QdmjqS2VZbo2sqPuCPjB+h5Oo096U=;
  b=UdrFsLdC/IrVNGI6OoozoFprUPlTM/mps5qWvYrsKkkCdKH03zOKNS+C
   ubbENi/XGL2RYas6be4OeuOzvKe0ZSw+PFCw5MtRNShzGhrUrQDI85G8a
   yVN0qewLoj7PYy7jYNoxVNrUcAkVA7k7UyHPVx5ibX8kuoKIRn5+h70Rg
   20Vxz6hO/+OPX7/4IssycW/uatDx+wzZcsmRN4/MW8kgd1JoIvBRV6C4a
   rHh+lRf+wCcsIgTbB9IkY4wAisC3JYLWpdiBYjJmpMG7p8bT7I50Zg13j
   Q+i2o8Ao3r4dMbahstsVd/+wwS8B2zh73ScfM2nzmOg9yK/C9cKBriyQs
   Q==;
X-CSE-ConnectionGUID: kK/iwg5hSmuRAog/IIY4Pw==
X-CSE-MsgGUID: EsvKnMCcSpy31wr4isC/8w==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43537784"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 12:19:05 +0200
X-CheckPoint: {67FE329A-46-DC4DC9A0-F4F29281}
X-MAIL-CPID: E2AC9662668DFE112FB8F3BA65C48555_0
X-Control-Analysis: str=0001.0A006377.67FE3296.0004,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60984163A8E;
	Tue, 15 Apr 2025 12:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744712342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFqpgQW5EamtR8QdmjqS2VZbo2sqPuCPjB+h5Oo096U=;
	b=X3coK32oMqIEkB1CNfPLlgOroXkcuLoSzbI2Au0MWdzOzmnVyb3gJzdPtUha13qwd93GKh
	Sora7MJBYzJC1kzCNEBhgV1SM3XUCLV5ORJKoiH6WoGksYg3bImk/6LhW2pP8HkSU4jlfo
	P30YGLpNjS0NWcT6QeB42r/0NFKZJbD0u85Xpz+bktp4ZqcS4aXp5mqVLqvYOfYE5wGgDl
	Xfhe/Bto5TDpxjuf8DpYZO3NYm3SiFk2paNeT5VXLzyiVhiDPrKadLbldrHNlxcQ4jOC6h
	AsWGxonmQRQKnhpE+kQfWF27VuOfuMTEVWrGVTBXcBL8CiHsiios1+ksg/4FUg==
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
Subject: [PATCH net-next 2/4] dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example
Date: Tue, 15 Apr 2025 12:18:02 +0200
Message-ID: <4216050f7b33ce4e5ce54f32023ec6ce093bd83c.1744710099.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

k3-am65-cpsw-nuss controllers have a fixed internal TX delay, so RXID
mode is not actually possible and will result in a warning from the
driver going forward.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index b11894fbaec47..c8128b8ca74fb 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -282,7 +282,7 @@ examples:
                     ti,syscon-efuse = <&mcu_conf 0x200>;
                     phys = <&phy_gmii_sel 1>;
 
-                    phy-mode = "rgmii-rxid";
+                    phy-mode = "rgmii-id";
                     phy-handle = <&phy0>;
                 };
             };
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


