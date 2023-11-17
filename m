Return-Path: <netdev+bounces-48729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0F7EF5B7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667151C2082A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0930335;
	Fri, 17 Nov 2023 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHorbHfC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7749F9A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EDEC433C8;
	Fri, 17 Nov 2023 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236389;
	bh=EkJXt82WQysCMYrDD2vrEuifKwB2iPptzM+qqCv7ra0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHorbHfCCLbyYDRfwvb7WwRV8GMtCWydxYobeAL+tf7H30cx0ZxyL256ZpU5g9UdQ
	 hNjHNkz9RSKdzPxhT+bqQcOVu65SeLCFtCwGhj0fbini1K1uyOn356JQVG+94IAKYE
	 2tVMcsg/QIpUW/F08mCxaarpiHUi1hIQSA4/utLzv6mj2VlYkhVGHi+t7B7wphnBId
	 WRHIWVgFpZQIU9qnGLxozRVjzGWA4xkd64odcmX/zykOwxlA7igI5MJzZOvhbmUBza
	 F/etQIXYTlSc+Y6gMLsYR7g0Q5zJt0bVvR/xapt9VfrAeRkXeXqYXlBVNz3nPatYmJ
	 YLdCdjuvLLfVQ==
Date: Fri, 17 Nov 2023 15:53:05 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 10/14] mlxsw: pci: Rename mlxsw_pci_sw_reset()
Message-ID: <20231117155305.GK164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <b0b1c4a725714f8f70f114226f6cf114d4537062.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b1c4a725714f8f70f114226f6cf114d4537062.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:19PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> In the next patches, mlxsw_pci_sw_reset() will be extended to support
> more reset types and will not necessarily issue a software reset. Rename
> the function to reflect that.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


