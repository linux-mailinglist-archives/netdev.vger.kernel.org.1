Return-Path: <netdev+bounces-264968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJvACyVqq2nNcwEAu9opvQ
	(envelope-from <netdev+bounces-264968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:58:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2108E228DE8
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF9A303205E
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD814389113;
	Fri,  6 Mar 2026 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEqnHIOx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114B371CFC
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841505; cv=none; b=mvtdJouyLMxtsZMKxuRabJNkELClwexFvOtvItwDLSNuZvXAIGzZyCKObnCrBFSB325/Lkcf5qZuQ6ob6XMy1/bohCpYoUhsPaZnkDqDtRjZ6lwgRS3QGJeFOuk+MohWnD2DkqQAWbabTDYdCws+wgrr4AsEQuUqwTquka8qAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841505; c=relaxed/simple;
	bh=pzoLFbE2KvvNoQN+KoB+b2Qa2qu25BrILCK0zg8vTHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv7I+ZHFDfRyLtZMhYsll+VN1SbCP3lvuROsp8NzxdI+MvqDI2H+sb+6p7Io0G99VUaWNoF5ksaYfQuie7Reh2gAzhRw8BYa2iu6zGJvl34+8OHQBv2Ans3CRxqIl6z3iF0ESso9B69rB6dXKFx5CXuKUX/v3ZFvGI8k0Cjon3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEqnHIOx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772841503; x=1804377503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pzoLFbE2KvvNoQN+KoB+b2Qa2qu25BrILCK0zg8vTHQ=;
  b=iEqnHIOxOjDjF+o7cWTI/te8f7RK1qGlQaB0Gh6kJpgJRValzypR1aHl
   nl1MPylWsv+a1/vpk5IUIcQSk+TaZ9KxMI+n7dlJ4owb4tK8F93RQgm5N
   bLFZh6CqJ5qmRK9sakjkFGlkuGdbX0urJilXnza9DRGWk/77cBWBUnQle
   5f4XP3+nYfIrTuHuMXwzsnsZ8EWx3PonI9J4C+N2qvaojKvuiASWVGpKx
   1Bx9fyzx1VeJKs4tlKLD6TNWf0UbkPRf/5j0QrGz2yWEsPrjhuIsHyNlY
   HHzAEWrmpMOFuE414PmP/LgDCsnXf4xUmMm8sm8JgBtKuuv0NuCdwuttk
   g==;
X-CSE-ConnectionGUID: JU9d7v9gSi60OAhp8BXXhQ==
X-CSE-MsgGUID: xaQZAizgT6eMop2oqEf1fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="99426417"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="99426417"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 15:58:17 -0800
X-CSE-ConnectionGUID: 6IIL0baaQbuo3/ANGq02zw==
X-CSE-MsgGUID: t2Md9z0bTvSJFylF1Ncc8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="257075411"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Mar 2026 15:58:14 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyf3b-000000001Ub-2P36;
	Fri, 06 Mar 2026 23:58:11 +0000
Date: Sat, 7 Mar 2026 07:57:28 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] net/sched: do not reset queues in graft
 operations
Message-ID: <202603070725.rEAZBlAv-lkp@intel.com>
References: <20260306113402.435055-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306113402.435055-1-edumazet@google.com>
X-Rspamd-Queue-Id: 2108E228DE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264968-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-sched-do-not-reset-queues-in-graft-operations/20260306-205258
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260306113402.435055-1-edumazet%40google.com
patch subject: [PATCH net-next] net/sched: do not reset queues in graft operations
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20260307/202603070725.rEAZBlAv-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070725.rEAZBlAv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070725.rEAZBlAv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/sched/sch_generic.c:1377 function parameter 'reset_needed' not described in 'dev_deactivate_many'
>> Warning: net/sched/sch_generic.c:1377 function parameter 'reset_needed' not described in 'dev_deactivate_many'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

