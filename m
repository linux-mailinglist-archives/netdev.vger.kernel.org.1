Return-Path: <netdev+bounces-38590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF997BB90A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF2928113D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418CA20B1D;
	Fri,  6 Oct 2023 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyXzPBiY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482179C3
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 13:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9523DC433C7;
	Fri,  6 Oct 2023 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696598757;
	bh=GK6+gdGAri1G6rozMe9+EwaIXQ9xuRPorgKW+tLw1L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyXzPBiYVRHBuL1QwV3tmCN0UqHukILJ3h4u8TxJvG9SgcfyjffCHRnrTkmecrBcI
	 Aq01AZUiCeZQIJc5233PU9okbYh1Bcm38ceGU1KtFnp7D9TV9NWx4rh2B6yH02w5ep
	 GoiwWthZ8JntltpZhFJhyVWfzBsrBJ6gs2izE1og9o0GfRszEET1xMjbAqAyzHLxL6
	 g7qrZZFt52GRRoulRee3sO9n9rMj7KiZMp93qoahLcY2rMXUQMI2iiB8QkuEQwcc8e
	 UE6GlyTi6Uq53a9ovcKOcnfTiQUsl7oRN/JEypGlOefT++3f2cGcnuv9I7XlJb9TVW
	 QJEiC4XDXMM6g==
Date: Fri, 6 Oct 2023 15:25:53 +0200
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2] ixgbe: fix crash with empty VF macvlan list
Message-ID: <ZSAK4eB2Wkl5RImI@kernel.org>
References: <ZSADNdIw8zFx1xw2@kadam>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSADNdIw8zFx1xw2@kadam>

On Fri, Oct 06, 2023 at 03:53:09PM +0300, Dan Carpenter wrote:
> The adapter->vf_mvs.l list needs to be initialized even if the list is
> empty.  Otherwise it will lead to crashes.
> 
> Fixes: a1cbb15c1397 ("ixgbe: Add macvlan support for VF")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Use the correct fixes tag.  Thanks, Simon.

Reviewed-by: Simon Horman <horms@kernel.org>

