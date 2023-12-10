Return-Path: <netdev+bounces-55614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01BB80BA87
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7AB1F20F9D
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5D8BE6;
	Sun, 10 Dec 2023 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkH21ofn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD38494
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A13C433C8;
	Sun, 10 Dec 2023 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702209257;
	bh=x6cjpt3ajy0Kzb75ylp+GLKAKp4kb24qMl37MO3JNIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkH21ofnQYHV0Vs2oSW+t/uDnCP6CzdX7Y53lJsOFMLDAMX/46zp3/uH3+j6LCEMc
	 27oUG/jVVLDdeFbBCbm5zBLrGpZNIRJMvWQVpdF1sVDot5tNtBjGnlch0/9fHvXoty
	 Xh1O9Ne5O3YqEOD4lEixA5W5v3aspEwPcIt3CyR1yWlW1zYExcze9J51bvRkspkLZ6
	 F/ku17FGXywToRTt4T1GpM2MdvVj0sP+smnyut1GDZrs6/f/rzEem5MC2eDj4Km1oz
	 vmdVPjTZmlSfx6m2EZGDSQ7mklDgVKCEabqeA0l8IMWbzeUYg/jK666MdqSMEr3Gg8
	 d9mmuMZjkecoA==
Date: Sun, 10 Dec 2023 11:54:14 +0000
From: Simon Horman <horms@kernel.org>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: Do not get coalesce settings while in
 reset
Message-ID: <20231210115414.GK5817@kernel.org>
References: <20231206173936.732818-1-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206173936.732818-1-pawel.chmielewski@intel.com>

On Wed, Dec 06, 2023 at 06:39:36PM +0100, Pawel Chmielewski wrote:
> From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> 
> Getting coalesce settings while reset is in progress can cause NULL
> pointer deference bug.
> If under reset, abort get coalesce for ethtool.
> 
> Fixes: 67fe64d78c437 ("ice: Implement getting and setting ethtool coalesce")
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> ---
> Changes since v1:
>  * Added "Fixes:" tag
>  * targeting iwl-net instead of iwl-next

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

