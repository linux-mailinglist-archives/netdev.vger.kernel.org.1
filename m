Return-Path: <netdev+bounces-44877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5497DA30C
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF841C21077
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB963FE5C;
	Fri, 27 Oct 2023 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B47Vdzda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA133FE37
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A472C433C7;
	Fri, 27 Oct 2023 22:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698444122;
	bh=j6s0akPwkoMXWKgIhoq2G0rk7zAEku7ly3SpTAlUBzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B47VdzdaSTLjFyRstiKn+VfBhkswUMRK4JLpyBrSTQjF/qbGcRJxlawdnIk+uQDdN
	 QM5rJ2OMSFwNhvqhqZ/N956k3DV6yA1e8zN+Xl5Urb3WiynuVEvI81ugCtO6F2wLdu
	 qrjER0y6jZ2byRVb4YRqWFuzCR1A0hG3Fjw/x7HEUymE83GHFZ+E6rGgradiycWCmm
	 Bzym/7NHDhSSzaD18ciTnnLnQz8hp+etSoaL0JCFfVRHAEwIFsMZRlvtr+Vex57K5J
	 qww71dtMQeDG9R5rziHpqcvHMpC0z2OsjUpasFahbpT5sZZN1nwORISOkTyH5MjDJr
	 o44t3jWiwGKfg==
Date: Fri, 27 Oct 2023 15:02:01 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <ZTwzWQxcEsziHrjW@x130>
References: <20231021064620.87397-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231021064620.87397-1-saeed@kernel.org>

On 20 Oct 23:46, Saeed Mahameed wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>
>
>v1->v2:
>  - Add missing Fixes tags
>  - Acked-by: Steffen for the xfrm patches
>
>This series provides ipsec and misc updates for mlx5 driver.
>For more information please see tag log below.
>
I will drop this series for now and send another one with out the 9 IPsec
patches until we decide what to do with those.

I will send another series today with mostly cleanup to mlx5 that will
include part of this series also.

