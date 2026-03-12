Return-Path: <netdev+bounces-266904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD06L2RCsmlFKgAAu9opvQ
	(envelope-from <netdev+bounces-266904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:34:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 383AD26D224
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26DB4302D592
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3BD3976A5;
	Thu, 12 Mar 2026 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DX4b9bMP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21A397683;
	Thu, 12 Mar 2026 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290081; cv=none; b=N5GNdZnkF741sRvFxWWOhNkzQ2JZwEs89Mwsn2uIAWBMbDOMKotq8A/g3bXeCkmaU14wdzyJzCTEP/2w2IG9RuhraCth2h8dKNNJlLIgUTkizRifZBWLPWHEmZU9mV3kD2O52LyyTgywBz5xGDc1eEh6TRLwrk+sVdl6+2z2WoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290081; c=relaxed/simple;
	bh=LVpsjxK//rsEadbTuzbHtfoezi6enpVrHOBYLFvVq0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcCF1qOMajY7ghgjSSzaVQVz/HZpNSqtIHrpUfnXBmaUUKhVT6V17+XV5NlDL6PxOKLu9HEDqHdezwvX5n/09STxPJ/xmc5aNE76AEd777m5KSgyzvYDBIoF0OiBj6ECdRPsV5yhpOvH2HzB5Jq0dC9jTMrXx17jLZ5IL+fTpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DX4b9bMP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773290079; x=1804826079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVpsjxK//rsEadbTuzbHtfoezi6enpVrHOBYLFvVq0M=;
  b=DX4b9bMP4i6IJm6j3yuVnhDHyn8Uu9fqbit3uCOiKq9Eu1bqE/23XDSA
   2Bftm8L6djLfxe6B/7Yf5XTAC9CSk4jpG26QJdDsis0xxV3IZqjVbS/X3
   xo+OVUC8HwXD7Ez9pw3XZJZ25UiM2pl9p/403v/4/x+JYoh3TeWSPoEJ5
   KxVCNU3C3cn50Vd80EFv90FCzi/OttgXEG+xVSB0Ms2gAyf90rlbZ7AHA
   9/Kx8RhY8Jr3bmsXQRAbTfFXuV59m2yOLOeS7+yWp15Ifzfr6AdzSiuPZ
   NipYJPUjM1vjJAthgg6Dd3q6FuQNAYuVdaCP70NEbHLQW6OR9rs9RwZrt
   Q==;
X-CSE-ConnectionGUID: L0ICCTbpS9a6Soj92OL8YQ==
X-CSE-MsgGUID: QaZnxdBcQYSZsThLaVLzYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74070512"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74070512"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 21:34:38 -0700
X-CSE-ConnectionGUID: XhrHr4tTSvubEH/bUJ/NCA==
X-CSE-MsgGUID: pxDWMSpuR0ubOV55xHpj7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="243708259"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2026 21:34:34 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0Xkl-0000000024l-0oNB;
	Thu, 12 Mar 2026 04:34:31 +0000
Date: Thu, 12 Mar 2026 12:34:23 +0800
From: kernel test robot <lkp@intel.com>
To: Matteo Croce <technoboy85@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] e1000e: add basic XDP support
Message-ID: <202603121204.pJemiT27-lkp@intel.com>
References: <20260311191437.3581-2-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311191437.3581-2-teknoraver@meta.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266904-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 383AD26D224
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Matteo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Croce/e1000e-add-basic-XDP-support/20260312-032318
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260311191437.3581-2-teknoraver%40meta.com
patch subject: [PATCH net-next 1/2] e1000e: add basic XDP support
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20260312/202603121204.pJemiT27-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603121204.pJemiT27-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603121204.pJemiT27-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `e1000_alloc_rx_buffers_xdp':
>> netdev.c:(.text+0xc077cf): undefined reference to `page_pool_alloc_pages'
   ld: vmlinux.o: in function `e1000e_setup_rx_resources':
>> (.text+0xc0c879): undefined reference to `page_pool_create'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

