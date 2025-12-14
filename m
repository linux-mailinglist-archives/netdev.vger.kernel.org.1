Return-Path: <netdev+bounces-244614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF85DCBB6F5
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 07:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B45230010E6
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 06:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97612367B5;
	Sun, 14 Dec 2025 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n30+CsPh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991842AD22;
	Sun, 14 Dec 2025 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765693192; cv=none; b=snYwsrXjSG+WjwtB4kaqSSB3HyeXvZaWqnbIoGmK2hJxQELHM68spyzRguCW8ToykpjyaPpfHGJsGoR6I0P6DV2xPORZOa6RndRQIK6pDBm5FKlIjva+5LS/f2NSKEZ5+UzlywohPFh94JjxihFNs522p/GRHRaFxfR2Zm051es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765693192; c=relaxed/simple;
	bh=eZUgN1MEjmI69Dx6xkOmA6NzMD2tqyUe/mkRtjP8KY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGJUpDFxxeB53k9UGE86AGhDMZ1x3Y2jfbem0Aj2NAnnqPLfNd1D7PRhAht3WQxzsu8sr2xnaPosbGRF2r2PAE9ijO6fboIZnv3p3W97xU59CqQX3IUJFerWejn4dEu0awMjRjuC9Net9O62tSQwDAuTuKloVaUqzlN1NaPUDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n30+CsPh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765693191; x=1797229191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eZUgN1MEjmI69Dx6xkOmA6NzMD2tqyUe/mkRtjP8KY0=;
  b=n30+CsPh/60fTCJLq3sU9ABvlYg0gQTOvm/ikoASz1zHTYaen2bKeV8X
   InLjjSpOSK916/4pejySqfKz7q29iOPhOO9W6qVcpnZI087bpSQRAvRgS
   h9+FK5p6qtfZT9rDqQ/vr4EeW+9C3QK/8M7zLGyJkQjeSsL2KuMobgCxS
   xZg7HTAx3I5LZIWwx6TVjOQO5HnLGT2cWegMEpJFdxe+jN7CqWKgxosdT
   K+LyRvaoAjVXLsUDxyTWC6h+PqcXdygnwv1+FYJnCqQV22B3+k/BFw5Fb
   J7GEmqT3vgbyBXLiGTHt7/jG7KF8bVYAIxx+hN9YwTW/cckdMTs+qQIVm
   g==;
X-CSE-ConnectionGUID: 36meaS38SmG2CjU/mVqSMQ==
X-CSE-MsgGUID: g1HTcv/4SCSTskVtfdslRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11641"; a="77947755"
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="77947755"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 22:19:50 -0800
X-CSE-ConnectionGUID: i5grRnW/RNeIrsP1MNjeLg==
X-CSE-MsgGUID: I6iPCiSRQwqpIjzZltUqpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="201869248"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Dec 2025 22:19:45 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUfSI-000000008ez-2MLv;
	Sun, 14 Dec 2025 06:19:42 +0000
Date: Sun, 14 Dec 2025 14:19:30 +0800
From: kernel test robot <lkp@intel.com>
To: david.laight.linux@gmail.com, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v2 11/16] bitfield: Common up validation of the mask
 parameter
