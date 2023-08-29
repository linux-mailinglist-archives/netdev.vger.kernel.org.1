Return-Path: <netdev+bounces-31165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2916978C0BF
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CA0280FF9
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A614AB5;
	Tue, 29 Aug 2023 08:47:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A414AA7
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 08:47:27 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C5CC7
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 01:47:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD6DC1F750;
	Tue, 29 Aug 2023 08:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1693298840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AspkWfyOutWiesbzUMApKDCtJgN8CnBNABew71w2J/M=;
	b=EJhB1JRro86gKHuXFafGECBuZhwOR3UfO0PVOzLoiEkItx+8S6hpyNdGS3pkZQiERiaIjq
	bIxM7RtKHGcVoig2EGjcQ6v/WSBpThO57POvfaKeCSU60XMOoE9A3HG+c6w+Bxj+sziNcZ
	jj9JyUeuSqs9iofabUmDalRuvwO1oMc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4194813301;
	Tue, 29 Aug 2023 08:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UtdBDpiw7WQ+RgAAMHmgww
	(envelope-from <oneukum@suse.com>); Tue, 29 Aug 2023 08:47:20 +0000
From: Oliver Neukum <oneukum@suse.com>
To: krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@pengutronix.de,
	sridhar.samudrala@intel.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] NFC: nxp: add NXP1002
Date: Tue, 29 Aug 2023 10:47:17 +0200
Message-ID: <20230829084717.961-1-oneukum@suse.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is backwards compatible

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/nfc/nxp-nci/i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index e2444ff582dc..7d35645b0e8b 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -343,6 +343,7 @@ MODULE_DEVICE_TABLE(of, of_nxp_nci_i2c_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id acpi_id[] = {
 	{ "NXP1001" },
+	{ "NXP1002" },
 	{ "NXP7471" },
 	{ }
 };
-- 
2.41.0


