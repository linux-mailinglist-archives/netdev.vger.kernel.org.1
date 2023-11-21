Return-Path: <netdev+bounces-49506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B327F23A8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A17A281279
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635391429E;
	Tue, 21 Nov 2023 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asDLBUu5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F613AF9
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6986C433C9;
	Tue, 21 Nov 2023 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700532624;
	bh=hvvpIF3DXjb6seguVIW6Q+slGWGZhYzncCbLRYm9HpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=asDLBUu5/UT5Jlwyrbe3mC12X6mPVCkCUbNN1qctkuVhdy9QStG0BisTYdIagE/QO
	 sFmNhcdDxZIYnm2zCCTXhHcLiV7dZ2pWcRUVtL5H4T3IJA7QH5ac2wkTKf8ZSVNLK7
	 llx6uFK2eLNxzsOl9J9HWQbR7kMk2ZxQgvs8jJoW6/Hi3I+OeYWrKdafrrJ1YoUj2z
	 ZGVvVNrej/oxrFpLW3AHX2kk5vgr+bqiZhMIOZkRQ7weXZmGHW3Pwa6g6FKK9pju8v
	 JMtlyMxIpnf6XHkFYe3Cf+h2YT72N4U1PSZPk1UyitpQvcY+S38FKeVAnKc6eLtBEu
	 EVbdXBQf3NttA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B51B5EAA957;
	Tue, 21 Nov 2023 02:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] nfp: add flow-steering support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170053262473.20954.13584700439051328392.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 02:10:24 +0000
References: <20231117071114.10667-1-louis.peens@corigine.com>
In-Reply-To: <20231117071114.10667-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 yinjun.zhang@corigine.com, netdev@vger.kernel.org, oss-drivers@corigine.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Nov 2023 09:11:12 +0200 you wrote:
> This short series adds flow steering support for the nfp driver.
> The first patch adds the part to communicate with ethtool but
> stubs out the HW offload parts. The second patch implements the
> HW communication and offloads flow steering.
> 
> After this series the user can now use 'ethtool -N/-n' to configure
> and display rx classification rules.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] nfp: add ethtool flow steering callbacks
    https://git.kernel.org/netdev/net-next/c/9eb03bb1c035
  - [net-next,2/2] nfp: offload flow steering to the nfp
    https://git.kernel.org/netdev/net-next/c/c38fb3dcd53d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



