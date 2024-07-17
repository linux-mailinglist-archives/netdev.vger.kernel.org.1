Return-Path: <netdev+bounces-111916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904EE93417E
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51231282A7D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32817FAC1;
	Wed, 17 Jul 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idT2ikCO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE331E4A6
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237376; cv=none; b=eXXt7wrtZ9cNwIOtJXSwNpjcGscOhVUlSoFrovHEvCVD+GsDRrcUbhMcWnLeGm5kABaa8cEMu8dsrS5HisEoUBuk+Vt5fUXrh3QztSJVSgv5aBWM1UvxFamPdNZCbfcEoQzVcE0AhZLxi+VB3/0naDOi9FdbnmxIRw0v0hHsO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237376; c=relaxed/simple;
	bh=Ml2bcml28aoeNE00ipDrA8uHTGL++Vh8ShvQ9yl2PTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blRnoRYD6kM5oVx61dXk7t7+eIlPuIQWqOhTshGwLWEdg7u9fvMzwiLurBEdq062SAchayKcFvLMZe81dKTXDta6/e0om/ugx5YDb6K+Fpj24Bbji9re91cau45LqdGSzQjF9z4PmEzVQdcn94ssVXvRUlKc1+VslVrphHSpmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idT2ikCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2D0C2BD10;
	Wed, 17 Jul 2024 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721237376;
	bh=Ml2bcml28aoeNE00ipDrA8uHTGL++Vh8ShvQ9yl2PTw=;
	h=From:To:Cc:Subject:Date:From;
	b=idT2ikCOaS0G0SqaV+d9HRmY4O+7xApFXfgv3Iny5/othQn5E5+V1Ze7sq4XkRev6
	 RVLWIJRAvwWhAz7j9iFrvXufx+uYQhPwM72NpnhZKw45YWdZYcUplSVht4K+6n/4wx
	 oUjjwpwTSdXpxHDk/VB4Ckuv+fl0OTgcyhY3Bm+QCInq0d4WSFMgovFIEHGDLfPPv4
	 iD7lQTZ28bf0O2MwhkfVJrvsAZywqpGv9O8X3bBfrbczRN6vPkvfbjv/dZXnPNX0rE
	 qkkUC4QxUz5FQW2oRTGwk/mzY9xQNBUkfYXWw48xpORjkHeXuHfaA3WPrm7wwJZsTX
	 fMKOSkbXmW50Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH net-next] driver core: auxiliary bus: Fix documentation of auxiliary_device
Date: Wed, 17 Jul 2024 10:29:16 -0700
Message-ID: <20240717172916.595808-1-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Fix the documentation of the below field of struct auxiliary_device

include/linux/auxiliary_bus.h:150: warning: Function parameter or struct member 'sysfs' not described in 'auxiliary_device'
include/linux/auxiliary_bus.h:150: warning: Excess struct member 'irqs' description in 'auxiliary_device'
include/linux/auxiliary_bus.h:150: warning: Excess struct member 'lock' description in 'auxiliary_device'
include/linux/auxiliary_bus.h:150: warning: Excess struct member 'irq_dir_exists' description in 'auxiliary_device'

Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/auxiliary_bus.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 3ba4487c9cd9..1539bbd263d2 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -58,9 +58,10 @@
  *       in
  * @name: Match name found by the auxiliary device driver,
  * @id: unique identitier if multiple devices of the same name are exported,
- * @irqs: irqs xarray contains irq indices which are used by the device,
- * @lock: Synchronize irq sysfs creation,
- * @irq_dir_exists: whether "irqs" directory exists,
+ * @sysfs: embedded struct which hold all sysfs related fields,
+ * @sysfs.irqs: irqs xarray contains irq indices which are used by the device,
+ * @sysfs.lock: Synchronize irq sysfs creation,
+ * @sysfs.irq_dir_exists: whether "irqs" directory exists,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
-- 
2.45.2


