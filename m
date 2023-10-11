Return-Path: <netdev+bounces-39797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ADC7C480D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29BC1C20C47
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4404693;
	Wed, 11 Oct 2023 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htKzSa2k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A0354F7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 125AFC433C9;
	Wed, 11 Oct 2023 03:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696993224;
	bh=H6zMY1CykdTxHKp9W2Zsgj0WQod7yLkCbShgqc2quBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=htKzSa2kkqPt5I4hkna/91UV0+3qVATM5Nd/+f7hTslNRdssh8jDmO3yYc0v5xmM2
	 oWlRfes7K2GJDasURDy26MZuZBN7b3SkFG5zmFLaq4yZ8L5r7ZLur7ipTvJx50H07+
	 O9khDsxgT21PzxYSLa+ww/4FWqh4aIx+eq9ubd3sNuEUortz6E/AKI5YQgbavIwxih
	 vln8lBEJyqqHjSqlpGMS6mggjQfBvo3oest1UTTmxsF03V7z6I0mddqKLwe7VqwSaA
	 hLZBlMmX84DxW19vNIrt3YsmUI0ViVTeHmKi5sKorWeElPlXVJ+w0ewGj1DsDVioei
	 COT/ySxJjLKHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAC52C595C5;
	Wed, 11 Oct 2023 03:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/1] ethtool: Fix mod state of verbose no_mask bitset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169699322395.28899.12018945004976045331.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 03:00:23 +0000
References: <20231009133645.44503-1-kory.maincent@bootlin.com>
In-Reply-To: <20231009133645.44503-1-kory.maincent@bootlin.com>
To: =?utf-8?q?K=C3=B6ry_Maincent_=3Ckory=2Emaincent=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: mkubecek@suse.cz, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 horms@kernel.org, thomas.petazzoni@bootlin.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Oct 2023 15:36:45 +0200 you wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> A bitset without mask in a _SET request means we want exactly the bits in
> the bitset to be set. This works correctly for compact format but when
> verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
> bits present in the request bitset but does not clear the rest. The commit
> 6699170376ab fixes this issue by clearing the whole target bitmap before we
> start iterating. The solution proposed brought an issue with the behavior
> of the mod variable. As the bitset is always cleared the old val will
> always differ to the new val.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] ethtool: Fix mod state of verbose no_mask bitset
    https://git.kernel.org/netdev/net/c/108a36d07c01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



