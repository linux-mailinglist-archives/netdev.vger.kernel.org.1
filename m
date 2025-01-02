Return-Path: <netdev+bounces-154728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B59FF998
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CF116277F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130E06FB0;
	Thu,  2 Jan 2025 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+xZl3ny"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402718BE5;
	Thu,  2 Jan 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735823097; cv=none; b=CGDr/hsx8h5OO7FxqkOjT6SL9x2rdzyxcWWGu9yZMTPEKucp0pSzSZeVLfKOqC0goh+DE9nPq9z6P8Oltle27J6GJ+OEt3vUQ291D/uiIQ7v07x0+ZPezXuqmn1YqhH0aNG10X6boo9gAgc9LxQvTp0WDvo9s94ujMesT4SBna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735823097; c=relaxed/simple;
	bh=MyiQ5rs7irBI2s5zak+5MNpRwo9hfZpRiM0mF8/K27c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuRQC5aMZkh6SG2de/fnDz9ltGe325YOXwyAY2QbIxCu4uAdk8WA9fLH5trrbibI9gC+ELEYRSwlrmZSAiLUw0O4OUiHn31kQ76cErqkJtf9NIjpWxtbrZOQ5Tn1VrdW+IZC1yb7/tOADIbKoUlpzSm18+oh2ZSgugAyTPGe22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+xZl3ny; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735823095; x=1767359095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyiQ5rs7irBI2s5zak+5MNpRwo9hfZpRiM0mF8/K27c=;
  b=j+xZl3nyuNH8ddAsgjcAkYIiUjww//+YYNW30HV25r9G6DCX5nEq5rta
   BUVPcPSCXWO8Kg+Ud9vIrgBR7c356pef0T0xFn1bTWz03hSUxjXNTP9ce
   i8vkMzQKGdxHcJUS+PZ3SV7ce3/sfklhXRFuW+QBu7ljrzH3SedS026cw
   B2q/uMhmZpUi18xQAdpIDjsBBgcXpIA0sju9Fro7k6pMzzB1Cvpf5+4iL
   rzqLPMRoqfUr22pe0/5EynvZkHSQtvuBm+HDmSxsKlSqMkZ+m5hPUziOi
   7yolfwwiBPVhamuX9v0EbHSXYotGF0Y5ijcUrccQYKkln2qQDyGrQ1JWm
   Q==;
X-CSE-ConnectionGUID: eYzGWlRoTNaHr9hiyPZQ/g==
X-CSE-MsgGUID: X5gR70GITpOaljBxcvXgtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="35301553"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="35301553"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 05:04:39 -0800
X-CSE-ConnectionGUID: suJd/1WaRES5LC6uzuojLA==
X-CSE-MsgGUID: VgInYyNqSV6V66l5vbyMRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124775510"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Jan 2025 05:04:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTKsJ-0008Vj-1k;
	Thu, 02 Jan 2025 13:04:31 +0000
Date: Thu, 2 Jan 2025 21:03:37 +0800
From: kernel test robot <lkp@intel.com>
To: shiming cheng <shiming.cheng@mediatek.com>,
	willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, lena.wang@mediatek.com,
	shiming cheng <shiming.cheng@mediatek.com>
Subject: Re: [PATCH]  ipv6: socket SO_BINDTODEVICE lookup routing fail
 without IPv6 rule.
Message-ID: <202501022057.YOhf05jy-lkp@intel.com>
References: <20250102095114.25860-1-shiming.cheng@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102095114.25860-1-shiming.cheng@mediatek.com>

Hi shiming,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main soc/for-next linus/master v6.13-rc5 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiming-cheng/ipv6-socket-SO_BINDTODEVICE-lookup-routing-fail-without-IPv6-rule/20250102-174939
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250102095114.25860-1-shiming.cheng%40mediatek.com
patch subject: [PATCH]  ipv6: socket SO_BINDTODEVICE lookup routing fail without IPv6 rule.
config: riscv-randconfig-001-20250102 (https://download.01.org/0day-ci/archive/20250102/202501022057.YOhf05jy-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250102/202501022057.YOhf05jy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501022057.YOhf05jy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv6/ip6_output.c:1239:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1259:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1294:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1311:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1317:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1327:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1348:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1429:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1834:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1867:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1876:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1898:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1978:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:1998:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:2013:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:2027:1: error: function definition is not allowed here
   {
   ^
   net/ipv6/ip6_output.c:2039:1: error: function definition is not allowed here
   {
   ^
>> net/ipv6/ip6_output.c:2074:2: error: expected '}'
   }
    ^
   net/ipv6/ip6_output.c:1107:1: note: to match this '{'
   {
   ^
   18 errors generated.


vim +1239 net/ipv6/ip6_output.c

34a0b3cdc07874 Adrian Bunk              2005-11-29  1225  
497c615abad7ee Herbert Xu               2006-07-30  1226  /**
497c615abad7ee Herbert Xu               2006-07-30  1227   *	ip6_dst_lookup - perform route lookup on flow
b51cd7c834dba0 Andrew Lunn              2020-07-13  1228   *	@net: Network namespace to perform lookup in
497c615abad7ee Herbert Xu               2006-07-30  1229   *	@sk: socket which provides route info
497c615abad7ee Herbert Xu               2006-07-30  1230   *	@dst: pointer to dst_entry * for result
4c9483b2fb5d25 David S. Miller          2011-03-12  1231   *	@fl6: flow to lookup
497c615abad7ee Herbert Xu               2006-07-30  1232   *
497c615abad7ee Herbert Xu               2006-07-30  1233   *	This function performs a route lookup on the given flow.
497c615abad7ee Herbert Xu               2006-07-30  1234   *
497c615abad7ee Herbert Xu               2006-07-30  1235   *	It returns zero on success, or a standard errno code on error.
497c615abad7ee Herbert Xu               2006-07-30  1236   */
343d60aada5a35 Roopa Prabhu             2015-07-30  1237  int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
343d60aada5a35 Roopa Prabhu             2015-07-30  1238  		   struct flowi6 *fl6)
497c615abad7ee Herbert Xu               2006-07-30 @1239  {
497c615abad7ee Herbert Xu               2006-07-30  1240  	*dst = NULL;
343d60aada5a35 Roopa Prabhu             2015-07-30  1241  	return ip6_dst_lookup_tail(net, sk, dst, fl6);
497c615abad7ee Herbert Xu               2006-07-30  1242  }
3cf3dc6c2e05e6 Arnaldo Carvalho de Melo 2005-12-13  1243  EXPORT_SYMBOL_GPL(ip6_dst_lookup);
3cf3dc6c2e05e6 Arnaldo Carvalho de Melo 2005-12-13  1244  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

