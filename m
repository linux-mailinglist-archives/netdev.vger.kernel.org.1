Return-Path: <netdev+bounces-148722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F29E301E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAF7166FD5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBF8208983;
	Tue,  3 Dec 2024 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lnr1rl/z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91080188A0E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270111; cv=none; b=ZMa7Rnc1OEDpNaMqz4HEzhHowl8F2HiMxlrMDizAfwOKVBd4ARPxSIQhZ4C7wkl7BqEMiTjBsXWEnJZ6St8jNCfjj5reeZjGPdGhGPUuiMa/Vr/VCvI6KsPKo7ZvJS9wysME31SDyeTK+I3lGHqoQ3d352MI1bVNJ15BumX/E/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270111; c=relaxed/simple;
	bh=hZta/0ynGmbOibynCU8QazYkxqMUoRIb2z63GrU1lUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uwo2CuHNVFqPcdu1pQHCtkB92Eh7etgTXyp/sAxyptoZpvUXhMhSAZ8QlrTJMqGAWG0CB0D0aryRiZy3VA4ah9bnFjWE8iRy3iHOpPrcX3tvR7Nsvyb+5j9OUY8WsK6CbvYPBrJpfh1uxJSK/cWlwPfsuAXYMiyqkxh0XQpVJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lnr1rl/z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733270109; x=1764806109;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=hZta/0ynGmbOibynCU8QazYkxqMUoRIb2z63GrU1lUM=;
  b=Lnr1rl/zLaB2tvrL8tZjtIhv/sQO03hXMfR4EmonF6hMt+gFYDJ3NJvl
   IExe4jYLVr5zOLdJdZwGQT4jGCx0bUg4NO7M9LpKG21epmH6tgN6TUDFl
   4vpts4Fq3+JzeyfVxyb1WeJ/JRqyxzTY+84q987nT+0a3nl9DhXqH14Hh
   Z/N8MR3hbuMt73y5lAWuTY6GURsft9FZz2YLm0NJEVX2YaFRncU+AgPsc
   2R9hNAG7wxIpcncuSwVvOxTzbx4fi14sgMflkq98soLufUQOH+7cGvtws
   a5Eeh+GIgWxYdOcvZ0GFMrao1CTQbX3JytJlXjTkzjf0Tvsxvu1JvGWZ1
   Q==;
X-CSE-ConnectionGUID: jN0duYxWT6q+OS6vXRqTRg==
X-CSE-MsgGUID: Wj0LO3SPTYyHFVCsmBMItw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58918417"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="58918417"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:08 -0800
X-CSE-ConnectionGUID: h6uQyhqGTv+ds6jlwGFfKg==
X-CSE-MsgGUID: qSczSdo2SeaQc6dUdXOG2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93679030"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:08 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v8 00/10] lib: packing: introduce and use
 (un)pack_fields
Date: Tue, 03 Dec 2024 15:53:46 -0800
Message-Id: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAqaT2cC/5XRzWrDMAwH8FcpPs/Dn5Kz095j7OAoSmvWuiUJo
 aP03edljGbZyRcbIfPTH/kmRh4Sj+JldxMDz2lM51yK8LQTdIh5zzJ1pRZGGaeVcvIS6SPl/XL
 LPvGxG2XMnUxUnp4uRz5xnuJUGNlqJCQObNGKAl4G7tN1GfYmMk8y83US76VzSON0Hj6XFLNe+
 j8Dta4ZOGupZNe0ukevFDr1mvLEx2c6n5Yxs1nRxlfRptBoHSJQCPyftg9aK6iibaHJu2ip6XX
 T4Ip+2v2SWE0aJA8QyTgL27RunTZU0a7QQcemd4asYr+l/Yqu/D7/TStSZc8NQ4tbGtZ0XWooN
 MQ+tOBDBLJbGh90OapoLDR3xrANDAR/FnK/378AmhfbMWMDAAA=
X-Change-ID: 20241004-packing-pack-fields-and-ice-implementation-b17c7ce8e373
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

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
    runtime, via CHECK_PACKED_FIELD macros.

The actual packing and unpacking code still uses the u64 size
variables. However, these are converted to the appropriate field sizes when
storing or reading the data from the buffer.

This version returns to the C pre-processor macro checks, rather than use
of external tools. To limit the amount of generated code and ease the
driver burden, we now enforce ordering (same as with v5), where the fields
must be in ascending or descending order. This reduces the overlap checks
from O(N^2) to O(N), and reduces the amount of generated code from 20K
lines to 3K lines.

I also refactored to place the generator script in
scripts/gen_packed_field_checks.c, and no longer automatically generate at
compile time. This avoids needing to mess too much with the top level build
system, at the expense of saving the macros in git. I think the reduction
to 3K lines is a bit more within reason vs the 20K lines from v2.

