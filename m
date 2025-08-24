Return-Path: <netdev+bounces-216322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470AEB33182
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736A4446B1A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A62750E6;
	Sun, 24 Aug 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4zSpVou"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98F35963;
	Sun, 24 Aug 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053662; cv=none; b=irzlFlr1/vrd7w6NTH8W0nLX8EH294ktPOXRluq0gDVyXDfVf4r+o11RpLL9kYaJUrisy0jDrqHMB7S1DHnUn8sp/vkjkYeZbbnA4+uUBKd3TuNq2z4cv9TQZxOvI5Zv9LFTEF5fpLpxOYETMtouybr4qSXyhC/GKGmz1vdkBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053662; c=relaxed/simple;
	bh=T0Xh8r2YCTqxv1vEbjm0Y0dC1Af3oWo4iIuijEyUQAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6uKnU0Td4x7AObSLHYcmkiTrkEJk00cjT9PzYGzqwL+gl8WsIDAuFpjenvat5wEf0WuasTXpenE4C7e91Y4RYUsFZWr8faoRQArlNCm1ImMUP+cY2YXyiGMK46qp3fnLBwADaqk2s5Q2W21kiRTlWaOSLmeGxvULEwssiNGCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4zSpVou; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756053661; x=1787589661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T0Xh8r2YCTqxv1vEbjm0Y0dC1Af3oWo4iIuijEyUQAg=;
  b=F4zSpVouIeLyiR4mrg0D1fYwJcmadfVJz2YKiXOnx3/hA/2S2heu5jhx
   FwX9uzlV/PWm0g39HsHxp0etxCnHZxNPHfZy9JSku6t2utVBLrl+xgyb+
   9GOvXHWNGhEtjGJ7AxvUAxxFl7u2Xu8Sl9FhAaVwBG9uD0avmsGXkta/w
   l6RxNZ8nbqdf95cNNoeeOj9axNVRJnKKO7CfaM7AX6XA3U8Vd+grIHcVZ
   j0jnv4feFwjbXh+OiR+0tNH0H7eKEl8IZBUoM5aAyG3h0Hzj4HVKJVUwg
   TUcOckhTTXQ++eVeVnHvbqr1MFK/z/q3ePOCcy1NAkB+WHQhsulG7h9h9
   A==;
X-CSE-ConnectionGUID: lOx58MRtR3K8QZ2IKFAkuA==
X-CSE-MsgGUID: 5Bh0ULSzRYiEfqP0nNYWIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69382466"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69382466"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 09:41:00 -0700
X-CSE-ConnectionGUID: ZXX6juDMRLScDZOFidyRMw==
X-CSE-MsgGUID: qczmWVd4S5+NKxb4zEUCBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169937558"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 24 Aug 2025 09:40:57 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqDm3-000N5v-0g;
	Sun, 24 Aug 2025 16:40:55 +0000
Date: Mon, 25 Aug 2025 00:40:03 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <202508250002.afAgRCmk-lkp@intel.com>
References: <20250824005116.2434998-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824005116.2434998-4-mmyangfl@gmail.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/dt-bindings-net-dsa-yt921x-Add-Motorcomm-YT921x-switch-support/20250824-085750
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250824005116.2434998-4-mmyangfl%40gmail.com
patch subject: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for Motorcomm YT921x
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250825/202508250002.afAgRCmk-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250825/202508250002.afAgRCmk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508250002.afAgRCmk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/yt921x.c: In function 'yt921x_port_down':
>> drivers/net/dsa/yt921x.c:2683:13: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
    2683 |         u32 mask;
         |             ^~~~


vim +/mask +2683 drivers/net/dsa/yt921x.c

  2680	
  2681	static int yt921x_port_down(struct yt921x_priv *priv, int port)
  2682	{
> 2683		u32 mask;
  2684		u32 ctrl;
  2685		int res;
  2686	
  2687		ctrl = YT921X_PORT_LINK | YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
  2688		res = yt921x_smi_clear_bits(priv, YT921X_PORTn_CTRL(port), ctrl);
  2689		if (res)
  2690			return res;
  2691	
  2692		if (yt921x_port_is_external(port)) {
  2693			ctrl = YT921X_SGMII_LINK;
  2694			res = yt921x_smi_clear_bits(priv, YT921X_SGMIIn(port), ctrl);
  2695			if (res)
  2696				return res;
  2697	
  2698			mask = YT921X_XMII_LINK;
  2699			res = yt921x_smi_clear_bits(priv, YT921X_XMIIn(port), ctrl);
  2700			if (res)
  2701				return res;
  2702		}
  2703	
  2704		return 0;
  2705	}
  2706	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

