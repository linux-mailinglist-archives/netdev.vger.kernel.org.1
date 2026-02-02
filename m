Return-Path: <netdev+bounces-255821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJP8IT96gGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:19:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3DCAC7F
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52711304FC0B
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E32DE711;
	Mon,  2 Feb 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDw2WQEz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792A2E972B
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026921; cv=none; b=SQyK4wOuBYzUbCrJNcnVsUbNOzY1TlgqzMfTFpV1eOxuLRS+pmoOHMvBXlhTWnqhTkjyJgqmANRmZRCc4Hti95aL2oWb+9UR6lHQzj9c7e7X7Sczh8SNmrXEByiXiuYfnkll+34JhHmgjAZAfhVsgpx6D1Ad6Wpx9Sq3CPNjDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026921; c=relaxed/simple;
	bh=cCgG3dIux3x+xt02C17bJz27PWIwYr7tHK1Irige0qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+WQmA9eKixEBWByksvfMV+pITBSf9uE8fVEOME89HDik5yjDqds0ZuJzRmcdS9DLuBpwRftV2Sq5f8jkDj8N7bUR6a67GFgMnzTUJlWSSv8aDFI0sS/+sM2N21DSpcLFxK6IOikmWR98ctiZKGNlA+XLwkLGGlexrwVvJ4foXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDw2WQEz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770026919; x=1801562919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cCgG3dIux3x+xt02C17bJz27PWIwYr7tHK1Irige0qI=;
  b=YDw2WQEz5+dH62HBMtjsk/gcEsNVkw9HGRv9mR6HETnL+IviVd0DWmbR
   oUM8vZJBb6IzpTP/a0nlV+z5bIPWiG8uv40c3+jbs+q2v3IqW/1FkrnTq
   6k2lVN3PfYkIJrV/cO7n5nFPlZknt1t8M7csj4ToJoK9A8h2AmnXK68U1
   MDy4npID0HVOrYXonNlC6SPi5gPx6RSq9dNmu7qWeI1jxByL6QNbBIkbW
   1Nf8yNN/kvrI+E0bk/QpiFYsACxR5l9u29g/wz9tVOrWR5YWXtJYmQ3R/
   LRFVaNfw7sEaxUq+f9xGUzmBp1ZnKUHrHXUll5pe9G4/+MiIMnbwT0Nfy
   g==;
X-CSE-ConnectionGUID: oHy+olDHQnyMDSGBIZfFzQ==
X-CSE-MsgGUID: /14LeuMQTry0vWhOMeXHcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="82289589"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="82289589"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 02:08:38 -0800
X-CSE-ConnectionGUID: 4A8P+vxkRfuBRuRzEds7GQ==
X-CSE-MsgGUID: M1aAK9y4RLq/kvZE4ISRrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="209483479"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 02 Feb 2026 02:08:34 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmqr9-00000000345-1anf;
	Mon, 02 Feb 2026 10:08:31 +0000
Date: Mon, 2 Feb 2026 11:08:22 +0100
From: kernel test robot <lkp@intel.com>
To: Riana Tauro <riana.tauro@intel.com>, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch,
	airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Riana Tauro <riana.tauro@intel.com>
Subject: Re: [PATCH v5 1/5] drm/ras: Introduce the DRM RAS infrastructure
 over generic netlink
Message-ID: <202602021142.G5vT8UkJ-lkp@intel.com>
References: <20260202064356.286243-8-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202064356.286243-8-riana.tauro@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255821-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,linux.intel.com,intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,kernel.org,redhat.com,google.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEF3DCAC7F
X-Rspamd-Action: no action

Hi Riana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-xe/drm-xe-next]
[also build test WARNING on drm-misc/drm-misc-next drm/drm-next linus/master v6.16-rc1 next-20260130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Riana-Tauro/drm-ras-Introduce-the-DRM-RAS-infrastructure-over-generic-netlink/20260202-141553
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20260202064356.286243-8-riana.tauro%40intel.com
patch subject: [PATCH v5 1/5] drm/ras: Introduce the DRM RAS infrastructure over generic netlink
reproduce: (https://download.01.org/0day-ci/archive/20260202/202602021142.G5vT8UkJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602021142.G5vT8UkJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ERROR: Cannot find file ./include/linux/hdmi.h
   ERROR: Cannot find file ./include/linux/hdmi.h
   WARNING: No kernel-doc for file ./include/linux/hdmi.h
   WARNING: ./drivers/gpu/drm/scheduler/sched_main.c:367 function parameter 'result' not described in 'drm_sched_job_done'
   Documentation/gpu/drm-ras:39: ./drivers/gpu/drm/drm_ras.c:40: ERROR: Unexpected indentation. [docutils]
>> Documentation/gpu/drm-ras:39: ./drivers/gpu/drm/drm_ras.c:41: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   Documentation/gpu/drm-ras:39: ./drivers/gpu/drm/drm_ras.c:46: ERROR: Unexpected indentation. [docutils]
   Documentation/gpu/drm-ras:39: ./drivers/gpu/drm/drm_ras.c:59: ERROR: Unexpected indentation. [docutils]
   Documentation/gpu/drm-ras:39: ./drivers/gpu/drm/drm_ras.c:60: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   Documentation/gpu/drm-uapi:607: ./drivers/gpu/drm/drm_ioctl.c:923: WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:69.
   Declaration is '.. c:function:: bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'. [duplicate_declaration.c]
--
   ERROR: Cannot find file ./include/linux/mutex.h
   ERROR: Cannot find file ./include/linux/mutex.h
   WARNING: No kernel-doc for file ./include/linux/mutex.h
   ERROR: Cannot find file ./include/linux/fwctl.h
   WARNING: No kernel-doc for file ./include/linux/fwctl.h
>> Documentation/gpu/drm-ras.rst:59: WARNING: undefined label: 'documentation/netlink/specs/drm_ras.yaml' [ref.ref]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

