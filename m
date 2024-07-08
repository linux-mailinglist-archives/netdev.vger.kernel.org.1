Return-Path: <netdev+bounces-109892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024892A310
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9B41C21061
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606F80BE5;
	Mon,  8 Jul 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZTC58eJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA427E0F1;
	Mon,  8 Jul 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442533; cv=none; b=b3X7wV3rxIvewCaVV/7173VdROlTEPorS+NS/JUBMl9sbW16HRw/o4Mly9mI3bxEKq9H5FX+oGIxaF7U3H5g65iJEpI3ALsB6olMrURPNrO/tVRahMcWpdlCZVz9IMYBh0zmDoCxLoqtWMD+4SBcNz/eUgdrHIFx82Vb4Ex8OFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442533; c=relaxed/simple;
	bh=Wgz2uiozIHIDH/yHMDfCgHBZnNB235P31/pFr0zACA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRd1x24ey0kCVHOOG2PJL+RqwH6V+4hXJwWx60FT8N5D4RfZ7IBZd2wBFnYFBh/DTja8+oOAHnQvGiNg9qhC3/gahzrNrmpxV9L5+jng2sQtkjbvKm6uI8auME4AraxoidYhj5SKb0z+qYv6Ol9XR9iavXnEULLHrmrYIFPQpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZTC58eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95773C116B1;
	Mon,  8 Jul 2024 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720442533;
	bh=Wgz2uiozIHIDH/yHMDfCgHBZnNB235P31/pFr0zACA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZTC58eJTG5w0XOOVhkJy7mBcuMU6EYZG9YhXGUNQBXqx97UC3+yjtIjpXw+ZuQTv
	 OP2I3gNG/Vwg/jzSYbSwypAi/FjJ+smFk9TFXH53wWGFzPrK8KdfqK1et8meDspoKy
	 ByMvAYTlt3GHHH1JBM4m5AG8zfC8ppv7BAjL7CtagOvdVnh3aGQoRiaW9O8YTowxpR
	 js/WG0mINjjVPiTWKanJ1FmQmoo6L+dKQMJFQ7ofQki7DKm4/vqxV1oFG8nS1cKpO4
	 uO3RxvNZUew/uzxecZhG/OAV+uckl8Nc+KQW6aAFP+cXH4s0J4yrnMkVXwtNZZHo/K
	 QBrUiKaOjSiJw==
Date: Mon, 8 Jul 2024 13:42:08 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, apw@canonical.com, joe@perches.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, willemb@google.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Ben Shelton <benjamin.h.shelton@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ice: Add MDD logging
 via devlink health
Message-ID: <20240708124208.GR1481495@kernel.org>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
 <20240703125922.5625-6-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703125922.5625-6-mateusz.polchlopek@intel.com>

On Wed, Jul 03, 2024 at 08:59:21AM -0400, Mateusz Polchlopek wrote:
> From: Ben Shelton <benjamin.h.shelton@intel.com>
> 
> Add a devlink health reporter for MDD events. The 'dump' handler will
> return the information captured in each call to ice_handle_mdd_event().
> A device reset (CORER/PFR) will put the reporter back in healthy state.
> 
> Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


