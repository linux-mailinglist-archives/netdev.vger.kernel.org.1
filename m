Return-Path: <netdev+bounces-109443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452469287BF
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7E2B21B13
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAB149DEF;
	Fri,  5 Jul 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srVlr460"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EF148844;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178459; cv=none; b=OmN3tt6PYE6KLHs+zKX/boLqQMEbpVod8T4w3oJxvYFAuh9xNqk347ynz6gKNtHEq8evhYIydNiyZjsH0OF00BqgJmCyTsNetB3Xzv/T8x+MQJWJCTZZp6FG8wDIEmMcfGdGYAvVU96UODnuR3aQN94AlfFMsZ17hgGUB1vexQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178459; c=relaxed/simple;
	bh=QX8mcpsZhZwgry0dptC2c1iiJs/twuajIuaTPFU0k7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afh3ihlPpOiDqB6mSBwNjDK6hUL/7Z1MhBrkC7ErAAbxm9UiV0PD7XXWzbfJNtMtV5J1yJZsQSw8g1yazs9ClNAt4fW2iw/O4bsmCwKH/vL0C6GbolvRFdJii0X4iWh3PG3aSPMbdamG9RWaaBsSi+5K0Nk4i9Vj1dPWg6t0pD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srVlr460; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A57C4AF15;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178458;
	bh=QX8mcpsZhZwgry0dptC2c1iiJs/twuajIuaTPFU0k7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=srVlr460YJtwg9UZ3Sf46NVk1W3UGk1hYSnEEpHANp/j7kx1vee6xa1sbqAYqIJvM
	 MzzrvIdI61uMJZdQUwTwPy7dn+CTkvrysTTALgEpNrV17u7UMdNx5s6wZC1p09mfRH
	 3udGpVKPSdbf45hbcjC3mVe9+BzDFYTaz4SeljJeoY9emQeaORa4bIqManhJGZOStK
	 78kiLm4X0Ls7pjL2SViklpvjO4+TycURv6ta5WyVZ/XQWPIvVfbDikJflTnauy3Jwx
	 hFlxDJyTPit9mx502C7xz0VYauvOgW0wOOpO9j95hURsTJ03zr4/pifMJbjMehtK1P
	 spau1QwhZf/pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4FAC3814E;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 05 Jul 2024 19:20:46 +0800
Subject: [PATCH 3/4] arm64: defconfig: Enable hci_uart for Amlogic
 Bluetooth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-btaml-v1-3-7f1538f98cef@amlogic.com>
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
In-Reply-To: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178456; l=589;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=gUtmHVeZTKC9IsfZRX6YKmxxFnXVwUrODq8x21j2HNc=;
 b=ZTHCBJLeGcUBzvp+O9iojkqGknWSEpcghggMhH2YF6OXCj4JHqRHv5lo4cq9mhjUgSKVZ87+u
 3PLPKut2aVvC7NvTKzLnumqV1EmM5m20rJHjawpd8R3nurgt0odwj4U
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Enable the HCI protocol of Amlogitc Bluetooth.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 57a9abe78ee4..11c4b5c532ca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -192,6 +192,7 @@ CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_BCM=y
 CONFIG_BT_HCIUART_QCA=y
 CONFIG_BT_HCIUART_MRVL=y
+CONFIG_BT_HCIUART_AML=y
 CONFIG_BT_MRVL=m
 CONFIG_BT_MRVL_SDIO=m
 CONFIG_BT_QCOMSMD=m

-- 
2.42.0



