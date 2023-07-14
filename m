Return-Path: <netdev+bounces-17796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A036A7530C3
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B318281ED9
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790EC6AB7;
	Fri, 14 Jul 2023 04:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7476FB3
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:51:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2C2D5F;
	Thu, 13 Jul 2023 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qD1DXByFaVGbY/ACa45ihUzn0y1l3V5o3cGLVTAVR2A=; b=PWbv+b9d71LvMImhJaPVoUOsyn
	EESuz1kQB92oVOXS/r3VcuSkBWvwM7d5Aa9b4RGvdMeSEujCheplsMm1FP0oZA6DWB6NobAtH5wCZ
	bFMApdt2/hZKLk1wh6HiB20d03hrtxdhb01KASGTl5rn/wM4XWjMQ8M4DSv4hm6ov4jdX77t7I3ul
	C+hNt2ncmv1naNPv4BWunZI0rBJ3eRjnU4QaLbNkT8C9e3mkFwV4xU2YPKFNe50U0+pc9xtVXWJhw
	8qTJ2/QDc515CVUDx7AKzVcFqPSnfaPsiIWmz3bRJgVn+ATUqCwsSeSVmrfL/3uK+mYY+LzlMVGhC
	l6olE4pw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKAm9-0050ZV-2n;
	Fri, 14 Jul 2023 04:51:29 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-wpan@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v2 net 2/9] net: cfg802154: fix kernel-doc notation warnings
Date: Thu, 13 Jul 2023 21:51:20 -0700
Message-ID: <20230714045127.18752-3-rdunlap@infradead.org>
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

Add an enum heading to the kernel-doc comments to prevent
kernel-doc warnings.

cfg802154.h:174: warning: Cannot understand  * @WPAN_PHY_FLAG_TRANSMIT_POWER: Indicates that transceiver will support
 on line 174 - I thought it was a doc line

cfg802154.h:192: warning: Enum value 'WPAN_PHY_FLAG_TXPOWER' not described in enum 'wpan_phy_flags'
cfg802154.h:192: warning: Excess enum value 'WPAN_PHY_FLAG_TRANSMIT_POWER' description in 'wpan_phy_flags'

Fixes: edea8f7c75ec ("cfg802154: introduce wpan phy flags")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
v2: add Ack by Miquel;

 include/net/cfg802154.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/include/net/cfg802154.h b/include/net/cfg802154.h
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -170,7 +170,8 @@ wpan_phy_cca_cmp(const struct wpan_phy_c
 }
 
 /**
- * @WPAN_PHY_FLAG_TRANSMIT_POWER: Indicates that transceiver will support
+ * enum wpan_phy_flags - WPAN PHY state flags
+ * @WPAN_PHY_FLAG_TXPOWER: Indicates that transceiver will support
  *	transmit power setting.
  * @WPAN_PHY_FLAG_CCA_ED_LEVEL: Indicates that transceiver will support cca ed
  *	level setting.

