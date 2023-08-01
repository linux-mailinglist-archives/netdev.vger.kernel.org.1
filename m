Return-Path: <netdev+bounces-23362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3115C76BB6C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627561C20FE7
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F8235A7;
	Tue,  1 Aug 2023 17:36:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705202CA5
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:36:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83C10F1;
	Tue,  1 Aug 2023 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=t3/TEOMMBqs2aatmdG8Z4OzwuZXTQz0DDq3G1QEeVZ0=; b=xn4P9Q6v+cxfApxHVA9nIEPL59
	XoFVePi8z26u90VblqDo8ZKsMc4U/DPTZRP68ibsrEcq6pP3g/0s3sKfa8oa9J58H+Rhq3KnrgleJ
	6hjJ52UVN20msW7acln7uPOWX2Wgfj9ssfxy52dAyC9hY0K407jhXK7ptNEaWsD0/heV0SMOsPncP
	ujQuF8E1zjeUTy+sWrlYianfi4e3+R7mMuqoeQ+xgOFZee91Fj/ltLieZapt2FvNM6+6lcWh2F9tS
	kvcQgk4/X9ea54a1eLYdm5du7NnHBNsjcGVKTmnCDw0bDVk1xj0mpa3GVRUzG/fB4KrkWlSOkqzCW
	FN32rksw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtII-002w8A-1j;
	Tue, 01 Aug 2023 17:36:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list),
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH 4/5] rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
Date: Tue,  1 Aug 2023 19:35:43 +0200
Message-Id: <20230801173544.1929519-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801173544.1929519-1-hch@lst.de>
References: <20230801173544.1929519-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ds1685_rtc_poweroff is only used externally via symbol_get, which was
only ever intended for very internal symbols like this one.  Use
EXPORT_SYMBOL_GPL for it so that symbol_get can enforce only being used
on EXPORT_SYMBOL_GPL symbols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Joshua Kinard <kumba@gentoo.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-ds1685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 0f707be0eb87fa..04dbf35cf3b706 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1432,7 +1432,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 		unreachable();
 	}
 }
-EXPORT_SYMBOL(ds1685_rtc_poweroff);
+EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
 /* ----------------------------------------------------------------------- */
 
 
-- 
2.39.2


