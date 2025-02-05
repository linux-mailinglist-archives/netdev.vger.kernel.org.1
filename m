Return-Path: <netdev+bounces-162944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B41A28921
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617CE3A1E4F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B343A22A7ED;
	Wed,  5 Feb 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cR4XNF0E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5321773C
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754612; cv=none; b=eRYLBeO+cnCB4jsQ7vg8yUOunk0XKGgW4btpXex8+mungfTpSjd5Eq/NShAP7l0fUYAnqUk5J1jsUJ126xqMwu0njF6LMTbj6OmjJn/FFnrYDcEPg0baTY1uqezMVwnePhyT6iet30PPNy3AsSfkCZg6vx1EZ4Yccv1e0nrq0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754612; c=relaxed/simple;
	bh=kTPA2cEJjPwaoqHnfY+66itOh73qdURMb0x4kl+2wbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9abZqk6tvyuRiQvnBrb0RoBpLb9omBWW2sNXsnde+1+JgdqE38xQOn1xycol9uX1v8eKa9Mi4AhRM8bl8CwHst9nKuBUEbbA1sJS/9IGQum4gyEo2VXwKzRc5RQhj1zhMVfnTMThk3ut+bMp1bDWxNWKEd5S5kwwisors4FpRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cR4XNF0E; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738754611; x=1770290611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTPA2cEJjPwaoqHnfY+66itOh73qdURMb0x4kl+2wbM=;
  b=cR4XNF0E/vw3cKu5iB12jpU/kQe7L6zswafDZmizE/csjDraNPGjJ85m
   kj5FcDY+mTRld7+PuMGbnfbVaqxyEPPQblcMlUxQiWleWtp/RZkNVcbQv
   x3Y2Bz52rrTkBDiZLDdYy0FT7OQ+TaM2SWl5J7VTSf5SXeaH8nKWqL05o
   wQEp7/0JGVZU4z4qGQOfyUOup+fdPXqn/KX9N64OkMSk7bXKq3N/ayKdI
   fbTVY1USaeSU6cYmqxLibvOk+3kdmgx4Tr2cARu1OT1qMouJVe2eouajd
   /6EoNvTZTYO+7RXLw+xrEuDOHVaWQdPZtCmQZJAMe0U+wrzutovou5GWI
   A==;
X-CSE-ConnectionGUID: taCUzJC4Sce0DyowLAkVwA==
X-CSE-MsgGUID: u78IdtivSFKs3NBCbJf/qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49963666"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="49963666"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 03:23:30 -0800
X-CSE-ConnectionGUID: +vAhKIm5QJi8tT6ww1tbFg==
X-CSE-MsgGUID: kJ44STgsRvW7OZ3VEmtcug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111314891"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 03:23:28 -0800
Date: Wed, 5 Feb 2025 12:19:55 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: [PATCH iwl-net] ice: health.c: fix compilation on gcc 7.5
Message-ID: <Z6NJUIQ+lzhBE5Yk@mev-dev.igk.intel.com>
References: <20250205104252.30464-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205104252.30464-2-przemyslaw.kitszel@intel.com>

On Wed, Feb 05, 2025 at 11:42:12AM +0100, Przemek Kitszel wrote:
> GCC 7 is not as good as GCC 8+ in telling what is a compile-time const,
> and thus could be used for static storage. So we could not use variables
> for that, no matter how much "const" keyword is sprinkled around.
> 
> Excerpt from the report:
> My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.
> 
>   CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>                                ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
>    "Change or replace the module or cable.", {ice_port_number_label}},
>                                               ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initialization for 'ice_health_status_lookup[1].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
> Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/netdev/CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> I would really like to bump min gcc to 8.5 (RH 8 family),
> instead of supporting old Ubuntu. However SLES 15 is also stuck with gcc 7.5 :(
> 
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Kees Cook <kees@kernel.org>
> CC: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/health.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index ea40f7941259..4bc546bafad1 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -23,12 +23,12 @@ struct ice_health_status {
>   * For instance, Health Code 0x1002 is triggered when the command fails.
>   * Such codes should be disregarded by the end-user.
>   * The below lookup requires to be sorted by code.
> + * #defines instead of proper const strings are used due to gcc 7 limitation.
>   */
>  
> -static const char *const ice_common_port_solutions =
> -	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
> -static const char *const ice_port_number_label = "Port Number";
> -static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
> +#define ice_common_port_solutions	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex."
> +#define ice_port_number_label		"Port Number"
> +#define ice_update_nvm_solution		"Update to the latest NVM image."

>  
>  static const struct ice_health_status ice_health_status_lookup[] = {
>  	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",
> 
> base-commit: 4241a702e0d0c2ca9364cfac08dbf134264962de

Thanks for fixing
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.46.0