This version returns to the 5-argument format of pack_fields and
unpack_fields, but now enforces that the passed pbuflen is a compile-time
constant via __builtin_constant_p(). This ensures we can still perform the
size checks, but keeps the API flexible rather than forcing users to always
wrap their buffer in a struct typedef. I think this is acceptable, and
enforcing a compile-time known size is a reasonable constraint.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v8:
- Add my missing SOB on one of the patches
- Remove include/linux/packing_types.h and put the generated code directly
  into include/linux/packing.h
- Split documentation to its own patch, and use the proposed documentation
  from Vladimir
- Link to v7: https://lore.kernel.org/r/20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com

Changes in v7:
- Dropped the RFC tag for submission to net-next
- Link to v6: https://lore.kernel.org/r/20241118-packing-pack-fields-and-ice-implementation-v6-0-6af8b658a6c3@intel.com

Changes in v6:
- Revert to macro checks similar to v2.
- Add a __builtin_choose_expr() based macro to automatically select the
  appropriate size macro.
- Keep the pbuflen check separate from the main loop check, similar to v5.
- Link to v5: https://lore.kernel.org/r/20241111-packing-pack-fields-and-ice-implementation-v5-0-80c07349e6b7@intel.com

Changes in v5:
- Fix printf format specifier for the sym->st_size
- Link to v4: https://lore.kernel.org/r/20241108-packing-pack-fields-and-ice-implementation-v4-0-81a9f42c30e5@intel.com

Changes in v4:
- Move the buffer size checks to (un)pack_fields() macros.
- Enforce use of a sized type of the packed buffer, removing the now
  unnecessary pbuflen argument of (un)pack_fields().
- Drop exporting the buffer size to modpost.
- Simplify modpost implementation to directly check each symbol in the
  handle_packed_field_symbol() function. This removes the need for a hash,
  and is ultimately much simpler now that modpost doesn't need the size of
  the target buffer.
- Fix the width check to correctly calculate the width and compare it
  properly.
- Refactor modpost messages to consistently report the module name first,
  the symbol name second, and the field number 3rd.
- Correctly implement overlap checks in the modpost, rather than only
  checking field ordering.
- Link to v3: https://lore.kernel.org/r/20241107-packing-pack-fields-and-ice-implementation-v3-0-27c566ac2436@intel.com

Changes in v3:
- Replace macro-based C pre-processor checks with checks implemented in
  modpost.
- Move structure definitions into  <linux/packing_types.h> to enable reuse
  within modpost.
- Add DECLARE_PACKED_FIELDS_S and DECLARE_PACKED_FIELDS_M to enable
  automatically generating the buffer size constants and the section
  attributes.
- Add additional unit tests for the pack_fields and unpack_fields APIs.
- Update documentation with an explanation of the new API as well as some
  example code.
- Link to v2: https://lore.kernel.org/r/20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com

Changes in v2:
- Add my missing sign-off to the first patch
- Update the descriptions for a few patches
- Only generate CHECK_PACKED_FIELDS_N when another module selects it
- Add a new patch introducing wrapper structures for the packed Tx and Rx
  queue context, suggested by Vladimir.
- Drop the now unnecessary macros in ice, thanks to the new types
- Link to v1: https://lore.kernel.org/r/20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com

---
Jacob Keller (7):
      lib: packing: document recently added APIs
      ice: remove int_q_state from ice_tlan_ctx
      ice: use structures to keep track of queue context size
      ice: use <linux/packing.h> for Tx and Rx queue context data
      ice: reduce size of queue context fields
      ice: move prefetch enable to ice_setup_rx_ctx
      ice: cleanup Rx queue context programming functions

Vladimir Oltean (3):
      lib: packing: create __pack() and __unpack() variants without error checking
      lib: packing: demote truncation error in pack() to a warning in __pack()
      lib: packing: add pack_fields() and unpack_fields()

 Makefile                                        |    4 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |   11 +-
 drivers/net/ethernet/intel/ice/ice_common.h     |    5 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |   49 +-
 include/linux/packing.h                         | 2855 +++++++++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_static_config.c |    8 +-
 drivers/net/ethernet/intel/ice/ice_base.c       |    6 +-
 drivers/net/ethernet/intel/ice/ice_common.c     |  293 +--
 lib/packing.c                                   |  285 ++-
 lib/packing_test.c                              |   61 +
 scripts/gen_packed_field_checks.c               |   38 +
 Documentation/core-api/packing.rst              |  118 +-
 MAINTAINERS                                     |    1 +
 drivers/net/ethernet/intel/Kconfig              |    1 +
 scripts/Makefile                                |    2 +-
 15 files changed, 3377 insertions(+), 360 deletions(-)
---
base-commit: e8e7be7d212dc2bc83b8151e51088666a6c42092
change-id: 20241004-packing-pack-fields-and-ice-implementation-b17c7ce8e373

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


