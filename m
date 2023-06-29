Return-Path: <netdev+bounces-14661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98562742DE6
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DBB1C204F6
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400414AB3;
	Thu, 29 Jun 2023 19:57:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414A14298
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:57:53 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9ED30EE
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:57:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e011f45ffso119459966b.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688068669; x=1690660669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T0XkjhHzkhxu75WseH55j4BVqaCsCyE2UEVh4FAZMq0=;
        b=CTvJZqI1Dwdpg/tnGpKsTzpneynUdZ96feKAykzeRl80scNrkoLFWkhJb3FeLv4OxY
         tIkSneQlJTya7FgP67vau9dbU+dVCfQVekhHvypNEUQFqrqmtoq+0yFhLVWfrt96fc+i
         eOGheUKBu9yINWDzGXxqnIORENoV/0K/EJelWPS1tT8XS04RlXsJ4F7G25Xn8MqgSwpT
         AWyjfxHjUCcJlkt4i27SxC/N0okUSZI/rW3aKYcli6Yv/9+LUW/tdntTPYA7oivMgO5p
         Jq0iNCaRmKZFDSxn/ZFqdj5lJP3hHh3dhawx9iPgXwIzJkwmYyCx2lSW/1QK+smvWmmZ
         gC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068669; x=1690660669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0XkjhHzkhxu75WseH55j4BVqaCsCyE2UEVh4FAZMq0=;
        b=NFb+30jjUrXBoJcKoXj63yybS8iDIxgYIUO33A0S7JGiyW23JtPBAZsvwFV0nU9IZD
         Ft+jftF1Bl/yoRs/3pn3vrVlB/aN/koD9YNY14GD5OHxCvlH8lElfE7gN6tBYIIXcddR
         T8fLLEiXVr2IU3mirwg+vMKHCNSzyabzjpGK0OxNcs8SgeD6Ca8XBhIe4TTDosqj2qt7
         KPT6m9jTSVC9DtLhy2gK2mB524je3ehab6XkMcghKC/EKE5GIHB49RwdP1pp/BzPCTNj
         ZbplYoYlfG2BtiglrHUhu2W8m+VsE1aNnYrc928FVHWKyHAkWAtNZbuR2YxamNJ1nyY5
         xzMA==
X-Gm-Message-State: AC+VfDySDvnuCR5jCJvbi77PIYHgCi2tvR41TR51AaA5uhGo8TnPDCVU
	hSX3CycYh4wUX915G+R/5BzpPdYdAvOMoQ==
X-Google-Smtp-Source: APBJJlH51k4XmcC0DNNNrUMdzVpKTe39SvSTPyqTfU51E5eHtWW9h9kbwmDjIs4urxndmJcD/wAPGg==
X-Received: by 2002:a17:906:8699:b0:973:d06d:545f with SMTP id g25-20020a170906869900b00973d06d545fmr328889ejx.24.1688068668668;
        Thu, 29 Jun 2023 12:57:48 -0700 (PDT)
Received: from localhost.localdomain (p200300c1c74c0400ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c74c:400:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906830800b00977eec7b7e8sm7153010ejx.68.2023.06.29.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:57:47 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org,
	hmehrtens@maxlinear.com,
	aleksander.lobakin@intel.com,
	simon.horman@corigine.com,
	idosch@idosch.org,
	Zahari Doychev <zdoychev@maxlinear.com>
Subject: [PATCH iproute2-next] f_flower: simplify cfm dump function
Date: Thu, 29 Jun 2023 21:57:36 +0200
Message-ID: <20230629195736.675018-1-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Zahari Doychev <zdoychev@maxlinear.com>

The standard print function can be used to print the cfm attributes in
both standard and json use cases. In this way no string buffer is needed
which simplifies the code.

Signed-off-by: Zahari Doychev <zdoychev@maxlinear.com>
---
 tc/f_flower.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tc/f_flower.c b/tc/f_flower.c
index 6da5028a..c71394f7 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -2816,9 +2816,6 @@ static void flower_print_arp_op(const char *name,
 static void flower_print_cfm(struct rtattr *attr)
 {
 	struct rtattr *tb[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];
-	struct rtattr *v;
-	SPRINT_BUF(out);
-	size_t sz = 0;
 
 	if (!attr || !(attr->rta_type & NLA_F_NESTED))
 		return;
@@ -2830,20 +2827,15 @@ static void flower_print_cfm(struct rtattr *attr)
 	print_string(PRINT_FP, NULL, "  cfm", NULL);
 	open_json_object("cfm");
 
-	v = tb[TCA_FLOWER_KEY_CFM_MD_LEVEL];
-	if (v) {
-		sz += sprintf(out, " mdl %u", rta_getattr_u8(v));
-		print_hhu(PRINT_JSON, "mdl", NULL, rta_getattr_u8(v));
-	}
+	if (tb[TCA_FLOWER_KEY_CFM_MD_LEVEL])
+		print_hhu(PRINT_ANY, "mdl", " mdl %u",
+			  rta_getattr_u8(tb[TCA_FLOWER_KEY_CFM_MD_LEVEL]));
 
-	v = tb[TCA_FLOWER_KEY_CFM_OPCODE];
-	if (v) {
-		sprintf(out + sz, " op %u", rta_getattr_u8(v));
-		print_hhu(PRINT_JSON, "op", NULL, rta_getattr_u8(v));
-	}
+	if (tb[TCA_FLOWER_KEY_CFM_OPCODE])
+		print_hhu(PRINT_ANY, "op", " op %u",
+			  rta_getattr_u8(tb[TCA_FLOWER_KEY_CFM_OPCODE]));
 
 	close_json_object();
-	print_string(PRINT_FP, "cfm", "%s", out);
 }
 
 static int flower_print_opt(struct filter_util *qu, FILE *f,
-- 
2.41.0


