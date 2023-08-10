Return-Path: <netdev+bounces-26374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA01777A0C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548DD1C215BF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC041F951;
	Thu, 10 Aug 2023 14:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2F1E1AC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:01:12 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE332127
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:01:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so7948595e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691676064; x=1692280864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pR7JxSyd5wLo1VYcQB3f1hEhXIONeOZ8SB138/rZQQ=;
        b=NfDJ8ojaaOzjSGYNGR+FqlggZ5XfQwb8agxPod3RprIPTV/fdLHUyE0FW0mF10NM9Y
         AgVf704ToIZuMQcwSqri+cizyeT4HM1vXGKK1F5Sk/yXrOqTCURvKpK2925+CIGftQBf
         0nVF1DQ0wgI4Y5A0nqGvQw97wQ6QefJNRB4nHiFi/0tCSilOztH/HBrH9K0Q+Jzv/d6L
         d1SlGCHTgGhD3BpgwbbU0XmB9yPLNaloZ0EKf9hTS74mYhQh/SrgUq98b5vyzL60lkBz
         ozv8vQCV59bVAN05S32QYCulxP6FIkrTuwZjW7r/CM7J6E6M6lI69R27yrRnP4ciapC4
         p8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676064; x=1692280864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pR7JxSyd5wLo1VYcQB3f1hEhXIONeOZ8SB138/rZQQ=;
        b=DQrUKRQsXZuFqpqrPO8ruAzN8L35o9FuNOkjWXx5hSjah9yyDvt/4f76jOsWnX1fNO
         vyZuC3TyJQgJqAoaBG/DxOE0jF0X/G6ClfjBmNkd8eF8N0mJulYUxWy9rV7tDxDRGhFf
         1rJ+uZ0aKonXusGHXAHwCqrzRCbCpAv66bLm1kKcwF7h+UqVLM6B0LbiRC0gIDvETNBn
         M/NeFU10jm1wul6PncZVwg3NNtQ6Fp9+3FmaJG6ueSvP9Bl+VQ111Dik3lcjdVRjQ2fZ
         Xe9APMTNqb1aIGjz4WusV5lH81DdMC215rk0it8Z5tcw2meZR4wvlxnBwqVaBbTJyElV
         qlsg==
X-Gm-Message-State: AOJu0YysLgfWaoTSMxvnArbddgkDMQIyBfe7IN8qspjXLyWMWph7KRgo
	/I5zJz5dz4ABvolI+3J6fm8PfAPSv07fbmOjRQalIQ==
X-Google-Smtp-Source: AGHT+IG7We/x9/vhuDnuvaP7SVD6Mby5+hjf7Si4HSMkeGEz1Y0/xI3uOMGd1e8RLcXjpVgrVIpDYw==
X-Received: by 2002:a1c:741a:0:b0:3fc:a8:dc3c with SMTP id p26-20020a1c741a000000b003fc00a8dc3cmr2038081wmc.37.1691676064229;
        Thu, 10 Aug 2023 07:01:04 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a1ccc12000000b003fbd9e390e1sm5183743wmb.47.2023.08.10.07.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:01:03 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	idosch@nvidia.com
Subject: [patch iproute2-next] devlink: accept "name" command line option instead of "trap"/"group"
Date: Thu, 10 Aug 2023 16:01:02 +0200
Message-ID: <20230810140102.1604684-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
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

It is common for all iproute2 apps to have command line option
names matching with show command outputs. However, that is not true
in case of trap and trap group devlink objects.

Correct would be to have "trap" and "group" in the outputs, but that is
not possible to change now. Instead of that, accept "name" instead of
"trap" and "group" options.

Examples:

$ devlink trap show netdevsim/netdevsim1
netdevsim/netdevsim1:
  name source_mac_is_multicast type drop generic true action drop group l2_drops
  name vlan_tag_mismatch type drop generic true action drop group l2_drops
  name ingress_vlan_filter type drop generic true action drop group l2_drops
  name ingress_spanning_tree_filter type drop generic true action drop group l2_drops
  name port_list_is_empty type drop generic true action drop group l2_drops
  name port_loopback_filter type drop generic true action drop group l2_drops
  name fid_miss type exception generic false action trap group l2_drops
  name blackhole_route type drop generic true action drop group l3_drops
  name ttl_value_is_too_small type exception generic true action trap group l3_exceptions
  name tail_drop type drop generic true action drop group buffer_drops
  name ingress_flow_action_drop type drop generic true action drop group acl_drops
  name egress_flow_action_drop type drop generic true action drop group acl_drops
  name igmp_query type control generic true action mirror group mc_snooping
  name igmp_v1_report type control generic true action trap group mc_snooping
$ devlink trap show netdevsim/netdevsim1 trap source_mac_is_multicast
netdevsim/netdevsim1:
  name source_mac_is_multicast type drop generic true action drop group l2_drops
$ devlink trap show netdevsim/netdevsim1 name source_mac_is_multicast
netdevsim/netdevsim1:
  name source_mac_is_multicast type drop generic true action drop group l2_drops

$ devlink trap group
netdevsim/netdevsim1:
  name l2_drops generic true
  name l3_drops generic true policer 1
  name l3_exceptions generic true policer 1
  name buffer_drops generic true policer 2
  name acl_drops generic true policer 3
  name mc_snooping generic true policer 3
$ devlink trap group show netdevsim/netdevsim1 group l2_drops
netdevsim/netdevsim1:
  name l2_drops generic true
$ devlink trap group show netdevsim/netdevsim1 name l2_drops
  name l2_drops generic true

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 26513142f900..fe69f53cd2e1 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2018,14 +2018,16 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (err)
 				return err;
 			o_found |= DL_OPT_HEALTH_REPORTER_AUTO_DUMP;
-		} else if (dl_argv_match(dl, "trap") &&
+		} else if ((dl_argv_match(dl, "trap") ||
+			    dl_argv_match(dl, "name")) &&
 			   (o_all & DL_OPT_TRAP_NAME)) {
 			dl_arg_inc(dl);
 			err = dl_argv_str(dl, &opts->trap_name);
 			if (err)
 				return err;
 			o_found |= DL_OPT_TRAP_NAME;
-		} else if (dl_argv_match(dl, "group") &&
+		} else if ((dl_argv_match(dl, "group") ||
+			    dl_argv_match(dl, "name")) &&
 			   (o_all & DL_OPT_TRAP_GROUP_NAME)) {
 			dl_arg_inc(dl);
 			err = dl_argv_str(dl, &opts->trap_group_name);
-- 
2.41.0


