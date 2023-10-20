Return-Path: <netdev+bounces-42939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C4F7D0B7D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8142824BB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD912E56;
	Fri, 20 Oct 2023 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gA+KrdFG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C412E52
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:22:00 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DE26AE
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98377c5d53eso93050566b.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697793695; x=1698398495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ziq3GIN9G3gkYphOjQYNZfoJbbuUQBt/lpMfUEh2/Qw=;
        b=gA+KrdFGE/ZadGfaTPHlLsLW2IJcrj8ZLCbKLLWwEgHM5TRlcVBqT6CV1yO4XWrSNc
         NWO9lYRCLLBR8Jt0c2JWoD8iMtE2WAsAwc3dhp3G6Y1osJQJWayVMFRB2lICTuNSha7U
         QuZRc0NivSVXP9bSRn2V5S8uD31lB3jsq09Xjld4eFX+GiSNNdaU9l+XFfu60NdzZRsv
         wgVLdpTRSJTmM82zPpsIBMChHG4bbHTm43aZibZdjUq3D05Ci9q8HIKT54ZF5C/clE2i
         nBLzI2WWnV9/IY1iT4JAwHA7TAbapovMRl4d9P0DoLJw0Q66pllG03EGdIU4yPVCaLoT
         ntCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793695; x=1698398495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ziq3GIN9G3gkYphOjQYNZfoJbbuUQBt/lpMfUEh2/Qw=;
        b=YknNBEcEntbNIT4LbJHEsCs0CFFlB3XzJCYMqbkbmcKGWXVu73rEi/Oklo9YbeuGiM
         nQTw6TdEPUOBmm2dHKLmwzvStsl/VXZQVus1QC4ynL+xehz3M01IgAQoJp7rCvVaGer+
         54DzZunCTqa71UEu7fXxep+v0I6cyblkuYHlnuDcJmoRwRmPDFT+UYW6yzH1T19QIIJc
         rvgCIEIPO59lfpPxBxFWC3x80ubISRbALMIUrXIZCePRCKuZeoeLAu0DewaNG1RATtpw
         nzNzPwK6EVLUkCqjrE0TcXvFeGMRfaIL3vdDS61KgNZViJRdqNwhUeVhpPBPko3LLPl7
         Lcig==
X-Gm-Message-State: AOJu0YyQHkbK2IJ/q2aqI9MXTXDKExJzP6HcSGxz2VztyC13CvQy3RRV
	e/DlZHmNGDCxiAxkvcSpewkRplH+Q9zHOOjO8Og=
X-Google-Smtp-Source: AGHT+IG0H2qXQ6uUFVvcq5++yx1uB0XFK9m9gvO7PAcFiA5Qx81iuRjJnBtetMmeoFaV4ULnBkKhHQ==
X-Received: by 2002:a17:907:6e91:b0:9be:fc31:8cd3 with SMTP id sh17-20020a1709076e9100b009befc318cd3mr992947ejc.17.1697793695353;
        Fri, 20 Oct 2023 02:21:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ga23-20020a170906b85700b009b65b2be80bsm1099727ejb.76.2023.10.20.02.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:21:34 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v2 09/10] devlink: remove duplicated netlink callback prototypes
Date: Fri, 20 Oct 2023 11:21:16 +0200
Message-ID: <20231020092117.622431-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020092117.622431-1-jiri@resnulli.us>
References: <20231020092117.622431-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

The prototypes are now generated, remove the old ones.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h | 62 -------------------------------------
 1 file changed, 62 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index daf4c696a618..183dbe3807ab 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -227,65 +227,3 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
-
-/* Devlink nl cmds */
-int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_flash_update_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_split_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_unsplit_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_del_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_sb_port_pool_set_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
-					struct genl_info *info);
-int devlink_nl_sb_occ_snapshot_doit(struct sk_buff *skb,
-				    struct genl_info *info);
-int devlink_nl_sb_occ_max_clear_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_dpipe_table_get_doit(struct sk_buff *skb,
-				    struct genl_info *info);
-int devlink_nl_dpipe_entries_get_doit(struct sk_buff *skb,
-				      struct genl_info *info);
-int devlink_nl_dpipe_headers_get_doit(struct sk_buff *skb,
-				      struct genl_info *info);
-int devlink_nl_dpipe_table_counters_set_doit(struct sk_buff *skb,
-					     struct genl_info *info);
-int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_param_get_dumpit(struct sk_buff *msg,
-				     struct netlink_callback *cb);
-int devlink_nl_port_param_get_doit(struct sk_buff *skb,
-				   struct genl_info *info);
-int devlink_nl_port_param_set_doit(struct sk_buff *skb,
-				   struct genl_info *info);
-int devlink_nl_region_new_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_region_del_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_region_read_dumpit(struct sk_buff *skb,
-				  struct netlink_callback *cb);
-int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
-					struct genl_info *info);
-int devlink_nl_health_reporter_recover_doit(struct sk_buff *skb,
-					    struct genl_info *info);
-int devlink_nl_health_reporter_diagnose_doit(struct sk_buff *skb,
-					     struct genl_info *info);
-int devlink_nl_health_reporter_dump_get_dumpit(struct sk_buff *skb,
-					       struct netlink_callback *cb);
-int devlink_nl_health_reporter_dump_clear_doit(struct sk_buff *skb,
-					       struct genl_info *info);
-int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
-					 struct genl_info *info);
-int devlink_nl_trap_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_trap_group_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_trap_policer_set_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_linecard_set_doit(struct sk_buff *skb, struct genl_info *info);
-- 
2.41.0


