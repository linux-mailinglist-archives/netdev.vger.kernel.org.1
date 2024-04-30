Return-Path: <netdev+bounces-92620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954748B8223
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005B12844D2
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F7A1BED89;
	Tue, 30 Apr 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNpn6BNP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88C1BED7A;
	Tue, 30 Apr 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513918; cv=none; b=NC6CfRch9NS34wJ0X+HzRVA24iHp3McyGNCUDXyVkvSJIlP52Xt2bMlghq24cDb2BqvWRptFvF2czgVmdr7STx9pfbHxE4FDhW8+GKK2ugteLA9KaWIlakphuvDRNK95kv5R+Rtym36qTc0hHiqFWQaPMXylYaod79wTMm40tAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513918; c=relaxed/simple;
	bh=+0rMFc8W9K6N8tTRcAbFLgTHxUGbC3wry46O1XEkCoE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bfRgwWwhZ7lfrqOzYCf8S4Yv8exNwcImFo537IdLYGxrBFPKq91oFrDPqmW4Wg1EcFEsGa2Nsj2I0torl10QMG6NG9/tKBf852K+31iHhmG2FyLmD7We7dQ9Gi4RpQlvFL+LtjEVq8x0zCIhfnVz7WI0lTHo8E9RGgpgyJ3f+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNpn6BNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EDE8C4AF19;
	Tue, 30 Apr 2024 21:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714513918;
	bh=+0rMFc8W9K6N8tTRcAbFLgTHxUGbC3wry46O1XEkCoE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KNpn6BNP23sWa+MZFKrEfAHnludgSYghf3qv04paljB3M4X9F7f/7u9eWNXeeTgpk
	 4ZMMe02FoEMUPo0S3Bcq4CsmQqaa9VR8fvd6pbrpdikooxeHZp4zi/8IHQHd46Dd6G
	 l0fYVw2QRV8tCyvS8KtQhEBIHR+oUdlJHQhj2naV4PZM0418/3IMjY1hwVa6SCMTa5
	 9N+But4kfEbcvOpgm9TWKZkeRsgpVmzPTfs+t5sJK9EUd5bOkVGd8Hou5Q6Alct/Sk
	 y/fH3+EKXAl+taQoGaK2qVLHtyPJk90Hydco4lzE5zu1tnMPCfGYLKQFSNdPisDHxO
	 68vZYQ3/l7yaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2EB1C43443;
	Tue, 30 Apr 2024 21:51:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-04-24
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171451391799.30746.13972006009899083304.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 21:51:57 +0000
References: <20240424204102.2319483-1-luiz.dentz@gmail.com>
In-Reply-To: <20240424204102.2319483-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 16:41:02 -0400 you wrote:
> The following changes since commit 5b5f724b05c550e10693a53a81cadca901aefd16:
> 
>   net: phy: mediatek-ge-soc: follow netdev LED trigger semantics (2024-04-24 11:50:49 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-04-24
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-04-24
    https://git.kernel.org/bluetooth/bluetooth-next/c/e6b219014fb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



