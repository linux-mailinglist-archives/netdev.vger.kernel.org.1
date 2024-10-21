Return-Path: <netdev+bounces-137670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 750229A9420
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20EA5B20E7B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A321FE110;
	Mon, 21 Oct 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Udel3NJH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B1170A3D
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553193; cv=none; b=GAKMz4+zeKe0kYMPWopomskUBWXG2fBOLn1cFF0WegOYgQlAdAS/YtrEbUl5gNLhEpQ6WxoC/MWte4DbSNjGlkUKwb+lJPd0yxL5oCpUzF4scC1pT6PFbU+7ad19WzBzf7KlD5gv+37dwbopv0h91hBYWP40Tuqu/zYHJQl8D2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553193; c=relaxed/simple;
	bh=bc30A0giA7Y+mXMMSipCppervGsDyYdn84KYmI7tK/c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RrJvPJsFvMqMm5UyW0HExVG7FUquyNZAAvn6jcvOA6PXvocFWKQYgAMuvnk8hJ77FjREI8tbITyVXdsnbrLp6Y3iQ7+gqI+TRk4FTfgONHHWZh2Xv7xv4ee/IPTlZ+t53MqDBvDqCzT8kW+zis9CMr5ZqdhQ9EVLZ3WuQZmbz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Udel3NJH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729553190; x=1761089190;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=bc30A0giA7Y+mXMMSipCppervGsDyYdn84KYmI7tK/c=;
  b=Udel3NJHo6JN6g1MQ5TkupHsEFIlu1+61v1gUFoc1l8YuA83OAuGbAk4
   a60ZXxxAtrpE59WhD61oElQOeYBcF0tCcnHsMSzoBwhSuIgLv1KnWrNRl
   WiEkZ9kQGlFN17iRs/5vCEZ6FdWRnEQ/keubBHVB9gnAgPcF//XI18yaF
   ZUPAe+yMyHU4KM+O1QGUPQ/ngHOkp+K3g+y94lsWyPBeEyyqNJU7vSPSK
   RLTIzdnI2Ra7t/pzkLap1bKpKY65fl61gUPLJ43GhWxPUDvKF3SoqOs1I
   T/p7vefLgzCJaSirGmwZmM1xMzoltCHgVPa0k57YGIhwwEzJfWzk490P+
   Q==;
X-CSE-ConnectionGUID: 2b1XzKUkT0mELtiDsJzsNw==
X-CSE-MsgGUID: EuE+Q8aoTASCUX0jJnj/OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31927032"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="31927032"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:26:30 -0700
X-CSE-ConnectionGUID: 8qRwh1wQSgO2LyGKfe+v6A==
X-CSE-MsgGUID: SBEHcaI2QJ+ZZUcwoOLO7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79761738"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:26:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/3] Intel Wired LAN Driver Fixes 2024-10-21 (igb, ice)
Date: Mon, 21 Oct 2024 16:26:23 -0700
Message-Id: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/jFmcC/y3M0QqDMAyF4VeRXC/QhA6dryK7cGuqAanSDhXEd
 182vPw4h/+AIlmlQFsdkGXVonMy0K2C99inQVCDGdixJ8eEuk34A5LDi0k+GHWXguybl+/rGPj
 +AEssWf6DFTqwGzzP8wshgNGHcwAAAA==
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jeff Garzik <jgarzik@redhat.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Piotr Raczynski <piotr.raczynski@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Milena Olech <milena.olech@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Michal Michalik <michal.michalik@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, 
 Wander Lairson Costa <wander@redhat.com>, Yuying Ma <yuma@redhat.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.14.1

This series includes fixes for the ice and igb drivers.

Wander fixes an issue in igb when operating on PREEMPT_RT kernels due to
the PREEMPT_RT kernel switching IRQs to be threaded by default.

Michal fixes the ice driver to block subfunction port creation when the PF
is operating in legacy (non-switchdev) mode.

Arkadiusz fixes a crash when loading the ice driver on an E810 LOM which
has DPLL enabled.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Arkadiusz Kubalewski (1):
      ice: fix crash on probe for DPLL enabled E810 LOM

Michal Swiatkowski (1):
      ice: block SF port creation in legacy mode

Wander Lairson Costa (1):
      igb: Disable threaded IRQ for igb_msix_other

 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |  1 +
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |  6 ++
 drivers/net/ethernet/intel/ice/ice_dpll.c          | 70 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        | 21 ++++++-
 drivers/net/ethernet/intel/igb/igb_main.c          |  2 +-
 5 files changed, 97 insertions(+), 3 deletions(-)
---
base-commit: d95d9a31aceb2021084bc9b94647bc5b175e05e7
change-id: 20241021-iwl-2024-10-21-iwl-net-fixes-248b4a7fd259

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


