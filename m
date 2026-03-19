Return-Path: <netdev+bounces-269623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID4UC4tNvGkXwwIAu9opvQ
	(envelope-from <netdev+bounces-269623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:24:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C51182D1A15
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0AF930936F0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFBE36826B;
	Thu, 19 Mar 2026 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2jVmdwv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D21346A11;
	Thu, 19 Mar 2026 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948278; cv=none; b=ar+wDsC4V3Dq7oczUzvVLs6mWm/cIAFX7q0AeUlBtpO9ctKNaHk1TTpuU3kdPzn8G3n0pRlwbE820Ddnaeu6OIK7wkN/eXdH1bdGVl+hVUfZ8PXHOG1dO8AJctUcNAkbMwGcy7u02gqFXctw3/lsmZkrlpYFOoVmSdkAjjgLMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948278; c=relaxed/simple;
	bh=u1xu7qpyWsYDX0L3tUDoGRj59kCYadpSZzq6Eu5V1lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZV95NBzd69gAHM6pd64cZuieluN/PRzHacYIUnssOpQLPRUpgyMAndS6UmWWhGeMCe2K7s3KiFIfav7css48S67jIHPgi+yPpPfULrjreWtxANeYZLHY5MbJVsarZs6VQW6AmkOtZKcJqmGrMQZm+B0uzT+4OOiyLllguedaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2jVmdwv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773948275; x=1805484275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1xu7qpyWsYDX0L3tUDoGRj59kCYadpSZzq6Eu5V1lk=;
  b=I2jVmdwvLoGorPW/AFeEXEFGZGnrkqvFsV5jxwW2vlkc9rMmlAqwNaQS
   ej3a8jVH/WF9RyCDaWoBs0cqcQegnDK0LU5c2uQmAV7nkduOc+58DYaay
   Xy29yB3vtcZTkNZ2262AHaE8Y9/z2s6Gs6luiraigZxDfqKbdYsX4NJqY
   PCwnIuPk80vOBbHr/7g5iOzSG6J1H3nBZNhGxfLD52zgRdVhAtohg07M0
   5PE52COGQZ9d7UGkCBKsKAug4R12n+XOYB/YFVzv9ZsDx5znnQX/b0OA1
   VeoUCQNQk1jqRQL+eEVy/rjqK3W0XHEw6Wo64MZGjTrFmBi5cfDuc+JJc
   A==;
X-CSE-ConnectionGUID: cT5pX5AGRaiDm/+DDN5ebA==
X-CSE-MsgGUID: LYgyL2HGQT65zqcQZrD+cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75151338"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="75151338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 12:24:34 -0700
X-CSE-ConnectionGUID: flfI1DlhQdarwslc5bpUfQ==
X-CSE-MsgGUID: gOtQL+EaQuC1IqfmCcQswQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="220456254"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 19 Mar 2026 12:24:27 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3Iym-000000001ZD-12mM;
	Thu, 19 Mar 2026 19:24:24 +0000
Date: Fri, 20 Mar 2026 03:22:12 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, sdf@fomichev.me, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211: use
 __rtnl_unlock in nl80211_pre_doit
Message-ID: <202603200304.JZwA4SBN-lkp@intel.com>
References: <20260318150305.123900-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318150305.123900-3-sdf@fomichev.me>
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
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269623-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.943];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: C51182D1A15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-add-address-list-snapshot-and-reconciliation-infrastructure/20260319-122535
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260318150305.123900-3-sdf%40fomichev.me
patch subject: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260320/202603200304.JZwA4SBN-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603200304.JZwA4SBN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603200304.JZwA4SBN-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__rtnl_unlock" [net/wireless/cfg80211.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

