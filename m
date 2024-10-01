Return-Path: <netdev+bounces-130807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9885B98B9D5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9141F235E4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196A61A0AF2;
	Tue,  1 Oct 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1PIbuOm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD519F429
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779242; cv=none; b=izs1v8GWIPwNymmruLR++mxY/WRYIvbRbzwWTTHI552H4X4K1+fyRW6LZP3MQ0TRq+nylogQh/tj1KcFY0MPBnSzwe/k8skefBBg8xCLa+1i494G2bISS2YOGgsNEClFWZxgq1Lsf4C48iflv0HZ0lGjY1Kis7gQHqpn1iwe8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779242; c=relaxed/simple;
	bh=AC4nt/hIi7YclL0fsOm041GyvxgfORC0BiVRrckpBzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKYMXqJL+n0e8KWwpkoR9O/YpgFksp2x1Jpqy1v1PlnTn21RmjTw0y/XwUuTJXbUcDqc0x5IJ4JKo/izqXXPYDNbAANFELj+wik0gPG+NeE9GfXfySeWZUm0SjVfdSm/BFoIO6F6D1fzNsFwqYhD/6Q6xbcDOSHSQTN0lt5Ft+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1PIbuOm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727779240; x=1759315240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AC4nt/hIi7YclL0fsOm041GyvxgfORC0BiVRrckpBzg=;
  b=l1PIbuOmfkydjF/m6ErtjwdOc5FDeQrkiWevIVZxpLxLw83yG/q3UE/a
   BWToVVclRnjjro/gYb8HODDTs04WG7mHdQmsOUhroV2rXPYJfJInbx5BZ
   /SHBS7O9kI7TnUs1tKiJ4x3P5+XKl9JKKQRFlirJOq8i0CruXh51LIVeV
   Dxf4S7JlfvA0y+EPUrnIgFvV2viMT1emynMDcoTLWDzer7nEVJcXXlura
   TedngV7BKxOHmFKaR5Aj7Koy/2ZmzXNulEiWrk4/z4PL+LD8xHvYcvt1I
   3G+7rJTpKc/bKcCrnQw5+oNs5sXaUK6WPRhbXwlC8ACj8S+iG5ArCqTes
   w==;
X-CSE-ConnectionGUID: emlDlBKXSRiEcE6MGj4NYA==
X-CSE-MsgGUID: lFbHgP76TCaEKbzDTZGTjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44433907"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="44433907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 03:40:39 -0700
X-CSE-ConnectionGUID: GoZVddivRa+m88kEZ4WDNQ==
X-CSE-MsgGUID: CMWetsxARrujVleCRsVC9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104447751"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 01 Oct 2024 03:40:38 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9F0A527BC4;
	Tue,  1 Oct 2024 11:40:36 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next 0/2] Extend the dump serdes equalizer values feature
Date: Tue,  1 Oct 2024 06:26:03 -0400
Message-Id: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the work done in commit 70838938e89c ("ice: Implement driver
functionality to dump serdes equalizer values") by refactor the
ice_get_tx_rx_equa() function, shorten struct fields names and add
new Rx registers that can be read using command:
 $ ethtool -d interface_name.

Mateusz Polchlopek (2):
  ice: rework of dump serdes equalizer values feature
  ice: extend dump serdes equalizer values feature

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  17 +++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 110 +++++++-----------
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  39 +++++--
 3 files changed, 89 insertions(+), 77 deletions(-)


base-commit: 3b26fcd8529dc446af79c6023a1850260ceeaba7
-- 
2.38.1


