Return-Path: <netdev+bounces-134622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7B799A84C
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1171E1F2351F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F66195FF1;
	Fri, 11 Oct 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emb51EDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871C823DD;
	Fri, 11 Oct 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661824; cv=none; b=fFn3sLe9jEgIajNC/G0e09DDBqZTQUrnVdh75ev2o+nKnZx/Lct7N3PkDaqsqVNN86MPPz7CV2A0yTWlVcTEXIZ4V5egt13nAmKfnznMEFyqVS1F8ucvX36n1F0+ONHOUMoKtQGQkmDDA6ZP4bXtWlWAhIiVbWrrlJWc2zizXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661824; c=relaxed/simple;
	bh=Ia9uuFkOCKGib3v2CyLqOobLOJIzSj6c02bDmOxNNyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a+SMf7JnzLrRRq5vx1/XOB9iJnvCoWceVpN5VzNopMnhv7ls6PHddRcPV0z2C9JItZtoFjVv0crg421V62yk0cUXW4XLzQeqx7cKmFFG5Qjz8eTIo07VNzndIfuYn/tAIrkdf35xcU4TWGtvc6FKl1uy92qYOJxBcZDFfPpGskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emb51EDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633C9C4CEC3;
	Fri, 11 Oct 2024 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661824;
	bh=Ia9uuFkOCKGib3v2CyLqOobLOJIzSj6c02bDmOxNNyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=emb51EDStU9qqgNw2TwhWJlh5V4vo3qX7ywNHguGWJTmO+lwAZIBjcsyqsq/5C1m1
	 v+WajLfZ5ErO82JcAxqp+r39hl9gCpw7GaEVUzlAX0w+S/uNS7Ub0D+JXYAc4Ql8hk
	 aeOeglYpuN0X/GTMdBX2vx6YNld4hA7LhuZr/BUyU7fMm/3OymNQHR6yaJbQopvEH6
	 o39/DfsBWk5q+CkFJuBF3mIMXzPMfDXXbXQEp3AX5+rNmB8Z6QvJouz2W26MYCjuMl
	 4RDWbdGvt1zl9p5x8iUnuVRSwFcm7K6IxCrXH149iFzh4Ew9JmTQMPZ0LX3W180wqL
	 gmQTWAX/qJ+nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7B380DBC0;
	Fri, 11 Oct 2024 15:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: phy: aquantia: poll status register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172866182902.2863074.6207885719666148725.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 15:50:29 +0000
References: <20241010004935.1774601-1-aryan.srivastava@alliedtelesis.co.nz>
In-Reply-To: <20241010004935.1774601-1-aryan.srivastava@alliedtelesis.co.nz>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 13:49:34 +1300 you wrote:
> The system interface connection status register is not immediately
> correct upon line side link up. This results in the status being read as
> OFF and then transitioning to the correct host side link mode with a
> short delay. This causes the phylink framework passing the OFF status
> down to all MAC config drivers, resulting in the host side link being
> misconfigured, which in turn can lead to link flapping or complete
> packet loss in some cases.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: phy: aquantia: poll status register
    https://git.kernel.org/netdev/net-next/c/7e5b547cac7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



