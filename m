Return-Path: <netdev+bounces-203044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CEDAF067F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA53044517A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 22:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7926B0A7;
	Tue,  1 Jul 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKeMYy4c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2177125D6
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408638; cv=none; b=hNYcopqpqPndwy4qUeRAwYpMaHM5jXFlB8GGPqoBDNNO9KwFbrSLOosHVtbZPOJBGXXw9M6kxCe8gOixqod04w66XG7zMfuXUyr8bnqbMZZJ7WDoKBfXyeN9UVQebOuOPSQKOC8TqGSJNPW9oKxVkAWT537rjruFhjYpRn6hyNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408638; c=relaxed/simple;
	bh=fUUoen+cTVxtXBN5cqDdx8Ds/uaclV/a5glV6L5lN/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C3I0NmeGFaINY2yQ5VD4KQlqwB9wgr1B6tEmyyaTU8tXgVlZ6T/ktPYEaeaEo4h7Ov/DbYtCt9lgt+ivzdG9svFle8XeeR95g6PK2EMiGszJJ+ETVDhW8W2C47Wnm4ySf/+EEHvD9/PeJHL+pchmVgeCFIrVYFJp+GmcICPBM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKeMYy4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEECC4CEEB;
	Tue,  1 Jul 2025 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408638;
	bh=fUUoen+cTVxtXBN5cqDdx8Ds/uaclV/a5glV6L5lN/o=;
	h=From:Subject:Date:To:Cc:From;
	b=bKeMYy4cn3iimktlqCIQ5UVhd9P7Bup5rCva9LfgW05HT5xsq8Mna7z8DHYXfllKp
	 5tlJ503FLqIl+gHdGOKuOKj2rC8XFfJziMtZQEbeWO1/aF+UTz06w2I4XmqQBZBogj
	 /VY5hr3hSRG1TYVMrqKn90/Xcpm2rZ/vEK0n+BcjmkmDDiuD8+EIwcRrgbgTQkL9Qu
	 9nJaZs6XLf1fGerrhWLzJquUp14Vt6/6geNj9AsQYXEQ/78Fq1l6+TXEnRXZWqFG+q
	 Kp03LTFKJu24GP+zw4B7xCbUOqjRJQHHVZRU1lZ8/fl6ROujvfs1Dsj4LHjGHK49wj
	 7GLrT1weNGQgw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/6] net: airoha: Introduce NPU callbacks for wlan
 offloading
Date: Wed, 02 Jul 2025 00:23:29 +0200
Message-Id: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOFfZGgC/x3MSwrDIBAA0KvIrDOg+VSbq5QuhjjTDAQtCmkh5
 O6RLN/mHVC5KFeYzQGFd62aU4PrDCwrpQ+jxmbobT9Zbx2SlrwScvJTcPjbKGEW2ShHfPjlGUk
 kjH6AFnwLi/7v/PU+zwsTwmblbAAAAA==
X-Change-ID: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Similar to wired traffic, EN7581 SoC allows to offload traffic to/from
the MT76 wireless NIC configuring the NPU module via the Netfilter
flowtable. This series introduces the necessary NPU callback used by
the MT76 driver in order to enable the offloading.
Subsequent patches will introduce the required MT76 support.

---
Lorenzo Bianconi (6):
      net: airoha: npu: Add NPU wlan memory initialization commands
      net: airoha: npu: Add more wlan NPU callbacks
      net: airoha: npu: Add wlan irq management callbacks
      net: airoha: npu: Read NPU interrupt lines from the DTS
      net: airoha: npu: Enable core 3 for WiFi offloading
      net: airoha: Add airoha_offload.h header

 drivers/net/ethernet/airoha/airoha_npu.c  | 326 +++++++++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_npu.h  |  36 ----
 drivers/net/ethernet/airoha/airoha_ppe.c  |   2 +-
 include/linux/soc/airoha/airoha_offload.h | 295 +++++++++++++++++++++++++++
 4 files changed, 619 insertions(+), 40 deletions(-)
---
base-commit: 21deb2d966920f0d4dd098ca6c3a55efbc0b2f23
change-id: 20250701-airoha-en7581-wlan-offlaod-67c9daff8473

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


