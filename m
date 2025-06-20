Return-Path: <netdev+bounces-199705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F562AE188B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AFD7A29A1
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB117289E0E;
	Fri, 20 Jun 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idy44S9u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6C283FEC;
	Fri, 20 Jun 2025 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413803; cv=none; b=OUaMMsCgyPpt5aWHyCCDWFlAptPZbQf4sPCiJZjJR62T6aVvrEEtJ1X4Eb9DAa/sWTkbClCZr677oFkqP6x5933BTeHu38Jbg6As7tO4ft1bt2WO+5tvU+vXPkwzdfDp5qRQc8xeQ8SgdKzQRacBXjODD2c1j3nTiJwTHVvLmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413803; c=relaxed/simple;
	bh=a6RQOtRl7tToqDq2ykyZySv8IKJOLXNE4RWsM7IKe8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hRrry8pR0wapQ3NvVzTaqkwDa5dAXgxiIqGsdPlo7m2HKC1BYnDFwYukNMolWOB7wOXOj1HUf70O05Qk+4m4q9L/BBQb/XDfMFWl40o1oU/jZfX61DYK58uV2/6HFXHoh3ZI7l08FIt/cykXGLTnXGjVWSH1TGTD2fZfA6yRIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idy44S9u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750413802; x=1781949802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6RQOtRl7tToqDq2ykyZySv8IKJOLXNE4RWsM7IKe8c=;
  b=idy44S9uHutwn0Z95OpI176AI5xUetHYspEzf0Cpf8E2KZ691aalm7IF
   QON1ck35O6eS82yy4YVsg6+gDKlozimhOe75NIYRd3WSW+4yezDFX1zPi
   hC1SNl4mj/bG3dyjXXNCksb27TMNziRJzpI9+Er6pmkhycGu9806NgPEG
   GSddLJIl/4rZWNZx4bOwJm456FDg2/iUAh8oWMTjLMX78qLVYsy3LtVjp
   kHIwo9c+IbI1StkWccTkWgXZquG5nW8raUnuLrh0T+aS8EqSzxtRBy5xw
   nVs5YkHwNLc2N7FUlQpPEaC4TRSh376hRaAdAj0JogB1HwGfu1i9VWcMP
   Q==;
X-CSE-ConnectionGUID: AeY0r3ltQMiuP7DxG7kV/A==
X-CSE-MsgGUID: hD6iTrozRuWgKfPYWwUCXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52817068"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52817068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 03:03:21 -0700
X-CSE-ConnectionGUID: 5ah90r50SzKx18OqVXdLVA==
X-CSE-MsgGUID: Vy074tasSTmFIH9DVwZZtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="181744778"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jun 2025 03:03:16 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Brett Creeley <bcreeley@amd.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next,v3 0/2] igc: Add Default Queue Support
Date: Fri, 20 Jun 2025 18:02:49 +0800
Message-Id: <20250620100251.2791202-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set introduces the support to configure "Default Queue" during runtime
by using ethtool's Network Flow Classification (NFC) wildcard rule approach.

v3:
  - separate macros relocation code that not related to wildcard rule to another patch (Brett)

V2: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20250619153738.2788568-1-yoong.siang.song@intel.com/
  - use Ethtool wildcard rule instead of extra uAPI (Jakub Kicinski & Jacob Keller)
  - combine MRQC register definitions into a single location (Kurt Kanzenbach)
  - use FIELD_PREP (Kurt Kanzenbach)
  - use RCT rule (Wojciech Drewek)
  - no need brackets for single line code (Wojciech Drewek)
  - use imperative mood in commit message (Marcin Szycik)
  - ensure igc_ prefix in function name (Marcin Szycik)

V1: https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20240730012212.775814-1-yoong.siang.song@intel.com/

Song Yoong Siang (2):
  igc: Relocate RSS field definitions to igc_defines.h
  igc: Add wildcard rule support to ethtool NFC using Default Queue

 drivers/net/ethernet/intel/igc/igc.h         | 15 ++++++-------
 drivers/net/ethernet/intel/igc/igc_defines.h |  4 ++++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 18 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_main.c    | 22 ++++++++++++++++++++
 4 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.34.1


