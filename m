Return-Path: <netdev+bounces-163743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FBA2B756
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC887166DBB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338B1802B;
	Fri,  7 Feb 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIlhB6yd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8F17BBF;
	Fri,  7 Feb 2025 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738888807; cv=none; b=WB0UFBN1Nx+LaBnJVK7pSeZObE2TdgWxUj2ZQH5vTtAWAcfNVHqlGXX6fgXs/7DnXin/siWfj1F0fD/RnlfkcvB+lzDXQoskAVRcQB9hEHOYySWtUtpQ5nRGQH3a3bpDlZ+Bc2EIN4VCAz4ME0IvrdOXYMm5IAV884dVzD4XOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738888807; c=relaxed/simple;
	bh=MPTrX/pGnmLsi85CgZUN8PpdQ4oomrsyAoZFgar388w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bwVfNHM3NkE8L2+W1WF/Vs/KS5Nzo24vBtAmUFYq2KiUpTqtZ0m5hHOh+5e1mpzmyNAJsoOKUEfavCt8zm683b7ktxgAoeIvvwKb01P9IfvqSlhIWT0WemU1Z5KHL3O3CiASn0e8EQ9vq5eLKsA9jo4YDIouqIE7n6BRKtDUWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIlhB6yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF2EC4CEDD;
	Fri,  7 Feb 2025 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738888806;
	bh=MPTrX/pGnmLsi85CgZUN8PpdQ4oomrsyAoZFgar388w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YIlhB6ydzcttB5rfxkNjxseW1u+hRA1ud4jYcm3Asu9xsBOyj0EmWPu+AnU5kqQu6
	 8agWo1H7zU7QnPorvTcMg9JLhjashGUR+q+q3WzYRO5ELotF76uihODAfTc8sqONfq
	 GgTyqvRAAGzze2glkw6x0IN7KO342T985AvrZRmcVJz7lQvRW0ewVbhBllVh5naYyW
	 HyMeIOfi5GcfEcZUe4PQ2YoHMNVxHGTx5kwp/zf/HHZbvv7C6ujRGq4RxaK1pqjHaL
	 8QvUdj8EUASvKoaiQxe6MPk/OzhwAnDJtGcPv4ZCngVvsY5xBRNVDMpDsCsGPopy3R
	 UgzQBoQt8FURQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2D4380AADE;
	Fri,  7 Feb 2025 00:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethtool: tsconfig: Fix netlink type of hwtstamp
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173888883452.1715572.8579419338327846660.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 00:40:34 +0000
References: <20250205110304.375086-1-kory.maincent@bootlin.com>
In-Reply-To: <20250205110304.375086-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, donald.hunter@gmail.com, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Feb 2025 12:03:01 +0100 you wrote:
> Fix the netlink type for hardware timestamp flags, which are represented
> as a bitset of flags. Although only one flag is supported currently, the
> correct netlink bitset type should be used instead of u32 to keep
> consistency with other fields. Address this by adding a new named string
> set description for the hwtstamp flag structure.
> 
> The code has been introduced in the current release so the uAPI change is
> still okay.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethtool: tsconfig: Fix netlink type of hwtstamp flags
    https://git.kernel.org/netdev/net/c/6a774228e890

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



