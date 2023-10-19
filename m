Return-Path: <netdev+bounces-42715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C87CFEE5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9858281F87
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754EC3218F;
	Thu, 19 Oct 2023 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB4mWxIT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4430FB0
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E909C433C7;
	Thu, 19 Oct 2023 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697731147;
	bh=i1omozby4EP2nJtt2vwivrLCaXUQEHO8dCe2Ki30RdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gB4mWxITYCEoH4eeUe26dhMkqyiRASOc8CnzXBKadpF2jM4Jor++fIE8HeWVojDd8
	 UWuHv6j9VWNAvv9PS9ZMf3GFP8S6wNl3bpoc6hfxA1k8ZSQDg5H9B/JDHyeIiynCz4
	 Pqtgvba9TrvWlrVx7h3axoOXJItKoAW2GP6QaxuZJH7PZo1X/l24/kgtxgMFp00wK6
	 Ck6NvnMcRA0iBa0dNmK7dOmB6p74T3fAGtYhNtplqrA9SGxHJmTDgR6nWSlH2pU763
	 w1HQPz6OSGgxd90uSrvuf4nkTG9su647yEV9akQaAbBPI7k+6rLSrxPaxJNPMmaBWz
	 G0bIjtmhHr9SQ==
Date: Thu, 19 Oct 2023 17:58:58 +0200
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Coiby Xu <coiby.xu@gmail.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Benjamin Poirier <bpoirier@suse.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 08/11] net/mlx5: devlink health: use retained
 error fmsg API
Message-ID: <20231019155858.GS2100445@kernel.org>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-9-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-9-przemyslaw.kitszel@intel.com>

On Wed, Oct 18, 2023 at 10:26:44PM +0200, Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


