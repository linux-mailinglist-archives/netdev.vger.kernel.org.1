Return-Path: <netdev+bounces-14352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A17740724
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 02:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922B1281171
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5811106;
	Wed, 28 Jun 2023 00:20:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C110EE
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 00:20:33 +0000 (UTC)
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 17:20:24 PDT
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [141.84.69.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB61326B3;
	Tue, 27 Jun 2023 17:20:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4QrMW26G5kz2W;
	Wed, 28 Jun 2023 02:13:34 +0200 (CEST)
Date: Wed, 28 Jun 2023 02:13:32 +0200
From: Tobias Heider <me@tobhe.de>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Prashant Sreedharan <prashant@broadcom.com>,
	Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
Message-ID: <ZJt7LKzjdz8+dClx@tobhe.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fixes a bug where on the M1 mac mini initramfs-tools fails to
include the necessary firmware into the initrd.

Signed-off-by: Tobias Heider <me@tobhe.de>
---
 drivers/net/ethernet/broadcom/tg3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 58747292521d..a52cf9aae498 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -224,6 +224,7 @@ MODULE_AUTHOR("David S. Miller (davem@redhat.com) and Jeff Garzik (jgarzik@pobox
 MODULE_DESCRIPTION("Broadcom Tigon3 ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FIRMWARE_TG3);
+MODULE_FIRMWARE(FIRMWARE_TG357766);
 MODULE_FIRMWARE(FIRMWARE_TG3TSO);
 MODULE_FIRMWARE(FIRMWARE_TG3TSO5);
 
-- 
2.39.2


