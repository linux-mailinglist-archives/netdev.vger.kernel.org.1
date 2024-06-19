Return-Path: <netdev+bounces-104831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C6790E8F2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45671284C34
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE4F13A279;
	Wed, 19 Jun 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQPoj8uq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853D139D15;
	Wed, 19 Jun 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795122; cv=none; b=fPm3xcAJWQQzN6TYZ8VS7BV8j5sU0prEv6cUr1tzxcB4VW6DQXJbGgLCMRPHtYOE0i1h+Sx9cNp9LOhLtLPbC2SZhkyyVx7BvH75sYfeLR1lVygrV6veiyECmZRA61NxNcO4SlgAJZWW4L1wcEHxdM+/C5gYdh7ReTvStqFylCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795122; c=relaxed/simple;
	bh=Uh5WmoLVL5Fngn5y6WjRvd07oh2JBAFi2uDL6j7S7uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N69a4KT4nojE7h6ACxzuqMhowcNfg1UYXrz2U56A/JAiib5xFZmd3byXkaE2WKktU7TZcM3rwBvxcYILt+SJxcejfWY0fufqxp/ezQijoq8G0jWuCNy9/+DGC6zpPOyDBgkJYVmKm+AMre5WOjSp4TDpCOrcfQ4pVReAJASZffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQPoj8uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC1FC4AF49;
	Wed, 19 Jun 2024 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718795121;
	bh=Uh5WmoLVL5Fngn5y6WjRvd07oh2JBAFi2uDL6j7S7uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQPoj8uqFOmX5PAChvrpAjJx8vxT+JB0Dee4Kj9XAgefq/qX6wgxUuTRkbNGKTw5O
	 yUDUxpLipNvJ4gYYRC4KVFF8JrHBwgjKvhO3lcwLAiPukcgiuODPWZDvPLjYVK/Q+z
	 BSYthMfoQL7VGdCdURw3ZKdaHT8QMZ4fkXDOva2jjkjPSIguIBgTJmcD1OMkV5G1PP
	 B3nrxGERj45M+O++MAFBgRU4Q8WlZ3X3cKsjCeB4+0oGmtjaBpk9Tp5GHvGLFHCqrZ
	 G9QkwSdP0bKTG8XCwtbj2whIvWKF6GhEdInhkweJXyvWStCb6+t79OACdz+/qWaBzf
	 ksBPSjf0tSXdQ==
Date: Wed, 19 Jun 2024 12:05:17 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net PATCH] octeontx2-pf: Fix linking objects into multiple
 modules
Message-ID: <20240619110517.GC690967@kernel.org>
References: <20240618061122.6628-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618061122.6628-1-gakula@marvell.com>

On Tue, Jun 18, 2024 at 11:41:22AM +0530, Geetha sowjanya wrote:
> This patch fixes the below build warning messages that are
> caused due to linking same files to multiple modules by
> exporting the required symbols.
> 
> "scripts/Makefile.build:244: drivers/net/ethernet/marvell/octeontx2/nic/Makefile:
> otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
> 
> scripts/Makefile.build:244: drivers/net/ethernet/marvell/octeontx2/nic/Makefile:
> otx2_dcbnl.o is added to multiple modules: rvu_nicpf rvu_nicvf"
> 
> Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Thanks Geetha,

I checked and it does not seem to be possible to compile
rvu_nicvf as a built-in and rvu_nicpf as a module,
which was my only concern about this.

Reviewed-by: Simon Horman <horms@kernel.org>

