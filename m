Return-Path: <netdev+bounces-247896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922FD004F1
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 23:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D374B30239FC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD72FD68B;
	Wed,  7 Jan 2026 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="JGsvQm9X"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F327510B;
	Wed,  7 Jan 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767824978; cv=none; b=u3htA8w+yny1CnnTZhddQfl5tgB2OSet6coYkkCWHebSDrYQhga7lWFUpj8EF6AEBCvVIavDP5LRRVhLDvWBOEFy1XIZkXghPBP6P9JfjFhiawbxFsw6XxYiQ/pGx0urXIlWv+/DKOcpV7lluf6b9a57MnZ5L92HmTwhXxijE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767824978; c=relaxed/simple;
	bh=PpRMIVVGL+LKNB6DZ4hfIdnkbdC7KPjjimbm0u5I2co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVE3f4y7aqbOZ3+NiAQOqjrmddW8eXJ7g58mGgYGOAOT1M0xCwC92OQQgz066r2x8nbw3nwKb+tD/KWGi5nN73xivVsYL9qd/eP6pOWxp5Lgu0wRs9lLBjS2UGgoC1DsV3zxx61p4SOIh8g2WRxgEoSKf7YntrvYAsznnaL3rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=JGsvQm9X; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4CC723D8517C;
	Wed,  7 Jan 2026 17:19:52 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6es2FM1r3awo; Wed,  7 Jan 2026 17:19:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 813643D85335;
	Wed,  7 Jan 2026 17:19:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 813643D85335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1767824391; bh=tpkOvFCXO7k+g2tJHJOPhaQQWMmDAm5QGPGlvIH/qrE=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=JGsvQm9XV1AMxAyEesFD019gbXAovb/dNemZh9Y5WSEPw95DwBj7BVLOlquE+639q
	 y8bgrLMIk9VqZvoY9bDtQoYaOMQ6+FhyDIB46Gj6orY5Qli/M4Ht2ZP0XuCB1U2kWK
	 UmTVROstahwk8AiXWpDh/N8vvUVk7DRp5q24IkyhGzadlAeRiQtXAqFtuzseer3XQ1
	 P8yKbZIfzJpTyZjEa5QLGPJGX2uhdVUE5jE5d2L9YBssC8qrS1CqpcwJYAecPJQpW+
	 tEfrGpfTy+Yl7o+PcKbuzuaY8GU4dEEN/gX+azBiq4lgynj9O2YozEz5T7vVoxtuc/
	 JzJYB9ziE6gig==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Ihano5PtzQiT; Wed,  7 Jan 2026 17:19:51 -0500 (EST)
Received: from oitua-pc.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5977B3D8517C;
	Wed,  7 Jan 2026 17:19:51 -0500 (EST)
From: Osose Itua <osose.itua@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com,
	Osose Itua <osose.itua@savoirfairelinux.com>
Subject: [PATCH v3 1/2] dt-bindings: net: adi,adin: document LP Termination property
Date: Wed,  7 Jan 2026 17:16:52 -0500
Message-ID: <20260107221913.1334157-2-osose.itua@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
References: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add "adi,low-cmode-impedance" boolean property which, when present,
configures the PHY for the lowest common-mode impedance on the receive
pair for 100BASE-TX operation by clearing the B_100_ZPTM_EN_DIMRX bit.
This is suited for capacitive coupled applications and other
applications where there may be a path for high common-mode noise to
reach the PHY.

If this value is not present, the value of the bit by default is 1,
which is normal termination (zero-power termination) mode.

Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
---
 .../devicetree/bindings/net/adi,adin.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Docume=
ntation/devicetree/bindings/net/adi,adin.yaml
index c425a9f1886d..f594055c2b15 100644
--- a/Documentation/devicetree/bindings/net/adi,adin.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
@@ -52,6 +52,20 @@ properties:
     description: Enable 25MHz reference clock output on CLK25_REF pin.
     type: boolean
=20
+  adi,low-cmode-impedance:
+    description: |
+      Configure PHY for the lowest common-mode impedance on the receive =
pair
+      for 100BASE-TX. This is suited for capacitive coupled applications=
 and
+      other applications where there may be a path for high common-mode =
noise
+      to reach the PHY.
+      If not present, by default the PHY is configured for normal termin=
ation
+      (zero-power termination) mode.
+
+      Note: There is a trade-off of 12 mW increased power consumption wi=
th
+        the lowest common-mode impedance setting, but in all cases the
+        differential impedance is 100 ohms.
+    type: boolean
+
 unevaluatedProperties: false
=20
 examples:

