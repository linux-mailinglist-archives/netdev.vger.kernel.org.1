Return-Path: <netdev+bounces-240544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E861C762ED
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A056B35C47F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D12D5950;
	Thu, 20 Nov 2025 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agSG841M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4DA33CEB7
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670083; cv=none; b=j5bxmS+8cGaoNqcWPVgb2HxOwYTeqQeZCr0clo0AniBuhMDb9MSozr49ao2OB+ANGvO59cbPSZTshVxOf3QwYN2bFMvF7pOyAZSBSIKa3eaNlRhGWWdttjtqxZtIzY47J6cpJ/z2hZ0rb4hieekTTdDzjvswZoOxLxMCKOG6mb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670083; c=relaxed/simple;
	bh=f9H5zInx1tkiTRX2oNbYV+CR/1Axsm51loeW7WIZCyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=npCqecB71DF1SycE4S/n+uzqnZ7Vv115rxP/SQUvuPxc6uQF4njAipNfMbSpsPJXFWYa5PYZe6e7+C9yeWp8NUyBAJjv+1L4TsB7uyTz6ogb8L+0szi8g8I3+5Ejodz8wb6lv3q6RI/QbKqQBtN0fFgUPoveHxopFoRx0MYx3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agSG841M; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763670082; x=1795206082;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=f9H5zInx1tkiTRX2oNbYV+CR/1Axsm51loeW7WIZCyI=;
  b=agSG841MEVmauUICa73zOE/50KTsKl4pqdb38oz6hC139dL/j+j0KpUJ
   kk/AyqGJTk/vXDJNUMbMqCkLle4k9Bydow+ZgcTAnc9acGpqDI3hpQ5lS
   Y0WPyEpDOgrp+0OrR2PFw2Or/GdksuifbXzLp2MCPXplAt8kxZvRfwLuM
   h13XXMupXCd6zn/FErqJdjsBMJecGh1KiKrhYzforZIVqeHNMMQHFvKzy
   qBmemgOaR63VUZWE2IWAHgsp62yQORacqnwDodgLV1se+/XUMnUzBMcks
   2T8k99Mz7eEii91N+/N5PP5HbZmEEMTDq7a2+ebY1P1xwQ8Bb0J01UNnm
   g==;
X-CSE-ConnectionGUID: akUxOHG+SqmNvuTHvxyLNg==
X-CSE-MsgGUID: PAQpuUv+RNui1WsfkBUCQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65688945"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65688945"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:21:17 -0800
X-CSE-ConnectionGUID: WAQi/kKiRTC8BqDtbEBfqA==
X-CSE-MsgGUID: lvSI+lq/TnKMWuTacBsLWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="222419689"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:21:11 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v4 0/6] ice: properly use u64_stats API for all
 ring stats
Date: Thu, 20 Nov 2025 12:20:40 -0800
Message-Id: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABp4H2kC/33O3U7DMAwF4Fepcj2j2PlrueI9Ji7S1mWB0bImK
 0NT350oEqJCKpfW8fnsu4g8B47isbqLmZcQwzTmQR8q0Z38+MIQ+jwLkmRQooXXN5h58F2aZrh
 c+coQk08RGnaErdIdSxS5/ZG3wq3IRxE+zzDyLYnnnJxCzOWvcnLBkhcdpdrVFwQJaHVP3Nema
 e1TGBOfH7rpvZgLbR2z71B2amvIGDc0xtFfR/06kup9R2WnV25QnrS3rd44h+rnD/d/3zn0jBp
 1S7z9Y13Xb8nSsTWYAQAA
X-Change-ID: 20251016-jk-refactor-queue-stats-9e721b34ce01
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=f9H5zInx1tkiTRX2oNbYV+CR/1Axsm51loeW7WIZCyI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkz5Cv0tHD83XLTVyZ2sH//4tcQnS+9Tp1gPfPymZpO38
 q7qgoe1HaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzk6GeG/wFPNQJV8s9cCLor
 tt1X1yhXUZnFYM3eHdNYL984FGzk/I+R4dKlh5VZkiFXu0TfydQJLutNvDZN1fBK01d2o8j/G1L
 28AAA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice driver has multiple u64 values stored in the ring structures for
