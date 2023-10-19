Return-Path: <netdev+bounces-42712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4051D7CFEDA
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39EDB20DAD
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671C32187;
	Thu, 19 Oct 2023 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKlBFIoC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52930FB0
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A2BC433C7;
	Thu, 19 Oct 2023 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697731083;
	bh=QbLeNs0KiqyXx6KeGr1Tb+iIIwByM0EHeR9F194rjjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKlBFIoCpi5yWke5RcXfIg5Ohs3onH/zaAVO8Hk8c21Qfo23jt84Fb1VwRj1F/X0f
	 zJd+GDFQX3EJN+s/Az6KyFNfnfz0+TSH5aOtoiV9guL29vwwmzdTqJsYTytLIfI9bJ
	 /UG7Yo+hianYE1TLm5kYSocz+IsQmoCggqibzkYASJHLyQoxugkwoq1f8Niz2KLWt9
	 qge4qeri4t4JAfv355ci1Vd7hbS3b8otUPtiFq0vHsiK+7scAz3hyNycSZZVwi+085
	 bTWM2OFaCLYxqtkRjxd+c6L9GEgJvIWA0HIGAkAwRk6GZ5gFTSxv6DkHVbQ/TsKXTs
	 bv0esuCnmwLrQ==
Date: Thu, 19 Oct 2023 17:57:55 +0200
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
Subject: Re: [PATCH net-next v3 07/11] mlxsw: core: devlink health: use
 retained error fmsg API
Message-ID: <20231019155755.GP2100445@kernel.org>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-8-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-8-przemyslaw.kitszel@intel.com>

On Wed, Oct 18, 2023 at 10:26:43PM +0200, Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


