Return-Path: <netdev+bounces-273246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHCUDTiYymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8335DF8B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0A3305CDF1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D9344DB7;
	Mon, 30 Mar 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmUasWh2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD833FE27
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884143; cv=none; b=YwB00vPayh1QEyWcTJsPkBXYABDZrkrzUqfoybiIfJ9et+MWYljxEWTEdHVZTinxMKA8d7OeNskYmj2eUTwAh7PuO2zhJsf8RqPvuDZjZrR7V+XV3cpofbbgi5byCcPHvnYQG71rjYv6RU41HknXHRZmRK5D3N76ixmwkuNndyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884143; c=relaxed/simple;
	bh=IvRLsuuNROeCtz5fhILDmAl8aXxGZEnNZRvHw+5mxU0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aHJk1GGT+of4rRLP8zdAkoYtNfeQiqDlPhz2lZ75HF3cwNO2sMRU8wv9/nnm9I1SrUOUfDSZzmzk3tnlbSMc/BZKOokhx+MLMoqAUEc9ScEWNfHKniASUHF7KNLO5VfqZOshG+RUvN5bB21eBnNrVVaZst+4CnagMONFGrUhcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmUasWh2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774884140; x=1806420140;
  h=date:from:to:cc:subject:message-id;
  bh=IvRLsuuNROeCtz5fhILDmAl8aXxGZEnNZRvHw+5mxU0=;
  b=PmUasWh2RXbfp1LTrjs1EytizVEX62sDmM0OALh1CFQ36saGkawn3FHI
   fgLNYZc6Q46HxARqXUd0b1KbRXonM3SxemUHJbl5iMtn6OJo110TOAdJd
   FoceuuZvQFYR5I2heG7MC1sE4UvyHOQW8EsStckgb3uvmrljYxAqQyMLz
   bRiModBOHtHLjy2llr6ckWI/r2hyWGjkPUjkcYudHDGgUGlrADyvZv4GF
   /iaXIguElpxltiflvXjs3xZczn/1UzTfy9UAKTaeGWxBpbaevTUji/bOd
   cQx9aMsANuOzz2/HFjrxBt8NFsp+XwQk4aSfzWwHuZDegoDa+6IX+FpfQ
   w==;
X-CSE-ConnectionGUID: P9yV4XFJQl2ORJrYbH87xQ==
X-CSE-MsgGUID: yYmH0lHNTdeu+vLt6qDWHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86956977"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="86956977"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 08:22:20 -0700
X-CSE-ConnectionGUID: 9lf89LolQ5S2G1G4a1OS6w==
X-CSE-MsgGUID: 8cs1bbD2SgGkVhy9K0nonA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="249138717"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 08:22:18 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7ERT-000000001G1-3djt;
	Mon, 30 Mar 2026 15:22:15 +0000
Date: Mon, 30 Mar 2026 23:21:54 +0800
From: kernel test robot <lkp@intel.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Subject: [net-next:main 35/51]
 drivers/net/ethernet/cadence/macb_main.c:5710:19: error: 'at91_default_usrio'
 undeclared here (not in a function)
Message-ID: <202603302354.afJpLbxZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273246-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 5BD8335DF8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   cf0d9080c6f795bc6be08babbffa29b62c06e9b0
commit: a17871778ee28e4df054521e966e9f37c61f541b [35/51] net: macb: rename macb_default_usrio to at91_default_usrio as not all platforms have mii mode control in usrio
config: i386-randconfig-016-20260330 (https://download.01.org/0day-ci/archive/20260330/202603302354.afJpLbxZ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603302354.afJpLbxZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603302354.afJpLbxZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/cadence/macb_main.c:5710:19: error: 'at91_default_usrio' undeclared here (not in a function)
    5710 |         .usrio = &at91_default_usrio,
         |                   ^~~~~~~~~~~~~~~~~~


vim +/at91_default_usrio +5710 drivers/net/ethernet/cadence/macb_main.c

  5704	
  5705	static const struct macb_config default_gem_config = {
  5706		.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
  5707			MACB_CAPS_JUMBO |
  5708			MACB_CAPS_GEM_HAS_PTP,
  5709		.dma_burst_length = 16,
> 5710		.usrio = &at91_default_usrio,
  5711		.jumbo_max_len = 10240,
  5712	};
  5713	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

