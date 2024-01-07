Return-Path: <netdev+bounces-62231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E88264D3
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 16:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F69281E21
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C114134C8;
	Sun,  7 Jan 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTqLLRZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28EA134D5
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704642210; x=1736178210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Q9tQiQhZixsslJryR4K6UJVlQR22fBmOoHvQrRA/Rc=;
  b=jTqLLRZ9YluKZIOKy3uPXiAmNm0+ZAusgPlYDpbHh0UtkcDO8XpBJDFl
   NGY4XuQ8HUB1pwwZuld+g/oqN0iXUCYltm/kuENUjDCDP2nE7Tcb4uCcA
   VZrWPwj15QkFMPf+qkXTtDEd7DLiCB02ozmUS12/8kVBs/9Jd6rWHvbkU
   I5IQahj/Vnt5xwDTDSHsKckPQccdf3tDLDclBYIDO/M4qJAfgVfwwVUqW
   CtsjB4ga2L7YRlFqJTxQtkjrFY0nEg0YWvC6s10Ab0Mz8xvBUYTbKozfC
   4mntNnq5rpwYekp6xdRQBg1UWxCyBFT4rAYnBpWW5T6gGIJWR50SFI0/K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4492176"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="4492176"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 07:43:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="784630142"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="784630142"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jan 2024 07:43:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMVJ6-0003sw-2c;
	Sun, 07 Jan 2024 15:43:24 +0000
Date: Sun, 7 Jan 2024 23:42:59 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net-next 1/1] net: introduce OpenVPN Data Channel Offload
 (ovpn)
Message-ID: <202401072315.mmiDVWdK-lkp@intel.com>
References: <20240106215740.14770-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106215740.14770-2-antonio@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/net-introduce-OpenVPN-Data-Channel-Offload-ovpn/20240107-061631
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240106215740.14770-2-antonio%40openvpn.net
patch subject: [PATCH net-next 1/1] net: introduce OpenVPN Data Channel Offload (ovpn)
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240107/202401072315.mmiDVWdK-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401072315.mmiDVWdK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401072315.mmiDVWdK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/ovpn/netlink.c:42:31: error: call to undeclared function 'NLA_POLICY_MAX_LEN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      42 |         [OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),
         |                                      ^
>> drivers/net/ovpn/netlink.c:42:31: warning: suggest braces around initialization of subobject [-Wmissing-braces]
      42 |         [OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      {                         }
>> drivers/net/ovpn/netlink.c:42:31: error: initializer element is not a compile-time constant
      42 |         [OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/netlink.c:63:27: warning: suggest braces around initialization of subobject [-Wmissing-braces]
      63 |         [OVPN_A_PEER_LOCAL_IP] = NLA_POLICY_MAX_LEN(sizeof(struct in6_addr)),
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  {                                          }
   drivers/net/ovpn/netlink.c:64:29: warning: suggest braces around initialization of subobject [-Wmissing-braces]
      64 |         [OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_MAX_LEN(sizeof(u16)),
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                    {                              }
   drivers/net/ovpn/netlink.c:63:27: error: initializer element is not a compile-time constant
      63 |         [OVPN_A_PEER_LOCAL_IP] = NLA_POLICY_MAX_LEN(sizeof(struct in6_addr)),
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/netlink.c:75:20: warning: suggest braces around initialization of subobject [-Wmissing-braces]
      75 |         [OVPN_A_IFNAME] = NLA_POLICY_MAX_LEN(IFNAMSIZ),
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                           {                           }
   drivers/net/ovpn/netlink.c:75:20: error: initializer element is not a compile-time constant
      75 |         [OVPN_A_IFNAME] = NLA_POLICY_MAX_LEN(IFNAMSIZ),
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 4 errors generated.
--
>> drivers/net/ovpn/peer.c:366: warning: Function parameter or member 'src' not described in 'ovpn_nexthop_lookup4'
>> drivers/net/ovpn/peer.c:366: warning: expecting prototype for ovpn_rpf4(). Prototype was for ovpn_nexthop_lookup4() instead
>> drivers/net/ovpn/peer.c:412: warning: Function parameter or member 'addr' not described in 'ovpn_nexthop_lookup6'
>> drivers/net/ovpn/peer.c:412: warning: expecting prototype for ovpn_rpf6(). Prototype was for ovpn_nexthop_lookup6() instead


vim +/NLA_POLICY_MAX_LEN +42 drivers/net/ovpn/netlink.c

    39	
    40	/** KEYDIR policy. Can be used for configuring an encryption and a decryption key */
    41	static const struct nla_policy ovpn_nl_policy_keydir[NUM_OVPN_A_KEYDIR] = {
  > 42		[OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),
    43		[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(NONCE_TAIL_SIZE),
    44	};
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

