Return-Path: <netdev+bounces-200588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E6AE6300
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79934188B27A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3528A724;
	Tue, 24 Jun 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cqcL80Dt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MUiSjZjf"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E23F288C18;
	Tue, 24 Jun 2025 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762473; cv=none; b=pKep3dmSXIuU723+s1Q6jDJTC+2vNE65qkIZf+Z8uKPVgDATluqOZbciN3//aeOm4TnGxCbtup80pRy0ui5DRHiTuo25HgVxpLy5AYUU4+2lvkCIW75CIX5dXIEBcqq7Z6hBHJIk1jW+reqH44kFK1rcXMq+W1tMNO0dm9RQ9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762473; c=relaxed/simple;
	bh=xOcPBxesAS/Nvz9n6NylGrfNaFZ9cp2mNB3qlYWmfiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOU+DFU2NAPUvytlUfphFUXLISnzE8O+Q+zBrz109kEEktrNk283Vmkv7PjHj+RSCJCETuCCThFp9paUoHzSIkk13yuUcL5TrXi+oEooX2qvvVyA8nxq1qpuhMJ8gPzW4lPbFFjyu76uqx9sA3Khx3kHhpCrIYMTUC9pN4bUrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cqcL80Dt; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MUiSjZjf reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1750762471; x=1782298471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIypQyu9izBr/7A1qOa4FEQ2MGblzldihGtaN/SHPP0=;
  b=cqcL80DtTLN9c+vUBDEFz8E3XQF2J7E2dBSqlbJCsj+dNttHwLrM33sF
   z+sGWRmdh6flTqT62L62fuRclAirxFhLi0YdnRj/9jxcWTGx1WPHYfCja
   /hZiNu7PUm9NkZw/jhlRi6BVn++FAGRKblKwHKNYCXwdS44d21NW44/xv
   v7SjNJ4+ZEQJ26LMY3M85k4GpApZW0en9lBQvT7/faZlgcSLMHGLpjwPN
   L6WuKRKBhgVfBs2Gf1Vu70aR44+xIanZF6ttfBgO5lEe1TH12lkUC+Gyd
   6JO5W4lkyvODYjOd7wRh3jg0GlJ+t45EotKvy+jwq/2DeisrgEsxUtzI1
   g==;
X-CSE-ConnectionGUID: eLKUm0CuTYGtOiwXD4x7LA==
X-CSE-MsgGUID: szbgzfL8T7uRoTX6yCEaZQ==
X-IronPort-AV: E=Sophos;i="6.16,261,1744063200"; 
   d="scan'208";a="44816890"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2025 12:54:27 +0200
X-CheckPoint: {685A83E3-18-ABFC28F4-D6731B76}
X-MAIL-CPID: 868EC48A26FC023677F57C65E2F6EDBB_5
X-Control-Analysis: str=0001.0A006368.685A83FF.000F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1823165D19;
	Tue, 24 Jun 2025 12:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1750762463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIypQyu9izBr/7A1qOa4FEQ2MGblzldihGtaN/SHPP0=;
	b=MUiSjZjfzTSatmv3j0U1YVfQTh2qXBN1BCFlL4JzAgPYiKKxPG1qOjgcrxgQnLHnMQexIX
	IWehI7DV5ZKXuQESQFLtA9qONwYCOckDyzxDR5carfawZLhUWvYhrBXqamOQYoszVrl7UN
	uzw/MC6ncCbm+Cp1MAtFih8lWMSP5bqBpWFpONI1YFfVsKl+h3MgDM0UQUHBTg1Vl/fbso
	qjdbL0mswPkuzjlhqBg8mXBDo0RuJVx8ZfzuuqnbsDTk/kXXl1HOxFCUgnp3SgBCeC3+KF
	QhaW7kHc9NGuz/qkeU3C5Wvs412sGTabjPbjkFU2NzKtNUl6zW6YMAjPK9uyug==
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
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 1/3] dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example
Date: Tue, 24 Jun 2025 12:53:32 +0200
Message-ID: <f9b5e84fcaf565506ed86cf1838444c2bc47334f.1750756583.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index 7b3d948f187df..a959c1d7e643a 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -284,7 +284,7 @@ examples:
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


