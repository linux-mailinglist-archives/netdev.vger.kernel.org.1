Return-Path: <netdev+bounces-66406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040A83ED77
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 15:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D356B1F22867
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68772030B;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb3Cd3eM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CE13FF0
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706365829; cv=none; b=pvnKhSjgch3wVYKfWSUuGanWh+lkRCYSr/en+FrObNDyDQej42NbLvuxpw73e+6kB6BlUEAVe9rHBG+IG2MdxRKUtc7RtENSgzXQG83wFuHd3S99W3ZZUJz+skhX13MTKo4X2gzNdMoZBT8pMZk3cLLj8/9g32TFs688nY69q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706365829; c=relaxed/simple;
	bh=rnHfKoziyPOCV9fVEANd+WdpO1eNT58+M0fShj7Qz3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gMYtWvB2Mm2rXXhqv1KVO+V9BoNgAOPDhqVcKogeUWiQ2zjoQaJD13WoQtJrVuETi78vVgv6Py0yWyNXQD1056QlXYDCIIYMpFhXdpVvK4HWtJi1K1tXoZFRXgjlDXWF7j6hPWO4t+xnrFwcLkKsj9+oj2762chARsoX5G92dSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb3Cd3eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25E5BC43390;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706365829;
	bh=rnHfKoziyPOCV9fVEANd+WdpO1eNT58+M0fShj7Qz3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mb3Cd3eMeDyuRdCdgqJ7ifgm72LvaTU4lWBuD2u7trX7jUqtwecGTFMbLXOIwb0aA
	 7vcjyt9kW7QTp61Exh1JPNl+BhmFKWLOdiAcyfkBNH/ANnja8bWeH6qd8+k3nF04Tr
	 p03rcW7SQzxHgla3D0/gVQmgAozYf++KY1vkkqzchOE/8XcBUzYbe2rLBpR6mAIKDj
	 Z3UNDdpOInP3FMsvpaKzQYYlIjEg1K84RGqCIqMTCv4ZnmzY+WXKkzO3S8hJWYhvLs
	 1w+5E9eX/LpUj/21L6A8fFoqoKDO2aAeIAcAK1Bp63gJRFUGXgSyDt8mDW8TO+DDpQ
	 Xlov0dBmV+hIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C667DFF760;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: mlx5.rst: Add note for eswitch MD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170636582904.20177.2855181351388263534.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 14:30:29 +0000
References: <20240125040041.5589-1-witu@nvidia.com>
In-Reply-To: <20240125040041.5589-1-witu@nvidia.com>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 24 Jan 2024 20:00:41 -0800 you wrote:
> Add a note when using esw_port_metadata. The parameter has runtime
> mode but setting it does not take effect immediately. Setting it must
> happen in legacy mode, and the port metadata takes effects when the
> switchdev mode is enabled.
> 
> Disable eswitch port metadata::
>   $ devlink dev param set pci/0000:06:00.0 name esw_port_metadata value \
>     false cmode runtime
> Change eswitch mode to switchdev mode where after choosing the metadata value::
>   $ devlink dev eswitch set pci/0000:06:00.0 mode switchdev
> 
> [...]

Here is the summary with links:
  - [net-next] Documentation: mlx5.rst: Add note for eswitch MD
    https://git.kernel.org/netdev/net-next/c/6f83b62283ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



