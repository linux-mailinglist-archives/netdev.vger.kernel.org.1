Return-Path: <netdev+bounces-238515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677EC5A49A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 294024E020C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAEF30DD18;
	Thu, 13 Nov 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei+dlmR2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9C326934;
	Thu, 13 Nov 2025 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763071989; cv=none; b=UWG370N4Z/YJ7B5pVqjKsAijdZ18lPOGsXI+ohAg19ZLfDlvnwzQIrBpjnrBQ+CWIJaFefZonOj0Lvzk8cQ/itNtyxMF0omHurgoWvU3RBGYpsVbky/APzzRfTb8MgZgezw0PucPdRQt/ZOrVDRvwNfb1nj0PYLPknYaR5erlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763071989; c=relaxed/simple;
	bh=PdMKW2N66Gj4RWzITvDRQESWqX2x6/CDPoaj0OUPspw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGbJO6W/7/sMqSpxaxMPcvzTfp56lkO2JSfz015QJXskSAX17FjjPcLvT2o49fAeGf3RXSUQqv6HivImg2GcPCV3DWxLPDksy7P5IdLwCF98jxYq/pqFv22O9OWV7ERtiEoDFpPt+BCdZxUbtNEPUV8c6cWRJNWT4Al0Tz804Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei+dlmR2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763071978; x=1794607978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PdMKW2N66Gj4RWzITvDRQESWqX2x6/CDPoaj0OUPspw=;
  b=Ei+dlmR2OUQC0EUnSGtXJHIbWjmGK+/SUNGLB+E4IJCp/N7sBqXdTapI
   XfovKxnVd4tSU6bf6IaUBAeFbU4ZWo+wSQf8rowl9/ZSQiCQ/TidaZJWT
   aYiNdzUyRPMhhsEsZRekUsbbLlJPsclUDeZPnQB3aEMxRpCF4tEnghDA/
   zKa4zez0CWqe0ptiaGIx++Og63b1QmYcloI7VbxmdrMMux9PwT8+gppRr
   moT/Ah5RR+I/oeWx4jN/7om/2Ay3/2pT/lV7DXFa3cn9z24M6Wg1ZuYBl
   4wE854PeGHFwyg1oeHGeGjCKp2I3c+D75k0pKDaBqXK11vB54F5EvPHds
   Q==;
X-CSE-ConnectionGUID: 65iW9F3VSfSDmFDoxZL4Dw==
X-CSE-MsgGUID: UUbnaxWCT8KMJ/K3qmc0BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65195917"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65195917"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:12:54 -0800
X-CSE-ConnectionGUID: HfVwSL2kTOO3KRO3RHKj3Q==
X-CSE-MsgGUID: AkywnmBFSoeSKtBB20fbAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="193715670"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:12:51 -0800
Date: Fri, 14 Nov 2025 00:12:48 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ref_tracker: use %p instead of %px in debugfs
 dentry name
Message-ID: <aRZX4JgN9nOEjIPg@intel.com>
References: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 08, 2025 at 07:45:23AM -0400, Jeff Layton wrote:
> As Kees points out, this is a kernel address leak, and debugging is
> not a sufficiently good reason to expose the real kernel address.
> 
> Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debugfs for a ref_tracker_dir")
> Reported-by: Kees Cook <kees@kernel.org>
> Closes: https://lore.kernel.org/netdev/202507301603.62E553F93@keescook/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Resending since I didn't get a response from Andrew. This time I've
> included netdev in the mailing list in case Jakub wants to pick this up
> instead.
> ---
>  lib/ref_tracker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
> index a9e6ffcff04b1da162a5a6add6bff075c2c9405e..cce12287708ea43e9eda9fe42f82a80423cea4e3 100644
> --- a/lib/ref_tracker.c
> +++ b/lib/ref_tracker.c
> @@ -434,7 +434,7 @@ void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
>  	if (dentry && !xa_is_err(dentry))
>  		return;
>  
> -	ret = snprintf(name, sizeof(name), "%s@%px", dir->class, dir);
> +	ret = snprintf(name, sizeof(name), "%s@%p", dir->class, dir);

This now results in attempts to register the same nonsense looking
debugfs file multiple times, which leads to errors in dmesg:
"debugfs: 'netdev@(____ptrval____)' already exists in 'ref_tracker'"

And we end up with a single file instead the one per network
interface (or whatever it was trying to achieve here):
 # tree /sys/kernel/debug/ref_tracker/
 /sys/kernel/debug/ref_tracker/
 └── netdev@(____ptrval____)

>  	name[sizeof(name) - 1] = '\0';
>  
>  	if (ret < sizeof(name)) {
> 
> ---
> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
> change-id: 20250731-reftrack-dbgfs-f99ad92068bc
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Ville Syrjälä
Intel

