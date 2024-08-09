Return-Path: <netdev+bounces-117095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92E94C9BA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC97E2872F8
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6261A16CD16;
	Fri,  9 Aug 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCDk50tX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70C16C6BD;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182155; cv=none; b=TqsG/EYJ3UYYiDmCj8x1WuXSeiDi0z0TpQe4jJZL2VMJFu1xK0b6tKJLp4W1CG+ryeqmgLG5C7Wg0hMXEBxpahBosCZyRtiRFgoNzwWLi8DVtu4V6d5tqrxYyUF+0VuAviRnJYg1WgnIf9hDGxeHW8ngfpglETd1+sxmz8DZQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182155; c=relaxed/simple;
	bh=ee0MfqKhJwu+BmHNrObmbBkQYcwyzrWWQyYQK6nZ/Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0WhAYNI7URyal9K2E88MeYzlFvj3MWGSnBE7pRDQl4VSwgPIxULBeqz/s0fIiC0JpQNsNMqsFft2RQMgCILbRGYNA9yoekwrLSqvKveCxINCSVQWdKsmbleYudvPAIrbCjclMxMEt0hiXpuSpzi0G3fb33hcZFTmk4GL1UpjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCDk50tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98FF7C4AF12;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723182154;
	bh=ee0MfqKhJwu+BmHNrObmbBkQYcwyzrWWQyYQK6nZ/Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CCDk50tX6fabL/r7p1cn8EgxZ18YusiRVthRNkLdJXSMgVttGe2eV3dVt2dJRZdhB
	 dcklvdf5F5K9UcpRcxISNODvGfitNn/UUG0L7+6BSz0tnFRTnLP1qIMFFJgNBDAecR
	 3Tr26yiAi94Hn+5qycLBHJYvwjKseAJgJN788aeT+3p1iH3NnWFz/iptLWwuwg3eFh
	 x5Ljabab7tmqo8NWig/rSk5C6Vgr3aRW0Fg20b6ggyT7lyl5rAJqMekVcydkv/qFlI
	 9mSM60LgMXucSCxBlkpgte7TYn1x6VBv5RkEcaDjJDYU+EEec/PhTgPWpf45BMtjVe
	 ygmFCQCIdKxkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8725CC52D7D;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 09 Aug 2024 13:42:26 +0800
Subject: [PATCH v4 3/3] MAINTAINERS: Add an entry for Amlogic HCI UART (M:
 Yang Li)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-btaml-v4-3-376b284405a7@amlogic.com>
References: <20240809-btaml-v4-0-376b284405a7@amlogic.com>
In-Reply-To: <20240809-btaml-v4-0-376b284405a7@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723182152; l=782;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=JCpkGkVAbaLnnsN6aT/w92n7ppHeCAU2X3+VbVGUtEo=;
 b=td7yfEL1A8qhkcP1PB5s2Zbov3UoJtOsbKhS+8ODjNsIY/c6zHBc7lOv8ZYj/BDP9OTIVNAgl
 Ga9IMtEvmgYB4oc3ONkA1RUjtDhmj6//z5a+jgNCe1rVfS0EoNAjXSb
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



