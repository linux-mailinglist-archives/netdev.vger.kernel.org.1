Return-Path: <netdev+bounces-37227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFB7B44D2
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 02:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 52608282073
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DC039F;
	Sun,  1 Oct 2023 00:38:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0F37D
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 00:38:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5552CA;
	Sat, 30 Sep 2023 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=z88LOIZ7EHuBVYquetgM5Awx0oSZmDtFncHgndSEXL8=; b=c+v9RdPLbFnKnkqj77DOIeop5v
	dJI/ZozCdVWv+B8NUgRZEtN/fRQ0N+vT5b3DpWRlldnPHOWW1EfTuZ9w58yXDegSeCFDft+nmzFIp
	rzbkpEirDTyAEpt3tbVHW1aisXd3hy7CS6I7OvkAOolIMjhsle2k01q4vgrUBlyQcrKycbi/dj5Qh
	yoXyxobqiBAIQ2Ay4VMq4zZNkDh0PZqLLDbsEm1v+vdHGusjHOQyIcalTEvQdtA+aqD2li/3AaXr4
	0suSpZCMJ0Auca2HsEkYUCdKiZZK4exQoU2OI8b+f2v/PW7aNXBSMFk4dH3QVtMxQdVPy/lWu/o0d
	uPmUggaA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qmkTv-00AI3H-1b;
	Sun, 01 Oct 2023 00:38:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH] net: skbuff: fix kernel-doc typos
Date: Sat, 30 Sep 2023 17:38:46 -0700
Message-ID: <20231001003846.29541-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001003846.29541-1-rdunlap@infradead.org>
References: <20231001003846.29541-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Correct punctuation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 include/linux/skbuff.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1309,7 +1309,7 @@ struct sk_buff_fclones {
  *
  * Returns true if skb is a fast clone, and its clone is not freed.
  * Some drivers call skb_orphan() in their ndo_start_xmit(),
- * so we also check that this didnt happen.
+ * so we also check that this didn't happen.
  */
 static inline bool skb_fclone_busy(const struct sock *sk,
 				   const struct sk_buff *skb)
@@ -2016,7 +2016,7 @@ static inline struct sk_buff *skb_share_
  *	Copy shared buffers into a new sk_buff. We effectively do COW on
  *	packets to handle cases where we have a local reader and forward
  *	and a couple of other messy ones. The normal one is tcpdumping
- *	a packet thats being forwarded.
+ *	a packet that's being forwarded.
  */
 
 /**

