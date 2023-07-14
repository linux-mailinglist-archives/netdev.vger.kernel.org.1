Return-Path: <netdev+bounces-17789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB1D7530BB
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863F1281F76
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E796653AD;
	Fri, 14 Jul 2023 04:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E765224
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E02D5F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9YJYHtPVNWz0vTrE8jX9JgM1vcMFqhu5z9qKG4nWNm8=; b=oEPzoklxgegcMBNtxyA5AXA/nv
	2E7GYLPySTShhzJW9Gbz/ZT2ivbKftLDsjnBud/TQFEmnQUtYjyak007EStdQ5av0tXJaeD8aRzjd
	UiGFPWCC8phlte/4ed6twgXDlT1+4dp9y1lqpUnVS5p0hdtDydNKU9YOl7KashLZeQs5TX7nI6Ts7
	s+kdOxlWgrwcXRiqQydn81Ww0jCeYMMproHxNBJwbdPrp1uAfC9Y/iP8sLkFedoVKAJx4kGN/qtvv
	xHR9ujKjyeXDY4xfb3ChSYVOR5YcZJO/z97iMFvbvh7/D905CSPS//OjSDRNtOaNWjPEC8ekV1v2s
	rKqVS4dQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKAm9-0050ZV-0s;
	Fri, 14 Jul 2023 04:51:29 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>
Subject: [PATCH v2 net 1/9] net: bonding: remove kernel-doc comment marker
Date: Thu, 13 Jul 2023 21:51:19 -0700
Message-ID: <20230714045127.18752-2-rdunlap@infradead.org>
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

bonding.h:282: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Returns NULL if the net_device does not belong to any of the bond's slaves

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
---
 include/net/bonding.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/net/bonding.h b/include/net/bonding.h
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -277,7 +277,7 @@ struct bond_vlan_tag {
 	unsigned short	vlan_id;
 };
 
-/**
+/*
  * Returns NULL if the net_device does not belong to any of the bond's slaves
  *
  * Caller must hold bond lock for read

