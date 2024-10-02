Return-Path: <netdev+bounces-131370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD898E588
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95ED1F21668
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F58197A6A;
	Wed,  2 Oct 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XE+F3gnI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B412F22
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905921; cv=none; b=Gw+VX64M51WvwTEVGGD4tOvkO3KiBt8wqTilMKO1PgHt6wleIP30mlb6ncyVg838XDfpLqlVRHnAObNe9G969Dax/1QIs5MPnnpiNRUZZH9pzgkrBqVbHGp+PhNy0p+aSRE8Op4m43D0VTnKdKftQmOD3w+VkCD8TQc1yhW0DJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905921; c=relaxed/simple;
	bh=SkgCoHQlzHhE7TmD8jmeMLWd4ohydfIjEwTu7gOJajc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uJd5LxHTiykoPztxB/PxGNL58D1StZB2pJ4YS4zQ56pvbtQNloAojd3O4zKl5/zifqC5G5Yyqmg/iFlkTwnpkeaLap2QwlNnPf4yCN/XVJyQGRwRPx+YUq8bXxmCNoOXJXe1MCcuL5gMaezeMBjrLYwSnD/hIyvUvbRYMf2VvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XE+F3gnI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905920; x=1759441920;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=SkgCoHQlzHhE7TmD8jmeMLWd4ohydfIjEwTu7gOJajc=;
  b=XE+F3gnIx9GP8uXW0NpH0JSkKxmlmQ8SvbPGHGmwbY+42HdYann2Upb2
   Vy70ZGR2sblfICS6m/1mupBn8bBRaEA1lMq3N8OwIMDl5CB5Rh1Y9dKlY
   jrNPZlQFB26JtjUh0qplijYSGDcy+/1SafO+kqw0+RRb7KDAjCdJ+lJjW
   I1RT+S8oQ1NNYhe7X5r8JDbZQe0VMS4326dPD3woJbTLngsNlL6sZyBR0
   VnBZVJvDBuP0qcDAE4XOMMqprDp7QUxkT+Nonp2FQrqIJIhXR+K0XnWgL
   cUP+Y4yBxfNQouxbhZJh3kkx62fwXueJylZPUfY9gt9HysWPHP2zwhYyx
   A==;
X-CSE-ConnectionGUID: N7iOmZpJS1aceu9bfNQh4Q==
X-CSE-MsgGUID: U4n1t6grT6SpSNDArCTVHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27262005"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27262005"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:51:59 -0700
X-CSE-ConnectionGUID: KdrpC3F1Sc24x5RR7jPsNA==
X-CSE-MsgGUID: rPTsohifQDyO+tk1yI9MlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78673879"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:51:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 00/10] packing: various improvements and KUnit
 tests
Date: Wed, 02 Oct 2024 14:51:49 -0700
Message-Id: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbA/WYC/52OQQqDMBBFryKz7pSoEbSr3qO4SM1UB+0oSRSLe
 PemOUJXn8eD//8BnhyTh1t2gKONPc8Sobhk0A1GekK2kaFQhVZNqXAx3cjS47gKBwzkg0cjFv0
 yRf5ZXCWFKnOrysJWtbYQ+xZHL97T1gOEAgrtAdpoBvZhdp90YsuT/2Nvy1Fho5/5S2nTmbq6s
 wSart38hvY8zy/nBVeC7AAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.1

This series contains a handful of improvements and fixes for the packing
library, including the addition of KUnit tests.

There are two major changes which might be considered bug fixes:

1) The library is updated to handle arbitrary buffer lengths, fixing
   undefined behavior when operating on buffers which are not a multiple of
   4 bytes.

2) The behavior of QUIRK_MSB_ON_THE_RIGHT is fixed to match the intended
   behavior when operating on packings that are not byte aligned.

These are not sent to net because no driver currently depends on this
behavior. For (1), the existing users of the packing API all operate on
buffers which are multiples of 4-bytes. For (2), no driver currently uses
QUIRK_MSB_ON_THE_RIGHT. The incorrect behavior was found while writing
KUnit tests.

This series also includes a handful of minor cleanups from Vladimir, as
well as a change to introduce a separated pack() and unpack() API. This API
is not (yet) used by a driver, but is the first step in implementing
pack_fields() and unpack_fields() which will be used in future changes for
the ice driver and changes Vladimir has in progress for other drivers using
the packing API.

This series is part 1 of a 2-part series for implementing use of
lib/packing in the ice driver. The 2nd part includes a new pack_fields()
and unpack_fields() implementation inspired by the ice driver's existing
bit packing code. It is built on top of the split pack() and unpack()
code. Additionally, the KUnit tests are built on top of pack() and
unpack(), based on original selftests written by Vladimir.

Fitting the entire library changes and drivers changes into a single series
exceeded the usual series limits.

Those interested in seeing the full work along with the ice driver
implementation can find it at:

  https://github.com/jacob-keller/linux/tree/packing/pack-fields-and-ice-implementation

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Drop the fixes tags, since none of the changes need or want to be
  backported.
- Link to v1: https://lore.kernel.org/r/20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com

---
Jacob Keller (3):
      lib: packing: add KUnit tests adapted from selftests
      lib: packing: add additional KUnit tests
      lib: packing: fix QUIRK_MSB_ON_THE_RIGHT behavior

Vladimir Oltean (7):
      lib: packing: refuse operating on bit indices which exceed size of buffer
      lib: packing: adjust definitions and implementation for arbitrary buffer lengths
      lib: packing: remove kernel-doc from header file
      lib: packing: add pack() and unpack() wrappers over packing()
      lib: packing: duplicate pack() and unpack() implementations
      lib: packing: use BITS_PER_BYTE instead of 8
      lib: packing: use GENMASK() for box_mask

 include/linux/packing.h            |  32 +--
 lib/packing.c                      | 400 ++++++++++++++++++++++-------------
 lib/packing_test.c                 | 412 +++++++++++++++++++++++++++++++++++++
 Documentation/core-api/packing.rst |  71 +++++++
 MAINTAINERS                        |   1 +
 lib/Kconfig                        |  12 ++
 lib/Makefile                       |   1 +
 7 files changed, 761 insertions(+), 168 deletions(-)
---
base-commit: c824deb1a89755f70156b5cdaf569fca80698719
change-id: 20240930-packing-kunit-tests-and-split-pack-unpack-031d032d584d

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


