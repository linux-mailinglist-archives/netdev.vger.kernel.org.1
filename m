Return-Path: <netdev+bounces-215059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08E4B2CF44
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8DD687D2E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE2C31DDA0;
	Tue, 19 Aug 2025 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ns9TnZXC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA07F31DD81
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642008; cv=none; b=Wkdhre2uxtMg7PHfioN2Suh8/S5XRlcAYV6nwhV6seCvioiePxkDTp8Av5KjDDFPbp6tNGoFyxPl/WNFNelMRe+T4T2+gG1H5jobCzBOmacyW4AAV7d0YfSJpGlPf5wvbjgi3812zAy4dMpMdjgY7HBQeAGZOeqvgbkLNcXsThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642008; c=relaxed/simple;
	bh=6F9TlIeMjNBAgf3BO3eCjOcPgLbSWc016FuZZUFGoI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAwXQvmZsZkOgWqZPt6DW8qAu7AQtDFoj6NdlooHtYhGukZVUJ7veuAV2nd15rH4w5BaaXmV0tMSqpb1zwVt1lKobva/qMuluFsXMn4n3SKNUJXLA5vYJAKfym81+2sGFBjBZhD6opb630o8De14qcqeVXQUmMs467AO58tOGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ns9TnZXC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755642007; x=1787178007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6F9TlIeMjNBAgf3BO3eCjOcPgLbSWc016FuZZUFGoI0=;
  b=ns9TnZXCbxiL9uEwr/ii/+k/aSCiJB9tEfHdxulcLUq/oY0eDm4UHM+1
   fIDy4a3tSmt0p3eQ07WcZ3jm9jCDO0EKlOEuln/N3IEj2Hb9knw6NooPK
   txY/q7ps+OKUguwwd2Dt87do6cdHt3BTVIdbcHUwiOiXnA4O3yOwfdy9y
   SvgFIwmgfy381Z4M0/KWDMOcpM6hPfbpoNaBHUfpqXUcuACVnAES+vdap
   IRHDQUp85GA+qpiQvoAXkV95PmP7l+sJvffcW4lxigniPhtZ/9Z4h/jVU
   zctXfbcZ4JpLsUYCMvTL+B6M6Eio+DXkYAlPslqVFuh+MKF+SLazsofyl
   g==;
X-CSE-ConnectionGUID: fxKOfoaJSo6QkH9LBr7R0A==
X-CSE-MsgGUID: ovfCQJ06TL249slLWttY6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57829558"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57829558"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:20:05 -0700
X-CSE-ConnectionGUID: 1aqH4lxcQzWk1F2mDG8b3A==
X-CSE-MsgGUID: 59ZKRaizSl+9bcwkeCCosw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173202842"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 19 Aug 2025 15:20:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	tatyana.e.nikolova@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v2 2/5] ice: fix possible leak in ice_plug_aux_dev() error path
Date: Tue, 19 Aug 2025 15:19:56 -0700
Message-ID: <20250819222000.3504873-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Fix a memory leak in the error path where kfree(iadev) was not called
following an error in auxiliary_device_add().

Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_idc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 420d45c2558b..8c4a3dc22a7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -322,16 +322,12 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 		"roce" : "iwarp";
 
 	ret = auxiliary_device_init(adev);
-	if (ret) {
-		kfree(iadev);
-		return ret;
-	}
+	if (ret)
+		goto free_iadev;
 
 	ret = auxiliary_device_add(adev);
-	if (ret) {
-		auxiliary_device_uninit(adev);
-		return ret;
-	}
+	if (ret)
+		goto aux_dev_uninit;
 
 	mutex_lock(&pf->adev_mutex);
 	cdev->adev = adev;
@@ -339,6 +335,13 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	set_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags);
 
 	return 0;
+
+aux_dev_uninit:
+	auxiliary_device_uninit(adev);
+free_iadev:
+	kfree(iadev);
+
+	return ret;
 }
 
 /* ice_unplug_aux_dev - unregister and free AUX device
-- 
2.47.1


