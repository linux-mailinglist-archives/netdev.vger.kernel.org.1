Return-Path: <netdev+bounces-17759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D90752FDA
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EF91C2146A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F391110;
	Fri, 14 Jul 2023 03:17:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425510F4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 03:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB07C433C7;
	Fri, 14 Jul 2023 03:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689304649;
	bh=pEGsOszmML37IX4Yb81gjGbW0Xq1S6oWpSR2x4ZU4+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iktJ5hcDNbl7sLPhKIpLAVwGAO0dTNaVOi42Nt8g/4WlspVL0JJ2kMgpUnSDQvcXx
	 FL8/5IfdT/sTvi1llcVAiu45NT6gquShTPTqf5MhQy/nK7rTwkhAYMDUKJS5M/4u+X
	 drxNzdfqzm+d3LQ8/TZ/Hs8KfCOiIV4EREvZ68Q4oJLYovJwgpqyZupKnjQTkC59Ya
	 mmZ0B23vmdksIs9kQb42TaNnJmmahAOFeI+48sfjJ5V8lJujSm/PUMw9w7VG8GicQE
	 yXEr1euayc7Bt97o35SCbTQQUuAjQtzb0GyyZ7BDy23hBjfFxxyvPSIDdcdId5R6af
	 Pl9e+hCAcFKHA==
Date: Thu, 13 Jul 2023 20:17:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230713201727.6dfe7549@kernel.org>
In-Reply-To: <20230713185833.GI41919@unreal>
References: <cover.1689064922.git.leonro@nvidia.com>
	<5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
	<20230712173259.4756fe08@kernel.org>
	<20230713063345.GG41919@unreal>
	<20230713100401.5fe0fa77@kernel.org>
	<20230713174317.GH41919@unreal>
	<20230713110556.682d21ba@kernel.org>
	<20230713185833.GI41919@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 21:58:33 +0300 Leon Romanovsky wrote:
> > TC packet rewrites or IPsec comes first?  
> 
> In theory, we support any order, but in real life I don't think that TC
> before IPsec is really valuable.

I asked the question poorly. To clearer, you're saying that:

a)  host <-> TC <-> IPsec <-> "wire"/switch
  or
b)  host <-> IPsec <-> TC <-> "wire"/switch

?

