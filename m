Return-Path: <netdev+bounces-211221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13361B17362
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815FA1C24469
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3EE15573F;
	Thu, 31 Jul 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jm/qyAG5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DB2905
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973315; cv=none; b=pWRbcf1bhgGBa7mf4kmEBBCmybXYu2fLmIJHZp/rEZaIhhiwv2ORWcvHmk0zNdWMtR2pynJK0zNwP6kV4RxGRlE85w2w5rARGUnbPye0TMbwzfTzeD2GwN6BSc5vElpWi80GDnhXWKj1knea32fTq4MSMWacwVTlEwX6jYw5c0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973315; c=relaxed/simple;
	bh=Ad47tlggEaV4abdj1k11+InzNPst1Kd5QZN68yN2zYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uScxRfx/4IMLBPxH+vMVM2JxHHmgxLGIKjpeTQXEvLcn8FoC2HDoskOTsxqMuBwdq8k8q0luDiDBCuVsAal0Uw1Cw/TGqQZ6pstwrhrumXWGVNuKVM4UVtNv5QR+SRqSnHZO5tP/eAPNWRouwNoogHEWzATUrnhGy6O1kyJX4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jm/qyAG5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973314; x=1785509314;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Ad47tlggEaV4abdj1k11+InzNPst1Kd5QZN68yN2zYI=;
  b=Jm/qyAG5yDZ/4C2GHNlsRaoqBmqQDxDJGOtgewnWv+OEBKYYBuhba0mR
   blvbf15ji/XYpGuj6JRJRmAeszm2wMY47IxRN+avomoZ+q94nCNqB4kmM
   lIVGrvrO689n7euf2jjxuw4iD/jDAn+UIbD78zLeFIcDrV2Wq/+nLE+cL
   11cvQP+AspfUpR07fOQ5fMN7nUzHGOThFO2kPEBxUNqA75ZdwoBR8cbiY
   riSSFktx1+Vq7GwxGBqcP7J9xZpBg6G9aTVvS+XN0eDUl1yAbuff/n397
   hNFYCPV6cTlryGpmrF7nICT1qckOxG1HXrNJwEDILWJVSTeoMXZMYwGN1
   w==;
X-CSE-ConnectionGUID: I3tONP9sSGenmvV+pXAkKg==
X-CSE-MsgGUID: OCjWYJ61R1CoKbo+L4kTFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="66867289"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="66867289"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:48:33 -0700
X-CSE-ConnectionGUID: eqI7goXYQzqpdvqnSOlOgA==
X-CSE-MsgGUID: GK/qOb0/RwSdUvy7tvubCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="162553560"
Received: from hlagrand-mobl1.ger.corp.intel.com (HELO [10.245.102.40]) ([10.245.102.40])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:48:32 -0700
Message-ID: <62e55634-d36d-49e5-9d2f-d5cb00a0f099@linux.intel.com>
Date: Thu, 31 Jul 2025 16:48:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH: i40e Improve trusted VF MAC addresses logging when limit
 is reached
To: Dave Hill <davidchill@hotmail.com>, netdev@vger.kernel.org
References: <CH3P221MB1462BC768A36BFE9E37E2CB6D327A@CH3P221MB1462.NAMP221.PROD.OUTLOOK.COM>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <CH3P221MB1462BC768A36BFE9E37E2CB6D327A@CH3P221MB1462.NAMP221.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey David,

On 2025-07-31 4:06 PM, Dave Hill wrote:
> From: David Hill<dhill@redhat.com>

s/David Hill<dhill@redhat.com>/David Hill <dhill@redhat.com>/g

The patch formatting is really mangled and not possible to be applied 
with standard tooling.

It is advised to create patches using `git format-patch` and use `git 
send-email` tool for patch submissions, as it ensures proper formatting.

It is also advised to add the maintainers for a given piece of code to 
To: or Cc:, you can find them using ./scripts/get_maintainer.pl

Please take a look at 
https://docs.kernel.org/process/submitting-patches.html on information 
how to submit patches properly.

> When a VF reaches the limit introduced in this commit [1], the host 
> reports an error in the syslog but doesn't mention which VF reached its 
> limit and what the limit is actually is which makes troubleshooting of 
> networking issue a bit tedious.   This commit simply improves this error 
> reporting by adding which VF number has reached a limit and what that 
> limit is.
> 
> Signed-off-by: David Hill<dhill@redhat.com>
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/ 
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> 
> index 9b8efdeafbcf..dc0e7a80d83a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -2953,7 +2953,8 @@ static inline int i40e_check_vf_permission(struct 
> i40e_vf *vf,
> I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
> hw->num_ports)) {
>                          dev_err(&pf->pdev->dev,
> -                               "Cannot add more MAC addresses, trusted 
> VF exhausted it's resources\n");
> +                               "Cannot add more MAC addresses, trusted 
> VF %d uses %d out of %d MAC addresses\n", vf->vf_id, 
> i40e_count_filters(vsi) +
> +          mac2add_cnt, I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf- 
>  >num_alloc_vfs,num_ports)));
>                          return -EPERM;
>                  }
>          }
> 
> [1] commit cfb1d572c986a39fd288f48a6305d81e6f8d04a3
> Author: Karen Sornek <karen.sornek@intel.com>
> Date:   Thu Jun 17 09:19:26 2021 +0200

The above should be just below your signoff tag as follows:

Signed-off-by: David Hill <dhill@redhat.com>
---
[1] commit cfb1d572c986a39fd288f48a6305d81e6f8d04a3
Author: Karen Sornek <karen.sornek@intel.com>
Date:   Thu Jun 17 09:19:26 2021 +0200
---

Best regards,
Dawid

