Return-Path: <netdev+bounces-205220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FFAFDD31
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE5658069F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E6619C553;
	Wed,  9 Jul 2025 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meL+6207"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9249625;
	Wed,  9 Jul 2025 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026388; cv=none; b=KSBMENpIAdLIv71wQ3o02AWfEzGfCn+x0JejZOH+vK8e1cimqSSr48+TSPFYg4w/2fFlYU40DumIQS9gCf/4CYt3hJ8uId1GeI4IlDUS47c2Yhv+v4xaVwnNmYa4nmyabsmEWkfjpI1EAhyA5n1a/ar/ZVnC+9MM0g6HTXsKeyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026388; c=relaxed/simple;
	bh=iwE9ARpaM6sjLNPYdGBMwXNgkssGsBxoP/cDtzcIsdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RYEAyZNsy0fI1yclhzmrlGMS6npGGZI43GENaoS0MiLQ0g9+Z9HKGL2F5Qwjvk8WAEXuOD273pgOaZQYkOtnNkIMJ9PSZILQDXkY7+GTVJxgJ/Afw0+JL24jNM0Y4YK7d/mF/79zaVWFhCy5km+XuFQhRXhLTP2Wq5NgcOomZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meL+6207; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CBCC4CEED;
	Wed,  9 Jul 2025 01:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752026388;
	bh=iwE9ARpaM6sjLNPYdGBMwXNgkssGsBxoP/cDtzcIsdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=meL+6207UGZ83PCRYpI7IC0nqosJcljyLYCQ94YWf7FkW1qxYkJlnhg3GqK4o2Y2X
	 m7mbElRiCgp3rYZ3VfjasDN2P+Y7qkFT6FiPj7z61yL8gwknpPb1L4fKnzsBSRICfv
	 w+xU1swc8+oyFvxd0/Ec4sn0Ym9qGJ7xpELNqAcDZkSN7XodoJVdSn6hlzjtgfFPyq
	 95zhxmawQxgMHOICQbAIz+7FwSCZb45/nBvlDpE4imureVNUHVZ4mTbPxc5Cu7g3eA
	 gZfYD+YuiP6rme9ysusAN0/nUgczzhVl2SGHMnoQkMqDkMf6PsXpTHRq2d4DgpvkMa
	 tsKF7x72f18Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0DC380DBEE;
	Wed,  9 Jul 2025 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dt-bindings: ixp4xx-ethernet: Support fixed
 links
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202641059.192708.17191274231375047755.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 02:00:10 +0000
References: 
 <20250704-ixp4xx-ethernet-binding-fix-v1-1-8ac360d5bc9b@linaro.org>
In-Reply-To: 
 <20250704-ixp4xx-ethernet-binding-fix-v1-1-8ac360d5bc9b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 04 Jul 2025 14:54:26 +0200 you wrote:
> This ethernet controller is using fixed links for DSA switches
> in two already existing device trees, so make sure the checker
> does not complain like this:
> 
> intel-ixp42x-linksys-wrv54g.dtb: ethernet@c8009000 (intel,ixp4xx-ethernet):
> 'fixed-link' does not match any of the regexes: '^pinctrl-[0-9]+$'
> from schema $id: http://devicetree.org/schemas/net/intel,ixp4xx-ethernet.yaml#
> 
> [...]

Here is the summary with links:
  - [net-next] net: dt-bindings: ixp4xx-ethernet: Support fixed links
    https://git.kernel.org/netdev/net-next/c/f7728ea83771

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



