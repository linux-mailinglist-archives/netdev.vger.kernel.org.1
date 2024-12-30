Return-Path: <netdev+bounces-154497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7969FE392
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685211881B3E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CD1A0718;
	Mon, 30 Dec 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4uEt6y/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4A78F34;
	Mon, 30 Dec 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735545818; cv=none; b=f5NcWgwFHoM9Q/g0QCuXADeKyvopHJoph0lAQEZABZFPIa5RVIDWMuG1hK1jqABMTU76LbsbJvcslUUKz4SY1zj2h1U90s3TiGo/up33lyxlZPHTPJaA1Fu2KFpa14g0dtuvFyewHaE4wqv6DFjOOotI84C0pxik4rNjlkJ25/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735545818; c=relaxed/simple;
	bh=oC6Xyw3boyzC6P52W/kO2gDxa4mcHXspi+S2APXmqh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAgycNfxI2sgZjrpIlvUUEMV45998PUX0DibUyQnqunOVsIK+Sqg/K0lk+B9NlAoCLPJ4DgV+huODClzpr2Fzovu2bYDlFt63sb0GNEwHvFCa/f+wtbDQLFIlGUgMKK38InYEDdRJxgM2RUVYzM8BL6nxpTYhzYH0+D0rpLm1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4uEt6y/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735545817; x=1767081817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oC6Xyw3boyzC6P52W/kO2gDxa4mcHXspi+S2APXmqh8=;
  b=D4uEt6y/CYV//nRaZALioqALprNfRRALh9pdAWd1/yxsNdLNDzkJFTQ8
   n4pzi4r562B9/pEs8/XiySJ9AzDEnd0ugQaT7uMSYsvzkPowghmPuumbO
   A5XQoD6340IwmPoxaSzva6lH/UzdVs5AFMai6NMUfzeLAmheVGhDtAKIM
   PVeQHAT3G6df0/MddndLejMtUUK5UptsG/WDYXym0TECGRJO1FhrN2n9D
   4u2pWCogKSz24CqMIRJePo+D3e66AVxUAQRz1HkBdUzwqejg5VnAKB065
   ZpX8jOG3uRgFhGynSc2kqt7rdZLyndexN+BabCjGgxtWYugZ18nlVUhxs
   g==;
X-CSE-ConnectionGUID: Jx3zSUoeS1+Jpz8oxAYaOQ==
X-CSE-MsgGUID: BRdsFq4KQla+WJoUXZPn1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46828489"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46828489"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 00:03:36 -0800
X-CSE-ConnectionGUID: 10Q2LOVmQQ2ZHNTSoY8aMw==
X-CSE-MsgGUID: BRkiS9IgRvievdmtx8Vimg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="101127684"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 00:03:33 -0800
Date: Mon, 30 Dec 2024 09:00:20 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Su Hui <suhui@nfschina.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] eth: fbnic: Avoid garbage value in
 fbnic_mac_get_sensor_asic()
Message-ID: <Z3JTFJgbzX4XGHwG@mev-dev.igk.intel.com>
References: <20241230014242.14562-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230014242.14562-1-suhui@nfschina.com>

On Mon, Dec 30, 2024 at 09:42:43AM +0800, Su Hui wrote:
> 'fw_cmpl' is uninitialized which makes 'sensor' and '*val' to be stored
> garbage value. Remove the whole body of fbnic_mac_get_sensor_asic() and
> return -EOPNOTSUPP to fix this problem.
> 
> Fixes: d85ebade02e8 ("eth: fbnic: Add hardware monitoring support via HWMON interface")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> index 80b82ff12c4d..dd28c0f4c4b0 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> @@ -688,23 +688,7 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
>  
>  static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id, long *val)
>  {
> -	struct fbnic_fw_completion fw_cmpl;
Probably it should be:
*fw_cmpl = fbd->cmpl_data
but it is also never initialized.

> -	s32 *sensor;
> -
> -	switch (id) {
> -	case FBNIC_SENSOR_TEMP:
> -		sensor = &fw_cmpl.tsene.millidegrees;
> -		break;
> -	case FBNIC_SENSOR_VOLTAGE:
> -		sensor = &fw_cmpl.tsene.millivolts;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	*val = *sensor;
> -
> -	return 0;
> +	return -EOPNOTSUPP;

It is more like removing broken functionality than fixing (maybe whole
commit should be reverted). Anyway returning not support is also fine.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  }
>  
>  static const struct fbnic_mac fbnic_mac_asic = {
> -- 
> 2.30.2

