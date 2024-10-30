Return-Path: <netdev+bounces-140252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7F9B5A78
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F427B23817
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C981946DF;
	Wed, 30 Oct 2024 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/0BFUZj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B32BA4A;
	Wed, 30 Oct 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730259622; cv=none; b=oga7tXR6d7DEISMnkKmEKbQ7D8139VG3mEdR5hDSnsMlABohAB9XQOZ5ix29R+bHukEpbDsm6L+llPaknr7KRXNtr0o24RZ1ewHz/2NWPAqfMsBA9MgCOvGBxllHd0nZO2H0chVcgP//m6hKKdKzhOjG08EdBBVmd8qBafxVMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730259622; c=relaxed/simple;
	bh=f7V99NMfBB6UTQhFnMkKRLNrX4xGNG5dR0vXU06uQW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MzTkZ3vqf/jx3dLZGQ3W0j0Ban2L6fSH3/EdhyBBhnFKrPobMKM036jjnlnRUqRoZeyc8Ncng5uyR97LX/7xNI1h43vi0wqIAblIdmAxVTrH7vn8fd/gbUcyeGM/06uGBI7EKO0S4fq5KGLW60tHjZa6L/m3m1pdr36kFWDfIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/0BFUZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613D6C4CEC7;
	Wed, 30 Oct 2024 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730259622;
	bh=f7V99NMfBB6UTQhFnMkKRLNrX4xGNG5dR0vXU06uQW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r/0BFUZjIsIHoEda7Jf+DcTua8yYjz7B0pCEeET0UfLK8YhYljLeq00Pm0e67wGui
	 hGl+YdQ/r4b0oCZlUIwFco0zFmPieyoWYNFHbEJHB0Cskz3PdLDpuen5mE6EF2jR34
	 HjhHrZ8Rhfs/mEZbkzpULdxTWY1WDou+As+5Y4F6TASBDGwdSv2Y6GlQ6SvhiWh1xT
	 hsl+aSA02TfDIpQqHdmQgQtycSEqjhr0U0YChi/3G3JDbKq742R553CELZ2MkOOhun
	 ON1PHTYjXewRFTwr8qSa1wCPM8r/I+0R/sQNjWJhLPspfEWfJM41UFPrW7XsmeyCl+
	 rxVdLp9GpJUew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF6380AC00;
	Wed, 30 Oct 2024 03:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] Documentation: networking: Add missing PHY_GET
 command in the message list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173025963001.905291.18392823059783954909.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 03:40:30 +0000
References: <20241028132351.75922-1-kory.maincent@bootlin.com>
In-Reply-To: <20241028132351.75922-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 horms@kernel.org, thomas.petazzoni@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Oct 2024 14:23:51 +0100 you wrote:
> ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message list.
> Add it to the ethool netlink documentation.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v2:
> - Change PHY_NTF documentation
> 
> [...]

Here is the summary with links:
  - [net-next,v2] Documentation: networking: Add missing PHY_GET command in the message list
    https://git.kernel.org/netdev/net-next/c/2b1d193a5a57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



