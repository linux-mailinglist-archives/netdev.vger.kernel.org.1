Return-Path: <netdev+bounces-124235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A19968A67
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E026C283613
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE43DAC19;
	Mon,  2 Sep 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D7hap9ea"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3443DAC0F;
	Mon,  2 Sep 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288909; cv=none; b=Z52ym3sQ/nYQaH5UQgISX4ZgzJ3yF2eryEQMwdaIxGL+RZH6+RXtvKMBUZVpcuG7+ifwm/v2RkgFwZTBjg+Y3CqT83ZWgMwxSVvp0NqQzUu58PiAKQIzmDcWCEU20b3lDukyDBVbvA+j2u8Yy38Ca/purBPNH7ChdCVLqLbsYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288909; c=relaxed/simple;
	bh=Ay7cz/cAx5VzT0SFGJs2YTe8CXFBSqYgGWY1vbNoneo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=i5aYdXkdBpSrI11n2WTnMgtUGOgWQZ/r6KCRLOxun3bEKLQnewSv1tBmk7bI+Ls8ca8ZYnBIKdHJR46zWLtlrQwvzAXvoe8ctLSnval1NM77inMgBEALz6N9p8dUF7wYyLeg/UtjxBfUqbue0rqCnWCmAxEANrkHPjeiRyyRzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D7hap9ea; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288907; x=1756824907;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Ay7cz/cAx5VzT0SFGJs2YTe8CXFBSqYgGWY1vbNoneo=;
  b=D7hap9eaggDeCh4bdZz+Pmfuj65w0JmeY/6HRRqzh6l1tR8ZuKwNHXNL
   hV3LLmVc1M8wGZYQxv8Obfgpmzd2kejr9mzgxje6HFMBlypgq2LsnBsx7
   cM1sEmqAZJgfIllVuqOXhMtKQ4UgozNOxXu37AXI6tYLa/ggNq0TR1mNv
   riAhavv8cWppUjGgXThhPIZkP30i1YXsa+qWTZ1Jy/KAoqQW7mzx1QPSs
   qhEoDa/zrUIoOJZoOxrXpFa6PhZXQyMTgHeBC/+/4GfnpQ7c15S1sMyNy
   TNjT504nu1ffkgn32xtWxseS3sXUJ4Ny5u6I5RQ0j3oHRXh+m6HQ43gYW
   Q==;
X-CSE-ConnectionGUID: /Vcaqev1TP+OZLTGnI90pA==
X-CSE-MsgGUID: dDyp8V77RRGGGtCZGqytLw==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34271102"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:55:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:36 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:34 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 00/12] net: microchip: add FDMA library and use it
 for Sparx5
Date: Mon, 2 Sep 2024 16:54:05 +0200
Message-ID: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3R1WYC/x2MSQrDMAwAvxJ0rsB1E7p8pfSg2HKjQ9QghWAI+
 XvdHodhZgdnE3Z4dDsYb+Ly0QbnUwdpIn0zSm4MMcQ+3EPEkmdCX8jqgANdU7j1IcdLgVYsxkX
 q//YE5RWV6wqvZkZyxtFI0/S7zSQKx/EFMUTuL34AAAA=
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<rdunlap@infradead.org>, <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.14-dev

This patch series is the first of a 2-part series, that adds a new
common FDMA library for Microchip switch chips Sparx5 and lan966x. These
chips share the same FDMA engine, and as such will benefit from a
common library with a common implementation.  This also has the benefit
of removing a lot open-coded bookkeeping and duplicate code for the two
drivers.

Additionally, upstreaming efforts for a third chip, lan969x, will begin
in the near future. This chip will use the new library too.

In this first series, the FDMA library is introduced and used by the
Sparx5 switch driver.

 ###################
 # Example of use: #
 ###################

- Initialize the rx and tx fdma structs with values for: number of
  DCB's, number of DB's, channel ID, DB size (data buffer size), and
  total size of the requested memory. Also provide two callbacks:
  nextptr_cb() and dataptr_cb() for getting the nextptr and dataptr.

- Allocate memory using fdma_alloc_phys() or fdma_alloc_coherent().

- Initialize the DCB's with fdma_dcb_init().

- Add new DCB's with fdma_dcb_add().

- Free memory with fdma_free_phys() or fdma_free_coherent().

 #####################
 # Patch  breakdown: #
 #####################

Patch #1:  introduces library and selects it for Sparx5.

Patch #2:  includes the fdma_api.h header and removes old symbols.

Patch #3:  replaces old rx and tx variables with equivalent ones from the
           fdma struct. Only the variables that can be changed without
           breaking traffic is changed in this patch.

Patch #4:  uses the library for allocation of rx buffers. This requires
           quite a bit of refactoring in this single patch.

Patch #5:  uses the library for adding DCB's in the rx path.

Patch #6:  uses the library for freeing rx buffers.

Patch #7:  uses the library helpers in the rx path.

Patch #8:  uses the library for allocation of tx buffers. This requires
           quite a bit of refactoring in this single patch.

Patch #9:  uses the library for adding DCB's in the tx path.

Patch #10: uses the library helpers in the tx path.

Patch #11: ditches the existing linked list for storing buffer addresses,
           and instead uses offsets into contiguous memory.

Patch #12: modifies existing rx and tx functions to be direction
           independent.

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Lars Povlsen <lars.povlsen@microchip.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
To: UNGLinuxDriver@microchip.com
To: rdunlap@infradead.org
To: horms@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (12):
      net: microchip: add FDMA library
      net: sparx5: use FDMA library symbols
      net: sparx5: replace a few variables with new equivalent ones
      net: sparx5: use the FDMA library for allocation of rx buffers
      net: sparx5: use FDMA library for adding DCB's in the rx path
      net: sparx5: use library helper for freeing rx buffers
      net: sparx5: use a few FDMA helpers in the rx path
      net: sparx5: use the FDMA library for allocation of tx buffers
      net: sparx5: use FDMA library for adding DCB's in the tx path
      net: sparx5: use library helper for freeing tx buffers
      net: sparx5: use contiguous memory for tx buffers
      net: sparx5: ditch sparx5_fdma_rx/tx_reload() functions

 drivers/net/ethernet/microchip/Kconfig             |   1 +
 drivers/net/ethernet/microchip/Makefile            |   1 +
 drivers/net/ethernet/microchip/fdma/Kconfig        |  18 +
 drivers/net/ethernet/microchip/fdma/Makefile       |   7 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c     | 146 ++++++++
 drivers/net/ethernet/microchip/fdma/fdma_api.h     | 243 +++++++++++++
 drivers/net/ethernet/microchip/sparx5/Kconfig      |   1 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 382 +++++++--------------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  31 +-
 10 files changed, 545 insertions(+), 286 deletions(-)
---
base-commit: 221f9cce949ac8042f65b71ed1fde13b99073256
change-id: 20240902-fdma-sparx5-5a7c0840d23f

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


