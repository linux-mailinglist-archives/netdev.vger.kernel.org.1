Return-Path: <netdev+bounces-269738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOEHIwmivGns1gIAu9opvQ
	(envelope-from <netdev+bounces-269738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:25:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 073FA2D4AB6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 245E33029C24
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F45C2D595D;
	Fri, 20 Mar 2026 01:25:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0932D0C89
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969907; cv=none; b=un2S/fJfoz3m3qf5Q9cybwbZDh+KmXk7kTDvE0a46kHckmMLSoxVbLfIltClxbQnnj0cxvGsQ8TBLw/EIw65LKA93cEOJj1xWWRN1PSb+sxfJEf1X3gcufpmEkJSoEaLqa9MHx2xAqQ6/tvbgBiqGsH5Egm6k8kikVh7hA+uV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969907; c=relaxed/simple;
	bh=fiWuZ9fcbL8sdigaSwTTvp8tHDm8kXTBMV+vvmAza+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUkddBNB1WPPTjBfP94PKjVKdSm4ka133OM2O5CSlcQ97sI+nPhC7b8U93843jdEBVORqYUtm+Qg0hwrup/z3n9CaEYr18PC9aJk7USY+ETsPMaMbR6Xa2B4UDxl8T4PkQOaCRtHYRbQVzksra04THJgfkgK8P8HjYLbH5kobTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128e4d0cc48so153583c88.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969906; x=1774574706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7EJnW3kdUcA/mWdICiYp+Buoz7NoSHqg/f92gpxvDwE=;
        b=jxDWaMguVlRx1ncteBerO0UfekaN/yHGn+maTiI7EZ1Wj4ibUeCPWFo+JjmexaeG9+
         cJux4+BjuOw7AFsTCujvhA1rxrk1jjMyZ30evxGAYhltnc3E/kFgtui0xvK1dcdT71YV
         jtZatowgHd0yujwU26AYJKvs0THhnzfjIh0GLhICXO9iCsGSU6HF08dGrVzdGri7qNFF
         MEGAa0ASsyzUlH9kQlF6k1GBoLzFSheBz+zGR4zBfaIS1UDGQJyDGPdAuLDlTkCZdhWt
         Vef+vKmnViu+Gr2hbF9Xe2IYM9YHP4ElXsn4D38pXnu5LNnGC+eJ+iyiKeFODFt4Lo36
         QjtA==
X-Gm-Message-State: AOJu0YzOMjqt8t/mcPpdXq9zAW/nOLu15bLmclqPJ8Eok8SOXDsCepVz
	tZuWgWPPr8L5X4TTuSpxtNQMfXBFJZAgWWG2FlFvUfjNPTPOjeLd2Vc4gmNq
X-Gm-Gg: ATEYQzyRIdxsNu8ac+dJr4dVaUgD5zJZWUFVQN5/5wpWqBr4Ogmn6l1NSl2ISx8GzR4
	fnKnJYVK0cRTYsogWZ1Q5uRzr6XRp9+ySteoG0IRJLXKl6DD/vMgVRHw+F69gOvD/7Y967qzIJk
	HPQ/8XkCqbblkqMx9z60slPltbebvvVrFLzMSn1Eqa+J/fuYaicIUsoRk3UoglXwzG0w4T2/lnH
	aY/8lTCqFNfzuKW/EbHEsNLweXXLMA/ws1eZNNqFLZZSRwoPqrKyJh2CRvIhI/TBAjxVUE1Jrz7
	8IDs4RhSwOmxWhxmkH+zPT8zkSOSmrFTAxfxjNkC9p5O/TgLeimhFigdfc0yGro4TK9jgqgjMX4
	xpA3jc57I6xEzU9gNZYKqurfiBKSZTATU2B2BuuKR/jbihpcVk9oEhA6JAdCgXWmNxQmuANIYmM
	BCy+VMabK0Xp1XT9jZg+UzKQ4XPMb/uLFZhCmuG0RzQ/ksG2JOmMKz7kPskb0iMFg1ZQwniiiho
	QQpuELm/eruSZdKqw==
X-Received: by 2002:a05:7022:ec18:b0:128:d17b:e7ab with SMTP id a92af1059eb24-12a726f6573mr546108c88.36.1773969905386;
        Thu, 19 Mar 2026 18:25:05 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b952asm749391c88.12.2026.03.19.18.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 02/13] wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit
Date: Thu, 19 Mar 2026 18:24:50 -0700
Message-ID: <20260320012501.2033548-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269738-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.449];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 073FA2D4AB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nl80211_pre_doit acquires rtnl_lock and then wiphy_lock, releasing
rtnl while keeping wiphy_lock held until post_doit. With the
introduction of rx_mode_wq and its flush in netdev_run_todo, calling
rtnl_unlock here creates a circular lock dependency:

  Chain exists of:
    (wq_completion)rx_mode_wq --> rtnl_mutex --> &rdev->wiphy.mtx

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&rdev->wiphy.mtx);
                                 lock(rtnl_mutex);
                                 lock(&rdev->wiphy.mtx);
    lock((wq_completion)rx_mode_wq);

Switch to __rtnl_unlock to skip netdev_run_todo in nl80211_pre_doit.
This seems safe because we run before the op.

Link: http://lore.kernel.org/netdev/69b5ad67.a00a0220.3b25d1.001a.GAE@google.com
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/rtnetlink.c   | 1 +
 net/wireless/core.c    | 1 +
 net/wireless/nl80211.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dad4b1054955..b1bfb4a4aedd 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -150,6 +150,7 @@ void __rtnl_unlock(void)
 		head = next;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(__rtnl_unlock, "NETDEV_INTERNAL");
 
 void rtnl_unlock(void)
 {
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 23afc250bc10..a78a9b613c94 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -41,6 +41,7 @@ MODULE_AUTHOR("Johannes Berg");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("wireless configuration support");
 MODULE_ALIAS_GENL_FAMILY(NL80211_GENL_NAME);
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
 
 /* RCU-protected (and RTNL for writers) */
 LIST_HEAD(cfg80211_rdev_list);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e15cd26f3a79..f8ed8730cf1c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18203,7 +18203,7 @@ static int nl80211_pre_doit(const struct genl_split_ops *ops,
 		__release(&rdev->wiphy.mtx);
 	}
 	if (!(internal_flags & NL80211_FLAG_NEED_RTNL))
-		rtnl_unlock();
+		__rtnl_unlock();
 
 	return 0;
 out_unlock:
-- 
2.53.0


