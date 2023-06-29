Return-Path: <netdev+bounces-14638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EAC742C8F
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3E71C20935
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26414280;
	Thu, 29 Jun 2023 19:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5214269
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E17CC433C9;
	Thu, 29 Jun 2023 19:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065274;
	bh=Cl2JZtp7JTFAtrbbJEFEFkb7VgCs98txtHTIsGFO6tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ck16IiUrc3SZeA8pVRKnMuzRX6TxFyoJpEtefR19QmzbbuixazEKtkmt+HWwJicvm
	 04DcfiEopG2b8X3ZpIbqbQF0BTtw83BCF42AM61ToCM0X1lOUbgX0hqzD0VsIL1CfT
	 2ELP1mlwabI30lbo2QXGTxRcqFRqQSWMQxLcfyrR7xdBDz82K3/WZhBRovaotzuh3A
	 bLQvXJFYZnCyCJkD6y59zgC8SXVT5ti+z5q2jIxZYTdpVQ0hRUqKYGGjHVqTeDQQT4
	 Xst/CDCVVFoBFvFIGbb3ozbe4REjXwWSGmhpCKDhCPhRP8eChZ8A6RAvYdcmVGVT+f
	 8o6UI46Pi6ILg==
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
Subject: [PATCH AUTOSEL 6.3 08/17] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date: Thu, 29 Jun 2023 15:00:37 -0400
Message-Id: <20230629190049.907558-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
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
index 5cf218c674a5a..c246370cd48c6 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1349,3 +1349,5 @@ module_spi_driver(adf7242_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FIRMWARE);
-- 
2.39.2


