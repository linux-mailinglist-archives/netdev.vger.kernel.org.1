Return-Path: <netdev+bounces-200590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F92AE630A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F881925552
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2428D8FE;
	Tue, 24 Jun 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="g6ofmyoi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="SbnfxT7E"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B4291C14;
	Tue, 24 Jun 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762483; cv=none; b=hAha4Sf8ejmbu2U2xXq3vwqefSg2ANCh45N42W94Pfr/la60NjbwAwuktHZ4d7tBxlhEHVTuRsnzNlPKBDWk3XZqg6j7hhnz86xx7NLiuiR6+QyogHcTJcQpPvIN9xOHQiBydTwz8DHJMEqMvogy/4RonGJVhWuzeXU4Fx6srHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762483; c=relaxed/simple;
	bh=RAzj7N+bla1iOo7p7vEicwLOK6iXhYpo48QQ3+tl5vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+Nht9QcdbBfyfty/OUHWigefAaFGVhPbhljg4hkYMIupFiASWVtNlIHGdsixk9EPr4tLJEY9GwPP8ZasGv5pkH6ySTrg8Kdo5V5f+plVSRagaskksNBmjmob0IteE1a05nRg18Cj56xBoXiZ4H6/TGp6hdr8DzenlaIy4M0HIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=g6ofmyoi; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=SbnfxT7E reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1750762480; x=1782298480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2cpStAr6k7XetnbU5fKbj58a2ZRw9CKJ+3G33iwY1+M=;
  b=g6ofmyoiccMFKm7oN+B/LyzhR95vKvKXwfvcV9KoNZCa3p3+FLJu9Dwk
   0xyWrHe0aQVC7vTkYhTU7gtzSV3KRhPNat1KbCCanItppR5Yjc5lQcCiC
   3qOu4SkNYC2I/3vfsRPVN3jTmgdq5g82k4bAcBw0Y5ayGukJmSLZtptQ3
   trwz1Lc70a255rhon6xjDYC5NmwZDMYWQ16kQMiYlNdN6hAbHgr7x2Y8d
   4KpltKt5BWUDmC2+zX0uxdpIwxnsmGQLL6YBODc/mqXFvu7uN+XfbNBsL
   PkoiV8p/XQO+HF6vCcvdIpjf4FlN4Txbh4ByFjXIdy/rUHALeBweMS1rP
   g==;
X-CSE-ConnectionGUID: HsnVMn02TZKNlmym4byIaA==
X-CSE-MsgGUID: JkffxU5oTOOyULapxLFXuQ==
X-IronPort-AV: E=Sophos;i="6.16,261,1744063200"; 
   d="scan'208";a="44816899"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2025 12:54:37 +0200
X-CheckPoint: {685A83ED-F-ABFC28F4-D6731B76}
X-MAIL-CPID: A25C1993D7B21E6C5F4D086DADF8A3C0_5
X-Control-Analysis: str=0001.0A006377.685A83F8.0088,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84239165D7C;
	Tue, 24 Jun 2025 12:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1750762473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cpStAr6k7XetnbU5fKbj58a2ZRw9CKJ+3G33iwY1+M=;
	b=SbnfxT7Ef893QSiAOwEAj4WRHi9CGMIPVPw0+jarCIUVMDi5tQGggIXLEIA08aQuIChHUn
	f7mBIWwtuSlkSaW4AhGak1WeASuzESsiZkpb8ARK5vidb+7nHPV0NIv83guJxPyVkWGAXU
	4e7qCLilOFhbPO/HOEQjE7JTrTF4m2GkqmX+EeVg+VFZn/oPb2gAy2Grym4GpMSWsr25U/
	DEb0fMTBJqlyrM8IJbnVnJffnoy1zj1OSMDx/04aMhXJo2bjGAD5aBrT15eJFzhjRRBJfu
	q9eiTdNBTHc1Q+XugRUaj5yjA6AZJbPD2HI1kdhSBxnJplUEji6GjISE7sBRYA==
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
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 3/3] checkpatch: check for comment explaining rgmii(|-rxid|-txid) PHY modes
Date: Tue, 24 Jun 2025 12:53:34 +0200
Message-ID: <bc112b8aa510cf9df9ab33178d122f234d0aebf7.1750756583.git.matthias.schiffer@ew.tq-group.com>
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

Historically, the RGMII PHY modes specified in Device Trees have been
used inconsistently, often referring to the usage of delays on the PHY
side rather than describing the board; many drivers still implement this
incorrectly.

Require a comment in Devices Trees using these modes (usually mentioning
that the delay is realized on the PCB), so we can avoid adding more
incorrect uses (or will at least notice which drivers still need to be
fixed).

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/dev-tools/checkpatch.rst |  9 +++++++++
 scripts/checkpatch.pl                  | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 76bd0ddb00416..d5c47e560324f 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -495,6 +495,15 @@ Comments
 
     See: https://lore.kernel.org/lkml/20131006222342.GT19510@leaf/
 
+  **UNCOMMENTED_RGMII_MODE**
+    Historically, the RGMII PHY modes specified in Device Trees have been
+    used inconsistently, often referring to the usage of delays on the PHY
+    side rather than describing the board.
+
+    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require the clock
+    signal to be delayed on the PCB; this unusual configuration should be
+    described in a comment. If they are not (meaning that the delay is realized
+    internally in the MAC or PHY), "rgmii-id" is the correct PHY mode.
 
 Commit message
 --------------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c2..f597734d83cc0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3741,6 +3741,18 @@ sub process {
 			}
 		}
 
+# Check for RGMII phy-mode with delay on PCB
+		if ($realfile =~ /\.(dts|dtsi|dtso)$/ &&
+		    $line =~ /^\+\s*(phy-mode|phy-connection-type)\s*=\s*"/ &&
+		    !ctx_has_comment($first_line, $linenr)) {
+			my $prop = $1;
+			my $mode = get_quoted_string($line, $rawline);
+			if ($mode =~ /^"rgmii(?:|-rxid|-txid)"$/) {
+				WARN("UNCOMMENTED_RGMII_MODE",
+				     "$prop $mode without comment -- delays on the PCB should be described, otherwise use \"rgmii-id\"\n" . $herecurr);
+			}
+		}
+
 # check for using SPDX license tag at beginning of files
 		if ($realline == $checklicenseline) {
 			if ($rawline =~ /^[ \+]\s*\#\!\s*\//) {
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


