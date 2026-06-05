Return-Path: <netdev+bounces-295543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oK3PI0IlImpjTAEAu9opvQ
	(envelope-from <netdev+bounces-295543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:24:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B0C644615
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:24:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=bEFGPvCW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295543-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B02A300F7AC
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A2B3BB12D;
	Fri,  5 Jun 2026 01:24:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9B3793D5;
	Fri,  5 Jun 2026 01:24:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622650; cv=none; b=Ujeb8vyJZNjdxC9r1x5k7zCb3TMMAgh3IVVSaRrtZnEfL/OvtZOygxFg9kQlHUdQjMrSOqc0NO+GpV/2vn82vp+0QOhObmcBNrWf80erjtZVuSrJaGv4uOWipqFKvpzLpk4sbiTGXEtI1PYEHpHAnwq/e4PYVJSAPTThnRNel5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622650; c=relaxed/simple;
	bh=wUXquFQuBDYMZICYnLQmQNv1jv/HaB9bdKctPiDDt8E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j+gAcpZnfBTg4VtiSlF128+E4rac7xQQANdUpbnj9IYi3WTsPGDCFGBzLNwYxkUILPu0tE5MiKog+P+RrAuSa8s9C0o30yGqZMRAdqvz0TUbsGjFt4RgHUhYLFCWGeO3hF52+dqQzY6WwFUeIcBQKUreB/F8kJuNwK5gRkBxdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEFGPvCW; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622645; x=1812158645;
  h=date:from:to:cc:subject:message-id;
  bh=wUXquFQuBDYMZICYnLQmQNv1jv/HaB9bdKctPiDDt8E=;
  b=bEFGPvCWsE4spr/eTrpKF3++WVf6ZQqzRd4AA94o+p1WE8cSrawkdNXq
   hqzplPmCxM2NdB6vnpt5dmK3z5leR8l95uhzm8dBclqindhC7qsG3sDFH
   gDSwsDXB+IPCnIxGejx2BuA3RG9BZo1g+BdO8CWr59oQ2amcHurYc6dPX
   q8LnJPTH2lk4LcpHH3uw1o/YOo7uPFpIzdtpzhR8YkcgB6WKDWP/rEcvq
   py/RdbFhB+NWRvmCipmNE5Nh/X1CRZwJwtpdQwYDhYR5LcmGg+T89dF2U
   7SZu0nc5MBsgTnPTvPPgnqTP86D86Udm3jJE6pJ+xi/ded2gdgjNiWfTH
   g==;
X-CSE-ConnectionGUID: UBB03Fs0TZ6biwcorQBLVA==
X-CSE-MsgGUID: qMfYEqY7S5GIcO5DM6xoCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92142078"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92142078"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:24:05 -0700
X-CSE-ConnectionGUID: uF5IaECnRIOofeg8SgIBIg==
X-CSE-MsgGUID: SZZHOVVQTCOmJU6YGz8JJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="240516094"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 18:24:03 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVJI0-00000000FQW-1P2q;
	Fri, 05 Jun 2026 01:24:00 +0000
Date: Fri, 05 Jun 2026 09:23:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
Subject: [mst-vhost:balloon 12/38] ld.lld: error: undefined symbol:
 folio_zero_user
Message-ID: <202606050942.HHhnHpHF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295543-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83B0C644615

Hi Michael,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   b145636d693114d343a0a47a4400f5b31e211fec
commit: c4af912c65bc897b31264a3403f18b0cf52fa10c [12/38] mm: use folio_zero_user for user pages in post_alloc_hook
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20260605/202606050942.HHhnHpHF-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 7917772d7d61384696c61102c08c2ea158e610fa)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606050942.HHhnHpHF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606050942.HHhnHpHF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: folio_zero_user
   >>> referenced by page_alloc.c
   >>>               mm/page_alloc.o:(post_alloc_hook) in archive vmlinux.a
   >>> referenced by page_alloc.c
   >>>               mm/page_alloc.o:(get_page_from_freelist) in archive vmlinux.a

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

