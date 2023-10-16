Return-Path: <netdev+bounces-41223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F17CA444
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87AE281673
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719C41F600;
	Mon, 16 Oct 2023 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jq9n9vI7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FB1D55B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:09 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27C2AD
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:08 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d4453ba38so9870476d6.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448967; x=1698053767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=jq9n9vI71YusLHgvQ03dRzSy466NXqtDD7oF5nSu6iWVYGaoa/39CtrjRWRSv+xZoE
         YdIT4bgyGbE79A5gs1IgT3Xd/G2vonT/1A98mR95Bvs98Pox6qxpqIeCQQOvBa1MB5cP
         KDEVMKruW116i1LCu+ZFrTltr+dGujGToFBUZ6vCJxGdBGiFgLl2U2XRV+Kujsm6T9k5
         oXIfAoIS7gGgfH+qZ/NssM1H9nmpkbCwkJa2welUlNZawQq3CrTddOABP07aQdLenkjB
         SPUUsS9t1u0KHSWarZyXCs5xP2JetIvVZXndOcCQmDNBiDjAUxCVv6HQ4KsVhYyUk8n3
         sbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448967; x=1698053767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=fDCl0izejgkfFjKaBSB7vsbTQ6djeI6JGTUUvg0iMYSc1zWcEXXYCZh9RzmiORYI9P
         YYxatKI8IC27Qs7LRa7WI6Mshqvzpj54ct+L0g+HkYHh5P24k1xU86hiHBstbX1iKsnl
         wWATmCTJW5YyqNF0Xp0YWazBgNjk2p9gPm2uL3cIbEDIwdjDtjelT+RN06QcSV1g5ra8
         4Z4QX+BBA7bGMAF4KkvHbxKqjDiLaBIhMzFbMy4oCciUCfgW7V50pdLqaAAHB5iyffil
         zwat52dm1WBeZYozrgc40Tw7y3hkUxy8n23/r20i6xGZRe64ycGbhcWwxv1wRv1SoCus
         6T2Q==
X-Gm-Message-State: AOJu0Yw/sa3UFHzs1mPHGa3R9mEa8NCVvJpBpwasCHPZTY4XwE80WiQH
	yLobUT5LYjqd3BabjouJdsIViHMfvsl6dH/0Xs4=
X-Google-Smtp-Source: AGHT+IGR/9swvBWklnGja715ZcjEwFtgcE1jQTqXBUTqe4w6F/UjVVb3rjH1hP5cpA9cVC2LGCwj8Q==
X-Received: by 2002:ad4:596f:0:b0:66d:4191:91ee with SMTP id eq15-20020ad4596f000000b0066d419191eemr6012746qvb.51.1697448967549;
        Mon, 16 Oct 2023 02:36:07 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:36:07 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH v7 net-next 07/18] rtnl: add helper to check if group has listeners
Date: Mon, 16 Oct 2023 05:35:38 -0400
Message-Id: <20231016093549.181952-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016093549.181952-1-jhs@mojatatu.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
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


