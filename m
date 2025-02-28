Return-Path: <netdev+bounces-170815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C529A4A07A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C264176899
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2326D5BF;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifoY96QM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A751AB6FF;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763973; cv=none; b=GDyZW+sF954zhYejFLKPuQUDjWLFE7oWqpQcwrAhT9MxNafj7UeMyFZABeh2qL/lD+iNHFvFnYWNkIexh5zz0y+5daO2LUOLh+o7QFb3Kfjl5pTVgq9ftvwoesB6rbkWlQVW187lLnUoBLenobQ9ZC12ZgIS833s5nIkRhNr3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763973; c=relaxed/simple;
	bh=euun0HGyq72O1vTOyptLcCjp/eEKm3tx5sHSwnHWWp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hpgOO66O6vwROM0ttG96Tr1x43PJXIVFhtZpktleLLitnKXfLHx1RCfeUBboGdB/jFjeoYobkNj8kjRmpLVvnwgAf3MwuBA5s/9ivy5HEwImUovaPvF1RH6BhgwplmY0ZGx1cFgIsfD02TpNUSn4bc+W72fHcsqdS5dHQR+/Wrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifoY96QM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02D14C4CEE8;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763973;
	bh=euun0HGyq72O1vTOyptLcCjp/eEKm3tx5sHSwnHWWp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ifoY96QM/XuiIK4B5mPzDJcoF1Fv9PNAmsIVvZG+MFaicy1aHnRJRcG7lYQvnyAae
	 b2etrvMw4mSw2uBI5Z9WIEqjX2UZPWFIp2HHcglN0fjPighM9ryArkk0oCo96U8jmw
	 2thpc9Z2lwitLoW7jBiNm+zkVDt75sTnNSFiKsCT8td6XyhUEZxKNI4F/hP/77URtw
	 NzT/JH+pf9Dq+L2eUqWcJz2Al+6YujhT59Thnkz6xwf/gCDzuONBdyfWNZcwaU9BL7
	 Zzq2TowWbUE3itfpevAebsqZI8gl/VtBNTGl1adWCEYI1rLYCeL7TAx6PYwhpd2Cz2
	 yR60vEy/tESzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E647AC282D2;
	Fri, 28 Feb 2025 17:32:52 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 18:32:51 +0100
Subject: [PATCH v2 2/3] dt-bindings: net: fsl,gianfar-mdio: Update
 information about TBI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-gianfar-yaml-v2-2-6beeefbd4818@posteo.net>
References: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
In-Reply-To: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740763971; l=2181;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=zMz5pAYjehVzrNabVSZ8qNmJKs7MqhCYd9lIZiB49GU=;
 b=AkdnvksPfyxakEhB3XwQ6sK5tZChmkcrUjnPSbZK3tJdJtEfx5VTc/uKkXTbqX/8SjPEjtPYR
 e1vbgPFysgPChsNmWKfIUmEBkmmxwHZfXvF3WTuGVhs/jkjKu56DVyi
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

When this binding was originally written, all known TSEC Ethernet
controllers had a Ten-Bit Interface (TBI). However, some datasheets such
as for the MPC8315E suggest that this is not universally true:

  The eTSECs do not support TBI, GMII, and FIFO operating modes, so all
  references to these interfaces and features should be ignored for this
  device.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- Add Rob's Acked-by tag
---
 Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
index 22369771c13614875845b6d6e6d6031b933cb152..03c819bc701be4e6bcae37891baccd4b01ec53c4 100644
--- a/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
@@ -11,13 +11,12 @@ description:
   connected. For each device that exists on this bus, a child node should be
   created.
 
-  As of this writing, every TSEC is associated with an internal Ten-Bit
-  Interface (TBI) PHY. This PHY is accessed through the local MDIO bus. These
-  buses are defined similarly to the mdio buses, except they are compatible
-  with "fsl,gianfar-tbi". The TBI PHYs underneath them are similar to normal
-  PHYs, but the reg property is considered instructive, rather than
-  descriptive. The reg property should be chosen so it doesn't interfere with
-  other PHYs on the bus.
+  Some TSECs are associated with an internal Ten-Bit Interface (TBI) PHY. This
+  PHY is accessed through the local MDIO bus. These buses are defined similarly
+  to the mdio buses, except they are compatible with "fsl,gianfar-tbi". The TBI
+  PHYs underneath them are similar to normal PHYs, but the reg property is
+  considered instructive, rather than descriptive. The reg property should be
+  chosen so it doesn't interfere with other PHYs on the bus.
 
 maintainers:
   - J. Neuschäfer <j.ne@posteo.net>

-- 
2.48.0.rc1.219.gb6b6757d772



