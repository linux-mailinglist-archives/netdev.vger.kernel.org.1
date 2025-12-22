Return-Path: <netdev+bounces-245774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5230CCD75F9
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 23:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 470BC309FC14
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61634346796;
	Mon, 22 Dec 2025 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="S2rH0lBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69132344023;
	Mon, 22 Dec 2025 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442170; cv=none; b=FJMcizU2UjM2BQqVzJGSA+zoWgSXSizXkXRqOpaUTJnuLBsbc4pgXwnfCGyqcaSqaNNSpX4eCxny6PAZb55m0AiRwEkz47mtlmBe+85HvGBR3FTFrpn5feXv6RHCH+yyVZXre4B/NTleT0+38Rhad4tQC9gbVbw/1xSb1GDBrQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442170; c=relaxed/simple;
	bh=h9sTwFcIF2VoWEebs9idiacVbrmeZIQUrGoTM2DVzn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9hq8ofkV/YhljSeNEwn6dgwHHdMBbThE/fbp2QGr66u/BJifMwonULr1StUHbk0g5YhkC7s9BdP2acj6rWpjLAwOB4SfmNwjzk/kWyhwLbbShhD7BRqF0vIq1FjmJtrKP29211X+hvOaaMSq1ZIumkwNyfOys1g34U/xv9PKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=S2rH0lBq; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A15AE3D854FB;
	Mon, 22 Dec 2025 17:22:38 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id k3YkhkqvBxDi; Mon, 22 Dec 2025 17:22:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E7B083D85543;
	Mon, 22 Dec 2025 17:22:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E7B083D85543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1766442157; bh=t6ij3OOLAh2RZ+jwSAyw28TaVj70IDoE5ZWQNr5Jk48=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=S2rH0lBqri/Bj+au49yl3wPpxDMsvdk2/+T1VnD5csWKpj7G6hyMyJtWBFkT++ofb
	 5zd2umqkp/zpLWqAi0qdsdacV479LwQqNZ2w5ThF/W380Is/Kfv8jGLSAKExz1W4Nt
	 I+kFe+DIKFttOvzGJSKF0JJy3VvIRtGsNCi2eKXlfopxgfhGH+zNYGvLimFXu4n3Lp
	 cHJkmY6cCXysCQYWTXJBt5LOdk2d6InhYRbPYU2d7bzeyRQTociTqs2lela0RCKh+b
	 gTTo79taW08llJdsZkCQXtXO9kF1/mrNGBCHSw/r+98ZAxXYkPlRGpD4Pj88M9/ZA9
	 4FL+Yv42cclng==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id x5KuDn4koreS; Mon, 22 Dec 2025 17:22:37 -0500 (EST)
Received: from oitua-pc.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CC6D13D854B3;
	Mon, 22 Dec 2025 17:22:37 -0500 (EST)
From: Osose Itua <osose.itua@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com,
	Osose Itua <osose.itua@savoirfairelinux.com>
Subject: [PATCH v2 2/2] dt-bindings: net: adi,adin: document LP Termination property
Date: Mon, 22 Dec 2025 17:21:05 -0500
Message-ID: <20251222222210.3651577-3-osose.itua@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
References: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add "adi,low-cmode-impedance" boolean property which, when present,
configures the PHY for the lowest common-mode impedance on the receive
pair for 100BASE-TX operation.

Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/net/adi,adin.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Docume=
ntation/devicetree/bindings/net/adi,adin.yaml
index c425a9f1886d..d3c8c5cc4bb1 100644
--- a/Documentation/devicetree/bindings/net/adi,adin.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
@@ -52,6 +52,12 @@ properties:
     description: Enable 25MHz reference clock output on CLK25_REF pin.
     type: boolean
=20
+  adi,low-cmode-impedance:
+    description: |
+      Ability to configure for the lowest common-mode impedance on the
+      receive pair for 100BASE-TX.
+    type: boolean
+
 unevaluatedProperties: false
=20
 examples:

