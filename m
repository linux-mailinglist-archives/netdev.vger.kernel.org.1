Return-Path: <netdev+bounces-62220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD567826450
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 14:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BAD1C20C4D
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D0134AE;
	Sun,  7 Jan 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZ6fhTrd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E0134A0
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704635652; x=1736171652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6fC6d7pDwxbTjzrVi/xipif06Ku7BmBlOvBVgsat6lA=;
  b=mZ6fhTrdntcaN7yY1s4ATDhRZV7gZ/IrcshpGyV3q6OSy8DsZ8ImXVpO
   OuYlqY8wIyr/5d4W6ZJrqIW8cEBtvJlvakbV6OVKxCUkokOFmSeOSKOG9
   0OlMwoF9ouu1R1R/1Cx9PVnAgKGFEwX/PKh0JR0HjdERijLKkgBt/Gxoa
   eLz/60E2mlstw6dcr+EmrwSsrHAlJjcmPRbIWBAEO/H3h23SKfPclkNVH
   P135+iAHihVbEIq3Be2kAJ3q8EavZJSO/0bV4IZXr+/y61sQbTKhTTWPr
   D+4y/nvYrfTkX8cuU0WYfNSzqlyVqgljcJ7WWJ65tDOVGqHeNkyF3yA77
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="428913756"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="428913756"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 05:54:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="809983359"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="809983359"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2024 05:54:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMTbK-0003pU-2i;
	Sun, 07 Jan 2024 13:54:06 +0000
Date: Sun, 7 Jan 2024 21:54:03 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net-next 1/1] net: introduce OpenVPN Data Channel Offload
 (ovpn)
Message-ID: <202401072136.mmDh9bfe-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240107/202401072136.mmDh9bfe-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401072136.mmDh9bfe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401072136.mmDh9bfe-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/ovpn/netlink.c:42:38: error: implicit declaration of function 'NLA_POLICY_MAX_LEN'; did you mean 'NLA_POLICY_MIN_LEN'? [-Werror=implicit-function-declaration]
      42 |         [OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),
         |                                      ^~~~~~~~~~~~~~~~~~
         |                                      NLA_POLICY_MIN_LEN
>> drivers/net/ovpn/netlink.c:42:38: error: initializer element is not constant
   drivers/net/ovpn/netlink.c:42:38: note: (near initialization for 'ovpn_nl_policy_keydir[1].type')
>> drivers/net/ovpn/netlink.c:41:75: warning: missing braces around initializer [-Wmissing-braces]
      41 | static const struct nla_policy ovpn_nl_policy_keydir[NUM_OVPN_A_KEYDIR] = {
         |                                                                           ^
   drivers/net/ovpn/netlink.c:63:34: error: initializer element is not constant
      63 |         [OVPN_A_PEER_LOCAL_IP] = NLA_POLICY_MAX_LEN(sizeof(struct in6_addr)),
         |                                  ^~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/netlink.c:63:34: note: (near initialization for 'ovpn_nl_policy_peer[8].type')
   drivers/net/ovpn/netlink.c:64:36: error: initializer element is not constant
      64 |         [OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_MAX_LEN(sizeof(u16)),
         |                                    ^~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/netlink.c:64:36: note: (near initialization for 'ovpn_nl_policy_peer[9].type')
   drivers/net/ovpn/netlink.c:57:71: warning: missing braces around initializer [-Wmissing-braces]
      57 | static const struct nla_policy ovpn_nl_policy_peer[NUM_OVPN_A_PEER] = {
         |                                                                       ^
   drivers/net/ovpn/netlink.c:57:71: warning: missing braces around initializer [-Wmissing-braces]
   drivers/net/ovpn/netlink.c:57:71: warning: missing braces around initializer [-Wmissing-braces]
   drivers/net/ovpn/netlink.c:57:71: warning: missing braces around initializer [-Wmissing-braces]
   drivers/net/ovpn/netlink.c:57:71: warning: missing braces around initializer [-Wmissing-braces]
   drivers/net/ovpn/netlink.c:75:27: error: initializer element is not constant
      75 |         [OVPN_A_IFNAME] = NLA_POLICY_MAX_LEN(IFNAMSIZ),
         |                           ^~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/netlink.c:75:27: note: (near initialization for 'ovpn_nl_policy[2].type')
   drivers/net/ovpn/netlink.c:73:61: warning: missing braces around initializer [-Wmissing-braces]
      73 | static const struct nla_policy ovpn_nl_policy[NUM_OVPN_A] = {
         |                                                             ^
   drivers/net/ovpn/netlink.c:73:61: warning: missing braces around initializer [-Wmissing-braces]
   drivers/net/ovpn/netlink.c:73:61: warning: missing braces around initializer [-Wmissing-braces]
   cc1: some warnings being treated as errors


vim +42 drivers/net/ovpn/netlink.c

    39	
    40	/** KEYDIR policy. Can be used for configuring an encryption and a decryption key */
  > 41	static const struct nla_policy ovpn_nl_policy_keydir[NUM_OVPN_A_KEYDIR] = {
  > 42		[OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),
    43		[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(NONCE_TAIL_SIZE),
    44	};
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