each queue used for statistics. These are accumulated in
ice_update_vsi_stats(). The packet and byte values are read using the
u64_stats API from <linux/u64_stats_sync.h>.

Several non-standard counters are also accumulated in the same function,
but do not use the u64_stats API. This could result in load/store tears on
32-bit architectures. Further, since commit 316580b69d0a ("u64_stats:
provide u64_stats_t type"), the u64 stats API has had u64_stats_t and
access functions which convert to local64_t on 64-bit architectures.

The ice driver doesn't use u64_stats_t and these access functions. Thus
even on 64-bit architectures it could read inconsistent values. This series
refactors the ice driver to use the updated API. Along the way I noticed
several other issues and inconsistencies which I have cleaned up,
summarized below.

*) The driver never called u64_stats_init, leaving the syncp improperly
   initialized. Since the field is part of a kzalloc block, this only
   impacts 32-bit systems with CONFIG_LOCKDEP enabled.

*) A few locations accessed the packets and byte counts directly without
   using the u64 stats API.

*) The ice_fetch_u64_stats_per_ring() function took the ice_q_stats by
   value, defeating the point of using the u64_stats API entirely.

To keep the stats increments short, I introduced ice_stats_inc, as
otherwise each stat increment has to be quite verbose. Similarly a few
places read only one stat, so I added ice_stats_read for those.

This version uses struct ice_vsi_(tx|rx)_stats structures defined in
ice_main.c for the accumulator. I haven't come up with a better solution
that allows accumulating nicely without this structure. Its a bit
frustrating as it copies the entries in the ring stats structures but with
u64 instead of u64_stats_t.

I am also still not entirely certain how the ice_update_vsi_ring_stats()
function is synchronized in the ice driver. It is called from multiple
places without an obvious synchronization mechanism. It is ultimately
called from the service task and from ethtool, and I think it may also be
called from one of the netdev stats callbacks.

I'm open to suggestions on ways to improve this, as I think the result
still has some ugly logic and a fair amount of near duplicate code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v4:
- Drop the cacheline_group changes. Olek and I plan to work on a full
  solution in a separate series.
- Drop moving prev_pkt out of the stats. This might still be a good idea,
  but it should wait for the cacheline group changes.
- Link to v3: https://patch.msgid.link/20251107-jk-refactor-queue-stats-v3-0-771ae1414b2e@intel.com

Changes in v3:
- Use SMP_CACHE_BYTES in assertions to avoid issues on ARM v7 with 128-byte
  cache (due to xdp_rxq_info changing size)
- Only check the tx_lock cache group size for non-debug kernels, rather
  than keeping logic to check its size when DEBUG_LOCK_ALLOC is enabled.
- Link to v2: https://patch.msgid.link/20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com

Changes in v2:
- Fix minor typos.
- Link to v1: https://patch.msgid.link/20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com

---
Jacob Keller (6):
      ice: initialize ring_stats->syncp
      ice: pass pointer to ice_fetch_u64_stats_per_ring
      ice: remove ice_q_stats struct and use struct_group
      ice: use u64_stats API to access pkts/bytes in dim sample
      ice: shorten ring stat names and add accessors
      ice: convert all ring stats to u64_stats_t

 drivers/net/ethernet/intel/ice/ice.h          |   3 -
 drivers/net/ethernet/intel/ice/ice_lib.h      |   6 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  77 +++++++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  30 ++--
 drivers/net/ethernet/intel/ice/ice_lib.c      |  61 +++++---
 drivers/net/ethernet/intel/ice/ice_main.c     | 196 +++++++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  45 +++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   4 +-
 11 files changed, 280 insertions(+), 150 deletions(-)
---
base-commit: 2fcc88754f4c49e3d9aef226fdfaa1634aa24c66
change-id: 20251016-jk-refactor-queue-stats-9e721b34ce01

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


