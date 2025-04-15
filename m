Return-Path: <netdev+bounces-182675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221EFA899C5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2637C1670F8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9D2918DB;
	Tue, 15 Apr 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MkFV+lBr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KS5my13j"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7404291171;
	Tue, 15 Apr 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712361; cv=none; b=AEGRG6q7FebqWxcEf0KOIGa18SdH+nHnqUowTK27kbq5Lxkmf6Az+mLnTBmCXnNBlpJLmc6J1HlHhzjb4PhihcxqbxHUUSU/8WASU5LfU+9vxTYxso/+iSqR1ydxsC9wZzmTeRcC6spGwxmt3lpBTs8nXUpmFyszI3uv9BE6hpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712361; c=relaxed/simple;
	bh=GLxiJlf0l4/8f/3cOIsp8spLAwZmy6rGL3fBo0ibedo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENKmWS1c2Y9XuLSx7SMNtH9qKxcrDtKABbgQ4SklMaPOhms34KUoe7+n8eRURs6W+nhCsPFAit5LBdKhjy9LegYOjRWPN6GEOM7jL+pctw6XcDCJya7vx7Jl4udfs2Er5kTgHLayN9isis9COjhriq6MROOkFYrR2J5BdV9KKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MkFV+lBr; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KS5my13j reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744712358; x=1776248358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3mgdLsAzzZaK/mOx+qOWZRMUeWUqc13Mm441pFDAiY=;
  b=MkFV+lBryBJNa6igRNWDBlpagU2YrcuUvlZWeby+D6BMtlBWLga7re+Q
   OGD7e2TIXUnyrIEy23+T8+HRkmnl2KgB34Nnbmq1HFJXLytAzrttBBu9D
   il2/Ks3ry6lTiRPIeb+R2qy5OS8NjcAvz/1SLTVz2aht7mL7u9DHGhQ8L
   T44hoVwfdHpm39KRZuboMquQa8wowu2HujjweBO2fLuJ55Nw1xob0QGIi
   0GwQXEQczlUgPFiEfF66lp/M9jjxPe2tbx4pSI52RPtMZzDqmBQipa8sN
   bc9Xs/tVhsFka/f25xRUgvY8AMso9e+Fk7I9X0UM/aGnGK1Usdjbmsl5i
   A==;
X-CSE-ConnectionGUID: IwmrXv6VTCSAI3p/xks4FQ==
X-CSE-MsgGUID: 3bL/W/GHSWOL+S5bi73eFg==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43537792"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 12:19:16 +0200
X-CheckPoint: {67FE32A5-B-7141A0B0-E6EDEC14}
X-MAIL-CPID: 5C0A9FF98528448249FF1B25666F25D4_3
X-Control-Analysis: str=0001.0A00639F.67FE32A3.002A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB06016489A;
	Tue, 15 Apr 2025 12:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744712352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3mgdLsAzzZaK/mOx+qOWZRMUeWUqc13Mm441pFDAiY=;
	b=KS5my13jufA8VQYzVUolMCKej6Q6tnssyGOSXTJ5vvYPOztf4WkrwHSB161oYHAaXSR5Di
	LU0epMxqooehsceu3dwjHl2Te7f8qmll6KsaNXzfcPOEmAqcr1APAsOPDup/VWeZu3J2r/
	VRahVBSu+/J7QqeEoucuEShtkKDdob90Qex2OofXap8YdqpdwwUollbCo2cVBlYfg7pwHz
	FYpxJD67+pTSdEZpd4q0U15HUuNstBYn0YdDGFZ8bIfRgFGO2nnkHeNh+t6TstazSpGo2G
	o7a0U9Ac5NsiMfKrEJn98eJefYeWxc0nD+814nZJxy9Z6c+ckH30du2wfZIj/A==
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
Subject: [PATCH net-next 4/4] checkpatch: check for comment explaining rgmii(|-rxid|-txid) PHY modes
Date: Tue, 15 Apr 2025 12:18:04 +0200
Message-ID: <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
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

Historially, the RGMII PHY modes specified in Device Trees have been
used inconsistently, often referring to the usage of delays on the PHY
side rather than describing the board; many drivers still implement this
incorrectly.

Require a comment in Devices Trees using these modes (usually mentioning
that the delay is relalized on the PCB), so we can avoid adding more
incorrect uses (or will at least notice which drivers still need to be
fixed).

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/dev-tools/checkpatch.rst |  9 +++++++++
 scripts/checkpatch.pl                  | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index abb3ff6820766..8692d3bc155f1 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -513,6 +513,15 @@ Comments
 
     See: https://lore.kernel.org/lkml/20131006222342.GT19510@leaf/
 
+  **UNCOMMENTED_RGMII_MODE**
+    Historially, the RGMII PHY modes specified in Device Trees have been
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
index 784912f570e9d..57fcbd4b63ede 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3735,6 +3735,17 @@ sub process {
 			}
 		}
 
+# Check for RGMII phy-mode with delay on PCB
+		if ($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*(phy-mode|phy-connection-type)\s*=\s*"/ &&
+		    !ctx_has_comment($first_line, $linenr)) {
+			my $prop = $1;
+			my $mode = get_quoted_string($line, $rawline);
+			if ($mode =~ /^"rgmii(?:|-rxid|-txid)"$/) {
+				CHK("UNCOMMENTED_RGMII_MODE",
+				    "$prop $mode without comment -- delays on the PCB should be described, otherwise use \"rgmii-id\"\n" . $herecurr);
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


