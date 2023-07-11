Return-Path: <netdev+bounces-16639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A021F74E1B9
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD82281454
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFEE171AD;
	Mon, 10 Jul 2023 23:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA65171AA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:03:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB511D
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zRZXD2Jthz7pgllrXfpIfXTG8eHmdK2Rnbh9jadh1qw=; b=Symwoep1AwgfZ6gFEl3k5l9aVY
	PvLjcl90Jn96lHWGh5WeIIo66e5bsPDCKXEHOXb2aPBNKxMaNDS3o//DOcwHmcZpuh6dVJYQw6t4R
	q0s/5+4H8SC5kqAkIlS5UfxMmiBniet0qyZ+nxoxBwhH+pZFk1Y1FwH4uvh7ZTrVq8Z8UcZh65MUD
	JFS6+7eDvJUPnbfXcfdp3j/zbQAvVbJUcbV2aAbgY03OSVTcGJUMN0dPakwZKSkWqm55DccK+zeTu
	Lym/uKSyIqGy1nIzx33nEF3G39TF5kofglyp5EvNzWsCy12S7dVg5GqFf0zLEOq0wwFLueEEZ+IyW
	3c+soC9w==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzuW-00CuO1-0N;
	Mon, 10 Jul 2023 23:03:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Dave Taht <dave.taht@bufferbloat.net>
Subject: [PATCH net 04/12] codel: fix kernel-doc notation warnings
Date: Mon, 10 Jul 2023 16:03:04 -0700
Message-ID: <20230710230312.31197-5-rdunlap@infradead.org>
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

Use '@' before the struct member names in kernel-doc notation
to prevent kernel-doc warnings.

codel.h:158: warning: Function parameter or member 'ecn_mark' not described in 'codel_stats'
codel.h:158: warning: Function parameter or member 'ce_mark' not described in 'codel_stats'

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Dave Taht <dave.taht@bufferbloat.net>
---
 include/net/codel.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/net/codel.h b/include/net/codel.h
--- a/include/net/codel.h
+++ b/include/net/codel.h
@@ -145,8 +145,8 @@ struct codel_vars {
  * @maxpacket:	largest packet we've seen so far
  * @drop_count:	temp count of dropped packets in dequeue()
  * @drop_len:	bytes of dropped packets in dequeue()
- * ecn_mark:	number of packets we ECN marked instead of dropping
- * ce_mark:	number of packets CE marked because sojourn time was above ce_threshold
+ * @ecn_mark:	number of packets we ECN marked instead of dropping
+ * @ce_mark:	number of packets CE marked because sojourn time was above ce_threshold
  */
 struct codel_stats {
 	u32		maxpacket;

