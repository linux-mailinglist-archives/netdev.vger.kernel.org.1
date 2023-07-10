Return-Path: <netdev+bounces-16637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8122C74E1B3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11321C20C36
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC2E168B2;
	Mon, 10 Jul 2023 23:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E35168B0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F63F9
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9YJYHtPVNWz0vTrE8jX9JgM1vcMFqhu5z9qKG4nWNm8=; b=Zu2lUA+bCUSWwZQPzgtGOJHY+h
	lHVbBP0F9Mb5bs1EV7JDBBnS6zNdyoefzjwYld0bRCMLY5IgxL+ZtmuQR/5ciDHxYABjmlkWaLaOL
	JdaghaVOgtPNRG6tOcRvQ60khb7RrTJwNATiIW/vUJE/GaaAmQcYvQXjeGF0BmNup2YkmwjBDdUGP
	IqQjyquoXFRW9YmDaQsOMpv6E+2cOX7AstvGrC6QJt0WLGnOhABnrq26Ey+FBRAlbAm4sar60jygm
	zKURhbI7hQl1/xQwgjEP0WeJI2j3IYgjbEiUJc+rYSwBrIWdjzU/Ktmd0Rf3BPbSj9Z7oCjqCaXAw
	dJTm6qPg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzuU-00CuO1-2F;
	Mon, 10 Jul 2023 23:03:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>
Subject: [PATCH net 01/12] net: bonding: remove kernel-doc comment marker
Date: Mon, 10 Jul 2023 16:03:01 -0700
Message-ID: <20230710230312.31197-2-rdunlap@infradead.org>
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

