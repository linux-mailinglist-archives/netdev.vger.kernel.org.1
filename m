Return-Path: <netdev+bounces-34533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4DF7A47AD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8FE281D08
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE691C69D;
	Mon, 18 Sep 2023 10:54:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B318E31
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:54:54 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48007103
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso570101866b.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695034464; x=1695639264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCJBECLpFEzbWQFVcPazQjZw8/sVT/dSGgBqqUOQozM=;
        b=F8nq0XgbV8g8glfiu7XFyYVKn7zjNK+ZPP2FikicnK1mAvKl0FNO3QJwb0RHbefTxW
         FWyF2ntDE6du0NgdCF2adr4PrfdbLT3Pvrz8AS3b7Nxd+7PEDPyPNYTYvgMc/j1cBMUK
         ueK3kxdD35dSdnmPGOeI8aeLDvr0SQ1jh4EZhHC3dCzsW4u88RZk9C5cUFykNfef/idt
         t1SkKP021GVeDhWKUIjLgsJsRXsd7zFQIbvcD1+wPKPPP3zP9fgP/bALwqNvficBf1+D
         LeUu7zWQdkDNfUXJitA4d1xvAittDhkGA0SiHVsLcD6qo0IgJRHH8cbyrBVk6t2WgwgC
         kYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034465; x=1695639265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCJBECLpFEzbWQFVcPazQjZw8/sVT/dSGgBqqUOQozM=;
        b=WBmELus479H4/xQ3+YqJOyXyurzq6VtNDs3OSGALaBUNSlA3Sx9WeGTj+KgSlHy4FN
         U+a3+YdNidXPUz2qUiwTrHxgIYYMfa1Csa99rd6ohd/eSLWc8LV9JHxxlLOqQJqh1kDG
         XdiHUcqOHMA1CvOul9HN/nlSucSTw3ZaLTxXQSDVfgYUwNRkNhZFPrvv/xVtzBAiOflE
         4A8PtzsbuCpE0vztkl8540xTh0c4IUahRlQ/d0HmHWBDr/h2zRiDb5gZs/1/nXoIlZou
         TRe9HGolvJaigUKXw3f+WSt2WJtFxRYvyuNuZaM2IqWtxqSQxbwTDO9k0cgp/WrnUXKE
         z6ZQ==
X-Gm-Message-State: AOJu0Yy83oB9HIiaOGvo/lz4Yw2FUjECR8H0UzrwyBSbI0L0qBnpNgVA
	hpkLhdT+CbSdjmtH718Ldio+OIE/nLF2iC2v8zE=
X-Google-Smtp-Source: AGHT+IGLIZqFeSZ9y5y5qe1jxRaaMamIMBxFFw12QTywncg/BYdqK7SBec9/YFH4ShYLKUETsKLmjQ==
X-Received: by 2002:a17:906:105c:b0:9a3:c4f4:12de with SMTP id j28-20020a170906105c00b009a3c4f412demr7206375ejj.37.1695034464664;
        Mon, 18 Sep 2023 03:54:24 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906829800b009ae0042e48bsm2169552ejx.5.2023.09.18.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:54:24 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 4/4] devlink: print nested devlink handle for devlink dev
Date: Mon, 18 Sep 2023 12:54:16 +0200
Message-ID: <20230918105416.1107260-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918105416.1107260-1-jiri@resnulli.us>
References: <20230918105416.1107260-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Devlink dev may contain one or more nested devlink instances. If one is
present, print it out simple. If more are present (there is no
such case in current kernel, but may be in theory in the future),
print them in array.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 8ea7b268c63c..a387da0f4995 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3889,13 +3889,50 @@ static void pr_out_reload_data(struct dl *dl, struct nlattr **tb)
 	pr_out_object_end(dl);
 }
 
+static void pr_out_dev_nested(struct dl *dl, const struct nlmsghdr *nlh)
+{
+	struct nlattr *attr, *attr2;
+	int count = 0;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		if (mnl_attr_get_type(attr) == DEVLINK_ATTR_NESTED_DEVLINK) {
+			count++;
+			attr2 = attr;
+		}
+	}
+	if (!count) {
+		return;
+	} else if (count == 1) {
+		pr_out_nested_handle(attr2);
+		return;
+	}
+
+	pr_out_array_start(dl, "nested_devlinks");
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		if (mnl_attr_get_type(attr) == DEVLINK_ATTR_NESTED_DEVLINK) {
+			check_indent_newline(dl);
+			if (dl->json_output)
+				open_json_object(NULL);
+			check_indent_newline(dl);
+			pr_out_nested_handle(attr);
+			if (dl->json_output)
+				close_json_object();
+			else
+				__pr_out_newline();
+		}
+	}
+	pr_out_array_end(dl);
+}
 
-static void pr_out_dev(struct dl *dl, struct nlattr **tb)
+static void pr_out_dev(struct dl *dl, const struct nlmsghdr *nlh,
+		       struct nlattr **tb)
 {
 	if ((tb[DEVLINK_ATTR_RELOAD_FAILED] && mnl_attr_get_u8(tb[DEVLINK_ATTR_RELOAD_FAILED])) ||
-	    (tb[DEVLINK_ATTR_DEV_STATS] && dl->stats)) {
+	    (tb[DEVLINK_ATTR_DEV_STATS] && dl->stats) ||
+	     tb[DEVLINK_ATTR_NESTED_DEVLINK]) {
 		__pr_out_handle_start(dl, tb, true, false);
 		pr_out_reload_data(dl, tb);
+		pr_out_dev_nested(dl, nlh);
 		pr_out_handle_end(dl);
 	} else {
 		pr_out_handle(dl, tb);
@@ -3912,7 +3949,7 @@ static int cmd_dev_show_cb(const struct nlmsghdr *nlh, void *data)
 	if (!tb[DEVLINK_ATTR_BUS_NAME] || !tb[DEVLINK_ATTR_DEV_NAME])
 		return MNL_CB_ERROR;
 
-	pr_out_dev(dl, tb);
+	pr_out_dev(dl, nlh, tb);
 	return MNL_CB_OK;
 }
 
@@ -6828,7 +6865,7 @@ static int cmd_mon_show_cb(const struct nlmsghdr *nlh, void *data)
 			return MNL_CB_ERROR;
 		pr_out_mon_header(genl->cmd);
 		dl->stats = true;
-		pr_out_dev(dl, tb);
+		pr_out_dev(dl, nlh, tb);
 		pr_out_mon_footer();
 		break;
 	case DEVLINK_CMD_PORT_GET: /* fall through */
-- 
2.41.0


