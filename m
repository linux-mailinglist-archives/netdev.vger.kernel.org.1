Return-Path: <netdev+bounces-44510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329587D855B
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E39B20D8C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88E2EB11;
	Thu, 26 Oct 2023 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggiYUmgK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3841D52B
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA795C433C7;
	Thu, 26 Oct 2023 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698332249;
	bh=xFnrK/hYymR3dfz8jx8fav5cyj+9R1dn8SkXsqL4fWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggiYUmgKY6ENHDjAVtmLaip5NluFzVyIwYaHAMfn8f9qujFJ9uMk02EcWnmmCdumC
	 0H7U3gAk6FFMrHw4WOmERYzAJFLOsFEvXr6h4cgP7Wauq1QdXKReshzxxJ5+9op3ZU
	 OoON7cV0ZvvGdDHM1O7cG4P9g3XQa23A/jJchbL1XdYXysz4liFuAyeLZe32RUMyFx
	 TTtFeseZCeHTvWtlJzc2Jfl4v1u8l4A6HBBPBlFTGPG5+ReRUtW35W9Juz6OqHQnnx
	 JHWwKBZcTT6oqjE6BBh+S2GuRQtp3QfxcxRWdDEuMaTvS9tUhr9BDuFTYbYF6W/KhT
	 QVPoht0R37Wyw==
Date: Thu, 26 Oct 2023 15:57:20 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: sunrpc: Fix an off by one in root_nfs_cat()
Message-ID: <20231026145720.GB225043@kernel.org>
References: <856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr>

On Tue, Oct 24, 2023 at 11:55:30PM +0200, Christophe JAILLET wrote:
> The intent is to check if the strings' are truncated or not. So, >= should
> be used instead of >, because strlcat() and snprintf() return the length of
> the output, excluding the trailing NULL.
> 
> Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


