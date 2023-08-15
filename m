Return-Path: <netdev+bounces-27610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E08777C88E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29071C20C74
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8224A95F;
	Tue, 15 Aug 2023 07:31:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA4185D
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBE1C433C7;
	Tue, 15 Aug 2023 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692084659;
	bh=2NZFDepYdzNczFU1DvSaLc7wYtMngHgdqKawoMYLupk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5NlC/mhWgI05moCLPXKDX8mMesFU5ON2J9wvHRkjn4+rIBRmu4aKS7cV+PRwwpyc
	 JMRKIG5Pt4p6byka+sG9ZA/UaICPzctpBV9mDElYuI43bNdwjJ+QztPHw/sj7sN7UI
	 x5BbIn7Zi2qmUDpuV9oCwUWWj5sUJPQ+JN7bF+nmmpdxCfak7EDjroqvKehGu3D5c0
	 KEZ73QzWj02u8drn6pvLVReiosYnGz0q36bFd7JCekkuKvMx5DQIUK459DxtTno/gT
	 OG/GfMZDyvhy8j9K4cURTgso38OoeGsp9R4Dzq9FeFr1QSbtzB/otkAghgypp07ok7
	 DZiitViX+XpTg==
Date: Tue, 15 Aug 2023 09:30:55 +0200
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: rdunlap@infradead.org, benjamin.poirier@gmail.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org,
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v6 0/2] netconsole: Enable compile time
 configuration
Message-ID: <ZNspr0OlEKGD3K9c@vergenet.net>
References: <20230811093158.1678322-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811093158.1678322-1-leitao@debian.org>

On Fri, Aug 11, 2023 at 02:31:56AM -0700, Breno Leitao wrote:
> Enable netconsole features to be set at compilation time. Create two
> Kconfig options that allow users to set extended logs and release
> prepending features at compilation time.
> 
> The first patch de-duplicates the initialization code, and the second
> patch adds the support in the de-duplicated code, avoiding touching two
> different functions with the same change.
> 
>   v1 -> v2:
> 	* Improvements in the Kconfig help section.
> 
>   v2 -> v3:
> 	* Honour the Kconfig settings when creating sysfs targets
> 	* Add "by default" in a Kconfig help.
> 
>   v3 -> v4:
> 	* Create an additional patch, de-duplicating the initialization
> 	  code for netconsole_target, and just patching it.
> 
>   v4 -> v5:
> 	* Remove complex code in the variable initialization.
> 
>   v5 -> v6:
> 	* Return -EINVAL for invalid configuration during
> 	  initialization.
> 
> Breno Leitao (2):
>   netconsole: Create a allocation helper
>   netconsole: Enable compile time configuration
> 
>  drivers/net/Kconfig      | 22 ++++++++++++++++++
>  drivers/net/netconsole.c | 48 +++++++++++++++++++++++-----------------
>  2 files changed, 50 insertions(+), 20 deletions(-)

Thanks Breno,

thanks for addressing the feedback given for previous revisions.

Reviewed-by: Simon Horman <horms@kernel.org>


