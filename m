Return-Path: <netdev+bounces-109441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1C9287BA
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182A2287191
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A5149C50;
	Fri,  5 Jul 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVYpLAHH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C491487C1;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178458; cv=none; b=RYV5h220rACyWvUp/dAaWantr5zKcNBOh5toSMDAkcftS8cfNmAgaNtgHZGFGlymQUQv9xcF2InfgOzQgD8zaI4U5K9dtFVdLfJbm16R88CeUD/12CR+Vuqbh2eQoVkWWe4VY2rOo1ekxJg+JIddK3cWYzECCOmb97JojpLfdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178458; c=relaxed/simple;
	bh=ljo98Oix0zF4HtbxIYPVKXMO3zcHlaqIjHBPe9TuLUw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lRmyi19aU/Ev7NwViUTUeCG8z4dDGB7Og2CgLHCYNLrJO4NTrshAwdanmtLKiDCqT4Bqs7dDteBD3cGIUDKS1Rq58IkW1qBiw6nnPo2SIanj+865VQ+RitIT/swivz4SsE1f8zIAHoG0ABtHL7WWPvekWnD6U6shJjkp8mR6vmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVYpLAHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58966C116B1;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178458;
	bh=ljo98Oix0zF4HtbxIYPVKXMO3zcHlaqIjHBPe9TuLUw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oVYpLAHHYqf0rqaqYNaFBSs6mQSIKoR3X5yxs3asrVMZVZSL3DPMcul02DjOnlN0Z
	 0XaDkVJoeCxLYsdZLisAO4PYAepSe/z8Kp25Q43VLO0E/bVUH2ngMq7R4AGnFHCmtP
	 IzLNFSpHrbN//lAUkOIj3LI2a2CHfrK+2EFWYLpXxkr9PpBpfAr8nG++391Y4Llg/X
	 4wde89IBMN0/k9U+uvD+lqFm9Z0uBRuSQ8iLMHhlGkoaSVPxCxLvmJrfmpi2f4RZGN
	 zHSeG2az9DT5XE5xFcYnZBixCgBG1pLoY3CG42UduEnUX6Wmi4PhZqzh7xckWxtQwj
	 9RK1vainZ7xWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE30C30658;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Subject: [PATCH 0/4] Add support for Amlogic HCI UART
Date: Fri, 05 Jul 2024 19:20:43 +0800
Message-Id: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvXh2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ML3aSSxNwc3TTLFPMkQ0tzI5PEJCWg2oKi1LTMCrA50bG1tQA2fFp
 IVwAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Yang Li <yang.li@amlogic.com>, 
 Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178456; l=1154;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=ljo98Oix0zF4HtbxIYPVKXMO3zcHlaqIjHBPe9TuLUw=;
 b=wVCKzjwrsOMYUCq8ga1twDNQUMMYDrVatd/xEz7R4znyMbF++ttuGYNqnZ85XWj298yrSuLEY
 2yR0llMi5+HDAp7a2s9Z6wUWVBWLVuhsLRU1IfBDsEWuXwBUgzVnG+c
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

Add support for Amlogic HCI UART, including dt-binding, Amlogic Bluetooth driver
and enable HCIUART_AML in defconfig.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Yang Li (4):
      dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
      Bluetooth: hci_uart: Add support for Amlogic HCI UART
      arm64: defconfig: Enable hci_uart for Amlogic Bluetooth
      MAINTAINERS: Add an entry for Amlogic HCI UART

 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  |  62 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/bluetooth/Kconfig                          |  13 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/hci_aml.c                        | 749 +++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c                      |   8 +-
 drivers/bluetooth/hci_uart.h                       |   8 +-
 8 files changed, 847 insertions(+), 3 deletions(-)
---
base-commit: e3203b17771757fdcd259d6378673f1590e36694
change-id: 20240418-btaml-f9d7b19724ab

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



