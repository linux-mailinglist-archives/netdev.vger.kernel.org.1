Return-Path: <netdev+bounces-171106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E2A4B83B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CEB188C35B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE01E5B76;
	Mon,  3 Mar 2025 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+Yt282H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6240B12B93;
	Mon,  3 Mar 2025 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740986332; cv=none; b=r/PWTnJKFg5sLpWJpiKAGKEhWZsxcAa05So7/OvrRZFWTVMPY9S+QwJmneMn2W4/1HTOiZrzplitiMzzfkqvnAVKtrq8yejurm8SsNMSou9856KXeVbkokCBzY+zn8zKSVAsEc825c0eX5yRHUo/Rr/BqlpmLZ6lKHzO0GlALTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740986332; c=relaxed/simple;
	bh=nxHbGfjDB0gEZ2Ngw7+tp2kHbTqIW5Z158k3FWhtCxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI33457buNJNCujkDL9sN9pF/cPM4oXRSMNTHLFTqPbdqcRqKp5BD15F3+DZwwtm01KJh2QRe+qYOK5Dscj+AbxFyYGv+PNuuICZY9RHRBPxgzPiWRcwd2PV7DYbQyFh9Rs1IEFrij+5qlBeyA3acrCiy5NJL/f8oH/c+qcPnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+Yt282H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740986332; x=1772522332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nxHbGfjDB0gEZ2Ngw7+tp2kHbTqIW5Z158k3FWhtCxI=;
  b=Y+Yt282HgRasC0nBdWvAoHffyX37x2nJ+RQXYjtOkx976iz/taMK1Ndo
   Pmqkmb0tQyEO6RB7s0kFkz8v1gHR4jscxkGVWKneZSVkfPXZx5OrcT/Ds
   7JcEQIj5CYmGi3N3PzYtPukHQykKg6/25RYG3Ex9baA39KEeI61j7rP0d
   ZehsAFW+WnzBEK5DeJCn2jJJ02F2BlHlpOjtQVq+Bo6rKBROQL9endnLU
   4OSIfnaJJMbL+H5lWy6Iu2wOYzaoU3gEIsqM4sPSGPGKr5PFz5kEHU5Ey
   +nCr5Gma5B902BsgUVJkynbu1ttzBgO1G5p4ZSBctp0y5whJRfHvihj6H
   w==;
X-CSE-ConnectionGUID: rQ+z3eFLTCSDrZEmyo070Q==
X-CSE-MsgGUID: lVqHqLXeQDuuK2Add6olpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41701288"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41701288"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:18:51 -0800
X-CSE-ConnectionGUID: x6YAPINcRtGFTkXKbfgDTQ==
X-CSE-MsgGUID: a8W1VWB0Ro+pmlo0JWsHXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="123073693"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:18:48 -0800
Date: Mon, 3 Mar 2025 08:15:00 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Brett Creeley <brett.creeley@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Qasim Ijaz <qasdev00@gmail.com>,
	Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH net-next] ionic: Simplify maximum determination in
 ionic_adminq_napi()
Message-ID: <Z8VW9IXnN+M8KVtZ@mev-dev.igk.intel.com>
References: <cbbc2dbd-2028-4623-8cb3-9d01be341daa@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbbc2dbd-2028-4623-8cb3-9d01be341daa@web.de>

On Sat, Mar 01, 2025 at 11:12:31AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 1 Mar 2025 11:01:28 +0100
> 
> Reduce nested max() calls by a single max3() call in this
> function implementation.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7707a9e53c43..85c4b02bd054 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -1242,7 +1242,7 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
>  	if (lif->hwstamp_txq)
>  		tx_work = ionic_tx_cq_service(&lif->hwstamp_txq->cq, budget, !!budget);
> 
> -	work_done = max(max(n_work, a_work), max(rx_work, tx_work));
> +	work_done = max3(n_work, a_work, max(rx_work, tx_work));
>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
>  		flags |= IONIC_INTR_CRED_UNMASK;
>  		intr->rearm_count++;

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> --
> 2.48.1

