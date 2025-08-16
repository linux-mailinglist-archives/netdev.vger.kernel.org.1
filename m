Return-Path: <netdev+bounces-214301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08583B28D68
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 13:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59DB3BA932
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 11:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB22D0C6B;
	Sat, 16 Aug 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n71hZWok"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1B2C3768;
	Sat, 16 Aug 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755343544; cv=none; b=RGxYOQK+WDYdClodj+zlK/lQ16mCHOEZYQfQ53mTQP+UB4WqZrFjCjA1ijK+loQ/h1t5WI6jZcr0uJioQtwcB+1EkuK2+SLz0+QP3aw57Rfg/IjYxjWbMFDaD+dShp4wR0ADcZjez22NOJZRHJu6rGzZ5gqMF9cm5leYRy9YGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755343544; c=relaxed/simple;
	bh=yXFNrlTsuKcIiCEG5HOLk1E5J3QOdw3cZCTv8+Nq19Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lymf+8swtYgb1MQ/awKjckKqmxpsrbAqBmBImqGNQSM8Ss1evvOcw8DXIKgvL1i65vX1D2049+yYP1sO8UD2uodCBlzi9ComXoPZSiVY2DcUE9DVGo/7lS+GdqnTrQvL8lsk374Yu9b5G6wUupXHzUQnQXf0BpmoOrCCvWLh2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n71hZWok; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755343543; x=1786879543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yXFNrlTsuKcIiCEG5HOLk1E5J3QOdw3cZCTv8+Nq19Q=;
  b=n71hZWokabrRDjOBI42sW1w7fjcwElw+LzgHU0HWoginULo6m9Vv5+uS
   VyzB02IQqdsOytedHFHSh40WxiqMEcV+DKosm6IhunAJh/9KEGIVcu0B5
   3Zcqq/SJdf0Usyo0xZGOPOpLX1DDprsi+gQARMq4Tgel+hOcBbjJOa5IP
   +P/8s/RALDzHzxdN5m2A9XMsV8uaNUmxnusVFn9MFU4ACzsDhl6dK21dc
   /xRbKU/yK/NKlXqY1P71MA66hBC9XFjVMy98tMEDk6gyi6yWuEvo/C8Ol
   USGE1rcUl1OCcIWd14L+2avMlBLLJkWEMFJuPosfcDMWlXbKN43Aj/H1g
   A==;
X-CSE-ConnectionGUID: p07IyuLnRySbStjIjLqRLQ==
X-CSE-MsgGUID: guZ+JZrCTZeGG9OOly6HqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57713463"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57713463"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 04:25:42 -0700
X-CSE-ConnectionGUID: uGNPv/P0SAOZCDHGzi1O3w==
X-CSE-MsgGUID: Tv9x7wr8Td6dRbiYNGSuGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="190913937"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 16 Aug 2025 04:25:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unF2T-000CqO-0F;
	Sat, 16 Aug 2025 11:25:34 +0000
Date: Sat, 16 Aug 2025 19:24:43 +0800
From: kernel test robot <lkp@intel.com>
To: Artur Rojek <contact@artur-rojek.eu>, Rob Landley <rob@landley.net>,
	Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <202508161930.ergOga3z-lkp@intel.com>
References: <20250815194806.1202589-4-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815194806.1202589-4-contact@artur-rojek.eu>

Hi Artur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Artur-Rojek/dt-bindings-vendor-prefixes-Document-J-Core/20250816-042354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250815194806.1202589-4-contact%40artur-rojek.eu
patch subject: [PATCH 3/3] net: j2: Introduce J-Core EMAC
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250816/202508161930.ergOga3z-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161930.ergOga3z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508161930.ergOga3z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/jcore_emac.c:231:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
     231 |         }
         |         ^
   1 warning generated.


vim +231 drivers/net/ethernet/jcore_emac.c

   192	
   193	static void jcore_emac_set_rx_mode(struct net_device *ndev)
   194	{
   195		struct jcore_emac *priv = netdev_priv(ndev);
   196		struct netdev_hw_addr *ha;
   197		unsigned int reg, i, idx = 0, set_mask = 0, clear_mask = 0, addr = 0;
   198	
   199		if (ndev->flags & IFF_PROMISC)
   200			set_mask |= JCORE_EMAC_PROMISC;
   201		else
   202			clear_mask |= JCORE_EMAC_PROMISC;
   203	
   204		if (ndev->flags & IFF_ALLMULTI)
   205			set_mask |= JCORE_EMAC_MCAST;
   206		else
   207			clear_mask |= JCORE_EMAC_MCAST;
   208	
   209		regmap_update_bits(priv->map, JCORE_EMAC_CONTROL, set_mask | clear_mask,
   210				   set_mask);
   211	
   212		if (!(ndev->flags & IFF_MULTICAST))
   213			return;
   214	
   215		netdev_for_each_mc_addr(ha, ndev) {
   216			/* Only the first 3 octets are used in a hardware mcast mask. */
   217			memcpy(&addr, ha->addr, 3);
   218	
   219			for (i = 0; i < idx; i++) {
   220				regmap_read(priv->map, JCORE_EMAC_MCAST_MASK(i), &reg);
   221				if (reg == addr)
   222					goto next_ha;
   223			}
   224	
   225			regmap_write(priv->map, JCORE_EMAC_MCAST_MASK(idx), addr);
   226			if (++idx >= JCORE_EMAC_MCAST_ADDRS) {
   227				netdev_warn(ndev, "Multicast list limit reached\n");
   228				break;
   229			}
   230	next_ha:
 > 231		}
   232	
   233		/* Clear the remaining mask entries. */
   234		for (i = idx; i < JCORE_EMAC_MCAST_ADDRS; i++)
   235			regmap_write(priv->map, JCORE_EMAC_MCAST_MASK(i), 0);
   236	}
   237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

