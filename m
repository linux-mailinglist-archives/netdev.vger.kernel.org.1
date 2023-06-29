Return-Path: <netdev+bounces-14651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB94742CEB
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3E21C20953
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5521643C;
	Thu, 29 Jun 2023 19:02:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C316405
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD5C433CD;
	Thu, 29 Jun 2023 19:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065331;
	bh=w8fVzKIFlZlrrzG/iy9drGGrL1ZlhQlSoKXNcjzNd7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrGHnq8In2ac//X5vBwx1dEzftstO/Qo9zN4KC+tSkpHEW7eyygXk708aq47jGlZh
	 5u75WTusIvAvejgFYWlkaO7AJj8ni97shlfGAaXKqH0OyVchksSgmNT3VkipV7V4OI
	 jSR4eOBVEQhEYZHcEI8l1cV5DTckRn8qf0CN2nLyFbN8YBwE69V1/IBidCo0zEL393
	 ZuS17/IS2tHgnFPc9m+ckcmlTTRcbW5LikKQrqHK0D2r7Gi05lsnW/BlEwmoNq42R1
	 8KTMpkgVhiSv7MIG6k/XxV5Erg0OHOY8V1FHgwKvoBc+7medK+v730Ggm4HkS53UK5
	 ijOG8wDJHgxcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juerg Haefliger <juerg.haefliger@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	shangxiaojing@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/4] nfc: fdp: Add MODULE_FIRMWARE macros
Date: Thu, 29 Jun 2023 15:02:03 -0400
Message-Id: <20230629190206.908243-3-sashal@kernel.org>
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
index 90bea6a1db692..e2162f02f2d46 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -776,3 +776,6 @@ EXPORT_SYMBOL(fdp_nci_remove);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("NFC NCI driver for Intel Fields Peak NFC controller");
 MODULE_AUTHOR("Robert Dolca <robert.dolca@intel.com>");
+
+MODULE_FIRMWARE(FDP_OTP_PATCH_NAME);
+MODULE_FIRMWARE(FDP_RAM_PATCH_NAME);
-- 
2.39.2


