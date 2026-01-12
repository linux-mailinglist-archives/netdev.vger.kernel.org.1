Return-Path: <netdev+bounces-248945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391C4D11AFC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5773E304B4C9
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B15284898;
	Mon, 12 Jan 2026 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMFOq3Um"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF026056E;
	Mon, 12 Jan 2026 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212028; cv=none; b=aUmERWRy8azmIcLtF8pdUIMJe9ddUGgXP+nJvXUiUCi225lk3gtpFRgWbr60TGHDpcsBT3qHubvUZG4LmPK2deyP0Z5a9A7BCSh0FiS4XEiFptXJUEKeBZRENWBqtZWPMBG9Ze1MNQbXmbr+0quvqF0E1cvO3QlFJLyprESHGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212028; c=relaxed/simple;
	bh=nNjcBRPDxW9Qm7zjbNWDFXwpKcSEsn9avwvDkyGys8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XqyJswfCvOB5XbkHXwTIJuGSUtbsQKePB4yePgvjPIMG6IwON/TDZ7Rb555VfKVqWYh3pokCaHcEtsT+tdmEgcocaFwy7FK3lsKN+b3k8BfCPLaQ46hjF9SGQp3fgkB8UIejzkaJzcxlGyYPETFU0939TYS7jGVIrI+lycQvvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMFOq3Um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7248DC19421;
	Mon, 12 Jan 2026 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768212027;
	bh=nNjcBRPDxW9Qm7zjbNWDFXwpKcSEsn9avwvDkyGys8M=;
	h=From:Subject:Date:To:Cc:From;
	b=eMFOq3UmpspiU8rXlnsf6nEjVGD+VN/KTi2/totKywtwrfRT6A+y+yC8sp0PLWy1g
	 xKDE60+fh7cL61cbSBut9dML/oCIvjuy5l5MZ/sFx++WvXSAHUo3SnEFqHKZehzWqf
	 kMUAGyek0dp4fuddT7KEVzDHGZVQeTEJsEre1tsl9jkWNZi/APXRZF4PC0bjcqsjeT
	 1tH6K6qdDPylNcee0KJLwBXGWzqSrWyd4M26n/STXvpcxvmnYXPh3SBSqKChKottM+
	 66K4LnpFfVqeXqRwosq0fSA/84GgLi9xPOqWdFwVkDNDAE7p2ccr5B7XDWMwJzqzR9
	 H4ThjTf9ctJGA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] Add the capability to read firmware binary
 names from dts for Airoha NPU driver
Date: Mon, 12 Jan 2026 11:00:06 +0100
Message-Id: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqFMAxA0a1Ixi+Q1h+4FXmDoKlmYJUUPyDu3
 eLwDO69IYmpJOiKG0wOTbrGDPcrYJg5ToI6ZoMn35CjFlltnRnjtmNQW042wciLYFlJTeTZcRk
 g55tJ0Otb9//neQHIquMeagAAAA==
X-Change-ID: 20260107-airoha-npu-firmware-name-34e5002a1a3f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This is a preliminary patch to enable NPU offloading for MT7996 (Eagle)
chipset since it requires a different binary with respect to the one
used for MT7992 on the EN7581 SoC.

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: npu: Add firmware-name property
      net: airoha: npu: Add the capability to read firmware names from dts

 .../devicetree/bindings/net/airoha,en7581-npu.yaml |  7 ++++
 drivers/net/ethernet/airoha/airoha_npu.c           | 42 ++++++++++++++++++----
 2 files changed, 43 insertions(+), 6 deletions(-)
---
base-commit: bc87b14594e30720a5c1546c24e0f5f08d34eb40
change-id: 20260107-airoha-npu-firmware-name-34e5002a1a3f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


