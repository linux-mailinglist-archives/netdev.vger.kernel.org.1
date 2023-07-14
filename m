Return-Path: <netdev+bounces-17791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5897530BD
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFE61C214E5
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E03D5224;
	Fri, 14 Jul 2023 04:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2B63CD
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:51:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260A2D64
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hszDT02ww50FM3fvOHg2nA28gCNzUF4D7X06zLjN8/M=; b=yGbcg6+2z6NUEPmdzJJnEG284s
	mCmcg/H84kCLl3ahnOoGYfxJhQp6V2ijvy/7HCyQgv5RUbs3H2fwQ7+DNjL78t9uFW79XDGCr8aOJ
	2vWKP2bcT68ntoRjmql+eIB6kQfuJ9klyquX8in/HAd/qJ4hexySt5OYc4VHN2hS3frD06LiRiuEi
	kMHI1QJv2qgyQF29jjM377xki22Eoa6LWLbh0cCuIjnwfNf9mVaVSZzcjpY9oVoCQuI6oQdZYZxQ/
	7S7OAmoomrtd9u/dys8UPG1w/Gv0U0PiPFIWcMeliPC9xfGF0HVmDNKkgJ8UUN1KoFnKPG9lg8Yf8
	sp31BPyw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKAmB-0050ZV-1n;
	Fri, 14 Jul 2023 04:51:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 net 6/9] net: llc: fix kernel-doc notation warnings
Date: Thu, 13 Jul 2023 21:51:24 -0700
Message-ID: <20230714045127.18752-7-rdunlap@infradead.org>
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

Use the corrent function parameter name or format to prevent
kernel-doc warnings.
Add 2 function parameter descriptions to prevent kernel-doc warnings.

llc_pdu.h:278: warning: Function parameter or member 'da' not described in 'llc_pdu_decode_da'
llc_pdu.h:278: warning: Excess function parameter 'sa' description in 'llc_pdu_decode_da'
llc_pdu.h:330: warning: Function parameter or member 'skb' not described in 'llc_pdu_init_as_test_cmd'
llc_pdu.h:379: warning: Function parameter or member 'svcs_supported' not described in 'llc_pdu_init_as_xid_cmd'
llc_pdu.h:379: warning: Function parameter or member 'rx_window' not described in 'llc_pdu_init_as_xid_cmd'

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/net/llc_pdu.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff -- a/include/net/llc_pdu.h b/include/net/llc_pdu.h
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -269,7 +269,7 @@ static inline void llc_pdu_decode_sa(str
 /**
  *	llc_pdu_decode_da - extracts dest address of input frame
  *	@skb: input skb that destination address must be extracted from it
- *	@sa: pointer to destination address (6 byte array).
+ *	@da: pointer to destination address (6 byte array).
  *
  *	This function extracts destination address(MAC) of input frame.
  */
@@ -321,7 +321,7 @@ static inline void llc_pdu_init_as_ui_cm
 
 /**
  *	llc_pdu_init_as_test_cmd - sets PDU as TEST
- *	@skb - Address of the skb to build
+ *	@skb: Address of the skb to build
  *
  * 	Sets a PDU as TEST
  */
@@ -369,6 +369,8 @@ struct llc_xid_info {
 /**
  *	llc_pdu_init_as_xid_cmd - sets bytes 3, 4 & 5 of LLC header as XID
  *	@skb: input skb that header must be set into it.
+ *	@svcs_supported: The class of the LLC (I or II)
+ *	@rx_window: The size of the receive window of the LLC
  *
  *	This function sets third,fourth,fifth and sixth bytes of LLC header as
  *	a XID PDU.

