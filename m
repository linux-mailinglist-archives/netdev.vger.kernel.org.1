Return-Path: <netdev+bounces-40932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECB77C91FF
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D801C20980
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB17E6;
	Sat, 14 Oct 2023 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSis4Kd0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D97E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA527C433C7;
	Sat, 14 Oct 2023 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697245821;
	bh=PVaD7CmLTUBd6K4WNVtUaCxsdNdlcU2IAOFVlyxl0aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSis4Kd0mVD905+VTMQp3LuVR2fMiGPEiaSAQfBuJclsJYEr8jkE87+mKiialvECL
	 SaQP8s/LAPGhjrKbzbhFDb53v5tB6axxuJhpfKPQDPXgNYgLqLqOfaaKhgGBhzLDdA
	 1mqRrCa1Bm0C1K4ShgRp5vNwVTQyiHiZoi3kty9CL/3zj28hT53mx9X6HvpgXfTC5q
	 7UhKyTn+1K+nOO3p6dNfntW0L+GQ/ILrf5Dy8F3StOEtY+DmCyPMKITkllZ3umyAvm
	 q+3fIJfDV5Hl81kR9e8gwbjV5BGDWk27xdBk2j9id4jW94mQ7EmS6EJLtIkItCa0WG
	 vl78UoDx5JgeA==
Date: Fri, 13 Oct 2023 18:10:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-10
Message-ID: <20231013181019.1c8540dd@kernel.org>
In-Reply-To: <20231012192750.124945-1-saeed@kernel.org>
References: <20231012192750.124945-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 12:27:35 -0700 Saeed Mahameed wrote:
> v1->v2:
>   - patch #2, remove leftover mutex_init() to fix the build break
> 
> This provides misc updates to mlx5 driver.
> For more information please see tag log below.
> 
> Please pull and let me know if there is any problem.

There are missing sign-offs on the PR and patches don't apply 
because I pulled Leon's ipsec branch :(

