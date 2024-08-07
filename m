Return-Path: <netdev+bounces-116619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08C094B335
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 00:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8EF1C217C2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE115572F;
	Wed,  7 Aug 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqBZyhLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953A1553B3
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070729; cv=none; b=m3zxi7mczcjxvu87d7MS4m3OOl7+F5uDlvCFzOdRKtmelZAsGO6d2jgkCEazhuAmRcg30V7i8MrwAQjKwviK3FAFsyLkZkpYhSXK6u0eNvdPaDdn7VlXtzqZ3OSEgJJunGD7bKY5cKza+RK1RWWAAEzZzKublWtLXQKpDM8MstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070729; c=relaxed/simple;
	bh=k24qoHhs6HzRJ1hQdy0U+DS/QK/x+/V5aLTduI9/0IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPQKx4byCkZx5uovQj1qvdZkHYKtvPcjp7DY51hfdPCd0FnAL47trYiOlppiRPxjkgK+dJKoFa2nqsdewNrajoxqZ5Sw0+fUDoV/tMHlS9GRBKAIQSyYr0mPerPSE7TiQN4H7pMP/uK/lgfsdgceJNtAErsTFD7n7xVu6mXdy8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqBZyhLJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723070728; x=1754606728;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k24qoHhs6HzRJ1hQdy0U+DS/QK/x+/V5aLTduI9/0IE=;
  b=BqBZyhLJutwvJsz+lcHkJ0UojFJ483dBgFoz7fzW5G+xnUMhEJ1atQn5
   ujwuUqk1cDAlj5njHVl5q3w36bMt6OZbJxMhqmaLCNCAdfJ6AlwQ028yl
   okibF9Lj6oiox1sy8qz3QBry1AcOcydX/GRojOV28EjOKj+LjSVqYpPq/
   Sk9tw+wnY1ILYG7dabXcgysbHqURF5Byxkt7OkOFPmteCVSkTDFvOSvgj
   6lPY5VhYJSvCqSosLZxMIDfHh8qRPGjzvRLW+InzSErYPoujlKPKqzU7x
   4+pIZJ80hpGp8S71AqBQJSp1vwOMivJVNdOb5p0iBPe9HtNNCg058iIxq
   g==;
X-CSE-ConnectionGUID: GXrhBX1/S86OxjZxgABqqg==
X-CSE-MsgGUID: Qh1veXo2SOqhyg2OJURFmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32573956"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32573956"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 15:45:27 -0700
X-CSE-ConnectionGUID: eJ72+9m1R5CaT2iCKt2kPg==
X-CSE-MsgGUID: KFdLFJ+pT0y5S29F4+gW9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57088286"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 07 Aug 2024 15:45:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2024-08-07 (ice)
Date: Wed,  7 Aug 2024 15:45:17 -0700
Message-ID: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Grzegorz adds IRQ synchronization call before performing reset and
prevents writing to hardware when it is resetting.

Mateusz swaps incorrect assignment of FEC statistics.

The following are changes since commit 1ca645a2f74a4290527ae27130c8611391b07dbf:
  net: usb: qmi_wwan: add MeiG Smart SRM825L
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Grzegorz Nitka (2):
  ice: Fix reset handler
  ice: Skip PTP HW writes during PTP reset procedure

Mateusz Polchlopek (1):
  ice: Fix incorrect assigns of FEC counts

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 ++++----
 drivers/net/ethernet/intel/ice/ice_main.c    | 2 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 4 ++++
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.42.0


