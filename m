Return-Path: <netdev+bounces-42707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC37CFECA
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B526B20B75
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406E431A68;
	Thu, 19 Oct 2023 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeDyiR4Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247330FB0
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC07FC433C8;
	Thu, 19 Oct 2023 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697730984;
	bh=cWiB5WBf+4iej5K0spNCMxRFf7fDDK9vDgeVfjadgeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeDyiR4YDfMMkxsjV5h9TwMDJe3hBmCeegsT2OC4BwCqaFZO0mgtDgMACm/DjFVLn
	 T6dFAHe3Kn0RO8nw7jVVWFJ80Kr2GRApNwo3krykajuzObjl0xI1YrZ1srRgPo78No
	 JCHtQWT5dOO5E+3Wl5VE1XtPVJMCIOVXPokNCf9m+WebM8CDT8aOMEncDme5LqVEp+
	 KVHRGeF9PG71KhoeEmFqmPA2L5nd+miGdqtRt3fXJSORKlvWXdYnrwvSF6lU0kmRu/
	 Oj/Huxmxje0p2f8NlmL4Fhb2TT3jvRanNjssOj8N4E8+MwmY8in2xh6P/v+w64OUEp
	 i7uypHlP+gNNQ==
Date: Thu, 19 Oct 2023 17:56:16 +0200
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
Subject: Re: [PATCH net-next v3 02/11] netdevsim: devlink health: use
 retained error fmsg API
Message-ID: <20231019155616.GK2100445@kernel.org>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-3-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-3-przemyslaw.kitszel@intel.com>

On Wed, Oct 18, 2023 at 10:26:38PM +0200, Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


