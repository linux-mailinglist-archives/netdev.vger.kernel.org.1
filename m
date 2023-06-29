Return-Path: <netdev+bounces-14648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A28742CE4
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16A9280C46
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDB314284;
	Thu, 29 Jun 2023 19:02:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B9D16408
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9A4C433CB;
	Thu, 29 Jun 2023 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065322;
	bh=qOWJR5B/v04A70X7Ke3al4vL7mXxqeyOb4QdNArum5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICEzBwwJ337bKFKkuSPegSxdqlpm7yMXqJNlMw/d2wHv9LF+wNZeu/D/FUzFyqQ4U
	 XeoDcuMd8dBDj6XW1tuAh4+bnKz0RubG/h8desWdJ7jGV5KuChy0rPn/z1Jou1vLf6
	 uh8g5CmePCk79tnSMA8w9spPjhYVAEgoPvWx5KzZCvq0m3YBgqHFnT54i4+eOB7SXd
	 TyT1j4OYHTjW/ri/sMdCjd+VyN2U1gYXCwqtjF+ezDjWFrGJ4jwAgBJ+TpGe3ahGu0
	 2dOugN/bYyp5poyL8LKNr/bn/4fD9eMUIz5BBqlfHVJRgNTZYaKV9XtxLIILImUaFH
	 8eKa8aYAijilQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juerg Haefliger <juerg.haefliger@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	shangxiaojing@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/5] nfc: fdp: Add MODULE_FIRMWARE macros
Date: Thu, 29 Jun 2023 15:01:54 -0400
Message-Id: <20230629190158.908169-3-sashal@kernel.org>
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


