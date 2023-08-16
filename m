Return-Path: <netdev+bounces-27879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16677D821
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D7328169E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861C1844;
	Wed, 16 Aug 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A251115
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2DCDC433C9;
	Wed, 16 Aug 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151821;
	bh=CaFpAjNCWcVRURgQgE8O4q7qg700dTldnwEhYYY+hmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I+psWdQvxW6Aatq7VPCb1Rr25p+/7Z4iwUPFaCWu7mXRJRd4l6cf1sJEuGgxnPwV1
	 qMtShX8AVZbqxVLH1HbYdg0oDXrWLm4P9wfxfeqaT7ddHv8nb5+OoAO5hZeRNknNWS
	 RsoN9nX7ABideVeYv2tf96OLi0tqZwWz/31nWttOsZTzQd/4ycFmS3uNcQOxtpFaBm
	 l/CAO26AJBZjpUhyvrcc3Ipq7/PZ145pG/29LZ9PvAQoCS1XYXSXIqQ9j3mwFU2fKc
	 DYaE5EvYg5PfmSx1oJSthxyIQpweI9CNuOrfYOnLPSrrh4yHBm72S9emdlaJpYyOpg
	 4pc4nSFRao8Mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5B34C395C5;
	Wed, 16 Aug 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: reject negative ifindex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215182174.21752.2733766231645812511.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:10:21 +0000
References: <20230814203840.2908710-1-kuba@kernel.org>
In-Reply-To: <20230814203840.2908710-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com,
 pshelar@ovn.org, andrey.zhadchenko@virtuozzo.com, brauner@kernel.org,
 dev@openvswitch.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 13:38:40 -0700 you wrote:
> Recent changes in net-next (commit 759ab1edb56c ("net: store netdevs
> in an xarray")) refactored the handling of pre-assigned ifindexes
> and let syzbot surface a latent problem in ovs. ovs does not validate
> ifindex, making it possible to create netdev ports with negative
> ifindex values. It's easy to repro with YNL:
> 
> $ ./cli.py --spec netlink/specs/ovs_datapath.yaml \
>          --do new \
> 	 --json '{"upcall-pid": 1, "name":"my-dp"}'
> $ ./cli.py --spec netlink/specs/ovs_vport.yaml \
> 	 --do new \
> 	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: reject negative ifindex
    https://git.kernel.org/netdev/net/c/a552bfa16bab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



