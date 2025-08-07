Return-Path: <netdev+bounces-212080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F2B1DC88
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD96616FA82
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E45273D84;
	Thu,  7 Aug 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1doIoff"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551226FA5A
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588140; cv=none; b=NqVGmBzCSXrPv9dh7Hywiyn6hKkqvJo2IVKNEte1Iqjwk0J09F4l5aPoH5Wk3IXQnt14OOe+jip0hf5Us7LpuD6QMHjwbIG07pKiSI+WpQdJlb+CBesi9bf+4ap+txIom36KbrgCcovGjbUdsSNd00k6YhNaTmScSqQRzwSqnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588140; c=relaxed/simple;
	bh=qX7eESPtFbbBYbqvdVvIwZ9KO5pH19YjcurNTasPwYQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uAFjm7HZuwhYwZqKnDGpfraRU2EYpyEk6+8cjjZQCeBenZPh2IM1v2j521m/vZV1mpTNRCn+TQmPGhEVvlUMPocYE8o2BaI+MTMZdOgJUM62MUdft0oyPX69rfjQBobhDSkkAtor8TNSjRn/eVx2X+4oumiR1xhqUv/yOc+sTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1doIoff; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754588139; x=1786124139;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=qX7eESPtFbbBYbqvdVvIwZ9KO5pH19YjcurNTasPwYQ=;
  b=I1doIoff2F8HmbhW9XpNx04wyNoU/cpOBJgJ5aP7u1xA6HjpzJXEqsEv
   pG/mjygowhN3C3UWW7odxzGuOrQdSc60TAnXv/DsYWXex0H7jSlQEL/iZ
   pcrAdApazcJOsueeA9es6XOurRmQDR54QjTvYGuH6kidyUbwgRABegKix
   Ty/O6N9DsZcN1TAfLzmsDhRE2H4UFbQATMCgpfqKMQ73knRWuOg987aVZ
   xTkDzcUD4DMeLSwV+Ci+IVbQ/cV1/YHK/dNtW3QSQi2DKyVHl+PWnZh0e
   jEQLPDZ7azY8SP/Zt/FKziExyFZz9CIw9RY/BFXaLno4T8k49zEvNfEh7
   A==;
X-CSE-ConnectionGUID: 2w1JO63mTgutJ4qEjt+HKg==
X-CSE-MsgGUID: fUtlPQmqQAqOwFoO43cMEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74511374"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="74511374"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:35:37 -0700
X-CSE-ConnectionGUID: Nsq6/E+kSfCtV9EO58lh3A==
X-CSE-MsgGUID: WmNTzC3ERpyGeEMCMfOaeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164787188"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:35:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net 0/2] ice: fix NULL access of tx->in_use
Date: Thu, 07 Aug 2025 10:35:25 -0700
Message-Id: <20250807-jk-ice-fix-tx-tstamp-race-v1-0-730fe20bec11@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN7jlGgC/x2MSwqAMAxEryJZG6hStXgVcVE0avxUaYsK4t0Nw
 mze8GYeCOSZAtTJA55ODrw7gSxNoJusGwm5F4Zc5YUyqsJ5Qe4IB74xSkK024HeSlUMZLTRZaW
 sBtkfnsT6vxvga0VHEdr3/QDL39pndAAAAA==
X-Change-ID: 20250807-jk-ice-fix-tx-tstamp-race-5fe8484670a4
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-c61db
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=qX7eESPtFbbBYbqvdVvIwZ9KO5pH19YjcurNTasPwYQ=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGiU4+TITF5IQ+PwW0ILDc3UzhqUJSvD55w6UpesToNbvja2S
 Ih1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmiU4+QACgkQapZdPm8PKOho6QD+OKQ2
 +EN8EGmcgUn4hl3xai5Gx1TkfLV8knvU3IxG2wcBAN1Mo+jQ7172qfJxf8f+Xk6XEnrwtpVk+2U
 S9y2AFLQL
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

Recent versions of the E810 firmware have support for a "low latency"
interface for accessing Tx timestamps without interacting over the AdminQ.

Unfortunately, a couple of the functions involved with this logic don't
properly check if the Tx timestamp tracker is initialized. This can lead to
a use-after-free or NULL pointer access violation:

[245977.278756] BUG: kernel NULL pointer dereference, address: 0000000000000000
[245977.278774] RIP: 0010:_find_first_bit+0x19/0x40
[245977.278796] Call Trace:
[245977.278809]  ? ice_misc_intr+0x364/0x380 [ice]

This happens because the reset flow in the driver re-initializes the
tracker. If a Tx timestamp interrupt occurs concurrently with a reset, the
ineractions race and the crash can occur.

I split the fixes to two separate patches because the extra interrupt for
low latency came in a different kernel. Hopefully this aids with
backporting the fix.

This was originally reported on an older kernel prior to f9472aaabd1f
("ice: Process TSYN IRQ in a separate function"), which has a similar bug,
but at a different code point. I plan to look into if any stable kernels
need a separate fix after this.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (2):
      ice: fix NULL access of tx->in_use in ice_ptp_ts_irq
      ice: fix NULL access of tx->in_use in ice_ll_ts_intr

 drivers/net/ethernet/intel/ice/ice_main.c | 12 +++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 13 ++++++++-----
 2 files changed, 15 insertions(+), 10 deletions(-)
---
base-commit: d942fe13f72bec92f6c689fbd74c5ec38228c16a
change-id: 20250807-jk-ice-fix-tx-tstamp-race-5fe8484670a4

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


