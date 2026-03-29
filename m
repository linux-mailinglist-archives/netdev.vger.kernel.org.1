Return-Path: <netdev+bounces-272851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KynBC3mlyGkeoQUAu9opvQ
	(envelope-from <netdev+bounces-272851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 06:07:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09435099A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 06:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B45130065E6
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 04:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE86259CA9;
	Sun, 29 Mar 2026 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vxyw9CTK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E62367B5
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774757238; cv=none; b=b5QQjaVruZQn8gGxJfTTSk867CoEgq+MC+a9JaZJJ3ph4eCa3HwUsGr9TX/fOzvayObdUzzCIoGPTaHuZLMZbI/GnniJZD70ETWvApX4DnicuYP6GqscpYU37BEOFW4Nh2bEX+mNacr0bpeADMg4CSy0UKKKppC5GEDMs4uxGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774757238; c=relaxed/simple;
	bh=gWeKNb1ClJWFYIkENDXGlY3FE8uiAbU0wSsHJ5klDlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk6brC65MWQZVwUisrEd7jaep1n46icpYWD1jQrTrvfxwa3JLptvdYX38eSOaA1BMdl9Cw4X639bKKW+jIjmM2aAWMsaMktnzW82iffobEXFS3xD0daLrIG4O9WwReS776GGVKBBqtn+o0NbytQLAPgMPY1zf/DDvXtBm0m13xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vxyw9CTK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774757236; x=1806293236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWeKNb1ClJWFYIkENDXGlY3FE8uiAbU0wSsHJ5klDlo=;
  b=Vxyw9CTKc6eSXFRa75rpEwmSJz4+6QhrmGrN3tAEi2rCXwxDAne5cn4n
   fx8GvxEG+8P1hWGP9u1z2HirGIQTHk6EODiTcOMCTG1jb7wlAxrnIR0GO
   asbcY+ELGxw7VX1VKzrIxZ5A0fsYlhlKmF5YC2Z/oBByJb+CZ2q6t0/ob
   nKbIR7FbDBcoojrcO6Dl32iQIwSQtX6J5jsMRQjd/TA4QrW/IfJ1wsrPV
   pTI5D/L68CZdhGbSwpc5KX91ON+/m0EUOzaZvUqqgAxBBj0jkZk030lUi
   00BF1u9LInHTlCXgWNdIbTXYBcF0Qe+pgYmFOqjP+1yLmuPmMCYX+1GC0
   Q==;
X-CSE-ConnectionGUID: xO+4PkQBRNaUDJEVVBEHrA==
X-CSE-MsgGUID: dxTnaEG3RTCAV13tovsWMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75896814"
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="75896814"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 21:07:15 -0700
X-CSE-ConnectionGUID: umSWqpfZQ5q0kWaT3+XgLg==
X-CSE-MsgGUID: kVj6EjhKT2OqCKxbc+mZ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="221306879"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 28 Mar 2026 21:07:12 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6hQc-000000007pF-0XGX;
	Sun, 29 Mar 2026 04:07:10 +0000
Date: Sun, 29 Mar 2026 06:06:41 +0200
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
Message-ID: <202603290603.7d9NDw4e-lkp@intel.com>
References: <20260327213441.3781433-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327213441.3781433-1-kuniyu@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272851-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,lunn.ch];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7D09435099A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tun-Ignore-tun-in-netdev_lock_pos/20260328-220059
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260327213441.3781433-1-kuniyu%40google.com
patch subject: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260329/202603290603.7d9NDw4e-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603290603.7d9NDw4e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603290603.7d9NDw4e-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-gnu-ld: net/core/dev.o: in function `netdev_lock_pos':
   net/core/dev.c:540:(.text+0x86a6): undefined reference to `tun_link_ops'
>> s390x-linux-gnu-ld: net/core/dev.c:540:(.text+0x2b5ac): undefined reference to `tun_link_ops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

