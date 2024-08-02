Return-Path: <netdev+bounces-115275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0A945B3D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10121F2504B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B861DC49D;
	Fri,  2 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFpc5S8Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C201DC478;
	Fri,  2 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591625; cv=none; b=EsJNze0GO9b0/Uy0JWAmZHfhLMye+0dwhucOuRyL1J0WoYQ8kmn/P6vMAdIRtKHiLwH+NaF35syzZWMBeOxqCYl4gL45/CeKueePHykNT8GkgpBwnSB6j8+PSaXxfatF3y017RVdMMX5xymEQwDbunHh8S0yhbx2E69cM1vJ25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591625; c=relaxed/simple;
	bh=ee0MfqKhJwu+BmHNrObmbBkQYcwyzrWWQyYQK6nZ/Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVRrAAPzUCdRp9/zz2QtyyFvUvks6WLKHewIklqIHmtM+J/hWrveaQHG8Dv/xKkJ68S4x9cRO2wh7D37Ug/Ktof2q1uUD0JW/BUGYc5Ix654z4dp+/OdIyykZoXa+KfG6r6HDA6Qwk4qGQYpeVm4hFESfqmUmW2SRSBFFlXGV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFpc5S8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C92BC4AF0B;
	Fri,  2 Aug 2024 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722591625;
	bh=ee0MfqKhJwu+BmHNrObmbBkQYcwyzrWWQyYQK6nZ/Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VFpc5S8Zl7mSoxZ9CjlfuVpqKYVgPCCofts7W9hhy12z3DnvkHP+XLTtjw7LA0LDN
	 N4EfGqwmwinD6C8hUS5ZKHfCs+o2QHAclummHDtgQyi4vfshq11173O0qgWHQUNurd
	 lqQpwYbVoO/65EiNzguntAh9TvVbmoG65go+VhLPRhQ4FhBzqWLd0UtUOlFFw/niRs
	 PM0LccA8Jp6CwaACu0lt8XxEbA1CfEZDAJkYW6jM+ePh7OhAhEtO7OpzK3AWW83ngm
	 j/s+6n4qFgaj2LYYb0BZjRPCD2pZvSVeMFNrGAzx1XKWKjMlM2IyNzdU6nFogjHjMs
	 ovfonZANPxCNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A99C52D6D;
	Fri,  2 Aug 2024 09:40:25 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 02 Aug 2024 17:39:49 +0800
Subject: [PATCH v3 3/3] MAINTAINERS: Add an entry for Amlogic HCI UART (M:
 Yang Li)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-btaml-v3-3-d8110bf9963f@amlogic.com>
References: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
In-Reply-To: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722591623; l=782;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=JCpkGkVAbaLnnsN6aT/w92n7ppHeCAU2X3+VbVGUtEo=;
 b=ipIHuZhIM6ngp93qMdEN/VfjA2HdBObHH6HUqRhwg4SUWFYllaWDjnOeLn9MTAx/H80ZxbFBj
 Rz0/egPUCntAjI0rPNIdMIP91Xxt3dEevf97kNawoX1aj3XI4kBdu35
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add Amlogic Bluetooth entry to MAINTAINERS to clarify the maintainers

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b73a6e2d78c..b106217933b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1149,6 +1149,13 @@ S:	Supported
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 F:	drivers/net/ethernet/amd/xgbe/
 
+AMLOGIC BLUETOOTH DRIVER
+M:	Yang Li <yang.li@amlogic.com>
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
+F:	drivers/bluetooth/hci_aml.c
+
 AMLOGIC DDR PMU DRIVER
 M:	Jiucheng Xu <jiucheng.xu@amlogic.com>
 L:	linux-amlogic@lists.infradead.org

-- 
2.42.0



