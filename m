Return-Path: <netdev+bounces-127875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE6976EC6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD3F286A10
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1591BA27E;
	Thu, 12 Sep 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5KbPoHP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458F1B9B33;
	Thu, 12 Sep 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158791; cv=none; b=kWTrzgalaO0vn05WpMqJIiQeUUbWNh69r+P6pDnyF6DE38ruTmfi9RtWnHItNdD+WtKbdJ2DiLc28IjhHo/WW0J1YjLsj/wBJk4QTtorDLouGs6iJ3o3GlrEiVHfK685zZ2QjTrj8ygM/Bjx9ARJVGTyGoHjIMplAuATdTNKUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158791; c=relaxed/simple;
	bh=kg9bQEmh6+n7yuTtLUfLR9/UZPbKJC2JEyK4nXkHhH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PQz7oXmPDLvqMbbva1v/ishHI16YRN9hPJ/xSWTqTeuVWIPf87F3ia+3Li9xhI0v07UkD9/U7kYW55KER77I6PnL7T+ezqC8lcEUZ6mK2LjL0vdXqC1Z2CaRI4frfkSLTH5CLjpdzuu6wle/HmK7guUa9Vc3NA7RNkI7hQsxNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5KbPoHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000FAC4CEC3;
	Thu, 12 Sep 2024 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726158791;
	bh=kg9bQEmh6+n7yuTtLUfLR9/UZPbKJC2JEyK4nXkHhH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p5KbPoHPQUYPa1TnhhQfsgVIFprQ8UUMy14amfBNLbLoaUkk3FGNYTcL9JSZFI3LA
	 Num3AQBnTQNhf/gp2OTm8jFQJaKrVq75UV9Xx1wB48qS+jBj2O7sbxSEu1Co07yWnL
	 972XIz6cB4QCautTsvshoN7TSMWIwJINz2WYj0gqbAyj0HOSiYgPzN1gR1+qI1svAF
	 6qniwRZ5Oh68mCCeMUp705XdPWZMWzDikQArfslVJ2pQa9AalZhFFJZQO9+ZIKKflZ
	 Ta6o1zXj00IkkDgNTVhQeNCQVpdd7gD4JJd4Quq6SjP98cG17JXhTR3dIS4HvQfo1u
	 KXcM1STUhgBpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD73822D1B;
	Thu, 12 Sep 2024 16:33:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-08-23
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172615879199.1648954.13776016691534059369.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 16:33:11 +0000
References: <20240823200008.65241-1-luiz.dentz@gmail.com>
In-Reply-To: <20240823200008.65241-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 16:00:08 -0400 you wrote:
> The following changes since commit 8af174ea863c72f25ce31cee3baad8a301c0cf0f:
> 
>   net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response (2024-08-23 14:24:24 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-23
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-08-23
    https://git.kernel.org/bluetooth/bluetooth-next/c/31a972959ae5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



