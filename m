Return-Path: <netdev+bounces-278744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFDDF09q32niSgAAu9opvQ
	(envelope-from <netdev+bounces-278744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:37:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB2403514
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2741E3017C18
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BC33FE1F;
	Wed, 15 Apr 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzGAju9R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65033F5B5
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249420; cv=none; b=hlpLF1FDIt6i6d58xfAx8UDbbl7hFNDCpGYwDYdEjSPDL6BiXaEY1FHBttr4/YPgmQ95xY140OmQ7n28ImeADJWdqhCfkR+d/vhe6ZOhuHQpcDupIhbGfpPNRNaB9vIkqjvN6IlygcVuFgmqXvtWXSNt/hEzpKTrZUT1AtZNh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249420; c=relaxed/simple;
	bh=ec1Boe0Z09sA9RCgq46h2z0pwuvhXspYVCvKglVxqvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L65QK8opWmuX5f3/4pnqg1im1pLu0P6B4D+xeQa2p77QrK2Gh+5b/JO/cphdFUKiV/AVUiNDAN6jrc9qkYGf1SSIYUTrrA0rI9mdAh+Iqe5AUH8Rx9BUzwBdrmH7g9cJfVST/8NHh0Ui+j/H54gDnE+X+qh2lsnDkl+9QnhGaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzGAju9R; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776249418; x=1807785418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ec1Boe0Z09sA9RCgq46h2z0pwuvhXspYVCvKglVxqvI=;
  b=SzGAju9RCFKgQ3tZELvyYuX0+pUoqxvvO9Tjf82GbAp20tE9wDKqO69T
   9jgqWRdx4aiBIIuw2htPI0LGIS8fzqS/g1QemqPvkE1c2Q2FyKIe1Z0Z5
   AVx0FKhVyNJj26lpNUQMBGmbzvKw6E5qOdjBae/Wmkuama8wWzmgK/rGg
   TN09gyBKRVMB4Ljx7yK/tTNTOFITbBuDgBFJibnzVP/7se7FEEFNnkOAz
   yVoFrY328OhPbXGft2GHhjZ4OaT81DG3/qdLc36IXOFBhS4HCqI2CzKi5
   m7OsuiU0YUOrWP+fwPaINx8Stkogq9keNBCp4B4QRNA1ke64+RglStcsy
   Q==;
X-CSE-ConnectionGUID: +bE9yWJIRTOPCXuIT9n1cw==
X-CSE-MsgGUID: IqUVF5XnQRm/++1ZHQ3YcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77334820"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77334820"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:36:58 -0700
X-CSE-ConnectionGUID: 2TSAZElDSEO2Uf60wpHf9Q==
X-CSE-MsgGUID: vzhLAkB5QayV6zUVHj4HOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="268382713"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Apr 2026 03:36:57 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCxc5-000000000Ov-0z7b;
	Wed, 15 Apr 2026 10:36:53 +0000
Date: Wed, 15 Apr 2026 18:36:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dudu Lu <phx0fer@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Dudu Lu <phx0fer@gmail.com>
Subject: Re: [PATCH] rose: Fix rose_find_socket() returning without
 sock_hold()
Message-ID: <202604151819.celyrwKo-lkp@intel.com>
References: <20260413090420.79932-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413090420.79932-1-phx0fer@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278744-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ukuu.org.uk:email,demon.co.uk:email,sral.fi:email,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: B1BB2403514
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dudu,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master horms-ipvs/master v7.0 next-20260414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dudu-Lu/rose-Fix-rose_find_socket-returning-without-sock_hold/20260414-194608
base:   net/main
patch link:    https://lore.kernel.org/r/20260413090420.79932-1-phx0fer%40gmail.com
patch subject: [PATCH] rose: Fix rose_find_socket() returning without sock_hold()
config: i386-randconfig-141-20260415 (https://download.01.org/0day-ci/archive/20260415/202604151819.celyrwKo-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9007-gcf3ea02b
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604151819.celyrwKo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604151819.celyrwKo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/rose/af_rose.c:1:9: error: expected identifier or '(' before 'if'
       1 |         if (s)
         |         ^~


vim +1 net/rose/af_rose.c

   > 1		if (s)
     2			sock_hold(s);// SPDX-License-Identifier: GPL-2.0-or-later
     3	/*
     4	 *
     5	 * Copyright (C) Jonathan Naylor G4KLX (g4klx@g4klx.demon.co.uk)
     6	 * Copyright (C) Alan Cox GW4PTS (alan@lxorguk.ukuu.org.uk)
     7	 * Copyright (C) Terry Dawson VK2KTJ (terry@animats.net)
     8	 * Copyright (C) Tomi Manninen OH2BNS (oh2bns@sral.fi)
     9	 */
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

