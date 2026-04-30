Return-Path: <netdev+bounces-282632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKV7CF3J8mntuAEAu9opvQ
	(envelope-from <netdev+bounces-282632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:15:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E1B49CBE8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD410301A3B8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A56313A3ED;
	Thu, 30 Apr 2026 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgUjVS9n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68E7E0FF;
	Thu, 30 Apr 2026 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518936; cv=none; b=FMuBsBTbmBFX3vXzd30FlzujZjbaKhHnzofxe36OXUwgyUNojxS+Ty6zroNhkOTFtsinApxS63TmevZbJN+dTOpwNqO0UvvuJYm2E2D+yUwOS+fM9xGkajs0vKTPHQF87bBAjyGH+DsYXuqw2jyY4C5MmG9r6dAAmhHGcByb0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518936; c=relaxed/simple;
	bh=mvpSvKMWoCG60xuK5G87ZW0h44g1nMj9onmCjCXuN08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oamtd/YwzcVlbdEO00kimNOobpMbq/V9OknNzTVayWNUKDhe9E8qHR6kSbnnn9MlMfu1J+k419SMJaWEoSbVUfxvqjM9sJ37/ic4vc9Xr/0+vNOjqHf2ZDW1NkxTSaZAoO6blV9KAaWhk5SYQzKtgjp48C1pL5SiB8pPa4p1lpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgUjVS9n; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777518934; x=1809054934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mvpSvKMWoCG60xuK5G87ZW0h44g1nMj9onmCjCXuN08=;
  b=NgUjVS9noiAejoNlcXg77wEKnFOLTsP7aVXEUZ5yHSWTOT+zxVc3Ipnv
   qxNRFAG1hMjJiMCy03PKuv6E4YMDNRJe0sKr7vkwK2pF1K/ckO1efAEKT
   Bal4BSjr236d3Az/5Suo2klhhVxzJCiGvHPiJ27wYztFKa7ZfD+XGORWA
   3WjaklX+Ajql3DV4GvDXbKcDk4E6nj5MRQq/A7a1Q+36CZAnlAQv69rfF
   GDF2hEdQ+L3LtxVykwO3EsrLAIzk5FBHAxuRYoLWmINj0zhRmsiv71+Rh
   FVEqNPHxvV1Sa6M0zo9AHSANJaBd3BfWDOh9mB2x+5Brm34yNBm4EFmo1
   w==;
X-CSE-ConnectionGUID: DNrwS0rHS0CZSdRgiHbMzg==
X-CSE-MsgGUID: eyNRQpmnSwqcwdFFlyWwtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78513783"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78513783"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 20:15:34 -0700
X-CSE-ConnectionGUID: P8oxglENSn2K+pg7WmkCCw==
X-CSE-MsgGUID: eN54ZgMfQFO9dEZk/h/kFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="231312463"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 29 Apr 2026 20:15:31 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIHs8-000000004in-2vm8;
	Thu, 30 Apr 2026 03:15:28 +0000
Date: Thu, 30 Apr 2026 05:14:58 +0200
From: kernel test robot <lkp@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Fritscher <michael@fritscher.net>,
	Byron Stanoszek <gandalf@winds.org>,
	Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 15/15] drivers: net: 8390: wd80x3: Remove this
 driver
Message-ID: <202604300512.3KcfhJGd-lkp@intel.com>
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-15-08a5b59784d5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-v7-0-0-net-next-driver-removal-v1-v2-15-08a5b59784d5@lunn.ch>
X-Rspamd-Queue-Id: 74E1B49CBE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282632-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1f5ffc672165ff851063a5fd044b727ab2517ae3]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Lunn/drivers-net-3com-3c509-Remove-this-driver/20260424-104110
base:   1f5ffc672165ff851063a5fd044b727ab2517ae3
patch link:    https://lore.kernel.org/r/20260422-v7-0-0-net-next-driver-removal-v1-v2-15-08a5b59784d5%40lunn.ch
patch subject: [PATCH net v2 15/15] drivers: net: 8390: wd80x3: Remove this driver
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260430/202604300512.3KcfhJGd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300512.3KcfhJGd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Non-Preserved Properties
   ======================== [docutils]
>> Documentation/networking/device_drivers/ethernet/index.rst:10: WARNING: toctree contains reference to nonexisting document 'networking/device_drivers/ethernet/3com/3c509' [toc.not_readable]
   Documentation/networking/skbuff:36: ./include/linux/skbuff.h:48: ERROR: Unexpected section title.


vim +10 Documentation/networking/device_drivers/ethernet/index.rst

132db93572821e Jakub Kicinski 2020-06-26   7  
132db93572821e Jakub Kicinski 2020-06-26   8  Contents:
132db93572821e Jakub Kicinski 2020-06-26   9  
132db93572821e Jakub Kicinski 2020-06-26 @10  .. toctree::

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

