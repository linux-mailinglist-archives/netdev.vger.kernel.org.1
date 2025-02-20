Return-Path: <netdev+bounces-168221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E2A3E2AA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB203A847A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E550212B0A;
	Thu, 20 Feb 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk2N3yqv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208AB20485B;
	Thu, 20 Feb 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072566; cv=none; b=eCf3WGNQcjXcA7sOz3XHLS0tMfzg5Wvyg2ILWt5LxWqsM5jPJEhgkHc3NeHfTFLY+9ETlVi8DB1cfW1NC1C1h1tLKc+ABRHfK+q2TtDV2950YNFk84jAJDXLCPOT7VHkOB836KXl6SduwUNz18qroaPHfHjj0OYvL3aKlxQBjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072566; c=relaxed/simple;
	bh=sOsK+4XV+btUJLsdx7CeyNqNlxi14iZGQDMYRhXYexo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sHAKLYSS6aD3e4q5/Lw0sTu/yNZNxHdfuS8ergIYANOd0796389sMAeoOttI6tGrIaZZ0pqoqaGFVb8g44YVtaZkj6ej4yiFuCpHG3prdVCI7+dmsXcJKKxPGgIdiPwlfQcJU4bpMozDgJ9gHgcdE4ZbT+Gnuv/AQ9Avgiw/PI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk2N3yqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFE4DC4CED1;
	Thu, 20 Feb 2025 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740072565;
	bh=sOsK+4XV+btUJLsdx7CeyNqNlxi14iZGQDMYRhXYexo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Xk2N3yqv4v6rQjLjnSAIKCmdcsUYqG9kN3ru57qEOSzSVwgcGOpIvvP8GUqd1hOdq
	 yPVFNeHlF4VQUObo4nH4SnNrDunDDfW3hF2QIMb4gZPMxXMM0lD1OhkjWHd8APEgtw
	 n1oVeqVTCz56CIUdo8ySayqfXSvJNRxiZVB000sJhAzTcaS2wytGlVNlAQUB+pIxnk
	 cZBgFUaq2N0RnfEuE0q6jshVD3+Zpskg6IMITR1wesj38Pod15pn37tzFHoUnoLSsA
	 P6C1+BoTxo01RS4bHZgmq0X93Z7dvDXDv/lpZplpTUFRWzBe261Z+gds8XY3slT/IM
	 IZrkKyYZ5v5tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6099C021B1;
	Thu, 20 Feb 2025 17:29:25 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/3] net: Convert Gianfar (Triple Speed Ethernet
 Controller) bindings to YAML
Date: Thu, 20 Feb 2025 18:29:20 +0100
Message-Id: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHBmt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNL3fTMxLy0xCLdysTcHN1EM1MTIzPjJHNTYxMloJaCotS0zAqwcdG
 xtbUAxNiZJl4AAAA=
X-Change-ID: 20250209-gianfar-yaml-a654263b7534
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740072564; l=1474;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=sOsK+4XV+btUJLsdx7CeyNqNlxi14iZGQDMYRhXYexo=;
 b=Lr6gbM7OQjCNKXzFicdyKKCHoUMa+JItK8YHuHAKUwAYcg8ebgyT+I7l15eNKiuwGDztq/RQm
 ObsbmXf51vwCxnj/C/HLivLaAD7358ip46IoaKOqScMUbFVgjSPIUMq
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

The aim of this series is to modernize the device tree bindings for the
Freescale "Gianfar" ethernet controller (a.k.a. TSEC, Triple Speed
Ethernet Controller) by converting them to YAML.

Known issues that require a solution:
- fsl,gianfar-mdio.yaml (MDIO bus) and fsl,gianfar.yaml (Ethernet
  controller) both specify "gianfar" as a possible compatible string. If
  compatible = "gianfar" is used, the device_type property determines
  whether the node is an MDIO controller or an Ethernet controller.
  This confuses the DT schema validation tools:

  Warning: Duplicate compatible "gianfar" found in schemas matching "$id":
           http://devicetree.org/schemas/net/fsl,gianfar-mdio.yaml#
           http://devicetree.org/schemas/net/fsl,gianfar.yaml#

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (3):
      dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to YAML
      dt-bindings: net: fsl,gianfar-mdio: Update information about TBI
      dt-bindings: net: Convert fsl,gianfar to YAML

 .../devicetree/bindings/net/fsl,gianfar-mdio.yaml  |  93 ++++++++
 .../devicetree/bindings/net/fsl,gianfar.yaml       | 242 +++++++++++++++++++++
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |  80 +------
 3 files changed, 338 insertions(+), 77 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250209-gianfar-yaml-a654263b7534

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



