Return-Path: <netdev+bounces-127194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE7B97487B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7011E1C20FD8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D52D7B8;
	Wed, 11 Sep 2024 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXXtCxck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1D18651
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726024239; cv=none; b=bkn7WOVejUY/yX4Ta60hsUg9//Nzwwm/whvvvW9VbIXRcRLKQgvmiuo4P2zTD8dwaIkXrIrze7gO1RJR8FN+n9eiQWYin4OZFp9l439TV4VFGsaUsiIedR3oLy3S74/EOH1F0C1XFYDCpixGZag5y1UH9PEDemxWmqy99V9YE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726024239; c=relaxed/simple;
	bh=SQJDic4Fs6xsFy/vyztbdNdWHJvOHDUMksVDGwa1pp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bMQa2LHahM2Y0EqWFwbv7IaZLDi3UZ3WFvha3Fb5CYvTCmIdUvs0M3dndQzhS6L5FwL/gRB6UE+9LTmcRJO0Ayt0OpQvrDcYz0nFbexKiKJY+uDI8IjzyrRLOiyOIkpPSojGUn1J80BFJTo5jItXNkR6JI1IdcBAzYE4EcVDX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXXtCxck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359A4C4CEC3;
	Wed, 11 Sep 2024 03:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726024239;
	bh=SQJDic4Fs6xsFy/vyztbdNdWHJvOHDUMksVDGwa1pp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NXXtCxckRVb+onmNYSDKvIsF2vpfSg6fg6AIqxba1YKqRwwxFm0aobHbaYdiIIyGc
	 cVtNw30HP2sSMH2Opvq2HjptbEYZtRprJVF6znh8pGBcvuY6AOt1VLZN1HrnX6lmbM
	 H3B5G5mEQevFLZJD2xzO5gdnefIiK07o9Wkh2WGekC9yAKPWgcDTRw42AuVtQx+2BO
	 et+YTi+rJXHfUQW/Mtarvua9QZ78UVRQ+kfJjfSR8L/x9dwitPn39ec5iUl+L7/SzM
	 JYxBVGtzAeDsBGUMzyTK0RaOTQXsKHLfs00GeXfSZQcqi6dZC1CPTFCa8Iu7xvXJso
	 /HDoT5fUZp5nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6A3822FA4;
	Wed, 11 Sep 2024 03:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V4 01/15] net/mlx5: Added missing mlx5_ifc definition for
 HW Steering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172602424028.471616.16090068542588503213.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 03:10:40 +0000
References: <20240909181250.41596-2-saeed@kernel.org>
In-Reply-To: <20240909181250.41596-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, kliteyn@nvidia.com,
 hamdani@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Mon,  9 Sep 2024 11:12:34 -0700 you wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Add mlx5_ifc definitions that are required for HWS support.
> 
> Note that due to change in the mlx5_ifc_flow_table_context_bits
> structure that now includes both SWS and HWS bits in a union,
> this patch also includes small change in one of SWS files that
> was required for compilation.
> 
> [...]

Here is the summary with links:
  - [net-next,V4,01/15] net/mlx5: Added missing mlx5_ifc definition for HW Steering
    https://git.kernel.org/netdev/net-next/c/34c626c3004a
  - [net-next,V4,02/15] net/mlx5: Added missing definitions in preparation for HW Steering
    https://git.kernel.org/netdev/net-next/c/00b9f0daefd7
  - [net-next,V4,03/15] net/mlx5: HWS, added actions handling
    https://git.kernel.org/netdev/net-next/c/504e536d9010
  - [net-next,V4,04/15] net/mlx5: HWS, added tables handling
    https://git.kernel.org/netdev/net-next/c/71a1372b8275
  - [net-next,V4,05/15] net/mlx5: HWS, added rules handling
    https://git.kernel.org/netdev/net-next/c/49674803542c
  - [net-next,V4,06/15] net/mlx5: HWS, added definers handling
    https://git.kernel.org/netdev/net-next/c/74a778b4a63f
  - [net-next,V4,07/15] net/mlx5: HWS, added matchers functionality
    https://git.kernel.org/netdev/net-next/c/472dd792348f
  - [net-next,V4,08/15] net/mlx5: HWS, added FW commands handling
    https://git.kernel.org/netdev/net-next/c/0869701cba3d
  - [net-next,V4,09/15] net/mlx5: HWS, added modify header pattern and args handling
    https://git.kernel.org/netdev/net-next/c/aefc15a0fa1c
  - [net-next,V4,10/15] net/mlx5: HWS, added vport handling
    https://git.kernel.org/netdev/net-next/c/6c5e68254027
  - [net-next,V4,11/15] net/mlx5: HWS, added memory management handling
    https://git.kernel.org/netdev/net-next/c/c61afff94373
  - [net-next,V4,12/15] net/mlx5: HWS, added backward-compatible API handling
    https://git.kernel.org/netdev/net-next/c/2111bb970c78
  - [net-next,V4,13/15] net/mlx5: HWS, added debug dump and internal headers
    https://git.kernel.org/netdev/net-next/c/d4a605e968e7
  - [net-next,V4,14/15] net/mlx5: HWS, added send engine and context handling
    https://git.kernel.org/netdev/net-next/c/2ca62599aa0b
  - [net-next,V4,15/15] net/mlx5: HWS, added API and enabled HWS support
    https://git.kernel.org/netdev/net-next/c/510f9f61a112

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



