Return-Path: <netdev+bounces-53270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A615801DD9
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 17:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9511C208DF
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F99168BF;
	Sat,  2 Dec 2023 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZoOTDXN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8C3D82
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 16:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD44C433C9;
	Sat,  2 Dec 2023 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701535709;
	bh=DnZEzNXP9hV68Bv4xg8L4T2Cgy7MhrlHkGJzKWd0Rog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZoOTDXNOwfGy+XbS4lGBQnlNtfStPpSe6XOuqQbxnbXDAUBoZaxsBOXb2D0e9dmu
	 C7p8JBEBYJRi0f0bK+IiWqwRZivi4i7Yep2WYel8lRjn8pg/WNx16abD/9vaSwAyAR
	 k4GatGF7Xw7DiyvOAZMGPkwt6A+K+y//RaCLR9ncjQMGdaNL+aqaolGYgZJKoIem/6
	 fMHcyTIbpba7xUZLqzio6tpm7HN3f4iXQsM8BLAQs6HGWp7wxz0PXN6ghbQEEtNMDe
	 NZa3CQKerGMXmPiMF4YfSgJAGp7mYigBA8NEINbq3X72XTGMZRY5/a/Q6TV9VTNUxc
	 NDJVm2GW1LVYQ==
Date: Sat, 2 Dec 2023 16:48:24 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] i40e: Fix ST code value for Clause 45
Message-ID: <20231202164824.GA50400@kernel.org>
References: <20231129161711.771729-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129161711.771729-1-ivecera@redhat.com>

On Wed, Nov 29, 2023 at 05:17:10PM +0100, Ivan Vecera wrote:
> ST code value for clause 45 that has been changed by
> commit 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
> is currently wrong.
> 
> The mentioned commit refactored ..MDIO_CLAUSE??_STCODE_MASK so
> their value is the same for both clauses. The value is correct
> for clause 22 but not for clause 45.
> 
> Fix the issue by adding a parameter to I40E_GLGEN_MSCA_STCODE_MASK
> macro that specifies required value.
> 
> Fixes: 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks Ivan,

I agree with your analysis and this fix looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


