Return-Path: <netdev+bounces-264064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJNkO5yuqGmfwQAAu9opvQ
	(envelope-from <netdev+bounces-264064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:13:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4662085C6
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A5833013960
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908C379ED4;
	Wed,  4 Mar 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGU4lD6T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAA351C02;
	Wed,  4 Mar 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662426; cv=none; b=faJKrr8wsYwWCSLjy/Z5gG6TAfiOprHOh5GAPtZCcIpBe9BcOaI4unfJ0/vfNEvxJwv/BTx80BhCdhAtGV3dI6Q9i1iYbzOuv4iK0DHeyUEprsj4uR+SsgblEm9sHv13tItkFtxwZBqTHvD/uhXv/L2HoKhprpqHK47dic8nVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662426; c=relaxed/simple;
	bh=8viQ62Vl8rOScrYYff4z3W73/71vqWr9R5SU1cx41TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USUhEIg45iDSvOZ50+U/wI+B1dBOo2ObNqRTaN89immnR2lhcxHv2juODxZbx5Ov6K+fvPzeWY3/3h0G0NZ3SPd+GkyD7482EEEm96DcOiXGBeaJwTxhvcIupsYYqbVSYxVbWVib0qIYsd+69LccXCg2IBh5j5Orgj5W5JZ6NXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGU4lD6T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772662423; x=1804198423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8viQ62Vl8rOScrYYff4z3W73/71vqWr9R5SU1cx41TU=;
  b=LGU4lD6T9socxIoLAOWJ85iz5AGm31KQBaDFGz9MLrcDEEMng3nH5Vou
   Z7xWFbbH/vnLJdHzj3hxdRc3uexUKn7xTGW/9ahtEx9iFtx57uIQOookY
   ta85xoXLt0ZKV29LSns1bXGsYdqI+mY8I6fkmNZwg/Ex9+beuydJmgC5p
   IMK40buOf4b3JI0fEMKps77B00L8mUG5KAChryq9Yo75F8DL3WQsengra
   38lNcvcc6gTvTec7VTiOznm/I3cSUubhrQEHP+EhZJdvNNHNNLPBa3LuZ
   IAlhMUpvLEyYr9vf5IWlAcDIcx28nkcGEajV2YNtQIvLQ5SQsmsEZo4w1
   Q==;
X-CSE-ConnectionGUID: 4bNaekX0TwOioMI66QQ89A==
X-CSE-MsgGUID: EwSZKSgyQhK7XOkcxbAZaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="61309895"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="61309895"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:13:42 -0800
X-CSE-ConnectionGUID: vKgF8lqPSuuf9WEb103q4w==
X-CSE-MsgGUID: 4DnBmdg1RWOursf8+vRWaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="223440410"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2026 14:13:38 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxuTF-000000004a9-1tK7;
	Wed, 04 Mar 2026 22:13:33 +0000
Date: Thu, 5 Mar 2026 06:13:31 +0800
From: kernel test robot <lkp@intel.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce Airoha AN8801/R Gigabit
 Ethernet PHY driver
Message-ID: <202603050606.eulVmYcb-lkp@intel.com>
References: <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
X-Rspamd-Queue-Id: 8B4662085C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,airoha.com,mediatek.com,gmail.com,collabora.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-264064-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[collabora.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Louis-Alexis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ed0abfe93fd135dac223e87a3c945017b1fa8bfc]

url:    https://github.com/intel-lab-lkp/linux/commits/Louis-Alexis-Eyraud/dt-bindings-net-Add-support-for-Airoha-AN8801-R-GbE-PHY/20260304-174023
base:   ed0abfe93fd135dac223e87a3c945017b1fa8bfc
patch link:    https://lore.kernel.org/r/20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d%40collabora.com
patch subject: [PATCH net-next 2/2] net: phy: Introduce Airoha AN8801/R Gigabit Ethernet PHY driver
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260305/202603050606.eulVmYcb-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050606.eulVmYcb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050606.eulVmYcb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/air_an8801.c:258:6: warning: variable 'pbus_data_h' is uninitialized when used here [-Wuninitialized]
     258 |         if (pbus_data_h < 0)
         |             ^~~~~~~~~~~
   drivers/net/phy/air_an8801.c:240:30: note: initialize the variable 'pbus_data_h' to silence this warning
     240 |         int pbus_data_l, pbus_data_h;
         |                                     ^
         |                                      = 0
   1 warning generated.


vim +/pbus_data_h +258 drivers/net/phy/air_an8801.c

   236	
   237	static int __air_buckpbus_reg_read(struct phy_device *phydev,
   238					   u32 addr, u32 *data)
   239	{
   240		int pbus_data_l, pbus_data_h;
   241		int ret;
   242	
   243		addr |= AN8801_PBUS_ACCESS;
   244	
   245		ret = __phy_write(phydev, AIR_BPBUS_MODE, MII_MMD_CTRL_ADDR);
   246		if (ret < 0)
   247			return ret;
   248	
   249		ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_HIGH, upper_16_bits(addr));
   250		if (ret < 0)
   251			return ret;
   252	
   253		ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_LOW, lower_16_bits(addr));
   254		if (ret < 0)
   255			return ret;
   256	
   257		ret = __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
 > 258		if (pbus_data_h < 0)
   259			return pbus_data_h;
   260	
   261		pbus_data_l = __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
   262		if (pbus_data_l < 0)
   263			return pbus_data_l;
   264	
   265		*data = (pbus_data_h << 16) | pbus_data_l;
   266		return 0;
   267	}
   268	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

