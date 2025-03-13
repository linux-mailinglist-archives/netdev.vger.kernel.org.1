Return-Path: <netdev+bounces-174557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A9A5F3C0
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1001886E79
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19E2661B1;
	Thu, 13 Mar 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cxtf4Fgu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E67262D38
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867545; cv=none; b=NKhUXtZ6Th0chlCEGFB5z6mbZeLJj9x8V9u2qGRl5mDps/YbLuqUR2wQw9UcF7EoYepR10WvGPRp5C4bMqB6U/6DGvpp1IsbkT6Ipj+rddq05OW4zZ5MPDLMNUMBmOmToELPNNDkuvx/AkeSZnPjKq8CCnOwXUZqWCrJVviafH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867545; c=relaxed/simple;
	bh=pTlzgNMAKbijr9k+5bhUs93WTLaCvWvkLWdxtUV6pco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXh1p0swpQVc9LIzkumtEygM0duqKtiDBz3dlsnILfe7h0ni0CizTjR7a4cyJPZKlfRAKk7vDc/pYpgh0V49XvNtnT+QaF16I8LjrvJHi37qVVfnJsjoO8DxzOzyiKRLAb6YF0hc+8JAYI6BBTp2D29pF608cnQZn5hgHyerusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cxtf4Fgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6B8C4CEDD;
	Thu, 13 Mar 2025 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867545;
	bh=pTlzgNMAKbijr9k+5bhUs93WTLaCvWvkLWdxtUV6pco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cxtf4Fgu6Pva2dLxRg6S7OuXk2J5Ic/At4Xz8yZL5w8znUGFF8vw1Qff4s7usNzMp
	 9a6KAKFpGV9qMQXaLNIf5ZZQwwKNJ2lA+EpBk1UXjT45CNYq4dp/Hr/UJ1yp/+mN7l
	 UwvHeWGcvK3nxxiSO+Pr9NB9aE4r1ss2BYnD8orvttffAsCtOxyvHCu3CNMKhdo1bw
	 rXaz02EUXJ9MnB/pnqrghtuqNVXbSaLmF0CajpeqgAP4uw1eUesicilwRMqUzWoC7c
	 l4l0r4lemQJLJzbGQdTabAFVAjkkoeBhFRV/VlNff38CLRi59PAQAduVovLCGph0tS
	 DCs/KUSaVOvaw==
Date: Thu, 13 Mar 2025 14:05:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chiachang Wang <chiachangwang@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	stanleyjhu@google.com, yumike@google.com
Subject: Re: [PATCH ipsec-next v5 1/2] xfrm: Migrate offload configuration
Message-ID: <20250313120538.GJ1322339@unreal>
References: <20250313023641.1007052-1-chiachangwang@google.com>
 <20250313023641.1007052-2-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313023641.1007052-2-chiachangwang@google.com>

On Thu, Mar 13, 2025 at 02:36:40AM +0000, Chiachang Wang wrote:
> Add hardware offload configuration to XFRM_MSG_MIGRATE
> using an option netlink attribute XFRMA_OFFLOAD_DEV.
> 
> In the existing xfrm_state_migrate(), the xfrm_init_state()
> is called assuming no hardware offload by default. Even the
> original xfrm_state is configured with offload, the setting will
> be reset. If the device is configured with hardware offload,
> it's reasonable to allow the device to maintain its hardware
> offload mode. But the device will end up with offload disabled
> after receiving a migration event when the device migrates the
> connection from one netdev to another one.
> 
> The devices that support migration may work with different
> underlying networks, such as mobile devices. The hardware setting
> should be forwarded to the different netdev based on the
> migration configuration. This change provides the capability
> for user space to migrate from one netdev to another.
> 
> Test: Tested with kernel test in the Android tree located
>       in https://android.googlesource.com/kernel/tests/
>       The xfrm_tunnel_test.py under the tests folder in
>       particular.
> Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> ---
>  v3 -> v4:
>  - Rebase commit to adopt updated xfrm_init_state()
>  - Remove redundant variable to rely on validiaty of pointer
>  v2 -> v3:
>  - Modify af_key to fix kbuild error
>  v1 -> v2:
>  - Address review feedback to correct the logic in the
>    xfrm_state_migrate in the migration offload configuration
>    change
>  - Revise the commit message for "xfrm: Migrate offload configuration"
> ---
>  include/net/xfrm.h     |  8 ++++++--
>  net/key/af_key.c       |  2 +-
>  net/xfrm/xfrm_policy.c |  4 ++--
>  net/xfrm/xfrm_state.c  |  9 ++++++++-
>  net/xfrm/xfrm_user.c   | 15 ++++++++++++---
>  5 files changed, 29 insertions(+), 9 deletions(-)
> 

I already posted it, but let's repost.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

