Return-Path: <netdev+bounces-52609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255BE7FF738
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14E8B20DF4
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D655766;
	Thu, 30 Nov 2023 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np6BJ4vx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828324315A
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499A9C433C8;
	Thu, 30 Nov 2023 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701363290;
	bh=49qhqgGAf1il4MSpBynBgZFH+miXfZEwpG76uLbPmaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Np6BJ4vxXm6HT8i2fZ9urPkjpE7U+PZf1nbMqbgnst4FDTsNisnm6s8tLoje2SPQJ
	 qMgzClrZSmMcq99U6JT0NDlzBr9Sb+wPbjaZwcPVLKoLEPLxKQfWate2/Uj51/wp0O
	 q3u+kP0EwP+JVZqi0L/q1ake8Nl7g4Nor5E+QjjlCX6yAmEcdsOiGtyxomt2Nhr9JE
	 lcC+AldJJLiMdMWt+pIcimlgAyOPfX5FkopqSC6Ykntf0ih4rAt7PmTKqjd5/mEZmo
	 aybKPIfqCQbttV/SHLkdAHFsER7sfu31yRAwnKGUMrvlfqIHdozZGZY15fqPlP5pl6
	 kAy+zh7PIKeAA==
Date: Thu, 30 Nov 2023 16:54:44 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, wojciech.drewek@intel.com
Subject: Re: [net-next PATCH v5 2/2] octeontx2-pf: TC flower offload support
 for mirror
Message-ID: <20231130165444.GF32077@kernel.org>
References: <20231130034324.3900445-1-sumang@marvell.com>
 <20231130034324.3900445-3-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130034324.3900445-3-sumang@marvell.com>

On Thu, Nov 30, 2023 at 09:13:24AM +0530, Suman Ghosh wrote:
> This patch extends TC flower offload support for mirroring ingress
> traffic to a different PF/VF. Below is an example command,
> 
> 'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
> skip_sw action mirred ingress mirror dev eth2'
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


