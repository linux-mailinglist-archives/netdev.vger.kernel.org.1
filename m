Return-Path: <netdev+bounces-204129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A234AF9104
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DD916D0AC
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C9271444;
	Fri,  4 Jul 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifZHHvcR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8321239E76
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626967; cv=none; b=sxHm6KKAwH6MUYkfStPfPqK+sTlyZTuFkbzQk51+eX+2EJox6CxVHN1NhFsejsk3WrKPIy6cVwGSrxEiKinrVxwk8OO8ngAfZESkvP1UsMBWaT46qtjxGuFOdFTBOLdnaqdRUfO34JuiSNq+ot+lMlMjO/LdJ6QmZV/Id3CtIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626967; c=relaxed/simple;
	bh=RPGK3rzN/jti3M3Bwfulr/BzvLaYn9tJQuNbxRwcnb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNqvClzh1c9/59Dr+kZjqzCcPYa7lCRTXRrA5qT0EBzm1swFUEEGNTfMSXKmIXojtmnprziRgPY6URu0Yi9sF40hgbmg1ScHWK5TArKgLXpT+Z37LpYSsB//I2D35+w/g2DK4cr1ytuMoM1u8mbdiS02MHrYMkZ3dG0JKcF/UPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifZHHvcR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751626965; x=1783162965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPGK3rzN/jti3M3Bwfulr/BzvLaYn9tJQuNbxRwcnb4=;
  b=ifZHHvcRtrUSCDXEZtwb4VqkZDv3fA5/tMt44prWnZVUy34/HO9WB5aA
   5uRVFrCsgQ5QF9EOoV6HxEMrtXy29tF6A4eFWWlb4vKVt2LiYGj/u9my7
   /pY7pkn2j2ON3WBmzdFXcMVKvyqYUUnLPnuJjN7VRa2SoqWcOjhV8U9Ry
   dwYiQl/FNhcXX5x/zePgMzLeodS3OqDV3VPaOiwFX+rOLT+VsmL/VNsH6
   YMhntlL9z8ewmZFJXN/zbkkSp9W4WR/G7aYSStr597SpFMbzTAniB7w2i
   jI5sQYKBY98WPm5jc+Y8zg7xghuQOskdGxdvl+QGMtCg65uWSc+eEMNEo
   Q==;
X-CSE-ConnectionGUID: 4xRRhCdyQxGnTuvj1tvijw==
X-CSE-MsgGUID: etIMh8NaSmGx+5vtYhYp0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76508707"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="76508707"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 04:02:44 -0700
X-CSE-ConnectionGUID: A8nMu1HmRX+OjxIzdAW2eA==
X-CSE-MsgGUID: uFhlsTEiTb6D3ohepmnCJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154260168"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jul 2025 04:02:42 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXeBj-0003d1-2t;
	Fri, 04 Jul 2025 11:02:39 +0000
Date: Fri, 4 Jul 2025 19:01:46 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Matt Johnston <matt@codeconstruct.com.au>
Subject: Re: [PATCH net-next 6/7] net: mctp: Test conflicts of connect() with
 bind()
Message-ID: <202507041803.6bndMcXn-lkp@intel.com>
References: <20250703-mctp-bind-v1-6-bb7e97c24613@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-mctp-bind-v1-6-bb7e97c24613@codeconstruct.com.au>

