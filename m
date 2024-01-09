Return-Path: <netdev+bounces-62704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5148828A3C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B5428829E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640BA3A8C1;
	Tue,  9 Jan 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIy+IygD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E23A294
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E46C43394;
	Tue,  9 Jan 2024 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818723;
	bh=3UW1BaI4F+h29/KDXw3mBVbUNtoJTtkiw9/DXnzKfS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIy+IygDIiVA1ghOWc1WjU0dKTrcf6kZOkVZ7mC2I2vcSO6KQtAZD01DDfIvB4dbF
	 4xzaCYX+NUBll1EBJDItQnLPbsOA7gwuF3J3CG1zinXsZxL1u+EiUXDixSCpvrsFKZ
	 YG51Ls6Wijn1EZOIFPotec8q7VUoiHNbRTbCiiA4fc6CJopDsqJqeC5n7JYuZ39ZM8
	 NIblbp6XwxIaKS5tAQRLYqUVZsLGFpCHb5WA+CTF8gHkA0PLtO7eWdQpqq6cnqDsR1
	 h5B1xkvZ10IznO4nysbIfZbyora6He8XpmX+gzOd5w6yLFWAqeP+2J29pScLXprpmY
	 sK+u2/A+67HNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	John Crispin <john@phrozen.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net 1/7] MAINTAINERS: eth: mtk: move John to CREDITS
Date: Tue,  9 Jan 2024 08:45:11 -0800
Message-ID: <20240109164517.3063131-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109164517.3063131-1-kuba@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

John is still active in other bits of the kernel but not much
on the MediaTek ethernet switch side. Our scripts report:

Subsystem MEDIATEK ETHERNET DRIVER
  Changes 81 / 384 (21%)
  Last activity: 2023-12-21
  Felix Fietkau <nbd@nbd.name>:
    Author c6d96df9fa2c 2023-05-02 00:00:00 42
    Tags c6d96df9fa2c 2023-05-02 00:00:00 48
  John Crispin <john@phrozen.org>:
  Sean Wang <sean.wang@mediatek.com>:
    Author 880c2d4b2fdf 2019-06-03 00:00:00 5
    Tags a5d75538295b 2020-04-07 00:00:00 7
  Mark Lee <Mark-MC.Lee@mediatek.com>:
    Author 8d66a8183d0c 2019-11-14 00:00:00 4
    Tags 8d66a8183d0c 2019-11-14 00:00:00 4
  Lorenzo Bianconi <lorenzo@kernel.org>:
    Author 7cb8cd4daacf 2023-12-21 00:00:00 98
    Tags 7cb8cd4daacf 2023-12-21 00:00:00 112
  Top reviewers:
    [18]: horms@kernel.org
    [15]: leonro@nvidia.com
    [8]: rmk+kernel@armlinux.org.uk
  INACTIVE MAINTAINER John Crispin <john@phrozen.org>

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Felix Fietkau <nbd@nbd.name>
CC: Sean Wang <sean.wang@mediatek.com>
CC: Mark Lee <Mark-MC.Lee@mediatek.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 6b4b06bb683b..a80bd154ae38 100644
--- a/CREDITS
+++ b/CREDITS
@@ -815,6 +815,10 @@ D: Support for Xircom PGSDB9 (firmware and host driver)
 S: Bucharest
 S: Romania
 
+N: John Crispin
+E: john@phrozen.org
+D: MediaTek MT7623 Gigabit ethernet support
+
 N: Laurence Culhane
 E: loz@holmes.demon.co.uk
 D: Wrote the initial alpha SLIP code
diff --git a/MAINTAINERS b/MAINTAINERS
index 014ad90d0872..737504c0c432 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13464,7 +13464,6 @@ F:	drivers/dma/mediatek/
 
 MEDIATEK ETHERNET DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
-M:	John Crispin <john@phrozen.org>
 M:	Sean Wang <sean.wang@mediatek.com>
 M:	Mark Lee <Mark-MC.Lee@mediatek.com>
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
-- 
2.43.0


