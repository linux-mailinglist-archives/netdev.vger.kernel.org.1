Return-Path: <netdev+bounces-182672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC7A899B9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D8168A69
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291F428E614;
	Tue, 15 Apr 2025 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NJBS9+wz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mx91+Fp1"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438F28B51D;
	Tue, 15 Apr 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712348; cv=none; b=nb27m3iz+1A1sN/e7tkoQReNz8gt1TFkK6TMgdAB3F/TEZS5trFJ6yl8/hQdWptroaBeZ+uivwlVfF0t0L+JXC0xf9kT1xrIQS4w4yl5XT131niRwhAotvfMBimRHIEjHCkd+HaayGH9Fw/X/Atu890MSIEetWlTnwljp+4aVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712348; c=relaxed/simple;
	bh=soMsuOoW4yEHs0ZnKQkME+wdlHFOzVeyMEamxHTbjpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3qQnK1qykTP1/mqfXIekJdPVO6xvAK4rHk4mWqUarI0E21dVJgPep0r9eIutjDp80XceS+WbG5lt93udYXey580TZB9o+tl5e4Z6ivmeTf6u68/0SEKs38Yo90s2y5i1AmS6a2ZrX1UEIgkl2gu1UIegYO+DINpdCjfoTPCxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NJBS9+wz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=mx91+Fp1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744712344; x=1776248344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wimGa1udfs/aPQ4Ye8/P3PbpDd6kr57yzXcYNHlkEz0=;
  b=NJBS9+wztb0Zmqku2Qf3sJKCNlGEEat5t4+NXY6IxTmGMVvGBBhO/YyM
   GpQccQN8SU8sLYt5B30MhTgbE/FgCWsXrBy/2eAO6be2zZ/8ForiWxLKZ
   yxQBN0DzM0k0l0oCBhf4NHdEGMZ8jhIZcEZaUbMr8tv2VOocHBHV+h+PU
   yxO1sz0xeWpMZrVd0kVKfxLMDigxD0MUyip7JNYUwXaoj8bUkCnX7VlyC
   GuwBMV/+BZPFCXj0x/9CfL1QbzfDNuEFH7YM90zNSv/e0jTox/6EfCSxe
   x3dG+5KSJecW85g+uzIxNB07VlTOo8wxL9bDFSs2pG4/iXIaGJxC2nkGB
   A==;
X-CSE-ConnectionGUID: OuAOiMBSRoC+zQEZDLxotA==
X-CSE-MsgGUID: XuVPIJwfRKKZTxbe3vRGpw==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43537781"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 12:19:00 +0200
X-CheckPoint: {67FE3295-24-7141A0B0-E6EDEC14}
X-MAIL-CPID: 5E09EB4AC63FE62BE71D1E04C3EAC840_3
X-Control-Analysis: str=0001.0A006377.67FE3290.0089,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2446B164775;
	Tue, 15 Apr 2025 12:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744712336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wimGa1udfs/aPQ4Ye8/P3PbpDd6kr57yzXcYNHlkEz0=;
	b=mx91+Fp1Q3/95YOyqSJE6PCDOydgSAiSmP41FQgtqttT2RkJol8Zcf9PfdWlo0BkXX6MG3
	E2aQdW2UlQAAcZqCkvB93mxTC8cTxQ1zaWzV+MvAibykg6qA/sZ0EzdXj2wo7rR/xQKDHy
	/PPYQic0ceEa/3v85eHkjhNnZnVVaq0ekHO69UeE72I8QdUE5bu4D9Fjprap2+Fk6xvoz6
	ot12jRTMibeNSTo4wqb/kQ94MyRC1+utDam6+YAI1wuY7tUfilAUmnVgn5EMuojBTx9+Fk
	bjmHugCSgGWgP9Ym56HKUxIrN6lSJyBqZwIKvhTpaf45JMZRldPAkc8bSZe8Vg==
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
Subject: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller: update descriptions of RGMII modes
Date: Tue, 15 Apr 2025 12:18:01 +0200
Message-ID: <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
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

As discussed [1], the comments for the different rgmii(-*id) modes do not
accurately describe what these values mean.

As the Device Tree is primarily supposed to describe the hardware and not
its configuration, the different modes need to distinguish board designs
(if a delay is built into the PCB using different trace lengths); whether
a delay is added on the MAC or the PHY side when needed should not matter.

Unfortunately, implementation in MAC drivers is somewhat inconsistent
where a delay is fixed or configurable on the MAC side. As a first step
towards sorting this out, improve the documentation.

Link: https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434dc28@lunn.ch/ [1]
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 .../bindings/net/ethernet-controller.yaml        | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 45819b2358002..2ddc1ce2439a6 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -74,19 +74,21 @@ properties:
       - rev-rmii
       - moca
 
-      # RX and TX delays are added by the MAC when required
+      # RX and TX delays are part of the board design (through PCB traces). MAC
+      # and PHY must not add delays.
       - rgmii
 
-      # RGMII with internal RX and TX delays provided by the PHY,
-      # the MAC should not add the RX or TX delays in this case
+      # RGMII with internal RX and TX delays provided by the MAC or PHY. No
+      # delays are included in the board design; this is the most common case
+      # in modern designs.
       - rgmii-id
 
-      # RGMII with internal RX delay provided by the PHY, the MAC
-      # should not add an RX delay in this case
+      # RGMII with internal RX delay provided by the MAC or PHY. TX delay is
+      # part of the board design.
       - rgmii-rxid
 
-      # RGMII with internal TX delay provided by the PHY, the MAC
-      # should not add an TX delay in this case
+      # RGMII with internal TX delay provided by the MAC or PHY. RX delay is
+      # part of the board design.
       - rgmii-txid
       - rtbi
       - smii
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


