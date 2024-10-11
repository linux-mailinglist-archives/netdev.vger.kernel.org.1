Return-Path: <netdev+bounces-134664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241F99AB82
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824521C21BCD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552281D0491;
	Fri, 11 Oct 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1l+97Wk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A21D0406;
	Fri, 11 Oct 2024 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672609; cv=none; b=PmvoWRYP6l1N4qNBiDRPhfVk/azG14v8rvcsTGydGCcaoDfEf1w+9N7B5OERyG+VD/Ex5oW36+1Db9NfXl0lZRTS8YRW2DV4yftO3eyLHjpcpKeD7coDaX/kU/+nJPCqUJz/aABGhLh+VnRdOuQ79t3JyR9GK+AotOHUOQ80XTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672609; c=relaxed/simple;
	bh=NKdwyV2yhRLyVZ+vhlosGcKFUdD7xmu+679Y6S8XNsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RevjjbNPF32cUhhbUDOQAhZZ0+E811m8bkt9MPBXbqWulhjmZZ787smDVzSf5TAPCTkmsvv9+VEn+5aZZdyLMK44f+mO68a41BawLRZYGZcyeSxFAHyrjwP93ylCqls5Nd+AGXRpqOJjL0p/16Ehw691OBSg/CIhcMow5GCCV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1l+97Wk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728672607; x=1760208607;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=NKdwyV2yhRLyVZ+vhlosGcKFUdD7xmu+679Y6S8XNsY=;
  b=N1l+97WkCgo9O5d650GhnzMf86YGCJkUvaXPAJOl5WG0tKy7zrJZ6xgW
   vTtTy8xra5bgbRAq8c0yKeb93bC99+Vr5R8/ICQMfd6meFo8ZNXXhiY8B
   AohkNmQVry9bQQgEUpXWpzkf6CxIuG2v+rC+ORwizaTUKDvZO2kRDbhct
   JIzEya8Tl5il+wOGapRvI31OAUHuwgnANbWyuxKQQNtZ000vcnQnllJ5t
   brEuDYk8zRqP7BogcSxt/F0tn/Jgzmx/gRzvWnuvYc3wZMrWTpDNEVkpf
   E73NiIDHV5OQuMucLBxxJdeoYhZ2Sjl0+r62jAqQPSNIz3AZ9hM4KuVmv
   w==;
X-CSE-ConnectionGUID: JWPBwNJRTMmnKIv6McPMKA==
X-CSE-MsgGUID: cE1fAFMGQoOHM82zoN241w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50626150"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="50626150"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:06 -0700
X-CSE-ConnectionGUID: zJgxWzITQY+UgaeF8BONzA==
X-CSE-MsgGUID: tZrstZS4Tpqo5f+gg0Kmqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77804142"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 0/8] lib: packing: introduce and use
 (un)pack_fields
Date: Fri, 11 Oct 2024 11:48:28 -0700
Message-Id: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxyCWcC/x2N0QqDMBAEf0XuuQeJCin9ldKHNFntUb2GJIgg/
 nuDT8vAMnNQQRYUenQHZWxS5KcN7K2j8PE6gyU2pt70ozVm5OTDV3S+lifBEgt7jSyhXde0YIV
 WX5uG39YFF3DH4AZqwpQxyX7FnqSorNgrvc7zD6sdPq6GAAAA
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.1

This series improves the packing library with a new API for packing or
unpacking a large number of fields at once with minimal code footprint. The
API is then used to replace bespoke packing logic in the ice driver,
preparing it to handle unpacking in the future. Finally, the ice driver has
a few other cleanups related to the packing logic.

The pack_fields and unpack_fields functions have the following improvements
over the existing pack() and unpack() API:

 1. Packing or unpacking a large number of fields takes significantly less
    code. This significantly reduces the .text size for an increase in the
    .data size which is much smaller.

 2. The unpacked data can be stored in sizes smaller than u64 variables.
    This reduces the storage requirement both for runtime data structures,
    and for the rodata defining the fields. This scales with the number of
    fields used.

 3. Most of the error checking is done at compile time, rather than
    runtime via CHECK_PACKED_FIELD_* macros. This saves wasted computation
    time, *and* catches errors in the field definitions immediately instead
    of only after the offending code executes.

The actual packing and unpacking code still uses the u64 size
variables. However, these are converted to the appropriate field sizes when
storing or reading the data from the buffer.

One complexity is that the CHECK_PACKED_FIELD_* macros need to be defined
one per size of the packed_fields array. This is because we don't have a
good way to handle the ordering checks otherwise. The C pre-processor is
unable to generate and run variable length loops at compile time.

This is a significant amount of macro code, ~22,000 lines of code. To
ensure it is correct and to avoid needing to store this directly in the
kernel history, this file is generated as <generated/packing-checks.h> via
a small C program, gen_packing_checks. To generate this, we need to update
the top level Kbuild process to include the compilation of
gen_packing_checks and execution to generate the packing-checks.h file.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (5):
      ice: remove int_q_state from ice_tlan_ctx
      ice: use <linux/packing.h> for Tx and Rx queue context data
      ice: reduce size of queue context fields
      ice: move prefetch enable to ice_setup_rx_ctx
      ice: cleanup Rx queue context programming functions

Vladimir Oltean (3):
      lib: packing: create __pack() and __unpack() variants without error checking
      lib: packing: demote truncation error in pack() to a warning in __pack()
      lib: packing: add pack_fields() and unpack_fields()

 drivers/net/ethernet/intel/ice/ice_common.h     |  12 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |  49 +---
 include/linux/packing.h                         |  69 ++++++
 drivers/net/dsa/sja1105/sja1105_static_config.c |   8 +-
 drivers/net/ethernet/intel/ice/ice_base.c       |   6 +-
 drivers/net/ethernet/intel/ice/ice_common.c     | 300 +++++-------------------
 lib/gen_packing_checks.c                        |  31 +++
 lib/packing.c                                   | 285 ++++++++++++++++------
 Kbuild                                          |  13 +-
 drivers/net/ethernet/intel/Kconfig              |   1 +
 10 files changed, 423 insertions(+), 351 deletions(-)
---
base-commit: d677aebd663ddc287f2b2bda098474694a0ca875
change-id: 20241004-packing-pack-fields-and-ice-implementation-b17c7ce8e373

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


