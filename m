Return-Path: <netdev+bounces-266215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPtiDqs6sGmDhQIAu9opvQ
	(envelope-from <netdev+bounces-266215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:37:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C94D253B48
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9207B33074E7
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F730AD00;
	Tue, 10 Mar 2026 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0H6UNSH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF83090FF;
	Tue, 10 Mar 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155603; cv=none; b=X6V9lzE8E7fG/F6LkFdTaB5T8YBM+A1T3CAec+UzUZdxxLwSTxvj84xnhC8CJCW7SLCDSfzlYE1FHQTWxrLLI41xasf9k0XH6Pf2Q8pvHaIO/ZHMg47VLwlsEqNv5ZzXy6dLNgyfvNsZ4P7z+CPsl6DzMCZ3O6fD/8AxlNVNgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155603; c=relaxed/simple;
	bh=HcwXFR0BZU04L0TE60XkSDcUfw0nCPDh63QT4nmIVHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWnPRG9AUhwX743PIwwLuqs0Ejj3RZfWSjNYs/k9LLBNIVK91qHz4xz9ym902BUGg/KVoiq/Da11LiMiFQ2bAb++uZPx6zvkoVwq0E/3u8arh2RUyh6SzpO4zQtnkRltYbkPgpsmMvSONZ3fNHKDXnK1b3/J7lm+Ys7hbN5xIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0H6UNSH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773155603; x=1804691603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HcwXFR0BZU04L0TE60XkSDcUfw0nCPDh63QT4nmIVHA=;
  b=F0H6UNSHwAvdwIk4kJ1xPLmnbKBhUAKP4mEbDo5IQf4Ydk/ILskrYzv8
   ZPpYUvj5WIrYgNV715DM2lQSfvORbmVo+VjtMZVizbFAbqgUtBt8hkSCh
   7iRKrhwxsRXljeN+T1iM++ZG4/bQ2/8ndK+IEGA/3qAXbkGsI4McbiYoW
   l+g6iF2jhhOrRFBlEW2dtovISsvl/S3PBQWda3XJ7bqqtqt7wT1cAcar7
   /N6oUOzxmc86QCvr0a+bj4uCd/qozGrGkOPtYYF84kdR8KR6vcYHQdqx0
   4h1vx+00dNXUrdzD1S67WKv1Rtk+v9Y5P2hq745woEzrJU0CfjR6ZF8AY
   A==;
X-CSE-ConnectionGUID: zLlNmiBUT9G9QDSEJCxGEw==
X-CSE-MsgGUID: IpaqhsuYRkmCvTs/v0QOSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73905999"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="73905999"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 08:13:18 -0700
X-CSE-ConnectionGUID: cs0c6UAnT/afM9ucvlIxLA==
X-CSE-MsgGUID: 1H3Lok8/QfmhajCA3HQBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220327038"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Mar 2026 08:13:13 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzylh-0000000027E-3rVa;
	Tue, 10 Mar 2026 15:13:09 +0000
Date: Tue, 10 Mar 2026 23:12:43 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <202603102342.ymeQ8hLm-lkp@intel.com>
References: <f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 8C94D253B48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266215-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,param.tci:url]
X-Rspamd-Action: no action

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/dsa-tag_mxl862xx-set-dsa_default_offload_fwd_mark/20260310-084425
base:   net-next/main
patch link:    https://lore.kernel.org/r/f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel%40makrotopia.org
patch subject: [PATCH net-next v2 2/2] net: dsa: mxl862xx: implement bridge offloading
config: sh-randconfig-001-20260310 (https://download.01.org/0day-ci/archive/20260310/202603102342.ymeQ8hLm-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260310/202603102342.ymeQ8hLm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603102342.ymeQ8hLm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/dsa/mxl862xx/mxl862xx.c: In function 'mxl862xx_port_fdb_add':
>> drivers/net/dsa/mxl862xx/mxl862xx.c:655:9: error: implicit declaration of function 'ether_addr_copy'; did you mean 'inetpeer_addr_cmp'? [-Wimplicit-function-declaration]
     655 |         ether_addr_copy(param.mac, addr);
         |         ^~~~~~~~~~~~~~~
         |         inetpeer_addr_cmp


vim +655 drivers/net/dsa/mxl862xx/mxl862xx.c

   640	
   641	static int mxl862xx_port_fdb_add(struct dsa_switch *ds, int port,
   642					 const unsigned char *addr, u16 vid, struct dsa_db db)
   643	{
   644		struct mxl862xx_mac_table_add param = { };
   645		int fid = mxl862xx_get_fid(ds, db), ret;
   646		struct mxl862xx_priv *priv = ds->priv;
   647	
   648		if (fid < 0)
   649			return fid;
   650	
   651		param.port_id = cpu_to_le32(port);
   652		param.static_entry = true;
   653		param.fid = cpu_to_le16(fid);
   654		param.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, vid));
 > 655		ether_addr_copy(param.mac, addr);
   656	
   657		ret = MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYADD, param);
   658		if (ret)
   659			dev_err(ds->dev, "failed to add FDB entry on port %d\n", port);
   660	
   661		return ret;
   662	}
   663	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

