Return-Path: <netdev+bounces-257482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHisEtWNhWmrDQQAu9opvQ
	(envelope-from <netdev+bounces-257482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 07:44:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D119DFABB7
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 07:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDBB83028EE7
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C55330322;
	Fri,  6 Feb 2026 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzIchnlM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377A2BE031
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360232; cv=none; b=N+3XhSkyqXKhCnarhngLI7YBWu09V7vRjFSw3RhfEKCTmEp9+8JKjJh9ZF1Xp51wEbjKLoPhidl/VFpoiLtSuxVcZmp5YXPUaroUANDC+cn5eeqJbXdAO5KbBF/Ya80rTleYSDCZPWTHhEoWqZmuDc92Ej8qyqWXOWLCamYay40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360232; c=relaxed/simple;
	bh=/JWP8MF5qF7SIJnI8qbIfcSi4SrL1bMOyFdN2GUdhK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7D2SYf64XlH5kZPlOME1mVfxL16QgnkjT7YganWYS/nLmf8g+OuCTDYPUooOO7hJdR7YceanDGwhmiJSEvb5kfnI6xa+SVXSKtzQ2BNL9446OQgekmy81ROVQOwPM5FLjwxGgmkKd7D9EeupfHPXJ9vi8YLpsjRbfLFMIfNiII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzIchnlM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770360231; x=1801896231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/JWP8MF5qF7SIJnI8qbIfcSi4SrL1bMOyFdN2GUdhK4=;
  b=CzIchnlMoX7Ow4NwS3LnOttidSK7yZ7K+oXkiUW8/NiYRLtx31m01HAo
   ztgk/Tyq1dtJpJOBZPInss0TLZPok5hUrvS2GSE/nCjiaKmLxWvoP51qa
   mG9hbwvCCU5w4lEKqCqCLnmi2JxEN2UxQYiJ4YkeznKiR1c4rVpiNBGZb
   h536Zp9At9ysF4lxzwJDp2lPf1UNt427ukCvzJV2QBG+unJ4XjU/L5Bzw
   itR4iUBXbDD1X3BYUc9Fusu9pA+djUepGEvEifI1ZfWEo25KN9nJeWegd
   EvoKPhB6bzC6ksZKwBtXDUFF+TN/ilWOLEdZvQplH9OHanX+1C1nMnKcu
   g==;
X-CSE-ConnectionGUID: BCpnX08PRJCMYFiE4ByIvA==
X-CSE-MsgGUID: 5/nS1oVOQ4KiWZuWOdDEew==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82304805"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82304805"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 22:43:50 -0800
X-CSE-ConnectionGUID: ipUoCHChTBKsww9tNlWH3w==
X-CSE-MsgGUID: V+H+I/KqTpmb/7VwfJNTiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="214951233"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Feb 2026 22:43:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voFZ9-00000000kUU-3CAV;
	Fri, 06 Feb 2026 06:43:43 +0000
Date: Fri, 6 Feb 2026 14:43:21 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
	Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <202602061444.jFWR3roe-lkp@intel.com>
References: <20260205224707.16995-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205224707.16995-6-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257482-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: D119DFABB7
X-Rspamd-Action: no action

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio_pci-Remove-supported_cap-size-build-assert/20260206-065356
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260205224707.16995-6-danielj%40nvidia.com
patch subject: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter caps
config: arm64-randconfig-002-20260206 (https://download.01.org/0day-ci/archive/20260206/202602061444.jFWR3roe-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602061444.jFWR3roe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602061444.jFWR3roe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/virtio_net_ff.h:9:10: fatal error: 'uapi/linux/stddef.h' file not found
       9 | #include <uapi/linux/stddef.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

