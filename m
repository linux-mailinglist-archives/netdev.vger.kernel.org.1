Return-Path: <netdev+bounces-26356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8AA77796E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD81D1C214DF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB120C8F;
	Thu, 10 Aug 2023 13:16:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF320C8D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:16:05 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE95310E6
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31792ac0fefso818796f8f.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673362; x=1692278162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlCQm1yoAb/1GMfSfv1BB1xQoZ0L6Gl/DdD4/lUj+do=;
        b=jhkzVCmpQ8sjstvsbAGs/HNVJQ4Whp273w96sFfTMFvQ5VCwXc6gpe8jmcDMcIx9pL
         Fhsg4EZ5gZW/t5uzxtDy4NqnsH4k9E/ZIUqbcuUDU6/+U9PyCrtzAwek20equq5UrTHW
         jEjXwA6FuQDi+uLO7f/o0u4Z2FehWy5rcsekI6oqj2GdtdHzouZOvB9oMYDNF63H0J3k
         B85nsafg5t50B79oLFy5cIlujR+HIzeRwPNDjBtrTgbzQTOEeqR31AaKAy6ueGz036mE
         S50BjCRt0gg7Pu3MNk+GvQcTbTEmkKAX3uoTH0IEPLh0ujR/KSq1m7zMgJlovzGQB9qv
         rBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673362; x=1692278162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlCQm1yoAb/1GMfSfv1BB1xQoZ0L6Gl/DdD4/lUj+do=;
        b=Nsfu9aMJoPpA+k/STqP+WMvpkICwOCvwO7/A+xwe4gn7mggehS9tobxYDeL8wZi818
         gJoZgaJNGdiyk06ot1e89dpb/PZm8FIk2ym/qDTwN9y7EzuSZszUKlSeHflGOZNybROz
         OcA+63BAVYNL5YBGcHG0ud4O6xI1EoF8xSHEYyNnKBGqt2eBim21KrpOydRW3DQFMakd
         g9VncCxUL5ILCDUS+vmQPQjtIAmVfZo3zlBPnqB8vmwsCu1ujAnzmW3dTcWXU6iKf4jC
         6k4/fNpG0Dt2MDXN1x3HVD9D3w5O7QXst0PeqVqZq3lojaVtsuMDz7Q9Pi/NsnGZWaOc
         2Xnw==
X-Gm-Message-State: AOJu0YxnZXAx7JwHaKfFxgwUtFBNzryNmps5rq6kLKgSwG7d1e2rqCve
	0uDYchB5l+WdoLz53lgiQvpqGMl+Qpf919VdQ6xp6w==
X-Google-Smtp-Source: AGHT+IFX4AIxnj/mQAUAmPwXiZRT/k+Ny6lQ6As4OfGIHjcQ//viANtcf1Fw+GEvsABL5YtsTgMtSw==
X-Received: by 2002:adf:f70d:0:b0:313:e953:65d0 with SMTP id r13-20020adff70d000000b00313e95365d0mr2045527wrp.28.1691673362347;
        Thu, 10 Aug 2023 06:16:02 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q11-20020adff94b000000b00317c742ca9asm2124708wrr.43.2023.08.10.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:16:01 -0700 (PDT)
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
Subject: [patch net-next v3 12/13] devlink: extend health reporter dump selector by port index
Date: Thu, 10 Aug 2023 15:15:38 +0200
Message-ID: <20230810131539.1602299-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810131539.1602299-1-jiri@resnulli.us>
References: <20230810131539.1602299-1-jiri@resnulli.us>
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
v2->v3:
- rebased on top of generated split ops and policies
- rebased on top of selector attr removal
---
 net/devlink/health.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index b9b3e68d9043..a038bd126b70 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -390,12 +390,22 @@ static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
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
+		goto per_port_dump;
+	}
+
 	list_for_each_entry(reporter, &devlink->reporter_list, list) {
 		if (idx < state->idx) {
 			idx++;
@@ -412,7 +422,9 @@ static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
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