Message-ID: <202512141305.J3aPiiBv-lkp@intel.com>
References: <20251212193721.740055-12-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212193721.740055-12-david.laight.linux@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc1 next-20251212]
[cannot apply to westeri-thunderbolt/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/nfp-Call-FIELD_PREP-in-NFP_ETH_SET_BIT_CONFIG-wrapper/20251213-040625
base:   linus/master
patch link:    https://lore.kernel.org/r/20251212193721.740055-12-david.laight.linux%40gmail.com
patch subject: [PATCH v2 11/16] bitfield: Common up validation of the mask parameter
config: i386-randconfig-053-20251213 (https://download.01.org/0day-ci/archive/20251214/202512141305.J3aPiiBv-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251214/202512141305.J3aPiiBv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512141305.J3aPiiBv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/xe/xe_guc.c:639:19: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     639 |                 klvs[count++] = PREP_GUC_KLV_TAG(OPT_IN_FEATURE_EXT_CAT_ERR_TYPE);
         |                                 ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
>> drivers/gpu/drm/xe/xe_guc.c:639:19: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   drivers/gpu/drm/xe/xe_guc.c:642:19: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     642 |                 klvs[count++] = PREP_GUC_KLV_TAG(OPT_IN_FEATURE_DYNAMIC_INHIBIT_CONTEXT_SWITCH);
         |                                 ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
   drivers/gpu/drm/xe/xe_guc.c:642:19: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   4 errors generated.
--
>> drivers/gpu/drm/xe/xe_guc_submit.c:371:12: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     371 |         *emit++ = PREP_GUC_KLV_TAG(SCHEDULING_POLICIES_RENDER_COMPUTE_YIELD);
         |                   ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
>> drivers/gpu/drm/xe/xe_guc_submit.c:371:12: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   2 errors generated.
--
>> drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:163:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     163 |                 PREP_GUC_KLV_TAG(VF_CFG_GGTT_START),
         |                 ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
>> drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:163:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:166:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     166 |                 PREP_GUC_KLV_TAG(VF_CFG_GGTT_SIZE),
         |                 ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:166:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:177:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     177 |                 PREP_GUC_KLV_TAG(VF_CFG_BEGIN_CONTEXT_ID),
         |                 ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:177:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:179:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     179 |                 PREP_GUC_KLV_TAG(VF_CFG_NUM_CONTEXTS),
         |                 ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:179:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:189:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     189 |                 PREP_GUC_KLV_TAG(VF_CFG_BEGIN_DOORBELL_ID),
         |                 ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:189:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
      62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
         |         ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c:191:3: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     191 |                 PREP_GUC_KLV_TAG(VF_CFG_NUM_DOORBELLS),
         |                 ^
--
>> drivers/gpu/drm/xe/xe_sriov_packet.c:381:16: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     381 |         klvs[len++] = PREP_GUC_KLV_CONST(MIGRATION_KLV_DEVICE_DEVID_KEY,
         |                       ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
>> drivers/gpu/drm/xe/xe_sriov_packet.c:381:16: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   drivers/gpu/drm/xe/xe_sriov_packet.c:384:16: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
     384 |         klvs[len++] = PREP_GUC_KLV_CONST(MIGRATION_KLV_DEVICE_REVID_KEY,
         |                       ^
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
      36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
         |                                                          ^
   drivers/gpu/drm/xe/xe_sriov_packet.c:384:16: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]
   drivers/gpu/drm/xe/xe_guc_klv_helpers.h:39:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
      39 |          FIELD_PREP_CONST(GUC_KLV_0_LEN, (len)))
         |                           ^
   drivers/gpu/drm/xe/abi/guc_klvs_abi.h:37:35: note: expanded from macro 'GUC_KLV_0_LEN'
      37 | #define GUC_KLV_0_LEN                           (0xffffu << 0)
         |                                                          ^
   4 errors generated.


vim +639 drivers/gpu/drm/xe/xe_guc.c

9c7d93a8f1ec04 Daniele Ceraolo Spurio 2025-06-25  616  
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  617  #define OPT_IN_MAX_DWORDS 16
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  618  int xe_guc_opt_in_features_enable(struct xe_guc *guc)
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  619  {
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  620  	struct xe_device *xe = guc_to_xe(guc);
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  621  	CLASS(xe_guc_buf, buf)(&guc->buf, OPT_IN_MAX_DWORDS);
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  622  	u32 count = 0;
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  623  	u32 *klvs;
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  624  	int ret;
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  625  
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  626  	if (!xe_guc_buf_is_valid(buf))
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  627  		return -ENOBUFS;
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  628  
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  629  	klvs = xe_guc_buf_cpu_ptr(buf);
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  630  
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  631  	/*
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  632  	 * The extra CAT error type opt-in was added in GuC v70.17.0, which maps
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  633  	 * to compatibility version v1.7.0.
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  634  	 * Note that the GuC allows enabling this KLV even on platforms that do
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  635  	 * not support the extra type; in such case the returned type variable
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  636  	 * will be set to a known invalid value which we can check against.
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  637  	 */
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  638  	if (GUC_SUBMIT_VER(guc) >= MAKE_GUC_VER(1, 7, 0))
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25 @639  		klvs[count++] = PREP_GUC_KLV_TAG(OPT_IN_FEATURE_EXT_CAT_ERR_TYPE);
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  640  
9c7d93a8f1ec04 Daniele Ceraolo Spurio 2025-06-25  641  	if (supports_dynamic_ics(guc))
9c7d93a8f1ec04 Daniele Ceraolo Spurio 2025-06-25  642  		klvs[count++] = PREP_GUC_KLV_TAG(OPT_IN_FEATURE_DYNAMIC_INHIBIT_CONTEXT_SWITCH);
9c7d93a8f1ec04 Daniele Ceraolo Spurio 2025-06-25  643  
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  644  	if (count) {
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  645  		xe_assert(xe, count <= OPT_IN_MAX_DWORDS);
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  646  
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  647  		ret = __guc_opt_in_features_enable(guc, xe_guc_buf_flush(buf), count);
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  648  		if (ret < 0) {
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  649  			xe_gt_err(guc_to_gt(guc),
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  650  				  "failed to enable GuC opt-in features: %pe\n",
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  651  				  ERR_PTR(ret));
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  652  			return ret;
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  653  		}
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  654  	}
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  655  
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  656  	return 0;
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  657  }
a7ffcea8631af9 Daniele Ceraolo Spurio 2025-06-25  658  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

