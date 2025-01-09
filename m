Return-Path: <netdev+bounces-156722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF9A07991
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A27A064E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57739FD9;
	Thu,  9 Jan 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbTvbdmC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3892AD25
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433958; cv=none; b=SjNzO6NH9K7z+on6aaYjLCpd4Mf2NYraH9vB0erKu0yei/oj2ItYSFR7MRAv2Msa15BC7X8NS3kV52NfM/YZA8vftr/aurf6I58ZReaxjBDXQ9SdTlxSzEQL/5/HlzO2f5OpD6mm3pC0aLu5mPesL5JuB/hjIXtG9ZBd5mUgDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433958; c=relaxed/simple;
	bh=0m5AT6Yx5OYeVRmLQ1UmuC8mynEXYbXl0+5dT87EF4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMP5O6KlABdeLX/r0Hing+oxuKhfsTqcbw6nQOiz/F8+J/MnjCoAMGkfiJykdgLMRnuX6JLS3nUFaPpp5HEu2hdU/nNoBXgs37hv379snZf1rr2lHZqCD//fT1aRvqdk3MK0lCkD/+S07Yx1+nsSv7J8YaAborMcu037WZSXMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbTvbdmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABCAC4CED2;
	Thu,  9 Jan 2025 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736433958;
	bh=0m5AT6Yx5OYeVRmLQ1UmuC8mynEXYbXl0+5dT87EF4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbTvbdmCrbXkKuyqSp48YcHulv1KRCm1Ossf6TPzA9VSS8bXvr2ttLhQ7rttZRD/J
	 e08QnFiuA33UR5zBTeTcu07SH8zBawrFgWTH1gHqRuEaJyUM694auKbrMsIn/fqciM
	 WWggYSNqFPrJgHBfTUjFek5EdQz868g8GR99ZKZSl62UYapL70R/faFDXCKOn7XZbU
	 6gAmLim8wz/PwK9uOtLvx1ISHT3GjFJ1yy9UkslF7mM5QyiwrCNBd3uuVJ3RLFCx3l
	 qLubaa7ljrdjt2Ur/gUCMWSdb9gyeesOzYyWaJAZMzCxFkfipC96eWTRqly1T4RCIz
	 SHo9iprWC4M5A==
Date: Thu, 9 Jan 2025 14:45:54 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jmaloy@redhat.com, ying.xue@windriver.com
Subject: Re: [PATCH net v2 6/8] MAINTAINERS: remove Ying Xue from TIPC
Message-ID: <20250109144554.GG7706@kernel.org>
References: <20250108155242.2575530-1-kuba@kernel.org>
 <20250108155242.2575530-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108155242.2575530-7-kuba@kernel.org>

On Wed, Jan 08, 2025 at 07:52:40AM -0800, Jakub Kicinski wrote:
> There is a steady stream of fixes for TIPC, even tho the development
> has slowed down a lot. Over last 2 years we have merged almost 70
> TIPC patches, but we haven't heard from Ying Xue once:
> 
> Subsystem TIPC NETWORK LAYER
>   Changes 42 / 69 (60%)
>   Last activity: 2023-10-04
>   Jon Maloy <jmaloy@redhat.com>:
>     Tags 08e50cf07184 2023-10-04 00:00:00 6
>   Ying Xue <ying.xue@windriver.com>:
>   Top reviewers:
>     [9]: horms@kernel.org
>     [8]: tung.q.nguyen@dektech.com.au
>     [4]: jiri@nvidia.com
>     [3]: tung.q.nguyen@endava.com
>     [2]: kuniyu@amazon.com
>   INACTIVE MAINTAINER Ying Xue <ying.xue@windriver.com>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Likewise, I was not able to see any git activity since June 2022,
or mailing list activity since 2020.

Reviewed-by: Simon Horman <horms@kernel.org>

