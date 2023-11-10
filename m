Return-Path: <netdev+bounces-47098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457D7E7C0B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 13:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72FA1B20F5D
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11891864E;
	Fri, 10 Nov 2023 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHuSVFjh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A58182DE
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 12:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A91EC433C7;
	Fri, 10 Nov 2023 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699617951;
	bh=JatCpayGw54MM2MQczG9OMKbwICuIITscYmUVdsdweg=;
	h=From:To:Cc:Subject:Date:From;
	b=YHuSVFjhijPxEuoBs7dhlY0+QJaSDAqCNpi2QdsgeMuGyBY+PsUkbK8jOwDRaCtOg
	 sKoxl1tTXtSCAliPHU2DIzvlmKBh2gFfKJycsLgYeVaR4iRzwZ3hA8igWK/lzd5Moi
	 x5IGEfprBh8WdRMahjWiwNI7+C5BNSwBIikqGWp16ve9EJ8puQlStJ/M/500511JeV
	 Ro9MdEXMYGk8ALHSXLG2WleWzlKIcg/MF5FYbfGZpEXKpJpsWrzIsMlv5nmMc+j/Z+
	 sGxsPXseKuF0rnUh4QWEXkZcutI2VhsTuupHnQ/X4QinQa7n++YGqJ2/FDOWAECI4p
	 YIe3EzLp9o0Ow==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net] net: mdio: fix typo in header
Date: Fri, 10 Nov 2023 13:05:46 +0100
Message-ID: <20231110120546.15540-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The quotes symbol in
  "EEE "link partner ability 1
should be at the end of the register name
  "EEE link partner ability 1"

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 include/linux/mdio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 8fa23bdcedbf..007fd9c3e4b6 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -420,7 +420,7 @@ static inline u32 linkmode_adv_to_mii_t1_adv_m_t(unsigned long *advertising)
  * A function that translates value of following registers to the linkmode:
  * IEEE 802.3-2018 45.2.3.10 "EEE control and capability 1" register (3.20)
  * IEEE 802.3-2018 45.2.7.13 "EEE advertisement 1" register (7.60)
- * IEEE 802.3-2018 45.2.7.14 "EEE "link partner ability 1 register (7.61)
+ * IEEE 802.3-2018 45.2.7.14 "EEE link partner ability 1" register (7.61)
  */
 static inline void mii_eee_cap1_mod_linkmode_t(unsigned long *adv, u32 val)
 {
-- 
2.41.0


