Return-Path: <netdev+bounces-16647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9774E1D1
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD71281481
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3490B1774C;
	Mon, 10 Jul 2023 23:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292EE17742
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:03:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1CEE48
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EyhtIl8iNwnZ53cBhS0nr/S/j3djORhPgE1jFYLM2BY=; b=NH5798TI+tbxZ7e0scBfTXwoNu
	9zte4Yy069Wnwl+tw+oOS5tBRKoDcr1mA5xug4WRCE12xyMuFb//fJusl/V02QdzTKOy941OBpygy
	gy+lPhUBa45DwLeXmJRMYqDyGMEVxr9xrgc/U/8vX2q7cElqUYE9biCR6/jRR/EaHB+glcVj15HsF
	DMCFR8HKZILkUCQsu6ggxHp5gx+LwZElsKnyBS5K5+HqBs+x+h2juX6w8tYiZ1JzDFMIDI2PqKkYc
	/vp1wcpiNXsaZT0sKu5xv1HnbkjOP5265VIQuZItglbWANlc31DMKasAHqBGCevDwcesboicStQKe
	plvh73Ag==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzuZ-00CuO1-1z;
	Mon, 10 Jul 2023 23:03:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH net 12/12] rsi: remove kernel-doc comment marker
Date: Mon, 10 Jul 2023 16:03:12 -0700
Message-ID: <20230710230312.31197-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710230312.31197-1-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
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
Cc: Amitkumar Karwar <amit.karwar@redpinesignals.com>
Cc: Kalle Valo <kvalo@kernel.org>
---
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

