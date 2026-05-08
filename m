Return-Path: <netdev+bounces-285810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AEWO+ve/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:02:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 498B64F6BAA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 703E3303D4D8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8194A3E1CFF;
	Fri,  8 May 2026 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eze9jnsk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6723E121F
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245188; cv=none; b=ZrPPxo1Xr4zNEjG2LaMtclKIO2fop2G9oTQWWsmSl22IwxW7499qmUjE2LUzgCRpSEsEwMphw/+8vQW6IF0NvaU+QLEapItWTJ63oC1/qpuxWCHGu44uDfd7AspCpVGqFQ05dZTmxBxi0qSRYgyj2ELLJDQdGE6YeVrnonc6fQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245188; c=relaxed/simple;
	bh=cIgqFDuYpmAQ9O9mjXlj0JybX6yCopnWD3DhBhD2jzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mm29FKL/nHDN5Zl0/dIB1H39po+1Rv0QZqBeM1qsqXNbuu7SU3R09kn2FLFxSuJIvGfsVuk6e2rpmJzDEMpUD2pf80KXe/ui/VAoTVOZaLrDR5xPPdrgLHe7AbALVV3dyoX4s9LDvnqXCPDEF5lvkCF2oRlVUshTOJaqF47oH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eze9jnsk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778245186; x=1809781186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cIgqFDuYpmAQ9O9mjXlj0JybX6yCopnWD3DhBhD2jzA=;
  b=Eze9jnsk6MBeEj8Tv2LadlUUGOWIm0URihc12QMo+vtdHVE0bVHo2jnD
   hLjGH/a/+cU6f6kNnjcP2EMggYaEK/BIJZve9+5kehExu3lqeNoR9DYYn
   Lf+0zUROTfJ/5pHXpn+jzZONOvREp4laFlISxVO9mkCDBehIoOu6CyfAf
   wuT2cHcn8TqsD4Ml/QL/84MLpa71R6oQ7W4UrOyJ2QR6fNmXDtFKQBbhe
   2UBFRRVBngMogEEXHUM9y4SrykRfm7gUXAjMcfrjWlfMMehhb/u5mhBpo
   qum6OCoPo+q9o0SZBiIX4ijYbItd35XboZNEJwqa26/xdnIfnWOPHJc36
   Q==;
X-CSE-ConnectionGUID: 4Lc2hFZZTkunJ75afrmOYw==
X-CSE-MsgGUID: AdkRqxXbQO6/6umeUs3jjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79199854"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79199854"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 05:59:43 -0700
X-CSE-ConnectionGUID: gacRS5sDToWF1t7ZyymUoQ==
X-CSE-MsgGUID: sGDyEB+NS9yAvETiJTNZ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241730093"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 05:59:38 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 01B0628798;
	Fri,  8 May 2026 13:59:35 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1 01/15] devlink, mlx5: add init/fini ops for shared devlink
