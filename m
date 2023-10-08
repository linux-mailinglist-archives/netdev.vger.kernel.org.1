Return-Path: <netdev+bounces-38921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D247BD057
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 23:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A4628157D
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11CF22F00;
	Sun,  8 Oct 2023 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BEC3aOno"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C552584
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 21:41:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677DDAC;
	Sun,  8 Oct 2023 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5oCCkNgvbUHSsCsaO/gYrO0Jg80vhFklPWNFZlpC5ng=; b=BEC3aOnoc6D40FR4QXG1FDQgsx
	hWil8guCdpiVBgK2khdaxrkTejo9lfT2ec0HleG02JdR53A+/LlcyCd9qcRgKR2Gxh8/4dBTk4Qqh
	ATATEBRZD1YMBptQd1tpXGI9TO8EpEuuYVmYelj8Y9OojZx0dDHkS7rANJ5Fo7AhXATDESjdnuPiM
	+09PsZ5UikgBIqpj6RuRdoLUu8oQeFqBidtLlax6PxfAnflZfdCmRoQhdNBsheIhGuGioI2roVn9J
	XnkfUXQDoYQXTCRpmVAzIZeYBtFrxj0uT3CBrx5qAoDJnHH00YD4XifXYvEh7/jYYSvThHVNf+O4M
	pUQ/zfjw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qpbWd-009M4Q-0L;
	Sun, 08 Oct 2023 21:41:23 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2] net: skbuff: fix kernel-doc typos
Date: Sun,  8 Oct 2023 14:41:21 -0700
Message-ID: <20231008214121.25940-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
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

Correct punctuation and drop an extraneous word.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: change "that this" to just "that" since "this" is unneeded
    (Simon and Jakub)

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
+ * so we also check that didn't happen.
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

