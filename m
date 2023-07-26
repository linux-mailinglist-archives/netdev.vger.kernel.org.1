Return-Path: <netdev+bounces-21206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC04762D3D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E3D281BF7
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2018814;
	Wed, 26 Jul 2023 07:25:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C741363
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:25:18 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36152D79
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:25:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31768ce2e81so1888341f8f.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690356312; x=1690961112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrmEDQikBQq+tW+r9/wP5JrQrBA7ZLd8C0lzRAAjHRo=;
        b=AiD+g7Zk9X2OvcmrYRsHRp47RT3pIRSJLFpPnwwmsTgBGCyLp91xfScIcksCwxsf/+
         RRQR7Q1s1kJKtXT7G+SqkShVGicDuMA6/ZnruFb7iWB7glu7WfzEGvpdFmVOOse4gjes
         pItou7R+4k7gTivRG8AjB+OdgpEBy6XmL+EiZj2yOgDY+aVmyq/oCROUokfvq/3IQTJx
         11ijkZrpHaP2aGe1NsX/2qvncY1NNN/wXL7npHqRASVPaLObNF/cRUzZevwcrwYwsX0s
         8v2zGZRq+BqS1dU3No7BfRnrvZYu8bKZ0hjnSUeMLLM92oDJIYGgeaGDjWipo2V+oDaK
         qqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356312; x=1690961112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrmEDQikBQq+tW+r9/wP5JrQrBA7ZLd8C0lzRAAjHRo=;
        b=MrpdVZXkI68OK7OZWIkmSnp8jtCiaqmiK7hoRrVdnUBJlJ+tyvg4xYfBDRI5+puwX6
         i/LpoSvF0r0jOIs0np9WD5+7BxLlsS4gIFqKZ8PIPHMy68ngLIGov3iArPOrInqJLoHm
         OMBxYPacsBKz4oWbIEfFwUeyFollEgnLL4KzAndLyu4BWQXizNFvLUAxJ3P1bpmx9hEw
         YpXXzrSv6CepfAryTG7IXgUWJVv24ZE4NZ9jp2CnYabWO+aF8bmVCV4wQEf2fVShy6r5
         vgmzV2HERDONV6P/K08GlKje/A/u90tOk10J6Efg0VAiFze3GnpE22PhJxJ30wDCISDm
         SiJg==
X-Gm-Message-State: ABy/qLYfYKZnaUEeYc01FpmnEIR6rQTWccFCbMYn40w63nKtYg/Dm3iU
	04i0PwR+RCnZtKoco0hUMqEqL2PyaMM=
X-Google-Smtp-Source: APBJJlHZXsbfQx0XH4QaS+wy+rcVdgLR1vfLL/s48QR9rLc1skDHDtX7l48Ekmyu/oBSBbq5DQ/RJw==
X-Received: by 2002:a5d:40c5:0:b0:313:e8b6:1699 with SMTP id b5-20020a5d40c5000000b00313e8b61699mr812310wrq.55.1690356311649;
        Wed, 26 Jul 2023 00:25:11 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d61c4000000b00316eb7770b8sm13460826wrv.5.2023.07.26.00.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:25:11 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Nicolas Escande <nico.escande@gmail.com>
Subject: [iproute2,v2] bridge: link: allow filtering on bridge name
Date: Wed, 26 Jul 2023 09:25:07 +0200
Message-ID: <20230726072507.4104996-1-nico.escande@gmail.com>
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
index b3542986..af0457b6 100644
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
+	    filter_master_index != rta_getattr_u32(tb[IFLA_MASTER]))
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