Date: Fri,  8 May 2026 14:41:54 +0200
Message-Id: <20260508124208.11622-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 498B64F6BAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285810-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add .shd_init() and .shd_fini() ops, that will be called for the first
devlink_shd_get() (to initialize driver' priv data) and on the last
devlink_shd_put() (to allow for the cleanup). Both ops are optional.

.shd_init() could return an error, which will stop creation of shd
instance. The initializer also gets an additional, optional param,
that driver could use for any needs.

If any of the callbacks will need to get devlink instance, it could
be accessed by shd_priv_to_devlink().

Both callbacks are called with devl_lock held and devlink registered.

Next commit will make use of the callbacks, another one will make use also
of the non-null additional param (outside of this series).

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
(v0) first discussed at:
https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com

v1: remove redundant added blank line (Jiri)
---
 include/net/devlink.h                         | 26 +++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
 net/devlink/sh_dev.c                          | 38 ++++++++++++++++++-
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index bcd31de1f890..5d3a1337bfa1 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1586,6 +1586,30 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+
+	/**
+	 * shd_init: Shared devlink instance initializer
+	 * @priv: shd_devlink' priv
+	 * @init_param: additional param to pass to driver callback
+	 *
+	 * Called once when the shared instance is first created (by the first
+	 * devlink_shd_get() call).
+	 * Should initialize the driver's private data embedded in the shared
+	 * devlink. May be NULL.
+	 *
+	 * Return: 0 on success, negative to prevent shared instance usage.
+	 */
+	int (*shd_init)(void *priv, void *init_param);
+	/**
+	 * shd_fini: Shared devlink instance finalizer
+	 * @priv: shd_devlink' priv
+	 *
+	 * Called once when the last reference is dropped and the shared
+	 * instance is destroyed. Should clean up the driver's private data.
+	 * May be NULL.
+	 */
+	void (*shd_fini)(void *priv);
+
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
@@ -1651,9 +1675,11 @@ void devlink_free(struct devlink *devlink);
 struct devlink *devlink_shd_get(const char *id,
 				const struct devlink_ops *ops,
 				size_t priv_size,
+				void *init_param,
 				const struct device_driver *driver);
 void devlink_shd_put(struct devlink *devlink);
 void *devlink_shd_get_priv(struct devlink *devlink);
+struct devlink *shd_priv_to_devlink(void *priv);
 
 /**
  * struct devlink_port_ops - Port operations
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index b925364765ac..1b8b1ce7e72d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -43,7 +43,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
 	*end = '\0';
 
 	/* Get or create shared devlink instance */
-	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, NULL, pdev->dev.driver);
 	kfree(sn);
 	if (!devlink)
 		return -ENOMEM;
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
index 85acce97e788..7b9520d3f946 100644
--- a/net/devlink/sh_dev.c
+++ b/net/devlink/sh_dev.c
@@ -34,6 +34,7 @@ static struct devlink_shd *devlink_shd_lookup(const char *id)
 static struct devlink_shd *devlink_shd_create(const char *id,
 					      const struct devlink_ops *ops,
 					      size_t priv_size,
+					      void *init_param,
 					      const struct device_driver *driver)
 {
 	struct devlink_shd *shd;
@@ -49,16 +50,30 @@ static struct devlink_shd *devlink_shd_create(const char *id,
 	if (!shd->id)
 		goto err_devlink_free;
 	shd->priv_size = priv_size;
-	refcount_set(&shd->refcount, 1);
 
 	devl_lock(devlink);
 	devl_register(devlink);
+
+	if (ops->shd_init) {
+		int err;
+
+		err = ops->shd_init(shd->priv, init_param);
+		if (err)
+			goto err_unregister;
+	}
+
 	devl_unlock(devlink);
 
+	refcount_set(&shd->refcount, 1);
 	list_add_tail(&shd->list, &shd_list);
 
 	return shd;
 
+err_unregister:
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	kfree(shd->id);
+
 err_devlink_free:
 	devlink_free(devlink);
 	return NULL;
@@ -70,6 +85,10 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
 
 	list_del(&shd->list);
 	devl_lock(devlink);
+
+	if (devlink->ops->shd_fini)
+		devlink->ops->shd_fini(shd->priv);
+
 	devl_unregister(devlink);
 	devl_unlock(devlink);
 	kfree(shd->id);
@@ -81,6 +100,7 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
  * @id: Identifier string (e.g., serial number) for the shared instance
  * @ops: Devlink operations structure
  * @priv_size: Size of private data structure
+ * @init_param: Passed to .shd_init() callback alongside driver's priv
  * @driver: Driver associated with the shared devlink instance
  *
  * Get an existing shared devlink instance identified by @id, or create
@@ -96,16 +116,17 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
 struct devlink *devlink_shd_get(const char *id,
 				const struct devlink_ops *ops,
 				size_t priv_size,
+				void *init_param,
 				const struct device_driver *driver)
 {
 	struct devlink *devlink;
 	struct devlink_shd *shd;
 
 	mutex_lock(&shd_mutex);
 
 	shd = devlink_shd_lookup(id);
 	if (!shd) {
-		shd = devlink_shd_create(id, ops, priv_size, driver);
+		shd = devlink_shd_create(id, ops, priv_size, init_param, driver);
 		goto unlock;
 	}
 
@@ -159,3 +180,16 @@ void *devlink_shd_get_priv(struct devlink *devlink)
 	return shd->priv;
 }
 EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
+
+/** shd_priv_to_devlink - Get devlink instance from shd_devlink's priv
+ * @priv: Driver's priv data
+ *
+ * Return: pointer to shared devlink instance the @priv belongs to.
+ */
+struct devlink *shd_priv_to_devlink(void *priv)
+{
+	struct devlink_shd *shd = container_of(priv, struct devlink_shd, priv);
+
+	return priv_to_devlink(shd);
+}
+EXPORT_SYMBOL_GPL(shd_priv_to_devlink);
-- 
2.39.3


