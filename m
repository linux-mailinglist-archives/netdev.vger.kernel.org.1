Return-Path: <netdev+bounces-212264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6CB1EE00
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725725A123A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095661F4CAA;
	Fri,  8 Aug 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5t870wP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43541E1E19;
	Fri,  8 Aug 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675117; cv=none; b=ZVhblmz1qcjlVqFauBeoVTnnua3o/jNhVxKY0zmdSIrtkY0F7JSa0fcsg1zcrRtcNiBrq0pgj1sHVFniDMP3Pf8kwck0+lADBSTHnGtpIbIVMWLLMxZRnPw7u/uCsyT17SFjjWaPUIKqkQHRvf44a1N4sc2CsPP1Qq319qkPT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675117; c=relaxed/simple;
	bh=UVukXqaBHBLJSuReTQ6CWOB4K+vGCgV0gGvwymfp5kg=;
	h=Subject:To:Cc:From:Date:Message-Id; b=Z8XpBjpBqYVHRr19UYqpybcFURNb7UUJuFIAK2OTsZBJFPZBhspkIuoXM5Qk1nSgi3RspE25bjZU0Ib3IG+I4cLAGfUdRbQDv+XXIWRJLVnxXD7Vmf0cvVAy/MdHJ/v8v2SDm+Vr77uL+H40iRKUx6M4zJqCtsDt/51Va4fsH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5t870wP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754675116; x=1786211116;
  h=subject:to:cc:from:date:message-id;
  bh=UVukXqaBHBLJSuReTQ6CWOB4K+vGCgV0gGvwymfp5kg=;
  b=U5t870wPq0IXa7LJTqLEcZxx52bCxxSGZoHnqfcEw69xVS5APj0blTYy
   eAYR8SS4/Jq0ixajkAxFWjAgAglQ4EracGgGBRcGUav1SE9HwHz+ekZ0N
   OBv8C4eLEluww5OBQDBpiPXpkHwopqtAnVd5GE3aPN6i4sV+lpm9iSJuJ
   5UoElXfieiKgqm7UjIQVDqoXpwuB7P611Bs+oYPU+P2hSbCXV1bIjD+oA
   o95sm3ihxagsZ00pxw5S/3YuWj0u4fzz/SSPz8roRCApqWHgi6ukVg/yQ
   JUYtL6HoqxlvKnalycAwXiYdSJgQ50CpR443HvfryZ8OQyQU4Mjj2HJ+c
   w==;
X-CSE-ConnectionGUID: ZQpU4ZprQf+3l9jf//EL2A==
X-CSE-MsgGUID: oQYdc7azQIebBmTDIgdIlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56063838"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56063838"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:45:12 -0700
X-CSE-ConnectionGUID: KGThBB1MTaSUiBXU8o2YZQ==
X-CSE-MsgGUID: /PEAKnKnQIKNHm2+tWd+KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="202566839"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa001.jf.intel.com with ESMTP; 08 Aug 2025 10:45:05 -0700
Subject: [PATCH] MAINTAINERS: Mark Intel WWAN IOSM driver as orphaned
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Loic Poulain <loic.poulain@oss.qualcomm.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 10:45:05 -0700
Message-Id: <20250808174505.C9FF434F@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This maintainer's email no longer works. Remove it from MAINTAINERS.

I've been unable to locate a new maintainer for this at Intel. Mark
the driver as Orphaned.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---

 b/MAINTAINERS |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN MAINTAINERS~MAINTAINERS-20250707-5 MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-20250707-5	2025-08-08 10:39:37.235217068 -0700
+++ b/MAINTAINERS	2025-08-08 10:39:37.253218644 -0700
@@ -12722,9 +12722,8 @@ S:	Maintained
 F:	drivers/platform/x86/intel/wmi/thunderbolt.c
 
 INTEL WWAN IOSM DRIVER
-M:	M Chetan Kumar <m.chetan.kumar@intel.com>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/wwan/iosm/
 
 INTEL(R) FLEXIBLE RETURN AND EVENT DELIVERY
_

