Return-Path: <netdev+bounces-127177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CEA9747E1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9451F2559D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CFB4A29;
	Wed, 11 Sep 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeiSas5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947633F6;
	Wed, 11 Sep 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018828; cv=none; b=NWN4aYhqJYc6LY6k4RFweWQXo4ijb5b2KBFrOdgjsEoH6Yq8AlFM5wB1T10pm+ZYc2o9bDUCbs/JHtDb4KKvw92C9hYgqMQz7hgbgUrqlhlEVc62M+cplk0T3Ohlw7J0Ja6x3+9w3x5+2xl6MqRpzuo4FPhJTnTMn3aoRjqnbcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018828; c=relaxed/simple;
	bh=JLo10ivEMXIbzqUpFG2sqArScGbP9KxOm95nFPCh02c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YBHd5EpE784BsQNTFeX/CO+lVtuzEulkPayr1HFXVcPLQJ0e6A1Dox6iL2Fkt/ERFH8zyjY66QMaShseO7nxha2WpjXTw6+3I7Nw/RcIAt86tYnZ7u+/6y5rjXQbxspEPaqPASP9IcYgsjnPdx1C5PvUUTc5IiPNG2y6payFfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeiSas5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5498C4CEC3;
	Wed, 11 Sep 2024 01:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726018828;
	bh=JLo10ivEMXIbzqUpFG2sqArScGbP9KxOm95nFPCh02c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HeiSas5bVWZ/nAFaYpBd+uIUqqay4ZvG6Qd/ry/Bh5YelwBB/W505Yxb4jlF5WOo+
	 QH2B1QQOJGC2eRn/Eux0BUdPelDI8iBk8xfPV4e6hc/jwMxQgBTM/rzMgDhroUXXpc
	 MLe14d6n7PD+QYll2uqfEfMWbOOJaIVqWdUcdUej7k476Wl40x1vfLk43Is0miMt4J
	 djvDPhntMFNFTxk1cnrNbrjj+sX0MysxlqV3zFl+A5S7hpjM0WQxqSeMqO5qKzPkv1
	 NUt8+1BgfsDHDWYmxpOGNWrgWuo+/P58/0W2ikFilSf4+flP+uqLuetgjgfIrNQkjF
	 cevyTpHz+KUXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4C3822FA4;
	Wed, 11 Sep 2024 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] MAINTAINERS: Add ethtool pse-pd to PSE NETWORK
 DRIVER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601882903.456797.9749874809768150815.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 01:40:29 +0000
References: <20240909114336.362174-1-kory.maincent@bootlin.com>
In-Reply-To: <20240909114336.362174-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, netdev@vger.kernel.org,
 o.rempel@pengutronix.de, thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 13:43:36 +0200 you wrote:
> Add net/ethtool/pse-pd.c to PSE NETWORK DRIVER to receive emails concerning
> modifications to the ethtool part.
> 
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v2] MAINTAINERS: Add ethtool pse-pd to PSE NETWORK DRIVER
    https://git.kernel.org/netdev/net/c/330dadacc59c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



