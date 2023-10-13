Return-Path: <netdev+bounces-40596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E9D7C7C8F
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 06:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D2C282CCD
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 04:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2801FD9;
	Fri, 13 Oct 2023 04:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNHRZ1QP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884B1C3C
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 04:23:28 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFE4BE;
	Thu, 12 Oct 2023 21:23:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c5c91bec75so13282195ad.3;
        Thu, 12 Oct 2023 21:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697171007; x=1697775807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgrJJGSoF6Q1a6fSDjSuymC/JdTZvEmvnPQt4mx+FO0=;
        b=HNHRZ1QPc0oPoFp8vmmtEWf/msLpxBnChlLawRcgLbwciVlS5JFLCmcFzWn59nTPYd
         +HKRYzbQfv2O9LTjdQeehGxcXFRp1ZPQnAFkgRPU+BJ1GfitwpW4TESLZP1gFpdEyoFT
         067E5HwFS8l2oVwK/EjtoPiClke0WSDrLF0vlmgNO6ckNgRhI7DERSOv8Atr5twvDVvV
         VO8LbwyeP134AKDf37L6RPdqhZgpLQwMI5N+H8jejv8pAqEhijFznLhR2eCp0U5Nrhh3
         K2vokO8x/kqEZHFjeuGovg9zlUonMz0EK0ow4qqZDhF4qmimOf+t53OUYBw3E//Dsg8j
         AivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697171007; x=1697775807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgrJJGSoF6Q1a6fSDjSuymC/JdTZvEmvnPQt4mx+FO0=;
        b=mOBxRNRbL8Imp+WdpjHgF6K7NSABkP+SYUh508OEJsCZZqRtxmn7C07qKV7wlIONFc
         dzJUUhY/TQBdexUYPOGoKh8zT0fUF8Td7mfrtj6rwQ/7WGKLG+I1QjNDD50xy5z6N6tY
         qhSdx4GTIp9pmr+73+MKyB/Aej2HFc3k/vja5j/HYE71SpNfscGTx6Ludaukfrc/PnBh
         AJSlSAImFzafAyuSKRTit994MndN2C2l9+LFxUfUC3eTLesX2Tyf4LuMgoqHJsvzp/6k
         jLl1K3IbgDoDoMJZb9USTS+q876F4PMd+D4nbOqYB5W3tBM+VcDmYyrby63g0KBKUedQ
         RoKg==
X-Gm-Message-State: AOJu0YwwhXlkUaEF8Jz4b0D8LyqvjIxGMd8RH522n5BhHW11r+M3TWVv
	flcEgGebZOqFgIwgXgXvi32dgg1eBKr1XA==
X-Google-Smtp-Source: AGHT+IEIazoL6I45lIn2nyAVQgyuJli758Z5lhoeNbnstJpTkASgj6TfDGFKp1BnI6j2inD3EYeSUA==
X-Received: by 2002:a17:902:c40d:b0:1c5:de06:9e5a with SMTP id k13-20020a170902c40d00b001c5de069e5amr26212576plk.21.1697171006908;
        Thu, 12 Oct 2023 21:23:26 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b001c3e732b8dbsm2802786pls.168.2023.10.12.21.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 21:23:26 -0700 (PDT)
From: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To: horms@kernel.org,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
Date: Fri, 13 Oct 2023 09:23:04 +0500
Message-Id: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

resolved typing mistake from devce to device

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

changes since v1:
	- resolved another typing mistake from concurent to
	  concurrent
---
 drivers/net/wwan/wwan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 87df60916960..72e01e550a16 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -302,7 +302,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
 
 static const struct {
 	const char * const name;	/* Port type name */
-	const char * const devsuf;	/* Port devce name suffix */
+	const char * const devsuf;	/* Port device name suffix */
 } wwan_port_types[WWAN_PORT_MAX + 1] = {
 	[WWAN_PORT_AT] = {
 		.name = "AT",
@@ -1184,7 +1184,7 @@ void wwan_unregister_ops(struct device *parent)
 	 */
 	put_device(&wwandev->dev);
 
-	rtnl_lock();	/* Prevent concurent netdev(s) creation/destroying */
+	rtnl_lock();	/* Prevent concurrent netdev(s) creation/destroying */
 
 	/* Remove all child netdev(s), using batch removing */
 	device_for_each_child(&wwandev->dev, &kill_list,
-- 
2.27.0