Hi Matt,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8b98f34ce1d8c520403362cb785231f9898eb3ff]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/net-mctp-Prevent-duplicate-binds/20250703-171427
base:   8b98f34ce1d8c520403362cb785231f9898eb3ff
patch link:    https://lore.kernel.org/r/20250703-mctp-bind-v1-6-bb7e97c24613%40codeconstruct.com.au
patch subject: [PATCH net-next 6/7] net: mctp: Test conflicts of connect() with bind()
config: loongarch-randconfig-001-20250704 (https://download.01.org/0day-ci/archive/20250704/202507041803.6bndMcXn-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507041803.6bndMcXn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507041803.6bndMcXn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/mctp/route.c:1584:
   net/mctp/test/route-test.c:1258:65: warning: 'type1' defined but not used [-Wunused-const-variable=]
    1258 | static const struct mctp_test_bind_setup bind_addr8_netdefault, type1 = {
         |                                                                 ^~~~~
   net/mctp/test/route-test.c:1258:42: warning: 'bind_addr8_netdefault' defined but not used [-Wunused-const-variable=]
    1258 | static const struct mctp_test_bind_setup bind_addr8_netdefault, type1 = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~
   net/mctp/test/route-test.c: In function 'mctp_bind_pair_desc':
>> net/mctp/test/route-test.c:1340:49: warning: '%s' directive output may be truncated writing up to 99 bytes into a region of size between 87 and 101 [-Wformat-truncation=]
    1340 |                  "{bind(addr %d, type %d, net %d%s)} {bind(addr %d, type %d, net %d%s)} -> error %d",
         |                                                 ^~
    1341 |                  t->bind1->bind_addr, t->bind1->bind_type, t->bind1->bind_net, peer1,
         |                                                                                ~~~~~
   net/mctp/test/route-test.c:1340:18: note: directive argument in the range [0, 255]
    1340 |                  "{bind(addr %d, type %d, net %d%s)} {bind(addr %d, type %d, net %d%s)} -> error %d",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mctp/test/route-test.c:1340:18: note: directive argument in the range [0, 255]
   net/mctp/test/route-test.c:1339:9: note: 'snprintf' output between 71 and 307 bytes into a destination of size 128
    1339 |         snprintf(desc, KUNIT_PARAM_DESC_SIZE,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1340 |                  "{bind(addr %d, type %d, net %d%s)} {bind(addr %d, type %d, net %d%s)} -> error %d",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1341 |                  t->bind1->bind_addr, t->bind1->bind_type, t->bind1->bind_net, peer1,
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1342 |                  t->bind2->bind_addr, t->bind2->bind_type, t->bind2->bind_net, peer2,
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1343 |                  t->error);
         |                  ~~~~~~~~~


vim +1340 net/mctp/test/route-test.c

  1257	
> 1258	static const struct mctp_test_bind_setup bind_addr8_netdefault, type1 = {
  1259		.bind_addr = 8, .bind_net = MCTP_NET_ANY, .bind_type = 1,
  1260	};
  1261	
  1262	/* 1 is default net */
  1263	static const struct mctp_test_bind_setup bind_addr8_net1_type1 = {
  1264		.bind_addr = 8, .bind_net = 1, .bind_type = 1,
  1265	};
  1266	
  1267	static const struct mctp_test_bind_setup bind_addrany_net1_type1 = {
  1268		.bind_addr = MCTP_ADDR_ANY, .bind_net = 1, .bind_type = 1,
  1269	};
  1270	
  1271	/* 2 is an arbitrary net */
  1272	static const struct mctp_test_bind_setup bind_addr8_net2_type1 = {
  1273		.bind_addr = 8, .bind_net = 2, .bind_type = 1,
  1274	};
  1275	
  1276	static const struct mctp_test_bind_setup bind_addr8_netdefault_type1 = {
  1277		.bind_addr = 8, .bind_net = MCTP_NET_ANY, .bind_type = 1,
  1278	};
  1279	
  1280	static const struct mctp_test_bind_setup bind_addrany_net2_type2 = {
  1281		.bind_addr = MCTP_ADDR_ANY, .bind_net = 2, .bind_type = 2,
  1282	};
  1283	
  1284	static const struct mctp_test_bind_setup bind_addrany_net2_type1_peer9 = {
  1285		.bind_addr = MCTP_ADDR_ANY, .bind_net = 2, .bind_type = 1,
  1286		.have_peer = true, .peer_addr = 9, .peer_net = 2,
  1287	};
  1288	
  1289	struct mctp_bind_pair_test {
  1290		const struct mctp_test_bind_setup *bind1;
  1291		const struct mctp_test_bind_setup *bind2;
  1292		int error;
  1293	};
  1294	
  1295	/* Pairs of binds and whether they will conflict */
  1296	static const struct mctp_bind_pair_test mctp_bind_pair_tests[] = {
  1297		/* Both ADDR_ANY, conflict */
  1298		{ &bind_addrany_netdefault_type1, &bind_addrany_netdefault_type1, EADDRINUSE },
  1299		/* Same specific EID, conflict */
  1300		{ &bind_addr8_netdefault_type1, &bind_addr8_netdefault_type1, EADDRINUSE },
  1301		/* ADDR_ANY vs specific EID, OK */
  1302		{ &bind_addrany_netdefault_type1, &bind_addr8_netdefault_type1, 0 },
  1303		/* ADDR_ANY different types, OK */
  1304		{ &bind_addrany_net2_type2, &bind_addrany_net2_type1, 0 },
  1305		/* ADDR_ANY different nets, OK */
  1306		{ &bind_addrany_net2_type1, &bind_addrany_netdefault_type1, 0 },
  1307	
  1308		/* specific EID, NET_ANY (resolves to default)
  1309		 *  vs specific EID, explicit default net 1, conflict
  1310		 */
  1311		{ &bind_addr8_netdefault_type1, &bind_addr8_net1_type1, EADDRINUSE },
  1312	
  1313		/* specific EID, net 1 vs specific EID, net 2, ok */
  1314		{ &bind_addr8_net1_type1, &bind_addr8_net2_type1, 0 },
  1315	
  1316		/* ANY_ADDR, NET_ANY (doesn't resolve to default)
  1317		 *  vs ADDR_ANY, explicit default net 1, OK
  1318		 */
  1319		{ &bind_addrany_netdefault_type1, &bind_addrany_net1_type1, 0 },
  1320	
  1321		/* specific remote peer doesn't conflict with any-peer bind */
  1322		{ &bind_addrany_net2_type1_peer9, &bind_addrany_net2_type1, 0 },
  1323	
  1324		/* bind() NET_ANY is allowed with a connect() net */
  1325		{ &bind_addrany_net2_type1_peer9, &bind_addrany_netdefault_type1, 0 },
  1326	};
  1327	
  1328	static void mctp_bind_pair_desc(const struct mctp_bind_pair_test *t, char *desc)
  1329	{
  1330		char peer1[100] = {0}, peer2[100] = {0};
  1331	
  1332		if (t->bind1->have_peer)
  1333			snprintf(peer1, sizeof(peer1), ", peer %d net %d",
  1334				 t->bind1->peer_addr, t->bind1->peer_net);
  1335		if (t->bind2->have_peer)
  1336			snprintf(peer2, sizeof(peer2), ", peer %d net %d",
  1337				 t->bind2->peer_addr, t->bind2->peer_net);
  1338	
  1339		snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> 1340			 "{bind(addr %d, type %d, net %d%s)} {bind(addr %d, type %d, net %d%s)} -> error %d",
  1341			 t->bind1->bind_addr, t->bind1->bind_type, t->bind1->bind_net, peer1,
  1342			 t->bind2->bind_addr, t->bind2->bind_type, t->bind2->bind_net, peer2,
  1343			 t->error);
  1344	}
  1345	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

