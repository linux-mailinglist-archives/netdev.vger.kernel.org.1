Return-Path: <netdev+bounces-197038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A1AD7691
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98101893DA7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4492D1F7B;
	Thu, 12 Jun 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fv2yf8lf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF02BCF53;
	Thu, 12 Jun 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742481; cv=none; b=VNyuj7ZFCDQ3BvVkZFiwsO+AiS1vAupUg7bHu2VQXm0uopVHilBTcRGJDovxZq0ZDGrq2MiXLYCdCMoo3kWXDGxdPN/TondYyJnv5kpFrUnqy3YJNVuG1YgjIykSMMaEFttSm4cxMw0XJ/zoZxzERLNGipYnWOtV1dVjVlUIVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742481; c=relaxed/simple;
	bh=kgz7hkjs7V+1CTp7FE7nxkTThIrJ7WPiUY0Og7QBt6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tq4gTQBFXu3czYK0RKvJ9qHhG3StQkxjTFDV38c+v/xfVdV4/x7AUNDLKZePTIZe9DB4jnTZUKZ1tNFSxZknZOfBzO3YOxluqjfflTrbpVXS8BfLsxH8GddRCXMNpJE0Kef9/z3PB3evtCBulWyliWSI/q2ab7EEGog1VXb1Ang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fv2yf8lf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749742479; x=1781278479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kgz7hkjs7V+1CTp7FE7nxkTThIrJ7WPiUY0Og7QBt6s=;
  b=fv2yf8lf1zBIqIJl6z8W7+pahLoccF1UNEBs2j7tNmstiqnNY6j1cmsx
   5uA2wn/Nk0WZOmL8J32Fd61wMLKKN2JYQRGQPd8YutjR4YBxuQzTRmyVQ
   1S653/uGZ+zggLa1xirJtSiag1fCX+f8ek1ny+NdGUEVig+VyPoL2wKgI
   BQSBaovNeYREuR42McnccoHA1JMQWmU5l9TUHp2BT2yw2Q0GjPCfN6qcf
   UdGVWLQRUyYLVSHaG7uTbAEIXiYrUWFz2cp//jCkEWlnCdOc/qdQSrQY5
   4hhrgW40gNBkSb8uVZRIQb18vpyQnjrnk+SSsN+Y6iSAYvVYiENcJmudJ
   g==;
X-CSE-ConnectionGUID: blzEp3RwR2KJAWuEa9iIiQ==
X-CSE-MsgGUID: Fe9AH1UTQ9SMcGC9ZeqKdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51158626"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51158626"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 08:34:38 -0700
X-CSE-ConnectionGUID: KQxa3/YaTiaVpno21ucPrw==
X-CSE-MsgGUID: 0RPavKa+QLyIObq2Twog7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152546791"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa004.jf.intel.com with ESMTP; 12 Jun 2025 08:34:33 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	aleksandr.loktionov@intel.com,
	milena.olech@intel.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v6 0/3]  dpll: add all inputs phase offset monitor
Date: Thu, 12 Jun 2025 17:28:32 +0200
Message-Id: <20250612152835.1703397-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dpll device level feature: phase offset monitor.

Phase offset measurement is typically performed against the current active
source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
the capability to monitor phase offsets across all available inputs.
The attribute and current feature state shall be included in the response
message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
In such cases, users can also control the feature using the
``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
values for the attribute.
Once enabled the phase offset measurements for the input shall be returned
in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.

Implement feature support in ice driver for dpll-enabled devices.

Verify capability:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --dump device-get
[{'clock-id': 4658613174691613800,
  'id': 0,
  'lock-status': 'locked-ho-acq',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'type': 'eec'},
 {'clock-id': 4658613174691613800,
  'id': 1,
  'lock-status': 'locked-ho-acq',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'phase-offset-monitor': 'disable',
  'type': 'pps'}]

Enable the feature:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do device-set --json '{"id":1, "phase-offset-monitor":"enable"}'

Verify feature is enabled:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --dump device-get
[
 [...]
 {'capabilities': {'all-inputs-phase-offset-monitor'},
  'clock-id': 4658613174691613800,
  'id': 1,
 [...]
  'phase-offset-monitor': 'enable',
 [...]]

v6:
- rebase.

Arkadiusz Kubalewski (3):
  dpll: add phase-offset-monitor feature to netlink spec
  dpll: add phase_offset_monitor_get/set callback ops
  ice: add phase offset monitor for all PPS dpll inputs

 Documentation/driver-api/dpll.rst             |  18 ++
 Documentation/netlink/specs/dpll.yaml         |  24 +++
 drivers/dpll/dpll_netlink.c                   |  69 ++++++-
 drivers/dpll/dpll_nl.c                        |   5 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  20 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  26 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 193 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   8 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +
 include/linux/dpll.h                          |   8 +
 include/uapi/linux/dpll.h                     |  12 ++
 12 files changed, 384 insertions(+), 6 deletions(-)


base-commit: 5d6d67c4cb10a4b4d3ae35758d5eeed6239afdc8
-- 
2.38.1


