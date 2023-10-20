Return-Path: <netdev+bounces-42884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0547D07B5
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD331B214C1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF029447;
	Fri, 20 Oct 2023 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhVT2nkg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C24CA5D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B06119;
	Thu, 19 Oct 2023 22:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f5GWYBu+PKHamukWGpCOB6Gbm7bgNIpCSyr7dKv6+1g=; b=PhVT2nkgy3+lbP4vZOcgWvTN5i
	tJfiJf+9gc29uHUK19jyfDU3Xg/YhyElCyWF915/BUMNphCm4MBDQ5ORVCa5APGSGjtb94U0Wa+L6
	2t1JF97CPcG0ScFGSbOf1pFKTUY7vFicIHB/nlc61p15LAaDhHcEYq0DrQRq23GZaOPCYSuPQVvXE
	tvc2ofhIT+mO9AyImjq2M4ZevNiQHxV1DeKbHeppki+6SkgIwxARtFjv4RI3qrQHBiMGyVRAdTM+t
	T2lHLAgWm+ADw2gWSnm5Dhyk7OJ9uO3yXrr9kFdqmH7ctFyxm8aWdCAQFfRYnogBWXKeIKEraPJBU
	mdd4MR9g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qtiFb-001GmL-0X;
	Fri, 20 Oct 2023 05:40:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Greg Ungerer <gerg@linux-m68k.org>,
	iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org
Subject: [PATCH 8/8] m68k: remove unused includes from dma.c
Date: Fri, 20 Oct 2023 07:40:24 +0200
Message-Id: <20231020054024.78295-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020054024.78295-1-hch@lst.de>
References: <20231020054024.78295-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

dma.c doesn't need most of the headers it includes.  Also there is
no point in undefining the DEBUG symbol given that it isn't used
anywhere in this small file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/kernel/dma.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index eef63d032abb53..16063783aa80c6 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -4,17 +4,8 @@
  * for more details.
  */
 
-#undef DEBUG
-
 #include <linux/dma-map-ops.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/scatterlist.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/export.h>
-
 #include <asm/cacheflush.h>
 
 #ifndef CONFIG_COLDFIRE
-- 
2.39.2


