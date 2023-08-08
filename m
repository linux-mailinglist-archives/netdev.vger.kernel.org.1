Return-Path: <netdev+bounces-25274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC6A773A3D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB011C20F62
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2DD101EA;
	Tue,  8 Aug 2023 12:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293811181
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B258C433C8;
	Tue,  8 Aug 2023 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691498789;
	bh=bwqg+nZJaOp58U9gLi7+hIbzVoD6HWVrHABj3u2osQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bv6idbcnou7dvWv3pfCSTobSlZ8fXVeIw2yMmJVRggQHuTlgeo+lUsF5L8mUAfrxw
	 Fb2BkRhuXr61SboC+ZUEBawjWZCulZnmjCs4zf47NOf4EXTLrZlZdXPLIYTdZ5kBGA
	 YdPp9jZSZ0hSZQYFhhy0b4/5OT6RjvfsYvu4qaZ1cKuY54iLY8SbN3WArnkfzPxntX
	 PsuYgLY/tsgFrUsjKdyt/eicIpeXIqk1sy66Iw0BblMhZoNn9tCT4MJJr1JexQSgfA
	 dd1N2mGvCM08nCLESVFn3n3+mWH9CqCwu/xITCIqguMtve2XtiLfah+dEHIN/rNpJw
	 l1P1t+mmv4g1w==
Date: Tue, 8 Aug 2023 14:46:23 +0200
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	saeedm@nvidia.com, leon@kernel.org, louis.peens@corigine.com,
	yinjun.zhang@corigine.com, huanhuan.wang@corigine.com,
	tglx@linutronix.de, na.wang@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2] rtnetlink: remove redundant checks for
 nlattr IFLA_BRIDGE_MODE
Message-ID: <ZNI5H4OY1DrFOcq6@vergenet.net>
References: <20230807091347.3804523-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807091347.3804523-1-linma@zju.edu.cn>

On Mon, Aug 07, 2023 at 05:13:47PM +0800, Lin Ma wrote:
> The commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
> IFLA_BRIDGE_MODE length") added the nla_len check in rtnl_bridge_setlink,
> which is the only caller for ndo_bridge_setlink handlers defined in
> low-level driver codes. Hence, this patch cleanups the redundant checks in
> each ndo_bridge_setlink handler function.
> 
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


