Return-Path: <netdev+bounces-200456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C49AE587D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148337A5392
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137411DA21;
	Tue, 24 Jun 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AURB3tnt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39FB14286
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750724389; cv=none; b=DpGI+/BeFIFsfgZH1qGqA2P468GcLSe653Qb8Oe9zwlO6Q338vjtoJRkSFTtfIvWHsTNJO0xKPQiZbOapnr15u8jqVD6awlpWJasrbtrX16LUjRUSwgep6G4c+1QWm4ymi36HTsqQz1CyaFwQb6hbxeHQjFZtydVp2bbJywVmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750724389; c=relaxed/simple;
	bh=E//y0Zn37uKT5BncWdH76l3vUfXvnuJYuA5ZcdMnOG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AUXXetXEynhkgubEu7w/HwgBRY2r1uj/ZqTl8SKxx+kPK1AzfLxldeDKPCycqN6k0FsLEZl5jLv0xXPnNJrYrYggx8tdEtrASQI/kYsV0kgsJ+dhRD5JZa9nAGUxfmrPJBEL9ISIUUCnl52uoQIDHZLZYciOe6is6IqtL/h3K/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AURB3tnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70454C4CEEA;
	Tue, 24 Jun 2025 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750724388;
	bh=E//y0Zn37uKT5BncWdH76l3vUfXvnuJYuA5ZcdMnOG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AURB3tntTqFbYDMDo8souEnKWGOUdAuZl8Y01JvCLD3686gNT8IEuc9sg8ysqYkot
	 bvlYun8xTC9nVkgF/MM1cG49RNGHxJIHaiGKoXFrmVrS4fY9aXCz5fyhQyHLL9dy47
	 KjcPa5sY/WXuCyp9fmosdgxXWIM+pgxsBC5JlyJXKRIBlrnXid5z1q5i5DPcwLNunt
	 4EynUEolE0910SX95xFNmXx6M6n68cw/vBHfDWrdNfyKD7DtqF/AdEYi2Oj4lO7eJB
	 EvxkfoasnaDz/tPx1RzWDiyDUQj7LfvFW1bE2BABJxpvpFETDhDCcj98SVlXSonmku
	 H0G68X2j+MdHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF5339FEB7D;
	Tue, 24 Jun 2025 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: replace sock_i_uid() with sk_uid()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072441550.3341634.468993853992894005.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:20:15 +0000
References: <20250620133001.4090592-1-edumazet@google.com>
In-Reply-To: <20250620133001.4090592-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 lorenzo@google.com, maze@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 13:29:59 +0000 you wrote:
> First patch annotates sk->sk_uid accesses and adds sk_uid() helper.
> 
> Second patch removes sock_i_uid() in favor of the new helper.
> 
> Eric Dumazet (2):
>   net: annotate races around sk->sk_uid
>   net: remove sock_i_uid()
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: annotate races around sk->sk_uid
    https://git.kernel.org/netdev/net-next/c/e84a4927a404
  - [net-next,2/2] net: remove sock_i_uid()
    https://git.kernel.org/netdev/net-next/c/c51da3f7a161

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



