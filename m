Return-Path: <netdev+bounces-17795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CE07530C1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36D8281FF6
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA86FB8;
	Fri, 14 Jul 2023 04:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415C6FB3
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:51:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1B62D5F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PAND6z7d2ii3Ray/aT1PoR411j/ePVAyV/iz9Sf/HTs=; b=ZrJUAJoGiOzETJ12xjeVTez4Q0
	sruvKPJBajOftBELUE70nVrdVWbrTIVzxmAhA6dFG9MtwUTYIRouUbithf4vL5+ieaMP2w2oozxwT
	Rw9KstLl93Kgr9FT4psXFC560aY4fqHHsOv/+76IzCv0LVTeEIx3YsS4mEXfywEWdgifd8Lspzc/k
	UbFsuRszA0FhpdK846iE/bDez6eEcVKz5nutyyhp7nRnzzLp/dO5OfDvqPRyaiSc88ZX8zbAfiRwC
	dnLe+oP7WhUEurBzAsvj7flKAbr8EwDEfVvPhEodILabtR+XO/gcfk6JdOZz7daf98cJxR3Oefy6q
	OvRcQj2w==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKAmC-0050ZV-2w;
	Fri, 14 Jul 2023 04:51:32 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v2 net 9/9] rsi: remove kernel-doc comment marker
Date: Thu, 13 Jul 2023 21:51:27 -0700
Message-ID: <20230714045127.18752-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714045127.18752-1-rdunlap@infradead.org>
References: <20230714045127.18752-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Change an errant kernel-doc comment marker (/**) to a regular
comment to prevent a kernel-doc warning.

rsi_91x.h:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Copyright (c) 2017 Redpine Signals Inc.

Fixes: 4c10d56a76bb ("rsi: add header file rsi_91x")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
Cc: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Cc: Kalle Valo <kvalo@kernel.org>
Acked-by: Kalle Valo <kvalo@kernel.org>
---
v2: drop Cc: Amitkumar Karwar <amit.karwar@redpinesignals.com>;
    add Ack by Kalle;

 include/net/rsi_91x.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/net/rsi_91x.h b/include/net/rsi_91x.h
--- a/include/net/rsi_91x.h
+++ b/include/net/rsi_91x.h
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2017 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any

