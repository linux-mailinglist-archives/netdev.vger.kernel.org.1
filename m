Return-Path: <netdev+bounces-112769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7442F93B1C3
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05992B226AB
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F38156C5F;
	Wed, 24 Jul 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3gt2zeg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34022089;
	Wed, 24 Jul 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828445; cv=none; b=tEeN5jrwS/6Wq7i+2xq3Sw3cZJWP0MN6I8Pno+4lqYm5CL1FDtD8hh6NgKZsh4g0PpdV7qy/K+gYT4vfNRHr3C9/9kUwJWogcDetp0huMk6cV4rK0Mr1Ohv9VW+zqBQyxpPw3nPfcDD6JFayUoMlcRIvBN6h+YpOKcLtwzKQI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828445; c=relaxed/simple;
	bh=0dUlSwLv3mwvkv5Kz61djZ1AXbh+Q3AHHVb7An338Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFCw5kKMa80BPVQt2xbADh/GbKiJRiuWQrgUNY68XQ+nI6EA5uHZqqoeawFKbxqQXjTBIEewbzefX5c4uvmdrQJ4U3uyrfQcbvsO/DP7rlQb2Pb02Z1aJXxHB9Cl+lvDYh8sPLxaby7te8NZhH2yritN3KSJKYpOUsvuS72stcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3gt2zeg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721828444; x=1753364444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0dUlSwLv3mwvkv5Kz61djZ1AXbh+Q3AHHVb7An338Ec=;
  b=K3gt2zegzPLKF/80kI/aU7PgmnwrF2q71Ge6p00v6ia94Lok/+yw37GE
   r3n+NLERZwfGFltMBagssO9uSIMpS+y4Xfuyg2rOg8yewLomuiEBC3ZeF
   yrZnbc3ES3Z69Rc6ftAgRYe0G8vXTEIzxCqdSwhnFgT1Bd7EAzhs7Jm45
   pmoey8dBFhGFcQd9wIqW38XIK80FkiAcBzX8c+SGkAMLBQzF8qNWCeueL
   KNGcM8vdKnJUB1q2j0VxT7QeCGFv0XW6yN7vRN2lcypiuie0df06wuZtk
   rN8n0TVUTF4ofwCl7J5H5IuliRrHqIAkJe1hs165LohwDV16EPMxWMKde
   A==;
X-CSE-ConnectionGUID: CeB40VzvQASChld2cXcSUw==
X-CSE-MsgGUID: py9DQGN5SFumCdpr5CMw4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19469364"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19469364"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 06:40:43 -0700
X-CSE-ConnectionGUID: IdraOJDqQuC9OVR6+RcmMg==
X-CSE-MsgGUID: KhNxVgLOQKyD+//WxKbLoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52615636"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 24 Jul 2024 06:40:41 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 0/3] idpf: fix 3 bugs revealed by the Chapter I
Date: Wed, 24 Jul 2024 15:40:21 +0200
Message-ID: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libeth conversion revealed 2 serious issues which lead to sporadic
crashes or WARNs under certain configurations. Additional one was found
while debugging these two with kmemleak.
This one is targeted stable, the rest can be backported manually later
if needed. They can be reproduced only after the conversion is applied
anyway.

Alexander Lobakin (2):
  idpf: fix memory leaks and crashes while performing a soft reset
  idpf: fix UAFs when destroying the queues

Michal Kubiak (1):
  idpf: fix memleak in vport interrupt configuration

 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 48 ++++++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 43 ++++--------------
 2 files changed, 33 insertions(+), 58 deletions(-)

-- 
2.45.2


