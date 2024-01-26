Return-Path: <netdev+bounces-66268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66E83E290
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 20:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1111C220EF
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6622EFC;
	Fri, 26 Jan 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeFX1CME"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADE22EF9
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297518; cv=none; b=RY7NGd3z6IBKibusWmsZKV8zMM6ThcCGBRof/rLgSG3rgdIJZCPcugOphU/MHLyyiGG60ayQ2H1j4mbQg9Ug2NZi6OiciGuU3wQgmsd8hXIl9iZtllcqjj+AP97v83pSI+3dRdaHGFhuKDLnqZgvXrm+9O7Jdi6TbNFUXcEZiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297518; c=relaxed/simple;
	bh=0/gi19UjEgJe4xm59PJQWWgwTm1xGi9jlTcxXelyEr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgA/YIjuojWsauCHsFw71+1mE5UWvBtChM0UoLe0n+wllUS7/POuIC2UuuxchuXK7y0BVl9pDu5TZY4aa0eN/eezVoMYuMzX4G/GCRwbjniRPnSBBDSr8CBg9lrFfRU1nqVRZVk6BOxEfzuBDHnGR8LKcOj6IhLjwYkaHppF0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeFX1CME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B4FC433F1;
	Fri, 26 Jan 2024 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706297517;
	bh=0/gi19UjEgJe4xm59PJQWWgwTm1xGi9jlTcxXelyEr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeFX1CME2O6T9rk7uTOsI66c0vGvv958hv7NxrVDQBRwFFcmX1ud4nxVb7paO4/ZI
	 lTgqLTrTC3JfOmY2NNgQN0RHXFDwKuByEN/zhWq5U7Hjls1BjtqdVGEHLmLO+xIThc
	 B5GpEqEBo2n0B0jgACIEmPkyfFksByd7yHfYEsAAM67aM6XhqDNCEN8SAyRoRpQfQj
	 bAQH4oFFDiNres/dr6gNfByN9L/VyRuF0u31TfsPKr507BXq+bYhFqWqA/6D2NpL0c
	 HrY0juRMXjlF7MA8TselGrtlISgMy/f9x3gtOFeOD8N6WZK+zywf1+YKQHWHAWpQ0T
	 uhZwHrnRx2nAQ==
Date: Fri, 26 Jan 2024 19:31:52 +0000
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jiri@resnulli.us, przemyslaw.kitszel@intel.com,
	vadim.fedorenko@linux.dev, paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH iwl-next v2] ice: Remove and readd netdev during devlink
 reload
Message-ID: <20240126193152.GC401354@kernel.org>
References: <20240125085459.13096-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125085459.13096-1-wojciech.drewek@intel.com>

On Thu, Jan 25, 2024 at 09:54:59AM +0100, Wojciech Drewek wrote:
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
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


