Return-Path: <netdev+bounces-47326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB47E9AA7
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709E7B20A4D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B11C6B6;
	Mon, 13 Nov 2023 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIHfP10c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706718625
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 11:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B44C433C8;
	Mon, 13 Nov 2023 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699873636;
	bh=LOxeX+UITP7Q9EMFXfOWnEfl7vySqq501b5Bmi7TWxs=;
	h=From:To:Cc:Subject:Date:From;
	b=OIHfP10cxjLlEAG/lFBprQv9qyUl5hAePRX09MAq3bXb6LdqmMGTDT2Fd43rNRbN4
	 bWRdSYjYK+8dgR6cJ/gMNhmgtsGxxRgNZ9qPriYha58VwzIgFl7h3TPL8xd26UM7LC
	 sflf6WDkcxuPQmqjM4nWZNNxCPKAJfKHl7wDJNoKXIlbGkkYUAh0UDsOU+E1TvO0TQ
	 1bm/HiAW6kIKdyAmoPBe2ViNu8iyczM6frz0NtSuQ30dkrQSkfTb4rbgOs4RV/GhlW
	 ndAUCuqy/rQRlISWmbeDrbnAnwJkaKl64Oh/d+XpmE2YxcoiYIh3weeFX4D1QFFEmE
	 bW0UCtbPrngDA==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	srk@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next 0/3] net: ethernet: am65-cpsw: Add ethtool standard MAC stats
Date: Mon, 13 Nov 2023 13:07:05 +0200
Message-Id: <20231113110708.137379-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Gets 'ethtool -S eth0 --groups eth-mac' command to work.

Also set default TX channels to maximum available.

cheers,
-roger

Roger Quadros (3):
  net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool
  net: ethernet: am65-cpsw: Set default TX channels to maximum
  net: ethernet: am65-cpsw: Error out if Enable TX/RX channel fails

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 26 +++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 37 ++++++++++++++++-----
 2 files changed, 55 insertions(+), 8 deletions(-)


base-commit: 89cdf9d556016a54ff6ddd62324aa5ec790c05cc
-- 
2.34.1


