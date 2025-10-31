Return-Path: <netdev+bounces-234563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A185BC23041
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 03:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49A21890170
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A732E9EA0;
	Fri, 31 Oct 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHA9542l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317B2BD580;
	Fri, 31 Oct 2025 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877830; cv=none; b=XuLxHBFIj4R8iA2D+svJvrckyNmtBYWZ+eoQa+eQrzDSiSnerZSzlzwxPZWzf+4YBEoaSuoowDPVzPdyoura9MtIZWX8zo2+UtlNF0gbyxsJ8w34kVe7CIEEjo0ek5eoOvEbODsDEoVDjL/i+LT1Yqa1SovOZfkQpZKF+fMN90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877830; c=relaxed/simple;
	bh=lPEse3zhfk1wp62kzqbz5Az1PznlZpNxU/0H91XiNPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E6q32qxxdWM289A+906fmDN35plq2UpYqAvXabmdNvKwEterVLDKKWskoGJOGjhfEXbozBQCF5ui/apgm70Kib/1xOEwO/3D44d2CyTP53K/xb2WE87Es/eEz/VkydkXQBtvHKpCjc7qJJRQZvgiFeKAUcC5dSROij4u2gggk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHA9542l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5A8C116C6;
	Fri, 31 Oct 2025 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761877829;
	bh=lPEse3zhfk1wp62kzqbz5Az1PznlZpNxU/0H91XiNPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oHA9542l+urU/JDRKipepaulKhtb/xMgXBfJ0Ef7W0nOCoFFKfPAAj8n05YIlwfBt
	 6gkTTwWZg/RJ+f64YFtQnHO+3FxgT1Y0iVNloJQ1VMstt8RrVy88EwVyJGOPDBGV4U
	 RiIWMRrqM5lmzwSZ94ig2YlnzHO7CHFIckAXufi38SXUd2T2w7ExOiDGURr0xZHgzQ
	 wkSVSaY/RJsQn6HBkmjxMk893L4T4hNoLyJkFpPItBLlNr5MdfvorySC0xhdP8YqQs
	 u4DQ/DE63ebQqtQtO0/Jr/ZnApniJXV7iMLj8DMaBwQk599xtWPNMKl1JJrUHJlcQ7
	 kc3A6aXwhOLRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCE3A78A72;
	Fri, 31 Oct 2025 02:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cxgb4: flower: add support for fragmentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176187780626.4112535.5971843180740890072.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 02:30:06 +0000
References: <20251028075255.1391596-1-harshitha.vr@chelsio.com>
In-Reply-To: <20251028075255.1391596-1-harshitha.vr@chelsio.com>
To: Harshita V Rajput <harshitha.vr@chelsio.com>
Cc: kuba@kernel.org, davem@davemloft.net, kernelxing@tencent.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, bharat@chelsio.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 13:22:55 +0530 you wrote:
> This patch adds support for matching fragmented packets in tc flower
> filters.
> 
> Previously, commit 93a8540aac72 ("cxgb4: flower: validate control flags")
> added a check using flow_rule_match_has_control_flags() to reject
> any rules with control flags, as the driver did not support
> fragmentation at that time.
> 
> [...]

Here is the summary with links:
  - cxgb4: flower: add support for fragmentation
    https://git.kernel.org/netdev/net-next/c/0d0eb186421d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



