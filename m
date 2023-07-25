Return-Path: <netdev+bounces-20754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D2760E84
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D562813DA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D5514ABD;
	Tue, 25 Jul 2023 09:22:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F51548D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:47 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8810D1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:22:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3176a439606so517096f8f.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690276964; x=1690881764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhYJtI4apXexoyUN398nhMyCR6OP+aq/F1jSuqvfnFU=;
        b=GRF2DXBuEsF3cK7ZUTDvtOcPDdf7zNKCPCrFFtS45LgRnA/H1HMQMNB1Trwig/hRIQ
         IRIOz/3iQ595vVz3/X1HV3zKcQTvl7A8tyagVx1sldcW1f9mGIhTXTrIkWuCiZqofy18
         JWERnQA51undhxXTxIxKIBMVuaN9+DtWOLscFNIXeZoACJana0d7A3K6FOmS/67e81rR
         C2av75iXZCaUjixSwx13nCwLv7oeDrIcV9bBl9grR+6RVRVGH6EbZ/5YF2QqyfTqFfhH
         /+F8efbRnfCJdqWTkJTqfpT54I2ugwErAmBcluWCAaNO3yxMXsL6GtnbGwNwrPUG2JjK
         H0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690276964; x=1690881764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhYJtI4apXexoyUN398nhMyCR6OP+aq/F1jSuqvfnFU=;
        b=Sn9n3Ur++7OX+XxUjS52w1JvcGJM6vomOnkzOVIn47MDaMgsteXbM75Bm9zr7f9q3w
         PmhgfFYX+RjR7ZE3/KOLy+qeUfxyVnyoqysIsTLKcamOIT+C2QbsxaIFO5e3GjOq24Gh
         MLTz6NmqkAHMqEADfF/6+/lkgB1xWUr9riA4NIPzJ+iZXwlotEeWWaCPXAP80IWlo5xa
         s3rCu9alzWZMeCseIc8aNP6XBaOcXCTZnLHH/WTQVm6lGu1Ks1408PF6yjh44owcL7km
         h7lIlbhkCTonCNEApSgv1hWkGujrmdlLA2ZWJKJa7cOBq6YBx3HYULXxC39024REaRzK
         Cfsw==
X-Gm-Message-State: ABy/qLYkyQbcMEtRrUDSGVpqwVV4nOu72XaA0o8SYhKqRSD48siUlJ2S
	JWLCtT5OSqHLhYFFiiIiDfOmzdPYYIM=
X-Google-Smtp-Source: APBJJlET9AykjQI5c/NTVOpTdincyZLdwg1Z/r78Tr3IFT/X6XtTWE+znn/wcvHSteGJv1m33PELiA==
X-Received: by 2002:a5d:4526:0:b0:317:630f:de0c with SMTP id j6-20020a5d4526000000b00317630fde0cmr2730691wra.44.1690276963928;
        Tue, 25 Jul 2023 02:22:43 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id q4-20020adfdfc4000000b0031134bcdacdsm15697970wrn.42.2023.07.25.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:22:43 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Nicolas Escande <nico.escande@gmail.com>
Subject: [iproute2] bridge: link: allow filtering on bridge name
Date: Tue, 25 Jul 2023 11:22:42 +0200
Message-ID: <20230725092242.3752387-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When using 'brige link show' we can either dump all links enslaved to any bridge
(called without arg ) or display a single link (called with dev arg).
However there is no way to dummp all links of a single bridge.

To do so, this adds new optional 'master XXX' arg to 'bridge link show' command.
usage: bridge link show master br0

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 bridge/link.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/bridge/link.c b/bridge/link.c
index b3542986..3581c50c 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -17,7 +17,8 @@
 #include "utils.h"
 #include "br_common.h"
 
-static unsigned int filter_index;
+static unsigned int filter_dev_index;
+static unsigned int filter_master_index;
 
 static const char *stp_states[] = {
 	[BR_STATE_DISABLED] = "disabled",
@@ -244,11 +245,15 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 	if (!(ifi->ifi_family == AF_BRIDGE || ifi->ifi_family == AF_UNSPEC))
 		return 0;
 
-	if (filter_index && filter_index != ifi->ifi_index)
+	if (filter_dev_index && filter_dev_index != ifi->ifi_index)
 		return 0;
 
 	parse_rtattr_flags(tb, IFLA_MAX, IFLA_RTA(ifi), len, NLA_F_NESTED);
 
+	if (filter_master_index && tb[IFLA_MASTER] &&
+		filter_master_index != rta_getattr_u32(tb[IFLA_MASTER]))
+		return 0;
+
 	name = get_ifname_rta(ifi->ifi_index, tb[IFLA_IFNAME]);
 	if (!name)
 		return -1;
@@ -312,7 +317,7 @@ static void usage(void)
 		"                               [ hwmode {vepa | veb} ]\n"
 		"                               [ backup_port DEVICE ] [ nobackup_port ]\n"
 		"                               [ self ] [ master ]\n"
-		"       bridge link show [dev DEV]\n");
+		"       bridge link show [dev DEV] [master DEVICE]\n");
 	exit(-1);
 }
 
@@ -607,6 +612,7 @@ static int brlink_modify(int argc, char **argv)
 static int brlink_show(int argc, char **argv)
 {
 	char *filter_dev = NULL;
+	char *filter_master = NULL;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -615,14 +621,25 @@ static int brlink_show(int argc, char **argv)
 				duparg("dev", *argv);
 			filter_dev = *argv;
 		}
+		if (strcmp(*argv, "master") == 0) {
+			NEXT_ARG();
+			if (filter_master)
+				duparg("master", *argv);
+			filter_master = *argv;
+		}
 		argc--; argv++;
 	}
 
 	if (filter_dev) {
-		filter_index = ll_name_to_index(filter_dev);
-		if (!filter_index)
+		filter_dev_index = ll_name_to_index(filter_dev);
+		if (!filter_dev_index)
 			return nodev(filter_dev);
 	}
+	if (filter_master) {
+		filter_master_index = ll_name_to_index(filter_master);
+		if (!filter_master_index)
+			return nodev(filter_master);
+	}
 
 	if (rtnl_linkdump_req(&rth, PF_BRIDGE) < 0) {
 		perror("Cannot send dump request");
-- 
2.41.0


