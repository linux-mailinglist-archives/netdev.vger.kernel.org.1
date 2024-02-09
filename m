Return-Path: <netdev+bounces-70598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE9D84FAFE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE679283D9B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46DB7BAF5;
	Fri,  9 Feb 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD6mT/AY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFD76414
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499633; cv=none; b=WkZMngrEKeoBOTUvIZKN5IYcAFKVEoBndIniFeYETjRerDD53rc0ChOhujp4W15b/m0MsQBcxt/9PICe7vYFN+Hlkl81IGw8hCX9oZZ6E3mUB4RLhAe1jg5WLyawXh8zSkCXLFSkitByoEe/w4OAAYspwS68YCKfmjttFTImtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499633; c=relaxed/simple;
	bh=fJ6NONlFF7HHwdpssZytfNNj+QKkFtEm5uaVaeAR3HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id3jMk36+wmmgMQq5YmSNXMBKx4+VoBwf41Gg8vEFWe5r+rSSF2Pf52RifAYhP8bid2DqIIVPMA623MIwMXM2T6fYaDDYwitR4N5LLSsqn1kBjWccLymBncLcgJJIXDP4SXjc/5sP++Ujsgi7h5HM5mBtjyqfIy7wsNshJ8isXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD6mT/AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97822C433C7;
	Fri,  9 Feb 2024 17:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499633;
	bh=fJ6NONlFF7HHwdpssZytfNNj+QKkFtEm5uaVaeAR3HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GD6mT/AYXR6MPkeJBHTv/5fMb5ykQN1CQTj+B8bHPSyueMiEuEfXScMtueL+bKB7n
	 jfXOQbu6yTBSfPAtMkcRyLinZQgLmjDPhmgJpAmHPAxL5GdTQIUs4aN5UPgCYIvF9l
	 Hta1EWpr/9saahDd2nc70OAxsC13uMK2XA8jqdaEIENf+esSRx/Cj6UU9G+kekJc5X
	 kgiLUI85cmj7kGIsBa35KN9O/o7LXl8gdHxtqWd89vQXaNLmXAlm3CNFOsLRh57sL9
	 qHeyUvOiAyNHTNIYPxFsxqxWwHkSZcH5y2ZT8/ddpyLNC/qoh2Mg7930gjhBami9Qb
	 ji4U/gjMELF4Q==
Date: Fri, 9 Feb 2024 17:25:39 +0000
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jiri@resnulli.us, przemyslaw.kitszel@intel.com,
	vadim.fedorenko@linux.dev, paul.m.stillwell.jr@intel.com,
	bcreeley@amd.com
Subject: Re: [PATCH iwl-next v5 2/2] ice: Fix debugfs with devlink reload
Message-ID: <20240209172539.GG1533412@kernel.org>
References: <20240205130357.106665-1-wojciech.drewek@intel.com>
 <20240205130357.106665-3-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205130357.106665-3-wojciech.drewek@intel.com>

On Mon, Feb 05, 2024 at 02:03:57PM +0100, Wojciech Drewek wrote:
> During devlink reload it is needed to remove debugfs entries
> correlated with only one PF. ice_debugfs_exit() removes all
> entries created by ice driver so we can't use it.
> 
> Introduce ice_debugfs_pf_deinit() in order to release PF's
> debugfs entries. Move ice_debugfs_exit() call to ice_module_exit(),
> it makes more sense since ice_debugfs_init() is called in
> ice_module_init() and not in ice_probe().
> 
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


