Return-Path: <netdev+bounces-42096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEC7CD1B2
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA192814D3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73163EDE;
	Wed, 18 Oct 2023 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB6fL6g3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52811A5B
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6205C433C8;
	Wed, 18 Oct 2023 01:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697591745;
	bh=txh0CUFBNNdl/1yV+ubQIc1v2meuc+g1RlL8IiDVMtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eB6fL6g3DGYiyQGzTY1ORMxAdBrTR6uHsE3B9mOurD0ARmEgYyOAbNYRhA0Br/n/O
	 G8YBo3OqTB0qsSPtyY4rtU79sF7NItMU1y8jwC3KvLbq4mAWGNFXZVFnDoVFvNrWxn
	 N5s5u8A3XQv8iln5pVP2MauYrlUWiFBGMt+xlxV8RYNNt9OGtglfX5J5QrQ6sfXEJz
	 c9HoHkDMIl0cfoMguW7IS1pLx76c6ii4sza4IWawT5OLU1MiwJxlFY57yRrNyzo6dT
	 DCIBiwJKL6cQrAD43ScrbE9+hLup3aGtiRPLQ6d2OK6IDSy2Ordio/ap4XEo/kP2w+
	 qpHRncobsvwtg==
Date: Tue, 17 Oct 2023 18:15:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coiby Xu <coiby.xu@gmail.com>, Benjamin Poirier <bpoirier@suse.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>, Michael Chan
 <michael.chan@broadcom.com>, Cai Huoqing <cai.huoqing@linux.dev>, George
 Cherian <george.cherian@marvell.com>, Danielle Ratson
 <danieller@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Ariel Elior <aelior@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Igor Russkikh <irusskikh@marvell.com>, Brett Creeley
 <brett.creeley@amd.com>, Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin
 <ayal@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/11] staging: qlge: devlink health: use
 retained error fmsg API
Message-ID: <20231017181543.70a75b82@kernel.org>
In-Reply-To: <20231017105341.415466-11-przemyslaw.kitszel@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
	<20231017105341.415466-11-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 12:53:40 +0200 Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.

Humpf. Unrelated to the set, when did qlge grow devlink support?!

Coiby, do you still use this HW?

It looks like the driver was moved to staging on account of being
old and unused, and expecting that we'll delete it. Clearly that's
not the case if people are adding devlink support, so should we
move it back?

