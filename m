Return-Path: <netdev+bounces-26863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3A7793B5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B96282390
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A8E34CC5;
	Fri, 11 Aug 2023 15:57:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE132AB52
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:40 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8430D5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso20790375e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769458; x=1692374258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hybXy0d1VAuj058NVlhZBUJGwNhBqfvisEr5ospEmtw=;
        b=xWfuYBK6b8YF+uAISVP+9kKeBheyfBZn656FvleBC75lZlkxRGf+xdgxTNKy6EmXTL
         NKaOJ4kQ/kit23RZuOQ30lftMWbILocDAH0OXpOahj0mqnV6c8tuIyGD3Jfbcjj24EW1
         gMLbNHgW5m3cSKNmM7kUR+LvwFOxZAsY9w5RtTzAE+4YHnHVuw1LNFalNYkc6hVzNlB+
         Y1ksQEe+9NewhCqaIPxLHeG0kgHdfwJfQfOBPJzYx9PQnMeD06Uha9Pis5gsPbiZYTce
         q7BvDRDv7B/bWMplCxqrXsBtMBxa+e/HTFqNmzHgfZ25TowqMl1Ryt2LAVcJjRXG5Ux9
         GaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769458; x=1692374258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hybXy0d1VAuj058NVlhZBUJGwNhBqfvisEr5ospEmtw=;
        b=BiqsBr+PUib2+mGKcFnf0jRfWZnjQ6jD3IFKBk1KmX9FsJEJ9ooSgNowLZh/vzYbEE
         v3HkbZX1ha7Yprsnew4DdPC7GOyhuWXNs4bw57jmbvPqUDIdt0dldWU1d7bVubfxVJ+h
         jizfYuvwyi2HXfYbVN8vqXCQRJKzMMUHgP+Kxjkwi14hwy7RxFcIQ2HhSP6fJJChTKlb
         yGUQHPUWUE6Hv7SWfgsYjQzMkynP2RrMUhpNR+wET/DlX39frck3DIfQO2wfZ1ARjOfj
         D73UfQNYI1FW3nPaOxQjWMEuzGMebJGm8smwGtY9IByUPzYhWsgCeq0pmrtKXa49NSfA
         vTtQ==
X-Gm-Message-State: AOJu0Ywwt2FrqKbkdzYlWsCW2iQhnGRDHblGBuN/jnPv7QaOOEm63RUb
	PVr4XNwGbvyZCg6ZUBV1hQ1he8oTs9rsdKVtaIArtQ==
X-Google-Smtp-Source: AGHT+IGjvvTPzR65EovVmaE7mKe08D6MHYMrLObq5v9CQ08CgNQF237pwBXITgqIJ+PvP8NsnNJYaQ==
X-Received: by 2002:a7b:cd07:0:b0:3fe:1bef:4034 with SMTP id f7-20020a7bcd07000000b003fe1bef4034mr2040947wmj.37.1691769457714;
        Fri, 11 Aug 2023 08:57:37 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c220100b003fc01f7b415sm8474313wml.39.2023.08.11.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:37 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v4 12/13] devlink: extend health reporter dump selector by port index
Date: Fri, 11 Aug 2023 17:57:13 +0200
Message-ID: <20230811155714.1736405-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811155714.1736405-1-jiri@resnulli.us>
References: <20230811155714.1736405-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Introduce a possibility for devlink object to expose attributes it
supports for selection of dumped objects.

Use this by health reporter to indicate it supports port index based
selection of dump objects. Implement this selection mechanism in
devlink_nl_cmd_health_reporter_get_dump_one()

Example:
$ devlink health
pci/0000:08:00.0:
  reporter fw
    state healthy error 0 recover 0 auto_dump true
  reporter fw_fatal
    state healthy error 0 recover 0 grace_period 60000 auto_recover true auto_dump true
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32768:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32769:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32770:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.1:
  reporter fw
    state healthy error 0 recover 0 auto_dump true
  reporter fw_fatal
    state healthy error 0 recover 0 grace_period 60000 auto_recover true auto_dump true
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.1/98304:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.1/98305:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.1/98306:
  reporter vnic
    state healthy error 0 recover 0

$ devlink health show pci/0000:08:00.0
pci/0000:08:00.0:
  reporter fw
    state healthy error 0 recover 0 auto_dump true
  reporter fw_fatal
    state healthy error 0 recover 0 grace_period 60000 auto_recover true auto_dump true
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32768:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32769:
  reporter vnic
    state healthy error 0 recover 0
pci/0000:08:00.0/32770:
  reporter vnic
    state healthy error 0 recover 0

$ devlink health show pci/0000:08:00.0/32768
pci/0000:08:00.0/32768:
  reporter vnic
    state healthy error 0 recover 0

The last command is possible because of this patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- fixed NLM_F_DUMP_FILTERED setting
v2->v3:
- rebased on top of generated split ops and policies
- rebased on top of selector attr removal
---
 net/devlink/health.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index b9b3e68d9043..a85bdec34801 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -390,12 +390,23 @@ static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
 						   int flags)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_health_reporter *reporter;
+	unsigned long port_index_end = ULONG_MAX;
+	struct nlattr **attrs = info->attrs;
+	unsigned long port_index_start = 0;
 	struct devlink_port *port;
 	unsigned long port_index;
 	int idx = 0;
 	int err;
 
+	if (attrs && attrs[DEVLINK_ATTR_PORT_INDEX]) {
+		port_index_start = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
+		port_index_end = port_index_start;
+		flags |= NLM_F_DUMP_FILTERED;
+		goto per_port_dump;
+	}
+
 	list_for_each_entry(reporter, &devlink->reporter_list, list) {
 		if (idx < state->idx) {
 			idx++;
@@ -412,7 +423,9 @@ static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
 		}
 		idx++;
 	}
-	xa_for_each(&devlink->ports, port_index, port) {
+per_port_dump:
+	xa_for_each_range(&devlink->ports, port_index, port,
+			  port_index_start, port_index_end) {
 		list_for_each_entry(reporter, &port->reporter_list, list) {
 			if (idx < state->idx) {
 				idx++;
-- 
2.41.0


