Return-Path: <netdev+bounces-44546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD97D88AE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 21:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517FD282106
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84883B2A1;
	Thu, 26 Oct 2023 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="env+rUFz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE833B28C
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 19:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC835C433CC;
	Thu, 26 Oct 2023 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698346869;
	bh=BfpcEIriXhL6NA0XYfCr5RdHD1Y5kk9MyjlA/KAMY2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=env+rUFzgcE/caI6Fh3g7WjTBOxZLqeqQ7h9zP4wWpHc14KazhOPk43b3GvhVWwU0
	 SLwokJ9wTLIx9yL7YG0iFBHPwCFTPRIdl+9JFF9leh+jf+nt/OkoibXkeIsoKozjGD
	 ParM2skwjrj2JP22TslUW0kr7qr/JS+joT4lnqmN3E6AolYSryyitkt1hGruJV2AaY
	 TVZcrtPxafv//FrLzaox2nmphAHIKi+oHAEsmvgWuwSdkgl2wy1gYg9o5a6ijj++XZ
	 Vrm03topJcRhsvAJ9XlVxMf8OBtegw8xYIdd56vCm6rcRmTQlcbc3k998lPHCWmebm
	 gzbjjUnC+azUA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	o.rempel@pengutronix.de
Subject: [PATCH net-next 2/4] net: fill in MODULE_DESCRIPTION()s under net/core
Date: Thu, 26 Oct 2023 12:00:59 -0700
Message-ID: <20231026190101.1413939-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026190101.1413939-1-kuba@kernel.org>
References: <20231026190101.1413939-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: o.rempel@pengutronix.de
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


