Return-Path: <netdev+bounces-57839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B846E8144C0
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADD11C209ED
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223641805D;
	Fri, 15 Dec 2023 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7KH7koc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045D18AE8;
	Fri, 15 Dec 2023 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84DBDC433C9;
	Fri, 15 Dec 2023 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702633224;
	bh=DBz9wtE7RjeSYiKG1ce4EE+S157hUpSa+u6pWZ6ST9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D7KH7kocevc6DNtXPXsqTrqaqIPQZG0XEAEJdLmRHeHPG8UrfNtCIp5biNlppKVhh
	 D6LPndpdR3AS1jtcYRQaBFosA52s+I6Wqjt2SkTMA9xnfko6UVztfFmNBe9GW+feP/
	 BwmSdm3NSIxelKGMsiF6/+EPggfu7q+ruTcBVsvQ33iXqWNlkLNcsJNv5Fo6W4aIq9
	 vKGWVGzhWqrHoPH6T4Zv4cFzs1432HZktTlbNM0EUe+cW9RtehaxUYkvjEYJ94F7VZ
	 ljpYZZXB3s3gLyA6OkWZ+guGhWPOe518rYSC8zAIlpK7NaHAR8UENKBe+A+MARfLhr
	 zdNCufzR+PoFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E4A7DD4EFD;
	Fri, 15 Dec 2023 09:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/4] Rust abstractions for network PHY drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263322444.1975.17234929609368010648.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 09:40:24 +0000
References: <20231213004211.1625780-1-fujita.tomonori@gmail.com>
In-Reply-To: <20231213004211.1625780-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Dec 2023 09:42:07 +0900 you wrote:
> No functional change since v10; only comment and commit log updates.
> 
> This patchset adds Rust abstractions for phylib. It doesn't fully
> cover the C APIs yet but I think that it's already useful. I implement
> two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
> they work well with real hardware.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/4] rust: core abstractions for network PHY drivers
    https://git.kernel.org/netdev/net-next/c/f20fd5449ada
  - [net-next,v11,2/4] rust: net::phy add module_phy_driver macro
    https://git.kernel.org/netdev/net-next/c/2fe11d5ab35d
  - [net-next,v11,3/4] MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
    https://git.kernel.org/netdev/net-next/c/cbaa28f970a1
  - [net-next,v11,4/4] net: phy: add Rust Asix PHY driver
    https://git.kernel.org/netdev/net-next/c/cbe0e4150896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



