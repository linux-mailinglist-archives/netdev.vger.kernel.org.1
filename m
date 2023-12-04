Return-Path: <netdev+bounces-53526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794880390E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF3BB20BC3
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A22C86A;
	Mon,  4 Dec 2023 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b="qEIZJa7N";
	dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b="WESxdsOt"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 07:43:02 PST
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8E1C3
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
	s=dkim1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VM+Vw9ink97pjcckziS5p6odtjFhBVxca8LD+qMjFqg=; b=qEIZJa7NhmVN94Nl0AJwKMOwNQ
	1Prz0rE0EgEVK2F/Y1tWfnnjhjeTvRFHJMYqUXjGXZ4bmNTCGu9IgZwBGEUzJ4UYcZM7iGvVJZ/91
	OGCucuH6NjJEhvVsz0lpqBP6WGu7B9S8Pj8anNDakg2qyAi0DyUQFJVbmvfQpfw0A5N4Lu1ncQh/g
	UMwaSYrzXdUfaG2Pe6LxKTkMRe2JJ/9ywXcXrQCsjHJzMfz6cWwVwCb1ltvN2r2UaCpkwLiTMEaNH
	XAQdboz2BKy/nLncUD7ryKFU+JyWdaRwPjDgA7FCG+qxcfQWxzcozgiWgpfn4OBIMkMf22lc1YeaP
	F7yHJAVA==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:41446 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.96)
	(envelope-from <dd@embedd.com>)
	id 1rAB3q-0007bE-2D;
	Mon, 04 Dec 2023 16:40:42 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_1099 0.000000,
	BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000,
	DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
	LEGITIMATE_SIGNS 0.000000, MULTIPLE_RCPTS 0.100000,
	MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_URI_FOUND 0.000000,
	NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
	OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000,
	__CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CTE 0.000000, __DKIM_ALIGNS_1 0.000000,
	__DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FROM_DOMAIN_IN_ANY_CC1 0.000000,
	__FROM_DOMAIN_IN_RCPT 0.000000, __FROM_NAME_NOT_IN_ADDR 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_X_MAILER 0.000000,
	__INVOICE_MULTILINGUAL 0.000000, __MIME_TEXT_ONLY 0.000000,
	__MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MULTIPLE_RCPTS_CC_X2 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
	__NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
	__OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
	__RCVD_PASS 0.000000, __SANE_MSGID 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
	__TO_NO_NAME 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
	__URI_NS 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2023.12.4.151216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=VM+Vw9ink97pjcckziS5p6odtjFhBVxca8LD+qMjFqg=;
	b=WESxdsOtdtqQQVIwlnmdmbmIZw9dLAPOj/RtfYOueAP1NpXCt/Fuq/rH1U3VkFybuRnLMSuzAtwXK+vySxp4JkETnn3FssfSytWSJBJ3JX4orwdT7vmSvXzVrdvZ7CW5mqCbVIs5EWZ88cHPXiP9UYYV29Q8OfL0/jtbRv6G34U=;
From: Daniel Danzberger <dd@embedd.com>
To: woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org,
	Daniel Danzberger <dd@embedd.com>
Subject: [PATCH] net: dsa: microchip: fix NULL pointer dereference on platform init
Date: Mon,  4 Dec 2023 16:43:15 +0100
Message-Id: <20231204154315.3906267-1-dd@embedd.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dd@embedd.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: dd@embedd.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1rAB3p-000E0u-GG
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <dd@embedd.com>)
	id 1rAB3p-000E0u-GG; Mon, 04 Dec 2023 16:40:41 +0100

Fixes a NULL pointer access when registering a switch device that has
not been defined via DTS.

This might happen when the switch is used on a platform like x86 that
doesn't use DTS and instantiates devices in platform specific init code.

Signed-off-by: Daniel Danzberger <dd@embedd.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 9545aed905f5..525e13d9e39c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1678,7 +1678,7 @@ static int ksz_check_device_id(struct ksz_device *dev)
 	dt_chip_data = of_device_get_match_data(dev->dev);
 
 	/* Check for Device Tree and Chip ID */
-	if (dt_chip_data->chip_id != dev->chip_id) {
+	if (dt_chip_data && dt_chip_data->chip_id != dev->chip_id) {
 		dev_err(dev->dev,
 			"Device tree specifies chip %s but found %s, please fix it!\n",
 			dt_chip_data->dev_name, dev->info->dev_name);
-- 
2.39.2


