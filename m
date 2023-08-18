Return-Path: <netdev+bounces-28737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F380780719
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32632822F0
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9B174DA;
	Fri, 18 Aug 2023 08:25:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778415AE3
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:25:40 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D9123
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:25:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf092a16c9so5585445ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347138; x=1692951938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ys/Jtubwtr0KcBiwL/KsiHOiw+JI6WSzniGm+ecmico=;
        b=pE1Bg0p3gyWO8AjCoe13tgTyVtaB79irwHtOO7oIiFWfwAW27me4I3aR78zRSnUSJr
         2fYmZNgL3wbqER/2KdQhQKNexZNECNiFR0zW9hnYQCloMzltG88/ifRpCGmsxrKZLlTT
         sw3DOLKyssOlA3YC/kZZJGq3T68Qr8x2B80J4U45M/sxcaqK1MO3C+6UR2wfhtxTVRbR
         qycC3RwhlxINRB3JtKcRoW7kEqeJkd8Ye3yKEXz5SFnhfkxdYTrnr1ktW7ne1I9PYob7
         kd1EqH6jB9kJz756MnnlK/z3unrPewErgbb3Ni66dU7myYHE148emX5DTAXm2cc65A1G
         mXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347138; x=1692951938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ys/Jtubwtr0KcBiwL/KsiHOiw+JI6WSzniGm+ecmico=;
        b=Z5oqlFCHo4dVkkY81rREaxfZh6O2aqlQa7VsqdhehQ2eUbMZleSBcyPnmRH/YUMZBY
         QXm+Mt202YDxMgAcIKvJD6v6TO2Yf9R9HnsKWZz4HyoRGIbCcQsPE+o4PVBbWfNknGd4
         Prd1CPZvKWusDjQvpR4V2xqrkComA9ELsVR+fAh1YeVHzdI1573BQhdUBzpmShAJZ9/b
         CTrmUBz5KW4fkeuKru2q+iw2Fz2DemrrxAqWT4gVt4CLmESYBnuFiKrWam5GM1APjZq+
         G/wyTbyrO+XnINuwXdj7TZ+WiSYURcvsxfyM5Q3mLd85avJ9vJV8dlAHl/ks1lGoxPzT
         8rww==
X-Gm-Message-State: AOJu0YwFKRcwv5C0ukvFxZMEcrasN1eIQQAqg6yDm1FLNO1AqqSqSyeD
	K9iAw3f5ANPAugvwYglLerVjxMOem4m0oUcu
X-Google-Smtp-Source: AGHT+IHY53pfl8nSw+Z7sBC9h/wLTPJV+G+HeVt/tWbVgDoBQhN9ZwTofalEES3Sj866baNyYO7k2Q==
X-Received: by 2002:a17:902:b58a:b0:1bd:a22a:d406 with SMTP id a10-20020a170902b58a00b001bda22ad406mr1487762pls.21.1692347138228;
        Fri, 18 Aug 2023 01:25:38 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001a80ad9c599sm1107680pll.294.2023.08.18.01.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:25:35 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next] IPv4: add extack info for IPv4 address add/delete
Date: Fri, 18 Aug 2023 16:25:23 +0800
Message-Id: <20230818082523.1972307-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add extack info for IPv4 address add/delete, which would be useful for
users to understand the problem without having to read kernel code.

No extack message for the ifa_local checking in __inet_insert_ifa() as
it has been checked in find_matching_ifa().

Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: Lowercase all ipv4 prefix. use one extack msg for ifa_valid checking.
---
 net/ipv4/devinet.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5deac0517ef7..c3658b8755bc 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -509,6 +509,7 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 				return -EEXIST;
 			}
 			if (ifa1->ifa_scope != ifa->ifa_scope) {
+				NL_SET_ERR_MSG(extack, "ipv4: Invalid scope value");
 				inet_free_ifa(ifa);
 				return -EINVAL;
 			}
@@ -664,6 +665,7 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ifm = nlmsg_data(nlh);
 	in_dev = inetdev_by_index(net, ifm->ifa_index);
 	if (!in_dev) {
+		NL_SET_ERR_MSG(extack, "ipv4: Device not found");
 		err = -ENODEV;
 		goto errout;
 	}
@@ -688,6 +690,7 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return 0;
 	}
 
+	NL_SET_ERR_MSG(extack, "ipv4: Address not found");
 	err = -EADDRNOTAVAIL;
 errout:
 	return err;
@@ -839,13 +842,23 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 
 	ifm = nlmsg_data(nlh);
 	err = -EINVAL;
-	if (ifm->ifa_prefixlen > 32 || !tb[IFA_LOCAL])
+
+	if (ifm->ifa_prefixlen > 32) {
+		NL_SET_ERR_MSG(extack, "ipv4: Invalid prefix length");
+		goto errout;
+	}
+
+	if (!tb[IFA_LOCAL]) {
+		NL_SET_ERR_MSG(extack, "ipv4: Local address is not supplied");
 		goto errout;
+	}
 
 	dev = __dev_get_by_index(net, ifm->ifa_index);
 	err = -ENODEV;
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "ipv4: Device not found");
 		goto errout;
+	}
 
 	in_dev = __in_dev_get_rtnl(dev);
 	err = -ENOBUFS;
@@ -897,6 +910,7 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 
 		ci = nla_data(tb[IFA_CACHEINFO]);
 		if (!ci->ifa_valid || ci->ifa_prefered > ci->ifa_valid) {
+			NL_SET_ERR_MSG(extack, "ipv4: address lifetime invalid");
 			err = -EINVAL;
 			goto errout_free;
 		}
@@ -954,6 +968,7 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			int ret = ip_mc_autojoin_config(net, true, ifa);
 
 			if (ret < 0) {
+				NL_SET_ERR_MSG(extack, "ipv4: Multicast auto join failed");
 				inet_free_ifa(ifa);
 				return ret;
 			}
@@ -967,8 +982,10 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		inet_free_ifa(ifa);
 
 		if (nlh->nlmsg_flags & NLM_F_EXCL ||
-		    !(nlh->nlmsg_flags & NLM_F_REPLACE))
+		    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
+			NL_SET_ERR_MSG(extack, "ipv4: Address already assigned");
 			return -EEXIST;
+		}
 		ifa = ifa_existing;
 
 		if (ifa->ifa_rt_priority != new_metric) {
-- 
2.38.1


