Return-Path: <netdev+bounces-22139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D50766274
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A628259F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A753BE;
	Fri, 28 Jul 2023 03:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278C5239
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96C35C433CD;
	Fri, 28 Jul 2023 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515025;
	bh=wTuzCF2A7a5OUWovA3zFSSC0NTzx9ILvTXye72QKJ70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXbFayOq6bsCC8KGfMJ5xn4gJgmDCeW8uHm2E+I2r+v9erit0JmieD56Tntyw2ciC
	 1idfa5ZVK6e+XS0fMkG3s3bD3WtVYvpnmyt5UIMF/nDItcmCkZz9xoL8tjRxERYUTX
	 zy2O0BjIPBDv+fpOw0mB1Wl+bvGR/Flgf+nboVcy00/3KJNRMvXU+SyJwmC1o8r8p4
	 te8eISOHlGqYu1/rN5rmqZVY6m5rttv3/AcVQPeBqS0JpWdw5DIOZZ/4d/p2F3ir0v
	 E4FYtOfde8kc25mqLL1uU2438jUZczMBP7N4/8y5xx7bgDbH3UVZKKjnuo+b0hKPgK
	 TjjA0Uc4W5tzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83C76C3959F;
	Fri, 28 Jul 2023 03:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv9  0/6] net/tls: fixes for NVMe-over-TLS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051502553.18144.8079815837647562945.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:30:25 +0000
References: <20230726191556.41714-1-hare@suse.de>
In-Reply-To: <20230726191556.41714-1-hare@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 21:15:50 +0200 you wrote:
> Hi all,
> 
> here are some small fixes to get NVMe-over-TLS up and running.
> The first set are just minor modifications to have MSG_EOR handled
> for TLS, but the second set implements the ->read_sock() callback
> for tls_sw.
> The ->read_sock() callbacks return -EIO when encountering any TLS
> Alert message, but as that's the default behaviour anyway I guess
> we can get away with it.
> 
> [...]

Here is the summary with links:
  - [1/6] net/tls: handle MSG_EOR for tls_sw TX flow
    https://git.kernel.org/netdev/net-next/c/e22e358bbeb3
  - [2/6] net/tls: handle MSG_EOR for tls_device TX flow
    https://git.kernel.org/netdev/net-next/c/c004b0e00c94
  - [3/6] selftests/net/tls: add test for MSG_EOR
    https://git.kernel.org/netdev/net-next/c/8790c6a4f54d
  - [4/6] net/tls: Use tcp_read_sock() instead of ops->read_sock()
    https://git.kernel.org/netdev/net-next/c/11863c6d440d
  - [5/6] net/tls: split tls_rx_reader_lock
    https://git.kernel.org/netdev/net-next/c/f9ae3204fb45
  - [6/6] net/tls: implement ->read_sock()
    https://git.kernel.org/netdev/net-next/c/662fbcec32f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



