Return-Path: <netdev+bounces-14650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B603742CEA
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F591C20B71
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52514A8E;
	Thu, 29 Jun 2023 19:02:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986416405
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9DEC433C0;
	Thu, 29 Jun 2023 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065328;
	bh=ZBPDjQTOm9nfTKy8pCEe02sdJ5H5tTrv77pYuNH3HnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=peqewKITAUOETW8PP5dmprk4OAB/q/YM/RbZE+oSjw3ks15fKe+1cNF9CI+OOT5z3
	 e2nMcp4PGN59CcqGkG6qX/riosbVdUTGP5paFoGJ/8QRD5fUDOABL2vSOs3hZJIpXJ
	 rljmmGB9mxrLuZyROHGThK4bGYejNcUvW3lwPPJi8+1yRIh4hLpK9AYNg6UfB0wibs
	 nyc3MtAJZ5lnQrHqaxytN67bYFp+NivAdn/HduXlJj7r9r1rQ9IfbQ5WSyYNtq2JYq
	 LQeCVyWPbk9VellvKh/yAzlgK34oogyL8Yl+soo8KHgx5YWcThWVnJY3nVlmwc60z4
	 EpySJLjO/GVjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juerg Haefliger <juerg.haefliger@canonical.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	michael.hennerich@analog.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/4] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date: Thu, 29 Jun 2023 15:02:02 -0400
Message-Id: <20230629190206.908243-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190206.908243-1-sashal@kernel.org>
References: <20230629190206.908243-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.185
Content-Transfer-Encoding: 8bit

From: Juerg Haefliger <juerg.haefliger@canonical.com>

[ Upstream commit f593a94b530aee4c7f2511c9e48eb495dff03991 ]

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 07adbeec19787..7140573eca72b 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1351,3 +1351,5 @@ module_spi_driver(adf7242_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FIRMWARE);
-- 
2.39.2


