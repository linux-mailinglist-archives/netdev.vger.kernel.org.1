Return-Path: <netdev+bounces-170812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D086A4A075
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95747A8AD0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FB31F09A7;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcgW8O6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AF1F098E;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763973; cv=none; b=U8MVCYBoSbXBW0bJfSmvNx2kmkEhKEQe/Nh2YFA1Ho7QIO00kEj5AVbkXB3Cl5ToGSpfqey3YdECTZUZOtU4XhOBeNU3ZzbDP+xS5BfdMXGvUp8s/mO9/8WcmDU/nzWGuXUNK5Mz/v2JESBaRO9TsGl2t/YSY7fvI0lohFjhOek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763973; c=relaxed/simple;
	bh=05YjIwxt9ICbD8A5g413HEEyLgeVF09nKkvpDTpwysE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OT4qQn2uqG19gyKFLSokpVphAlQUebXJdTxs9bmVphKNy3bYbb8SZ1CEQkN4P93cA9OZGiMmmA8Hpidz1OhAfI88WW185Is3n09APq+xmzrWvbvkUVnHGETWXXMF7bmHfsIw+JL4DhNtQCXc9iq98QqJWmzhf89eLuv8aBNf2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcgW8O6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5EF1C4CED6;
	Fri, 28 Feb 2025 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763972;
	bh=05YjIwxt9ICbD8A5g413HEEyLgeVF09nKkvpDTpwysE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tcgW8O6T7G7VdoJbU10ciL1w1PLzKLBAKTg41as/SOrxwabvTW8/Ir0wJarOLSIH2
	 FtddBEmdK3t3BwNZwtWWorR+ZEE1OY6w9AgCMKTLzLapLbC2uIwr3weQvlz3+UWjpr
	 fv9sV5mTJ5CVZIaA1cJyWdW5UxXJEZyrRO8m4U/sWPvLLSB2kjxitM4ASEWQkRO8AT
	 6bmkaPWh4TmSBegLAHL685tgC4jeWBgmtEEHpxQuRF1d7eAmnCQ06gLBVWgkPDGi4m
	 oUV8u5X0eeaUG37iEG0Bl0vMuMfiQ5AhvdITC3VZR2P6ID3KI3fAI5BVpedBT+8dhu
	 KyC0Fu1vSbPKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3380C282C6;
	Fri, 28 Feb 2025 17:32:52 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 0/3] net: Convert Gianfar (Triple Speed Ethernet
 Controller) bindings to YAML
Date: Fri, 28 Feb 2025 18:32:49 +0100
Message-Id: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEHzwWcC/1XMQQqDMBCF4avIrJsSR6PYlfcoLmKd6ECbSBJCR
 bx7U+mmy//B+3YI5JkC3IodPCUO7GwOvBTwWLSdSfCUG1Cikig7MbO2Rnux6ddT6EbV2FRjq6o
 a8mX1ZPh9cvch98IhOr+deiq/6w9C+Q+lUkghR921ZirJdNivLkRyV0sRhuM4PnZOJHCpAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740763971; l=1162;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=05YjIwxt9ICbD8A5g413HEEyLgeVF09nKkvpDTpwysE=;
 b=QXXMsMCKLcwGmYcgKknZtJuqocOJDhGbr3dYT/Km5BQNVg3sQJFdVbmJj0GRxpYO0l1NJ+ncR
 5wBDm7U3nnFCIMmBCFjrGyYeC1G7yCZEadaa9aR2PRU0jUA1McHDzFT
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

The aim of this series is to modernize the device tree bindings for the
Freescale "Gianfar" ethernet controller (a.k.a. TSEC, Triple Speed
Ethernet Controller) by converting them to YAML.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- various cleanups suggested by reviewers
- use a 'select:' schema to disambiguate compatible = "gianfar" between
  network controller and MDIO nodes
- Link to v1: https://lore.kernel.org/r/20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net

---
J. Neuschäfer (3):
      dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to YAML
      dt-bindings: net: fsl,gianfar-mdio: Update information about TBI
      dt-bindings: net: Convert fsl,gianfar to YAML

 .../devicetree/bindings/net/fsl,gianfar-mdio.yaml  | 112 ++++++++++
 .../devicetree/bindings/net/fsl,gianfar.yaml       | 248 +++++++++++++++++++++
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |  80 +------
 3 files changed, 363 insertions(+), 77 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250209-gianfar-yaml-a654263b7534

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



