Return-Path: <netdev+bounces-16638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA44374E1B4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA00C1C20C36
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBA168BA;
	Mon, 10 Jul 2023 23:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62E168B3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B992D10D;
	Mon, 10 Jul 2023 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tumxd6dc0vA2G3EW/fnOXAr0IYFDVpLv9/tSCnYJH58=; b=MNrqg8ZIwFfxKGIYijdmU6rN8z
	xUZdZrBz62rQNWs3uQWIKBLIJIx1kxNHVi3zkAkRQPSSBJ0gwiZySD1ol8/+BtoS16tX60pVIlTpW
	jwwU5+ErUDgUouPP2HVQZJBPEX6yozCrXfKZFT9D4MWDwRw1qdtYZ8GgL5l1RP868Mf71tGe01LG/
	nu5YN7XfjYFTFgs38CoWETwCV7e2mvavhGXmUZoEVAwlNmYccWvbmQLKCrXviZO69gTxivSozv2S5
	1hxhFYfKC0i3FDG7G59IHMpv4KZ3zOJyQF2iQPo2Ne9TXaJWBscvnh5RHsW3eVBU7PVkVQMHQMa+Q
	4PIJtOBw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzuV-00CuO1-0S;
	Mon, 10 Jul 2023 23:03:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH net 02/12] wifi: cfg80211: remove dead/unused enum value
Date: Mon, 10 Jul 2023 16:03:02 -0700
Message-ID: <20230710230312.31197-3-rdunlap@infradead.org>
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

Drop an unused (extra) enum value to prevent a kernel-doc warning.

cfg80211.h:1492: warning: Excess enum value 'STATION_PARAM_APPLY_STA_TXPOWER' description in 'station_parameters_apply_mask'

Fixes: 2d8b08fef0af ("wifi: cfg80211: fix kernel-doc warnings all over the file")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 include/net/cfg80211.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/net/cfg80211.h b/include/net/cfg80211.h
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1479,7 +1479,6 @@ struct iface_combination_params {
  * @STATION_PARAM_APPLY_UAPSD: apply new uAPSD parameters (uapsd_queues, max_sp)
  * @STATION_PARAM_APPLY_CAPABILITY: apply new capability
  * @STATION_PARAM_APPLY_PLINK_STATE: apply new plink state
- * @STATION_PARAM_APPLY_STA_TXPOWER: apply tx power for STA
  *
  * Not all station parameters have in-band "no change" signalling,
  * for those that don't these flags will are used.

