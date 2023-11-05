Return-Path: <netdev+bounces-46116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2361F7E177D
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 23:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A81B1C20933
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 22:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1E171DC;
	Sun,  5 Nov 2023 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZfj525q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870352569
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 22:58:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B6CF;
	Sun,  5 Nov 2023 14:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699225129; x=1730761129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IBnqEtOpVF3qUs7zi14zprYn6a0bv6FOzZ6a7h1nLOc=;
  b=KZfj525qBtCB9v+15cfAINtt6PgDNPOWv4d2R4lwnvJB23FpVeU1HUAc
   CwWlvtY1CVHZy1YcJEC7ue6cbjbUqIEqxrTkXZlIGOL7OFq1qD0Y3CZ34
   Ng/mTu0M1htGDpVQibQ+ZoZ61Q9F6h4UEdY4h7EZn46YAjDIUgtedUEX7
   xHsDZzt49ItKyEQOm+pRFjqIDfmaVHZsaRrWn6Uklva0yOty4DcBLiidC
   VJEDGifiIR1Mg0HnnSJVSMZSh+Ja73lfyMArs+FiElWASafcyhMlc6dW3
   d+ltC8CeEHyNVT5+U/9voX2avShLcZEdOI/gakVf8zr7jYcm3HD1bYIw0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388064926"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="388064926"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 14:58:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093600479"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="1093600479"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 14:58:48 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzm4s-0005rY-10;
	Sun, 05 Nov 2023 22:58:46 +0000
Date: Mon, 6 Nov 2023 06:57:01 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com,
	Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <202311060633.814zKJdK-lkp@intel.com>
References: <20231102154505.940783-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102154505.940783-13-justinlai0215@realtek.com>

Hi Justin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/net-ethernet-realtek-rtase-Add-pci-table-supported-in-this-module/20231103-032946
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231102154505.940783-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20231106/202311060633.814zKJdK-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060633.814zKJdK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060633.814zKJdK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/rtase/rtase_main.c:68:10: fatal error: 'net/page_pool.h' file not found
      68 | #include <net/page_pool.h>
         |          ^~~~~~~~~~~~~~~~~
   1 error generated.


vim +68 drivers/net/ethernet/realtek/rtase/rtase_main.c

db2657d0fa3a98 Justin Lai 2023-11-02 @68  #include <net/page_pool.h>
db2657d0fa3a98 Justin Lai 2023-11-02  69  #include <net/pkt_cls.h>
db2657d0fa3a98 Justin Lai 2023-11-02  70  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

