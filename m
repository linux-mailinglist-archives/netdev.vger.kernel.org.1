Return-Path: <netdev+bounces-14639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5891F742C92
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088E0280D4C
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A014292;
	Thu, 29 Jun 2023 19:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24814269
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2FAC433C0;
	Thu, 29 Jun 2023 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065277;
	bh=qOWJR5B/v04A70X7Ke3al4vL7mXxqeyOb4QdNArum5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYrpqu+rpzZw0ajizqBuyVyVSfKIaxV41OySwW8g9C+44WOF81gLzihgF4cLMeMk4
	 e5iQ4P7SP7ysbqJ+AVk1yF6M9BsqiQ91a7DauvTgEzA9NNoKULtQPpncFo1j8s3HEK
	 zTVi/pdyzwifGkxh+1ikJATiiimpzv+kuHnoTWrdF92aqxc0seoNb0myl7QfBe4w+U
	 3A1tyJcp9VAxJtkmHyRMX/bj0oUbOYtkX8IKy7FjXy1q+SUTExN2agIWFWgq7/Ipyi
	 M+KeTIeAPfvfnI7Bz4JHfNF0P+yxIExiTZM0D0CPJ2iFLqylewOL7dVUEg0syCdl2J
	 QVdE+NBfGERwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juerg Haefliger <juerg.haefliger@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	shangxiaojing@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 09/17] nfc: fdp: Add MODULE_FIRMWARE macros
Date: Thu, 29 Jun 2023 15:00:38 -0400
Message-Id: <20230629190049.907558-9-sashal@kernel.org>
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


