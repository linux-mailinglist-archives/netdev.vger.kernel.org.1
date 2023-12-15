Return-Path: <netdev+bounces-58075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A6814F62
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF4FB20DBE
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C763E490;
	Fri, 15 Dec 2023 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jRo5NEPT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040245974
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28aeb049942so806846a91.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702663065; x=1703267865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3JmolsZSD6DY9X8Q3bAn+e2xR2pyofVrW7JSvZYYXE=;
        b=jRo5NEPTeU3ojuWU08TMZDoubWzPq8sS/mM6ofkCHsTRBskupX73f5LFya7Gf2Q/EJ
         n0SD93XxuWJapSod5heJ1ov8X5U4YBol2u6wCOyAhhA/OI4DYS9Pbu5dNMWo9zmU0bu5
         k8kmU76E6VprpU8BAOYa5VwwxLJhwHrEJbsdap7TnSWXu/BmTiydUgi1oJS3WVsrrt3l
         OpMUqEXMLkZL47cEFNN7nBuEWmyns072apF8VJBEKWPYiz4UPAyImgyjLSuX/mVa6rVh
         W+h7R6ZRuQDeYJS+u3pqcm2g0lF6slkd3DFZZ+LPxfJwW4Ji2qysUrkG+jPSpNomxgNs
         eeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702663065; x=1703267865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3JmolsZSD6DY9X8Q3bAn+e2xR2pyofVrW7JSvZYYXE=;
        b=qDm+8IuuvvdQaSRWhcZkHHec/xAsYShWk/WiICcx4WqMJd08iteCuXOzDHynLGiF4y
         6syEQGqs0qPYZQGAuMRjjxaMihJPjOQm/wjLyassfsk6OTvhC7clq1K45/RTYNkgV475
         IyiSDZ3Jwe+ttCWbgIBEsuV6oKIyYzqlJZjOWihzGwVqZEq0FxalC2Nunay5aUyPa+w6
         Yx93lyO37UrhjTd4l0BNLlh1WW0eslMINPh1sOaektMQmqCPuyDP78wLX8xrz98F3nYa
         jgqgdapoiDl0UNwoZtOP2z6JnU/LonGjndusTdu0enPJq03sWLmPL92tHbS13BYZSwYT
         yb1w==
X-Gm-Message-State: AOJu0YyWtQJjX7ntY35PdaaZZRYCDYN2+K/l2HhwXodJhs1+fQPreD+G
	8/lRHXsEX9VQddP16Dri4bCOTGHcU7ub/Goya5g=
X-Google-Smtp-Source: AGHT+IEdKDuDVx3kZE0MyNFdHMZ1jgvPwaT4Sn1kGy3k5F7A8E4ng7lRG5U8vfoa8G2dYxAGaO4/Ww==
X-Received: by 2002:a17:90a:2c0f:b0:28b:44a7:48d with SMTP id m15-20020a17090a2c0f00b0028b44a7048dmr106707pjd.56.1702663064755;
        Fri, 15 Dec 2023 09:57:44 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id sm9-20020a17090b2e4900b0028b0848f0edsm711799pjb.9.2023.12.15.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:57:44 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	victor@mojatatu.com,
	martin@strongswan.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	lucien.xin@gmail.com,
	edwin.peer@broadcom.com,
	amcohen@nvidia.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 1/2] net: rtnl: introduce rcu_replace_pointer_rtnl
Date: Fri, 15 Dec 2023 14:57:10 -0300
Message-Id: <20231215175711.323784-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215175711.323784-1-pctammela@mojatatu.com>
References: <20231215175711.323784-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jamal Hadi Salim <jhs@mojatatu.com>

Introduce the rcu_replace_pointer_rtnl helper to lockdep check rtnl lock
rcu replacements, alongside the already existing helpers.

This is a quality of life helper so instead of using:
   rcu_replace_pointer(rp, p, lockdep_rtnl_is_held())
   .. or the open coded..
   rtnl_dereference() / rcu_assign_pointer()
   .. or the lazy check version ..
   rcu_replace_pointer(rp, p, 1)
Use:
   rcu_replace_pointer_rtnl(rp, p)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/linux/rtnetlink.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 6a8543b34e2c..410529fca18b 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -79,6 +79,18 @@ static inline bool lockdep_rtnl_is_held(void)
 #define rtnl_dereference(p)					\
 	rcu_dereference_protected(p, lockdep_rtnl_is_held())
 
+/**
+ * rcu_replace_pointer_rtnl - replace an RCU pointer under rtnl_lock, returning
+ * its old value
+ * @rp: RCU pointer, whose value is returned
+ * @p: regular pointer
+ *
+ * Perform a replacement under rtnl_lock, where @rp is an RCU-annotated
+ * pointer. The old value of @rp is returned, and @rp is set to @p
+ */
+#define rcu_replace_pointer_rtnl(rp, p)			\
+	rcu_replace_pointer(rp, p, lockdep_rtnl_is_held())
+
 static inline struct netdev_queue *dev_ingress_queue(struct net_device *dev)
 {
 	return rtnl_dereference(dev->ingress_queue);
-- 
2.40.1


