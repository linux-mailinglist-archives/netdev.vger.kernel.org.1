Return-Path: <netdev+bounces-185025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E02A983E4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3321A16711B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD40276025;
	Wed, 23 Apr 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iu8yOTR3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4EB275853
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397448; cv=none; b=iUxLJOf68kLWVOxMTvQbiaoXghHMslroJzTE57hMJg6FHwp0662lCI9LzwkTTekKzXHMO6oAZyunPSQzlyA9BSpjH8AbZC0iJWm3Ry6I3Fq+EOIbrTHyjIJD2xJloGErERFEx+/aTVL5HCZYIjVIZsZp9Flpar/w8iJiVvVDMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397448; c=relaxed/simple;
	bh=BGyAHAxhHVeDJkeT2pkcVULAmJOIlp3mgGTn2XDlYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o90PfS/O4QTAdHfgv55XULw5f2luHctnQNyvk09+0+FVpf7MchzySrUP9abI0VWJJ0IfAiC8saNHCeO5gQyOP33aRJXv7xLurZT7qx29kYkQG93FEVz/FvhWoH+2Bqt80Qgd4JiPt8gtvmrNklxZjGNWcvDXmWZpvzOzm8JAh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iu8yOTR3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745397446; x=1776933446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BGyAHAxhHVeDJkeT2pkcVULAmJOIlp3mgGTn2XDlYbQ=;
  b=Iu8yOTR3jPDyJo9Pn3LaUHQqvdTdnvGumFXwhAuYjtcPzRSoEuhzadvh
   LAYGSXqOLeQcUKAIokQ0eAQcJC4yszkkmvoZ+yKeXKWsr4javDUKkGbHV
   IMICco5GNSvw0TpbJToAI5vbTIUcfpIeXXo7ZQ6p8eIZZrw0xOgOPB90K
   1VQMVqRe+way2e7ArY/aN9M28pNyrNmSuClgWwSEZLsW7xYCFAdfI0Gk4
   lLtRDzT0ZQcnvtB+BjOscG8MgpKUvdlfOU4+agubvWhysm6M8VPuyOH7/
   E9Lh1YyCoRVuxYUhEtsTmIHWOTCl36qnirgGmX0m+An6luFwU4rG3OlsY
   g==;
X-CSE-ConnectionGUID: nNzpeWn7QWevpc6E+36N8Q==
X-CSE-MsgGUID: XQOrwbYATFGwdFbR+86j7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46101051"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46101051"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 01:37:25 -0700
X-CSE-ConnectionGUID: 8GYCP56dRcu+bU53gI5yBw==
X-CSE-MsgGUID: kA48dpB2RbKSlaxWCxd52w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132242739"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 01:37:22 -0700
Date: Wed, 23 Apr 2025 10:37:05 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	marcin.szycik@intel.com
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <aAimsamTlQOq3/aD@mev-dev.igk.intel.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
 <20250418003259.48017-3-kuniyu@amazon.com>
 <20250422194757.67ba67d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422194757.67ba67d6@kernel.org>

On Tue, Apr 22, 2025 at 07:47:57PM -0700, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 17:32:33 -0700 Kuniyuki Iwashima wrote:
> >  drivers/net/pfcp.c | 23 +++++++----------------
> 
> Wojciech, Michał, does anyone use this driver?
> It seems that it hooks dev_get_tstats64 as ndo_get_stats64 
> but it never allocates tstats, so any ifconfig / ip link
> run after the device is create immediately crashes the kernel.
> I don't see any tstats in this driver history or UDP tunnel
> code so I'm moderately confused as how this worked / when
> it broke.
> 
> If I'm not missing anything and indeed this driver was always
> broken we should just delete it ?

Uh, I remember that we used it to add tc filter. Maybe we can fix it?
Adding Marcin, as he was working on it.

Thanks

