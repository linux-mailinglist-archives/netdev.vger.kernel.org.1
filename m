Return-Path: <netdev+bounces-130660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00B98B0B5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BBF5B20C17
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438C188A0C;
	Mon, 30 Sep 2024 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3gXqBca"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F95339F
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738392; cv=none; b=mioCRlCYmMRIXqHFqNQAGxh3NtveAt+VsMJOtjfrgQzwMceBGGGy+ycGLR0ziZBF6gaGFuf4Io7sEhGdrq+4pJoFL4y4Bcs5OOpMilrofp4V5XdIRx9Wk4zWL0t6/NvFT1kkZcPYnTqI/5U43V0rxo/eXfX24cnL9Z2KmnU9VYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738392; c=relaxed/simple;
	bh=YfKWkLw9K4YnutHA+Pt+c2riDF/O8ZWVNI8t3MR74Jc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gO2U8SgTvTCEDp3cJYS5oDqQ9dd9nVRuRdmtPPwKzzpPnWYFMFb1IUmLzSVeDZPqwLaCGXmlmYaKe8ZA8XECvvMzvK79bVPzR6vEwof173ucUQV6jhIXJdvEiquXeVVpRyMmEBUTL5em44jBj14galgR0/Vw1tLe2mWzZ6iYRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3gXqBca; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738391; x=1759274391;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=YfKWkLw9K4YnutHA+Pt+c2riDF/O8ZWVNI8t3MR74Jc=;
  b=l3gXqBcaNlxc5EOILt6x6zO8ABKvuIVxIEGUwE1zIFpgSuId0mHaJl37
   MoD39Gh5kP6/hYEPTtnqgF3XLhak3KTkPLmdy3de5hTAHq7HXQgcAJlnJ
   0A5L1XsbOOhmkxWEXISQjxZURwEADyRg+MhtFgBkgga3rr3Fphvkiec1G
   xietyNtzoAn/qUyQUZJEbn49J0jdKpV80Sxw9EHHzUO396PC15YDjoIT2
   68Cztf2hVWWWYkUxQ0jTxIntO4l3jjBSJBDG/eGJYAWN6e1fRyVT4Sz5V
   ml3Ghod+zLgmdLEHCYwOjeacJIkZ7sKAnQbmET3/qB3LWWaVMv7aCNHcp
   g==;
X-CSE-ConnectionGUID: i6I40HtKQQmZbgD7b6kgGA==
X-CSE-MsgGUID: DmFE818WTXK2juPdsGlJjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26660297"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26660297"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:51 -0700
X-CSE-ConnectionGUID: jLmyPv71TwK21oR0m3X+Kw==
X-CSE-MsgGUID: aSPiUCDHTVyxkdP90ne1wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73356430"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 00/10] packing: various improvements and KUnit
 tests
Date: Mon, 30 Sep 2024 16:19:33 -0700
Message-Id: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAYy+2YC/x3NwQrCQAwE0F8pORvY7lZQf0U8LE2soRKXTSqF0
 n937Wl4DMxsYFyFDW7dBpW/YvLRhv7UwfjKOjEKNUMMcQjXFLDkcRadcF5UHJ3NDbMSWnk3/1t
 c9IiQegop0vkyELS9Uvkp6/F1B2VH5dXhse8/wAC0q4UAAAA=
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


