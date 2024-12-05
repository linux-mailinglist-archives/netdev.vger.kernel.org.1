Return-Path: <netdev+bounces-149218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC819E4C98
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C2B1685C4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F991190462;
	Thu,  5 Dec 2024 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7ZTbSs/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976218FDDC
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733368820; cv=none; b=aSlrLulCNVb9E0v11TN/QRlffCr7yjycVIc3NfGuY6h9bZrltBGh9bS4ekWjeWMLcuP8yrc8CtdMe0g8C6SmyLNF1zvdjZaSPENEvSQlASGpdmrFxnUxPmEzLYZ3o4y/IxfwC44gseYi+eCcHWZ8kmQB9t21560scnxrteBowTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733368820; c=relaxed/simple;
	bh=wIvMxJC5t3IT7Kp/xXch/rmal1wb2Px4nnJIzQ3XB9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I+uY/7Br03IHpQK6zfrgPR1nU77SGfJil+gN2ZUj3vM0iAQKN4dWanlFK8U1k1S89aD4bK9m6deFLe/7yRqTCIqZGk6j+jix8VA2upj60AAT1o4RC93jl/cYumBIDvRUiq+9OEvP/LESgbdM4wLs1I5DTzRY/lGBnzoZxpOSlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7ZTbSs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2915C4CED6;
	Thu,  5 Dec 2024 03:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733368820;
	bh=wIvMxJC5t3IT7Kp/xXch/rmal1wb2Px4nnJIzQ3XB9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l7ZTbSs/a83sIoXe9Ch+qZftQ2Tmu8zrM5K6zGCzPHCCJB7ypjKEqoStjMpOBnEXv
	 czk6LUxApkCgiLmYPb4STcFPcXUcU05qcKM2cdi8YGKBIhrzGXKIKnYtHjAqNavfuH
	 St31L29AtG6N5DD9rdIZLKuvwOtvD0qpfiIoBTpdsXVUcpm6/PEyWVqU2yt3y3koYN
	 CXM3jGls2A4oi2xs1CIKSNrg63ur+LtlsN4fkSiaXy7F3j3Db49C38Vh1Joq8/bdUh
	 H+IvSLWbb04QMnZn0B3zcZ165dVclBjuN7gGkwyKr2jC5EpyygamIQoFuIjD/NuiLC
	 HCuKy26x3Kyqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE463380A951;
	Thu,  5 Dec 2024 03:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mlxsw: spectrum_acl_flex_keys: Use correct key block on
 Spectrum-4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336883425.1427062.9314238179895149893.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:20:34 +0000
References: <35e72c97bdd3bc414fb8e4d747e5fb5d26c29658.1733237440.git.petrm@nvidia.com>
In-Reply-To: <35e72c97bdd3bc414fb8e4d747e5fb5d26c29658.1733237440.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 amcohen@nvidia.com, idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Dec 2024 16:16:05 +0100 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The driver is currently using an ACL key block that is not supported by
> Spectrum-4. This works because the driver is only using a single field
> from this key block which is located in the same offset in the
> equivalent Spectrum-4 key block.
> 
> [...]

Here is the summary with links:
  - [net] mlxsw: spectrum_acl_flex_keys: Use correct key block on Spectrum-4
    https://git.kernel.org/netdev/net/c/217bbf156f93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



