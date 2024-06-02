Return-Path: <netdev+bounces-99998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A101A8D7672
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA911C21824
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FC24207F;
	Sun,  2 Jun 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lW9I/gRQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF66B64B;
	Sun,  2 Jun 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339972; cv=none; b=E71rZ9KklA/0eK0ZgFgW6kG72U+jmTvrpTlvRq06mQGAOzlYBLs7DR+QQ353vTLiwSzs8tCbBZdyot5we3Yf+d+FcAYm52BGrccMik+O2P904pstfukehLR3rCq5nLeLtHZUDjbomGQA6rxSsosM7QcoIKzV4fYv3/Le/0RpK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339972; c=relaxed/simple;
	bh=lTgUwlG7nLBFiETrR69C8cfUl4O8VNEeo7B8BbTo+ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcACGcYmf7MmeslE7SgfMd6mUTPosGF8Cv3Xk+G7crLvwr4F+s6bYRhm/BY4MNtkbnTxopW7Z2DEh3GzFkM+pWJpQSqShjn6fYUZ8iHguDNw/1MZSHSLs3WXE5B2ML9sfkFHSXQgUNcmLv5XasIsQT3e/Q8WOSp6pUd3uVdRvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lW9I/gRQ; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id Dm2ns8x2vLmxrDm2ysLKRD; Sun, 02 Jun 2024 16:18:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717337937;
	bh=tSEqEQfth4qJVeha9JEnu00+3Nn6CnfjFpf6x4pdbiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lW9I/gRQVxMFu1jpMG+o+Dwoe9VaffsG8sUWLrrUW63upI2dFwGHJ/tYt6FUiB+m9
	 8s0imuKf+JWbw6+l5tt6nsfvVmS6Ohv7qlbie/rBpq40bf1bBuKdKHRjHfnA+x4Unc
	 R6J5WL1Aornl7H+0A5g1D+ixQf+a81Ja/Otzo1vu/3bT9C2AyEXDVIbrZ4OXXGXg+P
	 g0tH9wLO1utXdRoHy46J241KX/IbAp8rylHWQtllfAmWittTbT6XPsjLCZVjtd/4Yd
	 /1O94jiq28JdrVYo+6337fYE7hVb88/2j3AaarUFOmiY88zQ+SaFNwxrRicyjUqdAp
	 pIgjpJzDdxL9Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Jun 2024 16:18:57 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: idosch@nvidia.com,
	petrm@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2 net-next] devlink: Constify the 'table_ops' parameter of devl_dpipe_table_register()
Date: Sun,  2 Jun 2024 16:18:52 +0200
Message-ID: <3d1deee6bb5a31ee1a41645223fa8b4df1eef7ba.1717337525.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
References: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"struct devlink_dpipe_table_ops" only contains some function pointers.

Update "struct devlink_dpipe_table" and the 'table_ops' parameter of
devl_dpipe_table_register() so that structures in drivers can be
constified.

Constifying these structures will move some data to a read-only section, so
increase overall security.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/net/devlink.h | 4 ++--
 net/devlink/dpipe.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 35eb0f884386..db5eff6cb60f 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -352,7 +352,7 @@ struct devlink_dpipe_table {
 	bool resource_valid;
 	u64 resource_id;
 	u64 resource_units;
-	struct devlink_dpipe_table_ops *table_ops;
+	const struct devlink_dpipe_table_ops *table_ops;
 	struct rcu_head rcu;
 };
 
@@ -1751,7 +1751,7 @@ void devl_sb_unregister(struct devlink *devlink, unsigned int sb_index);
 void devlink_sb_unregister(struct devlink *devlink, unsigned int sb_index);
 int devl_dpipe_table_register(struct devlink *devlink,
 			      const char *table_name,
-			      struct devlink_dpipe_table_ops *table_ops,
+			      const struct devlink_dpipe_table_ops *table_ops,
 			      void *priv, bool counter_control_extern);
 void devl_dpipe_table_unregister(struct devlink *devlink,
 				 const char *table_name);
diff --git a/net/devlink/dpipe.c b/net/devlink/dpipe.c
index a72a9292efc5..55009b377447 100644
--- a/net/devlink/dpipe.c
+++ b/net/devlink/dpipe.c
@@ -839,7 +839,7 @@ EXPORT_SYMBOL_GPL(devlink_dpipe_table_counter_enabled);
  */
 int devl_dpipe_table_register(struct devlink *devlink,
 			      const char *table_name,
-			      struct devlink_dpipe_table_ops *table_ops,
+			      const struct devlink_dpipe_table_ops *table_ops,
 			      void *priv, bool counter_control_extern)
 {
 	struct devlink_dpipe_table *table;
-- 
2.45.1


