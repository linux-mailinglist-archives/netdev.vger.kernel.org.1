Return-Path: <netdev+bounces-211374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06414B1868E
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 19:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357B317266B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB31DED47;
	Fri,  1 Aug 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gp/uKjh6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213D8F66
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068971; cv=none; b=gEfHeLGlVgpAF1P+OqRkf5GCLlnT2ODSz55sLaxfpRWsBan0GVR/O4Sszb84qCZ3QiQyWe753qGVz9Jmf/pvl74dJ1Eh8774qiuEFJROUgF+6CmXFqNMKGf7I2dnXCHZWPg+mBR4niXH4KYKJDFsUwCY6hsHCLGRw9H9ZJj3D1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068971; c=relaxed/simple;
	bh=C2Y43f8+A0TYviky8U5IL18doPyRUKbyPM4d177ATTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hz2u1ovmY33IaA6sMwh71G6EOlbOhuspKYfns2sOWNZWQjLjbboWdsJyH/rEIbJT9rivR14T+6E5dkVohUah3EWKTXvjvhUxiJxJ8A87+YpawiOLMIT/wMY/nU9ptBKypqhdZP9YNgGHIaku2dZNkvWZro3P8X3Mw6c2m9rt6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gp/uKjh6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754068970; x=1785604970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C2Y43f8+A0TYviky8U5IL18doPyRUKbyPM4d177ATTE=;
  b=Gp/uKjh64CUR4+bhdFyrXuEZDDLliDsL1DzlYd84GO7ePZN2spNB855q
   qVSayIwRGXiasOCnceQATFQezP9rveMGN650z+lA8LkOaQtOaRE51dT9Z
   t8RB3RdKH+dexcFqueABSgVqdXYiOhicZLJphTEtXV8H6/w89d7tsbSpm
   96M/+PKbcbtCL25Ld2ZP358BPyMv6U+K1fVtRAmadH/8GNeZIlDjCqgsl
   pgH26/GFFYe7nmnDPwz1IORlO104puiXZkkjDuMzfNeHdJtK56VUM4wFn
   iHrXsvvYFoqctP51C5SOvBlVF1jXdJaPeV7Teq0BToNMSKQQA7LAn7Ews
   A==;
X-CSE-ConnectionGUID: hxOSpZZbSyKc3V5dhviwgQ==
X-CSE-MsgGUID: W4xhZa8YRgKtpNTd9mz98Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="59044377"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="59044377"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:22:49 -0700
X-CSE-ConnectionGUID: xvQF6/tiS0Ok3ogbWiWd0g==
X-CSE-MsgGUID: ppxpXdXcS4GeAl5TC5YwEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="168915243"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 01 Aug 2025 10:22:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com
Subject: [PATCH net 0/2][pull request] ixgbe: stop interface name changes
Date: Fri,  1 Aug 2025 10:22:36 -0700
Message-ID: <20250801172240.3105730-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jedrzej adds the option to not rename devlink ports and opts ixgbe into
this as some configurations rely on pre-devlink naming which could end up
broken as a result of the renaming.

The following are changes since commit 01051012887329ea78eaca19b1d2eac4c9f601b5:
  netlink: specs: ethtool: fix module EEPROM input/output arguments
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 10GbE

Jedrzej Jagielski (2):
  devlink: allow driver to freely name interfaces
  ixgbe: prevent from unwanted interface name changes

 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 1 +
 include/net/devlink.h                              | 7 ++++++-
 net/devlink/port.c                                 | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.47.1


