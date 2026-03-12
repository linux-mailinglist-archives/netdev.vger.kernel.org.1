Return-Path: <netdev+bounces-266903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKNVFVY/smk6KQAAu9opvQ
	(envelope-from <netdev+bounces-266903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:21:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92726D0C1
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C57304CCC8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DBE3932F9;
	Thu, 12 Mar 2026 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qta72D+A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EC38C404;
	Thu, 12 Mar 2026 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773289298; cv=none; b=mTLW2iB1RRQdI0pp4nlN6tATLuw+SB3/+gpprpgcetGpou8eWXXpdVY6FpqwQ5p9xsvKvzuACdEd88U6L62WX3+kOE4Qk1ZCN7HMT9UG0RCa/w7Z5pvE70kvuZdL3UM7qWZ5pKQe2js3L/Ylucqev3KOBZhNMsyh0Igzmx3YhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773289298; c=relaxed/simple;
	bh=7bD8IEomgLkpBjekMzW1r7IdMHdkv+QsIfsDdwgT6Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK8mcv63jXOdLlOjzgHMFTD0EUktGp1YpM/nhuYz+XxmKwrB3TP2WLmg2LzxceS4ymVGHCqyGMG9rdIoKopV2jex591GO8+gytpu7u+dSaeEXkmP4H3u5fwnSqMaNQJwz6uCiR/8LZ46dmRb8T4hq9WekrAZPNiziueGqtgQ83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qta72D+A; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773289298; x=1804825298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7bD8IEomgLkpBjekMzW1r7IdMHdkv+QsIfsDdwgT6Mo=;
  b=Qta72D+A/6iSnBFVJWMsz9Rpz0R0MhNxaE6K+jY8foFa57dEJjnfubol
   Xwz5/xlAmry79Pyvgn+DvUNSo6Vk9HiLOV4RkCWPF4eG1m/pLrFzUJTBS
   ANRDfSMgsopCYIki7DK2a14VbaeDS8YCrq2AIhvR7m1DojPLYGQaEX7YB
   kT6V4JVlZXAaJr814d+eXdkZDGrAFQLYjc2+2C8frFWyfKkpjKm9eskoR
   icmID/SUbo7Cqhq7OKNndYSMPbyzfwS0bzUK1O8++yIuSNt/WiB7M3Iqb
   Eml9aZzljUCklPt364A9VL6BIDCQKjnUTUMqJy41DKdDW9i5zGfdnVMxn
   Q==;
X-CSE-ConnectionGUID: 3pg3ExfyS6mdOfTIHC4E9Q==
X-CSE-MsgGUID: 8kQ15/5YROyzRSXB41IaSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74562535"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74562535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 21:21:38 -0700
X-CSE-ConnectionGUID: W0MSw16FRyC1s0N38dWxbg==
X-CSE-MsgGUID: q4mLhQcPRhWf4DVFpQI/eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="218131647"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Mar 2026 21:21:33 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0XYA-0000000024N-2uQ2;
	Thu, 12 Mar 2026 04:21:30 +0000
Date: Thu, 12 Mar 2026 12:21:06 +0800
From: kernel test robot <lkp@intel.com>
To: Matteo Croce <technoboy85@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] e1000e: add basic XDP support
Message-ID: <202603121251.DVGQwVSr-lkp@intel.com>
References: <20260311191437.3581-2-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311191437.3581-2-teknoraver@meta.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266903-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 1F92726D0C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Matteo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Croce/e1000e-add-basic-XDP-support/20260312-032318
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260311191437.3581-2-teknoraver%40meta.com
patch subject: [PATCH net-next 1/2] e1000e: add basic XDP support
config: i386-defconfig (https://download.01.org/0day-ci/archive/20260312/202603121251.DVGQwVSr-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603121251.DVGQwVSr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603121251.DVGQwVSr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: page_pool_create
   >>> referenced by netdev.c
   >>>               drivers/net/ethernet/intel/e1000e/netdev.o:(e1000e_setup_rx_resources) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: page_pool_alloc_pages
   >>> referenced by netdev.c
   >>>               drivers/net/ethernet/intel/e1000e/netdev.o:(e1000_alloc_rx_buffers_xdp) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

