Return-Path: <netdev+bounces-144603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FCF9C7E8A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA23B2336D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A83A18C344;
	Wed, 13 Nov 2024 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeTkZjgD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1C17FAC2;
	Wed, 13 Nov 2024 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538732; cv=none; b=dFAcCnqupRQMqAZ275Q41kwBhJhQDLFnTFFM0mPhn1WRAuqUhhO6Uh7xHd5i63NarBXyvpYMxrFjLtMpSaaQkpynGj6OqLx5mWYSe7PQxsUBY/dO7JUJMdO1T7M56dDWu5zCo4K+2oEU3OWQnBjKtlMN0NA91iHnltRzca2+oZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538732; c=relaxed/simple;
	bh=Ke/IE1DB3qjY9v7LrQKHXHZu3tcj+cRu/ANYQ0SpihU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWFXLI3eDClo3TtiAqHZV9+Vj+Hkh7lJQPIkNihGS3/wVqoNanPjUTtkmK8RSN0dt1R0JbSyK1798nwWbrRjwChgeOD4BBGee4jKgvNZM8nfDP3rrOGrAigFaU0eype4m/83BZUqa9R07ULyAioJi1U9j5bEO7FhLPMrDRufXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeTkZjgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B766CC4CEC3;
	Wed, 13 Nov 2024 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731538732;
	bh=Ke/IE1DB3qjY9v7LrQKHXHZu3tcj+cRu/ANYQ0SpihU=;
	h=From:To:Cc:Subject:Date:From;
	b=VeTkZjgDYMNrTM1rq86AxU6dTtg9NCv/2bG5ncXnRiUpOW4rgKXXY826dBk/h52lL
	 +Dhb8MClc33PvOAcMn/pbkvA0W7JbfsD2fGmHrkxPtEda8r/D0qvEQOzXxLkmGJDuW
	 lRASTLWaUdu9qxWp6wmvOa4SROwpSvYtTWGr5vnFWXu5i4Kq7GvxvPsDlae6ItlgWS
	 1sfvyM9yTjoe9PRBGtSKVS6m74EzaPm/Hp6rJ6vElosxOuJUU8cPY95CNDIsoIMolc
	 uBYj1hzN7mCY3rvoCH91NDgRLntLNbiBUj/aSsWIulazE9gyWYOTbV3/ZDb1Sm4bwx
	 nnd2pA9CKCRFA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: sff,sfp: Fix "interrupts" property typo
Date: Wed, 13 Nov 2024 16:58:25 -0600
Message-ID: <20241113225825.1785588-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example has "interrupt" property which is not a defined property. It
should be "interrupts" instead. "interrupts" also should not contain a
phandle.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/sff,sfp.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/sff,sfp.yaml b/Documentation/devicetree/bindings/net/sff,sfp.yaml
index 90611b598d2b..15616ad737f5 100644
--- a/Documentation/devicetree/bindings/net/sff,sfp.yaml
+++ b/Documentation/devicetree/bindings/net/sff,sfp.yaml
@@ -132,7 +132,7 @@ examples:
         pinctrl-names = "default";
         pinctrl-0 = <&cpm_phy0_pins &cps_phy0_pins>;
         reg = <0>;
-        interrupt = <&cpm_gpio2 18 IRQ_TYPE_EDGE_FALLING>;
+        interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
         sfp = <&sfp2>;
       };
     };
-- 
2.45.2


