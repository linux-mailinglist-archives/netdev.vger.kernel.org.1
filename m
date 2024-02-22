Return-Path: <netdev+bounces-73860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3885EE8F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1307A1F224E5
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B411CBC;
	Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbjuUCwm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC27111AC
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564829; cv=none; b=gnB3ZLKNzkal4nNp/6STSvFy9ou0rZF/MRTcMVG6ruh50wyg6/xMVODh3s4DcUhF17m2Kj1g2G+39oNSNJtylnfIiucqPPyiK+rP/tGejrb4EKW4jyEs1DCatDDF/mk6mGMdazB27rCd5vfnvyIbQDjdXwbH3WKCuk8PQPoZmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564829; c=relaxed/simple;
	bh=cv2oEZKKue+9awMYzKfRhJHIh5LbRD07ZOzDZhGdRfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W9+z3n1H1Y3OL10TvPHXckh00f/ny0YfEiVF359k0bBIpwHRuQth+BEd5KiM5ONNbboXj8Z/dr6++s/b42nd/gjDoCYto2oy/GNt4qxl1bdDLTgITLbJVu4dq42V9uyI/l4QGThknvLZB3sCJ+/XHpxzSJ6rnzBt/DnZzu/jEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbjuUCwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A15F3C43390;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708564828;
	bh=cv2oEZKKue+9awMYzKfRhJHIh5LbRD07ZOzDZhGdRfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SbjuUCwm0e/SH7vKy7Tf6VKgTQDr82l2Mib+dfMZ9WDqf0hOyPbBlP98yTNgKhEg2
	 y+opBGPQZhvqYE/XGCJuWBKri+6UCJENBzOrwd9a4T6ofEj1KFHX5teqLYOdoSNvvD
	 dOujeHOEK+8PtsapfX7AqQtmVBQBaQIThPD1afTBE5bDhql/P/cL/r2Vw0kXrhmwJs
	 WzdkmQKMiLGspLZumGQhoGu0uny5b+hZer1aF4D7iQFV+Ye9qxSiSAPlnZfejc+yO/
	 ror56l9eDK5JbsWQZ/XZvn/rJEwA+gDX5ZwPUpq3RbnjbC8TeHt6b/LqSgbW0ZhZCu
	 RnGbhjOUBJAbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89E20C00446;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] tools: ynl: fix impossible errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170856482856.21333.10100247859016276067.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 01:20:28 +0000
References: <20240220161112.2735195-1-kuba@kernel.org>
In-Reply-To: <20240220161112.2735195-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, chuck.lever@oracle.com, jiri@resnulli.us,
 nicolas.dichtel@6wind.com, willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 08:11:10 -0800 you wrote:
> Fix bugs discovered while I was hacking in low level stuff in YNL
> and kept breaking the socket, exercising the "impossible" error paths.
> 
> v2:
>  - drop the first patch, the bad header guards only exist in net-next
> v1: https://lore.kernel.org/all/20240217001742.2466993-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] tools: ynl: make sure we always pass yarg to mnl_cb_run
    https://git.kernel.org/netdev/net/c/e4fe082c38cd
  - [net,v2,2/2] tools: ynl: don't leak mcast_groups on init error
    https://git.kernel.org/netdev/net/c/5d78b73e8514

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



