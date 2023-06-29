Return-Path: <netdev+bounces-14644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1890D742C9C
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F41C20AC4
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98141429E;
	Thu, 29 Jun 2023 19:01:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F415486
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC02C433C0;
	Thu, 29 Jun 2023 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065304;
	bh=qOWJR5B/v04A70X7Ke3al4vL7mXxqeyOb4QdNArum5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXeZ0vn7BheUN+kKrgbuYIMFQw/qrDrL1Mqb2Z1o+KE8XBZmQFrODOSZq02nsjydO
	 jc6+B+W8ibTdAkFAoBaWjiZrYRulm+mvvBZ3qS0bgn5TjfHtJuFWyM6dgdtGDPTJXH
	 +/t5WgM+u38OBzXGTv372ywZOBGnrl1FkrqFJSv6TboTAghcV2UgG2Ea7e56ZiFdxP
	 lv39WUA3e9LtRMWclsGox2ufPK3wkncMUcegxBhEjkENu72Udv3fcemCSbRNUjBRxi
	 irIj58z0qZFzIhILNl+6f+HW3O9dGD1HXC//dq40YMnrbLUTgLS/cI1kfSAd8Ao4y2
	 AkbT3PjudGrww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juerg Haefliger <juerg.haefliger@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	shangxiaojing@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/12] nfc: fdp: Add MODULE_FIRMWARE macros
Date: Thu, 29 Jun 2023 15:01:26 -0400
Message-Id: <20230629190134.907949-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190134.907949-1-sashal@kernel.org>
References: <20230629190134.907949-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
Content-Transfer-Encoding: 8bit

From: Juerg Haefliger <juerg.haefliger@canonical.com>

[ Upstream commit eb09fc2d14163c0c217846cfabec3d0cce7c8f8c ]

The module loads firmware so add MODULE_FIRMWARE macros to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/fdp/fdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index f12f903a9dd13..da3e2dce8e70a 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -762,3 +762,6 @@ EXPORT_SYMBOL(fdp_nci_remove);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("NFC NCI driver for Intel Fields Peak NFC controller");
 MODULE_AUTHOR("Robert Dolca <robert.dolca@intel.com>");
+
+MODULE_FIRMWARE(FDP_OTP_PATCH_NAME);
+MODULE_FIRMWARE(FDP_RAM_PATCH_NAME);
-- 
2.39.2


