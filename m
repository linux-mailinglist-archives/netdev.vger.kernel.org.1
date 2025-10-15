Return-Path: <netdev+bounces-229485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD5BDCDB1
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C215E3AAA4B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C03126CD;
	Wed, 15 Oct 2025 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dICxFa+G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06D2153E7;
	Wed, 15 Oct 2025 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512531; cv=none; b=XAHSza5eH0aQpt2Zsf9uPoiSg2bbQJ58ajLmP4ChavEh7htYiyJIfH0m0rq7/PUvfMDNFhERE52ieqQjXWTWbhfcuZ8vFbIpWt3VLZLANYiOdeh6ffn6BQaoOMw4ipk83Zg5DKh8sSyKSCnpb6dyOcmpEVlzxWGrN9scYZaK5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512531; c=relaxed/simple;
	bh=V/D5+RxaBaTzRsVlk1fFmdDyl83zpQXVdvRBYnoOhmM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kJIGuBaq8hMpC1fPR56S5VGVI2YgDZZ0dWnI1wC1T+8BWNo2gVG6UFUBVss6+OgnvCq5fWTESD0gLfIetXta51MXZLbyNOFEtGnaOX5uYnIu9qIN8h6aEuNGGGJwTRvTTaMRyIhX2DPDq6oKM9QybHsJxPp+cNcxzG1a9ru43J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dICxFa+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6913DC4CEF8;
	Wed, 15 Oct 2025 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512529;
	bh=V/D5+RxaBaTzRsVlk1fFmdDyl83zpQXVdvRBYnoOhmM=;
	h=From:Subject:Date:To:Cc:From;
	b=dICxFa+GPIJOZ3a70/jcdGo7dRL8wG48FRX7kXjLFdvYKIlwtnqvYflb7M6uJqZu3
	 88qyPfBwtLxn1Bjy6++unULjt33dtylgm+wjqQGL0M+tM31HFHvdRCTod7I+1ZgtiY
	 qXOLweshOvMUtR2FBWTHTCTVkrPU2B7NFWOedH+M60ED8t90ZeLbdHoWiEIzFu9A1A
	 t+JCOC1U5J3FBhTVwR/G666ME7cApkLrvMlBKUo2J7Jxi0XlLplUqp60KZyz3KmpZ2
	 Ah6Nn8q8oC59jahC7zO1eGrinp8AiCa1sLVWB01P8RuAe0umGfPvIPgkrXtrF1F7CR
	 Uaa6dR4QcqGtg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 00/12] net: airoha: Add AN7583 ethernet controller
 support
Date: Wed, 15 Oct 2025 09:15:00 +0200
Message-Id: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVJ72gC/x3MTQqAIBBA4avIrBtQs9+rRAupqWZjohZBePek5
 bd474VIgSnCKF4IdHPk0xWoSsByWLcT8loMWupGSWnQuq7pa6R0YLy8P0NCZfWm19YMdS+hhD7
 Qxs8/neacP1uDB71kAAAA
X-Change-ID: 20251004-an7583-eth-support-1a2f2d649380
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.14.2

Introduce support for AN7583 ethernet controller to airoha-eth dirver.
The main differences between EN7581 and AN7583 is the latter runs a
single PPE module while EN7581 runs two of them. Moreover PPE SRAM in
AN7583 SoC is reduced to 8K (while SRAM is 16K on EN7581).

---
Lorenzo Bianconi (12):
      dt-bindings: net: airoha: Add AN7583 support
      net: airoha: ppe: Dynamically allocate foe_check_time array in airoha_ppe struct
      net: airoha: Add airoha_ppe_get_num_stats_entries() and airoha_ppe_get_num_total_stats_entries()
      net: airoha: Add airoha_eth_soc_data struct
      net: airoha: Generalize airoha_ppe2_is_enabled routine
      net: airoha: ppe: Move PPE memory info in airoha_eth_soc_data struct
      net: airoha: ppe: Remove airoha_ppe_is_enabled() where not necessary
      net: airoha: ppe: Configure SRAM PPE entries via the cpu
      net: airoha: ppe: Flush PPE SRAM table during PPE setup
      net: airoha: Select default ppe cpu port in airoha_dev_init()
      net: airoha: Refactor src port configuration in airhoha_set_gdm2_loopback
      net: airoha: Add AN7583 SoC support

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  60 ++++-
 drivers/net/ethernet/airoha/airoha_eth.c           | 247 ++++++++++++++------
 drivers/net/ethernet/airoha/airoha_eth.h           |  58 +++--
 drivers/net/ethernet/airoha/airoha_ppe.c           | 256 ++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |   3 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |   5 +-
 6 files changed, 443 insertions(+), 186 deletions(-)
---
base-commit: 6033d2a2468e07ec90bb153ea7c6c3bc2170c1e0
change-id: 20251004-an7583-eth-support-1a2f2d649380

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


