Return-Path: <netdev+bounces-271485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EdiBaa8w2kRtwQAu9opvQ
	(envelope-from <netdev+bounces-271485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:44:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB21323394
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49DF23006D54
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04953BA24F;
	Wed, 25 Mar 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6qob/b4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1933BA253;
	Wed, 25 Mar 2026 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435046; cv=none; b=rZiLb65GHKgTAZw475JApcSmVWurBhwp/U3KNLznQ3Gj/QPbJmE+vtDCQI25ksfdpl1EksiB86Sbe0w0TUCVyh3LAY4fzqbYge612vtZvkR4wqhOyvwUVrkEDDkw5C21cq49DJAmRaI+inuu0SCph26lwXkADByY58ihUEWgF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435046; c=relaxed/simple;
	bh=mD58wd6LOdvWt3tn2SATLgk5C/QF1f+Svr+0j17p9/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeTc7VY5+daFiLcgo5Xbw1eZ9Ut1xg5SLVvXsPHadXnAztHgBJcrKsEtZ4i7zN6srdpAUYlK9ePEiJJXZ1QaOABKhBN2MBYVqX1h0QR7Kx4W0JYk8wEhQx0m8DhYKfPyfZlec/v1YQIPHFw0KTVNxRzB0+GPc5kVXnKKmDAVPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6qob/b4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774435045; x=1805971045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mD58wd6LOdvWt3tn2SATLgk5C/QF1f+Svr+0j17p9/U=;
  b=V6qob/b4nRO9YZ/bFse2XU7+4UAX7aHg/cWQEYrXcCKPypeuEQ7w5A3g
   92TyMYw7SYB+swv+D0L9t11SffDrcBBkdutYM2rvan6ZMO4zEzRj6jpQH
   1FUKS26O9NvRbW+P2SXyzQIvysXbTtmJKmzLIXAXNYgPOdpDGE61S08h9
   oUKFC25UMKnpRym7nqPYh6pzB9nyvVRyYESCb+KR4ndbkGLQC9PuCwx13
   nv4Uli/zB+MmpthI+kub71KsTcXm+/d6ft4uZm3xkyAJJRyz3ClGLlP8z
   InWzST58eQM0nk8eHYhNK4FdbJyNrJDnbTNimKg88vGNhoQ/MryQT0zrn
   A==;
X-CSE-ConnectionGUID: ATQu0ZIYT4OI+DvqvRmCgw==
X-CSE-MsgGUID: CgMZ7OjZQwaXjIb9xJHNMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86945174"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="86945174"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 03:37:24 -0700
X-CSE-ConnectionGUID: hOlQ8iL8RXG/K9eXzyZ+TQ==
X-CSE-MsgGUID: 6fP92E8fRiqpuGYZV7YB/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="219790440"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2026 03:37:20 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5Lbx-000000006dx-2Abj;
	Wed, 25 Mar 2026 10:37:17 +0000
Date: Wed, 25 Mar 2026 18:36:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v9 03/10] bng_en: add ethtool link settings,
 get_link, and nway_reset
Message-ID: <202603251832.dBi1052h-lkp@intel.com>
References: <20260324200740.346029-4-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324200740.346029-4-bhargava.marreddy@broadcom.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271485-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 2EB21323394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bhargava,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-add-per-PF-workqueue-timer-and-slow-path-task/20260325-121249
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260324200740.346029-4-bhargava.marreddy%40broadcom.com
patch subject: [PATCH net-next v9 03/10] bng_en: add ethtool link settings, get_link, and nway_reset
config: i386-randconfig-141-20260325 (https://download.01.org/0day-ci/archive/20260325/202603251832.dBi1052h-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603251832.dBi1052h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251832.dBi1052h-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnge/bnge_link.c: In function 'bnge_set_link_ksettings':
>> drivers/net/ethernet/broadcom/bnge/bnge_link.c:1220:32: warning: variable 'link_info' set but not used [-Wunused-but-set-variable]
    1220 |         struct bnge_link_info *link_info;
         |                                ^~~~~~~~~


vim +/link_info +1220 drivers/net/ethernet/broadcom/bnge/bnge_link.c

  1212	
  1213	int bnge_set_link_ksettings(struct net_device *dev,
  1214				    const struct ethtool_link_ksettings *lk_ksettings)
  1215	{
  1216		const struct ethtool_link_settings *base = &lk_ksettings->base;
  1217		struct bnge_ethtool_link_info old_elink_info;
  1218		struct bnge_ethtool_link_info *elink_info;
  1219		struct bnge_net *bn = netdev_priv(dev);
> 1220		struct bnge_link_info *link_info;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

