Return-Path: <netdev+bounces-271406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M2sSJX2Bw2n9rAQAu9opvQ
	(envelope-from <netdev+bounces-271406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:32:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D77503202C4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B25EC3013036
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244052853F8;
	Wed, 25 Mar 2026 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrJI+H1J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F602AF00
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420345; cv=none; b=rs3/oGoOP4zam5fA1A0QNBuzsMTwm5DOZX387cPlok7UUoWz9EoErZsTpl5Mv8NqQPr+Bky9jnFk9ecTrLSxluVbbJyu31dpLENh6t9bKEkX+9+WuGS2snFDoTYtIkZiEYsKdZmYByUZIk/3AIG5METckja/of6902aMQkNuWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420345; c=relaxed/simple;
	bh=h4RRCfcEdmRZK9RVaAKuvBOS4NvEEsJkb8bg0Tcf2SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogtlZMhZxmCscHCrrdSdPw9H5PpHWpqKao6yY4EEkBU3abYkwnCPSL+yYrmSHHYREoG4MzS05h5YhZussC5beRqtz1VHufxLq2gJMhaErJtXiB/k/CYJ0cjxwhsyrVAaCrOaUPg+LWzj26dy0XIgQ4iBi82i+yVPz0+2Hpr6eCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrJI+H1J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774420343; x=1805956343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h4RRCfcEdmRZK9RVaAKuvBOS4NvEEsJkb8bg0Tcf2SI=;
  b=jrJI+H1JMsB1i87ekbQfqhGqw/vU9+Ikgrkdm01Mbj0ZW93jZf0cLiOD
   Czr2WUa1Kkv6ZqZyF6itiJi8QYYQA3OksvEf975og74ubFjHYIBsmJ8Lv
   CANMp3w5wSenMn4ACqPVr/8GywT2NHBJ+QfulacysazPxtIOScYHSY8KF
   CvWFCpo4274qWzvkrsSC4YWECaraA59+/g6HQIMr6wCTCAwTJnxnO1Fbg
   gYairAg1gbzmQxy4G19ZkzUKeujW9LzldlD5k40tpLStNCEYOsa0l6O91
   WrR7AAJOhOiiCbgSfQ+K3vg/6aEg3uXa5wbeUeudtJa3y1AJcZ+4JOYff
   A==;
X-CSE-ConnectionGUID: 0U4KPDsTQZS8l1L6r8hIZg==
X-CSE-MsgGUID: 3Q7rFhY5TDaH0NsCYcw10A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79308055"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79308055"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 23:32:03 -0700
X-CSE-ConnectionGUID: xGulh6gmTcuT57k7D1q5RQ==
X-CSE-MsgGUID: qPQk9mTjT8WgBzbn8tkU0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="221693629"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 24 Mar 2026 23:31:56 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.24])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9095E2FC6;
	Wed, 25 Mar 2026 06:31:54 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Michal Schmidt <mschmidt@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 1/2] devlink: unify devlink_shd_get_priv() into devlink_priv()
Date: Wed, 25 Mar 2026 07:26:52 +0100
Message-ID: <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271406-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D77503202C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unify access API to shared devlink priv data with normal devlink.

Thanks to Jiri Pirko, we now have ability to create shared devlink
instances [1]. Introduction series have added usage of those for mlx, but
without priv data attached to the shared devlink.

Current API makes it possible to access shared devlink instance's priv
data:

	void *devlink_shd_get_priv(struct devlink *devlink);

but it is easy to forget (especially during rebase from "before shared
devlinks" era) and call:

	void *devlink_priv(struct devlink *devlink);

which even has the same signature, so it's hard to catch the error.

New proposed API unifies both calls into one, without any increase in the
observed struct size. (Alternative could be to store additional pointer,
set during devlink_alloc).

Unexport the less convenient API call.

[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v1:
https://lore.kernel.org/netdev/20260323132136.13191-1-przemyslaw.kitszel@intel.com

v2:
- fix typos (Alex, Jiri)
- fix infinite recurrence (Alex)
- add __devlink_priv(), which is more general than v1's devlink_to_shd()
  (Jiri)
---
 net/devlink/devl_internal.h |  7 +++++++
 net/devlink/core.c          | 10 +++++++++-
 net/devlink/sh_dev.c        |  8 ++++----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7dfb7cdd2d23..0a57318d92f8 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -58,6 +58,7 @@ struct devlink {
 	struct mutex lock;
 	struct lock_class_key lock_key;
 	u8 reload_failed:1;
+	u8 is_shd:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
 	struct devlink_rel *rel;
@@ -72,6 +73,12 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
 
+/* Get priv allocated for struct devlink */
+void *__devlink_priv(struct devlink *devlink);
+
+/* Get private data from shared devlink instance */
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 #define devl_warn(devlink, format, args...)				\
 	do {								\
 		if ((devlink)->dev)					\
diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..a242be203fe8 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -230,10 +230,18 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-void *devlink_priv(struct devlink *devlink)
+void *__devlink_priv(struct devlink *devlink)
 {
 	return &devlink->priv;
 }
+
+void *devlink_priv(struct devlink *devlink)
+{
+	if (devlink->is_shd)
+		return devlink_shd_get_priv(devlink);
+
+	return __devlink_priv(devlink);
+}
 EXPORT_SYMBOL_GPL(devlink_priv);
 
 struct devlink *priv_to_devlink(void *priv)
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
index 85acce97e788..b85e5cb1edbe 100644
--- a/net/devlink/sh_dev.c
+++ b/net/devlink/sh_dev.c
@@ -43,13 +43,14 @@ static struct devlink_shd *devlink_shd_create(const char *id,
 				  &init_net, NULL, driver);
 	if (!devlink)
 		return NULL;
-	shd = devlink_priv(devlink);
+	shd = __devlink_priv(devlink);
 
 	shd->id = kstrdup(id, GFP_KERNEL);
 	if (!shd->id)
 		goto err_devlink_free;
 	shd->priv_size = priv_size;
 	refcount_set(&shd->refcount, 1);
+	devlink->is_shd = 1;
 
 	devl_lock(devlink);
 	devl_register(devlink);
@@ -136,7 +137,7 @@ void devlink_shd_put(struct devlink *devlink)
 	struct devlink_shd *shd;
 
 	mutex_lock(&shd_mutex);
-	shd = devlink_priv(devlink);
+	shd = __devlink_priv(devlink);
 	if (refcount_dec_and_test(&shd->refcount))
 		devlink_shd_destroy(shd);
 	mutex_unlock(&shd_mutex);
@@ -154,8 +155,7 @@ EXPORT_SYMBOL_GPL(devlink_shd_put);
  */
 void *devlink_shd_get_priv(struct devlink *devlink)
 {
-	struct devlink_shd *shd = devlink_priv(devlink);
+	struct devlink_shd *shd = __devlink_priv(devlink);
 
 	return shd->priv;
 }
-EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.51.1


