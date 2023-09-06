Return-Path: <netdev+bounces-32320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A235794196
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56792813FE
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B520107A5;
	Wed,  6 Sep 2023 16:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EC46BC
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 16:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F76C433C8;
	Wed,  6 Sep 2023 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694018480;
	bh=Sp0/mnRPXAwYptFsBN7paUPyr28E4thRdJ6CJ/lv3lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dO3qgwDAs2zTRQpBHQyCEYEXOuO/1VsurxWEepZqVKgfKENnd9FNNkrHKWDo4isiI
	 lFzaWoY6Ds6EFieZAAQlunL39qOZ6CTmfta4War09QbIhJDS1EnEtgkFip3jhD4JtB
	 6O0/GEJvGFBPOdeYrJBqW274HaDvwC0ZQQoTF6Psgcvoq8XA3HY5dZ8nmmwQGIX712
	 PFwLeQw7UaK67OAOhd17m32+kRXYO1RMsxqxy0yYJnrj6yq8WgIc0USHH7LUInlHYR
	 P2sPznSye/C4p7DKS8PqOH/odfxIlgHj/uZevvCFbmeb7wPNEUKqCRGA5+Tmk9aBxQ
	 sx4SRyZDENCfw==
Date: Wed, 6 Sep 2023 18:41:16 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net] net: enetc: distinguish error from valid pointers in
 enetc_fixup_clear_rss_rfs()
Message-ID: <20230906164116.GB270386@kernel.org>
References: <20230906141609.247579-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906141609.247579-1-vladimir.oltean@nxp.com>

On Wed, Sep 06, 2023 at 05:16:09PM +0300, Vladimir Oltean wrote:
> enetc_psi_create() returns an ERR_PTR() or a valid station interface
> pointer, but checking for the non-NULL quality of the return code blurs
> that difference away. So if enetc_psi_create() fails, we call
> enetc_psi_destroy() when we shouldn't. This will likely result in
> crashes, since enetc_psi_create() cleans up everything after itself when
> it returns an ERR_PTR().
> 
> Fixes: f0168042a212 ("net: enetc: reimplement RFS/RSS memory clearing as PCI quirk")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/582183ef-e03b-402b-8e2d-6d9bb3c83bd9@moroto.mountain/
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


