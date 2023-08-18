Return-Path: <netdev+bounces-28918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45AA7812A1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6921C210D7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2863B1ADCA;
	Fri, 18 Aug 2023 18:14:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BE19BC0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:14:48 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8FB3C3D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:14:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76d7fcae611so75614785a.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692382485; x=1692987285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ts5GMJjU01jbQ5PVsz14tQBnp6LPaCJuc2bNeweoxqI=;
        b=SukpCX95qSWqj9Rr9/4RuxY4gdtlfiQYj8h+L+zKecfymyjkSKqFsi2t+P2Myktwew
         f0Ri7NQYabJfeCjHZNVVirOun8rMUvew0pt6DEhplhty3IG5I3b34cQZcO3lsVcXB1/x
         N7JEAdq8DPzsWdTi6N1+K3JZgXAmx8g0QNfafMMPIc4fvGOL5WkFL5/Ks1TYMhcN/w63
         CkO4xlF5HKEQ6FadKlxJknYOGs4fu8JcYdO3BSj08iSn1QVRnPcTX0LY89ll4d7NrvQj
         DLbVaZsiuLaRd0u5oz/fWAxeVu9n4bBltdN2bslHRsW4bC7VofFcCmr73x7F4iPMRIjI
         D1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382485; x=1692987285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ts5GMJjU01jbQ5PVsz14tQBnp6LPaCJuc2bNeweoxqI=;
        b=duuLFNwAFmm7yxJz6/p0cekQx5e9jmfdf26hTyv0Q8VKZderZi81s7/iWWiZfPcid/
         KLvoIEQfUqBiHnBHi5kseeXR6yMvyRhlm9r8pUmlTgJJyL3LxET9Cmxl/1U536l2fSkO
         +u+Wxm3rTMJyaCU5DYQOurN1GZudATAJWIpjDAxEYCR1w8l8eZonREulX0PgjX8Svrde
         jbaAPGGfsObMhVn3RvJEdlEFto4lHlC35qJSyCjPMFY4k2g9waAC6EpcMipZqsLRncaX
         UIgaaEm/UMGqMa3fcDxpdUSzgcMDkQgF9VNjh2pcyr1JwQw3seLYuKHM6yYK8QdA3f4O
         PR+g==
X-Gm-Message-State: AOJu0YzGp5WcYOlXXpga7f0ZU0UAsjeW8Fe68EWPxiwMi63whkh15vxH
	Sced287QpdB4pHDisY32lF9NHg==
X-Google-Smtp-Source: AGHT+IGzVAdONCRybVRCgnELkK+w8qX+Q9oiEiGoqAL9mPtBgNqUXWy2EMZDv9XlT1nyRWzIKADUeA==
X-Received: by 2002:a0c:f112:0:b0:63f:89d3:bf51 with SMTP id i18-20020a0cf112000000b0063f89d3bf51mr3814741qvl.55.1692382485341;
        Fri, 18 Aug 2023 11:14:45 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id j17-20020a0cf511000000b006418daf9ac5sm844824qvm.132.2023.08.18.11.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:14:44 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	shaozhengchao@huawei.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com
Subject: [PATCH net 1/1] net/sched: fix a qdisc modification with ambigous command request
Date: Fri, 18 Aug 2023 14:14:32 -0400
Message-Id: <20230818181432.54283-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

When replacing an existing root qdisc, with one that is of the same kind, the
request boils down to essentially a paremeterization change  i.e not one that
requires allocation and grafting of a new qdisc. syzbot was able to create a
scenario which resulted in a taprio qdisc replacing an existing taprio qdisc
with a combination of NLM_F_CREATE, NLM_F_REPLACE and NLM_F_EXCL leading to
create and graft scenario.
The fix ensures that only when the qdisc kinds are different that we should
allow a create and graft, otherwise it goes into the "change" codepath.

While at it, fix the code and comments to improve readability.

While syzbot was able to create the issue, it did not zone on the root cause.
Analysis from Vladimir Oltean <vladimir.oltean@nxp.com> helped narrow it down.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com
Closes:https://lore.kernel.org/netdev/20230816225759.g25x76kmgzya2gei@skbuf/T/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_api.c | 55 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index aa6b1fe65151..dd3db8608275 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1547,10 +1547,28 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+static inline bool cmd_create_or_replace(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_REPLACE);
+}
+
+static inline bool cmd_create_exclusive(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_EXCL);
+}
+
+static inline bool cmd_change(struct nlmsghdr *n)
+{
+	return (!(n->nlmsg_flags & NLM_F_CREATE) &&
+		!(n->nlmsg_flags & NLM_F_REPLACE) &&
+		!(n->nlmsg_flags & NLM_F_EXCL));
+}
+
 /*
  * Create/change qdisc.
  */
-
 static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			   struct netlink_ext_ack *extack)
 {
@@ -1644,27 +1662,37 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				 *
 				 *   We know, that some child q is already
 				 *   attached to this parent and have choice:
-				 *   either to change it or to create/graft new one.
+				 *   1) change it or 2) create/graft new one.
+				 *   If the requested qdisc kind is different
+				 *   than the existing one, then we choose graft.
+				 *   If they are the same then this is "change"
+				 *   operation - just let it fallthrough..
 				 *
 				 *   1. We are allowed to create/graft only
-				 *   if CREATE and REPLACE flags are set.
+				 *   if the request is explicitly stating
+				 *   "please create if it doesn't exist".
 				 *
-				 *   2. If EXCL is set, requestor wanted to say,
-				 *   that qdisc tcm_handle is not expected
+				 *   2. If the request is to exclusive create
+				 *   then the qdisc tcm_handle is not expected
 				 *   to exist, so that we choose create/graft too.
 				 *
 				 *   3. The last case is when no flags are set.
+				 *   This will happen when for example tc
+				 *   utility issues a "change" command.
 				 *   Alas, it is sort of hole in API, we
 				 *   cannot decide what to do unambiguously.
-				 *   For now we select create/graft, if
-				 *   user gave KIND, which does not match existing.
+				 *   For now we select create/graft.
 				 */
-				if ((n->nlmsg_flags & NLM_F_CREATE) &&
-				    (n->nlmsg_flags & NLM_F_REPLACE) &&
-				    ((n->nlmsg_flags & NLM_F_EXCL) ||
-				     (tca[TCA_KIND] &&
-				      nla_strcmp(tca[TCA_KIND], q->ops->id))))
-					goto create_n_graft;
+				if (tca[TCA_KIND] &&
+				    nla_strcmp(tca[TCA_KIND], q->ops->id)) {
+					if (cmd_create_or_replace(n) ||
+					    cmd_create_exclusive(n)) {
+						goto create_n_graft;
+					} else {
+						if (cmd_change(n))
+							goto create_n_graft2;
+					}
+				}
 			}
 		}
 	} else {
@@ -1698,6 +1726,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		NL_SET_ERR_MSG(extack, "Qdisc not found. To create specify NLM_F_CREATE flag");
 		return -ENOENT;
 	}
+create_n_graft2:
 	if (clid == TC_H_INGRESS) {
 		if (dev_ingress_queue(dev)) {
 			q = qdisc_create(dev, dev_ingress_queue(dev),
-- 
2.34.1


