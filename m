Return-Path: <netdev+bounces-44856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C2C7DA238
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02021C2113C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA513F4D6;
	Fri, 27 Oct 2023 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZSNFl3g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4A3F4AD
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 21:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC05BC433CC;
	Fri, 27 Oct 2023 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698441196;
	bh=E4WshqjKmCDM+zwYoiy4C02V/FviukwokIHFSjNLmIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZSNFl3gWbkFW5SX74NvCoG1P1oF0S7kwDo/BI71rcm7xjjqO+sg9OX+I4HS55H8I
	 7Kor3nIQYc/JQHVe22qJ995xlTahEjcPDp9YibKZPf+HjaAESR4Bva/82ZGQ8zn5V0
	 6WiAgwT6l37X7/JcSREXf8Qh4oTZIeuHlqd+1BUCsw6BtnhS8BULQp3LyQNK5kKTOS
	 vb4GELFmE64/7NqV+6d9miy0waFPtjprhmBbxyKPm7HDl9KJHZosHZrd/2K30XbSUw
	 uWh9SH7aS/fYIOyGFK1DKJljiYDLBXCw7chZtw5Wq1Expo2kNytAJJa8lje5uU8ysL
	 Pcf+z9MP28dIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v2 2/4] net: fill in MODULE_DESCRIPTION()s under net/core
Date: Fri, 27 Oct 2023 14:13:09 -0700
Message-ID: <20231027211311.1821605-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027211311.1821605-1-kuba@kernel.org>
References: <20231027211311.1821605-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev_addr_lists_test.c | 1 +
 net/core/selftests.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
index 90e7e3811ae7..4dbd0dc6aea2 100644
--- a/net/core/dev_addr_lists_test.c
+++ b/net/core/dev_addr_lists_test.c
@@ -233,4 +233,5 @@ static struct kunit_suite dev_addr_test_suite = {
 };
 kunit_test_suite(dev_addr_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for struct netdev_hw_addr_list");
 MODULE_LICENSE("GPL");
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 94fe3146a959..8f801e6e3b91 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -405,5 +405,6 @@ void net_selftest_get_strings(u8 *data)
 }
 EXPORT_SYMBOL_GPL(net_selftest_get_strings);
 
+MODULE_DESCRIPTION("Common library for generic PHY ethtool selftests");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
-- 
2.41.0


