Return-Path: <netdev+bounces-14647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A3742CE1
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA88280E89
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457A14A83;
	Thu, 29 Jun 2023 19:02:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4413AD4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F36AC43397;
	Thu, 29 Jun 2023 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065320;
	bh=ZBPDjQTOm9nfTKy8pCEe02sdJ5H5tTrv77pYuNH3HnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/3EAn8LKsDfljV4aww9xtBNRUQH98pa7uazxPXJzxZA8evXwGchJkbGnnhoD6HBi
	 IZrLAfQea/ksuYD/dcEFoiKlu76sLST6YQ+3OK0qSUP1G+onc8DxAeNnP8JPkVFZnz
	 7cxOkBHFC/0tmBn+P28diMrKFxGbLqDcjan4pvVxbKxGI8UU2+19R40nYAhytvO6fY
	 M5gtyTG9tCui6SD+qpDTBEYawVSD4hRCkkMqeOdiwpFHy0W950JNpIN19B1Zbw4jEP
	 dqqi7Vgdv1VdeYMfqzkGyV0XWyHsbTP1KCKvyLz1foIh7am2LDK2dyhiCGmaCA5PWy
	 YuYon/2//1rHw==
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
Subject: [PATCH AUTOSEL 5.15 2/5] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date: Thu, 29 Jun 2023 15:01:53 -0400
Message-Id: <20230629190158.908169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190158.908169-1-sashal@kernel.org>
References: <20230629190158.908169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.118
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


