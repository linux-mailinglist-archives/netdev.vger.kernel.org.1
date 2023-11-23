Return-Path: <netdev+bounces-50559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A79D7F61A3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAA3B21549
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068B7250EC;
	Thu, 23 Nov 2023 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMG5vuNG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFADE2AE90
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 14:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648DCC433C8;
	Thu, 23 Nov 2023 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700750291;
	bh=UCTz5cBRlznHaYwHngoEfU+e2S0kC2Om+8hE86GPxCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMG5vuNG3fI8ZYPkS/1ZVNb4IDtP4nMDj0LgE9lEjzW9xrzmCcMvndo/U0o1MavQr
	 fjviKd7zqTSExBIWrJ4blRTnhFGR0hcM81Pj6BiGcH/Cw/Iy0mWS/mxtyihQuhlkIS
	 n4gpHYJEl/y7CN7C5B730uZWys5BrcN5IpMXs3rzRi6eN/wk4YjwoyhW42jhLe+fVx
	 k5iaQsP7cgaXQvxnP3j1lquUXSYXAxi6snM41OEPbiqjCjwUlj2K1ZphrTDKRaSiLV
	 wqUjrDVonvndLW8ZZlwkLikrtHDN+FhfRCOTufw5Iq/YVXT21jhIxhg+Qf+L+uwFi4
	 De/cmvImrjEyg==
Date: Thu, 23 Nov 2023 14:38:06 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com, Coverity Scan <scan-admin@coverity.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next] mlxsw: pci: Fix missing error checking
Message-ID: <20231123143806.GI6339@kernel.org>
References: <b5a455a64f774adc18dfe2eec7a54413e0cfb2e2.1700740705.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a455a64f774adc18dfe2eec7a54413e0cfb2e2.1700740705.git.petrm@nvidia.com>

On Thu, Nov 23, 2023 at 01:01:35PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> I accidentally removed the error checking after issuing the reset.
> Restore it.
> 
> Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
> Reported-by: Coverity Scan <scan-admin@coverity.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

