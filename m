Return-Path: <netdev+bounces-25578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA33774D3E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6651C20F7F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2498174CE;
	Tue,  8 Aug 2023 21:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563B174C4
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:44:36 +0000 (UTC)
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 14:44:32 PDT
Received: from authsmtp.register.it (authsmtp40.register.it [81.88.55.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0A196
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:44:32 -0700 (PDT)
Received: from localhost.localdomain ([213.230.62.249])
	by cmsmtp with ESMTPSA
	id TUUDqYXukCJCaTUUDqEu4j; Tue, 08 Aug 2023 23:43:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schroetersa.ch;
	s=key_mmumrc8kf9; t=1691531010;
	bh=kq80xGxH8d+kQYHmp4G8gY23FD7LmZhfznJZdss4Mh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yPoWxjBk4ZI22Z4Wz5XRutdyTEl59N3DmowYFD8lduzUNRQNqEld/ZHV0H7Ab2zqU
	 NrDw28UT1LiExynmfUwlmSKFMCKfssfkFHNawztEWu7rNsPdHhyiJ11Pz7KPb7ifGq
	 tP6k8RGlwk/pCIUGy+22fWei8iJkKfL6b0ODFCPakjnYQ+8gCLYrTSLH6qhVlDcOut
	 I8yNMs+JJuvy4L2kJchM6kDE/rSyMAOE5b0n8FuhbcmuCSdcZFqUtc3oET43BY07q7
	 6CVuV1VWu3nT9X0mkPDLZwr81wp0psbazrivaXwa0Nz59nQUyHtmJPvWxknbUPfY0N
	 oMByQ991Fa+Hg==
X-Rid: mathieu@schroetersa.ch@213.230.62.249
From: Mathieu Schroeter <mathieu@schroetersa.ch>
To: netdev@vger.kernel.org
Cc: Mathieu Schroeter <mathieu@schroetersa.ch>
Subject: [PATCH iproute2-next 2/4] Add utility to convert an unsigned int to string
Date: Tue,  8 Aug 2023 23:42:56 +0200
Message-Id: <20230808214258.975440-2-mathieu@schroetersa.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808214258.975440-1-mathieu@schroetersa.ch>
References: <20230808214258.975440-1-mathieu@schroetersa.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLt7SBoWUeaf3xVaYQb4iEtj++3AhAg0eXHa0B6Hau3WZ783Y67BQeMaSPhjG427t+7abRj05edwBeIGBrdZ4gU5fkZ32GjbZdkoZE5y3H/79EXmIQMK
 0z4lfkOeF81TettWceUuo0CrzIYoJCrPcl/j5G6j2ULz/ca/mcz2rENYIniS0+myFt5iJ2CiIucSIOKihvsXtEzimfFdPQTjgwUUdgjL43PBuGQ04TyhDCVX
 j3SwWad1V/EySEyVtN6xNg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Mathieu Schroeter <mathieu@schroetersa.ch>
---
 include/utils.h | 1 +
 lib/utils.c     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/utils.h b/include/utils.h
index cf11174d..f26ed822 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -309,6 +309,7 @@ unsigned int print_name_and_link(const char *fmt,
 extern int cmdlineno;
 
 char *int_to_str(int val, char *buf);
+char *uint_to_str(unsigned int val, char *buf);
 int get_guid(__u64 *guid, const char *arg);
 int get_real_family(int rtm_type, int rtm_family);
 
diff --git a/lib/utils.c b/lib/utils.c
index 68f44303..efa01668 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1409,6 +1409,12 @@ char *int_to_str(int val, char *buf)
 	return buf;
 }
 
+char *uint_to_str(unsigned int val, char *buf)
+{
+	sprintf(buf, "%u", val);
+	return buf;
+}
+
 int get_guid(__u64 *guid, const char *arg)
 {
 	unsigned long tmp;
-- 
2.39.2


