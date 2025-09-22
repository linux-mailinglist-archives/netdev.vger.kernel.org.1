Return-Path: <netdev+bounces-225413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED80B938B4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CC32E1756
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68430DED7;
	Mon, 22 Sep 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KopUwvRd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A2301025;
	Mon, 22 Sep 2025 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582617; cv=none; b=BfiQQJLzZ3u358npwg6byjTSwAO4Qc3KfEdlSCtsvidcwnN3k94AhO2ZlmgoJJpTxZqSNnumkYmgFH4TeKraEj2P30aUHzlTMyTBIXVWnwtKCiN1CCAhVg93UmM2V++EafOUcV/bijn34e0HaJCRNqagtzJmCzhp34761pRIbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582617; c=relaxed/simple;
	bh=2H8u0nMQOk8J5k4aOevdVI2N7c+wHOn6Uzv79nphwTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UzwMUoOAB2jaUVldccnF2Ah2/yvCXS86drBlBJ+uf75U3C5ZfO2qvmtlxGjk5LFNkES05xdFnetm+oF3yIRSe8QWV2gPtG+8T3nwHKX0Q7E3ESImY1+o27yANa04+qay4c00gZcotES4sRmuTQCL2XDAUYYXUNTZrZZmCyGy+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KopUwvRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6541C4CEF0;
	Mon, 22 Sep 2025 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758582616;
	bh=2H8u0nMQOk8J5k4aOevdVI2N7c+wHOn6Uzv79nphwTc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=KopUwvRdOafyKT+jl6cNuDCypg9pUsWW3bRM8d+9noell34zPPzFAZF7WzHyQqs4o
	 99SpECVzKNVZ/ixkSUzYcrASP7nBKdgzWW9F98JOwdFuBDqP0n6zfUpNrdsrBAHQd3
	 T/vpoc5txQKUXtYGSfpB3qhTnaDbWbv3KEihNLApv4SiShosD+dUpe+gCA0+XaiMc+
	 EYcDZw2WWI+pUuApOb7yShOKFhf04cUKTjSr8GnztWvBYRULScSmiaC38+skWBSKwp
	 zj0kbM6ytB9bpkpfOADcr29lfKKb5aFlS1l7UjcqzrZomXMaiABMqM2HxdnO4ywjDK
	 PyWA3KQmuFsFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA35CCAC5AC;
	Mon, 22 Sep 2025 23:10:15 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 23 Sep 2025 01:10:01 +0200
Subject: [PATCH] dt-bindings: net: ethernet-controller: Fix grammar in
 comment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-dt-net-typo-v1-1-08e1bdd14c74@posteo.net>
X-B4-Tracking: v=1; b=H4sIAEjX0WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNj3ZQS3bzUEt2SyoJ8XcvU1DRLk1SjNGMDMyWgjoKi1LTMCrBp0bG
 1tQC13EunXQAAAA==
X-Change-ID: 20250923-dt-net-typo-9eef94e2f306
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758582614; l=1216;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=UG1p5Ilscqfsthqo/vFuqDREG76+9qwWwF2C33lkH4U=;
 b=YKEwhNmEE7v9/7DglAAFg5iNOpL05owbfonhI07MdVIUhy1zsCQPerkREszKe6k3OBfRb+quw
 uL4A71PB/lQDY0xKFZI+F3Ixt7FAoPHyOZfJsUo8bbiS31l7594Q84P
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

"difference" is a noun, so "sufficient" is an adjective without "ly".

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 66b1cfbbfe221112286af4a14839ea039564113a..812f2c7aaa83777cf8c863e93d9597b951ac54d7 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -274,7 +274,7 @@ additionalProperties: true
 # specified.
 #
 # One option is to make the clock traces on the PCB longer than the
-# data traces. A sufficiently difference in length can provide the 2ns
+# data traces. A sufficient difference in length can provide the 2ns
 # delay. If both the RX and TX delays are implemented in this manner,
 # 'rgmii' should be used, so indicating the PCB adds the delays.
 #

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250923-dt-net-typo-9eef94e2f306

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



