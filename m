Return-Path: <netdev+bounces-159057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286FA143F7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247AB16B883
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11C2419E8;
	Thu, 16 Jan 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7W72qq2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51C236A81
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062477; cv=none; b=WjSnL377OCEqEOKwnGU5petlSKTmrEzkIYVQN180tJJqD+Or8Ypn3T8xzBhmdHN3yPNztJ5Py4ijU/ANGqDP7ZJ53Y4BbP1kzGMqJPsuPJ4/ngrQewcZOXWzf/cEDqTfDhsVVHbj2mgzgTr7Gs1Ic7wgbL+GiBd/kf/2z52wzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062477; c=relaxed/simple;
	bh=oaSxKAQMpS13TWHgbFGz0i7yncnkmJ9XJbS46aO6428=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fG9ohDO4qhATcjJPnMVuSkXRCzuQ8Ty0Axjjp9gRbm6WycTgDvfmpc/CrzVpUsvpAb6kxiv3B7HJGO+EtP7AxKzGszbk652fkrDZ1qDY6Cvjm2rOM3JQZddzAHHcvDhZpuzIyIlvQGu3qYGiFSWmM4s+/PekPgwzANhSVENvYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7W72qq2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737062476; x=1768598476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oaSxKAQMpS13TWHgbFGz0i7yncnkmJ9XJbS46aO6428=;
  b=K7W72qq2ibLPUqyk5EffxY2fUAPSpH7sA/qEsk7LFK4I7dCQ4rRyAdtZ
   flOiiWJqnnG5JZvhK5KwzBaacrBYHkhxQc0aknTW/jx2afDvx9Mc+pU+I
   7M2f5GqlGsriYTXORI5H49gDpdTV0robruL2yDs6XCQQ79SaGddpa1wDF
   /lP6qBjRUEtUUmFnwVO/m/DJIZKFXwJWJ5QQbEOPgbQsFqOU1ucAynVDn
   PLUbPqewIAvwE6b2MFllU6l8A5M5h760cuSVVgPIId4c+so/QlO97V5cR
   5FBNthocIbwUa6vAGA70bh0sXNDK1LhUzKYOZk8XXqfOuoYTgtSAfPUmX
   g==;
X-CSE-ConnectionGUID: Q5OUnJf1SJy/O/BWrYexMw==
X-CSE-MsgGUID: yDMWPJHvQGqgp2yRUXh8eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="55019530"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="55019530"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 13:21:10 -0800
X-CSE-ConnectionGUID: VmKo/AKCROGeJ9vzjeiwiA==
X-CSE-MsgGUID: pU4g3ONsQdes+SNhKjEK5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105572572"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jan 2025 13:21:10 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Konrad Knitter <konrad.knitter@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us
Subject: [PATCH net-next 2/3] devlink: add devl guard
Date: Thu, 16 Jan 2025 13:20:56 -0800
Message-ID: <20250116212059.1254349-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
References: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Knitter <konrad.knitter@intel.com>

Add devl guard for scoped_guard().

Example usage:

scoped_guard(devl, priv_to_devlink(pf)) {
	err = init_devlink(pf);
	if (err)
		return err;
}

Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/devlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index fc79fe2297a1..b8783126c1ed 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1535,6 +1535,7 @@ int devl_trylock(struct devlink *devlink);
 void devl_unlock(struct devlink *devlink);
 void devl_assert_locked(struct devlink *devlink);
 bool devl_lock_is_held(struct devlink *devlink);
+DEFINE_GUARD(devl, struct devlink *, devl_lock(_T), devl_unlock(_T));
 
 struct ib_device;
 
-- 
2.47.1


