Return-Path: <netdev+bounces-65850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A151083C087
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECB11C21DF7
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0502C870;
	Thu, 25 Jan 2024 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC33db9x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41D2C69D
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180866; cv=none; b=Ille8x54vtaZR8t11FUL931zVIDKCNynSW3Kd1GoDdhi3TcrU0DIFCMpma7Xk+F9lBwagpw2lVkXDvGEQDdLhDCKfq5pXBmAItO4X7yb+xz1ThNbsvmULWB9h0e8m+aJqjZLeLAsHiw7QKQmWNvFYTMS3hSOIJtmHtEiPs0B+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180866; c=relaxed/simple;
	bh=aYYCJudU8yAUgkMyhB1YwN2Sg7x602RYmD/3GTG+plA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZgg01RBJ3goNlAk9SgYiFatIqvKkkZevFEt79PHU769izwjG/bocy2+qBC7sW8C0gLT65UWMYJ27L3BSEsmCJIoew/NbLDBmtHxVWmsZqOHqScW5RY4nHb4PsQFVUdW+GzVXifmP8qov5xI/71xbK0NS1ZzyXMqk0RB02pM2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC33db9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E9EC433F1;
	Thu, 25 Jan 2024 11:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706180865;
	bh=aYYCJudU8yAUgkMyhB1YwN2Sg7x602RYmD/3GTG+plA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pC33db9xAAvNYuBouA84sGa2BAY23nEQ2wCPOlhGs2/nc4PqxRaufVBH7n5noAnsY
	 jnYeqjCKVWODNd83CoyWUM9qYJ3poP1F2G7XxprkXa+qExe5JtwJ7u4LrOZWGEVELr
	 fXX7z83WvvTiwXjbZGuwIhwOa5HSb346qLCZ57yYPuZf/kRRvY38Vx2tH35bL2N17m
	 Q180MYgkv1UJ+hAM1mZSkebsCOKDLnt4q5lAa9mKII7eR4FxU1bbc/t+90OmkxsE/m
	 QCXAkH4W5HeVwyliIeRcPo+X1xoCQTb9JC9vUdV6yIpBPTvHi3aA2zO/bOk8JCsNW7
	 +xtpvHWkiQ6HA==
Date: Thu, 25 Jan 2024 11:07:41 +0000
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jiri@resnulli.us
Subject: Re: [PATCH iwl-next] ice: Remove and readd netdev during devlink
 reload
Message-ID: <20240125110741.GE217708@kernel.org>
References: <20240123111849.9367-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123111849.9367-1-wojciech.drewek@intel.com>

On Tue, Jan 23, 2024 at 12:18:49PM +0100, Wojciech Drewek wrote:
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

Reviewed-by: Simon Horman <horms@kernel.org>


