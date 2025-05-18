Return-Path: <netdev+bounces-191339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF062ABAF6D
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F4175D40
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3C4B1E76;
	Sun, 18 May 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xr4Q9p3P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70B199FBA
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747565666; cv=none; b=RpF9WFe7LJst6wvSv5vqEYGoFNYYTFeVD/vbQQFU2UxUceH4un3lC+pRze67FA2YaQs+IWSBbpkIbZwnMHpNZFt2IUGZRkdseRPNP+USpnBeG7m5G1SWEz7Zda1oKDNI87yCYWyLjZKJT30Td10lAGOmG3OzjzqB6IYDcxBJNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747565666; c=relaxed/simple;
	bh=f9+6lJcYol3jp1fcgQ6ZYxJLTwEocCLwPQp/RuchLl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgmsUBmwXKhe8p9gak0/ax8Ncq7duliLV5ylhPS9+RQZ3zcZRANI9bz70Dljya2r3mDEI0C0IlLEGn7na1pi8W4o2zhiSgK7XJrNrQXwn6n495OjTvFipyvfMmJtWnT1A8oB1qA/SSRRa965X3hlSYyyqWmPIQMPXRFBlbyHkko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xr4Q9p3P; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747565664; x=1779101664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f9+6lJcYol3jp1fcgQ6ZYxJLTwEocCLwPQp/RuchLl4=;
  b=Xr4Q9p3PYf3Lcxov9e9knvPWI3beB4PnGizejDg30U5yaLCPPYcNUlUn
   LXyHbGD+/EXeOcdJ14iPb4/pcfhrRDwV3oHRGeRv2WdziVl+gdAHosnyE
   Ru+0UwzMUofnzclVPgbHdiDnNUcsFZNiljAr42LHWermKQAauDl/RNYKs
   eA1d2A/D82jxAWw5CCEG8zUe4Jmdz2X3KrsgTiFjKHM3XU4/Cac7vf4F2
   uOYYL9ThiTZqWZ/GUmLeiMcAGdMUDBVlbY+8ipQCbZxKN10gztL4l28di
   UZbHbHavH2MJ6PhW/7VtkMuFAtvZEplwumS2JBnH8zczhh6/hFMBD4Fuw
   g==;
X-CSE-ConnectionGUID: XbKbk21oRLe7GEaIW8BN+A==
X-CSE-MsgGUID: gjtOYM2qSHGkvQu3fsU/lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="49634339"
X-IronPort-AV: E=Sophos;i="6.15,298,1739865600"; 
   d="scan'208";a="49634339"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 03:54:23 -0700
X-CSE-ConnectionGUID: C0CJ6k1IS7y4HDbGI26wYQ==
X-CSE-MsgGUID: 1Tn86WfATlOK1AyqZjRgMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,298,1739865600"; 
   d="scan'208";a="139154387"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 May 2025 03:54:21 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGbes-000Kkx-2w;
	Sun, 18 May 2025 10:54:18 +0000
Date: Sun, 18 May 2025 18:54:13 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] ovpn: properly deconfigure UDP-tunnel
Message-ID: <202505182055.9AF6d1fu-lkp@intel.com>
References: <20250514095842.12067-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514095842.12067-1-antonio@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/ovpn-properly-deconfigure-UDP-tunnel/20250514-180029
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250514095842.12067-1-antonio%40openvpn.net
patch subject: [PATCH net-next] ovpn: properly deconfigure UDP-tunnel
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250518/202505182055.9AF6d1fu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250518/202505182055.9AF6d1fu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505182055.9AF6d1fu-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "udpv6_encap_needed_key" [net/ipv4/udp_tunnel.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

