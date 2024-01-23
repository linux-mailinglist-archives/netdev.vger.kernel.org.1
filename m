Return-Path: <netdev+bounces-65178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9E839723
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 19:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08EE1F2A4EF
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA607811FB;
	Tue, 23 Jan 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N2sVSMFy"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10D8005D
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032864; cv=none; b=N9JgYP27nMEw7OcIbiHv0rlEimuT5PqdSUu3NHPO+98Vg/aJfo9iasMy7QCLVdAjty/jRD3C1Eh/bHg6Gw9ZBG4o2A/0PqRLEG/TGodMtjL9vcR8EF5eDf1MgLj0hK21xOJe0qAbCFFyvDtr0odqE0vf/7zlOoDhHxUe5ExP9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032864; c=relaxed/simple;
	bh=EhSQhj2E2Gw8gZhilODuH0mKnZBkClKrCermf9q8liY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TayrklCYEo8dFpIr7eEcoER5aTXGTZXIPyYeWsVMan+rN5Gw8Pg51GRyjaayMLsXQU+2A+Gvcraihm013+72hw0+xQcUbnp5seyWQ2Sn9Mbz3xjA0vlyeUSuetjUIDIrATIxXOEnfragRFbuiNCSAvJpPtMUdio4ZnrkD+Dz+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N2sVSMFy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b8ade34-d7f4-452d-9893-ace80c97dfed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706032861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ssa/j3dpmDkZ3OgBuIT0XpwLPpx9/Pz3jRWEPzs1hQ=;
	b=N2sVSMFycdcjLYUK54iPsNp1bCJQ4+B/mlsOEmOERuS39v1z076zSJdJRoc8X4sXNN7sOu
	gU92ZM2dVq+uhOGmDQJUmUj4oZJI4/gDA8rLiN+pnXfMzmyk413KVq+etiiBMKei17kT8z
	osAgyQ8zjwhmjdCz7m8VgpGap/kwpO0=
Date: Tue, 23 Jan 2024 18:00:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-next] ice: Remove and readd netdev during devlink
 reload
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us
References: <20240123111849.9367-1-wojciech.drewek@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240123111849.9367-1-wojciech.drewek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/01/2024 11:18, Wojciech Drewek wrote:
> Recent changes to the devlink reload (commit 9b2348e2d6c9
> ("devlink: warn about existing entities during reload-reinit"))
> force the drivers to destroy devlink ports during reinit.
> Adjust ice driver to this requirement, unregister netdvice, destroy
> devlink port. ice_init_eth() was removed and all the common code
> between probe and reload was moved to ice_load().
> 
> During devlink reload we can't take devl_lock (it's already taken)
> and in ice_probe() we have to lock it. Use devl_* variant of the API
> which does not acquire and release devl_lock. Guard ice_load()
> with devl_lock only in case of probe.
> 
> Introduce ice_debugfs_fwlog_deinit() in order to release PF's
> debugfs entries. Move ice_debugfs_exit() call to ice_module_exit().
> 
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h         |   3 +
>   drivers/net/ethernet/intel/ice/ice_debugfs.c |  10 +
>   drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
>   drivers/net/ethernet/intel/ice/ice_fwlog.c   |   2 +
>   drivers/net/ethernet/intel/ice/ice_main.c    | 189 ++++++-------------
>   5 files changed, 139 insertions(+), 133 deletions(-)
> 

[...]

> +/**
> + * ice_devlink_reinit_up - do reinit of the given PF
> + * @pf: pointer to the PF struct
> + */
> +static int ice_devlink_reinit_up(struct ice_pf *pf)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	struct ice_vsi_cfg_params params = {};

no need for empy init here ...

> +	int err;
> +
> +	err = ice_init_dev(pf);
> +	if (err)
> +		return err;
> +
> +	params = ice_vsi_to_params(vsi);

... because it's completely overwritten here.

> +	params.flags = ICE_VSI_FLAG_INIT;
> +
> +	rtnl_lock();
> +	err = ice_vsi_cfg(vsi, &params);
> +	if (err)
> +		goto err_vsi_cfg;
> +	rtnl_unlock();
> +
> +	/* No need to take devl_lock, it's already taken by devlink API */
> +	err = ice_load(pf);
> +	if (err)
> +		goto err_load;
> +
> +	return 0;
> +
> +err_load:
> +	rtnl_lock();
> +	ice_vsi_decfg(vsi);
> +err_vsi_cfg:
> +	rtnl_unlock();
> +	ice_deinit_dev(pf);
> +	return err;
> +}
> +



