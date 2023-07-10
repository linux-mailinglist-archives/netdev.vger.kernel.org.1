Return-Path: <netdev+bounces-16649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726B74E1D4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F2728119C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E211774E;
	Mon, 10 Jul 2023 23:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937017744
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:03:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9318F11D
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yBiQr9QkgT2u++uzYKkTCPg+dXnnz/lfTj6BtKd9PYw=; b=wRYNtoebzaQKp0JM2ZILcIXFRk
	2jWU5bIyFPtbTN3o4TNXpqbH5XxSO9YpQHuYL0ud0zOtIp0FYyUTh7wt3WjMrx48SJMYVP3hXsX1q
	tZG9TE9sZPNfJK8YwO+Mf09SJla69/owZsTAL+/POU2iUuRD1OMmtuFb+T2JM1g37mMcWm31EVTTg
	JYFK00E2ltcIsVe++GS1K326oGuQWO2eQtQqR9dJtwMeeV8+hq/4lrw44ajLqNUl5GlgNYkcGqtXH
	G044pzeZ3bfNCchyoZxHq/JCTpHuM0zkNPf26YPeKshdJjzVJjNaWb4Z/MPnO6v+f0T7ebWpjoCZP
	UqpRwQFA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzuZ-00CuO1-0N;
	Mon, 10 Jul 2023 23:03:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Leslie Monis <lesliemonis@gmail.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	Gautam Ramakrishnan <gautamramk@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net 11/12] pie: fix kernel-doc notation warning
Date: Mon, 10 Jul 2023 16:03:11 -0700
Message-ID: <20230710230312.31197-12-rdunlap@infradead.org>
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

Spell a struct member's name correctly to prevent a kernel-doc
warning.

pie.h:38: warning: Function parameter or member 'tupdate' not described in 'pie_params'

Fixes: b42a3d7c7cff ("pie: improve comments and commenting style")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Leslie Monis <lesliemonis@gmail.com>
Cc: "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>
Cc: Gautam Ramakrishnan <gautamramk@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
---
 include/net/pie.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/net/pie.h b/include/net/pie.h
--- a/include/net/pie.h
+++ b/include/net/pie.h
@@ -17,7 +17,7 @@
 /**
  * struct pie_params - contains pie parameters
  * @target:		target delay in pschedtime
- * @tudpate:		interval at which drop probability is calculated
+ * @tupdate:		interval at which drop probability is calculated
  * @limit:		total number of packets that can be in the queue
  * @alpha:		parameter to control drop probability
  * @beta:		parameter to control drop probability

