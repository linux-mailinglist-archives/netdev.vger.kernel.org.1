Return-Path: <netdev+bounces-23166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5093876B376
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A7A1C2030C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1C20FBA;
	Tue,  1 Aug 2023 11:38:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819820FB4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:35 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C8D1B0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40398ccdaeeso27721571cf.3
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889910; x=1691494710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=o4Tnfn4XhFoAxnYJLvfUfHYTncBUlsKhGoTOQEfzL0jeESfjwJdB6mW5rDMd8aR6PP
         XqhE+mnSAqtKZqMBDPTUx89rfHRSENq9bYKrZpyr3ZQQxyffoNXeYR+nf1EKziUDz2o8
         ftgrDgvepiy9zRQf149qdKx5O56Isfif47jWSbcVkEvXrddH70IsXmbsJnOw+t86mnkH
         b47RzFoE2TArmsGb5j1gj27q+muXKXMtDyaRqu9cEheapnq1unlRAYOpdNX+5LEgjgq/
         2A81IIn0arscJmLCB2otKkIdONeCAC66SYpaT7CRKhnx5/Q6CzmiX+tHCtbzYclrGP7y
         CuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889910; x=1691494710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=Mv4DocNR8zltBR0QEFtHKTBdjuDoteoE2zKVCafJ3B9RzMxofCs1vych2tYmeZq9bn
         ZM76ar5h9qLdNh9ogtxfkhWv6HZ5ap3FflBUPLyi/dn8IQ0Wp9nQNTzqci+0P8gDM2sw
         yvfwagkQ/hMefqc5C6efzwM4QoH9tKG328BLoPpVZCtS2R+STmQl9avLdxSYz24ZYxPJ
         FUrdRR3H02uUZiNNDWT0DH10NYMsUUaEDpWOnoUSMrEoY9hReyUivG/H+fpJA0qHJA9h
         OnerHIcAY1umO1e1X9XuLluZmkdwBcipZ41MTH5tsPCjxyw3loQKYg2qlSiB7fbmaoOX
         EBdQ==
X-Gm-Message-State: ABy/qLauD838gd0U9H/rSolbM2N6QLwYJlYly82bc0krUVg8h/kB0cvX
	3N6FxJcNHuJE2Fq9YCM1+rNWgYStAIJbBDpW6bLUHQ==
X-Google-Smtp-Source: APBJJlEhdju8O3qS2yANB4DnjSG/elyuAkvEDf3P6ESuJvtx+10zkjnSUTtNmfyvVz/ZbkwpFFx8OQ==
X-Received: by 2002:a0c:8cca:0:b0:63d:33f9:141 with SMTP id q10-20020a0c8cca000000b0063d33f90141mr9422325qvb.34.1690889910554;
        Tue, 01 Aug 2023 04:38:30 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:29 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v5 net-next 08/23] rtnl: add helper to check if group has listeners
Date: Tue,  1 Aug 2023 07:37:52 -0400
Message-Id: <20230801113807.85473-9-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801113807.85473-1-jhs@mojatatu.com>
References: <20230801113807.85473-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As of today, rtnl code creates a new skb and unconditionally fills and
broadcasts it to the relevant group. For most operations this is okay
and doesn't waste resources in general.

For P4TC, it's interesting to know if the TC group has any listeners
when adding/updating/deleting table entries as we can optimize for the
most likely case it contains none. This not only improves our processing
speed, it also reduces pressure on the system memory as we completely
avoid the broadcast skb allocation.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/rtnetlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 971055e66..487e45f8a 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -142,4 +142,11 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
+static inline int rtnl_has_listeners(const struct net *net, u32 group)
+{
+	struct sock *rtnl = net->rtnl;
+
+	return netlink_has_listeners(rtnl, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
-- 
2.34.1


